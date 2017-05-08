#該程式未解開Section, 採用最新樣板產出!
{<section id="aint710.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-10-20 11:11:57), PR版次:0004(2016-10-20 11:04:46)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000057
#+ Filename...: aint710
#+ Description: 隨貨同行單維護作業
#+ Creator....: 04226(2015-02-05 15:25:42)
#+ Modifier...: 02159 -SD/PR- 02159
 
{</section>}
 
{<section id="aint710.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#19  16/04/14  BY 07900   校验代码重复错误讯息的修改
#160812-00017#3   16/08/15  By 06137   在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#161006-00008#11  16/10/20  By sakura  整批修改組織
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
PRIVATE type type_g_infm_m        RECORD
       infmsite LIKE infm_t.infmsite, 
   infmsite_desc LIKE type_t.chr80, 
   infmdocdt LIKE infm_t.infmdocdt, 
   infmdocno LIKE infm_t.infmdocno, 
   infm001 LIKE infm_t.infm001, 
   infm001_desc LIKE type_t.chr80, 
   infm002 LIKE infm_t.infm002, 
   infm002_desc LIKE type_t.chr80, 
   infm003 LIKE infm_t.infm003, 
   infm003_desc LIKE type_t.chr80, 
   infm004 LIKE infm_t.infm004, 
   infm004_desc LIKE type_t.chr80, 
   infm005 LIKE infm_t.infm005, 
   infm005_desc LIKE type_t.chr80, 
   infm006 LIKE infm_t.infm006, 
   infmunit LIKE infm_t.infmunit, 
   infm007 LIKE infm_t.infm007, 
   infmstus LIKE infm_t.infmstus, 
   infmownid LIKE infm_t.infmownid, 
   infmownid_desc LIKE type_t.chr80, 
   infmowndp LIKE infm_t.infmowndp, 
   infmowndp_desc LIKE type_t.chr80, 
   infmcrtid LIKE infm_t.infmcrtid, 
   infmcrtid_desc LIKE type_t.chr80, 
   infmcrtdp LIKE infm_t.infmcrtdp, 
   infmcrtdp_desc LIKE type_t.chr80, 
   infmcrtdt LIKE infm_t.infmcrtdt, 
   infmmodid LIKE infm_t.infmmodid, 
   infmmodid_desc LIKE type_t.chr80, 
   infmmoddt LIKE infm_t.infmmoddt, 
   infmcnfid LIKE infm_t.infmcnfid, 
   infmcnfid_desc LIKE type_t.chr80, 
   infmcnfdt LIKE infm_t.infmcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_info_d        RECORD
       infoseq LIKE info_t.infoseq, 
   infosite LIKE info_t.infosite, 
   infosite_desc LIKE type_t.chr500, 
   infounit LIKE info_t.infounit, 
   info002 LIKE info_t.info002, 
   info001 LIKE info_t.info001, 
   info001_desc LIKE type_t.chr500, 
   info001_desc_desc LIKE type_t.chr500, 
   info003 LIKE info_t.info003, 
   info004 LIKE info_t.info004, 
   info005 LIKE info_t.info005, 
   info005_desc LIKE type_t.chr500, 
   info006 LIKE info_t.info006, 
   info006_desc LIKE type_t.chr500, 
   info007 LIKE info_t.info007, 
   info008 LIKE info_t.info008, 
   info009 LIKE info_t.info009, 
   info009_desc LIKE type_t.chr500, 
   info010 LIKE info_t.info010, 
   info010_desc LIKE type_t.chr500, 
   info011 LIKE info_t.info011, 
   info012 LIKE info_t.info012, 
   info013 LIKE info_t.info013, 
   info014 LIKE info_t.info014, 
   info014_desc LIKE type_t.chr500, 
   info015 LIKE info_t.info015, 
   info015_desc LIKE type_t.chr500, 
   info016 LIKE info_t.info016
       END RECORD
PRIVATE TYPE type_g_info2_d RECORD
       infnseq LIKE infn_t.infnseq, 
   infnsite LIKE infn_t.infnsite, 
   infnsite_desc LIKE type_t.chr500, 
   infnunit LIKE infn_t.infnunit, 
   infn001 LIKE infn_t.infn001, 
   infn002 LIKE infn_t.infn002
       END RECORD
PRIVATE TYPE type_g_info3_d RECORD
       infpseq LIKE infp_t.infpseq, 
   infpsite LIKE infp_t.infpsite, 
   infpsite_desc LIKE type_t.chr500, 
   infpunit LIKE infp_t.infpunit, 
   infp001 LIKE infp_t.infp001, 
   infp002 LIKE infp_t.infp002, 
   infp003 LIKE infp_t.infp003, 
   infp005 LIKE infp_t.infp005, 
   infp004 LIKE infp_t.infp004, 
   infp004_desc LIKE type_t.chr500, 
   infp004_desc_desc LIKE type_t.chr500, 
   infp006 LIKE infp_t.infp006, 
   infp007 LIKE infp_t.infp007, 
   infp008 LIKE infp_t.infp008, 
   infp008_desc LIKE type_t.chr500, 
   infp009 LIKE infp_t.infp009, 
   infp009_desc LIKE type_t.chr500, 
   infp010 LIKE infp_t.infp010, 
   infp011 LIKE infp_t.infp011, 
   infp012 LIKE infp_t.infp012, 
   infp012_desc LIKE type_t.chr500, 
   infp013 LIKE infp_t.infp013, 
   infp013_desc LIKE type_t.chr500, 
   infp014 LIKE infp_t.infp014, 
   infp015 LIKE infp_t.infp015, 
   infp016 LIKE infp_t.infp016, 
   infp017 LIKE infp_t.infp017, 
   infp017_desc LIKE type_t.chr500, 
   infp018 LIKE infp_t.infp018, 
   infp018_desc LIKE type_t.chr500, 
   infp019 LIKE infp_t.infp019
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_infmsite LIKE infm_t.infmsite,
   b_infmsite_desc LIKE type_t.chr80,
      b_infmdocdt LIKE infm_t.infmdocdt,
      b_infmdocno LIKE infm_t.infmdocno,
      b_infm001 LIKE infm_t.infm001,
   b_infm001_desc LIKE type_t.chr80,
      b_infm002 LIKE infm_t.infm002,
   b_infm002_desc LIKE type_t.chr80,
      b_infm003 LIKE infm_t.infm003,
   b_infm003_desc LIKE type_t.chr80,
      b_infm004 LIKE infm_t.infm004,
   b_infm004_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
       
#模組變數(Module Variables)
DEFINE g_infm_m          type_g_infm_m
DEFINE g_infm_m_t        type_g_infm_m
DEFINE g_infm_m_o        type_g_infm_m
DEFINE g_infm_m_mask_o   type_g_infm_m #轉換遮罩前資料
DEFINE g_infm_m_mask_n   type_g_infm_m #轉換遮罩後資料
 
   DEFINE g_infmdocno_t LIKE infm_t.infmdocno
 
 
DEFINE g_info_d          DYNAMIC ARRAY OF type_g_info_d
DEFINE g_info_d_t        type_g_info_d
DEFINE g_info_d_o        type_g_info_d
DEFINE g_info_d_mask_o   DYNAMIC ARRAY OF type_g_info_d #轉換遮罩前資料
DEFINE g_info_d_mask_n   DYNAMIC ARRAY OF type_g_info_d #轉換遮罩後資料
DEFINE g_info2_d          DYNAMIC ARRAY OF type_g_info2_d
DEFINE g_info2_d_t        type_g_info2_d
DEFINE g_info2_d_o        type_g_info2_d
DEFINE g_info2_d_mask_o   DYNAMIC ARRAY OF type_g_info2_d #轉換遮罩前資料
DEFINE g_info2_d_mask_n   DYNAMIC ARRAY OF type_g_info2_d #轉換遮罩後資料
DEFINE g_info3_d          DYNAMIC ARRAY OF type_g_info3_d
DEFINE g_info3_d_t        type_g_info3_d
DEFINE g_info3_d_o        type_g_info3_d
DEFINE g_info3_d_mask_o   DYNAMIC ARRAY OF type_g_info3_d #轉換遮罩前資料
DEFINE g_info3_d_mask_n   DYNAMIC ARRAY OF type_g_info3_d #轉換遮罩後資料
 
 
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
 
{<section id="aint710.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ain","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT infmsite,'',infmdocdt,infmdocno,infm001,'',infm002,'',infm003,'',infm004, 
       '',infm005,'',infm006,infmunit,infm007,infmstus,infmownid,'',infmowndp,'',infmcrtid,'',infmcrtdp, 
       '',infmcrtdt,infmmodid,'',infmmoddt,infmcnfid,'',infmcnfdt", 
                      " FROM infm_t",
                      " WHERE infment= ? AND infmdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint710_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.infmsite,t0.infmdocdt,t0.infmdocno,t0.infm001,t0.infm002,t0.infm003, 
       t0.infm004,t0.infm005,t0.infm006,t0.infmunit,t0.infm007,t0.infmstus,t0.infmownid,t0.infmowndp, 
       t0.infmcrtid,t0.infmcrtdp,t0.infmcrtdt,t0.infmmodid,t0.infmmoddt,t0.infmcnfid,t0.infmcnfdt,t1.ooefl003 , 
       t2.ooag011 ,t3.ooefl003 ,t4.ooefl003 ,t5.ooefl003 ,t6.ooag011 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 , 
       t10.ooefl003 ,t11.ooag011 ,t12.ooag011",
               " FROM infm_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.infmsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.infm001  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.infm002 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.infm003 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.infm004 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.infm005  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.infmownid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.infmowndp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.infmcrtid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.infmcrtdp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.infmmodid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.infmcnfid  ",
 
               " WHERE t0.infment = " ||g_enterprise|| " AND t0.infmdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aint710_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aint710 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aint710_init()   
 
      #進入選單 Menu (="N")
      CALL aint710_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aint710
      
   END IF 
   
   CLOSE aint710_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aint710.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aint710_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
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
      CALL cl_set_combo_scc_part('infmstus','13','N,Y,P,A,D,R,W,C,X')
 
      CALL cl_set_combo_scc('info004','6013') 
   CALL cl_set_combo_scc('infn001','6016') 
   CALL cl_set_combo_scc('infp001','6016') 
   CALL cl_set_combo_scc('infp007','6013') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
   
   #初始化搜尋條件
   CALL aint710_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aint710.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aint710_ui_dialog()
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
   DEFINE l_pmds000  LIKE pmds_t.pmds000   #150416-00001#1 151123 by sakura
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
   
   LET g_forupd_sql = "SELECT infoseq,infosite,infounit,info002,info001,info003,info004,info005,info006, 
       info007,info008,info009,info010,info011,info012,info013,info014,info015,info016 FROM info_t WHERE  
       infoent=? AND infodocno=? AND infoseq=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)
   DECLARE aint710_upd_detail_cl CURSOR FROM g_forupd_sql
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_infm_m.* TO NULL
         CALL g_info_d.clear()
         CALL g_info2_d.clear()
         CALL g_info3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aint710_init()
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
               
               CALL aint710_fetch('') # reload data
               LET l_ac = 1
               CALL aint710_ui_detailshow() #Setting the current row 
         
               CALL aint710_idx_chk()
               #NEXT FIELD infoseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_info_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint710_idx_chk()
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
               CALL aint710_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_info2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint710_idx_chk()
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
               CALL aint710_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page2_sub.detail_qrystr"
                  #150416-00001#1 151123 by sakura(S)
                  BEFORE MENU
                    IF g_detail_idx = 0 THEN
                       HIDE OPTION "prog_infn002"
                       EXIT MENU
                    END IF
                  #150416-00001#1 151123 by sakura(E)
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_infn002
                  LET g_action_choice="prog_infn002"
                  IF cl_auth_chk_act("prog_infn002") THEN
                     
                     #add-point:ON ACTION prog_infn002 name="menu.detail_show.page2_sub.prog_infn002"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               #150416-00001#1 151123 by sakura(S)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog = 'aint510'
               LET la_param.param[1] = g_info2_d[l_ac].infn002
               
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
               #150416-00001#1 151123 by sakura(E)
                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page2.detail_qrystr"
               
               #END add-point
 
 
 
 
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_info3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint710_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL aint710_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page3_sub.detail_qrystr"
                  #150416-00001#1 151123 by sakura(S)
                  BEFORE MENU
                    IF g_detail_idx = 0 THEN
                       HIDE OPTION "prog_infp002"
                       EXIT MENU
                    END IF
                  #150416-00001#1 151123 by sakura(E)
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_infp002
                  LET g_action_choice="prog_infp002"
                  IF cl_auth_chk_act("prog_infp002") THEN
                     
                     #add-point:ON ACTION prog_infp002 name="menu.detail_show.page3_sub.prog_infp002"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               #150416-00001#1 151123 by sakura(S)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog = 'aint510'
               LET la_param.param[1] = g_info3_d[l_ac].infp002
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
               #150416-00001#1 151123 by sakura(E)               
 


                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page3.detail_qrystr"
               
               #END add-point
 
 
 
 
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aint710_browser_fill("")
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
               CALL aint710_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aint710_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aint710_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aint710_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aint710_set_act_visible()   
            CALL aint710_set_act_no_visible()
            IF NOT (g_infm_m.infmdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " infment = " ||g_enterprise|| " AND",
                                  " infmdocno = '", g_infm_m.infmdocno, "' "
 
               #填到對應位置
               CALL aint710_browser_fill("")
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
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "infm_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "info_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "infn_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "infp_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL aint710_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "infm_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "info_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "infn_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "infp_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aint710_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aint710_fetch("F")
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
               CALL aint710_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aint710_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint710_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aint710_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint710_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aint710_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint710_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aint710_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint710_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aint710_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint710_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_info_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_info2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_info3_d)
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
               NEXT FIELD infoseq
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
         ON ACTION upd_detail
            LET g_action_choice="upd_detail"
            IF cl_auth_chk_act("upd_detail") THEN
               
               #add-point:ON ACTION upd_detail name="menu.upd_detail"
               CALL aint710_upd_detail()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aint710_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/ain/aint710_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/ain/aint710_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aint710_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_infm001
            LET g_action_choice="prog_infm001"
            IF cl_auth_chk_act("prog_infm001") THEN
               
               #add-point:ON ACTION prog_infm001 name="menu.prog_infm001"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_infm_m.infm001)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_infm005
            LET g_action_choice="prog_infm005"
            IF cl_auth_chk_act("prog_infm005") THEN
               
               #add-point:ON ACTION prog_infm005 name="menu.prog_infm005"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_infm_m.infm005)
 


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aint710_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aint710_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aint710_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_infm_m.infmdocdt)
 
 
 
         
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
 
{<section id="aint710.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aint710_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'infmsite') RETURNING l_where
   LET l_wc = l_wc," AND ", l_where
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT infmdocno ",
                      " FROM infm_t ",
                      " ",
                      " LEFT JOIN info_t ON infoent = infment AND infmdocno = infodocno ", "  ",
                      #add-point:browser_fill段sql(info_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN infn_t ON infnent = infment AND infmdocno = infndocno", "  ",
                      #add-point:browser_fill段sql(infn_t1) name="browser_fill.cnt.join.infn_t1"
                      
                      #end add-point
 
                      " LEFT JOIN infp_t ON infpent = infment AND infmdocno = infpdocno", "  ",
                      #add-point:browser_fill段sql(infp_t1) name="browser_fill.cnt.join.infp_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE infment = " ||g_enterprise|| " AND infoent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("infm_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT infmdocno ",
                      " FROM infm_t ", 
                      "  ",
                      "  ",
                      " WHERE infment = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("infm_t")
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
      INITIALIZE g_infm_m.* TO NULL
      CALL g_info_d.clear()        
      CALL g_info2_d.clear() 
      CALL g_info3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.infmsite,t0.infmdocdt,t0.infmdocno,t0.infm001,t0.infm002,t0.infm003,t0.infm004 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.infmstus,t0.infmsite,t0.infmdocdt,t0.infmdocno,t0.infm001,t0.infm002, 
          t0.infm003,t0.infm004,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooefl003 ,t5.ooefl003 ",
                  " FROM infm_t t0",
                  "  ",
                  "  LEFT JOIN info_t ON infoent = infment AND infmdocno = infodocno ", "  ", 
                  #add-point:browser_fill段sql(info_t1) name="browser_fill.join.info_t1"
                  
                  #end add-point
                  "  LEFT JOIN infn_t ON infnent = infment AND infmdocno = infndocno", "  ", 
                  #add-point:browser_fill段sql(infn_t1) name="browser_fill.join.infn_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN infp_t ON infpent = infment AND infmdocno = infpdocno", "  ", 
                  #add-point:browser_fill段sql(infp_t1) name="browser_fill.join.infp_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.infmsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.infm001  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.infm002 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.infm003 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.infm004 AND t5.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.infment = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("infm_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.infmstus,t0.infmsite,t0.infmdocdt,t0.infmdocno,t0.infm001,t0.infm002, 
          t0.infm003,t0.infm004,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooefl003 ,t5.ooefl003 ",
                  " FROM infm_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.infmsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.infm001  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.infm002 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.infm003 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.infm004 AND t5.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.infment = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("infm_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY infmdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"infm_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_infmsite,g_browser[g_cnt].b_infmdocdt, 
          g_browser[g_cnt].b_infmdocno,g_browser[g_cnt].b_infm001,g_browser[g_cnt].b_infm002,g_browser[g_cnt].b_infm003, 
          g_browser[g_cnt].b_infm004,g_browser[g_cnt].b_infmsite_desc,g_browser[g_cnt].b_infm001_desc, 
          g_browser[g_cnt].b_infm002_desc,g_browser[g_cnt].b_infm003_desc,g_browser[g_cnt].b_infm004_desc 
 
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
         CALL aint710_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "P"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirm_transfer_in.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "C"
            LET g_browser[g_cnt].b_statepic = "stus/16/closed.png"
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
   
   IF cl_null(g_browser[g_cnt].b_infmdocno) THEN
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
 
{<section id="aint710.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aint710_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_infm_m.infmdocno = g_browser[g_current_idx].b_infmdocno   
 
   EXECUTE aint710_master_referesh USING g_infm_m.infmdocno INTO g_infm_m.infmsite,g_infm_m.infmdocdt, 
       g_infm_m.infmdocno,g_infm_m.infm001,g_infm_m.infm002,g_infm_m.infm003,g_infm_m.infm004,g_infm_m.infm005, 
       g_infm_m.infm006,g_infm_m.infmunit,g_infm_m.infm007,g_infm_m.infmstus,g_infm_m.infmownid,g_infm_m.infmowndp, 
       g_infm_m.infmcrtid,g_infm_m.infmcrtdp,g_infm_m.infmcrtdt,g_infm_m.infmmodid,g_infm_m.infmmoddt, 
       g_infm_m.infmcnfid,g_infm_m.infmcnfdt,g_infm_m.infmsite_desc,g_infm_m.infm001_desc,g_infm_m.infm002_desc, 
       g_infm_m.infm003_desc,g_infm_m.infm004_desc,g_infm_m.infm005_desc,g_infm_m.infmownid_desc,g_infm_m.infmowndp_desc, 
       g_infm_m.infmcrtid_desc,g_infm_m.infmcrtdp_desc,g_infm_m.infmmodid_desc,g_infm_m.infmcnfid_desc 
 
   
   CALL aint710_infm_t_mask()
   CALL aint710_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aint710.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aint710_ui_detailshow()
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
 
{<section id="aint710.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aint710_ui_browser_refresh()
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
      IF g_browser[l_i].b_infmdocno = g_infm_m.infmdocno 
 
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
 
{<section id="aint710.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aint710_construct()
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
   INITIALIZE g_infm_m.* TO NULL
   CALL g_info_d.clear()        
   CALL g_info2_d.clear() 
   CALL g_info3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON infmsite,infmdocdt,infmdocno,infm001,infm002,infm003,infm004,infm005, 
          infm006,infmunit,infm007,infmstus,infmownid,infmowndp,infmcrtid,infmcrtdp,infmcrtdt,infmmodid, 
          infmmoddt,infmcnfid,infmcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<infmcrtdt>>----
         AFTER FIELD infmcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<infmmoddt>>----
         AFTER FIELD infmmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<infmcnfdt>>----
         AFTER FIELD infmcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<infmpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.infmsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infmsite
            #add-point:ON ACTION controlp INFIELD infmsite name="construct.c.infmsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'infmsite',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO infmsite  #顯示到畫面上
            NEXT FIELD infmsite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmsite
            #add-point:BEFORE FIELD infmsite name="construct.b.infmsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infmsite
            
            #add-point:AFTER FIELD infmsite name="construct.a.infmsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmdocdt
            #add-point:BEFORE FIELD infmdocdt name="construct.b.infmdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infmdocdt
            
            #add-point:AFTER FIELD infmdocdt name="construct.a.infmdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.infmdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infmdocdt
            #add-point:ON ACTION controlp INFIELD infmdocdt name="construct.c.infmdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.infmdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infmdocno
            #add-point:ON ACTION controlp INFIELD infmdocno name="construct.c.infmdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_infmdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO infmdocno  #顯示到畫面上
            NEXT FIELD infmdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmdocno
            #add-point:BEFORE FIELD infmdocno name="construct.b.infmdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infmdocno
            
            #add-point:AFTER FIELD infmdocno name="construct.a.infmdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.infm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infm001
            #add-point:ON ACTION controlp INFIELD infm001 name="construct.c.infm001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO infm001  #顯示到畫面上
            NEXT FIELD infm001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infm001
            #add-point:BEFORE FIELD infm001 name="construct.b.infm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infm001
            
            #add-point:AFTER FIELD infm001 name="construct.a.infm001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.infm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infm002
            #add-point:ON ACTION controlp INFIELD infm002 name="construct.c.infm002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO infm002
            NEXT FIELD infm002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infm002
            #add-point:BEFORE FIELD infm002 name="construct.b.infm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infm002
            
            #add-point:AFTER FIELD infm002 name="construct.a.infm002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.infm003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infm003
            #add-point:ON ACTION controlp INFIELD infm003 name="construct.c.infm003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'infm003') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'infm003',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef211 = 'Y'"
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO infm003
            NEXT FIELD infm003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infm003
            #add-point:BEFORE FIELD infm003 name="construct.b.infm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infm003
            
            #add-point:AFTER FIELD infm003 name="construct.a.infm003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.infm004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infm004
            #add-point:ON ACTION controlp INFIELD infm004 name="construct.c.infm004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'infm004') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'infm004',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef211 = 'Y'"
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO infm004
            NEXT FIELD infm004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infm004
            #add-point:BEFORE FIELD infm004 name="construct.b.infm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infm004
            
            #add-point:AFTER FIELD infm004 name="construct.a.infm004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.infm005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infm005
            #add-point:ON ACTION controlp INFIELD infm005 name="construct.c.infm005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO infm005
            NEXT FIELD infm005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infm005
            #add-point:BEFORE FIELD infm005 name="construct.b.infm005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infm005
            
            #add-point:AFTER FIELD infm005 name="construct.a.infm005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infm006
            #add-point:BEFORE FIELD infm006 name="construct.b.infm006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infm006
            
            #add-point:AFTER FIELD infm006 name="construct.a.infm006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.infm006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infm006
            #add-point:ON ACTION controlp INFIELD infm006 name="construct.c.infm006"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmunit
            #add-point:BEFORE FIELD infmunit name="construct.b.infmunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infmunit
            
            #add-point:AFTER FIELD infmunit name="construct.a.infmunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.infmunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infmunit
            #add-point:ON ACTION controlp INFIELD infmunit name="construct.c.infmunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infm007
            #add-point:BEFORE FIELD infm007 name="construct.b.infm007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infm007
            
            #add-point:AFTER FIELD infm007 name="construct.a.infm007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.infm007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infm007
            #add-point:ON ACTION controlp INFIELD infm007 name="construct.c.infm007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmstus
            #add-point:BEFORE FIELD infmstus name="construct.b.infmstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infmstus
            
            #add-point:AFTER FIELD infmstus name="construct.a.infmstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.infmstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infmstus
            #add-point:ON ACTION controlp INFIELD infmstus name="construct.c.infmstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.infmownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infmownid
            #add-point:ON ACTION controlp INFIELD infmownid name="construct.c.infmownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO infmownid  #顯示到畫面上
            NEXT FIELD infmownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmownid
            #add-point:BEFORE FIELD infmownid name="construct.b.infmownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infmownid
            
            #add-point:AFTER FIELD infmownid name="construct.a.infmownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.infmowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infmowndp
            #add-point:ON ACTION controlp INFIELD infmowndp name="construct.c.infmowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO infmowndp  #顯示到畫面上
            NEXT FIELD infmowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmowndp
            #add-point:BEFORE FIELD infmowndp name="construct.b.infmowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infmowndp
            
            #add-point:AFTER FIELD infmowndp name="construct.a.infmowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.infmcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infmcrtid
            #add-point:ON ACTION controlp INFIELD infmcrtid name="construct.c.infmcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO infmcrtid  #顯示到畫面上
            NEXT FIELD infmcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmcrtid
            #add-point:BEFORE FIELD infmcrtid name="construct.b.infmcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infmcrtid
            
            #add-point:AFTER FIELD infmcrtid name="construct.a.infmcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.infmcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infmcrtdp
            #add-point:ON ACTION controlp INFIELD infmcrtdp name="construct.c.infmcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO infmcrtdp  #顯示到畫面上
            NEXT FIELD infmcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmcrtdp
            #add-point:BEFORE FIELD infmcrtdp name="construct.b.infmcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infmcrtdp
            
            #add-point:AFTER FIELD infmcrtdp name="construct.a.infmcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmcrtdt
            #add-point:BEFORE FIELD infmcrtdt name="construct.b.infmcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.infmmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infmmodid
            #add-point:ON ACTION controlp INFIELD infmmodid name="construct.c.infmmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO infmmodid  #顯示到畫面上
            NEXT FIELD infmmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmmodid
            #add-point:BEFORE FIELD infmmodid name="construct.b.infmmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infmmodid
            
            #add-point:AFTER FIELD infmmodid name="construct.a.infmmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmmoddt
            #add-point:BEFORE FIELD infmmoddt name="construct.b.infmmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.infmcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infmcnfid
            #add-point:ON ACTION controlp INFIELD infmcnfid name="construct.c.infmcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO infmcnfid  #顯示到畫面上
            NEXT FIELD infmcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmcnfid
            #add-point:BEFORE FIELD infmcnfid name="construct.b.infmcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infmcnfid
            
            #add-point:AFTER FIELD infmcnfid name="construct.a.infmcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmcnfdt
            #add-point:BEFORE FIELD infmcnfdt name="construct.b.infmcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON infoseq,infosite,infounit,info002,info001,info003,info004,info005,info006, 
          info007,info008,info009,info010,info011,info012,info013,info014,info015,info016
           FROM s_detail1[1].infoseq,s_detail1[1].infosite,s_detail1[1].infounit,s_detail1[1].info002, 
               s_detail1[1].info001,s_detail1[1].info003,s_detail1[1].info004,s_detail1[1].info005,s_detail1[1].info006, 
               s_detail1[1].info007,s_detail1[1].info008,s_detail1[1].info009,s_detail1[1].info010,s_detail1[1].info011, 
               s_detail1[1].info012,s_detail1[1].info013,s_detail1[1].info014,s_detail1[1].info015,s_detail1[1].info016 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infoseq
            #add-point:BEFORE FIELD infoseq name="construct.b.page1.infoseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infoseq
            
            #add-point:AFTER FIELD infoseq name="construct.a.page1.infoseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.infoseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infoseq
            #add-point:ON ACTION controlp INFIELD infoseq name="construct.c.page1.infoseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.infosite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infosite
            #add-point:ON ACTION controlp INFIELD infosite name="construct.c.page1.infosite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'infosite',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO infosite
            NEXT FIELD infosite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infosite
            #add-point:BEFORE FIELD infosite name="construct.b.page1.infosite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infosite
            
            #add-point:AFTER FIELD infosite name="construct.a.page1.infosite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infounit
            #add-point:BEFORE FIELD infounit name="construct.b.page1.infounit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infounit
            
            #add-point:AFTER FIELD infounit name="construct.a.page1.infounit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.infounit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infounit
            #add-point:ON ACTION controlp INFIELD infounit name="construct.c.page1.infounit"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.info002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info002
            #add-point:ON ACTION controlp INFIELD info002 name="construct.c.page1.info002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_3()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO info002  #顯示到畫面上
            NEXT FIELD info002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info002
            #add-point:BEFORE FIELD info002 name="construct.b.page1.info002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info002
            
            #add-point:AFTER FIELD info002 name="construct.a.page1.info002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.info001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info001
            #add-point:ON ACTION controlp INFIELD info001 name="construct.c.page1.info001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO info001  #顯示到畫面上
            NEXT FIELD info001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info001
            #add-point:BEFORE FIELD info001 name="construct.b.page1.info001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info001
            
            #add-point:AFTER FIELD info001 name="construct.a.page1.info001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info003
            #add-point:BEFORE FIELD info003 name="construct.b.page1.info003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info003
            
            #add-point:AFTER FIELD info003 name="construct.a.page1.info003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.info003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info003
            #add-point:ON ACTION controlp INFIELD info003 name="construct.c.page1.info003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info004
            #add-point:BEFORE FIELD info004 name="construct.b.page1.info004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info004
            
            #add-point:AFTER FIELD info004 name="construct.a.page1.info004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.info004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info004
            #add-point:ON ACTION controlp INFIELD info004 name="construct.c.page1.info004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.info005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info005
            #add-point:ON ACTION controlp INFIELD info005 name="construct.c.page1.info005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO info005  #顯示到畫面上
            NEXT FIELD info005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info005
            #add-point:BEFORE FIELD info005 name="construct.b.page1.info005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info005
            
            #add-point:AFTER FIELD info005 name="construct.a.page1.info005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.info006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info006
            #add-point:ON ACTION controlp INFIELD info006 name="construct.c.page1.info006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO info006  #顯示到畫面上
            NEXT FIELD info006                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info006
            #add-point:BEFORE FIELD info006 name="construct.b.page1.info006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info006
            
            #add-point:AFTER FIELD info006 name="construct.a.page1.info006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info007
            #add-point:BEFORE FIELD info007 name="construct.b.page1.info007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info007
            
            #add-point:AFTER FIELD info007 name="construct.a.page1.info007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.info007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info007
            #add-point:ON ACTION controlp INFIELD info007 name="construct.c.page1.info007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info008
            #add-point:BEFORE FIELD info008 name="construct.b.page1.info008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info008
            
            #add-point:AFTER FIELD info008 name="construct.a.page1.info008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.info008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info008
            #add-point:ON ACTION controlp INFIELD info008 name="construct.c.page1.info008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.info009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info009
            #add-point:ON ACTION controlp INFIELD info009 name="construct.c.page1.info009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_23()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO info009  #顯示到畫面上
            NEXT FIELD info009                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info009
            #add-point:BEFORE FIELD info009 name="construct.b.page1.info009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info009
            
            #add-point:AFTER FIELD info009 name="construct.a.page1.info009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.info010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info010
            #add-point:ON ACTION controlp INFIELD info010 name="construct.c.page1.info010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_6()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO info010  #顯示到畫面上
            NEXT FIELD info010                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info010
            #add-point:BEFORE FIELD info010 name="construct.b.page1.info010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info010
            
            #add-point:AFTER FIELD info010 name="construct.a.page1.info010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info011
            #add-point:BEFORE FIELD info011 name="construct.b.page1.info011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info011
            
            #add-point:AFTER FIELD info011 name="construct.a.page1.info011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.info011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info011
            #add-point:ON ACTION controlp INFIELD info011 name="construct.c.page1.info011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info012
            #add-point:BEFORE FIELD info012 name="construct.b.page1.info012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info012
            
            #add-point:AFTER FIELD info012 name="construct.a.page1.info012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.info012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info012
            #add-point:ON ACTION controlp INFIELD info012 name="construct.c.page1.info012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info013
            #add-point:BEFORE FIELD info013 name="construct.b.page1.info013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info013
            
            #add-point:AFTER FIELD info013 name="construct.a.page1.info013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.info013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info013
            #add-point:ON ACTION controlp INFIELD info013 name="construct.c.page1.info013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.info014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info014
            #add-point:ON ACTION controlp INFIELD info014 name="construct.c.page1.info014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_23()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO info014  #顯示到畫面上
            NEXT FIELD info014                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info014
            #add-point:BEFORE FIELD info014 name="construct.b.page1.info014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info014
            
            #add-point:AFTER FIELD info014 name="construct.a.page1.info014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.info015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info015
            #add-point:ON ACTION controlp INFIELD info015 name="construct.c.page1.info015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_6()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO info015  #顯示到畫面上
            NEXT FIELD info015                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info015
            #add-point:BEFORE FIELD info015 name="construct.b.page1.info015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info015
            
            #add-point:AFTER FIELD info015 name="construct.a.page1.info015"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info016
            #add-point:BEFORE FIELD info016 name="construct.b.page1.info016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info016
            
            #add-point:AFTER FIELD info016 name="construct.a.page1.info016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.info016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info016
            #add-point:ON ACTION controlp INFIELD info016 name="construct.c.page1.info016"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON infnseq,infnsite,infnunit,infn001,infn002
           FROM s_detail2[1].infnseq,s_detail2[1].infnsite,s_detail2[1].infnunit,s_detail2[1].infn001, 
               s_detail2[1].infn002
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infnseq
            #add-point:BEFORE FIELD infnseq name="construct.b.page2.infnseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infnseq
            
            #add-point:AFTER FIELD infnseq name="construct.a.page2.infnseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.infnseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infnseq
            #add-point:ON ACTION controlp INFIELD infnseq name="construct.c.page2.infnseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.infnsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infnsite
            #add-point:ON ACTION controlp INFIELD infnsite name="construct.c.page2.infnsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'infnsite',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO infnsite
            NEXT FIELD infnsite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infnsite
            #add-point:BEFORE FIELD infnsite name="construct.b.page2.infnsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infnsite
            
            #add-point:AFTER FIELD infnsite name="construct.a.page2.infnsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infnunit
            #add-point:BEFORE FIELD infnunit name="construct.b.page2.infnunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infnunit
            
            #add-point:AFTER FIELD infnunit name="construct.a.page2.infnunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.infnunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infnunit
            #add-point:ON ACTION controlp INFIELD infnunit name="construct.c.page2.infnunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infn001
            #add-point:BEFORE FIELD infn001 name="construct.b.page2.infn001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infn001
            
            #add-point:AFTER FIELD infn001 name="construct.a.page2.infn001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.infn001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infn001
            #add-point:ON ACTION controlp INFIELD infn001 name="construct.c.page2.infn001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.infn002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infn002
            #add-point:ON ACTION controlp INFIELD infn002 name="construct.c.page2.infn002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_indcdocno_1()                   #呼叫開窗
            DISPLAY g_qryparam.return1 TO infn002  #顯示到畫面上
            NEXT FIELD infn002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infn002
            #add-point:BEFORE FIELD infn002 name="construct.b.page2.infn002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infn002
            
            #add-point:AFTER FIELD infn002 name="construct.a.page2.infn002"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON infpseq,infpsite,infpunit,infp001,infp002,infp003,infp005,infp004,infp006, 
          infp007,infp008,infp009,infp010,infp011,infp012,infp013,infp014,infp015,infp016,infp017,infp018, 
          infp019
           FROM s_detail3[1].infpseq,s_detail3[1].infpsite,s_detail3[1].infpunit,s_detail3[1].infp001, 
               s_detail3[1].infp002,s_detail3[1].infp003,s_detail3[1].infp005,s_detail3[1].infp004,s_detail3[1].infp006, 
               s_detail3[1].infp007,s_detail3[1].infp008,s_detail3[1].infp009,s_detail3[1].infp010,s_detail3[1].infp011, 
               s_detail3[1].infp012,s_detail3[1].infp013,s_detail3[1].infp014,s_detail3[1].infp015,s_detail3[1].infp016, 
               s_detail3[1].infp017,s_detail3[1].infp018,s_detail3[1].infp019
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infpseq
            #add-point:BEFORE FIELD infpseq name="construct.b.page3.infpseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infpseq
            
            #add-point:AFTER FIELD infpseq name="construct.a.page3.infpseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.infpseq
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infpseq
            #add-point:ON ACTION controlp INFIELD infpseq name="construct.c.page3.infpseq"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'infpseq',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO infpseq
            NEXT FIELD infpseq
            #END add-point
 
 
         #Ctrlp:construct.c.page3.infpsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infpsite
            #add-point:ON ACTION controlp INFIELD infpsite name="construct.c.page3.infpsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'infpsite',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO infpsite
            NEXT FIELD infpsite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infpsite
            #add-point:BEFORE FIELD infpsite name="construct.b.page3.infpsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infpsite
            
            #add-point:AFTER FIELD infpsite name="construct.a.page3.infpsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infpunit
            #add-point:BEFORE FIELD infpunit name="construct.b.page3.infpunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infpunit
            
            #add-point:AFTER FIELD infpunit name="construct.a.page3.infpunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.infpunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infpunit
            #add-point:ON ACTION controlp INFIELD infpunit name="construct.c.page3.infpunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp001
            #add-point:BEFORE FIELD infp001 name="construct.b.page3.infp001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp001
            
            #add-point:AFTER FIELD infp001 name="construct.a.page3.infp001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.infp001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp001
            #add-point:ON ACTION controlp INFIELD infp001 name="construct.c.page3.infp001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.infp002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp002
            #add-point:ON ACTION controlp INFIELD infp002 name="construct.c.page3.infp002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_indcdocno_1()                   #呼叫開窗
            DISPLAY g_qryparam.return1 TO infp002  #顯示到畫面上
            NEXT FIELD infp002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp002
            #add-point:BEFORE FIELD infp002 name="construct.b.page3.infp002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp002
            
            #add-point:AFTER FIELD infp002 name="construct.a.page3.infp002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp003
            #add-point:BEFORE FIELD infp003 name="construct.b.page3.infp003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp003
            
            #add-point:AFTER FIELD infp003 name="construct.a.page3.infp003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.infp003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp003
            #add-point:ON ACTION controlp INFIELD infp003 name="construct.c.page3.infp003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.infp005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp005
            #add-point:ON ACTION controlp INFIELD infp005 name="construct.c.page3.infp005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_3()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO infp005  #顯示到畫面上
            NEXT FIELD infp005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp005
            #add-point:BEFORE FIELD infp005 name="construct.b.page3.infp005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp005
            
            #add-point:AFTER FIELD infp005 name="construct.a.page3.infp005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.infp004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp004
            #add-point:ON ACTION controlp INFIELD infp004 name="construct.c.page3.infp004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO infp004  #顯示到畫面上
            NEXT FIELD infp004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp004
            #add-point:BEFORE FIELD infp004 name="construct.b.page3.infp004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp004
            
            #add-point:AFTER FIELD infp004 name="construct.a.page3.infp004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp006
            #add-point:BEFORE FIELD infp006 name="construct.b.page3.infp006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp006
            
            #add-point:AFTER FIELD infp006 name="construct.a.page3.infp006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.infp006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp006
            #add-point:ON ACTION controlp INFIELD infp006 name="construct.c.page3.infp006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp007
            #add-point:BEFORE FIELD infp007 name="construct.b.page3.infp007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp007
            
            #add-point:AFTER FIELD infp007 name="construct.a.page3.infp007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.infp007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp007
            #add-point:ON ACTION controlp INFIELD infp007 name="construct.c.page3.infp007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.infp008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp008
            #add-point:ON ACTION controlp INFIELD infp008 name="construct.c.page3.infp008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO infp008  #顯示到畫面上
            NEXT FIELD infp008                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp008
            #add-point:BEFORE FIELD infp008 name="construct.b.page3.infp008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp008
            
            #add-point:AFTER FIELD infp008 name="construct.a.page3.infp008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.infp009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp009
            #add-point:ON ACTION controlp INFIELD infp009 name="construct.c.page3.infp009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO infp009  #顯示到畫面上
            NEXT FIELD infp009                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp009
            #add-point:BEFORE FIELD infp009 name="construct.b.page3.infp009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp009
            
            #add-point:AFTER FIELD infp009 name="construct.a.page3.infp009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp010
            #add-point:BEFORE FIELD infp010 name="construct.b.page3.infp010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp010
            
            #add-point:AFTER FIELD infp010 name="construct.a.page3.infp010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.infp010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp010
            #add-point:ON ACTION controlp INFIELD infp010 name="construct.c.page3.infp010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp011
            #add-point:BEFORE FIELD infp011 name="construct.b.page3.infp011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp011
            
            #add-point:AFTER FIELD infp011 name="construct.a.page3.infp011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.infp011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp011
            #add-point:ON ACTION controlp INFIELD infp011 name="construct.c.page3.infp011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.infp012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp012
            #add-point:ON ACTION controlp INFIELD infp012 name="construct.c.page3.infp012"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_23()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO infp012  #顯示到畫面上
            NEXT FIELD infp012                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp012
            #add-point:BEFORE FIELD infp012 name="construct.b.page3.infp012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp012
            
            #add-point:AFTER FIELD infp012 name="construct.a.page3.infp012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.infp013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp013
            #add-point:ON ACTION controlp INFIELD infp013 name="construct.c.page3.infp013"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_6()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO infp013  #顯示到畫面上
            NEXT FIELD infp013                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp013
            #add-point:BEFORE FIELD infp013 name="construct.b.page3.infp013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp013
            
            #add-point:AFTER FIELD infp013 name="construct.a.page3.infp013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp014
            #add-point:BEFORE FIELD infp014 name="construct.b.page3.infp014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp014
            
            #add-point:AFTER FIELD infp014 name="construct.a.page3.infp014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.infp014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp014
            #add-point:ON ACTION controlp INFIELD infp014 name="construct.c.page3.infp014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp015
            #add-point:BEFORE FIELD infp015 name="construct.b.page3.infp015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp015
            
            #add-point:AFTER FIELD infp015 name="construct.a.page3.infp015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.infp015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp015
            #add-point:ON ACTION controlp INFIELD infp015 name="construct.c.page3.infp015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp016
            #add-point:BEFORE FIELD infp016 name="construct.b.page3.infp016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp016
            
            #add-point:AFTER FIELD infp016 name="construct.a.page3.infp016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.infp016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp016
            #add-point:ON ACTION controlp INFIELD infp016 name="construct.c.page3.infp016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.infp017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp017
            #add-point:ON ACTION controlp INFIELD infp017 name="construct.c.page3.infp017"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_23()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO infp017  #顯示到畫面上
            NEXT FIELD infp017                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp017
            #add-point:BEFORE FIELD infp017 name="construct.b.page3.infp017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp017
            
            #add-point:AFTER FIELD infp017 name="construct.a.page3.infp017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.infp018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp018
            #add-point:ON ACTION controlp INFIELD infp018 name="construct.c.page3.infp018"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_6()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO infp018  #顯示到畫面上
            NEXT FIELD infp018                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp018
            #add-point:BEFORE FIELD infp018 name="construct.b.page3.infp018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp018
            
            #add-point:AFTER FIELD infp018 name="construct.a.page3.infp018"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp019
            #add-point:BEFORE FIELD infp019 name="construct.b.page3.infp019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp019
            
            #add-point:AFTER FIELD infp019 name="construct.a.page3.infp019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.infp019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp019
            #add-point:ON ACTION controlp INFIELD infp019 name="construct.c.page3.infp019"
            
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
 
            INITIALIZE g_wc2_table3 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "infm_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "info_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "infn_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "infp_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
 
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
 
{<section id="aint710.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aint710_filter()
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
      CONSTRUCT g_wc_filter ON infmsite,infmdocdt,infmdocno,infm001,infm002,infm003,infm004
                          FROM s_browse[1].b_infmsite,s_browse[1].b_infmdocdt,s_browse[1].b_infmdocno, 
                              s_browse[1].b_infm001,s_browse[1].b_infm002,s_browse[1].b_infm003,s_browse[1].b_infm004 
 
 
         BEFORE CONSTRUCT
               DISPLAY aint710_filter_parser('infmsite') TO s_browse[1].b_infmsite
            DISPLAY aint710_filter_parser('infmdocdt') TO s_browse[1].b_infmdocdt
            DISPLAY aint710_filter_parser('infmdocno') TO s_browse[1].b_infmdocno
            DISPLAY aint710_filter_parser('infm001') TO s_browse[1].b_infm001
            DISPLAY aint710_filter_parser('infm002') TO s_browse[1].b_infm002
            DISPLAY aint710_filter_parser('infm003') TO s_browse[1].b_infm003
            DISPLAY aint710_filter_parser('infm004') TO s_browse[1].b_infm004
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         #161006-00008#11 by sakura add(S)
         ON ACTION controlp INFIELD b_infmsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'infmsite',g_site,'c')
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO b_infmsite
            NEXT FIELD b_infmsite
            
         ON ACTION controlp INFIELD b_infm003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'infm003') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'infm003',g_site,'c')
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef211 = 'Y'"
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO b_infm003
            NEXT FIELD b_infm003

         ON ACTION controlp INFIELD b_infm004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'infm004') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'infm004',g_site,'c')
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef211 = 'Y'"
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO b_infm004
            NEXT FIELD b_infm004
         #161006-00008#11 by sakura add(E)
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
 
      CALL aint710_filter_show('infmsite')
   CALL aint710_filter_show('infmdocdt')
   CALL aint710_filter_show('infmdocno')
   CALL aint710_filter_show('infm001')
   CALL aint710_filter_show('infm002')
   CALL aint710_filter_show('infm003')
   CALL aint710_filter_show('infm004')
 
END FUNCTION
 
{</section>}
 
{<section id="aint710.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aint710_filter_parser(ps_field)
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
 
{<section id="aint710.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aint710_filter_show(ps_field)
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
   LET ls_condition = aint710_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aint710.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aint710_query()
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
   CALL g_info_d.clear()
   CALL g_info2_d.clear()
   CALL g_info3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aint710_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aint710_browser_fill("")
      CALL aint710_fetch("")
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
      CALL aint710_filter_show('infmsite')
   CALL aint710_filter_show('infmdocdt')
   CALL aint710_filter_show('infmdocno')
   CALL aint710_filter_show('infm001')
   CALL aint710_filter_show('infm002')
   CALL aint710_filter_show('infm003')
   CALL aint710_filter_show('infm004')
   CALL aint710_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aint710_fetch("F") 
      #顯示單身筆數
      CALL aint710_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aint710.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aint710_fetch(p_flag)
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
   
   LET g_infm_m.infmdocno = g_browser[g_current_idx].b_infmdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aint710_master_referesh USING g_infm_m.infmdocno INTO g_infm_m.infmsite,g_infm_m.infmdocdt, 
       g_infm_m.infmdocno,g_infm_m.infm001,g_infm_m.infm002,g_infm_m.infm003,g_infm_m.infm004,g_infm_m.infm005, 
       g_infm_m.infm006,g_infm_m.infmunit,g_infm_m.infm007,g_infm_m.infmstus,g_infm_m.infmownid,g_infm_m.infmowndp, 
       g_infm_m.infmcrtid,g_infm_m.infmcrtdp,g_infm_m.infmcrtdt,g_infm_m.infmmodid,g_infm_m.infmmoddt, 
       g_infm_m.infmcnfid,g_infm_m.infmcnfdt,g_infm_m.infmsite_desc,g_infm_m.infm001_desc,g_infm_m.infm002_desc, 
       g_infm_m.infm003_desc,g_infm_m.infm004_desc,g_infm_m.infm005_desc,g_infm_m.infmownid_desc,g_infm_m.infmowndp_desc, 
       g_infm_m.infmcrtid_desc,g_infm_m.infmcrtdp_desc,g_infm_m.infmmodid_desc,g_infm_m.infmcnfid_desc 
 
   
   #遮罩相關處理
   LET g_infm_m_mask_o.* =  g_infm_m.*
   CALL aint710_infm_t_mask()
   LET g_infm_m_mask_n.* =  g_infm_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint710_set_act_visible()   
   CALL aint710_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_infm_m_t.* = g_infm_m.*
   LET g_infm_m_o.* = g_infm_m.*
   
   LET g_data_owner = g_infm_m.infmownid      
   LET g_data_dept  = g_infm_m.infmowndp
   
   #重新顯示   
   CALL aint710_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aint710.insert" >}
#+ 資料新增
PRIVATE FUNCTION aint710_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_info_d.clear()   
   CALL g_info2_d.clear()  
   CALL g_info3_d.clear()  
 
 
   INITIALIZE g_infm_m.* TO NULL             #DEFAULT 設定
   
   LET g_infmdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_infm_m.infmownid = g_user
      LET g_infm_m.infmowndp = g_dept
      LET g_infm_m.infmcrtid = g_user
      LET g_infm_m.infmcrtdp = g_dept 
      LET g_infm_m.infmcrtdt = cl_get_current()
      LET g_infm_m.infmmodid = g_user
      LET g_infm_m.infmmoddt = cl_get_current()
      LET g_infm_m.infmstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_infm_m_t.* = g_infm_m.*
      LET g_infm_m_o.* = g_infm_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_infm_m.infmstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "P"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_in.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL aint710_input("a")
      
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
         INITIALIZE g_infm_m.* TO NULL
         INITIALIZE g_info_d TO NULL
         INITIALIZE g_info2_d TO NULL
         INITIALIZE g_info3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aint710_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_info_d.clear()
      #CALL g_info2_d.clear()
      #CALL g_info3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint710_set_act_visible()   
   CALL aint710_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_infmdocno_t = g_infm_m.infmdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " infment = " ||g_enterprise|| " AND",
                      " infmdocno = '", g_infm_m.infmdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint710_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aint710_cl
   
   CALL aint710_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aint710_master_referesh USING g_infm_m.infmdocno INTO g_infm_m.infmsite,g_infm_m.infmdocdt, 
       g_infm_m.infmdocno,g_infm_m.infm001,g_infm_m.infm002,g_infm_m.infm003,g_infm_m.infm004,g_infm_m.infm005, 
       g_infm_m.infm006,g_infm_m.infmunit,g_infm_m.infm007,g_infm_m.infmstus,g_infm_m.infmownid,g_infm_m.infmowndp, 
       g_infm_m.infmcrtid,g_infm_m.infmcrtdp,g_infm_m.infmcrtdt,g_infm_m.infmmodid,g_infm_m.infmmoddt, 
       g_infm_m.infmcnfid,g_infm_m.infmcnfdt,g_infm_m.infmsite_desc,g_infm_m.infm001_desc,g_infm_m.infm002_desc, 
       g_infm_m.infm003_desc,g_infm_m.infm004_desc,g_infm_m.infm005_desc,g_infm_m.infmownid_desc,g_infm_m.infmowndp_desc, 
       g_infm_m.infmcrtid_desc,g_infm_m.infmcrtdp_desc,g_infm_m.infmmodid_desc,g_infm_m.infmcnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_infm_m_mask_o.* =  g_infm_m.*
   CALL aint710_infm_t_mask()
   LET g_infm_m_mask_n.* =  g_infm_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_infm_m.infmsite,g_infm_m.infmsite_desc,g_infm_m.infmdocdt,g_infm_m.infmdocno,g_infm_m.infm001, 
       g_infm_m.infm001_desc,g_infm_m.infm002,g_infm_m.infm002_desc,g_infm_m.infm003,g_infm_m.infm003_desc, 
       g_infm_m.infm004,g_infm_m.infm004_desc,g_infm_m.infm005,g_infm_m.infm005_desc,g_infm_m.infm006, 
       g_infm_m.infmunit,g_infm_m.infm007,g_infm_m.infmstus,g_infm_m.infmownid,g_infm_m.infmownid_desc, 
       g_infm_m.infmowndp,g_infm_m.infmowndp_desc,g_infm_m.infmcrtid,g_infm_m.infmcrtid_desc,g_infm_m.infmcrtdp, 
       g_infm_m.infmcrtdp_desc,g_infm_m.infmcrtdt,g_infm_m.infmmodid,g_infm_m.infmmodid_desc,g_infm_m.infmmoddt, 
       g_infm_m.infmcnfid,g_infm_m.infmcnfid_desc,g_infm_m.infmcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_infm_m.infmownid      
   LET g_data_dept  = g_infm_m.infmowndp
   
   #功能已完成,通報訊息中心
   CALL aint710_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aint710.modify" >}
#+ 資料修改
PRIVATE FUNCTION aint710_modify()
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
   LET g_infm_m_t.* = g_infm_m.*
   LET g_infm_m_o.* = g_infm_m.*
   
   IF g_infm_m.infmdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_infmdocno_t = g_infm_m.infmdocno
 
   CALL s_transaction_begin()
   
   OPEN aint710_cl USING g_enterprise,g_infm_m.infmdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint710_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint710_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint710_master_referesh USING g_infm_m.infmdocno INTO g_infm_m.infmsite,g_infm_m.infmdocdt, 
       g_infm_m.infmdocno,g_infm_m.infm001,g_infm_m.infm002,g_infm_m.infm003,g_infm_m.infm004,g_infm_m.infm005, 
       g_infm_m.infm006,g_infm_m.infmunit,g_infm_m.infm007,g_infm_m.infmstus,g_infm_m.infmownid,g_infm_m.infmowndp, 
       g_infm_m.infmcrtid,g_infm_m.infmcrtdp,g_infm_m.infmcrtdt,g_infm_m.infmmodid,g_infm_m.infmmoddt, 
       g_infm_m.infmcnfid,g_infm_m.infmcnfdt,g_infm_m.infmsite_desc,g_infm_m.infm001_desc,g_infm_m.infm002_desc, 
       g_infm_m.infm003_desc,g_infm_m.infm004_desc,g_infm_m.infm005_desc,g_infm_m.infmownid_desc,g_infm_m.infmowndp_desc, 
       g_infm_m.infmcrtid_desc,g_infm_m.infmcrtdp_desc,g_infm_m.infmmodid_desc,g_infm_m.infmcnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT aint710_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_infm_m_mask_o.* =  g_infm_m.*
   CALL aint710_infm_t_mask()
   LET g_infm_m_mask_n.* =  g_infm_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
 
   
   CALL aint710_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
 
    
   WHILE TRUE
      LET g_infmdocno_t = g_infm_m.infmdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_infm_m.infmmodid = g_user 
LET g_infm_m.infmmoddt = cl_get_current()
LET g_infm_m.infmmodid_desc = cl_get_username(g_infm_m.infmmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aint710_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE infm_t SET (infmmodid,infmmoddt) = (g_infm_m.infmmodid,g_infm_m.infmmoddt)
          WHERE infment = g_enterprise AND infmdocno = g_infmdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_infm_m.* = g_infm_m_t.*
            CALL aint710_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_infm_m.infmdocno != g_infm_m_t.infmdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE info_t SET infodocno = g_infm_m.infmdocno
 
          WHERE infoent = g_enterprise AND infodocno = g_infm_m_t.infmdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "info_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "info_t:",SQLERRMESSAGE 
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
         
         UPDATE infn_t
            SET infndocno = g_infm_m.infmdocno
 
          WHERE infnent = g_enterprise AND
                infndocno = g_infmdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "infn_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "infn_t:",SQLERRMESSAGE 
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
         
         UPDATE infp_t
            SET infpdocno = g_infm_m.infmdocno
 
          WHERE infpent = g_enterprise AND
                infpdocno = g_infmdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "infp_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "infp_t:",SQLERRMESSAGE 
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
   CALL aint710_set_act_visible()   
   CALL aint710_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " infment = " ||g_enterprise|| " AND",
                      " infmdocno = '", g_infm_m.infmdocno, "' "
 
   #填到對應位置
   CALL aint710_browser_fill("")
 
   CLOSE aint710_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint710_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aint710.input" >}
#+ 資料輸入
PRIVATE FUNCTION aint710_input(p_cmd)
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
   DISPLAY BY NAME g_infm_m.infmsite,g_infm_m.infmsite_desc,g_infm_m.infmdocdt,g_infm_m.infmdocno,g_infm_m.infm001, 
       g_infm_m.infm001_desc,g_infm_m.infm002,g_infm_m.infm002_desc,g_infm_m.infm003,g_infm_m.infm003_desc, 
       g_infm_m.infm004,g_infm_m.infm004_desc,g_infm_m.infm005,g_infm_m.infm005_desc,g_infm_m.infm006, 
       g_infm_m.infmunit,g_infm_m.infm007,g_infm_m.infmstus,g_infm_m.infmownid,g_infm_m.infmownid_desc, 
       g_infm_m.infmowndp,g_infm_m.infmowndp_desc,g_infm_m.infmcrtid,g_infm_m.infmcrtid_desc,g_infm_m.infmcrtdp, 
       g_infm_m.infmcrtdp_desc,g_infm_m.infmcrtdt,g_infm_m.infmmodid,g_infm_m.infmmodid_desc,g_infm_m.infmmoddt, 
       g_infm_m.infmcnfid,g_infm_m.infmcnfid_desc,g_infm_m.infmcnfdt
   
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
   LET g_forupd_sql = "SELECT infoseq,infosite,infounit,info002,info001,info003,info004,info005,info006, 
       info007,info008,info009,info010,info011,info012,info013,info014,info015,info016 FROM info_t WHERE  
       infoent=? AND infodocno=? AND infoseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint710_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT infnseq,infnsite,infnunit,infn001,infn002 FROM infn_t WHERE infnent=?  
       AND infndocno=? AND infnseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint710_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT infpseq,infpsite,infpunit,infp001,infp002,infp003,infp005,infp004,infp006, 
       infp007,infp008,infp009,infp010,infp011,infp012,infp013,infp014,infp015,infp016,infp017,infp018, 
       infp019 FROM infp_t WHERE infpent=? AND infpdocno=? AND infpseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint710_bcl3 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aint710_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aint710_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_infm_m.infmsite,g_infm_m.infmdocdt,g_infm_m.infmdocno,g_infm_m.infm001,g_infm_m.infm002, 
       g_infm_m.infm003,g_infm_m.infm004,g_infm_m.infm005,g_infm_m.infm006,g_infm_m.infmunit,g_infm_m.infm007, 
       g_infm_m.infmstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aint710.input.head" >}
      #單頭段
      INPUT BY NAME g_infm_m.infmsite,g_infm_m.infmdocdt,g_infm_m.infmdocno,g_infm_m.infm001,g_infm_m.infm002, 
          g_infm_m.infm003,g_infm_m.infm004,g_infm_m.infm005,g_infm_m.infm006,g_infm_m.infmunit,g_infm_m.infm007, 
          g_infm_m.infmstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aint710_cl USING g_enterprise,g_infm_m.infmdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint710_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint710_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aint710_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL aint710_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infmsite
            
            #add-point:AFTER FIELD infmsite name="input.a.infmsite"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmsite
            #add-point:BEFORE FIELD infmsite name="input.b.infmsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infmsite
            #add-point:ON CHANGE infmsite name="input.g.infmsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmdocdt
            #add-point:BEFORE FIELD infmdocdt name="input.b.infmdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infmdocdt
            
            #add-point:AFTER FIELD infmdocdt name="input.a.infmdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infmdocdt
            #add-point:ON CHANGE infmdocdt name="input.g.infmdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmdocno
            #add-point:BEFORE FIELD infmdocno name="input.b.infmdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infmdocno
            
            #add-point:AFTER FIELD infmdocno name="input.a.infmdocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_infm_m.infmdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_infm_m.infmdocno != g_infmdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM infm_t WHERE "||"infment = '" ||g_enterprise|| "' AND "||"infmdocno = '"||g_infm_m.infmdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infmdocno
            #add-point:ON CHANGE infmdocno name="input.g.infmdocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infm001
            
            #add-point:AFTER FIELD infm001 name="input.a.infm001"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infm001
            #add-point:BEFORE FIELD infm001 name="input.b.infm001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infm001
            #add-point:ON CHANGE infm001 name="input.g.infm001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infm002
            
            #add-point:AFTER FIELD infm002 name="input.a.infm002"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infm002
            #add-point:BEFORE FIELD infm002 name="input.b.infm002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infm002
            #add-point:ON CHANGE infm002 name="input.g.infm002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infm003
            
            #add-point:AFTER FIELD infm003 name="input.a.infm003"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infm003
            #add-point:BEFORE FIELD infm003 name="input.b.infm003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infm003
            #add-point:ON CHANGE infm003 name="input.g.infm003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infm004
            
            #add-point:AFTER FIELD infm004 name="input.a.infm004"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infm004
            #add-point:BEFORE FIELD infm004 name="input.b.infm004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infm004
            #add-point:ON CHANGE infm004 name="input.g.infm004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infm005
            
            #add-point:AFTER FIELD infm005 name="input.a.infm005"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_infm_m.infm005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_infm_m.infm005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_infm_m.infm005_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infm005
            #add-point:BEFORE FIELD infm005 name="input.b.infm005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infm005
            #add-point:ON CHANGE infm005 name="input.g.infm005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infm006
            #add-point:BEFORE FIELD infm006 name="input.b.infm006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infm006
            
            #add-point:AFTER FIELD infm006 name="input.a.infm006"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infm006
            #add-point:ON CHANGE infm006 name="input.g.infm006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmunit
            #add-point:BEFORE FIELD infmunit name="input.b.infmunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infmunit
            
            #add-point:AFTER FIELD infmunit name="input.a.infmunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infmunit
            #add-point:ON CHANGE infmunit name="input.g.infmunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infm007
            #add-point:BEFORE FIELD infm007 name="input.b.infm007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infm007
            
            #add-point:AFTER FIELD infm007 name="input.a.infm007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infm007
            #add-point:ON CHANGE infm007 name="input.g.infm007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infmstus
            #add-point:BEFORE FIELD infmstus name="input.b.infmstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infmstus
            
            #add-point:AFTER FIELD infmstus name="input.a.infmstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infmstus
            #add-point:ON CHANGE infmstus name="input.g.infmstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.infmsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infmsite
            #add-point:ON ACTION controlp INFIELD infmsite name="input.c.infmsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.infmdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infmdocdt
            #add-point:ON ACTION controlp INFIELD infmdocdt name="input.c.infmdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.infmdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infmdocno
            #add-point:ON ACTION controlp INFIELD infmdocno name="input.c.infmdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.infm001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infm001
            #add-point:ON ACTION controlp INFIELD infm001 name="input.c.infm001"
            
            #END add-point
 
 
         #Ctrlp:input.c.infm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infm002
            #add-point:ON ACTION controlp INFIELD infm002 name="input.c.infm002"
            
            #END add-point
 
 
         #Ctrlp:input.c.infm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infm003
            #add-point:ON ACTION controlp INFIELD infm003 name="input.c.infm003"
            
            #END add-point
 
 
         #Ctrlp:input.c.infm004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infm004
            #add-point:ON ACTION controlp INFIELD infm004 name="input.c.infm004"
            
            #END add-point
 
 
         #Ctrlp:input.c.infm005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infm005
            #add-point:ON ACTION controlp INFIELD infm005 name="input.c.infm005"
            
            #END add-point
 
 
         #Ctrlp:input.c.infm006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infm006
            #add-point:ON ACTION controlp INFIELD infm006 name="input.c.infm006"
            
            #END add-point
 
 
         #Ctrlp:input.c.infmunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infmunit
            #add-point:ON ACTION controlp INFIELD infmunit name="input.c.infmunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.infm007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infm007
            #add-point:ON ACTION controlp INFIELD infm007 name="input.c.infm007"
            
            #END add-point
 
 
         #Ctrlp:input.c.infmstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infmstus
            #add-point:ON ACTION controlp INFIELD infmstus name="input.c.infmstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_infm_m.infmdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO infm_t (infment,infmsite,infmdocdt,infmdocno,infm001,infm002,infm003,infm004, 
                   infm005,infm006,infmunit,infm007,infmstus,infmownid,infmowndp,infmcrtid,infmcrtdp, 
                   infmcrtdt,infmmodid,infmmoddt,infmcnfid,infmcnfdt)
               VALUES (g_enterprise,g_infm_m.infmsite,g_infm_m.infmdocdt,g_infm_m.infmdocno,g_infm_m.infm001, 
                   g_infm_m.infm002,g_infm_m.infm003,g_infm_m.infm004,g_infm_m.infm005,g_infm_m.infm006, 
                   g_infm_m.infmunit,g_infm_m.infm007,g_infm_m.infmstus,g_infm_m.infmownid,g_infm_m.infmowndp, 
                   g_infm_m.infmcrtid,g_infm_m.infmcrtdp,g_infm_m.infmcrtdt,g_infm_m.infmmodid,g_infm_m.infmmoddt, 
                   g_infm_m.infmcnfid,g_infm_m.infmcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_infm_m:",SQLERRMESSAGE 
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
                  CALL aint710_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aint710_b_fill()
                  CALL aint710_b_fill2('0')
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
               CALL aint710_infm_t_mask_restore('restore_mask_o')
               
               UPDATE infm_t SET (infmsite,infmdocdt,infmdocno,infm001,infm002,infm003,infm004,infm005, 
                   infm006,infmunit,infm007,infmstus,infmownid,infmowndp,infmcrtid,infmcrtdp,infmcrtdt, 
                   infmmodid,infmmoddt,infmcnfid,infmcnfdt) = (g_infm_m.infmsite,g_infm_m.infmdocdt, 
                   g_infm_m.infmdocno,g_infm_m.infm001,g_infm_m.infm002,g_infm_m.infm003,g_infm_m.infm004, 
                   g_infm_m.infm005,g_infm_m.infm006,g_infm_m.infmunit,g_infm_m.infm007,g_infm_m.infmstus, 
                   g_infm_m.infmownid,g_infm_m.infmowndp,g_infm_m.infmcrtid,g_infm_m.infmcrtdp,g_infm_m.infmcrtdt, 
                   g_infm_m.infmmodid,g_infm_m.infmmoddt,g_infm_m.infmcnfid,g_infm_m.infmcnfdt)
                WHERE infment = g_enterprise AND infmdocno = g_infmdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "infm_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aint710_infm_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_infm_m_t)
               LET g_log2 = util.JSON.stringify(g_infm_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_infmdocno_t = g_infm_m.infmdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aint710.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_info_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_info_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aint710_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_info_d.getLength()
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
            OPEN aint710_cl USING g_enterprise,g_infm_m.infmdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint710_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint710_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_info_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_info_d[l_ac].infoseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_info_d_t.* = g_info_d[l_ac].*  #BACKUP
               LET g_info_d_o.* = g_info_d[l_ac].*  #BACKUP
               CALL aint710_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aint710_set_no_entry_b(l_cmd)
               IF NOT aint710_lock_b("info_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aint710_bcl INTO g_info_d[l_ac].infoseq,g_info_d[l_ac].infosite,g_info_d[l_ac].infounit, 
                      g_info_d[l_ac].info002,g_info_d[l_ac].info001,g_info_d[l_ac].info003,g_info_d[l_ac].info004, 
                      g_info_d[l_ac].info005,g_info_d[l_ac].info006,g_info_d[l_ac].info007,g_info_d[l_ac].info008, 
                      g_info_d[l_ac].info009,g_info_d[l_ac].info010,g_info_d[l_ac].info011,g_info_d[l_ac].info012, 
                      g_info_d[l_ac].info013,g_info_d[l_ac].info014,g_info_d[l_ac].info015,g_info_d[l_ac].info016 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_info_d_t.infoseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_info_d_mask_o[l_ac].* =  g_info_d[l_ac].*
                  CALL aint710_info_t_mask()
                  LET g_info_d_mask_n[l_ac].* =  g_info_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aint710_show()
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
            INITIALIZE g_info_d[l_ac].* TO NULL 
            INITIALIZE g_info_d_t.* TO NULL 
            INITIALIZE g_info_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_info_d[l_ac].infoseq = "0"
      LET g_info_d[l_ac].info007 = "0"
      LET g_info_d[l_ac].info008 = "0"
      LET g_info_d[l_ac].info012 = "0"
      LET g_info_d[l_ac].info013 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_info_d_t.* = g_info_d[l_ac].*     #新輸入資料
            LET g_info_d_o.* = g_info_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aint710_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aint710_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_info_d[li_reproduce_target].* = g_info_d[li_reproduce].*
 
               LET g_info_d[li_reproduce_target].infoseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM info_t 
             WHERE infoent = g_enterprise AND infodocno = g_infm_m.infmdocno
 
               AND infoseq = g_info_d[l_ac].infoseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_infm_m.infmdocno
               LET gs_keys[2] = g_info_d[g_detail_idx].infoseq
               CALL aint710_insert_b('info_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_info_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "info_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aint710_b_fill()
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
               LET gs_keys[01] = g_infm_m.infmdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_info_d_t.infoseq
 
            
               #刪除同層單身
               IF NOT aint710_delete_b('info_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint710_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aint710_key_delete_b(gs_keys,'info_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint710_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aint710_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_info_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_info_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_info_d[l_ac].info012,"0","1","","","azz-00079",1) THEN
               NEXT FIELD info012
            END IF 
 
 
 
            #add-point:AFTER FIELD info012 name="input.a.page1.info012"
            IF NOT cl_null(g_info_d[l_ac].info012) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info012
            #add-point:BEFORE FIELD info012 name="input.b.page1.info012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE info012
            #add-point:ON CHANGE info012 name="input.g.page1.info012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_info_d[l_ac].info013,"0","1","","","azz-00079",1) THEN
               NEXT FIELD info013
            END IF 
 
 
 
            #add-point:AFTER FIELD info013 name="input.a.page1.info013"
            IF NOT cl_null(g_info_d[l_ac].info013) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info013
            #add-point:BEFORE FIELD info013 name="input.b.page1.info013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE info013
            #add-point:ON CHANGE info013 name="input.g.page1.info013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info014
            
            #add-point:AFTER FIELD info014 name="input.a.page1.info014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info014
            #add-point:BEFORE FIELD info014 name="input.b.page1.info014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE info014
            #add-point:ON CHANGE info014 name="input.g.page1.info014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info015
            
            #add-point:AFTER FIELD info015 name="input.a.page1.info015"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info015
            #add-point:BEFORE FIELD info015 name="input.b.page1.info015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE info015
            #add-point:ON CHANGE info015 name="input.g.page1.info015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD info016
            #add-point:BEFORE FIELD info016 name="input.b.page1.info016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD info016
            
            #add-point:AFTER FIELD info016 name="input.a.page1.info016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE info016
            #add-point:ON CHANGE info016 name="input.g.page1.info016"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.info012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info012
            #add-point:ON ACTION controlp INFIELD info012 name="input.c.page1.info012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.info013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info013
            #add-point:ON ACTION controlp INFIELD info013 name="input.c.page1.info013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.info014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info014
            #add-point:ON ACTION controlp INFIELD info014 name="input.c.page1.info014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.info015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info015
            #add-point:ON ACTION controlp INFIELD info015 name="input.c.page1.info015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.info016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD info016
            #add-point:ON ACTION controlp INFIELD info016 name="input.c.page1.info016"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_info_d[l_ac].* = g_info_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aint710_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_info_d[l_ac].infoseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_info_d[l_ac].* = g_info_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aint710_info_t_mask_restore('restore_mask_o')
      
               UPDATE info_t SET (infodocno,infoseq,infosite,infounit,info002,info001,info003,info004, 
                   info005,info006,info007,info008,info009,info010,info011,info012,info013,info014,info015, 
                   info016) = (g_infm_m.infmdocno,g_info_d[l_ac].infoseq,g_info_d[l_ac].infosite,g_info_d[l_ac].infounit, 
                   g_info_d[l_ac].info002,g_info_d[l_ac].info001,g_info_d[l_ac].info003,g_info_d[l_ac].info004, 
                   g_info_d[l_ac].info005,g_info_d[l_ac].info006,g_info_d[l_ac].info007,g_info_d[l_ac].info008, 
                   g_info_d[l_ac].info009,g_info_d[l_ac].info010,g_info_d[l_ac].info011,g_info_d[l_ac].info012, 
                   g_info_d[l_ac].info013,g_info_d[l_ac].info014,g_info_d[l_ac].info015,g_info_d[l_ac].info016) 
 
                WHERE infoent = g_enterprise AND infodocno = g_infm_m.infmdocno 
 
                  AND infoseq = g_info_d_t.infoseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_info_d[l_ac].* = g_info_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "info_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_info_d[l_ac].* = g_info_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "info_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_infm_m.infmdocno
               LET gs_keys_bak[1] = g_infmdocno_t
               LET gs_keys[2] = g_info_d[g_detail_idx].infoseq
               LET gs_keys_bak[2] = g_info_d_t.infoseq
               CALL aint710_update_b('info_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aint710_info_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_info_d[g_detail_idx].infoseq = g_info_d_t.infoseq 
 
                  ) THEN
                  LET gs_keys[01] = g_infm_m.infmdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_info_d_t.infoseq
 
                  CALL aint710_key_update_b(gs_keys,'info_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_infm_m),util.JSON.stringify(g_info_d_t)
               LET g_log2 = util.JSON.stringify(g_infm_m),util.JSON.stringify(g_info_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aint710_unlock_b("info_t","'1'")
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
               LET g_info_d[li_reproduce_target].* = g_info_d[li_reproduce].*
 
               LET g_info_d[li_reproduce_target].infoseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_info_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_info_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_info3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_info3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aint710_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_info3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_info3_d[l_ac].* TO NULL 
            INITIALIZE g_info3_d_t.* TO NULL 
            INITIALIZE g_info3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
                  LET g_info3_d[l_ac].infpseq = "0"
      LET g_info3_d[l_ac].infp003 = "0"
      LET g_info3_d[l_ac].infp010 = "0"
      LET g_info3_d[l_ac].infp011 = "0"
      LET g_info3_d[l_ac].infp015 = "0"
      LET g_info3_d[l_ac].infp016 = "0"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_info3_d_t.* = g_info3_d[l_ac].*     #新輸入資料
            LET g_info3_d_o.* = g_info3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aint710_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL aint710_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_info3_d[li_reproduce_target].* = g_info3_d[li_reproduce].*
 
               LET g_info3_d[li_reproduce_target].infpseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[3] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aint710_cl USING g_enterprise,g_infm_m.infmdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint710_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint710_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_info3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_info3_d[l_ac].infpseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_info3_d_t.* = g_info3_d[l_ac].*  #BACKUP
               LET g_info3_d_o.* = g_info3_d[l_ac].*  #BACKUP
               CALL aint710_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL aint710_set_no_entry_b(l_cmd)
               IF NOT aint710_lock_b("infp_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aint710_bcl3 INTO g_info3_d[l_ac].infpseq,g_info3_d[l_ac].infpsite,g_info3_d[l_ac].infpunit, 
                      g_info3_d[l_ac].infp001,g_info3_d[l_ac].infp002,g_info3_d[l_ac].infp003,g_info3_d[l_ac].infp005, 
                      g_info3_d[l_ac].infp004,g_info3_d[l_ac].infp006,g_info3_d[l_ac].infp007,g_info3_d[l_ac].infp008, 
                      g_info3_d[l_ac].infp009,g_info3_d[l_ac].infp010,g_info3_d[l_ac].infp011,g_info3_d[l_ac].infp012, 
                      g_info3_d[l_ac].infp013,g_info3_d[l_ac].infp014,g_info3_d[l_ac].infp015,g_info3_d[l_ac].infp016, 
                      g_info3_d[l_ac].infp017,g_info3_d[l_ac].infp018,g_info3_d[l_ac].infp019
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_info3_d_mask_o[l_ac].* =  g_info3_d[l_ac].*
                  CALL aint710_infp_t_mask()
                  LET g_info3_d_mask_n[l_ac].* =  g_info3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aint710_show()
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
               LET gs_keys[01] = g_infm_m.infmdocno
               LET gs_keys[gs_keys.getLength()+1] = g_info3_d_t.infpseq
            
               #刪除同層單身
               IF NOT aint710_delete_b('infp_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint710_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aint710_key_delete_b(gs_keys,'infp_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint710_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aint710_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_info_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_info3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM infp_t 
             WHERE infpent = g_enterprise AND infpdocno = g_infm_m.infmdocno
               AND infpseq = g_info3_d[l_ac].infpseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_infm_m.infmdocno
               LET gs_keys[2] = g_info3_d[g_detail_idx].infpseq
               CALL aint710_insert_b('infp_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_info_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "infp_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aint710_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_info3_d[l_ac].* = g_info3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aint710_bcl3
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
               LET g_info3_d[l_ac].* = g_info3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL aint710_infp_t_mask_restore('restore_mask_o')
                              
               UPDATE infp_t SET (infpdocno,infpseq,infpsite,infpunit,infp001,infp002,infp003,infp005, 
                   infp004,infp006,infp007,infp008,infp009,infp010,infp011,infp012,infp013,infp014,infp015, 
                   infp016,infp017,infp018,infp019) = (g_infm_m.infmdocno,g_info3_d[l_ac].infpseq,g_info3_d[l_ac].infpsite, 
                   g_info3_d[l_ac].infpunit,g_info3_d[l_ac].infp001,g_info3_d[l_ac].infp002,g_info3_d[l_ac].infp003, 
                   g_info3_d[l_ac].infp005,g_info3_d[l_ac].infp004,g_info3_d[l_ac].infp006,g_info3_d[l_ac].infp007, 
                   g_info3_d[l_ac].infp008,g_info3_d[l_ac].infp009,g_info3_d[l_ac].infp010,g_info3_d[l_ac].infp011, 
                   g_info3_d[l_ac].infp012,g_info3_d[l_ac].infp013,g_info3_d[l_ac].infp014,g_info3_d[l_ac].infp015, 
                   g_info3_d[l_ac].infp016,g_info3_d[l_ac].infp017,g_info3_d[l_ac].infp018,g_info3_d[l_ac].infp019)  
                   #自訂欄位頁簽
                WHERE infpent = g_enterprise AND infpdocno = g_infm_m.infmdocno
                  AND infpseq = g_info3_d_t.infpseq #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_info3_d[l_ac].* = g_info3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "infp_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_info3_d[l_ac].* = g_info3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "infp_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_infm_m.infmdocno
               LET gs_keys_bak[1] = g_infmdocno_t
               LET gs_keys[2] = g_info3_d[g_detail_idx].infpseq
               LET gs_keys_bak[2] = g_info3_d_t.infpseq
               CALL aint710_update_b('infp_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aint710_infp_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_info3_d[g_detail_idx].infpseq = g_info3_d_t.infpseq 
                  ) THEN
                  LET gs_keys[01] = g_infm_m.infmdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_info3_d_t.infpseq
                  CALL aint710_key_update_b(gs_keys,'infp_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_infm_m),util.JSON.stringify(g_info3_d_t)
               LET g_log2 = util.JSON.stringify(g_infm_m),util.JSON.stringify(g_info3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp002
            #add-point:BEFORE FIELD infp002 name="input.b.page3.infp002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp002
            
            #add-point:AFTER FIELD infp002 name="input.a.page3.infp002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infp002
            #add-point:ON CHANGE infp002 name="input.g.page3.infp002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp014
            #add-point:BEFORE FIELD infp014 name="input.b.page3.infp014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp014
            
            #add-point:AFTER FIELD infp014 name="input.a.page3.infp014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infp014
            #add-point:ON CHANGE infp014 name="input.g.page3.infp014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp017
            
            #add-point:AFTER FIELD infp017 name="input.a.page3.infp017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp017
            #add-point:BEFORE FIELD infp017 name="input.b.page3.infp017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infp017
            #add-point:ON CHANGE infp017 name="input.g.page3.infp017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp018
            
            #add-point:AFTER FIELD infp018 name="input.a.page3.infp018"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp018
            #add-point:BEFORE FIELD infp018 name="input.b.page3.infp018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infp018
            #add-point:ON CHANGE infp018 name="input.g.page3.infp018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD infp019
            #add-point:BEFORE FIELD infp019 name="input.b.page3.infp019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD infp019
            
            #add-point:AFTER FIELD infp019 name="input.a.page3.infp019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE infp019
            #add-point:ON CHANGE infp019 name="input.g.page3.infp019"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.infp002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp002
            #add-point:ON ACTION controlp INFIELD infp002 name="input.c.page3.infp002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.infp014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp014
            #add-point:ON ACTION controlp INFIELD infp014 name="input.c.page3.infp014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.infp017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp017
            #add-point:ON ACTION controlp INFIELD infp017 name="input.c.page3.infp017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.infp018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp018
            #add-point:ON ACTION controlp INFIELD infp018 name="input.c.page3.infp018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.infp019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD infp019
            #add-point:ON ACTION controlp INFIELD infp019 name="input.c.page3.infp019"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_info3_d[l_ac].* = g_info3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aint710_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aint710_unlock_b("infp_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_info3_d[li_reproduce_target].* = g_info3_d[li_reproduce].*
 
               LET g_info3_d[li_reproduce_target].infpseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_info3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_info3_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
      DISPLAY ARRAY g_info2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL aint710_idx_chk()
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
            CALL aint710_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="aint710.input.other" >}
      
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
            NEXT FIELD infmdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD infoseq
               WHEN "s_detail2"
                  NEXT FIELD infnseq
               WHEN "s_detail3"
                  NEXT FIELD infpseq
 
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
 
{<section id="aint710.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aint710_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aint710_b_fill() #單身填充
      CALL aint710_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aint710_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_infm_m_mask_o.* =  g_infm_m.*
   CALL aint710_infm_t_mask()
   LET g_infm_m_mask_n.* =  g_infm_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_infm_m.infmsite,g_infm_m.infmsite_desc,g_infm_m.infmdocdt,g_infm_m.infmdocno,g_infm_m.infm001, 
       g_infm_m.infm001_desc,g_infm_m.infm002,g_infm_m.infm002_desc,g_infm_m.infm003,g_infm_m.infm003_desc, 
       g_infm_m.infm004,g_infm_m.infm004_desc,g_infm_m.infm005,g_infm_m.infm005_desc,g_infm_m.infm006, 
       g_infm_m.infmunit,g_infm_m.infm007,g_infm_m.infmstus,g_infm_m.infmownid,g_infm_m.infmownid_desc, 
       g_infm_m.infmowndp,g_infm_m.infmowndp_desc,g_infm_m.infmcrtid,g_infm_m.infmcrtid_desc,g_infm_m.infmcrtdp, 
       g_infm_m.infmcrtdp_desc,g_infm_m.infmcrtdt,g_infm_m.infmmodid,g_infm_m.infmmodid_desc,g_infm_m.infmmoddt, 
       g_infm_m.infmcnfid,g_infm_m.infmcnfid_desc,g_infm_m.infmcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_infm_m.infmstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "P"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_in.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_info_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_info2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_info3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aint710_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aint710.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aint710_detail_show()
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
 
{<section id="aint710.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aint710_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE infm_t.infmdocno 
   DEFINE l_oldno     LIKE infm_t.infmdocno 
 
   DEFINE l_master    RECORD LIKE infm_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE info_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE infn_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE infp_t.* #此變數樣板目前無使用
 
 
 
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
   
   IF g_infm_m.infmdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_infmdocno_t = g_infm_m.infmdocno
 
    
   LET g_infm_m.infmdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_infm_m.infmownid = g_user
      LET g_infm_m.infmowndp = g_dept
      LET g_infm_m.infmcrtid = g_user
      LET g_infm_m.infmcrtdp = g_dept 
      LET g_infm_m.infmcrtdt = cl_get_current()
      LET g_infm_m.infmmodid = g_user
      LET g_infm_m.infmmoddt = cl_get_current()
      LET g_infm_m.infmstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_infm_m.infmstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "P"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_in.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL aint710_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_infm_m.* TO NULL
      INITIALIZE g_info_d TO NULL
      INITIALIZE g_info2_d TO NULL
      INITIALIZE g_info3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aint710_show()
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
   CALL aint710_set_act_visible()   
   CALL aint710_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_infmdocno_t = g_infm_m.infmdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " infment = " ||g_enterprise|| " AND",
                      " infmdocno = '", g_infm_m.infmdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint710_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aint710_idx_chk()
   
   LET g_data_owner = g_infm_m.infmownid      
   LET g_data_dept  = g_infm_m.infmowndp
   
   #功能已完成,通報訊息中心
   CALL aint710_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aint710.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aint710_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE info_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE infn_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE infp_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aint710_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM info_t
    WHERE infoent = g_enterprise AND infodocno = g_infmdocno_t
 
    INTO TEMP aint710_detail
 
   #將key修正為調整後   
   UPDATE aint710_detail 
      #更新key欄位
      SET infodocno = g_infm_m.infmdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO info_t SELECT * FROM aint710_detail
   
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
   DROP TABLE aint710_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM infn_t 
    WHERE infnent = g_enterprise AND infndocno = g_infmdocno_t
 
    INTO TEMP aint710_detail
 
   #將key修正為調整後   
   UPDATE aint710_detail SET infndocno = g_infm_m.infmdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO infn_t SELECT * FROM aint710_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aint710_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM infp_t 
    WHERE infpent = g_enterprise AND infpdocno = g_infmdocno_t
 
    INTO TEMP aint710_detail
 
   #將key修正為調整後   
   UPDATE aint710_detail SET infpdocno = g_infm_m.infmdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO infp_t SELECT * FROM aint710_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aint710_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_infmdocno_t = g_infm_m.infmdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint710.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aint710_delete()
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
   
   IF g_infm_m.infmdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aint710_cl USING g_enterprise,g_infm_m.infmdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint710_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint710_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint710_master_referesh USING g_infm_m.infmdocno INTO g_infm_m.infmsite,g_infm_m.infmdocdt, 
       g_infm_m.infmdocno,g_infm_m.infm001,g_infm_m.infm002,g_infm_m.infm003,g_infm_m.infm004,g_infm_m.infm005, 
       g_infm_m.infm006,g_infm_m.infmunit,g_infm_m.infm007,g_infm_m.infmstus,g_infm_m.infmownid,g_infm_m.infmowndp, 
       g_infm_m.infmcrtid,g_infm_m.infmcrtdp,g_infm_m.infmcrtdt,g_infm_m.infmmodid,g_infm_m.infmmoddt, 
       g_infm_m.infmcnfid,g_infm_m.infmcnfdt,g_infm_m.infmsite_desc,g_infm_m.infm001_desc,g_infm_m.infm002_desc, 
       g_infm_m.infm003_desc,g_infm_m.infm004_desc,g_infm_m.infm005_desc,g_infm_m.infmownid_desc,g_infm_m.infmowndp_desc, 
       g_infm_m.infmcrtid_desc,g_infm_m.infmcrtdp_desc,g_infm_m.infmmodid_desc,g_infm_m.infmcnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT aint710_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_infm_m_mask_o.* =  g_infm_m.*
   CALL aint710_infm_t_mask()
   LET g_infm_m_mask_n.* =  g_infm_m.*
   
   CALL aint710_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aint710_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_infmdocno_t = g_infm_m.infmdocno
 
 
      DELETE FROM infm_t
       WHERE infment = g_enterprise AND infmdocno = g_infm_m.infmdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_infm_m.infmdocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM info_t
       WHERE infoent = g_enterprise AND infodocno = g_infm_m.infmdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "info_t:",SQLERRMESSAGE 
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
      DELETE FROM infn_t
       WHERE infnent = g_enterprise AND
             infndocno = g_infm_m.infmdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "infn_t:",SQLERRMESSAGE 
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
      DELETE FROM infp_t
       WHERE infpent = g_enterprise AND
             infpdocno = g_infm_m.infmdocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "infp_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_infm_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aint710_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_info_d.clear() 
      CALL g_info2_d.clear()       
      CALL g_info3_d.clear()       
 
     
      CALL aint710_ui_browser_refresh()  
      #CALL aint710_ui_headershow()  
      #CALL aint710_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aint710_browser_fill("")
         CALL aint710_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aint710_cl
 
   #功能已完成,通報訊息中心
   CALL aint710_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aint710.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aint710_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_info_d.clear()
   CALL g_info2_d.clear()
   CALL g_info3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aint710_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT infoseq,infosite,infounit,info002,info001,info003,info004,info005, 
             info006,info007,info008,info009,info010,info011,info012,info013,info014,info015,info016 , 
             t1.ooefl003 ,t2.imaal003 ,t3.imaal004 ,t4.oocal003 ,t5.oocal003 ,t6.inayl003 ,t7.inayl003 FROM info_t", 
                
                     " INNER JOIN infm_t ON infment = " ||g_enterprise|| " AND infmdocno = infodocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=infosite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=info001 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=info001 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=info005 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=info006 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t6 ON t6.inaylent="||g_enterprise||" AND t6.inayl001=info009 AND t6.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t7 ON t7.inaylent="||g_enterprise||" AND t7.inayl001=info014 AND t7.inayl002='"||g_dlang||"' ",
 
                     " WHERE infoent=? AND infodocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY info_t.infoseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint710_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aint710_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_infm_m.infmdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_infm_m.infmdocno INTO g_info_d[l_ac].infoseq,g_info_d[l_ac].infosite, 
          g_info_d[l_ac].infounit,g_info_d[l_ac].info002,g_info_d[l_ac].info001,g_info_d[l_ac].info003, 
          g_info_d[l_ac].info004,g_info_d[l_ac].info005,g_info_d[l_ac].info006,g_info_d[l_ac].info007, 
          g_info_d[l_ac].info008,g_info_d[l_ac].info009,g_info_d[l_ac].info010,g_info_d[l_ac].info011, 
          g_info_d[l_ac].info012,g_info_d[l_ac].info013,g_info_d[l_ac].info014,g_info_d[l_ac].info015, 
          g_info_d[l_ac].info016,g_info_d[l_ac].infosite_desc,g_info_d[l_ac].info001_desc,g_info_d[l_ac].info001_desc_desc, 
          g_info_d[l_ac].info005_desc,g_info_d[l_ac].info006_desc,g_info_d[l_ac].info009_desc,g_info_d[l_ac].info014_desc  
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
    
   #判斷是否填充
   IF aint710_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT infnseq,infnsite,infnunit,infn001,infn002 ,t8.ooefl003 FROM infn_t", 
                
                     " INNER JOIN  infm_t ON infment = " ||g_enterprise|| " AND infmdocno = infndocno ",
 
                     "",
                     
                                    " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=infnsite AND t8.ooefl002='"||g_dlang||"' ",
 
                     " WHERE infnent=? AND infndocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY infn_t.infnseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint710_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aint710_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_infm_m.infmdocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_infm_m.infmdocno INTO g_info2_d[l_ac].infnseq,g_info2_d[l_ac].infnsite, 
          g_info2_d[l_ac].infnunit,g_info2_d[l_ac].infn001,g_info2_d[l_ac].infn002,g_info2_d[l_ac].infnsite_desc  
            #(ver:78)
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
 
   #判斷是否填充
   IF aint710_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT infpseq,infpsite,infpunit,infp001,infp002,infp003,infp005,infp004, 
             infp006,infp007,infp008,infp009,infp010,infp011,infp012,infp013,infp014,infp015,infp016, 
             infp017,infp018,infp019 ,t9.ooefl003 ,t10.imaal003 ,t11.imaal004 ,t12.oocal003 ,t13.oocal003 , 
             t14.inayl003 ,t15.inayl003 FROM infp_t",   
                     " INNER JOIN  infm_t ON infment = " ||g_enterprise|| " AND infmdocno = infpdocno ",
 
                     "",
                     
                                    " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=infpsite AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t10 ON t10.imaalent="||g_enterprise||" AND t10.imaal001=infp004 AND t10.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t11 ON t11.imaalent="||g_enterprise||" AND t11.imaal001=infp004 AND t11.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t12 ON t12.oocalent="||g_enterprise||" AND t12.oocal001=infp008 AND t12.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t13 ON t13.oocalent="||g_enterprise||" AND t13.oocal001=infp009 AND t13.oocal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t14 ON t14.inaylent="||g_enterprise||" AND t14.inayl001=infp012 AND t14.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t15 ON t15.inaylent="||g_enterprise||" AND t15.inayl001=infp017 AND t15.inayl002='"||g_dlang||"' ",
 
                     " WHERE infpent=? AND infpdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY infp_t.infpseq"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint710_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR aint710_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_infm_m.infmdocno   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_infm_m.infmdocno INTO g_info3_d[l_ac].infpseq,g_info3_d[l_ac].infpsite, 
          g_info3_d[l_ac].infpunit,g_info3_d[l_ac].infp001,g_info3_d[l_ac].infp002,g_info3_d[l_ac].infp003, 
          g_info3_d[l_ac].infp005,g_info3_d[l_ac].infp004,g_info3_d[l_ac].infp006,g_info3_d[l_ac].infp007, 
          g_info3_d[l_ac].infp008,g_info3_d[l_ac].infp009,g_info3_d[l_ac].infp010,g_info3_d[l_ac].infp011, 
          g_info3_d[l_ac].infp012,g_info3_d[l_ac].infp013,g_info3_d[l_ac].infp014,g_info3_d[l_ac].infp015, 
          g_info3_d[l_ac].infp016,g_info3_d[l_ac].infp017,g_info3_d[l_ac].infp018,g_info3_d[l_ac].infp019, 
          g_info3_d[l_ac].infpsite_desc,g_info3_d[l_ac].infp004_desc,g_info3_d[l_ac].infp004_desc_desc, 
          g_info3_d[l_ac].infp008_desc,g_info3_d[l_ac].infp009_desc,g_info3_d[l_ac].infp012_desc,g_info3_d[l_ac].infp017_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         
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
   
   #end add-point
   
   CALL g_info_d.deleteElement(g_info_d.getLength())
   CALL g_info2_d.deleteElement(g_info2_d.getLength())
   CALL g_info3_d.deleteElement(g_info3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aint710_pb
   FREE aint710_pb2
 
   FREE aint710_pb3
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_info_d.getLength()
      LET g_info_d_mask_o[l_ac].* =  g_info_d[l_ac].*
      CALL aint710_info_t_mask()
      LET g_info_d_mask_n[l_ac].* =  g_info_d[l_ac].*
   END FOR
   
   LET g_info2_d_mask_o.* =  g_info2_d.*
   FOR l_ac = 1 TO g_info2_d.getLength()
      LET g_info2_d_mask_o[l_ac].* =  g_info2_d[l_ac].*
      CALL aint710_infn_t_mask()
      LET g_info2_d_mask_n[l_ac].* =  g_info2_d[l_ac].*
   END FOR
   LET g_info3_d_mask_o.* =  g_info3_d.*
   FOR l_ac = 1 TO g_info3_d.getLength()
      LET g_info3_d_mask_o[l_ac].* =  g_info3_d[l_ac].*
      CALL aint710_infp_t_mask()
      LET g_info3_d_mask_n[l_ac].* =  g_info3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aint710.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aint710_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM info_t
       WHERE infoent = g_enterprise AND
         infodocno = ps_keys_bak[1] AND infoseq = ps_keys_bak[2]
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
         CALL g_info_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM infn_t
       WHERE infnent = g_enterprise AND
             infndocno = ps_keys_bak[1] AND infnseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "infn_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_info2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM infp_t
       WHERE infpent = g_enterprise AND
             infpdocno = ps_keys_bak[1] AND infpseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "infp_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_info3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint710.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aint710_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO info_t
                  (infoent,
                   infodocno,
                   infoseq
                   ,infosite,infounit,info002,info001,info003,info004,info005,info006,info007,info008,info009,info010,info011,info012,info013,info014,info015,info016) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_info_d[g_detail_idx].infosite,g_info_d[g_detail_idx].infounit,g_info_d[g_detail_idx].info002, 
                       g_info_d[g_detail_idx].info001,g_info_d[g_detail_idx].info003,g_info_d[g_detail_idx].info004, 
                       g_info_d[g_detail_idx].info005,g_info_d[g_detail_idx].info006,g_info_d[g_detail_idx].info007, 
                       g_info_d[g_detail_idx].info008,g_info_d[g_detail_idx].info009,g_info_d[g_detail_idx].info010, 
                       g_info_d[g_detail_idx].info011,g_info_d[g_detail_idx].info012,g_info_d[g_detail_idx].info013, 
                       g_info_d[g_detail_idx].info014,g_info_d[g_detail_idx].info015,g_info_d[g_detail_idx].info016) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "info_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_info_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO infn_t
                  (infnent,
                   infndocno,
                   infnseq
                   ,infnsite,infnunit,infn001,infn002) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_info2_d[g_detail_idx].infnsite,g_info2_d[g_detail_idx].infnunit,g_info2_d[g_detail_idx].infn001, 
                       g_info2_d[g_detail_idx].infn002)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "infn_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_info2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO infp_t
                  (infpent,
                   infpdocno,
                   infpseq
                   ,infpsite,infpunit,infp001,infp002,infp003,infp005,infp004,infp006,infp007,infp008,infp009,infp010,infp011,infp012,infp013,infp014,infp015,infp016,infp017,infp018,infp019) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_info3_d[g_detail_idx].infpsite,g_info3_d[g_detail_idx].infpunit,g_info3_d[g_detail_idx].infp001, 
                       g_info3_d[g_detail_idx].infp002,g_info3_d[g_detail_idx].infp003,g_info3_d[g_detail_idx].infp005, 
                       g_info3_d[g_detail_idx].infp004,g_info3_d[g_detail_idx].infp006,g_info3_d[g_detail_idx].infp007, 
                       g_info3_d[g_detail_idx].infp008,g_info3_d[g_detail_idx].infp009,g_info3_d[g_detail_idx].infp010, 
                       g_info3_d[g_detail_idx].infp011,g_info3_d[g_detail_idx].infp012,g_info3_d[g_detail_idx].infp013, 
                       g_info3_d[g_detail_idx].infp014,g_info3_d[g_detail_idx].infp015,g_info3_d[g_detail_idx].infp016, 
                       g_info3_d[g_detail_idx].infp017,g_info3_d[g_detail_idx].infp018,g_info3_d[g_detail_idx].infp019) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "infp_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_info3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aint710.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aint710_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "info_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aint710_info_t_mask_restore('restore_mask_o')
               
      UPDATE info_t 
         SET (infodocno,
              infoseq
              ,infosite,infounit,info002,info001,info003,info004,info005,info006,info007,info008,info009,info010,info011,info012,info013,info014,info015,info016) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_info_d[g_detail_idx].infosite,g_info_d[g_detail_idx].infounit,g_info_d[g_detail_idx].info002, 
                  g_info_d[g_detail_idx].info001,g_info_d[g_detail_idx].info003,g_info_d[g_detail_idx].info004, 
                  g_info_d[g_detail_idx].info005,g_info_d[g_detail_idx].info006,g_info_d[g_detail_idx].info007, 
                  g_info_d[g_detail_idx].info008,g_info_d[g_detail_idx].info009,g_info_d[g_detail_idx].info010, 
                  g_info_d[g_detail_idx].info011,g_info_d[g_detail_idx].info012,g_info_d[g_detail_idx].info013, 
                  g_info_d[g_detail_idx].info014,g_info_d[g_detail_idx].info015,g_info_d[g_detail_idx].info016)  
 
         WHERE infoent = g_enterprise AND infodocno = ps_keys_bak[1] AND infoseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "info_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "info_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aint710_info_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "infn_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aint710_infn_t_mask_restore('restore_mask_o')
               
      UPDATE infn_t 
         SET (infndocno,
              infnseq
              ,infnsite,infnunit,infn001,infn002) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_info2_d[g_detail_idx].infnsite,g_info2_d[g_detail_idx].infnunit,g_info2_d[g_detail_idx].infn001, 
                  g_info2_d[g_detail_idx].infn002) 
         WHERE infnent = g_enterprise AND infndocno = ps_keys_bak[1] AND infnseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "infn_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "infn_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aint710_infn_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "infp_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aint710_infp_t_mask_restore('restore_mask_o')
               
      UPDATE infp_t 
         SET (infpdocno,
              infpseq
              ,infpsite,infpunit,infp001,infp002,infp003,infp005,infp004,infp006,infp007,infp008,infp009,infp010,infp011,infp012,infp013,infp014,infp015,infp016,infp017,infp018,infp019) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_info3_d[g_detail_idx].infpsite,g_info3_d[g_detail_idx].infpunit,g_info3_d[g_detail_idx].infp001, 
                  g_info3_d[g_detail_idx].infp002,g_info3_d[g_detail_idx].infp003,g_info3_d[g_detail_idx].infp005, 
                  g_info3_d[g_detail_idx].infp004,g_info3_d[g_detail_idx].infp006,g_info3_d[g_detail_idx].infp007, 
                  g_info3_d[g_detail_idx].infp008,g_info3_d[g_detail_idx].infp009,g_info3_d[g_detail_idx].infp010, 
                  g_info3_d[g_detail_idx].infp011,g_info3_d[g_detail_idx].infp012,g_info3_d[g_detail_idx].infp013, 
                  g_info3_d[g_detail_idx].infp014,g_info3_d[g_detail_idx].infp015,g_info3_d[g_detail_idx].infp016, 
                  g_info3_d[g_detail_idx].infp017,g_info3_d[g_detail_idx].infp018,g_info3_d[g_detail_idx].infp019)  
 
         WHERE infpent = g_enterprise AND infpdocno = ps_keys_bak[1] AND infpseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "infp_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "infp_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aint710_infp_t_mask_restore('restore_mask_n')
 
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
 
{<section id="aint710.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aint710_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aint710.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aint710_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aint710.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aint710_lock_b(ps_table,ps_page)
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
   #CALL aint710_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "info_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aint710_bcl USING g_enterprise,
                                       g_infm_m.infmdocno,g_info_d[g_detail_idx].infoseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint710_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "infn_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aint710_bcl2 USING g_enterprise,
                                             g_infm_m.infmdocno,g_info2_d[g_detail_idx].infnseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint710_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "infp_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aint710_bcl3 USING g_enterprise,
                                             g_infm_m.infmdocno,g_info3_d[g_detail_idx].infpseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint710_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   LET ls_group = "info_t1"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aint710_upd_detail_cl USING g_enterprise,
                                       g_infm_m.infmdocno,g_info_d[g_detail_idx].infoseq     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint710_upd_detail_cl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aint710.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aint710_unlock_b(ps_table,ps_page)
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
      CLOSE aint710_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aint710_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aint710_bcl3
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   LET ls_group = "'4',"
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aint710_upd_detail_cl
   END IF
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aint710.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aint710_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("infmdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("infmdocno",TRUE)
      CALL cl_set_comp_entry("infmdocdt",TRUE)
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
 
{<section id="aint710.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aint710_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("infmdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("infmdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("infmdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint710.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aint710_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("info012",TRUE)   #撥入包裝數量
   CALL cl_set_comp_entry("info015",TRUE)   #儲位
   CALL cl_set_comp_entry("info016",TRUE)   #批號
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aint710.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aint710_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_inaa007       LIKE inaa_t.inaa007
   DEFINE l_imaf061       LIKE imaf_t.imaf061
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF NOT cl_null(g_info_d[l_ac].info013) THEN
      CALL cl_set_comp_entry("info012",FALSE)   #撥入包裝數量
   END IF
   
   #庫位不使用儲位管理時，儲位不可維護
   LET l_inaa007 = ''
   SELECT inaa007 INTO l_inaa007
     FROM inaa_t
    WHERE inaaent = g_enterprise
      AND inaasite = g_infm_m.infm003
      AND inaa001 = g_info_d[l_ac].info014
   IF l_inaa007 = '5' THEN
      CALL cl_set_comp_entry("info015",FALSE)
      LET g_info_d[l_ac].info015 = ' '
      LET g_info_d[l_ac].info015_desc = ''
   END IF
   
   #[T:料件據點進銷存檔].[C:庫存批號控管]=2時,[C:不可有批號]欄位不可輸入
   LET l_imaf061 = ''
   SELECT imaf061 INTO l_imaf061
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = 'ALL'
      AND imaf001 = g_info_d[l_ac].info001
   IF l_imaf061 = '2' THEN
      CALL cl_set_comp_entry("info016",FALSE)
      LET g_info_d[l_ac].info016 = ' '
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aint710.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aint710_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("delete", TRUE)
   CALL cl_set_act_visible("upd_detail",TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint710.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aint710_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_infm_m.infmstus NOT MATCHES "[NDR]" THEN
      CALL cl_set_act_visible("delete", FALSE)
   END IF
   
   #當狀態 = 確認，才可以維護單身撥入資訊
   IF g_infm_m.infmstus != 'Y' THEN
      CALL cl_set_act_visible("upd_detail",FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint710.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aint710_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint710.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aint710_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint710.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aint710_default_search()
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
      LET ls_wc = ls_wc, " infmdocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   #傳單號範圍至aint710,一次查詢可查詢出多個單號資料
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc , g_argv[02], " AND "
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
         INITIALIZE g_wc2_table2 TO NULL
 
         INITIALIZE g_wc2_table3 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "infm_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "info_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "infn_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "infp_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
            IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
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
 
{<section id="aint710.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aint710_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_cnt      LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_infm_m.infmdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aint710_cl USING g_enterprise,g_infm_m.infmdocno
   IF STATUS THEN
      CLOSE aint710_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint710_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aint710_master_referesh USING g_infm_m.infmdocno INTO g_infm_m.infmsite,g_infm_m.infmdocdt, 
       g_infm_m.infmdocno,g_infm_m.infm001,g_infm_m.infm002,g_infm_m.infm003,g_infm_m.infm004,g_infm_m.infm005, 
       g_infm_m.infm006,g_infm_m.infmunit,g_infm_m.infm007,g_infm_m.infmstus,g_infm_m.infmownid,g_infm_m.infmowndp, 
       g_infm_m.infmcrtid,g_infm_m.infmcrtdp,g_infm_m.infmcrtdt,g_infm_m.infmmodid,g_infm_m.infmmoddt, 
       g_infm_m.infmcnfid,g_infm_m.infmcnfdt,g_infm_m.infmsite_desc,g_infm_m.infm001_desc,g_infm_m.infm002_desc, 
       g_infm_m.infm003_desc,g_infm_m.infm004_desc,g_infm_m.infm005_desc,g_infm_m.infmownid_desc,g_infm_m.infmowndp_desc, 
       g_infm_m.infmcrtid_desc,g_infm_m.infmcrtdp_desc,g_infm_m.infmmodid_desc,g_infm_m.infmcnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT aint710_action_chk() THEN
      CLOSE aint710_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_infm_m.infmsite,g_infm_m.infmsite_desc,g_infm_m.infmdocdt,g_infm_m.infmdocno,g_infm_m.infm001, 
       g_infm_m.infm001_desc,g_infm_m.infm002,g_infm_m.infm002_desc,g_infm_m.infm003,g_infm_m.infm003_desc, 
       g_infm_m.infm004,g_infm_m.infm004_desc,g_infm_m.infm005,g_infm_m.infm005_desc,g_infm_m.infm006, 
       g_infm_m.infmunit,g_infm_m.infm007,g_infm_m.infmstus,g_infm_m.infmownid,g_infm_m.infmownid_desc, 
       g_infm_m.infmowndp,g_infm_m.infmowndp_desc,g_infm_m.infmcrtid,g_infm_m.infmcrtid_desc,g_infm_m.infmcrtdp, 
       g_infm_m.infmcrtdp_desc,g_infm_m.infmcrtdt,g_infm_m.infmmodid,g_infm_m.infmmodid_desc,g_infm_m.infmmoddt, 
       g_infm_m.infmcnfid,g_infm_m.infmcnfid_desc,g_infm_m.infmcnfdt
 
   CASE g_infm_m.infmstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "P"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_in.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "C"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_infm_m.infmstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "P"
               HIDE OPTION "confirm_transfer_in"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "C"
               HIDE OPTION "closed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw,closed",FALSE)
      #將open改為unconfirmed
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed,confirm_transfer_in",TRUE)
      CASE g_infm_m.infmstus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,confirm_transfer_in",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
            
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,confirm_transfer_in",FALSE)
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN
         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
            
         WHEN "P"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,confirm_transfer_in",FALSE)
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN
         WHEN "R"
            CALL cl_set_act_visible("confirmed,unconfirmed,confirm_transfer_in",FALSE)

         WHEN "D"
            CALL cl_set_act_visible("confirmed,unconfirmed,confirm_transfer_in",FALSE)

         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed,confirm_transfer_in",FALSE)

         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid,confirm_transfer_in",FALSE)
             
         WHEN "C"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,confirm_transfer_in",FALSE)
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aint710_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint710_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aint710_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint710_cl
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
      ON ACTION confirm_transfer_in
         IF cl_auth_chk_act("confirm_transfer_in") THEN
            LET lc_state = "P"
            #add-point:action控制 name="statechange.confirm_transfer_in"
            
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
      ON ACTION closed
         IF cl_auth_chk_act("closed") THEN
            LET lc_state = "C"
            #add-point:action控制 name="statechange.closed"
            
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
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "P"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "C"
      AND lc_state <> "X"
      ) OR 
      g_infm_m.infmstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aint710_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   OPEN aint710_cl USING g_enterprise,g_infm_m.infmdocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint710_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE aint710_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   CALL cl_err_collect_init()
   #確認
   IF lc_state = 'Y' THEN
      CALL s_aint710_conf_chk(g_infm_m.infmdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN
         ELSE
            CALL s_aint710_conf_upd(g_infm_m.infmdocno) RETURNING l_success
            IF NOT l_success THEN
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
   
   #未確認
   IF lc_state = 'N' THEN
      CALL s_aint710_unconf_chk(g_infm_m.infmdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN
         ELSE
            CALL s_aint710_unconf_upd(g_infm_m.infmdocno) RETURNING l_success
            IF NOT l_success THEN
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
   
   #作廢
   IF lc_state = 'X' THEN
      CALL s_aint710_invalid_chk(g_infm_m.infmdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN
         ELSE
            CALL s_apmt840_invalid_upd(g_infm_m.infmdocno) RETURNING l_success
            IF NOT l_success THEN
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
   
   #撥入確認
   IF lc_state = 'P' THEN
      CALL s_aint710_inconf_chk(g_infm_m.infmdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
         RETURN
      ELSE
         IF NOT cl_ask_confirm('ain-00112') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN
         ELSE
            CALL s_aint710_inconf_upd(g_infm_m.infmdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
               SELECT COUNT(indddocno) INTO l_cnt
                 FROM infp_t,indd_t
                WHERE infpent = inddent
                  AND infp002 = indddocno
                  AND infp003 = inddseq
                  AND indd040 = 'N'
                  AND infpent = g_enterprise
                  AND infpdocno = g_infm_m.infmdocno
               IF l_cnt = 0 THEN
                  LET lc_state = 'C'
               ELSE
                  LET lc_state = 'P'
               END IF
            END IF
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_infm_m.infmmodid = g_user
   LET g_infm_m.infmmoddt = cl_get_current()
   LET g_infm_m.infmstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE infm_t 
      SET (infmstus,infmmodid,infmmoddt) 
        = (g_infm_m.infmstus,g_infm_m.infmmodid,g_infm_m.infmmoddt)     
    WHERE infment = g_enterprise AND infmdocno = g_infm_m.infmdocno
 
    
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
         WHEN "P"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirm_transfer_in.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE aint710_master_referesh USING g_infm_m.infmdocno INTO g_infm_m.infmsite,g_infm_m.infmdocdt, 
          g_infm_m.infmdocno,g_infm_m.infm001,g_infm_m.infm002,g_infm_m.infm003,g_infm_m.infm004,g_infm_m.infm005, 
          g_infm_m.infm006,g_infm_m.infmunit,g_infm_m.infm007,g_infm_m.infmstus,g_infm_m.infmownid,g_infm_m.infmowndp, 
          g_infm_m.infmcrtid,g_infm_m.infmcrtdp,g_infm_m.infmcrtdt,g_infm_m.infmmodid,g_infm_m.infmmoddt, 
          g_infm_m.infmcnfid,g_infm_m.infmcnfdt,g_infm_m.infmsite_desc,g_infm_m.infm001_desc,g_infm_m.infm002_desc, 
          g_infm_m.infm003_desc,g_infm_m.infm004_desc,g_infm_m.infm005_desc,g_infm_m.infmownid_desc, 
          g_infm_m.infmowndp_desc,g_infm_m.infmcrtid_desc,g_infm_m.infmcrtdp_desc,g_infm_m.infmmodid_desc, 
          g_infm_m.infmcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_infm_m.infmsite,g_infm_m.infmsite_desc,g_infm_m.infmdocdt,g_infm_m.infmdocno, 
          g_infm_m.infm001,g_infm_m.infm001_desc,g_infm_m.infm002,g_infm_m.infm002_desc,g_infm_m.infm003, 
          g_infm_m.infm003_desc,g_infm_m.infm004,g_infm_m.infm004_desc,g_infm_m.infm005,g_infm_m.infm005_desc, 
          g_infm_m.infm006,g_infm_m.infmunit,g_infm_m.infm007,g_infm_m.infmstus,g_infm_m.infmownid,g_infm_m.infmownid_desc, 
          g_infm_m.infmowndp,g_infm_m.infmowndp_desc,g_infm_m.infmcrtid,g_infm_m.infmcrtid_desc,g_infm_m.infmcrtdp, 
          g_infm_m.infmcrtdp_desc,g_infm_m.infmcrtdt,g_infm_m.infmmodid,g_infm_m.infmmodid_desc,g_infm_m.infmmoddt, 
          g_infm_m.infmcnfid,g_infm_m.infmcnfid_desc,g_infm_m.infmcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aint710_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint710_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint710.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aint710_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_info_d.getLength() THEN
         LET g_detail_idx = g_info_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_info_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_info_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_info2_d.getLength() THEN
         LET g_detail_idx = g_info2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_info2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_info2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_info3_d.getLength() THEN
         LET g_detail_idx = g_info3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_info3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_info3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aint710.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aint710_b_fill2(pi_idx)
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
   
   CALL aint710_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aint710.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aint710_fill_chk(ps_idx)
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
 
{<section id="aint710.status_show" >}
PRIVATE FUNCTION aint710_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aint710.mask_functions" >}
&include "erp/ain/aint710_mask.4gl"
 
{</section>}
 
{<section id="aint710.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aint710_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
   LET g_wc2_table3 = " 1=1"
 
 
   CALL aint710_show()
   CALL aint710_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_infm_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_info_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_info2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_info3_d))
 
 
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
   #CALL aint710_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aint710_ui_headershow()
   CALL aint710_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aint710_draw_out()
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
   CALL aint710_ui_headershow()  
   CALL aint710_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aint710.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aint710_set_pk_array()
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
   LET g_pk_array[1].values = g_infm_m.infmdocno
   LET g_pk_array[1].column = 'infmdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint710.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aint710.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aint710_msgcentre_notify(lc_state)
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
   CALL aint710_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_infm_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint710.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aint710_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint710.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 維護單身撥入資訊
# Memo...........:
# Usage..........: CALL aint710_upd_detail()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success     True/False
# Date & Author..: 2015/02/12 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION aint710_upd_detail()
DEFINE  l_cmd                 LIKE type_t.chr1
DEFINE  l_n                   LIKE type_t.num5                #檢查重複用  
DEFINE  l_cnt                 LIKE type_t.num5                #檢查重複用  
DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否 
DEFINE  l_insert              BOOLEAN


   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT ARRAY g_info_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
      
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_info_d.getLength()+1)
              LET g_insert = 'N'
           END IF
            CALL aint710_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_info_d.getLength()
      
         BEFORE ROW 
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
      
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
      
            CALL s_transaction_begin()
            OPEN aint710_cl USING g_enterprise,g_infm_m.infmdocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "OPEN aint710_cl:"
               LET g_errparam.code   = STATUS
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               CLOSE aint710_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
      
            LET g_rec_b = g_info_d.getLength()
      
            IF g_rec_b >= l_ac AND g_info_d[l_ac].infoseq IS NOT NULL THEN
               LET l_cmd='u'
               LET g_info_d_t.* = g_info_d[l_ac].*  #BACKUP
               LET g_info_d_o.* = g_info_d[l_ac].*  #BACKUP
               CALL aint710_set_entry_b(l_cmd)
               CALL aint710_set_no_entry_b(l_cmd)
               IF NOT aint710_lock_b("info_t1","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aint710_upd_detail_cl INTO g_info_d[l_ac].infoseq,g_info_d[l_ac].infosite,g_info_d[l_ac].infounit,
                      g_info_d[l_ac].info002,g_info_d[l_ac].info001,g_info_d[l_ac].info003,g_info_d[l_ac].info004,
                      g_info_d[l_ac].info005,g_info_d[l_ac].info006,g_info_d[l_ac].info007,g_info_d[l_ac].info008,
                      g_info_d[l_ac].info009,g_info_d[l_ac].info010,g_info_d[l_ac].info011,g_info_d[l_ac].info012,
                      g_info_d[l_ac].info013,g_info_d[l_ac].info014,g_info_d[l_ac].info015,g_info_d[l_ac].info016
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_info_d_t.infoseq
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  LET g_bfill = "N"
                  CALL aint710_show()
                  LET g_bfill = "Y"
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
      	
         AFTER FIELD info012
            IF NOT cl_ap_chk_range(g_info_d[l_ac].info012,"0","1","","","azz-00079",1) THEN
               NEXT FIELD info012
            END IF
            IF NOT cl_null(g_info_d[l_ac].info012) THEN
               IF g_info_d[l_ac].info012 != g_info_d_o.info012 OR cl_null(g_info_d_o.info012) THEN
                  IF g_info_d[l_ac].info012 > g_info_d[l_ac].info007 THEN
                     #輸入的撥入包裝數量大於撥出包裝數量！
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ain-00486"
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_info_d[l_ac].info012 = g_info_d_o.info012
                     NEXT FIELD CURRENT
                  END IF
                  CALL aint710_num_change('1')
               END IF
            END IF
            LET g_info_d_o.info012 = g_info_d[l_ac].info012
            LET g_info_d_o.info013 = g_info_d[l_ac].info013
      	
         AFTER FIELD info013
            IF NOT cl_ap_chk_range(g_info_d[l_ac].info013,"0","1","","","azz-00079",1) THEN
               NEXT FIELD info013
            END IF
            IF NOT cl_null(g_info_d[l_ac].info013) THEN
               IF g_info_d[l_ac].info013 != g_info_d_o.info013 OR cl_null(g_info_d_o.info013) THEN
                  IF g_info_d[l_ac].info013 > g_info_d[l_ac].info008 THEN
                     #輸入的撥入庫存數量大於撥出庫存數量！
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ain-00487"
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_info_d[l_ac].info013 = g_info_d_o.info013
                     NEXT FIELD CURRENT
                  END IF
                  CALL aint710_num_change('2')
               END IF
            END IF
            LET g_info_d_o.info012 = g_info_d[l_ac].info012
            LET g_info_d_o.info013 = g_info_d[l_ac].info013
      
         AFTER FIELD info014
            IF NOT cl_null(g_info_d[l_ac].info014) THEN
                IF g_info_d[l_ac].info014 != g_info_d_o.info014 OR cl_null(g_info_d_o.info014) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_infm_m.infm004
                  LET g_chkparam.arg2 = g_info_d[l_ac].info014
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                 #160318-00025#19  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001") THEN
                     CALL s_desc_get_stock_desc(g_infm_m.infm004,g_info_d[l_ac].info014)
      	            RETURNING g_info_d[l_ac].info014_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_stock_desc(g_infm_m.infm004,g_info_d[l_ac].info014)
               RETURNING g_info_d[l_ac].info014_desc
            LET g_info_d_o.info014 = g_info_d[l_ac].info014
            LET g_info_d_o.info015 = g_info_d[l_ac].info015
            CALL aint710_set_entry_b(l_cmd)
            CALL aint710_set_no_entry_b(l_cmd)
      
         AFTER FIELD info015
            LET g_info_d[l_ac].info015_desc = ''
            DISPLAY BY NAME g_info_d[l_ac].info015_desc
            IF NOT cl_null(g_info_d[l_ac].info015) THEN
               IF g_info_d[l_ac].info015 != g_info_d_o.info015 OR cl_null(g_info_d_o.info015) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_infm_m.infm004
                  LET g_chkparam.arg2 = g_info_d[l_ac].info014
                  LET g_chkparam.arg3 = g_info_d[l_ac].info015
                  #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#19  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inab002") THEN
      		     LET g_info_d[l_ac].info015 = g_info_d_o.info015
                 CALL s_desc_get_locator_desc(g_infm_m.infm004, g_info_d[l_ac].info014, g_info_d[l_ac].info015)
      	            RETURNING g_info_d[l_ac].info015_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_locator_desc(g_infm_m.infm004, g_info_d[l_ac].info014, g_info_d[l_ac].info015)
               RETURNING g_info_d[l_ac].info015_desc
            LET g_info_d_o.info015 = g_info_d[l_ac].info015
      
         ON ACTION controlp INFIELD info014
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_info_d[l_ac].info014
      	
            LET g_qryparam.arg1 = g_infm_m.infm004
            CALL q_inaa001_23()
            LET g_info_d[l_ac].info014 = g_qryparam.return1
            DISPLAY g_info_d[l_ac].info014 TO info014
      	   CALL s_desc_get_stock_desc(g_infm_m.infm004,g_info_d[l_ac].info014)
      	      RETURNING g_info_d[l_ac].info014_desc
            NEXT FIELD info014
      
         ON ACTION controlp INFIELD info015
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_info_d[l_ac].info015
      	
            LET g_qryparam.arg1 = g_infm_m.infm004
            LET g_qryparam.arg2 = g_info_d[l_ac].info014
            CALL q_inab002_6()
            LET g_info_d[l_ac].info015 = g_qryparam.return1
            DISPLAY g_info_d[l_ac].info015 TO info015
            CALL s_desc_get_locator_desc(g_infm_m.infm004, g_info_d[l_ac].info014, g_info_d[l_ac].info015)
               RETURNING g_info_d[l_ac].info015_desc
            NEXT FIELD info015
      
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 9001
               LET g_errparam.popup  = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_info_d[l_ac].* = g_info_d_t.*
               CLOSE aint710_upd_detail_cl
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF
      
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = g_info_d[l_ac].infoseq
               LET g_errparam.code   = -263
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET g_info_d[l_ac].* = g_info_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               UPDATE info_t
      	         SET (info012, info013, info014,
      		           info015, info016)
      		        = (g_info_d[l_ac].info012, g_info_d[l_ac].info013, g_info_d[l_ac].info014,
      			        g_info_d[l_ac].info015, g_info_d[l_ac].info016)
                 WHERE infoent = g_enterprise
      		       AND infodocno = g_infm_m.infmdocno
                   AND infoseq = g_info_d_t.infoseq
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = "info_t"
                     LET g_errparam.code   = "std-00009"
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_info_d[l_ac].* = g_info_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = "info_t"
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_info_d[l_ac].* = g_info_d_t.*
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL
                     LET gs_keys[1] = g_infm_m.infmdocno
                     LET gs_keys_bak[1] = g_infmdocno_t
                     LET gs_keys[2] = g_info_d[g_detail_idx].infoseq
                     LET gs_keys_bak[2] = g_info_d_t.infoseq
                     CALL aint710_update_b('info_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
               
               #更新隨貨同行單明細
               IF NOT aint710_reversal() THEN
                  CALL s_transaction_end('N','0')
               END IF
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_info_d[g_detail_idx].infoseq = g_info_d_t.infoseq) THEN
                  LET gs_keys[01] = g_infm_m.infmdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_info_d_t.infoseq
                  CALL aint710_key_update_b(gs_keys,'info_t')
               END IF
      
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_infm_m),util.JSON.stringify(g_info_d_t)
               LET g_log2 = util.JSON.stringify(g_infm_m),util.JSON.stringify(g_info_d[l_ac])
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                  CALL s_transaction_end('N','0')
               END IF
            END IF
      
         AFTER ROW
            CALL aint710_unlock_b("info_t4","'4'")
            CALL s_transaction_end('Y','0')
            CALL aint710_b_fill()
      	
         AFTER INPUT
      
      END INPUT
      
      BEFORE DIALOG
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
         CALL DIALOG.setCurrentRow("s_detail3",g_detail_idx)
      
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
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   
END FUNCTION

################################################################################
# Descriptions...: 數量轉換
# Memo...........:
# Usage..........: CALL aint710_num_change(p_type)
# Input parameter: p_type         1.包裝單位轉換成庫存單位
#                                 2.庫存單位轉換成包裝單位
# Return code....: 無
# Date & Author..: 2015/02/12 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION aint710_num_change(p_type)
DEFINE p_type           LIKE type_t.chr1
DEFINE l_success        LIKE type_t.num5

   IF p_type = '1' THEN
      #由包裝數量轉換成庫存數量
      CALL s_aooi250_convert_qty(g_info_d[l_ac].info001,g_info_d[l_ac].info006,g_info_d[l_ac].info005,g_info_d[l_ac].info012)
         RETURNING l_success,g_info_d[l_ac].info013
         
      IF g_info_d[l_ac].info013 > g_info_d[l_ac].info008 THEN
         LET g_info_d[l_ac].info013 = g_info_d[l_ac].info008
      END IF
   ELSE
      #由庫存數量轉換成包裝數量
      CALL s_aooi250_convert_qty(g_info_d[l_ac].info001,g_info_d[l_ac].info005,g_info_d[l_ac].info006,g_info_d[l_ac].info013)
         RETURNING l_success,g_info_d[l_ac].info012
         
      IF g_info_d[l_ac].info012 > g_info_d[l_ac].info007 THEN
         LET g_info_d[l_ac].info012 = g_info_d[l_ac].info007
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 更新隨貨同行單明細
# Memo...........:
# Usage..........: CALL aint710_reversal()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2015/02/13 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION aint710_reversal()
DEFINE r_success         LIKE type_t.num5
DEFINE l_infp            RECORD
       infpseq           LIKE infp_t.infpseq,   #項次
       infp008           LIKE infp_t.infp008,   #庫存單位
       infp009           LIKE infp_t.infp009,   #包裝單位
       infp010           LIKE infp_t.infp010,   #撥出包裝數量
       infp011           LIKE infp_t.infp011,   #撥出庫存數量
       infp015           LIKE infp_t.infp015,   #撥入包裝數量
       infp016           LIKE infp_t.infp016,   #撥入庫存數量
       infp017           LIKE infp_t.infp017,   #撥入庫位
       infp018           LIKE infp_t.infp018,   #撥入儲位
       infp019           LIKE infp_t.infp019    #撥入批號
                         END RECORD
DEFINE l_sql             STRING
DEFINE l_total_info012   LIKE info_t.info012    #總撥入包裝數量
DEFINE l_total_info013   LIKE info_t.info013    #總撥入庫存數量
DEFINE l_success         LIKE type_t.num5
DEFINE l_change          LIKE info_t.info007


   LET r_success = TRUE
   LET l_sql = "SELECT infpseq,infp008,infp009,infp010,infp011",
               "  FROM infp_t",
               " WHERE infpent = ",g_enterprise,
               "   AND infpdocno = '",g_infm_m.infmdocno,"'",
               "   AND infp004 = '",g_info_d[l_ac].info001,"'",  #商品編號
               "   AND infp005 = '",g_info_d[l_ac].info002,"'",  #商品條碼
               "   AND COALESCE(infp006,' ') = COALESCE('",g_info_d[l_ac].info003,"',' ')",  #產品特徵
               "   AND COALESCE(infp007,' ') = COALESCE('",g_info_d[l_ac].info004,"',' ')",  #經營方式
               "   AND COALESCE(infp012,' ') = COALESCE('",g_info_d[l_ac].info009,"',' ')",  #撥出庫位
               "   AND COALESCE(infp013,' ') = COALESCE('",g_info_d[l_ac].info010,"',' ')",  #撥出儲位
               "   AND COALESCE(infp014,' ') = COALESCE('",g_info_d[l_ac].info011,"',' ')",  #撥出批號
               " ORDER BY infpseq"
   PREPARE aint710_sel_infp_pre FROM l_sql
   DECLARE aint710_sel_infp_cs CURSOR FOR aint710_sel_infp_pre
   
   #撥入包裝數量
   LET l_total_info012 = g_info_d[l_ac].info012
   #撥入庫存數量
   LET l_total_info013 = g_info_d[l_ac].info013
   
   FOREACH aint710_sel_infp_cs
      INTO l_infp.infpseq, l_infp.infp008, l_infp.infp009,
           l_infp.infp010, l_infp.infp011
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Foreach aint710_sel_infp_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #庫存單位
      LET l_success = ''
      LET l_change = 0
      #由明細庫存單位轉換成 匯總庫存單位
      CALL s_aooi250_convert_qty(g_info_d[l_ac].info001,l_infp.infp008,g_info_d[l_ac].info005,l_infp.infp011)
         RETURNING l_success,l_change
      
      IF l_total_info013 = 0 THEN
         LET l_infp.infp016 = 0    #撥入庫存數量
         LET l_infp.infp017 = ''   #撥入庫位
         LET l_infp.infp018 = ''   #撥入儲位
         LET l_infp.infp019 = ''   #撥入批號
      ELSE
         #匯總庫存數量 >= 轉換後的明細庫存數量
         #  =>全數沖銷
         #Else
         #  =>部分沖銷
         IF l_total_info013 >= l_change THEN
            LET l_total_info013 = l_total_info013 - l_change
            LET l_infp.infp016 = l_infp.infp011           #撥入庫存數量
            LET l_infp.infp017 = g_info_d[l_ac].info009   #撥入庫位
            LET l_infp.infp018 = g_info_d[l_ac].info010   #撥入儲位
            LET l_infp.infp019 = g_info_d[l_ac].info011   #撥入批號
         ELSE
            #由匯總庫存單位轉換成 明細庫存單位
            LET l_success = ''
            LET l_change = ''
            CALL s_aooi250_convert_qty(g_info_d[l_ac].info001,g_info_d[l_ac].info005,l_infp.infp008,l_total_info013)
               RETURNING l_success,l_change
            LET l_total_info013 = 0
            LET l_infp.infp016 = l_change                 #撥入庫存數量
            LET l_infp.infp017 = g_info_d[l_ac].info009   #撥入庫位
            LET l_infp.infp018 = g_info_d[l_ac].info010   #撥入儲位
            LET l_infp.infp019 = g_info_d[l_ac].info011   #撥入批號
         END IF
      END IF
      
      #包裝單位
      LET l_success = ''
      LET l_change = 0
      #由明細包裝單位轉換成 匯總包裝單位
      CALL s_aooi250_convert_qty(g_info_d[l_ac].info001,l_infp.infp009,g_info_d[l_ac].info006,l_infp.infp010)
         RETURNING l_success,l_change
      
      IF l_total_info012 = 0 THEN
         LET l_infp.infp015 = 0    #撥入包裝數量
         #可能會因轉換單位而有數量差異
         IF l_infp.infp016 = 0 THEN
            LET l_infp.infp017 = ''   #撥入庫位
            LET l_infp.infp018 = ''   #撥入儲位
            LET l_infp.infp019 = ''   #撥入批號
         END IF
      ELSE
         #匯總包裝數量 >= 轉換後的明細包裝數量
         #  =>全數沖銷
         #Else
         #  =>部分沖銷
         IF l_total_info012 >= l_change THEN
            LET l_total_info012 = l_total_info012 - l_change
            LET l_infp.infp015 = l_infp.infp010           #撥入包裝數量
            LET l_infp.infp017 = g_info_d[l_ac].info009   #撥入庫位
            LET l_infp.infp018 = g_info_d[l_ac].info010   #撥入儲位
            LET l_infp.infp019 = g_info_d[l_ac].info011   #撥入批號
         ELSE
            #由匯總庫存單位轉換成 明細庫存單位
            LET l_success = ''
            LET l_change = ''
            CALL s_aooi250_convert_qty(g_info_d[l_ac].info001,g_info_d[l_ac].info006,l_infp.infp009,l_total_info012)
               RETURNING l_success,l_change
            LET l_total_info012 = 0
            LET l_infp.infp015 = l_change                 #撥入包裝數量
            LET l_infp.infp017 = g_info_d[l_ac].info009   #撥入庫位
            LET l_infp.infp018 = g_info_d[l_ac].info010   #撥入儲位
            LET l_infp.infp019 = g_info_d[l_ac].info011   #撥入批號
         END IF
      END IF
      
      UPDATE infp_t
         SET infp015 = l_infp.infp015,   #撥入包裝數量
             infp016 = l_infp.infp016,   #撥入庫存數量
             infp017 = l_infp.infp017,   #撥入庫位
             infp018 = l_infp.infp018,   #撥入儲位
             infp019 = l_infp.infp019    #撥入批號
       WHERE infpent = g_enterprise
         AND infpdocno = g_infm_m.infmdocno
         AND infpseq = l_infp.infpseq
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Upd infp_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      INITIALIZE l_infp.* TO NULL
   END FOREACH
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
