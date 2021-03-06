#該程式未解開Section, 採用最新樣板產出!
{<section id="aint805.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0025(2016-11-18 17:35:58), PR版次:0025(2017-02-20 15:50:04)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000280
#+ Filename...: aint805
#+ Description: 盤點單維護作業-初盤
#+ Creator....: 01251(2014-02-13 11:37:02)
#+ Modifier...: 06189 -SD/PR- 01996
 
{</section>}
 
{<section id="aint805.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#20  16/04/15 BY 07900   校验代码重复错误讯息的修改
#160719-00006#1   16/07/19 BY 02159   INSERT INTO 以 * 寫法改成指定欄位寫法
#160812-00017#3   16/08/15 By 06137   在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160818-00017#18  16/08/23 By lixh    单据类作业修改，删除时需重新检查状态
#160905-00007#5   16/09/05 by geza    sql加上ent条件
#161017-00029#7   16/10/18 by 08172   新增商品特征，根据条码带特征，特征带条码
#160824-00007#292 17/01/09 by 06814   新舊值相關處理
#161228-00033#3   17/01/10 by sakura  為了客戶DB種類的相容性:rownum寫法的改寫
#160711-00040#15  17/02/20 By xujing  T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                          CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
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
PRIVATE type type_g_ineg_m        RECORD
       inegsite LIKE ineg_t.inegsite, 
   inegsite_desc LIKE type_t.chr80, 
   inegdocdt LIKE ineg_t.inegdocdt, 
   inegdocno LIKE ineg_t.inegdocno, 
   ineg002 LIKE ineg_t.ineg002, 
   ineg002_desc LIKE type_t.chr80, 
   ineg004 LIKE ineg_t.ineg004, 
   ineg004_desc LIKE type_t.chr80, 
   ineg005 LIKE ineg_t.ineg005, 
   ineg005_desc LIKE type_t.chr80, 
   ineg003 LIKE ineg_t.ineg003, 
   ineg006 LIKE ineg_t.ineg006, 
   ineg006_desc LIKE type_t.chr80, 
   ineg007 LIKE ineg_t.ineg007, 
   ineg007_desc LIKE type_t.chr80, 
   ineg008 LIKE ineg_t.ineg008, 
   ineg008_desc LIKE type_t.chr80, 
   ineg010 LIKE ineg_t.ineg010, 
   ineg011 LIKE ineg_t.ineg011, 
   ineg001 LIKE ineg_t.ineg001, 
   inegunit LIKE ineg_t.inegunit, 
   inegstus LIKE ineg_t.inegstus, 
   inegownid LIKE ineg_t.inegownid, 
   inegownid_desc LIKE type_t.chr80, 
   inegcrtdp LIKE ineg_t.inegcrtdp, 
   inegcrtdp_desc LIKE type_t.chr80, 
   inegowndp LIKE ineg_t.inegowndp, 
   inegowndp_desc LIKE type_t.chr80, 
   inegcrtdt LIKE ineg_t.inegcrtdt, 
   inegcrtid LIKE ineg_t.inegcrtid, 
   inegcrtid_desc LIKE type_t.chr80, 
   inegmodid LIKE ineg_t.inegmodid, 
   inegmodid_desc LIKE type_t.chr80, 
   inegcnfdt LIKE ineg_t.inegcnfdt, 
   inegmoddt LIKE ineg_t.inegmoddt, 
   inegpstid LIKE ineg_t.inegpstid, 
   inegpstid_desc LIKE type_t.chr80, 
   inegcnfid LIKE ineg_t.inegcnfid, 
   inegcnfid_desc LIKE type_t.chr80, 
   inegpstdt LIKE ineg_t.inegpstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_ineh_d        RECORD
       inehseq LIKE ineh_t.inehseq, 
   ineh001 LIKE ineh_t.ineh001, 
   ineh003 LIKE ineh_t.ineh003, 
   ineh003_desc LIKE type_t.chr500, 
   ineh002 LIKE ineh_t.ineh002, 
   ineh001_desc LIKE type_t.chr500, 
   ineh001_desc_desc LIKE type_t.chr500, 
   ineh004 LIKE ineh_t.ineh004, 
   ineh004_desc LIKE type_t.chr500, 
   ineh005 LIKE ineh_t.ineh005, 
   ineh006 LIKE ineh_t.ineh006, 
   ineh007 LIKE ineh_t.ineh007, 
   ineh008 LIKE ineh_t.ineh008, 
   ineh008_desc LIKE type_t.chr500, 
   ineh010 LIKE ineh_t.ineh010, 
   ineh011 LIKE ineh_t.ineh011, 
   ineh012 LIKE ineh_t.ineh012, 
   ineh013 LIKE ineh_t.ineh013, 
   ineh014 LIKE ineh_t.ineh014, 
   amount LIKE type_t.num20_6, 
   ineh009 LIKE ineh_t.ineh009, 
   ineh015 LIKE ineh_t.ineh015, 
   ineh016 LIKE ineh_t.ineh016, 
   amount1 LIKE type_t.num20_6, 
   ineh017 LIKE ineh_t.ineh017, 
   amount2 LIKE type_t.num20_6, 
   ineh018 LIKE ineh_t.ineh018, 
   ineh019 LIKE ineh_t.ineh019, 
   inehunit LIKE ineh_t.inehunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_inegsite LIKE ineg_t.inegsite,
   b_inegsite_desc LIKE type_t.chr80,
      b_inegdocdt LIKE ineg_t.inegdocdt,
      b_inegdocno LIKE ineg_t.inegdocno,
      b_ineg002 LIKE ineg_t.ineg002,
   b_ineg002_desc LIKE type_t.chr80,
      b_ineg003 LIKE ineg_t.ineg003,
      b_ineg004 LIKE ineg_t.ineg004,
   b_ineg004_desc LIKE type_t.chr80,
      b_ineg005 LIKE ineg_t.ineg005,
   b_ineg005_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#161017-00029#7 -s by 08172
DEFINE g_inam       DYNAMIC ARRAY OF RECORD   #记录产品特征
         inam001      LIKE inam_t.inam001,
         inam002      LIKE inam_t.inam002,
         inam004      LIKE inam_t.inam004
                   END RECORD 
DEFINE g_imaa005   LIKE imaa_t.imaa005     #特征组别
#161017-00029#7 -e by 08172                   
#end add-point
       
#模組變數(Module Variables)
DEFINE g_ineg_m          type_g_ineg_m
DEFINE g_ineg_m_t        type_g_ineg_m
DEFINE g_ineg_m_o        type_g_ineg_m
DEFINE g_ineg_m_mask_o   type_g_ineg_m #轉換遮罩前資料
DEFINE g_ineg_m_mask_n   type_g_ineg_m #轉換遮罩後資料
 
   DEFINE g_inegsite_t LIKE ineg_t.inegsite
DEFINE g_inegdocno_t LIKE ineg_t.inegdocno
 
 
DEFINE g_ineh_d          DYNAMIC ARRAY OF type_g_ineh_d
DEFINE g_ineh_d_t        type_g_ineh_d
DEFINE g_ineh_d_o        type_g_ineh_d
DEFINE g_ineh_d_mask_o   DYNAMIC ARRAY OF type_g_ineh_d #轉換遮罩前資料
DEFINE g_ineh_d_mask_n   DYNAMIC ARRAY OF type_g_ineh_d #轉換遮罩後資料
 
 
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
DEFINE g_site_flag      LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="aint805.main" >}
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
   LET g_forupd_sql = " SELECT inegsite,'',inegdocdt,inegdocno,ineg002,'',ineg004,'',ineg005,'',ineg003, 
       ineg006,'',ineg007,'',ineg008,'',ineg010,ineg011,ineg001,inegunit,inegstus,inegownid,'',inegcrtdp, 
       '',inegowndp,'',inegcrtdt,inegcrtid,'',inegmodid,'',inegcnfdt,inegmoddt,inegpstid,'',inegcnfid, 
       '',inegpstdt", 
                      " FROM ineg_t",
                      " WHERE inegent= ? AND inegsite=? AND inegdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint805_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.inegsite,t0.inegdocdt,t0.inegdocno,t0.ineg002,t0.ineg004,t0.ineg005, 
       t0.ineg003,t0.ineg006,t0.ineg007,t0.ineg008,t0.ineg010,t0.ineg011,t0.ineg001,t0.inegunit,t0.inegstus, 
       t0.inegownid,t0.inegcrtdp,t0.inegowndp,t0.inegcrtdt,t0.inegcrtid,t0.inegmodid,t0.inegcnfdt,t0.inegmoddt, 
       t0.inegpstid,t0.inegcnfid,t0.inegpstdt,t1.ooefl003 ,t2.inea001 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 , 
       t6.ooefl003 ,t7.inayl003 ,t8.ooag011 ,t9.ooefl003 ,t10.ooefl003 ,t11.ooag011 ,t12.ooag011 ,t13.ooag011 , 
       t14.ooag011",
               " FROM ineg_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.inegsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inea_t t2 ON t2.ineaent="||g_enterprise||" AND t2.ineadocno=t0.ineg002  ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.ineg004  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.ineg005 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.ineg006  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.ineg007 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t7 ON t7.inaylent="||g_enterprise||" AND t7.inayl001=t0.ineg008 AND t7.inayl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.inegownid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.inegcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.inegowndp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.inegcrtid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.inegmodid  ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent="||g_enterprise||" AND t13.ooag001=t0.inegpstid  ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=t0.inegcnfid  ",
 
               " WHERE t0.inegent = " ||g_enterprise|| " AND t0.inegsite = ? AND t0.inegdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aint805_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aint805 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aint805_init()   
 
      #進入選單 Menu (="N")
      CALL aint805_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aint805
      
   END IF 
   
   CLOSE aint805_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aint805.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aint805_init()
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('inegstus','13','Y,N,S,A,D,R,W,X')
 
      CALL cl_set_combo_scc('ineg010','6938') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_act_visible("posted,unposted",FALSE)
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
   
   #初始化搜尋條件
   CALL aint805_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aint805.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aint805_ui_dialog()
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
   DEFINE l_success LIKE type_t.num5 #add by geza 20160317
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
            CALL aint805_insert()
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
         INITIALIZE g_ineg_m.* TO NULL
         CALL g_ineh_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aint805_init()
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
               
               CALL aint805_fetch('') # reload data
               LET l_ac = 1
               CALL aint805_ui_detailshow() #Setting the current row 
         
               CALL aint805_idx_chk()
               #NEXT FIELD inehseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_ineh_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint805_idx_chk()
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
               CALL aint805_idx_chk()
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
            CALL aint805_browser_fill("")
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
               CALL aint805_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aint805_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aint805_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aint805_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aint805_set_act_visible()   
            CALL aint805_set_act_no_visible()
            IF NOT (g_ineg_m.inegsite IS NULL
              OR g_ineg_m.inegdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " inegent = " ||g_enterprise|| " AND",
                                  " inegsite = '", g_ineg_m.inegsite, "' "
                                  ," AND inegdocno = '", g_ineg_m.inegdocno, "' "
 
               #填到對應位置
               CALL aint805_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "ineg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "ineh_t" 
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
               CALL aint805_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "ineg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "ineh_t" 
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
                  CALL aint805_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aint805_fetch("F")
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
               CALL aint805_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aint805_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint805_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aint805_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint805_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aint805_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint805_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aint805_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint805_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aint805_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint805_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_ineh_d)
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
               NEXT FIELD inehseq
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
               CALL aint805_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aint805_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION downloadtemplet
            LET g_action_choice="downloadtemplet"
            IF cl_auth_chk_act("downloadtemplet") THEN
               
               #add-point:ON ACTION downloadtemplet name="menu.downloadtemplet"
               CALL s_excel_templet_download()  #lanjj add on2016-06-28
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION ined_upd
            LET g_action_choice="ined_upd"
            IF cl_auth_chk_act("ined_upd") THEN
               
               #add-point:ON ACTION ined_upd name="menu.ined_upd"
               IF NOT cl_null(g_ineg_m.inegdocno) THEN
                  IF g_ineg_m.inegstus <> 'Y' THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "ain-00758" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CONTINUE DIALOG 
                  ELSE
                     CALL s_aini801_setpro('2',g_ineg_m.inegsite,g_ineg_m.ineg002,'4') RETURNING l_success               
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "std-00003" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CONTINUE DIALOG    
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aint805_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aint805_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/ain/aint805_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/ain/aint805_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aint805_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION uploadtemplet
            LET g_action_choice="uploadtemplet"
            IF cl_auth_chk_act("uploadtemplet") THEN
               
               #add-point:ON ACTION uploadtemplet name="menu.uploadtemplet"
               CALL s_excel_templet_upload() #lanjj add on 2016-06-28
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION import
            LET g_action_choice="import"
            IF cl_auth_chk_act("import") THEN
               
               #add-point:ON ACTION import name="menu.import"
              #lanjj add on 2016-06-28 excel 导入
               CALL cl_err_collect_init()
               CALL s_aint805_excel(g_ineg_m.inegdocno)
               CALL aint805_b_fill()
               CALL cl_err_collect_show()
              #lanjj add on 2016-06-28 excel 导入
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_aint800
            LET g_action_choice="prog_aint800"
            IF cl_auth_chk_act("prog_aint800") THEN
               
               #add-point:ON ACTION prog_aint800 name="menu.prog_aint800"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aint800'
               LET la_param.param[1] = g_ineg_m.ineg002

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_ineg004
            LET g_action_choice="prog_ineg004"
            IF cl_auth_chk_act("prog_ineg004") THEN
               
               #add-point:ON ACTION prog_ineg004 name="menu.prog_ineg004"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_ineg_m.ineg004)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_ineg006
            LET g_action_choice="prog_ineg006"
            IF cl_auth_chk_act("prog_ineg006") THEN
               
               #add-point:ON ACTION prog_ineg006 name="menu.prog_ineg006"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_ineg_m.ineg006)
 


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aint805_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aint805_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aint805_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_ineg_m.inegdocdt)
 
 
 
         
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
 
{<section id="aint805.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aint805_browser_fill(ps_page_action)
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
   LET g_wc=g_wc CLIPPED," AND ineg001='1' "
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()  
   CALL s_aooi500_sql_where(g_prog,'inegsite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   LET l_wc  = g_wc.trim()    
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT inegsite,inegdocno ",
                      " FROM ineg_t ",
                      " ",
                      " LEFT JOIN ineh_t ON inehent = inegent AND inegsite = inehsite AND inegdocno = inehdocno ", "  ",
                      #add-point:browser_fill段sql(ineh_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE inegent = " ||g_enterprise|| " AND inehent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("ineg_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT inegsite,inegdocno ",
                      " FROM ineg_t ", 
                      "  ",
                      "  ",
                      " WHERE inegent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("ineg_t")
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
      INITIALIZE g_ineg_m.* TO NULL
      CALL g_ineh_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.inegsite,t0.inegdocdt,t0.inegdocno,t0.ineg002,t0.ineg003,t0.ineg004,t0.ineg005 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.inegstus,t0.inegsite,t0.inegdocdt,t0.inegdocno,t0.ineg002,t0.ineg003, 
          t0.ineg004,t0.ineg005,t1.ooefl003 ,t2.inea001 ,t3.ooag011 ,t4.ooefl003 ",
                  " FROM ineg_t t0",
                  "  ",
                  "  LEFT JOIN ineh_t ON inehent = inegent AND inegsite = inehsite AND inegdocno = inehdocno ", "  ", 
                  #add-point:browser_fill段sql(ineh_t1) name="browser_fill.join.ineh_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.inegsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inea_t t2 ON t2.ineaent="||g_enterprise||" AND t2.ineadocno=t0.ineg002  ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.ineg004  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.ineg005 AND t4.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.inegent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("ineg_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.inegstus,t0.inegsite,t0.inegdocdt,t0.inegdocno,t0.ineg002,t0.ineg003, 
          t0.ineg004,t0.ineg005,t1.ooefl003 ,t2.inea001 ,t3.ooag011 ,t4.ooefl003 ",
                  " FROM ineg_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.inegsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inea_t t2 ON t2.ineaent="||g_enterprise||" AND t2.ineadocno=t0.ineg002  ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.ineg004  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.ineg005 AND t4.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.inegent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("ineg_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY inegsite,inegdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"ineg_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_inegsite,g_browser[g_cnt].b_inegdocdt, 
          g_browser[g_cnt].b_inegdocno,g_browser[g_cnt].b_ineg002,g_browser[g_cnt].b_ineg003,g_browser[g_cnt].b_ineg004, 
          g_browser[g_cnt].b_ineg005,g_browser[g_cnt].b_inegsite_desc,g_browser[g_cnt].b_ineg002_desc, 
          g_browser[g_cnt].b_ineg004_desc,g_browser[g_cnt].b_ineg005_desc
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
         CALL aint805_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "S"
            LET g_browser[g_cnt].b_statepic = "stus/16/posted.png"
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
   
   IF cl_null(g_browser[g_cnt].b_inegsite) THEN
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
   #add by geza 20160317(S)
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint805_set_act_visible()   
   CALL aint805_set_act_no_visible()
   #add by geza 20160317(E)
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="aint805.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aint805_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_ineg_m.inegsite = g_browser[g_current_idx].b_inegsite   
   LET g_ineg_m.inegdocno = g_browser[g_current_idx].b_inegdocno   
 
   EXECUTE aint805_master_referesh USING g_ineg_m.inegsite,g_ineg_m.inegdocno INTO g_ineg_m.inegsite, 
       g_ineg_m.inegdocdt,g_ineg_m.inegdocno,g_ineg_m.ineg002,g_ineg_m.ineg004,g_ineg_m.ineg005,g_ineg_m.ineg003, 
       g_ineg_m.ineg006,g_ineg_m.ineg007,g_ineg_m.ineg008,g_ineg_m.ineg010,g_ineg_m.ineg011,g_ineg_m.ineg001, 
       g_ineg_m.inegunit,g_ineg_m.inegstus,g_ineg_m.inegownid,g_ineg_m.inegcrtdp,g_ineg_m.inegowndp, 
       g_ineg_m.inegcrtdt,g_ineg_m.inegcrtid,g_ineg_m.inegmodid,g_ineg_m.inegcnfdt,g_ineg_m.inegmoddt, 
       g_ineg_m.inegpstid,g_ineg_m.inegcnfid,g_ineg_m.inegpstdt,g_ineg_m.inegsite_desc,g_ineg_m.ineg002_desc, 
       g_ineg_m.ineg004_desc,g_ineg_m.ineg005_desc,g_ineg_m.ineg006_desc,g_ineg_m.ineg007_desc,g_ineg_m.ineg008_desc, 
       g_ineg_m.inegownid_desc,g_ineg_m.inegcrtdp_desc,g_ineg_m.inegowndp_desc,g_ineg_m.inegcrtid_desc, 
       g_ineg_m.inegmodid_desc,g_ineg_m.inegpstid_desc,g_ineg_m.inegcnfid_desc
   
   CALL aint805_ineg_t_mask()
   CALL aint805_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aint805.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aint805_ui_detailshow()
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
 
{<section id="aint805.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aint805_ui_browser_refresh()
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
      IF g_browser[l_i].b_inegsite = g_ineg_m.inegsite 
         AND g_browser[l_i].b_inegdocno = g_ineg_m.inegdocno 
 
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
 
{<section id="aint805.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aint805_construct()
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
   INITIALIZE g_ineg_m.* TO NULL
   CALL g_ineh_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON inegsite,inegdocdt,inegdocno,ineg002,ineg004,ineg005,ineg006,ineg007, 
          ineg008,ineg010,ineg011,ineg001,inegunit,inegstus,inegownid,inegcrtdp,inegowndp,inegcrtdt, 
          inegcrtid,inegmodid,inegcnfdt,inegmoddt,inegpstid,inegcnfid,inegpstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<inegcrtdt>>----
         AFTER FIELD inegcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<inegmoddt>>----
         AFTER FIELD inegmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<inegcnfdt>>----
         AFTER FIELD inegcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<inegpstdt>>----
         AFTER FIELD inegpstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.inegsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inegsite
            #add-point:ON ACTION controlp INFIELD inegsite name="construct.c.inegsite"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
#			LET g_qryparam.arg1=g_site
#			LET g_qryparam.arg2='8'
#            CALL q_ooed004_3()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'inegsite',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO inegsite  #顯示到畫面上

            NEXT FIELD inegsite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegsite
            #add-point:BEFORE FIELD inegsite name="construct.b.inegsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inegsite
            
            #add-point:AFTER FIELD inegsite name="construct.a.inegsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegdocdt
            #add-point:BEFORE FIELD inegdocdt name="construct.b.inegdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inegdocdt
            
            #add-point:AFTER FIELD inegdocdt name="construct.a.inegdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inegdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inegdocdt
            #add-point:ON ACTION controlp INFIELD inegdocdt name="construct.c.inegdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inegdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inegdocno
            #add-point:ON ACTION controlp INFIELD inegdocno name="construct.c.inegdocno"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1='1'
            CALL q_inegdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inegdocno  #顯示到畫面上

            NEXT FIELD inegdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegdocno
            #add-point:BEFORE FIELD inegdocno name="construct.b.inegdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inegdocno
            
            #add-point:AFTER FIELD inegdocno name="construct.a.inegdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ineg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineg002
            #add-point:ON ACTION controlp INFIELD ineg002 name="construct.c.ineg002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ineadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ineg002  #顯示到畫面上

            NEXT FIELD ineg002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineg002
            #add-point:BEFORE FIELD ineg002 name="construct.b.ineg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineg002
            
            #add-point:AFTER FIELD ineg002 name="construct.a.ineg002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ineg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineg004
            #add-point:ON ACTION controlp INFIELD ineg004 name="construct.c.ineg004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ineg004  #顯示到畫面上

            NEXT FIELD ineg004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineg004
            #add-point:BEFORE FIELD ineg004 name="construct.b.ineg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineg004
            
            #add-point:AFTER FIELD ineg004 name="construct.a.ineg004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ineg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineg005
            #add-point:ON ACTION controlp INFIELD ineg005 name="construct.c.ineg005"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE			
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ineg005  #顯示到畫面上

            NEXT FIELD ineg005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineg005
            #add-point:BEFORE FIELD ineg005 name="construct.b.ineg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineg005
            
            #add-point:AFTER FIELD ineg005 name="construct.a.ineg005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ineg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineg006
            #add-point:ON ACTION controlp INFIELD ineg006 name="construct.c.ineg006"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ineg006  #顯示到畫面上

            NEXT FIELD ineg006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineg006
            #add-point:BEFORE FIELD ineg006 name="construct.b.ineg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineg006
            
            #add-point:AFTER FIELD ineg006 name="construct.a.ineg006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ineg007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineg007
            #add-point:ON ACTION controlp INFIELD ineg007 name="construct.c.ineg007"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ineg007  #顯示到畫面上

            NEXT FIELD ineg007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineg007
            #add-point:BEFORE FIELD ineg007 name="construct.b.ineg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineg007
            
            #add-point:AFTER FIELD ineg007 name="construct.a.ineg007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ineg008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineg008
            #add-point:ON ACTION controlp INFIELD ineg008 name="construct.c.ineg008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_12()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ineg008  #顯示到畫面上
            NEXT FIELD ineg008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineg008
            #add-point:BEFORE FIELD ineg008 name="construct.b.ineg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineg008
            
            #add-point:AFTER FIELD ineg008 name="construct.a.ineg008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineg010
            #add-point:BEFORE FIELD ineg010 name="construct.b.ineg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineg010
            
            #add-point:AFTER FIELD ineg010 name="construct.a.ineg010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ineg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineg010
            #add-point:ON ACTION controlp INFIELD ineg010 name="construct.c.ineg010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.ineg011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineg011
            #add-point:ON ACTION controlp INFIELD ineg011 name="construct.c.ineg011"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ineg011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ineg011  #顯示到畫面上
            NEXT FIELD ineg011                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineg011
            #add-point:BEFORE FIELD ineg011 name="construct.b.ineg011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineg011
            
            #add-point:AFTER FIELD ineg011 name="construct.a.ineg011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineg001
            #add-point:BEFORE FIELD ineg001 name="construct.b.ineg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineg001
            
            #add-point:AFTER FIELD ineg001 name="construct.a.ineg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ineg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineg001
            #add-point:ON ACTION controlp INFIELD ineg001 name="construct.c.ineg001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegunit
            #add-point:BEFORE FIELD inegunit name="construct.b.inegunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inegunit
            
            #add-point:AFTER FIELD inegunit name="construct.a.inegunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inegunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inegunit
            #add-point:ON ACTION controlp INFIELD inegunit name="construct.c.inegunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegstus
            #add-point:BEFORE FIELD inegstus name="construct.b.inegstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inegstus
            
            #add-point:AFTER FIELD inegstus name="construct.a.inegstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inegstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inegstus
            #add-point:ON ACTION controlp INFIELD inegstus name="construct.c.inegstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inegownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inegownid
            #add-point:ON ACTION controlp INFIELD inegownid name="construct.c.inegownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inegownid  #顯示到畫面上

            NEXT FIELD inegownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegownid
            #add-point:BEFORE FIELD inegownid name="construct.b.inegownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inegownid
            
            #add-point:AFTER FIELD inegownid name="construct.a.inegownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inegcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inegcrtdp
            #add-point:ON ACTION controlp INFIELD inegcrtdp name="construct.c.inegcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inegcrtdp  #顯示到畫面上

            NEXT FIELD inegcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegcrtdp
            #add-point:BEFORE FIELD inegcrtdp name="construct.b.inegcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inegcrtdp
            
            #add-point:AFTER FIELD inegcrtdp name="construct.a.inegcrtdp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inegowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inegowndp
            #add-point:ON ACTION controlp INFIELD inegowndp name="construct.c.inegowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inegowndp  #顯示到畫面上

            NEXT FIELD inegowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegowndp
            #add-point:BEFORE FIELD inegowndp name="construct.b.inegowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inegowndp
            
            #add-point:AFTER FIELD inegowndp name="construct.a.inegowndp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegcrtdt
            #add-point:BEFORE FIELD inegcrtdt name="construct.b.inegcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inegcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inegcrtid
            #add-point:ON ACTION controlp INFIELD inegcrtid name="construct.c.inegcrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inegcrtid  #顯示到畫面上

            NEXT FIELD inegcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegcrtid
            #add-point:BEFORE FIELD inegcrtid name="construct.b.inegcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inegcrtid
            
            #add-point:AFTER FIELD inegcrtid name="construct.a.inegcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inegmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inegmodid
            #add-point:ON ACTION controlp INFIELD inegmodid name="construct.c.inegmodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inegmodid  #顯示到畫面上

            NEXT FIELD inegmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegmodid
            #add-point:BEFORE FIELD inegmodid name="construct.b.inegmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inegmodid
            
            #add-point:AFTER FIELD inegmodid name="construct.a.inegmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegcnfdt
            #add-point:BEFORE FIELD inegcnfdt name="construct.b.inegcnfdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegmoddt
            #add-point:BEFORE FIELD inegmoddt name="construct.b.inegmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inegpstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inegpstid
            #add-point:ON ACTION controlp INFIELD inegpstid name="construct.c.inegpstid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inegpstid  #顯示到畫面上

            NEXT FIELD inegpstid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegpstid
            #add-point:BEFORE FIELD inegpstid name="construct.b.inegpstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inegpstid
            
            #add-point:AFTER FIELD inegpstid name="construct.a.inegpstid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inegcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inegcnfid
            #add-point:ON ACTION controlp INFIELD inegcnfid name="construct.c.inegcnfid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inegcnfid  #顯示到畫面上

            NEXT FIELD inegcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegcnfid
            #add-point:BEFORE FIELD inegcnfid name="construct.b.inegcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inegcnfid
            
            #add-point:AFTER FIELD inegcnfid name="construct.a.inegcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegpstdt
            #add-point:BEFORE FIELD inegpstdt name="construct.b.inegpstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON inehseq,ineh001,ineh003,ineh003_desc,ineh002,ineh004,ineh005,ineh006, 
          ineh008,amount,ineh009,ineh016,ineh017,ineh019
           FROM s_detail1[1].inehseq,s_detail1[1].ineh001,s_detail1[1].ineh003,s_detail1[1].ineh003_desc, 
               s_detail1[1].ineh002,s_detail1[1].ineh004,s_detail1[1].ineh005,s_detail1[1].ineh006,s_detail1[1].ineh008, 
               s_detail1[1].amount,s_detail1[1].ineh009,s_detail1[1].ineh016,s_detail1[1].ineh017,s_detail1[1].ineh019 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inehseq
            #add-point:BEFORE FIELD inehseq name="construct.b.page1.inehseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inehseq
            
            #add-point:AFTER FIELD inehseq name="construct.a.page1.inehseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inehseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inehseq
            #add-point:ON ACTION controlp INFIELD inehseq name="construct.c.page1.inehseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.ineh001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh001
            #add-point:ON ACTION controlp INFIELD ineh001 name="construct.c.page1.ineh001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_rtdx001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ineh001  #顯示到畫面上

            NEXT FIELD ineh001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh001
            #add-point:BEFORE FIELD ineh001 name="construct.b.page1.ineh001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh001
            
            #add-point:AFTER FIELD ineh001 name="construct.a.page1.ineh001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh003
            #add-point:BEFORE FIELD ineh003 name="construct.b.page1.ineh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh003
            
            #add-point:AFTER FIELD ineh003 name="construct.a.page1.ineh003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ineh003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh003
            #add-point:ON ACTION controlp INFIELD ineh003 name="construct.c.page1.ineh003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh003_desc
            #add-point:BEFORE FIELD ineh003_desc name="construct.b.page1.ineh003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh003_desc
            
            #add-point:AFTER FIELD ineh003_desc name="construct.a.page1.ineh003_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ineh003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh003_desc
            #add-point:ON ACTION controlp INFIELD ineh003_desc name="construct.c.page1.ineh003_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh002
            #add-point:BEFORE FIELD ineh002 name="construct.b.page1.ineh002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh002
            
            #add-point:AFTER FIELD ineh002 name="construct.a.page1.ineh002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ineh002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh002
            #add-point:ON ACTION controlp INFIELD ineh002 name="construct.c.page1.ineh002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.ineh004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh004
            #add-point:ON ACTION controlp INFIELD ineh004 name="construct.c.page1.ineh004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_inaa001_12()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ineh004  #顯示到畫面上

            NEXT FIELD ineh004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh004
            #add-point:BEFORE FIELD ineh004 name="construct.b.page1.ineh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh004
            
            #add-point:AFTER FIELD ineh004 name="construct.a.page1.ineh004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ineh005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh005
            #add-point:ON ACTION controlp INFIELD ineh005 name="construct.c.page1.ineh005"
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_inab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ineh005  #顯示到畫面上

            NEXT FIELD ineh005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh005
            #add-point:BEFORE FIELD ineh005 name="construct.b.page1.ineh005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh005
            
            #add-point:AFTER FIELD ineh005 name="construct.a.page1.ineh005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh006
            #add-point:BEFORE FIELD ineh006 name="construct.b.page1.ineh006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh006
            
            #add-point:AFTER FIELD ineh006 name="construct.a.page1.ineh006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ineh006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh006
            #add-point:ON ACTION controlp INFIELD ineh006 name="construct.c.page1.ineh006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.ineh008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh008
            #add-point:ON ACTION controlp INFIELD ineh008 name="construct.c.page1.ineh008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ineh008  #顯示到畫面上
            NEXT FIELD ineh008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh008
            #add-point:BEFORE FIELD ineh008 name="construct.b.page1.ineh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh008
            
            #add-point:AFTER FIELD ineh008 name="construct.a.page1.ineh008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amount
            #add-point:BEFORE FIELD amount name="construct.b.page1.amount"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amount
            
            #add-point:AFTER FIELD amount name="construct.a.page1.amount"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.amount
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amount
            #add-point:ON ACTION controlp INFIELD amount name="construct.c.page1.amount"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh009
            #add-point:BEFORE FIELD ineh009 name="construct.b.page1.ineh009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh009
            
            #add-point:AFTER FIELD ineh009 name="construct.a.page1.ineh009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ineh009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh009
            #add-point:ON ACTION controlp INFIELD ineh009 name="construct.c.page1.ineh009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh016
            #add-point:BEFORE FIELD ineh016 name="construct.b.page1.ineh016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh016
            
            #add-point:AFTER FIELD ineh016 name="construct.a.page1.ineh016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ineh016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh016
            #add-point:ON ACTION controlp INFIELD ineh016 name="construct.c.page1.ineh016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh017
            #add-point:BEFORE FIELD ineh017 name="construct.b.page1.ineh017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh017
            
            #add-point:AFTER FIELD ineh017 name="construct.a.page1.ineh017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ineh017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh017
            #add-point:ON ACTION controlp INFIELD ineh017 name="construct.c.page1.ineh017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh019
            #add-point:BEFORE FIELD ineh019 name="construct.b.page1.ineh019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh019
            
            #add-point:AFTER FIELD ineh019 name="construct.a.page1.ineh019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ineh019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh019
            #add-point:ON ACTION controlp INFIELD ineh019 name="construct.c.page1.ineh019"
            
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
                  WHEN la_wc[li_idx].tableid = "ineg_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "ineh_t" 
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
   LET g_wc=g_wc CLIPPED," AND ineg001='1' "
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aint805.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aint805_filter()
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
      CONSTRUCT g_wc_filter ON inegsite,inegdocdt,inegdocno,ineg002,ineg003,ineg004,ineg005
                          FROM s_browse[1].b_inegsite,s_browse[1].b_inegdocdt,s_browse[1].b_inegdocno, 
                              s_browse[1].b_ineg002,s_browse[1].b_ineg003,s_browse[1].b_ineg004,s_browse[1].b_ineg005 
 
 
         BEFORE CONSTRUCT
               DISPLAY aint805_filter_parser('inegsite') TO s_browse[1].b_inegsite
            DISPLAY aint805_filter_parser('inegdocdt') TO s_browse[1].b_inegdocdt
            DISPLAY aint805_filter_parser('inegdocno') TO s_browse[1].b_inegdocno
            DISPLAY aint805_filter_parser('ineg002') TO s_browse[1].b_ineg002
            DISPLAY aint805_filter_parser('ineg003') TO s_browse[1].b_ineg003
            DISPLAY aint805_filter_parser('ineg004') TO s_browse[1].b_ineg004
            DISPLAY aint805_filter_parser('ineg005') TO s_browse[1].b_ineg005
      
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
 
      CALL aint805_filter_show('inegsite')
   CALL aint805_filter_show('inegdocdt')
   CALL aint805_filter_show('inegdocno')
   CALL aint805_filter_show('ineg002')
   CALL aint805_filter_show('ineg003')
   CALL aint805_filter_show('ineg004')
   CALL aint805_filter_show('ineg005')
 
END FUNCTION
 
{</section>}
 
{<section id="aint805.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aint805_filter_parser(ps_field)
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
 
{<section id="aint805.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aint805_filter_show(ps_field)
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
   LET ls_condition = aint805_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aint805.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aint805_query()
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
   CALL g_ineh_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aint805_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aint805_browser_fill("")
      CALL aint805_fetch("")
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
      CALL aint805_filter_show('inegsite')
   CALL aint805_filter_show('inegdocdt')
   CALL aint805_filter_show('inegdocno')
   CALL aint805_filter_show('ineg002')
   CALL aint805_filter_show('ineg003')
   CALL aint805_filter_show('ineg004')
   CALL aint805_filter_show('ineg005')
   CALL aint805_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aint805_fetch("F") 
      #顯示單身筆數
      CALL aint805_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aint805.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aint805_fetch(p_flag)
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
   
   LET g_ineg_m.inegsite = g_browser[g_current_idx].b_inegsite
   LET g_ineg_m.inegdocno = g_browser[g_current_idx].b_inegdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aint805_master_referesh USING g_ineg_m.inegsite,g_ineg_m.inegdocno INTO g_ineg_m.inegsite, 
       g_ineg_m.inegdocdt,g_ineg_m.inegdocno,g_ineg_m.ineg002,g_ineg_m.ineg004,g_ineg_m.ineg005,g_ineg_m.ineg003, 
       g_ineg_m.ineg006,g_ineg_m.ineg007,g_ineg_m.ineg008,g_ineg_m.ineg010,g_ineg_m.ineg011,g_ineg_m.ineg001, 
       g_ineg_m.inegunit,g_ineg_m.inegstus,g_ineg_m.inegownid,g_ineg_m.inegcrtdp,g_ineg_m.inegowndp, 
       g_ineg_m.inegcrtdt,g_ineg_m.inegcrtid,g_ineg_m.inegmodid,g_ineg_m.inegcnfdt,g_ineg_m.inegmoddt, 
       g_ineg_m.inegpstid,g_ineg_m.inegcnfid,g_ineg_m.inegpstdt,g_ineg_m.inegsite_desc,g_ineg_m.ineg002_desc, 
       g_ineg_m.ineg004_desc,g_ineg_m.ineg005_desc,g_ineg_m.ineg006_desc,g_ineg_m.ineg007_desc,g_ineg_m.ineg008_desc, 
       g_ineg_m.inegownid_desc,g_ineg_m.inegcrtdp_desc,g_ineg_m.inegowndp_desc,g_ineg_m.inegcrtid_desc, 
       g_ineg_m.inegmodid_desc,g_ineg_m.inegpstid_desc,g_ineg_m.inegcnfid_desc
   
   #遮罩相關處理
   LET g_ineg_m_mask_o.* =  g_ineg_m.*
   CALL aint805_ineg_t_mask()
   LET g_ineg_m_mask_n.* =  g_ineg_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint805_set_act_visible()   
   CALL aint805_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("modify,modify_detail,delete",TRUE)
   IF g_ineg_m.inegstus != 'N' THEN
      CALL cl_set_act_visible("modify,modify_detail,delete",FALSE)
   END IF

   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_ineg_m_t.* = g_ineg_m.*
   LET g_ineg_m_o.* = g_ineg_m.*
   
   LET g_data_owner = g_ineg_m.inegownid      
   LET g_data_dept  = g_ineg_m.inegowndp
   
   #重新顯示   
   CALL aint805_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aint805.insert" >}
#+ 資料新增
PRIVATE FUNCTION aint805_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
DEFINE r_insert       LIKE type_t.num5
DEFINE r_success     LIKE type_t.num5
DEFINE r_doctype     LIKE rtai_t.rtai004
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_ineh_d.clear()   
 
 
   INITIALIZE g_ineg_m.* TO NULL             #DEFAULT 設定
   
   LET g_inegsite_t = NULL
   LET g_inegdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_ineg_m.inegownid = g_user
      LET g_ineg_m.inegowndp = g_dept
      LET g_ineg_m.inegcrtid = g_user
      LET g_ineg_m.inegcrtdp = g_dept 
      LET g_ineg_m.inegcrtdt = cl_get_current()
      LET g_ineg_m.inegmodid = g_user
      LET g_ineg_m.inegmoddt = cl_get_current()
      LET g_ineg_m.inegstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_ineg_m.ineg010 = "1"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_ineg_m.inegcnfid = ""
      LET g_ineg_m.inegcnfdt = ""   
      LET g_ineg_m.inegpstid = ""
      LET g_ineg_m.inegpstdt = ""       
      LET g_ineg_m.inegstus = "N"
#      LET g_ineg_m.inegsite=g_site
      LET r_insert=TRUE
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'inegsite',g_ineg_m.inegsite) RETURNING r_insert,g_ineg_m.inegsite
      IF NOT r_insert THEN
         RETURN 
      END IF     
      
      ##預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_ineg_m.inegsite,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_ineg_m.inegdocno = r_doctype    
      
      LET g_ineg_m.ineg001='1'
      SELECT ooefl003 INTO g_ineg_m.inegsite_desc 
        FROM ooefl_t
       WHERE ooeflent=g_enterprise
         AND ooefl001=g_ineg_m.inegsite
         AND ooefl002=g_lang      
      LET g_ineg_m.inegdocdt=g_today
      LET g_ineg_m.ineg003=g_today
      LET g_ineg_m.ineg004=g_user     
      SELECT ooag003 INTO g_ineg_m.ineg005
        FROM ooag_t
       WHERE ooagent=g_enterprise
         AND ooag001=g_ineg_m.ineg004
      SELECT oofa011 INTO g_ineg_m.ineg004_desc
        FROM oofa_t
       WHERE oofa002='2'
         AND oofa003=g_ineg_m.ineg004
         AND oofaent = g_enterprise #add by geza 20160905 #160905-00007#5          
      SELECT ooefl003 INTO g_ineg_m.ineg005_desc
        FROM ooefl_t
       WHERE ooeflent=g_enterprise
         AND ooefl001=g_ineg_m.ineg005
         AND ooefl002=g_lang    
         
      LET g_ineg_m.ineg006=g_user   
      SELECT ooag003 INTO g_ineg_m.ineg007
        FROM ooag_t
       WHERE ooagent=g_enterprise
         AND ooag001=g_ineg_m.ineg006  
      SELECT oofa011 INTO g_ineg_m.ineg006_desc
        FROM oofa_t
       WHERE oofa002='2'
         AND oofa003=g_ineg_m.ineg006
         AND oofaent = g_enterprise #add by geza 20160905 #160905-00007#5          
      SELECT ooefl003 INTO g_ineg_m.ineg007_desc
        FROM ooefl_t
       WHERE ooeflent=g_enterprise
         AND ooefl001=g_ineg_m.ineg007
         AND ooefl002=g_lang       
         
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_ineg_m.inegownid
        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
        LET g_ineg_m.inegownid_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_ineg_m.inegownid_desc

        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_ineg_m.inegcrtdp
        CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_ineg_m.inegcrtdp_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_ineg_m.inegcrtdp_desc

        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_ineg_m.inegcrtid
        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
        LET g_ineg_m.inegcrtid_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_ineg_m.inegcrtid_desc

        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_ineg_m.inegowndp
        CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_ineg_m.inegowndp_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_ineg_m.inegowndp_desc

        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_ineg_m.inegmodid
        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
        LET g_ineg_m.inegmodid_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_ineg_m.inegmodid_desc

        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_ineg_m.inegcnfid
        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
        LET g_ineg_m.inegcnfid_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_ineg_m.inegcnfid_desc
        
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_ineg_m.inegpstid
        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
        LET g_ineg_m.inegpstid_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_ineg_m.inegpstid_desc          
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_ineg_m_t.* = g_ineg_m.*
      LET g_ineg_m_o.* = g_ineg_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_ineg_m.inegstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
 
 
 
    
      CALL aint805_input("a")
      
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
         INITIALIZE g_ineg_m.* TO NULL
         INITIALIZE g_ineh_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aint805_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_ineh_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint805_set_act_visible()   
   CALL aint805_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_inegsite_t = g_ineg_m.inegsite
   LET g_inegdocno_t = g_ineg_m.inegdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " inegent = " ||g_enterprise|| " AND",
                      " inegsite = '", g_ineg_m.inegsite, "' "
                      ," AND inegdocno = '", g_ineg_m.inegdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint805_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aint805_cl
   
   CALL aint805_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aint805_master_referesh USING g_ineg_m.inegsite,g_ineg_m.inegdocno INTO g_ineg_m.inegsite, 
       g_ineg_m.inegdocdt,g_ineg_m.inegdocno,g_ineg_m.ineg002,g_ineg_m.ineg004,g_ineg_m.ineg005,g_ineg_m.ineg003, 
       g_ineg_m.ineg006,g_ineg_m.ineg007,g_ineg_m.ineg008,g_ineg_m.ineg010,g_ineg_m.ineg011,g_ineg_m.ineg001, 
       g_ineg_m.inegunit,g_ineg_m.inegstus,g_ineg_m.inegownid,g_ineg_m.inegcrtdp,g_ineg_m.inegowndp, 
       g_ineg_m.inegcrtdt,g_ineg_m.inegcrtid,g_ineg_m.inegmodid,g_ineg_m.inegcnfdt,g_ineg_m.inegmoddt, 
       g_ineg_m.inegpstid,g_ineg_m.inegcnfid,g_ineg_m.inegpstdt,g_ineg_m.inegsite_desc,g_ineg_m.ineg002_desc, 
       g_ineg_m.ineg004_desc,g_ineg_m.ineg005_desc,g_ineg_m.ineg006_desc,g_ineg_m.ineg007_desc,g_ineg_m.ineg008_desc, 
       g_ineg_m.inegownid_desc,g_ineg_m.inegcrtdp_desc,g_ineg_m.inegowndp_desc,g_ineg_m.inegcrtid_desc, 
       g_ineg_m.inegmodid_desc,g_ineg_m.inegpstid_desc,g_ineg_m.inegcnfid_desc
   
   
   #遮罩相關處理
   LET g_ineg_m_mask_o.* =  g_ineg_m.*
   CALL aint805_ineg_t_mask()
   LET g_ineg_m_mask_n.* =  g_ineg_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_ineg_m.inegsite,g_ineg_m.inegsite_desc,g_ineg_m.inegdocdt,g_ineg_m.inegdocno,g_ineg_m.ineg002, 
       g_ineg_m.ineg002_desc,g_ineg_m.ineg004,g_ineg_m.ineg004_desc,g_ineg_m.ineg005,g_ineg_m.ineg005_desc, 
       g_ineg_m.ineg003,g_ineg_m.ineg006,g_ineg_m.ineg006_desc,g_ineg_m.ineg007,g_ineg_m.ineg007_desc, 
       g_ineg_m.ineg008,g_ineg_m.ineg008_desc,g_ineg_m.ineg010,g_ineg_m.ineg011,g_ineg_m.ineg001,g_ineg_m.inegunit, 
       g_ineg_m.inegstus,g_ineg_m.inegownid,g_ineg_m.inegownid_desc,g_ineg_m.inegcrtdp,g_ineg_m.inegcrtdp_desc, 
       g_ineg_m.inegowndp,g_ineg_m.inegowndp_desc,g_ineg_m.inegcrtdt,g_ineg_m.inegcrtid,g_ineg_m.inegcrtid_desc, 
       g_ineg_m.inegmodid,g_ineg_m.inegmodid_desc,g_ineg_m.inegcnfdt,g_ineg_m.inegmoddt,g_ineg_m.inegpstid, 
       g_ineg_m.inegpstid_desc,g_ineg_m.inegcnfid,g_ineg_m.inegcnfid_desc,g_ineg_m.inegpstdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_ineg_m.inegownid      
   LET g_data_dept  = g_ineg_m.inegowndp
   
   #功能已完成,通報訊息中心
   CALL aint805_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aint805.modify" >}
#+ 資料修改
PRIVATE FUNCTION aint805_modify()
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
   LET g_ineg_m_t.* = g_ineg_m.*
   LET g_ineg_m_o.* = g_ineg_m.*
   
   IF g_ineg_m.inegsite IS NULL
   OR g_ineg_m.inegdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_inegsite_t = g_ineg_m.inegsite
   LET g_inegdocno_t = g_ineg_m.inegdocno
 
   CALL s_transaction_begin()
   
   OPEN aint805_cl USING g_enterprise,g_ineg_m.inegsite,g_ineg_m.inegdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint805_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint805_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint805_master_referesh USING g_ineg_m.inegsite,g_ineg_m.inegdocno INTO g_ineg_m.inegsite, 
       g_ineg_m.inegdocdt,g_ineg_m.inegdocno,g_ineg_m.ineg002,g_ineg_m.ineg004,g_ineg_m.ineg005,g_ineg_m.ineg003, 
       g_ineg_m.ineg006,g_ineg_m.ineg007,g_ineg_m.ineg008,g_ineg_m.ineg010,g_ineg_m.ineg011,g_ineg_m.ineg001, 
       g_ineg_m.inegunit,g_ineg_m.inegstus,g_ineg_m.inegownid,g_ineg_m.inegcrtdp,g_ineg_m.inegowndp, 
       g_ineg_m.inegcrtdt,g_ineg_m.inegcrtid,g_ineg_m.inegmodid,g_ineg_m.inegcnfdt,g_ineg_m.inegmoddt, 
       g_ineg_m.inegpstid,g_ineg_m.inegcnfid,g_ineg_m.inegpstdt,g_ineg_m.inegsite_desc,g_ineg_m.ineg002_desc, 
       g_ineg_m.ineg004_desc,g_ineg_m.ineg005_desc,g_ineg_m.ineg006_desc,g_ineg_m.ineg007_desc,g_ineg_m.ineg008_desc, 
       g_ineg_m.inegownid_desc,g_ineg_m.inegcrtdp_desc,g_ineg_m.inegowndp_desc,g_ineg_m.inegcrtid_desc, 
       g_ineg_m.inegmodid_desc,g_ineg_m.inegpstid_desc,g_ineg_m.inegcnfid_desc
   
   #檢查是否允許此動作
   IF NOT aint805_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_ineg_m_mask_o.* =  g_ineg_m.*
   CALL aint805_ineg_t_mask()
   LET g_ineg_m_mask_n.* =  g_ineg_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   IF NOT aint805_check(g_ineg_m.ineg002,g_ineg_m.inegsite) THEN
      CLOSE aint805_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aint805_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_inegsite_t = g_ineg_m.inegsite
      LET g_inegdocno_t = g_ineg_m.inegdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_ineg_m.inegmodid = g_user 
LET g_ineg_m.inegmoddt = cl_get_current()
LET g_ineg_m.inegmodid_desc = cl_get_username(g_ineg_m.inegmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aint805_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE ineg_t SET (inegmodid,inegmoddt) = (g_ineg_m.inegmodid,g_ineg_m.inegmoddt)
          WHERE inegent = g_enterprise AND inegsite = g_inegsite_t
            AND inegdocno = g_inegdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_ineg_m.* = g_ineg_m_t.*
            CALL aint805_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_ineg_m.inegsite != g_ineg_m_t.inegsite
      OR g_ineg_m.inegdocno != g_ineg_m_t.inegdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE ineh_t SET inehsite = g_ineg_m.inegsite
                                       ,inehdocno = g_ineg_m.inegdocno
 
          WHERE inehent = g_enterprise AND inehsite = g_ineg_m_t.inegsite
            AND inehdocno = g_ineg_m_t.inegdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "ineh_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "ineh_t:",SQLERRMESSAGE 
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
   CALL aint805_set_act_visible()   
   CALL aint805_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " inegent = " ||g_enterprise|| " AND",
                      " inegsite = '", g_ineg_m.inegsite, "' "
                      ," AND inegdocno = '", g_ineg_m.inegdocno, "' "
 
   #填到對應位置
   CALL aint805_browser_fill("")
 
   CLOSE aint805_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint805_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aint805.input" >}
#+ 資料輸入
PRIVATE FUNCTION aint805_input(p_cmd)
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
   DEFINE  l_ined003             LIKE ined_t.ined003
   DEFINE  l_ined004             LIKE ined_t.ined004
   DEFINE  l_ined005             LIKE ined_t.ined005
   DEFINE  l_gzcbl004            LIKE gzcbl_t.gzcbl004
   DEFINE  l_gzze003             LIKE gzze_t.gzze003
   DEFINE  l_str                 LIKE type_t.chr500
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_success             LIKE type_t.chr1
   DEFINE  l_amount              LIKE type_t.num5
   DEFINE  l_errno               STRING
   DEFINE  l_sql1                STRING     #160711-00040#15 add
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
   DISPLAY BY NAME g_ineg_m.inegsite,g_ineg_m.inegsite_desc,g_ineg_m.inegdocdt,g_ineg_m.inegdocno,g_ineg_m.ineg002, 
       g_ineg_m.ineg002_desc,g_ineg_m.ineg004,g_ineg_m.ineg004_desc,g_ineg_m.ineg005,g_ineg_m.ineg005_desc, 
       g_ineg_m.ineg003,g_ineg_m.ineg006,g_ineg_m.ineg006_desc,g_ineg_m.ineg007,g_ineg_m.ineg007_desc, 
       g_ineg_m.ineg008,g_ineg_m.ineg008_desc,g_ineg_m.ineg010,g_ineg_m.ineg011,g_ineg_m.ineg001,g_ineg_m.inegunit, 
       g_ineg_m.inegstus,g_ineg_m.inegownid,g_ineg_m.inegownid_desc,g_ineg_m.inegcrtdp,g_ineg_m.inegcrtdp_desc, 
       g_ineg_m.inegowndp,g_ineg_m.inegowndp_desc,g_ineg_m.inegcrtdt,g_ineg_m.inegcrtid,g_ineg_m.inegcrtid_desc, 
       g_ineg_m.inegmodid,g_ineg_m.inegmodid_desc,g_ineg_m.inegcnfdt,g_ineg_m.inegmoddt,g_ineg_m.inegpstid, 
       g_ineg_m.inegpstid_desc,g_ineg_m.inegcnfid,g_ineg_m.inegcnfid_desc,g_ineg_m.inegpstdt
   
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
   LET g_forupd_sql = "SELECT inehseq,ineh001,ineh003,ineh002,ineh004,ineh005,ineh006,ineh007,ineh008, 
       ineh010,ineh011,ineh012,ineh013,ineh014,ineh009,ineh015,ineh016,ineh017,ineh018,ineh019,inehunit  
       FROM ineh_t WHERE inehent=? AND inehsite=? AND inehdocno=? AND inehseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint805_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aint805_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aint805_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_ineg_m.inegsite,g_ineg_m.inegdocdt,g_ineg_m.inegdocno,g_ineg_m.ineg002,g_ineg_m.ineg004, 
       g_ineg_m.ineg005,g_ineg_m.ineg006,g_ineg_m.ineg007,g_ineg_m.ineg008,g_ineg_m.ineg010,g_ineg_m.ineg011, 
       g_ineg_m.ineg001,g_ineg_m.inegunit,g_ineg_m.inegstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   DISPLAY BY NAME g_ineg_m.inegsite_desc,g_ineg_m.ineg002_desc,g_ineg_m.ineg004_desc,g_ineg_m.ineg005_desc,
                   g_ineg_m.ineg006_desc,g_ineg_m.ineg007_desc,g_ineg_m.inegownid,g_ineg_m.inegownid_desc, 
                   g_ineg_m.inegcrtdp,g_ineg_m.inegcrtdp_desc,g_ineg_m.inegowndp,g_ineg_m.inegowndp_desc,g_ineg_m.inegcrtdt, 
                   g_ineg_m.inegcrtid,g_ineg_m.inegcrtid_desc,g_ineg_m.inegmodid,g_ineg_m.inegmodid_desc,g_ineg_m.inegcnfdt, 
                   g_ineg_m.inegmoddt,g_ineg_m.inegpstid,g_ineg_m.inegpstid_desc,g_ineg_m.inegcnfid,g_ineg_m.inegcnfid_desc, 
                   g_ineg_m.inegpstdt
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aint805.input.head" >}
      #單頭段
      INPUT BY NAME g_ineg_m.inegsite,g_ineg_m.inegdocdt,g_ineg_m.inegdocno,g_ineg_m.ineg002,g_ineg_m.ineg004, 
          g_ineg_m.ineg005,g_ineg_m.ineg006,g_ineg_m.ineg007,g_ineg_m.ineg008,g_ineg_m.ineg010,g_ineg_m.ineg011, 
          g_ineg_m.ineg001,g_ineg_m.inegunit,g_ineg_m.inegstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aint805_cl USING g_enterprise,g_ineg_m.inegsite,g_ineg_m.inegdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint805_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint805_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aint805_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL aint805_set_entry(p_cmd)
            CALL aint805_set_no_entry(p_cmd)
            #end add-point
            CALL aint805_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inegsite
            
            #add-point:AFTER FIELD inegsite name="input.a.inegsite"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ineg_m.inegsite) AND NOT cl_null(g_ineg_m.inegdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_ineg_m.inegsite != g_inegsite_t  OR g_ineg_m.inegdocno != g_inegdocno_t )) THEN 
                  CALL s_aooi500_chk(g_prog,'inegsite',g_ineg_m.inegsite,g_ineg_m.inegsite)
                   RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_ineg_m.inegsite
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     
                     LET g_ineg_m.inegsite = g_inegsite_t
                     NEXT FIELD CURRENT
                  END IF
                  LET g_site_flag = TRUE
                  CALL aint805_set_entry(p_cmd)
                  CALL aint805_set_no_entry(p_cmd)                  
               END IF
            END IF

           
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg_m.inegsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ineg_m.inegsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg_m.inegsite_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegsite
            #add-point:BEFORE FIELD inegsite name="input.b.inegsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inegsite
            #add-point:ON CHANGE inegsite name="input.g.inegsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegdocdt
            #add-point:BEFORE FIELD inegdocdt name="input.b.inegdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inegdocdt
            
            #add-point:AFTER FIELD inegdocdt name="input.a.inegdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inegdocdt
            #add-point:ON CHANGE inegdocdt name="input.g.inegdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegdocno
            #add-point:BEFORE FIELD inegdocno name="input.b.inegdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inegdocno
            
            #add-point:AFTER FIELD inegdocno name="input.a.inegdocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ineg_m.inegsite) AND NOT cl_null(g_ineg_m.inegdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_ineg_m.inegsite != g_inegsite_t OR g_ineg_m.inegdocno != g_inegdocno_t )) THEN 
                  IF NOT s_aooi200_chk_slip(g_site,'',g_ineg_m.inegdocno,g_prog) THEN
                     LET g_ineg_m.inegdocno =  g_ineg_m_t.inegdocno                    
                     NEXT FIELD CURRENT
                  END IF 
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inegdocno
            #add-point:ON CHANGE inegdocno name="input.g.inegdocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineg002
            
            #add-point:AFTER FIELD ineg002 name="input.a.ineg002"
            IF NOT cl_null(g_ineg_m.ineg002) THEN
              #IF p_cmd = 'a' OR ( p_cmd = 'u' AND g_ineg_m.ineg002 != g_ineg_m_t.ineg002) THEN   #160824-00007#292 20170109 mark by beckxie
              IF g_ineg_m.ineg002 != g_ineg_m_o.ineg002 OR cl_null(g_ineg_m_o.ineg002) THEN   #160824-00007#292 20170109 add by beckxie
                 INITIALIZE g_chkparam.* TO NULL
		      
                    #設定g_chkparam.*的參數
                 LET g_chkparam.arg1 = g_ineg_m.ineg002
              
                 IF NOT cl_chk_exist("v_ineadocno") THEN
                   #LET g_ineg_m.ineg002 =  g_ineg_m_t.ineg002  #160824-00007#292 20170109 mark by beckxie
                   #160824-00007#292 20170109 add by beckxie---S
                   LET g_ineg_m.ineg002 = g_ineg_m_o.ineg002    
                   LET g_ineg_m.ineg002_desc = g_ineg_m_o.ineg002_desc
                   LET g_ineg_m.ineg003 = g_ineg_m_o.ineg003    
                   #160824-00007#292 20170109 add by beckxie---E
                   NEXT FIELD CURRENT
                 END IF
                 
                 IF NOT aint805_check(g_ineg_m.ineg002,g_ineg_m.inegsite) THEN
                   #LET g_ineg_m.ineg002 =  g_ineg_m_t.ineg002  #160824-00007#292 20170109 mark by beckxie
                   #160824-00007#292 20170109 add by beckxie---S
                   LET g_ineg_m.ineg002 = g_ineg_m_o.ineg002    
                   LET g_ineg_m.ineg002_desc = g_ineg_m_o.ineg002_desc
                   LET g_ineg_m.ineg003 = g_ineg_m_o.ineg003    
                   #160824-00007#292 20170109 add by beckxie---E
                   NEXT FIELD CURRENT
                 END IF                  
                     
              END IF
             
            END IF  
             SELECT inea002 INTO g_ineg_m.ineg003
              FROM inea_t
             WHERE ineaent=g_enterprise
               AND ineadocno=g_ineg_m.ineg002
            DISPLAY BY NAME g_ineg_m.ineg003   
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg_m.ineg002
            CALL ap_ref_array2(g_ref_fields,"SELECT inea001 FROM inea_t WHERE ineaent='"||g_enterprise||"' AND ineadocno=? ","") RETURNING g_rtn_fields
            LET g_ineg_m.ineg002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg_m.ineg002_desc
            
            LET g_ineg_m_o.* = g_ineg_m.* #160824-00007#292 20170109 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineg002
            #add-point:BEFORE FIELD ineg002 name="input.b.ineg002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ineg002
            #add-point:ON CHANGE ineg002 name="input.g.ineg002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineg004
            
            #add-point:AFTER FIELD ineg004 name="input.a.ineg004"
           IF NOT cl_null(g_ineg_m.ineg004) THEN 
              #IF p_cmd = 'a' OR ( p_cmd = 'u' AND g_ineg_m.ineg004 != g_ineg_m_t.ineg004) THEN   #160824-00007#292 20170109 mark by beckxie
              IF g_ineg_m.ineg004 != g_ineg_m_o.ineg004 OR cl_null(g_ineg_m_o.ineg004) THEN   #160824-00007#292 20170109 add by beckxie
                 INITIALIZE g_chkparam.* TO NULL
		      
                      #設定g_chkparam.*的參數
                   LET g_chkparam.arg1 = g_ineg_m.ineg004
                   #160318-00025#20  by 07900 --add-str
                   LET g_errshow = TRUE #是否開窗                   
                   LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                   #160318-00025#20  by 07900 --add-end
                   IF NOT cl_chk_exist("v_ooag001") THEN
                     #LET g_ineg_m.ineg004 =  g_ineg_m_t.ineg004   #160824-00007#292 20170109 mark by beckxie
                     #160824-00007#292 20170109 add by beckxie---S
                     LET g_ineg_m.ineg004 =  g_ineg_m_o.ineg004   
                     LET g_ineg_m.ineg004_desc =  g_ineg_m_o.ineg004_desc   
                     LET g_ineg_m.ineg005 =  g_ineg_m_o.ineg005   
                     LET g_ineg_m.ineg005_desc =  g_ineg_m_o.ineg005_desc
                     #160824-00007#292 20170109 add by beckxie---E
                     NEXT FIELD CURRENT
                   END IF                              
		      
                END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg_m.ineg004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_ineg_m.ineg004_desc = '', g_rtn_fields[1] , ''
            SELECT ooag003 INTO g_ineg_m.ineg005
              FROM ooag_t
             WHERE ooagent=g_enterprise
               AND ooag001=g_ineg_m.ineg004 
            SELECT ooefl003 INTO g_ineg_m.ineg005_desc
              FROM ooefl_t
             WHERE ooeflent=g_enterprise
               AND ooefl001=g_ineg_m.ineg005
               AND ooefl002=g_lang 
            DISPLAY BY NAME g_ineg_m.ineg004_desc
            DISPLAY BY NAME g_ineg_m.ineg005
            DISPLAY BY NAME g_ineg_m.ineg005_desc  
            
            LET g_ineg_m_o.* = g_ineg_m.* #160824-00007#292 20170109 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineg004
            #add-point:BEFORE FIELD ineg004 name="input.b.ineg004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ineg004
            #add-point:ON CHANGE ineg004 name="input.g.ineg004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineg005
            
            #add-point:AFTER FIELD ineg005 name="input.a.ineg005"
            IF NOT cl_null(g_ineg_m.ineg005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND g_ineg_m.ineg005 != g_ineg_m_t.ineg005) THEN
                  INITIALIZE g_chkparam.* TO NULL
		       
               #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_ineg_m.ineg005
                  LET g_chkparam.arg2 = g_ineg_m.inegdocdt
		            #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#19  by 07900 --add-end
                     #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_ineg_m.ineg005 = g_ineg_m_t.ineg005
                     NEXT FIELD CURRENT
                  END IF
		       
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg_m.ineg005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ineg_m.ineg005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg_m.ineg005_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineg005
            #add-point:BEFORE FIELD ineg005 name="input.b.ineg005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ineg005
            #add-point:ON CHANGE ineg005 name="input.g.ineg005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineg006
            
            #add-point:AFTER FIELD ineg006 name="input.a.ineg006"
            IF NOT cl_null(g_ineg_m.ineg006) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND g_ineg_m.ineg006 != g_ineg_m_t.ineg006) THEN   #160824-00007#292 20170109 mark by beckxie
               IF g_ineg_m.ineg006 != g_ineg_m_o.ineg006 OR cl_null(g_ineg_m_o.ineg006) THEN   #160824-00007#292 20170109 add by beckxie
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_ineg_m.ineg006
                  
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     #LET g_ineg_m.ineg006 =  g_ineg_m_t.ineg006   #160824-00007#292 20170109 mark by beckxie
                     #160824-00007#292 20170109 add by beckxie---S
                     LET g_ineg_m.ineg006 =  g_ineg_m_o.ineg006
                     LET g_ineg_m.ineg006_desc =  g_ineg_m_o.ineg006_desc
                     LET g_ineg_m.ineg007 =  g_ineg_m_o.ineg007
                     LET g_ineg_m.ineg007_desc =  g_ineg_m_o.ineg007_desc
                     #160824-00007#292 20170109 add by beckxie---E
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF 
            END IF    
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg_m.ineg006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_ineg_m.ineg006_desc = '', g_rtn_fields[1] , ''
            
            SELECT ooag003 INTO g_ineg_m.ineg007
              FROM ooag_t
             WHERE ooagent=g_enterprise
               AND ooag001=g_ineg_m.ineg006  
            SELECT ooefl003 INTO g_ineg_m.ineg007_desc
              FROM ooefl_t
             WHERE ooeflent=g_enterprise
               AND ooefl001=g_ineg_m.ineg007
               AND ooefl002=g_lang 
             DISPLAY BY NAME g_ineg_m.ineg006_desc
             DISPLAY BY NAME g_ineg_m.ineg007
             DISPLAY BY NAME g_ineg_m.ineg007_desc             
            LET g_ineg_m_o.* = g_ineg_m.*   #160824-00007#292 20170109 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineg006
            #add-point:BEFORE FIELD ineg006 name="input.b.ineg006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ineg006
            #add-point:ON CHANGE ineg006 name="input.g.ineg006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineg007
            
            #add-point:AFTER FIELD ineg007 name="input.a.ineg007"
           IF NOT cl_null(g_ineg_m.ineg007) THEN
              IF p_cmd = 'a' OR ( p_cmd = 'u' AND g_ineg_m.ineg007 != g_ineg_m_t.ineg007) THEN           
                 INITIALIZE g_chkparam.* TO NULL
		         
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_ineg_m.ineg007
                  LET g_chkparam.arg2 = g_ineg_m.inegdocdt
		            #160318-00025#19  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#19  by 07900 --add-end
                        #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_ineg_m.ineg007 = g_ineg_m_t.ineg007
                     NEXT FIELD CURRENT
                  END IF
               		      
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg_m.ineg007
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ineg_m.ineg007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg_m.ineg007_desc            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineg007
            #add-point:BEFORE FIELD ineg007 name="input.b.ineg007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ineg007
            #add-point:ON CHANGE ineg007 name="input.g.ineg007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineg008
            
            #add-point:AFTER FIELD ineg008 name="input.a.ineg008"
           IF NOT cl_null(g_ineg_m.ineg008) THEN
              IF p_cmd = 'a' OR ( p_cmd = 'u' AND g_ineg_m.ineg008 != g_ineg_m_t.ineg008) THEN           
                 INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_ineg_m.ineg008
		            #160318-00025#20  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#20  by 07900 --add-end 
                        #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_inaa001_2") THEN
                     LET g_ineg_m.ineg008 = g_ineg_m_t.ineg008
                     NEXT FIELD CURRENT
                  END IF
               		      
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg_m.ineg008
            CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ineg_m.ineg008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg_m.ineg008_desc  



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineg008
            #add-point:BEFORE FIELD ineg008 name="input.b.ineg008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ineg008
            #add-point:ON CHANGE ineg008 name="input.g.ineg008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineg010
            #add-point:BEFORE FIELD ineg010 name="input.b.ineg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineg010
            
            #add-point:AFTER FIELD ineg010 name="input.a.ineg010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ineg010
            #add-point:ON CHANGE ineg010 name="input.g.ineg010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineg011
            #add-point:BEFORE FIELD ineg011 name="input.b.ineg011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineg011
            
            #add-point:AFTER FIELD ineg011 name="input.a.ineg011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ineg011
            #add-point:ON CHANGE ineg011 name="input.g.ineg011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineg001
            #add-point:BEFORE FIELD ineg001 name="input.b.ineg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineg001
            
            #add-point:AFTER FIELD ineg001 name="input.a.ineg001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ineg001
            #add-point:ON CHANGE ineg001 name="input.g.ineg001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegunit
            #add-point:BEFORE FIELD inegunit name="input.b.inegunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inegunit
            
            #add-point:AFTER FIELD inegunit name="input.a.inegunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inegunit
            #add-point:ON CHANGE inegunit name="input.g.inegunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inegstus
            #add-point:BEFORE FIELD inegstus name="input.b.inegstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inegstus
            
            #add-point:AFTER FIELD inegstus name="input.a.inegstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inegstus
            #add-point:ON CHANGE inegstus name="input.g.inegstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.inegsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inegsite
            #add-point:ON ACTION controlp INFIELD inegsite name="input.c.inegsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ineg_m.inegsite             #給予default值

            #給予arg   
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'inegsite',g_ineg_m.inegsite,'i') #150308-00001#3 150309 pomelo add 'i'
            CALL q_ooef001_24()

            LET g_ineg_m.inegsite = g_qryparam.return1              

            DISPLAY g_ineg_m.inegsite TO inegsite              #
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg_m.inegsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ineg_m.inegsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg_m.inegsite_desc
            
            NEXT FIELD inegsite                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.inegdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inegdocdt
            #add-point:ON ACTION controlp INFIELD inegdocdt name="input.c.inegdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.inegdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inegdocno
            #add-point:ON ACTION controlp INFIELD inegdocno name="input.c.inegdocno"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ineg_m.inegdocno             #給予default值

            #給予arg
            LET l_ooef004 = ''            
            SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise            
            LET g_qryparam.arg1 = l_ooef004 #
            LET g_qryparam.arg2 = g_prog #
            #160711-00040#15 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#15 add(e)
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_ineg_m.inegdocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ineg_m.inegdocno TO inegdocno              #顯示到畫面上

            NEXT FIELD inegdocno                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.ineg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineg002
            #add-point:ON ACTION controlp INFIELD ineg002 name="input.c.ineg002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1= g_ineg_m.inegsite

            LET g_qryparam.default1 = g_ineg_m.ineg002             #給予default值

            #給予arg

            CALL q_ineadocno_05()                                #呼叫開窗

            LET g_ineg_m.ineg002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ineg_m.ineg002 TO ineg002              #顯示到畫面上
             SELECT inea002 INTO g_ineg_m.ineg003
              FROM inea_t
             WHERE ineaent=g_enterprise
               AND ineadocno=g_ineg_m.ineg002
            DISPLAY BY NAME g_ineg_m.ineg003   
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg_m.ineg002
            CALL ap_ref_array2(g_ref_fields,"SELECT inea001 FROM inea_t WHERE ineaent='"||g_enterprise||"' AND ineadocno=? ","") RETURNING g_rtn_fields
            LET g_ineg_m.ineg002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg_m.ineg002_desc
            NEXT FIELD ineg002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.ineg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineg004
            #add-point:ON ACTION controlp INFIELD ineg004 name="input.c.ineg004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ineg_m.ineg004             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_ineg_m.ineg004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ineg_m.ineg004 TO ineg004              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg_m.ineg004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_ineg_m.ineg004_desc = '', g_rtn_fields[1] , ''
            SELECT ooag003 INTO g_ineg_m.ineg005
              FROM ooag_t
             WHERE ooagent=g_enterprise
               AND ooag001=g_ineg_m.ineg004 
            SELECT ooefl003 INTO g_ineg_m.ineg005_desc
              FROM ooefl_t
             WHERE ooeflent=g_enterprise
               AND ooefl001=g_ineg_m.ineg005
               AND ooefl002=g_lang 
            DISPLAY BY NAME g_ineg_m.ineg004_desc
            DISPLAY BY NAME g_ineg_m.ineg005
            DISPLAY BY NAME g_ineg_m.ineg005_desc 
            NEXT FIELD ineg004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.ineg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineg005
            #add-point:ON ACTION controlp INFIELD ineg005 name="input.c.ineg005"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ineg_m.ineg005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #

            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_ineg_m.ineg005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ineg_m.ineg005 TO ineg005              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg_m.ineg005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ineg_m.ineg005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg_m.ineg005_desc
            NEXT FIELD ineg005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.ineg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineg006
            #add-point:ON ACTION controlp INFIELD ineg006 name="input.c.ineg006"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ineg_m.ineg006             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_ineg_m.ineg006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ineg_m.ineg006 TO ineg006              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg_m.ineg006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_ineg_m.ineg006_desc = '', g_rtn_fields[1] , ''
            
            SELECT ooag003 INTO g_ineg_m.ineg007
              FROM ooag_t
             WHERE ooagent=g_enterprise
               AND ooag001=g_ineg_m.ineg006  
            SELECT ooefl003 INTO g_ineg_m.ineg007_desc
              FROM ooefl_t
             WHERE ooeflent=g_enterprise
               AND ooefl001=g_ineg_m.ineg007
               AND ooefl002=g_lang 
             DISPLAY BY NAME g_ineg_m.ineg006_desc
             DISPLAY BY NAME g_ineg_m.ineg007
             DISPLAY BY NAME g_ineg_m.ineg007_desc  
            NEXT FIELD ineg006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.ineg007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineg007
            #add-point:ON ACTION controlp INFIELD ineg007 name="input.c.ineg007"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ineg_m.ineg007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #

            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_ineg_m.ineg007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ineg_m.ineg007 TO ineg007              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg_m.ineg007
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ineg_m.ineg007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg_m.ineg007_desc 
            NEXT FIELD ineg007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.ineg008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineg008
            #add-point:ON ACTION controlp INFIELD ineg008 name="input.c.ineg008"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ineg_m.ineg008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_inaa001_12()                                #呼叫開窗

            LET g_ineg_m.ineg008 = g_qryparam.return1              

            DISPLAY g_ineg_m.ineg008 TO ineg008              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineg_m.ineg008
            CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ineg_m.ineg008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineg_m.ineg008_desc  
            NEXT FIELD ineg008 
            #END add-point
 
 
         #Ctrlp:input.c.ineg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineg010
            #add-point:ON ACTION controlp INFIELD ineg010 name="input.c.ineg010"
            
            #END add-point
 
 
         #Ctrlp:input.c.ineg011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineg011
            #add-point:ON ACTION controlp INFIELD ineg011 name="input.c.ineg011"
            
            #END add-point
 
 
         #Ctrlp:input.c.ineg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineg001
            #add-point:ON ACTION controlp INFIELD ineg001 name="input.c.ineg001"
            
            #END add-point
 
 
         #Ctrlp:input.c.inegunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inegunit
            #add-point:ON ACTION controlp INFIELD inegunit name="input.c.inegunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.inegstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inegstus
            #add-point:ON ACTION controlp INFIELD inegstus name="input.c.inegstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_ineg_m.inegsite,g_ineg_m.inegdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_site,g_ineg_m.inegdocno,g_ineg_m.inegdocdt,g_prog) RETURNING l_success,g_ineg_m.inegdocno
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_ineg_m.inegdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CONTINUE DIALOG                  
               END IF 
               #end add-point
               
               INSERT INTO ineg_t (inegent,inegsite,inegdocdt,inegdocno,ineg002,ineg004,ineg005,ineg003, 
                   ineg006,ineg007,ineg008,ineg010,ineg011,ineg001,inegunit,inegstus,inegownid,inegcrtdp, 
                   inegowndp,inegcrtdt,inegcrtid,inegmodid,inegcnfdt,inegmoddt,inegpstid,inegcnfid,inegpstdt) 
 
               VALUES (g_enterprise,g_ineg_m.inegsite,g_ineg_m.inegdocdt,g_ineg_m.inegdocno,g_ineg_m.ineg002, 
                   g_ineg_m.ineg004,g_ineg_m.ineg005,g_ineg_m.ineg003,g_ineg_m.ineg006,g_ineg_m.ineg007, 
                   g_ineg_m.ineg008,g_ineg_m.ineg010,g_ineg_m.ineg011,g_ineg_m.ineg001,g_ineg_m.inegunit, 
                   g_ineg_m.inegstus,g_ineg_m.inegownid,g_ineg_m.inegcrtdp,g_ineg_m.inegowndp,g_ineg_m.inegcrtdt, 
                   g_ineg_m.inegcrtid,g_ineg_m.inegmodid,g_ineg_m.inegcnfdt,g_ineg_m.inegmoddt,g_ineg_m.inegpstid, 
                   g_ineg_m.inegcnfid,g_ineg_m.inegpstdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_ineg_m:",SQLERRMESSAGE 
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
                  CALL aint805_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aint805_b_fill()
                  CALL aint805_b_fill2('0')
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
               CALL aint805_ineg_t_mask_restore('restore_mask_o')
               
               UPDATE ineg_t SET (inegsite,inegdocdt,inegdocno,ineg002,ineg004,ineg005,ineg003,ineg006, 
                   ineg007,ineg008,ineg010,ineg011,ineg001,inegunit,inegstus,inegownid,inegcrtdp,inegowndp, 
                   inegcrtdt,inegcrtid,inegmodid,inegcnfdt,inegmoddt,inegpstid,inegcnfid,inegpstdt) = (g_ineg_m.inegsite, 
                   g_ineg_m.inegdocdt,g_ineg_m.inegdocno,g_ineg_m.ineg002,g_ineg_m.ineg004,g_ineg_m.ineg005, 
                   g_ineg_m.ineg003,g_ineg_m.ineg006,g_ineg_m.ineg007,g_ineg_m.ineg008,g_ineg_m.ineg010, 
                   g_ineg_m.ineg011,g_ineg_m.ineg001,g_ineg_m.inegunit,g_ineg_m.inegstus,g_ineg_m.inegownid, 
                   g_ineg_m.inegcrtdp,g_ineg_m.inegowndp,g_ineg_m.inegcrtdt,g_ineg_m.inegcrtid,g_ineg_m.inegmodid, 
                   g_ineg_m.inegcnfdt,g_ineg_m.inegmoddt,g_ineg_m.inegpstid,g_ineg_m.inegcnfid,g_ineg_m.inegpstdt) 
 
                WHERE inegent = g_enterprise AND inegsite = g_inegsite_t
                  AND inegdocno = g_inegdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "ineg_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aint805_ineg_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_ineg_m_t)
               LET g_log2 = util.JSON.stringify(g_ineg_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_inegsite_t = g_ineg_m.inegsite
            LET g_inegdocno_t = g_ineg_m.inegdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aint805.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_ineh_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION preood_into
            LET g_action_choice="preood_into"
            IF cl_auth_chk_act("preood_into") THEN
               
               #add-point:ON ACTION preood_into name="input.detail_input.page1.preood_into"
               CALL aint805_preoodinto()
               EXIT DIALOG
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_ineh_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aint805_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_ineh_d.getLength()
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
            OPEN aint805_cl USING g_enterprise,g_ineg_m.inegsite,g_ineg_m.inegdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint805_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint805_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_ineh_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_ineh_d[l_ac].inehseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_ineh_d_t.* = g_ineh_d[l_ac].*  #BACKUP
               LET g_ineh_d_o.* = g_ineh_d[l_ac].*  #BACKUP
               CALL aint805_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aint805_set_no_entry_b(l_cmd)
               IF NOT aint805_lock_b("ineh_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aint805_bcl INTO g_ineh_d[l_ac].inehseq,g_ineh_d[l_ac].ineh001,g_ineh_d[l_ac].ineh003, 
                      g_ineh_d[l_ac].ineh002,g_ineh_d[l_ac].ineh004,g_ineh_d[l_ac].ineh005,g_ineh_d[l_ac].ineh006, 
                      g_ineh_d[l_ac].ineh007,g_ineh_d[l_ac].ineh008,g_ineh_d[l_ac].ineh010,g_ineh_d[l_ac].ineh011, 
                      g_ineh_d[l_ac].ineh012,g_ineh_d[l_ac].ineh013,g_ineh_d[l_ac].ineh014,g_ineh_d[l_ac].ineh009, 
                      g_ineh_d[l_ac].ineh015,g_ineh_d[l_ac].ineh016,g_ineh_d[l_ac].ineh017,g_ineh_d[l_ac].ineh018, 
                      g_ineh_d[l_ac].ineh019,g_ineh_d[l_ac].inehunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_ineh_d_t.inehseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_ineh_d_mask_o[l_ac].* =  g_ineh_d[l_ac].*
                  CALL aint805_ineh_t_mask()
                  LET g_ineh_d_mask_n[l_ac].* =  g_ineh_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aint805_show()
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
            INITIALIZE g_ineh_d[l_ac].* TO NULL 
            INITIALIZE g_ineh_d_t.* TO NULL 
            INITIALIZE g_ineh_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_ineh_d[l_ac].ineh010 = "0"
      LET g_ineh_d[l_ac].ineh011 = "0"
      LET g_ineh_d[l_ac].ineh012 = "0"
      LET g_ineh_d[l_ac].ineh013 = "0"
      LET g_ineh_d[l_ac].ineh014 = "0"
      LET g_ineh_d[l_ac].amount = "0"
      LET g_ineh_d[l_ac].ineh009 = "0"
      LET g_ineh_d[l_ac].ineh015 = "0"
      LET g_ineh_d[l_ac].ineh016 = "0"
      LET g_ineh_d[l_ac].amount1 = "0"
      LET g_ineh_d[l_ac].ineh017 = "0"
      LET g_ineh_d[l_ac].amount2 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_ineh_d[l_ac].ineh004=g_ineg_m.ineg008
            #end add-point
            LET g_ineh_d_t.* = g_ineh_d[l_ac].*     #新輸入資料
            LET g_ineh_d_o.* = g_ineh_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aint805_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aint805_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_ineh_d[li_reproduce_target].* = g_ineh_d[li_reproduce].*
 
               LET g_ineh_d[li_reproduce_target].inehseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"

            SELECT MAX(inehseq) INTO g_ineh_d[l_ac].inehseq
              FROM ineh_t
             WHERE inehent= g_enterprise
               AND inehsite= g_ineg_m.inegsite
               AND inehdocno= g_ineg_m.inegdocno
            IF cl_null(g_ineh_d[l_ac].inehseq) THEN
               LET g_ineh_d[l_ac].inehseq=1
            ELSE
               LET  g_ineh_d[l_ac].inehseq=g_ineh_d[l_ac].inehseq+1
            END IF 
            DISPLAY g_ineh_d[l_ac].inehseq TO inehseq
            IF cl_null(g_ineh_d[l_ac].amount) THEN LET g_ineh_d[l_ac].amount=0 END IF
            LET g_ineh_d[l_ac].ineh007=' '
            LET g_ineh_d[l_ac].ineh003=' '
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
            #161017-00029#7 -s by 08172
            #料件有使用產品特徴則不可空白
            LET g_imaa005 = ''
            CALL aint805_get_imaa005(g_ineh_d[l_ac].ineh001) RETURNING g_imaa005
            IF NOT cl_null(g_imaa005) THEN
               IF cl_null(g_ineh_d[l_ac].ineh003) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00124'
                  LET g_errparam.extend = g_ineg_m.inegdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD ineh003               
               END IF
            ELSE 
               IF cl_null(g_ineh_d[l_ac].ineh003) THEN
                  LET g_ineh_d[l_ac].ineh003 = ' ' 
               END IF          
            END IF
            #161017-00029#7 -e by 08172     
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM ineh_t 
             WHERE inehent = g_enterprise AND inehsite = g_ineg_m.inegsite
               AND inehdocno = g_ineg_m.inegdocno
 
               AND inehseq = g_ineh_d[l_ac].inehseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ineg_m.inegsite
               LET gs_keys[2] = g_ineg_m.inegdocno
               LET gs_keys[3] = g_ineh_d[g_detail_idx].inehseq
               CALL aint805_insert_b('ineh_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_ineh_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "ineh_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aint805_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               #產生產品特徵開窗的值到資料庫
               IF g_inam.getLength() > 1 THEN
                  LET l_success = TRUE
                  CALL aint805_feature() RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     CANCEL INSERT
                  END IF
                  LET g_rec_b = g_inam.getLength() - 1  
                  CALL g_inam.clear()
               END IF
               CALL aint805_b_fill()                
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
               LET gs_keys[01] = g_ineg_m.inegsite
               LET gs_keys[gs_keys.getLength()+1] = g_ineg_m.inegdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_ineh_d_t.inehseq
 
            
               #刪除同層單身
               IF NOT aint805_delete_b('ineh_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint805_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aint805_key_delete_b(gs_keys,'ineh_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint805_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aint805_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_ineh_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_ineh_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inehseq
            #add-point:BEFORE FIELD inehseq name="input.b.page1.inehseq"
#            SELECT inehseq INTO g_ineh_d[l_ac].inehseq
#              FROM ineh_t
#             WHERE inehent= g_enterprise
#               AND inehsite= g_ineg_m.inegsite
#               AND inehdocno= g_ineg_m.inegdocno
#            IF cl_null(g_ineh_d[l_ac].inehseq) THEN
#               LET g_ineh_d[l_ac].inehseq=1
#            ELSE
#               LET  g_ineh_d[l_ac].inehseq=g_ineh_d[l_ac].inehseq+1
#            END IF               
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inehseq
            
            #add-point:AFTER FIELD inehseq name="input.a.page1.inehseq"
            #此段落由子樣板a05產生
            IF  g_ineg_m.inegsite IS NOT NULL AND g_ineg_m.inegdocno IS NOT NULL AND g_ineh_d[g_detail_idx].inehseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ineg_m.inegsite != g_inegsite_t OR g_ineg_m.inegdocno != g_inegdocno_t OR g_ineh_d[g_detail_idx].inehseq != g_ineh_d_t.inehseq)) THEN 
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inehseq
            #add-point:ON CHANGE inehseq name="input.g.page1.inehseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh001
            
            #add-point:AFTER FIELD ineh001 name="input.a.page1.ineh001"
            IF NOT cl_null(g_ineh_d[l_ac].ineh001) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND  g_ineh_d[l_ac].ineh001 != g_ineh_d_t.ineh001) THEN   #160824-00007#292 20170109 mark by beckxie
               IF g_ineh_d[l_ac].ineh001 != g_ineh_d_o.ineh001 OR cl_null(g_ineh_d_o.ineh001) THEN   #160824-00007#292 20170109 add by beckxie
               
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_ineh_d[l_ac].ineh001
                  LET g_chkparam.arg2 = g_ineg_m.inegsite
                  LET g_chkparam.arg3 = g_ineg_m.ineg002

                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_inee002") THEN
                     #LET g_ineh_d[l_ac].ineh001 = g_ineh_d_t.ineh001   #160824-00007#292 20170109 mark by beckxie
                     #160824-00007#292 20170109 add by beckxie---S
                     LET g_ineh_d[l_ac].ineh001 = g_ineh_d_o.ineh001
                     LET g_ineh_d[l_ac].ineh002 = g_ineh_d_o.ineh002
                     LET g_ineh_d[l_ac].ineh003 = g_ineh_d_o.ineh003
                     LET g_ineh_d[l_ac].ineh003_desc = g_ineh_d_o.ineh003_desc
                     LET g_ineh_d[l_ac].ineh005 = g_ineh_d_o.ineh005
                     LET g_ineh_d[l_ac].ineh008 = g_ineh_d_o.ineh008
                     LET g_ineh_d[l_ac].ineh016 = g_ineh_d_o.ineh016
                     LET g_ineh_d[l_ac].ineh017 = g_ineh_d_o.ineh017
                     LET g_ineh_d[l_ac].amount  = g_ineh_d_o.amount
                     LET g_ineh_d[l_ac].amount1 = g_ineh_d_o.amount1
                     LET g_ineh_d[l_ac].amount2 = g_ineh_d_o.amount2
                     LET g_ineh_d[l_ac].ineh008_desc = g_ineh_d_o.ineh008_desc
                     LET g_ineh_d[l_ac].ineh001_desc = g_ineh_d_o.ineh001_desc
                     LET g_ineh_d[l_ac].ineh001_desc_desc = g_ineh_d_o.ineh001_desc_desc
                     #160824-00007#292 20170109 add by beckxie---E
                     NEXT FIELD CURRENT
                  END IF  
                  
                  SELECT imay003 INTO g_ineh_d[l_ac].ineh002
                     FROM imay_t
                    WHERE imayent=g_enterprise
                      AND imay001=g_ineh_d[l_ac].ineh001 
                      AND imay006='Y' 
                     
                  INITIALIZE g_chkparam.* TO NULL   
                  LET g_chkparam.arg1 = g_ineh_d[l_ac].ineh002

                  #呼叫檢查存在並帶值的library
#                  IF NOT cl_chk_exist("v_imay003") THEN   #161017-00029#7 by 08172
                  IF NOT cl_chk_exist("v_imay003_1") THEN  #161017-00029#7 by 08172
                     #LET g_ineh_d[l_ac].ineh001 = g_ineh_d_t.ineh001   #160824-00007#292 20170109 mark by beckxie
                     #LET g_ineh_d[l_ac].ineh002 = g_ineh_d_t.ineh002   #160824-00007#292 20170109 mark by beckxie
                     #160824-00007#292 20170109 add by beckxie---S
                     LET g_ineh_d[l_ac].ineh001 = g_ineh_d_o.ineh001
                     LET g_ineh_d[l_ac].ineh002 = g_ineh_d_o.ineh002
                     LET g_ineh_d[l_ac].ineh003 = g_ineh_d_o.ineh003
                     LET g_ineh_d[l_ac].ineh003_desc = g_ineh_d_o.ineh003_desc
                     LET g_ineh_d[l_ac].ineh005 = g_ineh_d_o.ineh005
                     LET g_ineh_d[l_ac].ineh008 = g_ineh_d_o.ineh008
                     LET g_ineh_d[l_ac].ineh016 = g_ineh_d_o.ineh016
                     LET g_ineh_d[l_ac].ineh017 = g_ineh_d_o.ineh017
                     LET g_ineh_d[l_ac].amount  = g_ineh_d_o.amount
                     LET g_ineh_d[l_ac].amount1 = g_ineh_d_o.amount1
                     LET g_ineh_d[l_ac].amount2 = g_ineh_d_o.amount2
                     LET g_ineh_d[l_ac].ineh008_desc = g_ineh_d_o.ineh008_desc
                     LET g_ineh_d[l_ac].ineh001_desc = g_ineh_d_o.ineh001_desc
                     LET g_ineh_d[l_ac].ineh001_desc_desc = g_ineh_d_o.ineh001_desc_desc
                     #160824-00007#292 20170109 add by beckxie---E
                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF
            CALL aint805_ineh_ref()
            CALL aint805_amount()
            #161017-00029#7 -s by 08172
            #LET g_ineh_d_o.* = g_ineh_d[l_ac].*   #160824-00007#292 20170109 mark by beckxie
            CALL aint805_set_entry_b(l_cmd)        
            CALL aint805_set_no_entry_b(l_cmd)
            CALL s_feature_description(g_ineh_d[l_ac].ineh001,g_ineh_d[l_ac].ineh003) 
                     RETURNING l_success,g_ineh_d[l_ac].ineh003_desc
            LET g_ineh_d_o.* = g_ineh_d[l_ac].*   #160824-00007#292 20170109 add by beckxie
            #161017-00029#7 -e by 08172
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh001
            #add-point:BEFORE FIELD ineh001 name="input.b.page1.ineh001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ineh001
            #add-point:ON CHANGE ineh001 name="input.g.page1.ineh001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh003
            
            #add-point:AFTER FIELD ineh003 name="input.a.page1.ineh003"
            #161017-00029#7 -s by 08172
            IF NOT cl_null(g_ineh_d[l_ac].ineh003) THEN 
               IF g_ineh_d[l_ac].ineh003 != g_ineh_d_o.ineh003 OR g_ineh_d_o.ineh003 IS NULL THEN 
                  IF NOT s_feature_check(g_ineh_d[l_ac].ineh001,g_ineh_d[l_ac].ineh003) THEN
                     LET g_ineh_d[l_ac].ineh003 = g_ineh_d_o.ineh003
                     LET g_ineh_d[l_ac].ineh009 = g_ineh_d_o.ineh009
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_feature_direct_input(g_ineh_d[l_ac].ineh001,g_ineh_d[l_ac].ineh003,g_ineh_d_o.ineh003,g_ineg_m.inegdocno,g_ineg_m.inegsite) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               IF NOT cl_null(g_imaa005) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  'sub-00124'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               ELSE
                  LET g_ineh_d[l_ac].ineh003 = ' '
               END IF
            END IF
            
            IF NOT cl_null(g_ineh_d[l_ac].ineh003) AND NOT cl_null(g_ineh_d[l_ac].ineh001) THEN
               INITIALIZE g_ineh_d[l_ac].ineh002 TO NULL
               #161228-00033#3 by sakura mark(S)
               #SELECT imay003 INTO g_ineh_d[l_ac].ineh002
               #  FROM imay_t
               # WHERE imayent = g_enterprise
               #   AND imay001 = g_ineh_d[l_ac].ineh001
               #   AND imay019 = g_ineh_d[l_ac].ineh003
               #   AND imaystus = 'Y'
               #   AND ROWNUM = 1
               #161228-00033#3 by sakura mark(E)
               #161228-00033#3 by sakura add(S)
               LET g_sql = "SELECT imay003 ",
                           "  FROM imay_t ",
                           " WHERE imayent = ",g_enterprise,
                           "   AND imay001 = '",g_ineh_d[l_ac].ineh001,"'",
                           "   AND imay019 = '",g_ineh_d[l_ac].ineh003,"'",
                           "   AND imaystus = 'Y' "
               PREPARE aint805_sel_imay003_pre FROM g_sql
               DECLARE aint805_sel_imay003_cur SCROLL CURSOR FOR aint805_sel_imay003_pre   
               OPEN aint805_sel_imay003_cur
               FETCH FIRST aint805_sel_imay003_cur INTO g_ineh_d[l_ac].ineh002
               CLOSE aint805_sel_imay003_cur               
               FREE  aint805_sel_imay003_pre               
               #161228-00033#3 by sakura add(E)
               IF cl_null(g_ineh_d[l_ac].ineh002) THEN
                  SELECT imay003 INTO g_ineh_d[l_ac].ineh002
                    FROM imay_t
                   WHERE imayent = g_enterprise
                     AND imay001 = g_ineh_d[l_ac].ineh001
                     AND imay006 = 'Y'
                     AND imaystus = 'Y'
               END IF
               DISPLAY g_ineh_d[l_ac].ineh002 TO ineh002
            END IF
            CALL aint805_amount()
            IF NOT cl_null(g_ineh_d[l_ac].ineh009) THEN
               LET g_ineh_d[l_ac].amount1= g_ineh_d[l_ac].ineh016*g_ineh_d[l_ac].ineh009 
               LET g_ineh_d[l_ac].amount2= g_ineh_d[l_ac].ineh017*g_ineh_d[l_ac].ineh009 
            END IF
            IF cl_null(g_ineh_d[l_ac].amount1) THEN LET g_ineh_d[l_ac].amount1=0 END IF
            IF cl_null(g_ineh_d[l_ac].amount2) THEN LET g_ineh_d[l_ac].amount2=0 END IF
            SELECT SUM(inag008) INTO g_ineh_d[l_ac].ineh010
              FROM inag_t
             WHERE inagent=g_enterprise
               AND inagsite=g_ineg_m.inegsite
               AND inag001=g_ineh_d[l_ac].ineh001
               AND inag002=g_ineh_d[l_ac].ineh003  
               AND inag004=g_ineh_d[l_ac].ineh004
               AND inag005=g_ineh_d[l_ac].ineh005
               AND inag007=g_ineh_d[l_ac].ineh008
            IF cl_null(g_ineh_d[l_ac].ineh010) THEN LET g_ineh_d[l_ac].ineh010=0 END IF 
            LET g_ineh_d_o.* = g_ineh_d[l_ac].*
            CALL s_feature_description(g_ineh_d[l_ac].ineh001,g_ineh_d[l_ac].ineh003) 
                     RETURNING l_success,g_ineh_d[l_ac].ineh003_desc
            #161017-00029#7 -e by 08172
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh003
            #add-point:BEFORE FIELD ineh003 name="input.b.page1.ineh003"
            #161017-00029#7 -s by 08172
            IF cl_get_para(g_enterprise,g_ineg_m.inegsite,'S-BAS-0036') = 'Y' THEN 
               IF s_feature_auto_chk(g_ineh_d[l_ac].ineh001) AND cl_null(g_ineh_d[l_ac].ineh003) THEN   
                  CALL g_inam.clear()            
                  CALL s_feature(l_cmd,g_ineh_d[l_ac].ineh001,'','',g_ineg_m.inegsite,g_ineg_m.inegdocno) RETURNING l_success,g_inam
                  LET g_ineh_d[l_ac].ineh003 = g_inam[1].inam002
                  LET g_ineh_d[l_ac].ineh009 = g_inam[1].inam004
                  #賬面數量
                  SELECT SUM(inag008) INTO g_ineh_d[l_ac].ineh010
                    FROM inag_t
                   WHERE inagent=g_enterprise
                     AND inagsite=g_ineg_m.inegsite
                     AND inag001=g_ineh_d[l_ac].ineh001
                     AND inag002=g_ineh_d[l_ac].ineh003
                     AND inag004=g_ineh_d[l_ac].ineh004
                     AND inag005=g_ineh_d[l_ac].ineh005
                     AND inag007=g_ineh_d[l_ac].ineh008
                  IF cl_null(g_ineh_d[l_ac].ineh010) THEN LET g_ineh_d[l_ac].ineh010=0 END IF
                  CALL aint805_amount()
                  IF NOT cl_null(g_ineh_d[l_ac].ineh009) THEN
                     LET g_ineh_d[l_ac].amount1= g_ineh_d[l_ac].ineh016*g_ineh_d[l_ac].ineh009 
                     LET g_ineh_d[l_ac].amount2= g_ineh_d[l_ac].ineh017*g_ineh_d[l_ac].ineh009 
                  END IF
                  IF cl_null(g_ineh_d[l_ac].amount1) THEN LET g_ineh_d[l_ac].amount1=0 END IF
                  IF cl_null(g_ineh_d[l_ac].amount2) THEN LET g_ineh_d[l_ac].amount2=0 END IF                  
               END IF
            END IF
            LET g_ineh_d_o.* = g_ineh_d[l_ac].*            
            #161017-00029#7 -e by 08172   
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ineh003
            #add-point:ON CHANGE ineh003 name="input.g.page1.ineh003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh003_desc
            #add-point:BEFORE FIELD ineh003_desc name="input.b.page1.ineh003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh003_desc
            
            #add-point:AFTER FIELD ineh003_desc name="input.a.page1.ineh003_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ineh003_desc
            #add-point:ON CHANGE ineh003_desc name="input.g.page1.ineh003_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh002
            #add-point:BEFORE FIELD ineh002 name="input.b.page1.ineh002"
            LET g_ineh_d_o.* = g_ineh_d[l_ac].*   #161017-00029#7 by 08172
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh002
            
            #add-point:AFTER FIELD ineh002 name="input.a.page1.ineh002"
            IF NOT cl_null(g_ineh_d[l_ac].ineh002) THEN
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND  g_ineh_d[l_ac].ineh002 != g_ineh_d_t.ineh002) THEN #161017-00029#7 by 08172
               
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND  g_ineh_d[l_ac].ineh002 != g_ineh_d_o.ineh002) THEN  #161017-00029#7 by 08172   #160824-00007#292 20170109 mark by beckxie
               IF g_ineh_d[l_ac].ineh002 != g_ineh_d_o.ineh002 OR cl_null(g_ineh_d_o.ineh002) THEN   #160824-00007#292 20170109 add by beckxie
               
              
                  SELECT imay001 INTO g_ineh_d[l_ac].ineh001
                    FROM imay_t
                   WHERE imayent=g_enterprise
                     AND imay003=g_ineh_d[l_ac].ineh002
                  #161017-00029#7 -s by 08172
#                  SELECT imay003 INTO g_ineh_d[l_ac].ineh002
#                     FROM imay_t
#                    WHERE imayent=g_enterprise
#                      AND imay001=g_ineh_d[l_ac].ineh001 
#                      AND imay006='Y' 
                  #161017-00029#7 -e by 08172
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_ineh_d[l_ac].ineh002

                  #呼叫檢查存在並帶值的library
#                  IF NOT cl_chk_exist("v_imay003") THEN   #161017-00029#7 by 08172
                  IF NOT cl_chk_exist("v_imay003_1") THEN  #161017-00029#7 by 08172
                     #LET g_ineh_d[l_ac].ineh001 = g_ineh_d_t.ineh001   #160824-00007#292 20170109 mark by beckxie
                     #LET g_ineh_d[l_ac].ineh002 = g_ineh_d_t.ineh002   #160824-00007#292 20170109 mark by beckxie
                     #160824-00007#292 20170109 add by beckxie---S
                     LET g_ineh_d[l_ac].ineh001 = g_ineh_d_o.ineh001
                     LET g_ineh_d[l_ac].ineh002 = g_ineh_d_o.ineh002
                     LET g_ineh_d[l_ac].ineh003 = g_ineh_d_o.ineh003
                     LET g_ineh_d[l_ac].ineh003_desc = g_ineh_d_o.ineh003_desc
                     LET g_ineh_d[l_ac].ineh005 = g_ineh_d_o.ineh005
                     LET g_ineh_d[l_ac].ineh008 = g_ineh_d_o.ineh008
                     LET g_ineh_d[l_ac].ineh016 = g_ineh_d_o.ineh016
                     LET g_ineh_d[l_ac].ineh017 = g_ineh_d_o.ineh017
                     LET g_ineh_d[l_ac].amount  = g_ineh_d_o.amount
                     LET g_ineh_d[l_ac].amount1 = g_ineh_d_o.amount1
                     LET g_ineh_d[l_ac].amount2 = g_ineh_d_o.amount2
                     LET g_ineh_d[l_ac].ineh008_desc = g_ineh_d_o.ineh008_desc
                     LET g_ineh_d[l_ac].ineh001_desc = g_ineh_d_o.ineh001_desc
                     LET g_ineh_d[l_ac].ineh001_desc_desc = g_ineh_d_o.ineh001_desc_desc
                     #160824-00007#292 20170109 add by beckxie---E
                     NEXT FIELD CURRENT
                  END IF  
                  
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_ineh_d[l_ac].ineh001
                  LET g_chkparam.arg2 = g_ineg_m.inegsite
                  LET g_chkparam.arg3 = g_ineg_m.ineg002

                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_inee002") THEN
                     #LET g_ineh_d[l_ac].ineh001 = g_ineh_d_t.ineh001   #160824-00007#292 20170109 mark by beckxie
                     #LET g_ineh_d[l_ac].ineh002 = g_ineh_d_t.ineh002   #160824-00007#292 20170109 mark by beckxie
                     #160824-00007#292 20170109 add by beckxie---S
                     LET g_ineh_d[l_ac].ineh001 = g_ineh_d_o.ineh001
                     LET g_ineh_d[l_ac].ineh002 = g_ineh_d_o.ineh002
                     LET g_ineh_d[l_ac].ineh003 = g_ineh_d_o.ineh003
                     LET g_ineh_d[l_ac].ineh003_desc = g_ineh_d_o.ineh003_desc
                     LET g_ineh_d[l_ac].ineh005 = g_ineh_d_o.ineh005
                     LET g_ineh_d[l_ac].ineh008 = g_ineh_d_o.ineh008
                     LET g_ineh_d[l_ac].ineh016 = g_ineh_d_o.ineh016
                     LET g_ineh_d[l_ac].ineh017 = g_ineh_d_o.ineh017
                     LET g_ineh_d[l_ac].amount  = g_ineh_d_o.amount
                     LET g_ineh_d[l_ac].amount1 = g_ineh_d_o.amount1
                     LET g_ineh_d[l_ac].amount2 = g_ineh_d_o.amount2
                     LET g_ineh_d[l_ac].ineh008_desc = g_ineh_d_o.ineh008_desc
                     LET g_ineh_d[l_ac].ineh001_desc = g_ineh_d_o.ineh001_desc
                     LET g_ineh_d[l_ac].ineh001_desc_desc = g_ineh_d_o.ineh001_desc_desc
                     #160824-00007#292 20170109 add by beckxie---E
                     NEXT FIELD CURRENT
                  END IF  

               END IF
            END IF
            SELECT imaa104 INTO g_ineh_d[l_ac].ineh008
              FROM imaa_t
             WHERE imaaent=g_enterprise
               AND imaa001=g_ineh_d[l_ac].ineh001 
            SELECT oocal003 INTO g_ineh_d[l_ac].ineh008_desc
              FROM oocal_t
             WHERE oocalent=g_enterprise
               AND oocal001=g_ineh_d[l_ac].ineh008
               AND oocal002=g_lang
            SELECT imaal003,imaal004 INTO g_ineh_d[l_ac].ineh001_desc,g_ineh_d[l_ac].ineh001_desc_desc
              FROM imaal_t
             WHERE imaalent=g_enterprise
               AND imaal001=g_ineh_d[l_ac].ineh001
               AND imaal002=g_dlang
            
            SELECT inee003,inee004 INTO g_ineh_d[l_ac].ineh016,g_ineh_d[l_ac].ineh017
              FROM inee_t
             WHERE ineeent= g_enterprise
               AND ineesite= g_ineg_m.inegsite
               AND inee001= g_ineg_m.inegdocno
               AND inee002= g_ineh_d[l_ac].ineh001
            #161017-00029#7 -s by 08172   
            LET g_ineh_d[l_ac].ineh003 = ' '
            SELECT imay019 INTO g_ineh_d[l_ac].ineh003
              FROM imay_t 
             WHERE imayent = g_enterprise
               AND imay003 = g_ineh_d[l_ac].ineh002
               AND imaystus = 'Y'
            DISPLAY  g_ineh_d[l_ac].ineh003 TO ineh003
            #161017-00029#7 -e by 08172
            IF cl_null(g_ineh_d[l_ac].ineh016) THEN LET g_ineh_d[l_ac].ineh016=0 END IF
            IF cl_null(g_ineh_d[l_ac].ineh017) THEN LET g_ineh_d[l_ac].ineh017=0 END IF
            IF NOT cl_null(g_ineh_d[l_ac].ineh009) THEN
               LET g_ineh_d[l_ac].amount1= g_ineh_d[l_ac].ineh016*g_ineh_d[l_ac].ineh009 
               LET g_ineh_d[l_ac].amount2= g_ineh_d[l_ac].ineh017*g_ineh_d[l_ac].ineh009 
            END IF
            IF cl_null(g_ineh_d[l_ac].amount1) THEN LET g_ineh_d[l_ac].amount1=0 END IF
            IF cl_null(g_ineh_d[l_ac].amount2) THEN LET g_ineh_d[l_ac].amount2=0 END IF                  
             
            DISPLAY g_ineh_d[l_ac].ineh001 TO ineh001                   
            DISPLAY g_ineh_d[l_ac].ineh002 TO ineh002
            DISPLAY g_ineh_d[l_ac].ineh008 TO ineh008
            DISPLAY g_ineh_d[l_ac].ineh016 TO ineh016
            DISPLAY g_ineh_d[l_ac].ineh017 TO ineh017
            DISPLAY g_ineh_d[l_ac].amount1 TO amount1
            DISPLAY g_ineh_d[l_ac].amount2 TO amount2
            DISPLAY g_ineh_d[l_ac].ineh008_desc TO ineh008_desc                 
            DISPLAY g_ineh_d[l_ac].ineh001_desc TO ineh001_desc
            DISPLAY g_ineh_d[l_ac].ineh001_desc_desc TO ineh001_desc_desc  
           
            CALL aint805_amount()
            #161017-00029#7 -s by 08172
            #LET g_ineh_d_o.* = g_ineh_d[l_ac].*   #160824-00007#292 20170109 mark by beckxie
            CALL aint805_set_entry_b(l_cmd)        
            CALL aint805_set_no_entry_b(l_cmd)     
            CALL s_feature_description(g_ineh_d[l_ac].ineh001,g_ineh_d[l_ac].ineh003) 
                     RETURNING l_success,g_ineh_d[l_ac].ineh003_desc
            LET g_ineh_d_o.* = g_ineh_d[l_ac].*   #160824-00007#292 20170109 add by beckxie         
            #161017-00029#7 -e by 08172
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ineh002
            #add-point:ON CHANGE ineh002 name="input.g.page1.ineh002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh004
            
            #add-point:AFTER FIELD ineh004 name="input.a.page1.ineh004"
            IF NOT cl_null(g_ineh_d[l_ac].ineh004) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND  g_ineh_d[l_ac].ineh004 != g_ineh_d_t.ineh004) THEN   #160824-00007#292 20170109 mark by beckxie
               IF g_ineh_d[l_ac].ineh004 != g_ineh_d_o.ineh004 OR cl_null(g_ineh_d_o.ineh004) THEN   #160824-00007#292 20170109 add by beckxie
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_ineh_d[l_ac].ineh004
                  #160318-00025#20  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#20  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_inaa001_2") THEN
                     #LET g_ineh_d[l_ac].ineh004 = g_ineh_d_t.ineh004   #160824-00007#292 20170109 mark by beckxie
                     #160824-00007#292 20170109 add by beckxie---S
                     LET g_ineh_d[l_ac].ineh004 = g_ineh_d_o.ineh004
                     LET g_ineh_d[l_ac].ineh004_desc = g_ineh_d_o.ineh004_desc
                     LET g_ineh_d[l_ac].ineh005 = g_ineh_d_o.ineh005
                     LET g_ineh_d[l_ac].amount = g_ineh_d_o.amount
                     #160824-00007#292 20170109 add by beckxie---E
                     NEXT FIELD CURRENT
                  END IF                

                  IF g_ineh_d[l_ac].ineh004<>g_ineg_m.ineg008 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_ineh_d[l_ac].ineh004
                     LET g_errparam.code   = "ain-00676" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                  
                     #LET g_ineh_d[l_ac].ineh004 = g_ineh_d_t.ineh004   #160824-00007#292 20170109 mark by beckxie
                     #160824-00007#292 20170109 add by beckxie---S
                     LET g_ineh_d[l_ac].ineh004 = g_ineh_d_o.ineh004
                     LET g_ineh_d[l_ac].ineh004_desc = g_ineh_d_o.ineh004_desc
                     LET g_ineh_d[l_ac].ineh005 = g_ineh_d_o.ineh005
                     LET g_ineh_d[l_ac].amount = g_ineh_d_o.amount
                     #160824-00007#292 20170109 add by beckxie---E
                     NEXT FIELD CURRENT
                  END IF 

               END IF
            END IF
            CALL aint805_amount()
            IF cl_null(g_ineh_d[l_ac].ineh005) THEN LET g_ineh_d[l_ac].ineh005=' ' END IF
#            IF cl_null(g_ineh_d[l_ac].ineh006) THEN LET g_ineh_d[l_ac].ineh006=' ' END IF    
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineh_d[l_ac].ineh004
            CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ineh_d[l_ac].ineh004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineh_d[l_ac].ineh004_desc              
            
            LET g_ineh_d_o.* = g_ineh_d[l_ac].*   #160824-00007#292 20170109 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh004
            #add-point:BEFORE FIELD ineh004 name="input.b.page1.ineh004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ineh004
            #add-point:ON CHANGE ineh004 name="input.g.page1.ineh004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh005
            #add-point:BEFORE FIELD ineh005 name="input.b.page1.ineh005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh005
            
            #add-point:AFTER FIELD ineh005 name="input.a.page1.ineh005"
            IF NOT cl_null(g_ineh_d[l_ac].ineh005) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND  g_ineh_d[l_ac].ineh005 != g_ineh_d_t.ineh005) THEN   #160824-00007#292 20170109 mark by beckxie
               IF g_ineh_d[l_ac].ineh005 != g_ineh_d_o.ineh005 OR cl_null(g_ineh_d_o.ineh005) THEN   #160824-00007#292 20170109 add by beckxie
               
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_ineg_m.inegsite
                  LET g_chkparam.arg2 = g_ineh_d[l_ac].ineh004
                  LET g_chkparam.arg3 = g_ineh_d[l_ac].ineh005
                  #160318-00025#20  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#20  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_inab002") THEN
                     #LET g_ineh_d[l_ac].ineh004 = g_ineh_d_t.ineh004   #160824-00007#292 20170109 mark by beckxie
                     #160824-00007#292 20170109 add by beckxie---S
                     LET g_ineh_d[l_ac].ineh004 = g_ineh_d_o.ineh004
                     LET g_ineh_d[l_ac].ineh005 = g_ineh_d_o.ineh005
                     LET g_ineh_d[l_ac].amount = g_ineh_d_o.amount
                     #160824-00007#292 20170109 add by beckxie---E
                     NEXT FIELD CURRENT
                  END IF                
               

               END IF
            END IF
            CALL aint805_amount()
            IF cl_null(g_ineh_d[l_ac].ineh005) THEN LET g_ineh_d[l_ac].ineh005=' ' END IF
#            IF cl_null(g_ineh_d[l_ac].ineh006) THEN LET g_ineh_d[l_ac].ineh006=' ' END IF           

            LET g_ineh_d_o.* = g_ineh_d[l_ac].*   #160824-00007#292 20170109 add by beckxie
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ineh005
            #add-point:ON CHANGE ineh005 name="input.g.page1.ineh005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh006
            #add-point:BEFORE FIELD ineh006 name="input.b.page1.ineh006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh006
            
            #add-point:AFTER FIELD ineh006 name="input.a.page1.ineh006"
            CALL aint805_amount()
            IF cl_null(g_ineh_d[l_ac].ineh005) THEN LET g_ineh_d[l_ac].ineh005=' ' END IF
#            IF cl_null(g_ineh_d[l_ac].ineh006) THEN LET g_ineh_d[l_ac].ineh006=' ' END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ineh006
            #add-point:ON CHANGE ineh006 name="input.g.page1.ineh006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amount
            #add-point:BEFORE FIELD amount name="input.b.page1.amount"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amount
            
            #add-point:AFTER FIELD amount name="input.a.page1.amount"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amount
            #add-point:ON CHANGE amount name="input.g.page1.amount"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ineh_d[l_ac].ineh009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD ineh009
            END IF 
 
 
 
            #add-point:AFTER FIELD ineh009 name="input.a.page1.ineh009"
            IF NOT cl_null(g_ineh_d[l_ac].ineh009) THEN 
               LET g_ineh_d[l_ac].amount1=g_ineh_d[l_ac].ineh009*g_ineh_d[l_ac].ineh016
               LET g_ineh_d[l_ac].amount2=g_ineh_d[l_ac].ineh009*g_ineh_d[l_ac].ineh017
               SELECT SUM(ineh009) INTO l_amount
                 FROM ineh_t,ineg_t
                WHERE inehent=inegent
                  AND inehsite=inegsite
                  AND inehdocno=inegdocno
                  AND inehent=g_enterprise
                  AND inehsite=g_ineg_m.inegsite
                  AND ineg001='1'
                  AND inegstus<>'X'
                  AND ineg002=g_ineg_m.ineg002
                  AND ineh001=g_ineh_d[l_ac].ineh001
                  AND ineh003=g_ineh_d[l_ac].ineh003    #161017-00029#7 by 08172
                  AND ineh004=g_ineh_d[l_ac].ineh004
                  AND ineh005=g_ineh_d[l_ac].ineh005
#                  AND ineh006=g_ineh_d[l_ac].ineh006
                  AND ineh008=g_ineh_d[l_ac].ineh008
                IF cl_null(g_ineh_d_t.ineh009) THEN LET g_ineh_d_t.ineh009=0 END IF
                LET g_ineh_d[l_ac].amount =l_amount-g_ineh_d_t.ineh009+ g_ineh_d[l_ac].ineh009                              
                 
               IF cl_null(g_ineh_d[l_ac].amount) THEN  LET g_ineh_d[l_ac].amount=0  END IF   
               IF cl_null(g_ineh_d[l_ac].amount1) THEN LET g_ineh_d[l_ac].amount1=0 END IF
               IF cl_null(g_ineh_d[l_ac].amount2) THEN LET g_ineh_d[l_ac].amount2=0 END IF                 
               DISPLAY g_ineh_d[l_ac].amount  TO amount
               DISPLAY g_ineh_d[l_ac].amount1 TO amount1
               DISPLAY g_ineh_d[l_ac].amount2 TO amount2               
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh009
            #add-point:BEFORE FIELD ineh009 name="input.b.page1.ineh009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ineh009
            #add-point:ON CHANGE ineh009 name="input.g.page1.ineh009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ineh019
            #add-point:BEFORE FIELD ineh019 name="input.b.page1.ineh019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ineh019
            
            #add-point:AFTER FIELD ineh019 name="input.a.page1.ineh019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ineh019
            #add-point:ON CHANGE ineh019 name="input.g.page1.ineh019"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.inehseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inehseq
            #add-point:ON ACTION controlp INFIELD inehseq name="input.c.page1.inehseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ineh001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh001
            #add-point:ON ACTION controlp INFIELD ineh001 name="input.c.page1.ineh001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ineh_d[l_ac].ineh001             #給予default值

            #給予arg
            LET g_qryparam.arg1 =g_ineg_m.ineg002
            CALL q_inee002()                                #呼叫開窗

            LET g_ineh_d[l_ac].ineh001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ineh_d[l_ac].ineh001 TO ineh001              #顯示到畫面上
            CALL aint805_ineh_ref()
            NEXT FIELD ineh001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.ineh003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh003
            #add-point:ON ACTION controlp INFIELD ineh003 name="input.c.page1.ineh003"
            #161017-00029#7 -s by 08172
            LET g_imaa005 = ''
            CALL aint805_get_imaa005(g_ineh_d[l_ac].ineh001) RETURNING g_imaa005
               
            IF NOT cl_null(g_imaa005) THEN
               IF l_cmd = 'a' THEN            
                  CALL g_inam.clear()            
                  CALL s_feature(l_cmd,g_ineh_d[l_ac].ineh001,'','',g_ineg_m.inegsite,g_ineg_m.inegdocno) 
                     RETURNING l_success,g_inam
                  LET g_ineh_d[l_ac].ineh003 = g_inam[1].inam002
                  LET g_ineh_d[l_ac].ineh009 = g_inam[1].inam004
                  
                  IF NOT cl_null(g_ineh_d[l_ac].ineh009) THEN
                     LET g_ineh_d[l_ac].amount1= g_ineh_d[l_ac].ineh016*g_ineh_d[l_ac].ineh009 
                     LET g_ineh_d[l_ac].amount2= g_ineh_d[l_ac].ineh017*g_ineh_d[l_ac].ineh009 
                  END IF
                  IF cl_null(g_ineh_d[l_ac].amount1) THEN LET g_ineh_d[l_ac].amount1=0 END IF
                  IF cl_null(g_ineh_d[l_ac].amount2) THEN LET g_ineh_d[l_ac].amount2=0 END IF
                  CALL aint805_amount()
                  SELECT SUM(inag008) INTO g_ineh_d[l_ac].ineh010
                    FROM inag_t
                   WHERE inagent=g_enterprise
                     AND inagsite=g_ineg_m.inegsite
                     AND inag001=g_ineh_d[l_ac].ineh001
                     AND inag002=g_ineh_d[l_ac].ineh003  
                     AND inag004=g_ineh_d[l_ac].ineh004
                     AND inag005=g_ineh_d[l_ac].ineh005
                     AND inag007=g_ineh_d[l_ac].ineh008
                  IF cl_null(g_ineh_d[l_ac].ineh010) THEN LET g_ineh_d[l_ac].ineh010=0 END IF 
               END IF
               IF l_cmd = 'u' THEN
                  CALL s_feature_single(g_ineh_d[l_ac].ineh001,g_ineh_d[l_ac].ineh003,g_ineg_m.inegsite,g_ineg_m.inegdocno)
                     RETURNING l_success,g_ineh_d[l_ac].ineh003
               END IF
            END IF
            #161017-00029#7 -e by 08172
            #END add-point
 
 
         #Ctrlp:input.c.page1.ineh003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh003_desc
            #add-point:ON ACTION controlp INFIELD ineh003_desc name="input.c.page1.ineh003_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ineh002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh002
            #add-point:ON ACTION controlp INFIELD ineh002 name="input.c.page1.ineh002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ineh004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh004
            #add-point:ON ACTION controlp INFIELD ineh004 name="input.c.page1.ineh004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ineh_d[l_ac].ineh004             #給予default值

            #給予arg

            CALL q_inaa001_12()                                #呼叫開窗

            LET g_ineh_d[l_ac].ineh004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ineh_d[l_ac].ineh004 TO ineh004              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ineh_d[l_ac].ineh004
            CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ineh_d[l_ac].ineh004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ineh_d[l_ac].ineh004_desc  
            NEXT FIELD ineh004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.ineh005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh005
            #add-point:ON ACTION controlp INFIELD ineh005 name="input.c.page1.ineh005"
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ineh_d[l_ac].ineh005             #給予default值

            #給予arg
            IF NOT cl_null(g_ineh_d[l_ac].ineh004) THEN
               LET g_qryparam.arg1=g_ineh_d[l_ac].ineh004
               CALL q_inab002_9()                                #呼叫開窗
            ELSE
               CALL q_inab002()
            END IF
            LET g_ineh_d[l_ac].ineh005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ineh_d[l_ac].ineh005 TO ineh005              #顯示到畫面上

            NEXT FIELD ineh005 
            #END add-point
 
 
         #Ctrlp:input.c.page1.ineh006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh006
            #add-point:ON ACTION controlp INFIELD ineh006 name="input.c.page1.ineh006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amount
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amount
            #add-point:ON ACTION controlp INFIELD amount name="input.c.page1.amount"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ineh009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh009
            #add-point:ON ACTION controlp INFIELD ineh009 name="input.c.page1.ineh009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ineh019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ineh019
            #add-point:ON ACTION controlp INFIELD ineh019 name="input.c.page1.ineh019"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_ineh_d[l_ac].* = g_ineh_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aint805_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_ineh_d[l_ac].inehseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_ineh_d[l_ac].* = g_ineh_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               #賬面數量
               LET g_ineh_d[l_ac].ineh010=''
               SELECT SUM(inag008) INTO g_ineh_d[l_ac].ineh010
                 FROM inag_t
                WHERE inagent=g_enterprise
                  AND inagsite=g_ineg_m.inegsite
                  AND inag001=g_ineh_d[l_ac].ineh001
                  AND inag002=g_ineh_d[l_ac].ineh003  #161017-00029#7 by 08172
                  AND inag004=g_ineh_d[l_ac].ineh004
                  AND inag005=g_ineh_d[l_ac].ineh005
                  AND inag007=g_ineh_d[l_ac].ineh008
               IF cl_null(g_ineh_d[l_ac].ineh010) THEN LET g_ineh_d[l_ac].ineh010=0 END IF
               IF cl_null(g_ineh_d[l_ac].ineh003) THEN LET g_ineh_d[l_ac].ineh003 = ' ' END IF  #161017-00029#7 by 08172               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aint805_ineh_t_mask_restore('restore_mask_o')
      
               UPDATE ineh_t SET (inehsite,inehdocno,inehseq,ineh001,ineh003,ineh002,ineh004,ineh005, 
                   ineh006,ineh007,ineh008,ineh010,ineh011,ineh012,ineh013,ineh014,ineh009,ineh015,ineh016, 
                   ineh017,ineh018,ineh019,inehunit) = (g_ineg_m.inegsite,g_ineg_m.inegdocno,g_ineh_d[l_ac].inehseq, 
                   g_ineh_d[l_ac].ineh001,g_ineh_d[l_ac].ineh003,g_ineh_d[l_ac].ineh002,g_ineh_d[l_ac].ineh004, 
                   g_ineh_d[l_ac].ineh005,g_ineh_d[l_ac].ineh006,g_ineh_d[l_ac].ineh007,g_ineh_d[l_ac].ineh008, 
                   g_ineh_d[l_ac].ineh010,g_ineh_d[l_ac].ineh011,g_ineh_d[l_ac].ineh012,g_ineh_d[l_ac].ineh013, 
                   g_ineh_d[l_ac].ineh014,g_ineh_d[l_ac].ineh009,g_ineh_d[l_ac].ineh015,g_ineh_d[l_ac].ineh016, 
                   g_ineh_d[l_ac].ineh017,g_ineh_d[l_ac].ineh018,g_ineh_d[l_ac].ineh019,g_ineh_d[l_ac].inehunit) 
 
                WHERE inehent = g_enterprise AND inehsite = g_ineg_m.inegsite 
                  AND inehdocno = g_ineg_m.inegdocno 
 
                  AND inehseq = g_ineh_d_t.inehseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_ineh_d[l_ac].* = g_ineh_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ineh_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_ineh_d[l_ac].* = g_ineh_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ineh_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ineg_m.inegsite
               LET gs_keys_bak[1] = g_inegsite_t
               LET gs_keys[2] = g_ineg_m.inegdocno
               LET gs_keys_bak[2] = g_inegdocno_t
               LET gs_keys[3] = g_ineh_d[g_detail_idx].inehseq
               LET gs_keys_bak[3] = g_ineh_d_t.inehseq
               CALL aint805_update_b('ineh_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aint805_ineh_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_ineh_d[g_detail_idx].inehseq = g_ineh_d_t.inehseq 
 
                  ) THEN
                  LET gs_keys[01] = g_ineg_m.inegsite
                  LET gs_keys[gs_keys.getLength()+1] = g_ineg_m.inegdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_ineh_d_t.inehseq
 
                  CALL aint805_key_update_b(gs_keys,'ineh_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_ineg_m),util.JSON.stringify(g_ineh_d_t)
               LET g_log2 = util.JSON.stringify(g_ineg_m),util.JSON.stringify(g_ineh_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aint805_unlock_b("ineh_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            CALL aint805_b_fill()   #161017-00029#7 by 08172
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            CALL aint805_b_fill()   #161017-00029#7 by 08172
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_ineh_d[li_reproduce_target].* = g_ineh_d[li_reproduce].*
 
               LET g_ineh_d[li_reproduce_target].inehseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_ineh_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_ineh_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="aint805.input.other" >}
      
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
            NEXT FIELD inegsite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD inehseq
 
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
 
{<section id="aint805.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aint805_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aint805_b_fill() #單身填充
      CALL aint805_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aint805_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"

            
            
   #end add-point
   
   #遮罩相關處理
   LET g_ineg_m_mask_o.* =  g_ineg_m.*
   CALL aint805_ineg_t_mask()
   LET g_ineg_m_mask_n.* =  g_ineg_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_ineg_m.inegsite,g_ineg_m.inegsite_desc,g_ineg_m.inegdocdt,g_ineg_m.inegdocno,g_ineg_m.ineg002, 
       g_ineg_m.ineg002_desc,g_ineg_m.ineg004,g_ineg_m.ineg004_desc,g_ineg_m.ineg005,g_ineg_m.ineg005_desc, 
       g_ineg_m.ineg003,g_ineg_m.ineg006,g_ineg_m.ineg006_desc,g_ineg_m.ineg007,g_ineg_m.ineg007_desc, 
       g_ineg_m.ineg008,g_ineg_m.ineg008_desc,g_ineg_m.ineg010,g_ineg_m.ineg011,g_ineg_m.ineg001,g_ineg_m.inegunit, 
       g_ineg_m.inegstus,g_ineg_m.inegownid,g_ineg_m.inegownid_desc,g_ineg_m.inegcrtdp,g_ineg_m.inegcrtdp_desc, 
       g_ineg_m.inegowndp,g_ineg_m.inegowndp_desc,g_ineg_m.inegcrtdt,g_ineg_m.inegcrtid,g_ineg_m.inegcrtid_desc, 
       g_ineg_m.inegmodid,g_ineg_m.inegmodid_desc,g_ineg_m.inegcnfdt,g_ineg_m.inegmoddt,g_ineg_m.inegpstid, 
       g_ineg_m.inegpstid_desc,g_ineg_m.inegcnfid,g_ineg_m.inegcnfid_desc,g_ineg_m.inegpstdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_ineg_m.inegstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
   FOR l_ac = 1 TO g_ineh_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
 
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aint805_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aint805.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aint805_detail_show()
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
 
{<section id="aint805.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aint805_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE ineg_t.inegsite 
   DEFINE l_oldno     LIKE ineg_t.inegsite 
   DEFINE l_newno02     LIKE ineg_t.inegdocno 
   DEFINE l_oldno02     LIKE ineg_t.inegdocno 
 
   DEFINE l_master    RECORD LIKE ineg_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE ineh_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_ineg_m.inegsite IS NULL
   OR g_ineg_m.inegdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_inegsite_t = g_ineg_m.inegsite
   LET g_inegdocno_t = g_ineg_m.inegdocno
 
    
   LET g_ineg_m.inegsite = ""
   LET g_ineg_m.inegdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_ineg_m.inegownid = g_user
      LET g_ineg_m.inegowndp = g_dept
      LET g_ineg_m.inegcrtid = g_user
      LET g_ineg_m.inegcrtdp = g_dept 
      LET g_ineg_m.inegcrtdt = cl_get_current()
      LET g_ineg_m.inegmodid = g_user
      LET g_ineg_m.inegmoddt = cl_get_current()
      LET g_ineg_m.inegstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
      LET g_ineg_m.inegcnfid = ""
      LET g_ineg_m.inegcnfdt = ""   
      LET g_ineg_m.inegpstid = ""
      LET g_ineg_m.inegpstdt = ""       
      LET g_ineg_m.inegstus = "N"
      LET g_ineg_m.inegsite=g_site
      LET g_ineg_m.ineg001='1'
      LET g_ineg_m.ineg002=""
      SELECT ooefl003 INTO g_ineg_m.inegsite_desc 
        FROM ooefl_t
       WHERE ooeflent=g_enterprise
         AND ooefl001=g_ineg_m.inegsite
         AND ooefl002=g_lang      
      LET g_ineg_m.inegdocdt=g_today
      LET g_ineg_m.ineg003=g_today
      LET g_ineg_m.ineg004=g_user     
      SELECT ooag003 INTO g_ineg_m.ineg005
        FROM ooag_t
       WHERE ooagent=g_enterprise
         AND ooag001=g_ineg_m.ineg004
      SELECT oofa011 INTO g_ineg_m.ineg004_desc
        FROM oofa_t
       WHERE oofa002='2'
         AND oofa003=g_ineg_m.ineg004
         AND oofaent = g_enterprise #add by geza 20160905 #160905-00007#5          
      SELECT ooefl003 INTO g_ineg_m.ineg005_desc
        FROM ooefl_t
       WHERE ooeflent=g_enterprise
         AND ooefl001=g_ineg_m.ineg005
         AND ooefl002=g_lang    
         
      LET g_ineg_m.ineg006=g_user   
      SELECT ooag003 INTO g_ineg_m.ineg007
        FROM ooag_t
       WHERE ooagent=g_enterprise
         AND ooag001=g_ineg_m.ineg006  
      SELECT oofa011 INTO g_ineg_m.ineg006_desc
        FROM oofa_t
       WHERE oofa002='2'
         AND oofa003=g_ineg_m.ineg006
         AND oofaent = g_enterprise #add by geza 20160905 #160905-00007#5          
      SELECT ooefl003 INTO g_ineg_m.ineg007_desc
        FROM ooefl_t
       WHERE ooeflent=g_enterprise
         AND ooefl001=g_ineg_m.ineg007
         AND ooefl002=g_lang       
         
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_ineg_m.inegownid
        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
        LET g_ineg_m.inegownid_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_ineg_m.inegownid_desc

        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_ineg_m.inegcrtdp
        CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_ineg_m.inegcrtdp_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_ineg_m.inegcrtdp_desc

        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_ineg_m.inegcrtid
        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
        LET g_ineg_m.inegcrtid_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_ineg_m.inegcrtid_desc

        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_ineg_m.inegowndp
        CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_ineg_m.inegowndp_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_ineg_m.inegowndp_desc

        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_ineg_m.inegmodid
        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
        LET g_ineg_m.inegmodid_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_ineg_m.inegmodid_desc

        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_ineg_m.inegcnfid
        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
        LET g_ineg_m.inegcnfid_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_ineg_m.inegcnfid_desc
        
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = g_ineg_m.inegpstid
        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
        LET g_ineg_m.inegpstid_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_ineg_m.inegpstid_desc 


   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_ineg_m.inegstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
      LET g_ineg_m.inegsite_desc = ''
   DISPLAY BY NAME g_ineg_m.inegsite_desc
 
   
   CALL aint805_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_ineg_m.* TO NULL
      INITIALIZE g_ineh_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aint805_show()
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
   CALL aint805_set_act_visible()   
   CALL aint805_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_inegsite_t = g_ineg_m.inegsite
   LET g_inegdocno_t = g_ineg_m.inegdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " inegent = " ||g_enterprise|| " AND",
                      " inegsite = '", g_ineg_m.inegsite, "' "
                      ," AND inegdocno = '", g_ineg_m.inegdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint805_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aint805_idx_chk()
   
   LET g_data_owner = g_ineg_m.inegownid      
   LET g_data_dept  = g_ineg_m.inegowndp
   
   #功能已完成,通報訊息中心
   CALL aint805_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aint805.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aint805_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE ineh_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aint805_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM ineh_t
    WHERE inehent = g_enterprise AND inehsite = g_inegsite_t
     AND inehdocno = g_inegdocno_t
 
    INTO TEMP aint805_detail
 
   #將key修正為調整後   
   UPDATE aint805_detail 
      #更新key欄位
      SET inehsite = g_ineg_m.inegsite
          , inehdocno = g_ineg_m.inegdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO ineh_t SELECT * FROM aint805_detail
   
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
   DROP TABLE aint805_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_inegsite_t = g_ineg_m.inegsite
   LET g_inegdocno_t = g_ineg_m.inegdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint805.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aint805_delete()
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
   
   IF g_ineg_m.inegsite IS NULL
   OR g_ineg_m.inegdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aint805_cl USING g_enterprise,g_ineg_m.inegsite,g_ineg_m.inegdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint805_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint805_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint805_master_referesh USING g_ineg_m.inegsite,g_ineg_m.inegdocno INTO g_ineg_m.inegsite, 
       g_ineg_m.inegdocdt,g_ineg_m.inegdocno,g_ineg_m.ineg002,g_ineg_m.ineg004,g_ineg_m.ineg005,g_ineg_m.ineg003, 
       g_ineg_m.ineg006,g_ineg_m.ineg007,g_ineg_m.ineg008,g_ineg_m.ineg010,g_ineg_m.ineg011,g_ineg_m.ineg001, 
       g_ineg_m.inegunit,g_ineg_m.inegstus,g_ineg_m.inegownid,g_ineg_m.inegcrtdp,g_ineg_m.inegowndp, 
       g_ineg_m.inegcrtdt,g_ineg_m.inegcrtid,g_ineg_m.inegmodid,g_ineg_m.inegcnfdt,g_ineg_m.inegmoddt, 
       g_ineg_m.inegpstid,g_ineg_m.inegcnfid,g_ineg_m.inegpstdt,g_ineg_m.inegsite_desc,g_ineg_m.ineg002_desc, 
       g_ineg_m.ineg004_desc,g_ineg_m.ineg005_desc,g_ineg_m.ineg006_desc,g_ineg_m.ineg007_desc,g_ineg_m.ineg008_desc, 
       g_ineg_m.inegownid_desc,g_ineg_m.inegcrtdp_desc,g_ineg_m.inegowndp_desc,g_ineg_m.inegcrtid_desc, 
       g_ineg_m.inegmodid_desc,g_ineg_m.inegpstid_desc,g_ineg_m.inegcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aint805_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_ineg_m_mask_o.* =  g_ineg_m.*
   CALL aint805_ineg_t_mask()
   LET g_ineg_m_mask_n.* =  g_ineg_m.*
   
   CALL aint805_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aint805_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_inegsite_t = g_ineg_m.inegsite
      LET g_inegdocno_t = g_ineg_m.inegdocno
 
 
      DELETE FROM ineg_t
       WHERE inegent = g_enterprise AND inegsite = g_ineg_m.inegsite
         AND inegdocno = g_ineg_m.inegdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_ineg_m.inegsite,":",SQLERRMESSAGE  
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
      
      DELETE FROM ineh_t
       WHERE inehent = g_enterprise AND inehsite = g_ineg_m.inegsite
         AND inehdocno = g_ineg_m.inegdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ineh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_ineg_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aint805_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_ineh_d.clear() 
 
     
      CALL aint805_ui_browser_refresh()  
      #CALL aint805_ui_headershow()  
      #CALL aint805_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aint805_browser_fill("")
         CALL aint805_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aint805_cl
 
   #功能已完成,通報訊息中心
   CALL aint805_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aint805.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aint805_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_success   LIKE type_t.num5   #161017-00029#7 by 08172
   DEFINE l_inaa007   LIKE inaa_t.inaa007   #161222-00014#1 add by cheng 161222
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
 
   #end add-point
   
   #清空第一階單身
   CALL g_ineh_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aint805_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT inehseq,ineh001,ineh003,ineh002,ineh004,ineh005,ineh006,ineh007, 
             ineh008,ineh010,ineh011,ineh012,ineh013,ineh014,ineh009,ineh015,ineh016,ineh017,ineh018, 
             ineh019,inehunit ,t1.imaal003 ,t2.imaal004 ,t3.inaa002 ,t4.oocal003 FROM ineh_t",   
                     " INNER JOIN ineg_t ON inegent = " ||g_enterprise|| " AND inegsite = inehsite ",
                     " AND inegdocno = inehdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=ineh001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=ineh001 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inaa_t t3 ON t3.inaaent="||g_enterprise||" AND t3.inaasite=inehsite AND t3.inaa001=ineh004  ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=ineh008 AND t4.oocal002='"||g_dlang||"' ",
 
                     " WHERE inehent=? AND inehsite=? AND inehdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
 
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY ineh_t.inehseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint805_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aint805_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_ineg_m.inegsite,g_ineg_m.inegdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_ineg_m.inegsite,g_ineg_m.inegdocno INTO g_ineh_d[l_ac].inehseq, 
          g_ineh_d[l_ac].ineh001,g_ineh_d[l_ac].ineh003,g_ineh_d[l_ac].ineh002,g_ineh_d[l_ac].ineh004, 
          g_ineh_d[l_ac].ineh005,g_ineh_d[l_ac].ineh006,g_ineh_d[l_ac].ineh007,g_ineh_d[l_ac].ineh008, 
          g_ineh_d[l_ac].ineh010,g_ineh_d[l_ac].ineh011,g_ineh_d[l_ac].ineh012,g_ineh_d[l_ac].ineh013, 
          g_ineh_d[l_ac].ineh014,g_ineh_d[l_ac].ineh009,g_ineh_d[l_ac].ineh015,g_ineh_d[l_ac].ineh016, 
          g_ineh_d[l_ac].ineh017,g_ineh_d[l_ac].ineh018,g_ineh_d[l_ac].ineh019,g_ineh_d[l_ac].inehunit, 
          g_ineh_d[l_ac].ineh001_desc,g_ineh_d[l_ac].ineh001_desc_desc,g_ineh_d[l_ac].ineh004_desc,g_ineh_d[l_ac].ineh008_desc  
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
       #huangrh 20150615---modify---盤點流程不使用批號   
       LET g_ineh_d[l_ac].amount1=g_ineh_d[l_ac].ineh009*g_ineh_d[l_ac].ineh016
       LET g_ineh_d[l_ac].amount2=g_ineh_d[l_ac].ineh009*g_ineh_d[l_ac].ineh017         
       #161222-00014#1 add by cheng 161222 ---s---
       SELECT inaa007 INTO l_inaa007 FROM inaa_t,ineh_t WHERE inaaent=g_enterprise AND inaasite=inehsite AND inaa001=g_ineh_d[l_ac].ineh004
       IF l_inaa007 = '5' THEN 
          SELECT SUM(ineh009) INTO g_ineh_d[l_ac].amount
            FROM ineh_t,ineg_t
           WHERE inehent=inegent
             AND inehsite=inegsite
             AND inehdocno=inegdocno
             AND inehent=g_enterprise
             AND inehsite=g_ineg_m.inegsite
             AND ineg001='1'
             AND inegstus<>'X'
             AND ineg002=g_ineg_m.ineg002
             AND ineh001=g_ineh_d[l_ac].ineh001
             AND ineh003=g_ineh_d[l_ac].ineh003
             AND ineh004=g_ineh_d[l_ac].ineh004
             AND ineh008=g_ineh_d[l_ac].ineh008
          IF cl_null(g_ineh_d[l_ac].amount) THEN  LET g_ineh_d[l_ac].amount=0  END IF 
          DISPLAY g_ineh_d[l_ac].amount TO amount
       ELSE
       #161222-00014#1 add by cheng 161222 ---e---  
          SELECT SUM(ineh009) INTO g_ineh_d[l_ac].amount
            FROM ineh_t,ineg_t
           WHERE inehent=inegent
             AND inehsite=inegsite
             AND inehdocno=inegdocno
             AND inehent=g_enterprise
             AND inehsite=g_ineg_m.inegsite
             AND ineg001='1'
             AND inegstus<>'X'
             AND ineg002=g_ineg_m.ineg002
             AND ineh001=g_ineh_d[l_ac].ineh001
             AND ineh003=g_ineh_d[l_ac].ineh003    #161017-00029#7 by 08172
             AND ineh004=g_ineh_d[l_ac].ineh004
             AND ineh005=g_ineh_d[l_ac].ineh005
#             AND ineh006=g_ineh_d[l_ac].ineh006
             AND ineh008=g_ineh_d[l_ac].ineh008
          IF cl_null(g_ineh_d[l_ac].amount) THEN  LET g_ineh_d[l_ac].amount=0  END IF 
          DISPLAY g_ineh_d[l_ac].amount TO amount
         END IF         #161222-00014#1 add by cheng 161222
       IF cl_null(g_ineh_d[l_ac].amount) THEN  LET g_ineh_d[l_ac].amount=0  END IF   
       IF cl_null(g_ineh_d[l_ac].amount1) THEN LET g_ineh_d[l_ac].amount1=0 END IF
       IF cl_null(g_ineh_d[l_ac].amount2) THEN LET g_ineh_d[l_ac].amount2=0 END IF  
          
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_ineh_d[l_ac].ineh004
       CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_ineh_d[l_ac].ineh004_desc = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_ineh_d[l_ac].ineh004_desc
       #161017-00029#7 -s by 08172
       CALL s_feature_description(g_ineh_d[l_ac].ineh001,g_ineh_d[l_ac].ineh003) 
                RETURNING l_success,g_ineh_d[l_ac].ineh003_desc
       #161017-00029#7 -e by 08172                
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
   
   CALL g_ineh_d.deleteElement(g_ineh_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aint805_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_ineh_d.getLength()
      LET g_ineh_d_mask_o[l_ac].* =  g_ineh_d[l_ac].*
      CALL aint805_ineh_t_mask()
      LET g_ineh_d_mask_n[l_ac].* =  g_ineh_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aint805.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aint805_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM ineh_t
       WHERE inehent = g_enterprise AND
         inehsite = ps_keys_bak[1] AND inehdocno = ps_keys_bak[2] AND inehseq = ps_keys_bak[3]
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
         CALL g_ineh_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint805.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aint805_insert_b(ps_table,ps_keys,ps_page)
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
       #賬面數量
       LET g_ineh_d[g_detail_idx].ineh010=''
       SELECT SUM(inag008) INTO g_ineh_d[g_detail_idx].ineh010
         FROM inag_t
        WHERE inagent=g_enterprise
          AND inagsite=ps_keys[1]
          AND inag001=g_ineh_d[g_detail_idx].ineh001
          AND inag002=g_ineh_d[g_detail_idx].ineh003  #161017-00029#7 by 08172
          AND inag004=g_ineh_d[g_detail_idx].ineh004
          AND inag005=g_ineh_d[g_detail_idx].ineh005
          AND inag007=g_ineh_d[g_detail_idx].ineh008
       IF cl_null(g_ineh_d[g_detail_idx].ineh010) THEN LET g_ineh_d[g_detail_idx].ineh010=0 END IF
      IF cl_null(g_ineh_d[g_detail_idx].ineh003) THEN LET g_ineh_d[g_detail_idx].ineh003 = ' ' END IF  #161017-00029#7 by 08172       
      #end add-point 
      INSERT INTO ineh_t
                  (inehent,
                   inehsite,inehdocno,
                   inehseq
                   ,ineh001,ineh003,ineh002,ineh004,ineh005,ineh006,ineh007,ineh008,ineh010,ineh011,ineh012,ineh013,ineh014,ineh009,ineh015,ineh016,ineh017,ineh018,ineh019,inehunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_ineh_d[g_detail_idx].ineh001,g_ineh_d[g_detail_idx].ineh003,g_ineh_d[g_detail_idx].ineh002, 
                       g_ineh_d[g_detail_idx].ineh004,g_ineh_d[g_detail_idx].ineh005,g_ineh_d[g_detail_idx].ineh006, 
                       g_ineh_d[g_detail_idx].ineh007,g_ineh_d[g_detail_idx].ineh008,g_ineh_d[g_detail_idx].ineh010, 
                       g_ineh_d[g_detail_idx].ineh011,g_ineh_d[g_detail_idx].ineh012,g_ineh_d[g_detail_idx].ineh013, 
                       g_ineh_d[g_detail_idx].ineh014,g_ineh_d[g_detail_idx].ineh009,g_ineh_d[g_detail_idx].ineh015, 
                       g_ineh_d[g_detail_idx].ineh016,g_ineh_d[g_detail_idx].ineh017,g_ineh_d[g_detail_idx].ineh018, 
                       g_ineh_d[g_detail_idx].ineh019,g_ineh_d[g_detail_idx].inehunit)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ineh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_ineh_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aint805.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aint805_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "ineh_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      IF cl_null(g_ineh_d[g_detail_idx].ineh003) THEN LET g_ineh_d[g_detail_idx].ineh003 = ' ' END IF  #161017-00029#7 by 08172
      #end add-point 
      
      #將遮罩欄位還原
      CALL aint805_ineh_t_mask_restore('restore_mask_o')
               
      UPDATE ineh_t 
         SET (inehsite,inehdocno,
              inehseq
              ,ineh001,ineh003,ineh002,ineh004,ineh005,ineh006,ineh007,ineh008,ineh010,ineh011,ineh012,ineh013,ineh014,ineh009,ineh015,ineh016,ineh017,ineh018,ineh019,inehunit) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_ineh_d[g_detail_idx].ineh001,g_ineh_d[g_detail_idx].ineh003,g_ineh_d[g_detail_idx].ineh002, 
                  g_ineh_d[g_detail_idx].ineh004,g_ineh_d[g_detail_idx].ineh005,g_ineh_d[g_detail_idx].ineh006, 
                  g_ineh_d[g_detail_idx].ineh007,g_ineh_d[g_detail_idx].ineh008,g_ineh_d[g_detail_idx].ineh010, 
                  g_ineh_d[g_detail_idx].ineh011,g_ineh_d[g_detail_idx].ineh012,g_ineh_d[g_detail_idx].ineh013, 
                  g_ineh_d[g_detail_idx].ineh014,g_ineh_d[g_detail_idx].ineh009,g_ineh_d[g_detail_idx].ineh015, 
                  g_ineh_d[g_detail_idx].ineh016,g_ineh_d[g_detail_idx].ineh017,g_ineh_d[g_detail_idx].ineh018, 
                  g_ineh_d[g_detail_idx].ineh019,g_ineh_d[g_detail_idx].inehunit) 
         WHERE inehent = g_enterprise AND inehsite = ps_keys_bak[1] AND inehdocno = ps_keys_bak[2] AND inehseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ineh_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ineh_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aint805_ineh_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aint805.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aint805_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aint805.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aint805_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aint805.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aint805_lock_b(ps_table,ps_page)
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
   #CALL aint805_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "ineh_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aint805_bcl USING g_enterprise,
                                       g_ineg_m.inegsite,g_ineg_m.inegdocno,g_ineh_d[g_detail_idx].inehseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint805_bcl:",SQLERRMESSAGE 
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
 
{<section id="aint805.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aint805_unlock_b(ps_table,ps_page)
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
      CLOSE aint805_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aint805.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aint805_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("inegdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("inegsite,inegdocno",TRUE)
      CALL cl_set_comp_entry("inegdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("ineg002",TRUE)
      CALL cl_set_comp_entry("inegsite",TRUE)
      CALL cl_set_comp_required('inegsite',TRUE)     
      CALL cl_set_comp_entry("ineg008",TRUE)
      CALL cl_set_comp_required('ineg008',TRUE)      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint805.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aint805_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_count LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("inegsite,inegdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      LET l_count=0
      SELECT count(*) INTO l_count
       FROM ineh_t
      WHERE inehent=g_enterprise
        AND inehdocno=g_ineg_m.inegdocno  
      IF NOT cl_null(l_count) AND l_count>0 THEN   
         CALL cl_set_comp_entry("ineg002",FALSE)
      END IF
      CALL cl_set_comp_required('ineg008',FALSE)        
      CALL cl_set_comp_entry("ineg008",FALSE)      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("inegdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("inegdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT s_aooi500_comp_entry(g_prog,'inegsite') OR g_site_flag THEN
      CALL cl_set_comp_entry("inegsite",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint805.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aint805_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("ineh003",TRUE)  #161017-00029#7 by 08172
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aint805.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aint805_set_no_entry_b(p_cmd)
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
   #161017-00029#7 -s by 08172
   #當料件有使用產品特徵功能時此欄位才可輸入
   LET g_imaa005  = ''
   CALL aint805_get_imaa005(g_ineh_d[l_ac].ineh001) RETURNING g_imaa005
   IF cl_null(g_imaa005) THEN
      CALL cl_set_comp_entry("ineh003",FALSE)
   END IF
   #161017-00029#7 -e by 08172
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aint805.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aint805_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint805.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aint805_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_ineg_m.inegstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint805.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aint805_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint805.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aint805_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint805.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aint805_default_search()
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
      LET ls_wc = ls_wc, " inegsite = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " inegdocno = '", g_argv[02], "' AND "
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
               WHEN la_wc[li_idx].tableid = "ineg_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "ineh_t" 
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
 
{<section id="aint805.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aint805_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_errno        LIKE type_t.chr100
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_ineg_m.inegstus='X' THEN
      RETURN
   END IF 
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_ineg_m.inegsite IS NULL
      OR g_ineg_m.inegdocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aint805_cl USING g_enterprise,g_ineg_m.inegsite,g_ineg_m.inegdocno
   IF STATUS THEN
      CLOSE aint805_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint805_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aint805_master_referesh USING g_ineg_m.inegsite,g_ineg_m.inegdocno INTO g_ineg_m.inegsite, 
       g_ineg_m.inegdocdt,g_ineg_m.inegdocno,g_ineg_m.ineg002,g_ineg_m.ineg004,g_ineg_m.ineg005,g_ineg_m.ineg003, 
       g_ineg_m.ineg006,g_ineg_m.ineg007,g_ineg_m.ineg008,g_ineg_m.ineg010,g_ineg_m.ineg011,g_ineg_m.ineg001, 
       g_ineg_m.inegunit,g_ineg_m.inegstus,g_ineg_m.inegownid,g_ineg_m.inegcrtdp,g_ineg_m.inegowndp, 
       g_ineg_m.inegcrtdt,g_ineg_m.inegcrtid,g_ineg_m.inegmodid,g_ineg_m.inegcnfdt,g_ineg_m.inegmoddt, 
       g_ineg_m.inegpstid,g_ineg_m.inegcnfid,g_ineg_m.inegpstdt,g_ineg_m.inegsite_desc,g_ineg_m.ineg002_desc, 
       g_ineg_m.ineg004_desc,g_ineg_m.ineg005_desc,g_ineg_m.ineg006_desc,g_ineg_m.ineg007_desc,g_ineg_m.ineg008_desc, 
       g_ineg_m.inegownid_desc,g_ineg_m.inegcrtdp_desc,g_ineg_m.inegowndp_desc,g_ineg_m.inegcrtid_desc, 
       g_ineg_m.inegmodid_desc,g_ineg_m.inegpstid_desc,g_ineg_m.inegcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aint805_action_chk() THEN
      CLOSE aint805_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_ineg_m.inegsite,g_ineg_m.inegsite_desc,g_ineg_m.inegdocdt,g_ineg_m.inegdocno,g_ineg_m.ineg002, 
       g_ineg_m.ineg002_desc,g_ineg_m.ineg004,g_ineg_m.ineg004_desc,g_ineg_m.ineg005,g_ineg_m.ineg005_desc, 
       g_ineg_m.ineg003,g_ineg_m.ineg006,g_ineg_m.ineg006_desc,g_ineg_m.ineg007,g_ineg_m.ineg007_desc, 
       g_ineg_m.ineg008,g_ineg_m.ineg008_desc,g_ineg_m.ineg010,g_ineg_m.ineg011,g_ineg_m.ineg001,g_ineg_m.inegunit, 
       g_ineg_m.inegstus,g_ineg_m.inegownid,g_ineg_m.inegownid_desc,g_ineg_m.inegcrtdp,g_ineg_m.inegcrtdp_desc, 
       g_ineg_m.inegowndp,g_ineg_m.inegowndp_desc,g_ineg_m.inegcrtdt,g_ineg_m.inegcrtid,g_ineg_m.inegcrtid_desc, 
       g_ineg_m.inegmodid,g_ineg_m.inegmodid_desc,g_ineg_m.inegcnfdt,g_ineg_m.inegmoddt,g_ineg_m.inegpstid, 
       g_ineg_m.inegpstid_desc,g_ineg_m.inegcnfid,g_ineg_m.inegcnfid_desc,g_ineg_m.inegpstdt
 
   CASE g_ineg_m.inegstus
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "S"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
         CASE g_ineg_m.inegstus
            
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "S"
               HIDE OPTION "posted"
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
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("posted,unposted",FALSE)
         CASE g_ineg_m.inegstus
            WHEN "N"
               #HIDE OPTION "open"
               CALL cl_set_act_visible("unconfirmed,posted,unposted",FALSE)

            WHEN "S"
               #HIDE OPTION "posted"
               CALL cl_set_act_visible("unconfirmed,posted,invalid,confirmed",FALSE)

            WHEN "X"
               #HIDE OPTION "invalid"
               CALL cl_set_act_visible("unconfirmed,posted,invalid,confirmed,unposted",FALSE)

            WHEN "Y"
               #HIDE OPTION "confirmed"
               CALL cl_set_act_visible("invalid,confirmed,unposted",FALSE)

         END CASE
         
         
         CALL cl_set_act_visible("unconfirmed,invalid,confirmed,posted,withdraw,rejection,signing,unposted",TRUE)
         CASE g_ineg_m.inegstus
            WHEN "N"
               #HIDE OPTION "open"
               CALL cl_set_act_visible("unconfirmed,posted,withdraw,rejection,signing,unposted",FALSE)
               #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
               IF cl_bpm_chk() THEN
                   CALL cl_set_act_visible("signing",TRUE)
               END IF

            WHEN "S"
               #HIDE OPTION "posted"
               CALL cl_set_act_visible("unconfirmed,invalid,confirmed,posted,withdraw,rejection,signing",FALSE)

            WHEN "X"
               #HIDE OPTION "invalid"
               CALL cl_set_act_visible("invalid,unconfirmed,confirmed,posted,unposted,withdraw,rejection,signing",FALSE)

            WHEN "Y"
               #HIDE OPTION "confirmed"
               CALL cl_set_act_visible("invalid,confirmed,unposted,withdraw,rejection,signing",FALSE)

            WHEN "A"
               CALL cl_set_act_visible("invalid,unconfirmed,posted,withdraw,rejection,signing",FALSE)

            WHEN "D"
               CALL cl_set_act_visible("linvaid,unconfirmed,confirmed,posted,withdraw,rejection,signing",FALSE)

            WHEN "R"
               CALL cl_set_act_visible("unconfirmed,confirmed,posted,withdraw,rejection,signing",FALSE)

            WHEN "W"
               CALL cl_set_act_visible("invalid,unconfirmed,confirmed,posted,rejection,signing",FALSE)
         END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aint805_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint805_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aint805_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint805_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION posted
         IF cl_auth_chk_act("posted") THEN
            LET lc_state = "S"
            #add-point:action控制 name="statechange.posted"
            
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
       ON ACTION unposted 
          IF cl_auth_chk_act("unposted") THEN    #151027-00016#2 20151112 add by beckxie
             LET lc_state = "1"
          END IF   #151027-00016#2 20151112 add by beckxie
          EXIT MENU

      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "Y" 
      AND lc_state <> "N"
      AND lc_state <> "S"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_ineg_m.inegstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aint805_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   LET g_ineg_m.inegcnfdt=cl_get_current()
   LET g_ineg_m.inegpstdt=cl_get_current()
   LET g_ineg_m.inegmoddt=cl_get_current()
   CASE lc_state 
      WHEN 'Y' 

         CALL s_aint805_conf_chk(g_ineg_m.inegdocno,lc_state) RETURNING l_success,l_errno
         
         IF l_success THEN
            IF cl_ask_confirm('lib-014') THEN
               CALL s_transaction_begin()
               CALL s_aint805_conf_upd(g_ineg_m.inegdocno,lc_state) RETURNING l_success,l_errno
               UPDATE ineg_t SET inegcnfid = g_user,inegcnfdt=g_ineg_m.inegcnfdt
                    WHERE inegent = g_enterprise AND inegdocno = g_ineg_m.inegdocno AND inegsite=g_ineg_m.inegsite              
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_ineg_m.inegdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
               RETURN            
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_ineg_m.inegdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN            
         END IF  
         
      WHEN 'N' 
            
         CALL s_aint805_conf_chk(g_ineg_m.inegdocno,lc_state) RETURNING l_success,l_errno
         
         IF l_success THEN
            IF cl_ask_confirm('lib-015') THEN
               CALL s_transaction_begin()
               CALL s_aint805_conf_upd(g_ineg_m.inegdocno,lc_state) RETURNING l_success,l_errno
               UPDATE ineg_t SET inegcnfid ='',inegcnfdt=''
                    WHERE inegent = g_enterprise AND inegdocno = g_ineg_m.inegdocno AND inegsite=g_ineg_m.inegsite              
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_ineg_m.inegdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')                  
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
               RETURN            
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_ineg_m.inegdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN            
         END IF       
         
         
      WHEN 'X'

         CALL s_aint805_conf_chk(g_ineg_m.inegdocno,lc_state) RETURNING l_success,l_errno
         
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_aint805_conf_upd(g_ineg_m.inegdocno,lc_state) RETURNING l_success,l_errno
               UPDATE ineg_t SET inegmodid =g_user,inegmoddt=g_ineg_m.inegmoddt
                    WHERE inegent = g_enterprise AND inegdocno = g_ineg_m.inegdocno AND inegsite=g_ineg_m.inegsite                
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_ineg_m.inegdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')                 
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
               RETURN            
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_ineg_m.inegdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN            
         END IF      


      WHEN 'S'
            
         CALL s_aint805_conf_chk(g_ineg_m.inegdocno,lc_state) RETURNING l_success,l_errno
         
         IF l_success THEN
            IF cl_ask_confirm('sub-00232') THEN
               CALL s_transaction_begin()
               CALL s_aint805_conf_upd(g_ineg_m.inegdocno,lc_state) RETURNING l_success,l_errno  
               UPDATE ineg_t SET inegpstid =g_user,inegpstdt=g_ineg_m.inegpstdt
                    WHERE inegent = g_enterprise AND inegdocno = g_ineg_m.inegdocno AND inegsite=g_ineg_m.inegsite                
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_ineg_m.inegdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
               RETURN            
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_ineg_m.inegdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN            
         END IF       
         
         
      WHEN '1'
            
         CALL s_aint805_conf_chk(g_ineg_m.inegdocno,lc_state) RETURNING l_success,l_errno
         
         IF l_success THEN
            IF cl_ask_confirm('sub-00233') THEN
               CALL s_transaction_begin()
               CALL s_aint805_conf_upd(g_ineg_m.inegdocno,lc_state) RETURNING l_success,l_errno  
               UPDATE ineg_t SET inegpstid ='',inegpstdt=''
                    WHERE inegent = g_enterprise AND inegdocno = g_ineg_m.inegdocno AND inegsite=g_ineg_m.inegsite                 
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_ineg_m.inegdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
               RETURN            
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_ineg_m.inegdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN            
         END IF       
                      

     OTHERWISE 
         EXIT CASE          
   END CASE              
   #end add-point
   
   LET g_ineg_m.inegmodid = g_user
   LET g_ineg_m.inegmoddt = cl_get_current()
   LET g_ineg_m.inegstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE ineg_t 
      SET (inegstus,inegmodid,inegmoddt) 
        = (g_ineg_m.inegstus,g_ineg_m.inegmodid,g_ineg_m.inegmoddt)     
    WHERE inegent = g_enterprise AND inegsite = g_ineg_m.inegsite
      AND inegdocno = g_ineg_m.inegdocno
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
      EXECUTE aint805_master_referesh USING g_ineg_m.inegsite,g_ineg_m.inegdocno INTO g_ineg_m.inegsite, 
          g_ineg_m.inegdocdt,g_ineg_m.inegdocno,g_ineg_m.ineg002,g_ineg_m.ineg004,g_ineg_m.ineg005,g_ineg_m.ineg003, 
          g_ineg_m.ineg006,g_ineg_m.ineg007,g_ineg_m.ineg008,g_ineg_m.ineg010,g_ineg_m.ineg011,g_ineg_m.ineg001, 
          g_ineg_m.inegunit,g_ineg_m.inegstus,g_ineg_m.inegownid,g_ineg_m.inegcrtdp,g_ineg_m.inegowndp, 
          g_ineg_m.inegcrtdt,g_ineg_m.inegcrtid,g_ineg_m.inegmodid,g_ineg_m.inegcnfdt,g_ineg_m.inegmoddt, 
          g_ineg_m.inegpstid,g_ineg_m.inegcnfid,g_ineg_m.inegpstdt,g_ineg_m.inegsite_desc,g_ineg_m.ineg002_desc, 
          g_ineg_m.ineg004_desc,g_ineg_m.ineg005_desc,g_ineg_m.ineg006_desc,g_ineg_m.ineg007_desc,g_ineg_m.ineg008_desc, 
          g_ineg_m.inegownid_desc,g_ineg_m.inegcrtdp_desc,g_ineg_m.inegowndp_desc,g_ineg_m.inegcrtid_desc, 
          g_ineg_m.inegmodid_desc,g_ineg_m.inegpstid_desc,g_ineg_m.inegcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_ineg_m.inegsite,g_ineg_m.inegsite_desc,g_ineg_m.inegdocdt,g_ineg_m.inegdocno, 
          g_ineg_m.ineg002,g_ineg_m.ineg002_desc,g_ineg_m.ineg004,g_ineg_m.ineg004_desc,g_ineg_m.ineg005, 
          g_ineg_m.ineg005_desc,g_ineg_m.ineg003,g_ineg_m.ineg006,g_ineg_m.ineg006_desc,g_ineg_m.ineg007, 
          g_ineg_m.ineg007_desc,g_ineg_m.ineg008,g_ineg_m.ineg008_desc,g_ineg_m.ineg010,g_ineg_m.ineg011, 
          g_ineg_m.ineg001,g_ineg_m.inegunit,g_ineg_m.inegstus,g_ineg_m.inegownid,g_ineg_m.inegownid_desc, 
          g_ineg_m.inegcrtdp,g_ineg_m.inegcrtdp_desc,g_ineg_m.inegowndp,g_ineg_m.inegowndp_desc,g_ineg_m.inegcrtdt, 
          g_ineg_m.inegcrtid,g_ineg_m.inegcrtid_desc,g_ineg_m.inegmodid,g_ineg_m.inegmodid_desc,g_ineg_m.inegcnfdt, 
          g_ineg_m.inegmoddt,g_ineg_m.inegpstid,g_ineg_m.inegpstid_desc,g_ineg_m.inegcnfid,g_ineg_m.inegcnfid_desc, 
          g_ineg_m.inegpstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aint805_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint805_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint805.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aint805_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_ineh_d.getLength() THEN
         LET g_detail_idx = g_ineh_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_ineh_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_ineh_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aint805.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aint805_b_fill2(pi_idx)
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
   
   CALL aint805_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aint805.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aint805_fill_chk(ps_idx)
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
 
{<section id="aint805.status_show" >}
PRIVATE FUNCTION aint805_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aint805.mask_functions" >}
&include "erp/ain/aint805_mask.4gl"
 
{</section>}
 
{<section id="aint805.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aint805_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aint805_show()
   CALL aint805_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_ineg_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_ineh_d))
 
 
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
   #CALL aint805_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aint805_ui_headershow()
   CALL aint805_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aint805_draw_out()
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
   CALL aint805_ui_headershow()  
   CALL aint805_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aint805.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aint805_set_pk_array()
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
   LET g_pk_array[1].values = g_ineg_m.inegsite
   LET g_pk_array[1].column = 'inegsite'
   LET g_pk_array[2].values = g_ineg_m.inegdocno
   LET g_pk_array[2].column = 'inegdocno'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint805.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aint805.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aint805_msgcentre_notify(lc_state)
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
   CALL aint805_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_ineg_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint805.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aint805_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#18-s
   SELECT inegstus INTO g_ineg_m.inegstus FROM ineg_t
    WHERE inegent = g_enterprise
      AND inegsite = g_site
      AND inegdocno = g_ineg_m.inegdocno
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_ineg_m.inegstus
        WHEN 'W'
           LET g_errno = 'sub-01347'
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
        LET g_errparam.extend = g_ineg_m.inegdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aint805_set_act_visible()
        CALL aint805_set_act_no_visible()
        CALL aint805_show()
        RETURN FALSE
     END IF
   END IF      
   #160818-00017#18-e
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint805.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 盤點計劃的檢查
# Memo...........:
# Usage..........: CALL aint805_check(p_ineg002,p_inegsite)
#                  RETURNING r_success
# Input parameter: p_ineg002       盤點計劃
#                : p_inegsite      盤點組織
# Return code....: r_success       TRUE/FASE
# Date & Author..: 20140319 By huangrh
# Modify.........:
################################################################################
PUBLIC FUNCTION aint805_check(p_ineg002,p_inegsite)
DEFINE p_ineg002          LIKE ineg_t.ineg002
DEFINE p_inegsite         LIKE ineg_t.inegsite
DEFINE l_ined003          LIKE ined_t.ined003
DEFINE l_ined004          LIKE ined_t.ined004
DEFINE l_ined005          LIKE ined_t.ined005
DEFINE l_gzcbl004         LIKE gzcbl_t.gzcbl004
DEFINE l_gzze003          LIKE gzze_t.gzze003
DEFINE l_str              LIKE type_t.chr500
DEFINE l_ooef004          LIKE ooef_t.ooef004
DEFINE l_success          LIKE type_t.chr1
DEFINE r_success          LIKE type_t.num5
DEFINE l_inebstus         LIKE ineb_t.inebstus
DEFINE l_errno            STRING
   
   LET r_success=TRUE
   IF cl_null(p_ineg002) OR cl_null(p_inegsite) THEN
      LET r_success=FALSE
      RETURN r_success
   END IF
#盤點計劃生效門店範圍
   LET l_inebstus=''
   LET l_errno=''
   #SELECT l_inebstus INTO l_inebstus        #160818-00017#18 mark 
   SELECT DISTINCT inebstus INTO l_inebstus  #160818-00017#18
     FROM inea_t,ineb_t
    WHERE ineaent=inebent
      AND ineadocno=inebdocno
      AND ineadocno=p_ineg002
      AND ineb001=p_inegsite   
      AND inebent=g_enterprise  #160818-00017#18      
   CASE
      WHEN SQLCA.sqlcode = 100     LET l_errno = 'ain-00116'
      WHEN l_inebstus <> 'Y'       LET l_errno = 'ain-00117'
      OTHERWISE LET l_errno = SQLCA.sqlcode USING '---------'
   END CASE
   IF NOT cl_null(l_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = p_ineg002
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success=FALSE
      RETURN r_success
   END IF
    

   #盤點計劃已作廢
   LET l_ined005=''
   SELECT ined005 INTO l_ined005
     FROM ined_t
    WHERE inedent= g_enterprise
      AND inedsite= p_inegsite
      AND ined001=  p_ineg002
      AND ined003='9'
      AND ined004='Y' 
   IF NOT cl_null(l_ined005) AND l_ined005='Y' THEN                  
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "ain-00033"
      LET g_errparam.extend = p_ineg002
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success=FALSE
      RETURN r_success
   END IF 

   #盤點計劃未啟用此流程   
   LET l_ined004=''
   SELECT ined004 INTO l_ined004
     FROM ined_t
    WHERE inedent= g_enterprise
      AND inedsite= p_inegsite
      AND ined001= p_ineg002
      AND ined003='4'
   IF NOT cl_null(l_ined004) AND l_ined004='N' THEN
      LET l_gzcbl004=''
      SELECT gzcbl004 INTO l_gzcbl004 
        FROM gzcbl_t
       WHERE gzcbl001='6548'                         
         AND gzcbl003=g_dlang
         AND gzcbl002='4'                    
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "ain-00032"
      LET g_errparam.extend = p_ineg002
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_gzcbl004
      CALL cl_err()
                         
      LET r_success=FALSE
      RETURN r_success
   END IF
   
   #盤點計劃此進度已完成
   LET l_ined005=''
   SELECT ined005 INTO l_ined005
     FROM ined_t
    WHERE inedent= g_enterprise
      AND inedsite= p_inegsite
      AND ined001=  p_ineg002
      AND ined003='4'
      AND ined004='Y' 
   IF NOT cl_null(l_ined005) AND l_ined005='Y' THEN
      LET l_gzcbl004=''
      SELECT gzcbl004 INTO l_gzcbl004 
        FROM gzcbl_t
       WHERE gzcbl001='6548'                         
         AND gzcbl003=g_dlang
         AND gzcbl002='4'  
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "ain-00034"
      LET g_errparam.extend = p_ineg002
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_gzcbl004
      CALL cl_err()
               
      LET r_success=FALSE
      RETURN r_success
   END IF
   
   #上一些已啟用的流程未完成
   LET l_ined003=''
   SELECT MAX(ined003) INTO l_ined003
     FROM ined_t
    WHERE inedent=g_enterprise
      AND inedsite=p_inegsite
      AND ined001=p_ineg002
      AND ined004='Y'
      AND ined003<'4'  
      AND ined003<>'3' #库存快照           
   LET l_ined005=''
   SELECT ined005 INTO l_ined005
     FROM ined_t
    WHERE inedent=g_enterprise
      AND inedsite=p_inegsite
      AND ined001=p_ineg002
      AND ined004='Y'
      AND ined003=l_ined003
   IF NOT cl_null(l_ined005) AND l_ined005='N' THEN
                       
      DECLARE aint805_selgacbl0042 CURSOR  FOR
          SELECT gzcbl004 
            FROM gzcbl_t
           WHERE gzcbl001='6548'                         
             AND gzcbl003=g_lang
             AND gzcbl002<=l_ined003
             AND EXISTS (SELECT ined003 FROM ined_t
                                   WHERE inedent=g_enterprise
                                     AND inedsite=p_inegsite
                                     AND ined001=p_ineg002
                                     AND ined003=gzcbl_t.gzcbl002
                                     AND ined003<=l_ined003
                                     AND ined003<>'3' #库存快照                                     
                                     AND ined004='Y'
                                     AND ined005='N')
      LET l_str=''
      FOREACH aint805_selgacbl0042 INTO l_gzcbl004
          IF cl_null(l_str) THEN
             LET l_str=l_gzcbl004
          ELSE
             LET l_str=l_str||"/"||l_gzcbl004
          END IF                      
      END FOREACH                   
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "ain-00035"
       LET g_errparam.extend = p_ineg002
       LET g_errparam.popup = TRUE
       LET g_errparam.replace[1] = l_str
       CALL cl_err()
                    
      LET r_success=FALSE
      RETURN r_success
   END IF   
   
   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 預盤單轉入
# Memo...........:
# Usage..........: CALL aint805_preoodinto()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20140226 By huangrh
# Modify.........:
################################################################################
PUBLIC FUNCTION aint805_preoodinto()
#DEFINE l_ineh  RECORD LIKE ineh_t.*   #160719-00006#1 160719 by sakura mark
#160719-00006#1 160719 by sakura add(S)
DEFINE l_ineh RECORD  #盤點維護資料明細表
       inehent LIKE ineh_t.inehent,     #企業編號
       inehunit LIKE ineh_t.inehunit,   #應用組織
       inehsite LIKE ineh_t.inehsite,   #營運據點
       inehdocno LIKE ineh_t.inehdocno, #單據編號
       inehseq LIKE ineh_t.inehseq,     #項次
       ineh001 LIKE ineh_t.ineh001,     #商品編號
       ineh002 LIKE ineh_t.ineh002,     #商品條碼
       ineh003 LIKE ineh_t.ineh003,     #商品特徵
       ineh004 LIKE ineh_t.ineh004,     #庫位
       ineh005 LIKE ineh_t.ineh005,     #儲位
       ineh006 LIKE ineh_t.ineh006,     #批號
       ineh007 LIKE ineh_t.ineh007,     #貨架位置
       ineh008 LIKE ineh_t.ineh008,     #單位
       ineh009 LIKE ineh_t.ineh009,     #本次輸入數量
       ineh010 LIKE ineh_t.ineh010,     #帳面數量
       ineh011 LIKE ineh_t.ineh011,     #初盤數量
       ineh012 LIKE ineh_t.ineh012,     #複盤數量
       ineh013 LIKE ineh_t.ineh013,     #抽盤數量
       ineh014 LIKE ineh_t.ineh014,     #實盤數量
       ineh015 LIKE ineh_t.ineh015,     #差異數量
       ineh016 LIKE ineh_t.ineh016,     #最新進價
       ineh017 LIKE ineh_t.ineh017,     #售價
       ineh018 LIKE ineh_t.ineh018,     #理由碼
       ineh019 LIKE ineh_t.ineh019,     #備註
       ineh020 LIKE ineh_t.ineh020,     #來源單號
       ineh021 LIKE ineh_t.ineh021      #來源項次
END RECORD
#160719-00006#1 160719 by sakura add(E)
DEFINE l_count        LIKE type_t.num5


    CALL s_transaction_begin()
    
    #20150715---按照客户需求调整，可以没有库存快照，先做初盘单
    LET l_count=0
    SELECT COUNT(*) INTO l_count
      FROM inef_t
     WHERE inefent=g_enterprise
       AND inefsite=g_ineg_m.inegsite
       AND inef001=g_ineg_m.ineg002
    IF l_count=0 THEN  #没有库存快照
       DECLARE bfill_csinto_ineh_cur CURSOR FOR SELECT DISTINCT ineeent,ineeunit,ineesite,'','',inee002,rtdx002,'',inag004,inag005,'',' ',inag007,0,0,0,0,0,0,0,inee003,inee004,'',''
                                                  FROM inee_t,rtdx_t,inag_t 
                                                 WHERE ineeent=g_enterprise
                                                   AND ineesite=g_ineg_m.inegsite
                                                   AND inee001=g_ineg_m.ineg002
                                                   AND ineeent=rtdxent 
                                                   AND ineesite=rtdxsite 
                                                   AND inee002=rtdx001
                                                   AND inagent=ineeent
                                                   AND inagsite=ineesite
                                                   AND inag001=inee002
                                                   AND inag004=g_ineg_m.ineg008
                                                  ORDER BY inee002
                                                  
       FOREACH bfill_csinto_ineh_cur INTO l_ineh.*
          LET l_ineh.inehdocno=g_ineg_m.inegdocno
          SELECT MAX(inehseq)+1 INTO l_ineh.inehseq
            FROM ineh_t
           WHERE inehent=l_ineh.inehent
             AND inehsite=l_ineh.inehsite
             AND inehdocno=l_ineh.inehdocno
          IF cl_null(l_ineh.inehseq) THEN LET l_ineh.inehseq=1 END IF
          
          #賬面數量
          LET l_ineh.ineh010=''
          SELECT SUM(inag008) INTO l_ineh.ineh010
            FROM inag_t
           WHERE inagent=l_ineh.inehent
             AND inagsite=l_ineh.inehsite
             AND inag001=l_ineh.ineh001
             AND inag002=l_ineh.ineh003  #161017-00029#7 by 08172
             AND inag004=l_ineh.ineh004
             AND inag005=l_ineh.ineh005
             AND inag007=l_ineh.ineh008
          IF cl_null(l_ineh.ineh010) THEN LET l_ineh.ineh010=0 END IF           
          IF cl_null(l_ineh.ineh003) THEN LET l_ineh.ineh003 = ' ' END IF  #161017-00029#7 by 08172
          #INSERT INTO ineh_t VALUES (l_ineh.*)   #160719-00006#1 160719 by sakura mark
          #160719-00006#1 160719 by sakura add(S)
          INSERT INTO ineh_t (inehent,inehunit,inehsite,inehdocno,inehseq,
                              ineh001,ineh002 ,ineh003 ,ineh004  ,ineh005,
                              ineh006,ineh007 ,ineh008 ,ineh009  ,ineh010,
                              ineh011,ineh012 ,ineh013 ,ineh014  ,ineh015,
                              ineh016,ineh017 ,ineh018 ,ineh019  ,ineh020,
                              ineh021) 
                      VALUES (l_ineh.inehent,l_ineh.inehunit,l_ineh.inehsite,l_ineh.inehdocno,l_ineh.inehseq,
                              l_ineh.ineh001,l_ineh.ineh002 ,l_ineh.ineh003 ,l_ineh.ineh004  ,l_ineh.ineh005,
                              l_ineh.ineh006,l_ineh.ineh007 ,l_ineh.ineh008 ,l_ineh.ineh009  ,l_ineh.ineh010,
                              l_ineh.ineh011,l_ineh.ineh012 ,l_ineh.ineh013 ,l_ineh.ineh014  ,l_ineh.ineh015,
                              l_ineh.ineh016,l_ineh.ineh017 ,l_ineh.ineh018 ,l_ineh.ineh019  ,l_ineh.ineh020,
                              l_ineh.ineh021) 
          #160719-00006#1 160719 by sakura add(E)          
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "into ineh"
             LET g_errparam.popup = TRUE
             CALL cl_err()
     
             CALL s_transaction_end('N','0')
             EXIT FOREACH
          END IF
       END FOREACH                                                  

    ELSE
       #huangrh 20150615---modify---盤點流程不使用批號
       LET g_sql="SELECT DISTINCT ineeent,ineeunit,ineesite,'','',inee002,rtdx002,inef003,inef005,inef006,'',inef008,inef009,0,0,0,0,0,0,0,inee003,inee004,'','' ",
                 "  FROM inee_t INNER JOIN rtdx_t ON ineeent=rtdxent AND ineesite=rtdxsite AND inee002=rtdx001 ",
                 "              INNER JOIN inef_t ON ineeent=inefent AND ineesite=inefsite AND inee001=inef001 AND inee002=inef002 ",
                 "  WHERE ineeent='",g_enterprise,"'",
                 "    AND ineesite='",g_ineg_m.inegsite,"'",
                 "    AND inee001='",g_ineg_m.ineg002,"'",
                 "    AND inef005='",g_ineg_m.ineg008,"'",
                 "   ORDER BY inee002,inef005"
                 
       PREPARE aint805_pbinto FROM g_sql
       DECLARE b_fill_csinto CURSOR FOR aint805_pbinto
      
       FOREACH b_fill_csinto INTO l_ineh.*
          LET l_ineh.inehdocno=g_ineg_m.inegdocno
          SELECT MAX(inehseq)+1 INTO l_ineh.inehseq
            FROM ineh_t
           WHERE inehent=l_ineh.inehent
             AND inehsite=l_ineh.inehsite
             AND inehdocno=l_ineh.inehdocno
          IF cl_null(l_ineh.inehseq) THEN LET l_ineh.inehseq=1 END IF
          
          #賬面數量
          LET l_ineh.ineh010=''
          SELECT SUM(inag008) INTO l_ineh.ineh010
            FROM inag_t
           WHERE inagent=l_ineh.inehent
             AND inagsite=l_ineh.inehsite
             AND inag001=l_ineh.ineh001
             AND inag002=l_ineh.ineh003  #161017-00029#7 by 08172
             AND inag004=l_ineh.ineh004
             AND inag005=l_ineh.ineh005
             AND inag007=l_ineh.ineh008
          IF cl_null(l_ineh.ineh010) THEN LET l_ineh.ineh010=0 END IF           
          IF cl_null(l_ineh.ineh003) THEN LET l_ineh.ineh003 = ' ' END IF  #161017-00029#7 by 08172
          #INSERT INTO ineh_t VALUES (l_ineh.*)   #160719-00006#1 160719 by sakura mark
          #160719-00006#1 160719 by sakura add(S)
          INSERT INTO ineh_t (inehent,inehunit,inehsite,inehdocno,inehseq,
                              ineh001,ineh002 ,ineh003 ,ineh004  ,ineh005,
                              ineh006,ineh007 ,ineh008 ,ineh009  ,ineh010,
                              ineh011,ineh012 ,ineh013 ,ineh014  ,ineh015,
                              ineh016,ineh017 ,ineh018 ,ineh019  ,ineh020,
                              ineh021) 
                      VALUES (l_ineh.inehent,l_ineh.inehunit,l_ineh.inehsite,l_ineh.inehdocno,l_ineh.inehseq,
                              l_ineh.ineh001,l_ineh.ineh002 ,l_ineh.ineh003 ,l_ineh.ineh004  ,l_ineh.ineh005,
                              l_ineh.ineh006,l_ineh.ineh007 ,l_ineh.ineh008 ,l_ineh.ineh009  ,l_ineh.ineh010,
                              l_ineh.ineh011,l_ineh.ineh012 ,l_ineh.ineh013 ,l_ineh.ineh014  ,l_ineh.ineh015,
                              l_ineh.ineh016,l_ineh.ineh017 ,l_ineh.ineh018 ,l_ineh.ineh019  ,l_ineh.ineh020,
                              l_ineh.ineh021) 
          #160719-00006#1 160719 by sakura add(E)          
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "into ineh"
             LET g_errparam.popup = TRUE
             CALL cl_err()
     
             CALL s_transaction_end('N','0')
             EXIT FOREACH
          END IF
       END FOREACH
    END IF
    
    CALL s_transaction_end('Y','0')
    FREE aint805_pbinto
    CALL aint805_b_fill()
    CALL aint805_show()

END FUNCTION
################################################################################
# Descriptions...: 商品帶出條碼等資料
# Memo...........:
# Usage..........: CALL aint805_ineh_ref()
# Input parameter: 
# Return code....: 
# Date & Author..: 20140321 By huangrh
# Modify.........:
################################################################################
PUBLIC FUNCTION aint805_ineh_ref()
   DEFINE l_n    LIKE type_t.num5  #161017-00029#7 by 08172   
  
   #161017-00029#7 -s by 08172
   SELECT COUNT(1) INTO l_n
     FROM imay_t
    WHERE imayent = g_enterprise
      AND imay001 = g_ineh_d[l_ac].ineh001
      AND imay003 = g_ineh_d[l_ac].ineh002
      AND imaystus = 'Y'
   IF l_n = 0 THEN
      INITIALIZE g_ineh_d[l_ac].ineh002 TO NULL
   #161017-00029#7 -e by 08172      
      SELECT imay003 INTO g_ineh_d[l_ac].ineh002
        FROM imay_t
       WHERE imayent=g_enterprise
         AND imay001=g_ineh_d[l_ac].ineh001 
         AND imay006='Y'
         AND imaystus = 'Y'   #161017-00029#7 by 08172       
      
   END IF
   #161017-00029#7 -s by 08172
   IF NOT cl_null(g_ineh_d[l_ac].ineh002) THEN
      LET g_ineh_d[l_ac].ineh003 = ' '
      SELECT imay019 INTO g_ineh_d[l_ac].ineh003
        FROM imay_t 
       WHERE imayent = g_enterprise
         AND imay003 = g_ineh_d[l_ac].ineh002
         AND imaystus = 'Y'
   END IF
   #161017-00029#7 -e by 08172
   SELECT imaa104 INTO g_ineh_d[l_ac].ineh008
     FROM imaa_t
    WHERE imaaent=g_enterprise
      AND imaa001=g_ineh_d[l_ac].ineh001 
   SELECT oocal003 INTO g_ineh_d[l_ac].ineh008_desc
     FROM oocal_t
    WHERE oocalent=g_enterprise
      AND oocal001=g_ineh_d[l_ac].ineh008
      AND oocal002=g_lang
   SELECT imaal003,imaal004 INTO g_ineh_d[l_ac].ineh001_desc,g_ineh_d[l_ac].ineh001_desc_desc
     FROM imaal_t
    WHERE imaalent=g_enterprise
      AND imaal001=g_ineh_d[l_ac].ineh001
      AND imaal002=g_lang
   
    
   SELECT DISTINCT inee003,inee004 INTO g_ineh_d[l_ac].ineh016,g_ineh_d[l_ac].ineh017
     FROM inee_t
    WHERE ineeent= g_enterprise
      AND ineesite= g_ineg_m.inegsite
      AND inee001= g_ineg_m.ineg002
      AND inee002= g_ineh_d[l_ac].ineh001
             
   IF cl_null(g_ineh_d[l_ac].ineh016) THEN LET g_ineh_d[l_ac].ineh016=0 END IF
   IF cl_null(g_ineh_d[l_ac].ineh017) THEN LET g_ineh_d[l_ac].ineh017=0 END IF
   IF NOT cl_null(g_ineh_d[l_ac].ineh009) THEN
      LET g_ineh_d[l_ac].amount1= g_ineh_d[l_ac].ineh016*g_ineh_d[l_ac].ineh009 
      LET g_ineh_d[l_ac].amount2= g_ineh_d[l_ac].ineh017*g_ineh_d[l_ac].ineh009 
   END IF
   IF cl_null(g_ineh_d[l_ac].amount1) THEN LET g_ineh_d[l_ac].amount1=0 END IF
   IF cl_null(g_ineh_d[l_ac].amount2) THEN LET g_ineh_d[l_ac].amount2=0 END IF                  
                
   DISPLAY g_ineh_d[l_ac].ineh002 TO ineh002
   DISPLAY g_ineh_d[l_ac].ineh003 TO ineh003  #161017-00029#7 by 08172
   DISPLAY g_ineh_d[l_ac].ineh008 TO ineh008
   DISPLAY g_ineh_d[l_ac].ineh016 TO ineh016
   DISPLAY g_ineh_d[l_ac].ineh017 TO ineh017
   DISPLAY g_ineh_d[l_ac].amount1 TO amount1
   DISPLAY g_ineh_d[l_ac].amount2 TO amount2
   DISPLAY g_ineh_d[l_ac].ineh008_desc TO ineh008_desc                 
   DISPLAY g_ineh_d[l_ac].ineh001_desc TO ineh001_desc
   DISPLAY g_ineh_d[l_ac].ineh001_desc_desc TO ineh001_desc_desc   


END FUNCTION

################################################################################
# Descriptions...: 累計錄入數量
# Memo...........:
# Usage..........: CALL aint805_amount()
# Input parameter: 
# Return code....: 
# Date & Author..: 20140529 By huangrh
# Modify.........:
################################################################################
PUBLIC FUNCTION aint805_amount()
   DEFINE l_inaa007 LIKE inaa_t.inaa007

     IF NOT cl_null(g_ineh_d[l_ac].ineh001) 
        AND NOT cl_null(g_ineh_d[l_ac].ineh004) 
        AND NOT cl_null(g_ineh_d[l_ac].ineh008) THEN

        IF cl_null(g_ineh_d[l_ac].ineh005) THEN
           LET g_ineh_d[l_ac].ineh005= ' '
        END IF
        #huangrh 20150615---modify---盤點流程不使用批號
        #IF cl_null(g_ineh_d[l_ac].ineh006) THEN
        #   LET g_ineh_d[l_ac].ineh006= ' '
        #END IF        

     #161216-00047#1 add by cheng 161217 ---s---
        SELECT inaa007 INTO l_inaa007 FROM inaa_t,ineh_t WHERE inaaent=g_enterprise AND inaasite=inehsite AND inaa001=g_ineh_d[l_ac].ineh004
        IF l_inaa007 = '5' THEN 
           SELECT SUM(ineh009) INTO g_ineh_d[l_ac].amount
             FROM ineh_t,ineg_t
            WHERE inehent=inegent
              AND inehsite=inegsite
              AND inehdocno=inegdocno
              AND inehent=g_enterprise
              AND inehsite=g_ineg_m.inegsite
              AND ineg001='1'
              AND inegstus<>'X'
              AND ineg002=g_ineg_m.ineg002
              AND ineh001=g_ineh_d[l_ac].ineh001
              AND ineh003=g_ineh_d[l_ac].ineh003
              AND ineh004=g_ineh_d[l_ac].ineh004
              AND ineh008=g_ineh_d[l_ac].ineh008
           IF cl_null(g_ineh_d[l_ac].amount) THEN  LET g_ineh_d[l_ac].amount=0  END IF 
           DISPLAY g_ineh_d[l_ac].amount TO amount
         ELSE  
     #161216-00047#1 add by cheng 161217 ---e---
           SELECT SUM(ineh009) INTO g_ineh_d[l_ac].amount
             FROM ineh_t,ineg_t
            WHERE inehent=inegent
              AND inehsite=inegsite
              AND inehdocno=inegdocno
              AND inehent=g_enterprise
              AND inehsite=g_ineg_m.inegsite
              AND ineg001='1'
              AND inegstus<>'X'
              AND ineg002=g_ineg_m.ineg002
              AND ineh001=g_ineh_d[l_ac].ineh001
              AND ineh003=g_ineh_d[l_ac].ineh003    #161017-00029#7 by 08172
              AND ineh004=g_ineh_d[l_ac].ineh004
              AND ineh005=g_ineh_d[l_ac].ineh005
#              AND ineh006=g_ineh_d[l_ac].ineh006
              AND ineh008=g_ineh_d[l_ac].ineh008
           IF cl_null(g_ineh_d[l_ac].amount) THEN  LET g_ineh_d[l_ac].amount=0  END IF 
           DISPLAY g_ineh_d[l_ac].amount TO amount
         END IF
      END IF        #161216-00047#1 add by cheng 161217

END FUNCTION

################################################################################
# Descriptions...: 汇入excel
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016-06-28 by lanjj (集美无中台 暂时不使用 改用元件写法)
# Modify.........:
################################################################################
PRIVATE FUNCTION aint805_load()
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_sql           STRING
   DEFINE l_inehseq       LIKE ineh_t.inehseq
   DEFINE l_ineh001       LIKE ineh_t.ineh001
   DEFINE l_ineh002       LIKE ineh_t.ineh002
   DEFINE l_ineh009       LIKE ineh_t.ineh009
   DEFINE l_ineh004       LIKE ineh_t.ineh004
   DEFINE l_ineh019       LIKE ineh_t.ineh019
   DEFINE l_ineh          RECORD
          inehsite        LIKE ineh_t.inehsite,
          inehdocno       LIKE ineh_t.inehdocno,
          inehseq         LIKE ineh_t.inehseq,
          ineh001         LIKE ineh_t.ineh001,
          ineh002         LIKE ineh_t.ineh002,
          ineh003         LIKE ineh_t.ineh003,
          ineh004         LIKE ineh_t.ineh004,
          ineh005         LIKE ineh_t.ineh005,
          ineh006         LIKE ineh_t.ineh006,
          ineh007         LIKE ineh_t.ineh007,
          ineh008         LIKE ineh_t.ineh008,
          ineh009         LIKE ineh_t.ineh009,
          ineh010         LIKE ineh_t.ineh010,
          ineh011         LIKE ineh_t.ineh011,
          ineh012         LIKE ineh_t.ineh012,
          ineh013         LIKE ineh_t.ineh013,
          ineh014         LIKE ineh_t.ineh014,
          ineh015         LIKE ineh_t.ineh015,
          ineh016         LIKE ineh_t.ineh016,
          ineh017         LIKE ineh_t.ineh017,
          ineh018         LIKE ineh_t.ineh018,
          ineh019         LIKE ineh_t.ineh019
                          END RECORD

   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM ineh_t
    WHERE inehent   = g_enterprise
      AND inehdocno = g_ineg_m.inegdocno
      AND inehsite  = g_ineg_m.inegsite
   IF cl_null(l_count) THEN LET l_count = 0 END IF

   IF l_count < 1 THEN RETURN END IF

   LET l_sql = "SELECT inehseq,ineh001,ineh002,ineh009,ineh004,ineh019 FROM ineh_t ", 
               " WHERE inehent = '",g_enterprise,"'",
               "   AND inehdocno = '",g_ineg_m.inegdocno,"'",
               "   AND inehsite = '",g_ineg_m.inegsite,"'"
   PREPARE aint805_load_prep FROM l_sql
   DECLARE aint805_load_curs CURSOR FOR aint805_load_prep

   FOREACH aint805_load_curs INTO l_inehseq,l_ineh001,l_ineh002,l_ineh009,l_ineh004,l_ineh019 
      INITIALIZE l_ineh.* TO NULL
      LET l_ineh.inehseq = l_inehseq
      LET l_ineh.ineh001 = l_ineh001
      LET l_ineh.ineh002 = l_ineh002
      LET l_ineh.ineh009 = l_ineh009
      LET l_ineh.ineh004 = l_ineh004
      LET l_ineh.ineh019 = l_ineh019
      LET l_ineh.ineh006 = NULL     

      IF NOT cl_null(l_ineh.ineh002) THEN
         SELECT imay001 INTO l_ineh.ineh001 FROM imay_t
          WHERE imayent=g_enterprise
            AND imay003=l_ineh.ineh002
      END IF

      IF NOT cl_null(l_ineh.ineh001) THEN
         SELECT imay003 INTO l_ineh.ineh002 FROM imay_t
           WHERE imayent=g_enterprise
             AND imay001=l_ineh.ineh001 
             AND imay006='Y' 
      END IF

      SELECT imaa104 INTO l_ineh.ineh008 FROM imaa_t
       WHERE imaaent=g_enterprise
         AND imaa001=l_ineh.ineh001 

      IF cl_null(l_ineh.ineh005) THEN LET l_ineh.ineh005 = ' ' END IF
      IF cl_null(l_ineh.ineh007) THEN LET l_ineh.ineh007 = ' ' END IF

      #賬面數量
      LET l_ineh.ineh010=0
      SELECT SUM(inag008) INTO l_ineh.ineh010
        FROM inag_t
       WHERE inagent=g_enterprise
         AND inagsite=g_ineg_m.inegsite
         AND inag001=l_ineh.ineh001
         AND inag002=l_ineh.ineh003  #161017-00029#7 by 08172
         AND inag004=l_ineh.ineh004
         AND inag005=l_ineh.ineh005
         AND inag007=l_ineh.ineh008
      IF cl_null(l_ineh.ineh010) THEN LET l_ineh.ineh010=0 END IF 

      SELECT inee003,inee004 INTO l_ineh.ineh016,l_ineh.ineh017
        FROM inee_t
       WHERE ineeent= g_enterprise
         AND ineesite= g_ineg_m.inegsite
         AND inee001= g_ineg_m.ineg002
         AND inee002= l_ineh.ineh001
               
       IF cl_null(l_ineh.ineh016) THEN LET l_ineh.ineh016=0 END IF
       IF cl_null(l_ineh.ineh017) THEN LET l_ineh.ineh017=0 END IF              
      IF cl_null(l_ineh.ineh003) THEN LET l_ineh.ineh003 = ' ' END IF  #161017-00029#7 by 08172    
      UPDATE ineh_t SET ineh001 = l_ineh.ineh001,
	                     ineh002 = l_ineh.ineh002,
	                     ineh003 = l_ineh.ineh003,
	                     ineh004 = l_ineh.ineh004,
	                     ineh005 = l_ineh.ineh005,
	                     ineh006 = l_ineh.ineh006,
	                     ineh007 = l_ineh.ineh007,
	                     ineh008 = l_ineh.ineh008,
	                     ineh009 = l_ineh.ineh009,
	                     ineh010 = l_ineh.ineh010,
	                     ineh011 = l_ineh.ineh011,
	                     ineh012 = l_ineh.ineh012,
	                     ineh013 = l_ineh.ineh013,
	                     ineh014 = l_ineh.ineh014,
	                     ineh015 = l_ineh.ineh015,
	                     ineh016 = l_ineh.ineh016,
	                     ineh017 = l_ineh.ineh017,
	                     ineh018 = l_ineh.ineh018,
	                     ineh019 = l_ineh.ineh019
       WHERE inehent  = g_enterprise
         AND inehsite = g_ineg_m.inegsite
         AND inehdocno= g_ineg_m.inegdocno
         AND inehseq  = l_ineh.inehseq

   END FOREACH

   CALL aint805_show()

END FUNCTION

################################################################################
# Descriptions...: 新增时依据产品特征开窗后的值新增到资料库
# Memo...........:
# Usage..........: CALL aint805_feature()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: #161017-00029#7 2016/10/18 by 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION aint805_feature()
   DEFINE  r_success    LIKE type_t.num5
   DEFINE  l_success    LIKE type_t.num5   
   DEFINE  l_i          LIKE type_t.num5
   DEFINE  l_inehseq    LIKE ineh_t.inehseq
   DEFINE  l_ineh       RECORD
           inehent      LIKE ineh_t.inehent,
           inehunit     LIKE ineh_t.inehunit,
           inehsite     LIKE ineh_t.inehsite,
           inehdocno    LIKE ineh_t.inehdocno,
           inehseq      LIKE ineh_t.inehseq,
           ineh001      LIKE ineh_t.ineh001,
           ineh002      LIKE ineh_t.ineh002,
           ineh003      LIKE ineh_t.ineh003,
           ineh004      LIKE ineh_t.ineh004,
           ineh005      LIKE ineh_t.ineh005,
           ineh006      LIKE ineh_t.ineh006,
           ineh007      LIKE ineh_t.ineh007,
           ineh008      LIKE ineh_t.ineh008,
           ineh009      LIKE ineh_t.ineh009,
           ineh010      LIKE ineh_t.ineh010,
           ineh011      LIKE ineh_t.ineh011,
           ineh012      LIKE ineh_t.ineh012,
           ineh013      LIKE ineh_t.ineh013,
           ineh014      LIKE ineh_t.ineh014,
           ineh015      LIKE ineh_t.ineh015,
           ineh016      LIKE ineh_t.ineh016,
           ineh017      LIKE ineh_t.ineh017,
           ineh018      LIKE ineh_t.ineh018,
           ineh019      LIKE ineh_t.ineh019,
           ineh020      LIKE ineh_t.ineh020,
           ineh021      LIKE ineh_t.ineh021
                        END RECORD
   DEFINE l_sql         STRING   #161228-00033#3 by sakura add
                        
   LET r_success = TRUE
  
   LET l_inehseq = '' 
   INITIALIZE l_ineh.* TO NULL  
   SELECT inehent,inehunit,inehsite,inehdocno,inehseq,
          ineh001,ineh002,ineh003,ineh004,ineh005,ineh006,
          ineh007,ineh008,ineh009,ineh010,ineh011,ineh012,
          ineh013,ineh014,ineh015,ineh016,ineh017,ineh018,
          ineh019,ineh020,ineh021
     INTO l_ineh.inehent,l_ineh.inehunit,l_ineh.inehsite,l_ineh.inehdocno,l_ineh.inehseq,
          l_ineh.ineh001,l_ineh.ineh002,l_ineh.ineh003,l_ineh.ineh004,l_ineh.ineh005,l_ineh.ineh006,
          l_ineh.ineh007,l_ineh.ineh008,l_ineh.ineh009,l_ineh.ineh010,l_ineh.ineh011,l_ineh.ineh012,
          l_ineh.ineh013,l_ineh.ineh014,l_ineh.ineh015,l_ineh.ineh016,l_ineh.ineh017,l_ineh.ineh018,
          l_ineh.ineh019,l_ineh.ineh020,l_ineh.ineh021
     FROM ineh_t
    WHERE inehent = g_enterprise
      AND inehsite = g_ineg_m.inegsite
      AND inehdocno = g_ineg_m.inegdocno
      AND inehseq = g_ineh_d[l_ac].inehseq
    
   SELECT MAX(inehseq) INTO l_inehseq
     FROM ineh_t
    WHERE inehent = g_enterprise
      AND inehsite = g_ineg_m.inegsite
      AND inehdocno = g_ineg_m.inegdocno
      AND inehseq <= 9000        
    
   
   FOR l_i = 2 TO g_inam.getLength()
       IF cl_null(l_inehseq) OR l_inehseq = 0 THEN
          LET l_inehseq = 1
       ELSE
          LET l_inehseq = l_inehseq + 1
       END IF 
       LET l_ineh.inehseq = l_inehseq
       LET l_ineh.ineh003 = g_inam[l_i].inam002
       LET l_ineh.ineh009 = g_inam[l_i].inam004
       
       #带出商品条码
       IF NOT cl_null(l_ineh.ineh003) AND NOT cl_null(l_ineh.ineh001) THEN
          #161228-00033#3 by sakura mark(S)
          #SELECT imay003 INTO l_ineh.ineh002
          #  FROM imay_t
          # WHERE imayent = g_enterprise
          #   AND imay001 = l_ineh.ineh001
          #   AND imay019 = l_ineh.ineh003
          #   AND imaystus = 'Y'
          #   AND ROWNUM = 1
          #161228-00033#3 by sakura mark(E)
          #161228-00033#3 by sakura add(S)
          LET l_sql = "SELECT imay003 ",
                      "  FROM imay_t ",
                      " WHERE imayent = ",g_enterprise,
                      "   AND imay001 = '",l_ineh.ineh001,"'",
                      "   AND imay019 = '",l_ineh.ineh003,"'",
                      "   AND imaystus = 'Y' "
          PREPARE aint805_sel_imay003_pre1 FROM l_sql
          DECLARE aint805_sel_imay003_cur1 SCROLL CURSOR FOR aint805_sel_imay003_pre1   
          OPEN aint805_sel_imay003_cur1
          FETCH FIRST aint805_sel_imay003_cur1 INTO l_ineh.ineh002
          CLOSE aint805_sel_imay003_cur1               
          FREE  aint805_sel_imay003_pre1                     
          #161228-00033#3 by sakura add(E)
          IF cl_null(l_ineh.ineh002) THEN
             SELECT imay003 INTO l_ineh.ineh002
               FROM imay_t
              WHERE imayent = g_enterprise
                AND imay001 = l_ineh.ineh001
                AND imay006 = 'Y'
                AND imaystus = 'Y'
          END IF
       END IF
       #賬面數量
       SELECT SUM(inag008) INTO l_ineh.ineh010
         FROM inag_t
        WHERE inagent=g_enterprise
          AND inagsite=g_ineg_m.inegsite
          AND inag001=l_ineh.ineh001
          AND inag002=l_ineh.ineh003
          AND inag004=l_ineh.ineh004
          AND inag005=l_ineh.ineh005
          AND inag007=l_ineh.ineh008
       IF cl_null(l_ineh.ineh010) THEN LET l_ineh.ineh010=0 END IF 
       IF cl_null(l_ineh.ineh003) THEN LET l_ineh.ineh003 = ' ' END IF  #161017-00029#7 by 08172 
       INSERT INTO ineh_t
              (inehent,inehunit,inehsite,inehdocno,inehseq,
               ineh001,ineh002,ineh003,ineh004,ineh005,ineh006,
               ineh007,ineh008,ineh009,ineh010,ineh011,ineh012,
               ineh013,ineh014,ineh015,ineh016,ineh017,ineh018,
               ineh019,ineh020,ineh021)
       VALUES (l_ineh.inehent,l_ineh.inehunit,l_ineh.inehsite,l_ineh.inehdocno,l_ineh.inehseq,
               l_ineh.ineh001,l_ineh.ineh002,l_ineh.ineh003,l_ineh.ineh004,l_ineh.ineh005,l_ineh.ineh006,
               l_ineh.ineh007,l_ineh.ineh008,l_ineh.ineh009,l_ineh.ineh010,l_ineh.ineh011,l_ineh.ineh012,
               l_ineh.ineh013,l_ineh.ineh014,l_ineh.ineh015,l_ineh.ineh016,l_ineh.ineh017,l_ineh.ineh018,
               l_ineh.ineh019,l_ineh.ineh020,l_ineh.ineh021)
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ineh_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
   END FOR 
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取得產品特徵類別
# Memo...........:
# Usage..........: CALL aint805_get_imaa005(p_imaa001)
#                  RETURNING r_imaa005
# Input parameter: p_imaa001   商品編號
# Return code....: r_imaa005   產品特徵類別
# Date & Author..: #161017-00029#7 2016/10/20 By 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION aint805_get_imaa005(p_imaa001)
   DEFINE p_imaa001      LIKE imaa_t.imaa001
   DEFINE r_imaa005      LIKE imaa_t.imaa005

   LET r_imaa005 = ''
   SELECT imaa005 INTO r_imaa005 
     FROM imaa_t 
    WHERE imaaent = g_enterprise 
      AND imaa001 = p_imaa001
      
   RETURN r_imaa005
END FUNCTION

 
{</section>}
 
