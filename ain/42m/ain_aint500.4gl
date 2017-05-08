#該程式未解開Section, 採用最新樣板產出!
{<section id="aint500.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2015-07-24 15:14:17), PR版次:0014(2017-02-20 15:12:55)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000432
#+ Filename...: aint500
#+ Description: 調撥申請單維護作業
#+ Creator....: 01726(2014-02-27 10:22:13)
#+ Modifier...: 02159 -SD/PR- 01996
 
{</section>}
 
{<section id="aint500.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#29  2016/04/07 by 07959   將重複內容的錯誤訊息置換為公用錯誤訊息
#160818-00017#17  2016/08/25 by 08172   修改删除时重新检查状态
#160905-00007#5   20160905 by geza     sql加上ent条件
#160711-00040#15  2017/02/20 By xujing   T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
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
PRIVATE type type_g_inda_m        RECORD
       indasite LIKE inda_t.indasite, 
   indasite_desc LIKE type_t.chr80, 
   indadocdt LIKE inda_t.indadocdt, 
   indadocno LIKE inda_t.indadocno, 
   inda001 LIKE inda_t.inda001, 
   inda001_desc LIKE type_t.chr80, 
   indaunit LIKE inda_t.indaunit, 
   inda003 LIKE inda_t.inda003, 
   inda003_desc LIKE type_t.chr80, 
   inda004 LIKE inda_t.inda004, 
   inda004_desc LIKE type_t.chr80, 
   inda005 LIKE inda_t.inda005, 
   inda101 LIKE inda_t.inda101, 
   inda101_desc LIKE type_t.chr80, 
   inda002 LIKE inda_t.inda002, 
   inda002_desc LIKE type_t.chr80, 
   inda006 LIKE inda_t.inda006, 
   indastus LIKE inda_t.indastus, 
   indaownid LIKE inda_t.indaownid, 
   indaownid_desc LIKE type_t.chr80, 
   indaowndp LIKE inda_t.indaowndp, 
   indaowndp_desc LIKE type_t.chr80, 
   indacrtid LIKE inda_t.indacrtid, 
   indacrtid_desc LIKE type_t.chr80, 
   indacrtdp LIKE inda_t.indacrtdp, 
   indacrtdp_desc LIKE type_t.chr80, 
   indacrtdt LIKE inda_t.indacrtdt, 
   indamodid LIKE inda_t.indamodid, 
   indamodid_desc LIKE type_t.chr80, 
   indamoddt LIKE inda_t.indamoddt, 
   indacnfid LIKE inda_t.indacnfid, 
   indacnfid_desc LIKE type_t.chr80, 
   indacnfdt LIKE inda_t.indacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_indb_d        RECORD
       indbsite LIKE indb_t.indbsite, 
   indbunit LIKE indb_t.indbunit, 
   indbseq LIKE indb_t.indbseq, 
   indb002 LIKE indb_t.indb002, 
   indb001 LIKE indb_t.indb001, 
   indb001_desc LIKE type_t.chr500, 
   indb001_desc_desc LIKE type_t.chr500, 
   indb003 LIKE indb_t.indb003, 
   indb004 LIKE indb_t.indb004, 
   indb004_desc LIKE type_t.chr500, 
   indb005 LIKE indb_t.indb005, 
   indb005_desc LIKE type_t.chr500, 
   indb006 LIKE indb_t.indb006, 
   indb007 LIKE indb_t.indb007, 
   indb008 LIKE indb_t.indb008, 
   indb009 LIKE indb_t.indb009, 
   indb010 LIKE indb_t.indb010, 
   indb011 LIKE indb_t.indb011, 
   indb012 LIKE indb_t.indb012, 
   indb013 LIKE indb_t.indb013
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_indasite LIKE inda_t.indasite,
   b_indasite_desc LIKE type_t.chr80,
      b_indadocdt LIKE inda_t.indadocdt,
      b_indadocno LIKE inda_t.indadocno,
      b_inda001 LIKE inda_t.inda001,
      b_inda003 LIKE inda_t.inda003,
   b_inda003_desc LIKE type_t.chr80,
      b_inda004 LIKE inda_t.inda004,
   b_inda004_desc LIKE type_t.chr80,
      b_inda005 LIKE inda_t.inda005,
      b_inda002 LIKE inda_t.inda002,
   b_inda002_desc LIKE type_t.chr80,
      b_inda006 LIKE inda_t.inda006
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_flag           LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_inda_m          type_g_inda_m
DEFINE g_inda_m_t        type_g_inda_m
DEFINE g_inda_m_o        type_g_inda_m
DEFINE g_inda_m_mask_o   type_g_inda_m #轉換遮罩前資料
DEFINE g_inda_m_mask_n   type_g_inda_m #轉換遮罩後資料
 
   DEFINE g_indadocno_t LIKE inda_t.indadocno
 
 
DEFINE g_indb_d          DYNAMIC ARRAY OF type_g_indb_d
DEFINE g_indb_d_t        type_g_indb_d
DEFINE g_indb_d_o        type_g_indb_d
DEFINE g_indb_d_mask_o   DYNAMIC ARRAY OF type_g_indb_d #轉換遮罩前資料
DEFINE g_indb_d_mask_n   DYNAMIC ARRAY OF type_g_indb_d #轉換遮罩後資料
 
 
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
 
{<section id="aint500.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309            
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
   LET g_forupd_sql = " SELECT indasite,'',indadocdt,indadocno,inda001,'',indaunit,inda003,'',inda004, 
       '',inda005,inda101,'',inda002,'',inda006,indastus,indaownid,'',indaowndp,'',indacrtid,'',indacrtdp, 
       '',indacrtdt,indamodid,'',indamoddt,indacnfid,'',indacnfdt", 
                      " FROM inda_t",
                      " WHERE indaent= ? AND indadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
            
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint500_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.indasite,t0.indadocdt,t0.indadocno,t0.inda001,t0.indaunit,t0.inda003, 
       t0.inda004,t0.inda005,t0.inda101,t0.inda002,t0.inda006,t0.indastus,t0.indaownid,t0.indaowndp, 
       t0.indacrtid,t0.indacrtdp,t0.indacrtdt,t0.indamodid,t0.indamoddt,t0.indacnfid,t0.indacnfdt,t1.ooefl003 , 
       t2.ooag011 ,t3.ooefl003 ,t4.ooefl003 ,t5.ooefl003 ,t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 , 
       t10.ooefl003 ,t11.ooag011 ,t12.ooag011",
               " FROM inda_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.indasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.inda001  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.inda003 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.inda004 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.inda101 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.inda002 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.indaownid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.indaowndp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.indacrtid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.indacrtdp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.indamodid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.indacnfid  ",
 
               " WHERE t0.indaent = " ||g_enterprise|| " AND t0.indadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aint500_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
                        
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aint500 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aint500_init()   
 
      #進入選單 Menu (="N")
      CALL aint500_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
                        
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aint500
      
   END IF 
   
   CLOSE aint500_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#2  By sakura 150309            
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aint500.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aint500_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309            
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
      CALL cl_set_combo_scc_part('indastus','13','N,Y,A,C,D,R,T,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#2  By sakura 150309
   #end add-point
   
   #初始化搜尋條件
   CALL aint500_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aint500.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aint500_ui_dialog()
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
            CALL aint500_insert()
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
         INITIALIZE g_inda_m.* TO NULL
         CALL g_indb_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aint500_init()
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
               
               CALL aint500_fetch('') # reload data
               LET l_ac = 1
               CALL aint500_ui_detailshow() #Setting the current row 
         
               CALL aint500_idx_chk()
               #NEXT FIELD indbseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_indb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint500_idx_chk()
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
               CALL aint500_idx_chk()
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
            CALL aint500_browser_fill("")
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
               CALL aint500_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aint500_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aint500_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
                                                
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aint500_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aint500_set_act_visible()   
            CALL aint500_set_act_no_visible()
            IF NOT (g_inda_m.indadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " indaent = " ||g_enterprise|| " AND",
                                  " indadocno = '", g_inda_m.indadocno, "' "
 
               #填到對應位置
               CALL aint500_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "inda_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "indb_t" 
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
               CALL aint500_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "inda_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "indb_t" 
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
                  CALL aint500_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aint500_fetch("F")
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
               CALL aint500_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aint500_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint500_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aint500_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint500_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aint500_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint500_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aint500_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint500_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aint500_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint500_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_indb_d)
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
               NEXT FIELD indbseq
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
               CALL aint500_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #160818-00017#17 -s by 08172
               CALL aint500_set_act_visible()   
               CALL aint500_set_act_no_visible()
               #160818-00017#17 -e by 08172                                               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aint500_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #160818-00017#17 -s by 08172
               CALL aint500_set_act_visible()   
               CALL aint500_set_act_no_visible()
               #160818-00017#17 -e by 08172                                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aint500_delete()
               #add-point:ON ACTION delete name="menu.delete"
               #160818-00017#17 -s by 08172
               CALL aint500_set_act_visible()   
               CALL aint500_set_act_no_visible()
               #160818-00017#17 -e by 08172                                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aint500_insert()
               #add-point:ON ACTION insert name="menu.insert"
                                                            
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = " indaent = '",g_enterprise,"' AND indadocno = '",g_inda_m.indadocno,"' " #sakura ad
               #END add-point
               &include "erp/ain/aint500_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = " indaent = '",g_enterprise,"' AND indadocno = '",g_inda_m.indadocno,"' " #sakura ad
               #END add-point
               &include "erp/ain/aint500_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aint500_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
                                                            
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aint500_query()
               #add-point:ON ACTION query name="menu.query"
                                                            
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_inda001
            LET g_action_choice="prog_inda001"
            IF cl_auth_chk_act("prog_inda001") THEN
               
               #add-point:ON ACTION prog_inda001 name="menu.prog_inda001"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_inda_m.inda001)
 


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aint500_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aint500_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aint500_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_inda_m.indadocdt)
 
 
 
         
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
 
{<section id="aint500.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aint500_browser_fill(ps_page_action)
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
      LET l_wc = l_wc CLIPPED," AND (indasite = '",g_site,"' OR inda002 = '",g_site,"' OR inda003 = '",g_site,"' OR inda004 = '",g_site,"') "
   LET g_wc = g_wc CLIPPED," AND (indasite = '",g_site,"' OR inda002 = '",g_site,"' OR inda003 = '",g_site,"' OR inda004 = '",g_site,"') "
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT indadocno ",
                      " FROM inda_t ",
                      " ",
                      " LEFT JOIN indb_t ON indbent = indaent AND indadocno = indbdocno ", "  ",
                      #add-point:browser_fill段sql(indb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE indaent = " ||g_enterprise|| " AND indbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("inda_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT indadocno ",
                      " FROM inda_t ", 
                      "  ",
                      "  ",
                      " WHERE indaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("inda_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   LET l_sub_sql = l_sub_sql," AND (indasite = '",g_site,"' OR inda002 = '",g_site,"' OR inda003 = '",g_site,"' OR inda004 = '",g_site,"') "
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
      INITIALIZE g_inda_m.* TO NULL
      CALL g_indb_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.indasite,t0.indadocdt,t0.indadocno,t0.inda001,t0.inda003,t0.inda004,t0.inda005,t0.inda002,t0.inda006 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.indastus,t0.indasite,t0.indadocdt,t0.indadocno,t0.inda001,t0.inda003, 
          t0.inda004,t0.inda005,t0.inda002,t0.inda006,t1.ooefl003 ,t2.ooefl003 ,t3.ooefl003 ,t4.ooefl003 ", 
 
                  " FROM inda_t t0",
                  "  ",
                  "  LEFT JOIN indb_t ON indbent = indaent AND indadocno = indbdocno ", "  ", 
                  #add-point:browser_fill段sql(indb_t1) name="browser_fill.join.indb_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.indasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.inda003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.inda004 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.inda002 AND t4.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.indaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("inda_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.indastus,t0.indasite,t0.indadocdt,t0.indadocno,t0.inda001,t0.inda003, 
          t0.inda004,t0.inda005,t0.inda002,t0.inda006,t1.ooefl003 ,t2.ooefl003 ,t3.ooefl003 ,t4.ooefl003 ", 
 
                  " FROM inda_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.indasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.inda003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.inda004 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.inda002 AND t4.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.indaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("inda_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   LET g_sql = g_sql," AND (indasite = '",g_site,"' OR inda002 = '",g_site,"' OR inda003 = '",g_site,"' OR inda004 = '",g_site,"') "
   #end add-point
   LET g_sql = g_sql, " ORDER BY indadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
            
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"inda_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
            
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_indasite,g_browser[g_cnt].b_indadocdt, 
          g_browser[g_cnt].b_indadocno,g_browser[g_cnt].b_inda001,g_browser[g_cnt].b_inda003,g_browser[g_cnt].b_inda004, 
          g_browser[g_cnt].b_inda005,g_browser[g_cnt].b_inda002,g_browser[g_cnt].b_inda006,g_browser[g_cnt].b_indasite_desc, 
          g_browser[g_cnt].b_inda003_desc,g_browser[g_cnt].b_inda004_desc,g_browser[g_cnt].b_inda002_desc 
 
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
         CALL aint500_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "C"
            LET g_browser[g_cnt].b_statepic = "stus/16/closed.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "T"
            LET g_browser[g_cnt].b_statepic = "stus/16/org_approved.png"
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
   
   IF cl_null(g_browser[g_cnt].b_indadocno) THEN
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
 
{<section id="aint500.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aint500_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
            
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_inda_m.indadocno = g_browser[g_current_idx].b_indadocno   
 
   EXECUTE aint500_master_referesh USING g_inda_m.indadocno INTO g_inda_m.indasite,g_inda_m.indadocdt, 
       g_inda_m.indadocno,g_inda_m.inda001,g_inda_m.indaunit,g_inda_m.inda003,g_inda_m.inda004,g_inda_m.inda005, 
       g_inda_m.inda101,g_inda_m.inda002,g_inda_m.inda006,g_inda_m.indastus,g_inda_m.indaownid,g_inda_m.indaowndp, 
       g_inda_m.indacrtid,g_inda_m.indacrtdp,g_inda_m.indacrtdt,g_inda_m.indamodid,g_inda_m.indamoddt, 
       g_inda_m.indacnfid,g_inda_m.indacnfdt,g_inda_m.indasite_desc,g_inda_m.inda001_desc,g_inda_m.inda003_desc, 
       g_inda_m.inda004_desc,g_inda_m.inda101_desc,g_inda_m.inda002_desc,g_inda_m.indaownid_desc,g_inda_m.indaowndp_desc, 
       g_inda_m.indacrtid_desc,g_inda_m.indacrtdp_desc,g_inda_m.indamodid_desc,g_inda_m.indacnfid_desc 
 
   
   CALL aint500_inda_t_mask()
   CALL aint500_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aint500.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aint500_ui_detailshow()
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
 
{<section id="aint500.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aint500_ui_browser_refresh()
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
      IF g_browser[l_i].b_indadocno = g_inda_m.indadocno 
 
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
 
{<section id="aint500.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aint500_construct()
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
   INITIALIZE g_inda_m.* TO NULL
   CALL g_indb_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON indasite,indadocdt,indadocno,inda001,indaunit,inda003,inda004,inda005, 
          inda101,inda002,inda006,indastus,indaownid,indaowndp,indacrtid,indacrtdp,indacrtdt,indamodid, 
          indamoddt,indacnfid,indacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
                                                
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<indacrtdt>>----
         AFTER FIELD indacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<indamoddt>>----
         AFTER FIELD indamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<indacnfdt>>----
         AFTER FIELD indacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<indapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.indasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indasite
            #add-point:ON ACTION controlp INFIELD indasite name="construct.c.indasite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
			  #LET g_qryparam.where = " ooef201 = 'Y' "
           #CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'indasite',g_site,'c') #150308-00001#2  By sakura add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO indasite     #顯示到畫面上
            NEXT FIELD indasite                        #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indasite
            #add-point:BEFORE FIELD indasite name="construct.b.indasite"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indasite
            
            #add-point:AFTER FIELD indasite name="construct.a.indasite"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indadocdt
            #add-point:BEFORE FIELD indadocdt name="construct.b.indadocdt"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indadocdt
            
            #add-point:AFTER FIELD indadocdt name="construct.a.indadocdt"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indadocdt
            #add-point:ON ACTION controlp INFIELD indadocdt name="construct.c.indadocdt"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.indadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indadocno
            #add-point:ON ACTION controlp INFIELD indadocno name="construct.c.indadocno"
                                                            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " (indasite = '",g_site,"' OR inda002 = '",g_site,"' OR inda003 = '",g_site,"' OR inda004 = '",g_site,"') "
            CALL q_indadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indadocno  #顯示到畫面上

            NEXT FIELD indadocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indadocno
            #add-point:BEFORE FIELD indadocno name="construct.b.indadocno"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indadocno
            
            #add-point:AFTER FIELD indadocno name="construct.a.indadocno"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.inda001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda001
            #add-point:ON ACTION controlp INFIELD inda001 name="construct.c.inda001"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inda001  #顯示到畫面上

            NEXT FIELD inda001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda001
            #add-point:BEFORE FIELD inda001 name="construct.b.inda001"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda001
            
            #add-point:AFTER FIELD inda001 name="construct.a.inda001"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indaunit
            #add-point:BEFORE FIELD indaunit name="construct.b.indaunit"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indaunit
            
            #add-point:AFTER FIELD indaunit name="construct.a.indaunit"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indaunit
            #add-point:ON ACTION controlp INFIELD indaunit name="construct.c.indaunit"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.inda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda003
            #add-point:ON ACTION controlp INFIELD inda003 name="construct.c.inda003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #开窗设定
            IF s_aooi500_setpoint(g_prog,'inda003') THEN
               #aooi500中有设定
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'inda003',g_site,'c') #150308-00001#2  By sakura add 'c'
               CALL q_ooef001_24()
            ELSE
               #aooi500中未设定按原逻辑
			      LET g_qryparam.where = " ooef201 = 'Y' "
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO inda003      #顯示到畫面上
            NEXT FIELD inda003                         #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda003
            #add-point:BEFORE FIELD inda003 name="construct.b.inda003"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda003
            
            #add-point:AFTER FIELD inda003 name="construct.a.inda003"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.inda004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda004
            #add-point:ON ACTION controlp INFIELD inda004 name="construct.c.inda004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #开窗设定
            IF s_aooi500_setpoint(g_prog,'inda004') THEN
               #aooi500中有设定
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'inda004',g_site,'c') #150308-00001#2  By sakura add 'c'
               CALL q_ooef001_24()
            ELSE
               #aooi500中未设定按原逻辑
			      LET g_qryparam.where = " ooef201 = 'Y' "
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO inda004      #顯示到畫面上
            NEXT FIELD inda004                         #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda004
            #add-point:BEFORE FIELD inda004 name="construct.b.inda004"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda004
            
            #add-point:AFTER FIELD inda004 name="construct.a.inda004"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda005
            #add-point:BEFORE FIELD inda005 name="construct.b.inda005"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda005
            
            #add-point:AFTER FIELD inda005 name="construct.a.inda005"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.inda005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda005
            #add-point:ON ACTION controlp INFIELD inda005 name="construct.c.inda005"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.inda101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda101
            #add-point:ON ACTION controlp INFIELD inda101 name="construct.c.inda101"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inda101  #顯示到畫面上
            NEXT FIELD inda101                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda101
            #add-point:BEFORE FIELD inda101 name="construct.b.inda101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda101
            
            #add-point:AFTER FIELD inda101 name="construct.a.inda101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda002
            #add-point:ON ACTION controlp INFIELD inda002 name="construct.c.inda002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #开窗设定
            IF s_aooi500_setpoint(g_prog,'inda002') THEN
               #aooi500中有设定
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'inda002',g_site,'c') #150308-00001#2  By sakura add 'c'
               CALL q_ooef001_24()
            ELSE
               #aooi500中未设定按原逻辑
			      LET g_qryparam.where = " ooef201 = 'Y' "
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO inda002      #顯示到畫面上
            NEXT FIELD inda002                         #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda002
            #add-point:BEFORE FIELD inda002 name="construct.b.inda002"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda002
            
            #add-point:AFTER FIELD inda002 name="construct.a.inda002"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda006
            #add-point:BEFORE FIELD inda006 name="construct.b.inda006"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda006
            
            #add-point:AFTER FIELD inda006 name="construct.a.inda006"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.inda006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda006
            #add-point:ON ACTION controlp INFIELD inda006 name="construct.c.inda006"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indastus
            #add-point:BEFORE FIELD indastus name="construct.b.indastus"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indastus
            
            #add-point:AFTER FIELD indastus name="construct.a.indastus"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indastus
            #add-point:ON ACTION controlp INFIELD indastus name="construct.c.indastus"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.indaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indaownid
            #add-point:ON ACTION controlp INFIELD indaownid name="construct.c.indaownid"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indaownid  #顯示到畫面上

            NEXT FIELD indaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indaownid
            #add-point:BEFORE FIELD indaownid name="construct.b.indaownid"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indaownid
            
            #add-point:AFTER FIELD indaownid name="construct.a.indaownid"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indaowndp
            #add-point:ON ACTION controlp INFIELD indaowndp name="construct.c.indaowndp"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indaowndp  #顯示到畫面上

            NEXT FIELD indaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indaowndp
            #add-point:BEFORE FIELD indaowndp name="construct.b.indaowndp"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indaowndp
            
            #add-point:AFTER FIELD indaowndp name="construct.a.indaowndp"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indacrtid
            #add-point:ON ACTION controlp INFIELD indacrtid name="construct.c.indacrtid"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indacrtid  #顯示到畫面上

            NEXT FIELD indacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indacrtid
            #add-point:BEFORE FIELD indacrtid name="construct.b.indacrtid"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indacrtid
            
            #add-point:AFTER FIELD indacrtid name="construct.a.indacrtid"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.indacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indacrtdp
            #add-point:ON ACTION controlp INFIELD indacrtdp name="construct.c.indacrtdp"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indacrtdp  #顯示到畫面上

            NEXT FIELD indacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indacrtdp
            #add-point:BEFORE FIELD indacrtdp name="construct.b.indacrtdp"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indacrtdp
            
            #add-point:AFTER FIELD indacrtdp name="construct.a.indacrtdp"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indacrtdt
            #add-point:BEFORE FIELD indacrtdt name="construct.b.indacrtdt"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.indamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indamodid
            #add-point:ON ACTION controlp INFIELD indamodid name="construct.c.indamodid"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indamodid  #顯示到畫面上

            NEXT FIELD indamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indamodid
            #add-point:BEFORE FIELD indamodid name="construct.b.indamodid"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indamodid
            
            #add-point:AFTER FIELD indamodid name="construct.a.indamodid"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indamoddt
            #add-point:BEFORE FIELD indamoddt name="construct.b.indamoddt"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.indacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indacnfid
            #add-point:ON ACTION controlp INFIELD indacnfid name="construct.c.indacnfid"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indacnfid  #顯示到畫面上

            NEXT FIELD indacnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indacnfid
            #add-point:BEFORE FIELD indacnfid name="construct.b.indacnfid"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indacnfid
            
            #add-point:AFTER FIELD indacnfid name="construct.a.indacnfid"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indacnfdt
            #add-point:BEFORE FIELD indacnfdt name="construct.b.indacnfdt"
                                                
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON indbsite,indbunit,indbseq,indb002,indb001,indb003,indb004,indb005,indb006, 
          indb007,indb008,indb009,indb010,indb011,indb012,indb013
           FROM s_detail1[1].indbsite,s_detail1[1].indbunit,s_detail1[1].indbseq,s_detail1[1].indb002, 
               s_detail1[1].indb001,s_detail1[1].indb003,s_detail1[1].indb004,s_detail1[1].indb005,s_detail1[1].indb006, 
               s_detail1[1].indb007,s_detail1[1].indb008,s_detail1[1].indb009,s_detail1[1].indb010,s_detail1[1].indb011, 
               s_detail1[1].indb012,s_detail1[1].indb013
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
                                                
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indbsite
            #add-point:BEFORE FIELD indbsite name="construct.b.page1.indbsite"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indbsite
            
            #add-point:AFTER FIELD indbsite name="construct.a.page1.indbsite"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indbsite
            #add-point:ON ACTION controlp INFIELD indbsite name="construct.c.page1.indbsite"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indbunit
            #add-point:BEFORE FIELD indbunit name="construct.b.page1.indbunit"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indbunit
            
            #add-point:AFTER FIELD indbunit name="construct.a.page1.indbunit"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indbunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indbunit
            #add-point:ON ACTION controlp INFIELD indbunit name="construct.c.page1.indbunit"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indbseq
            #add-point:BEFORE FIELD indbseq name="construct.b.page1.indbseq"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indbseq
            
            #add-point:AFTER FIELD indbseq name="construct.a.page1.indbseq"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indbseq
            #add-point:ON ACTION controlp INFIELD indbseq name="construct.c.page1.indbseq"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.page1.indb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb002
            #add-point:ON ACTION controlp INFIELD indb002 name="construct.c.page1.indb002"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imay003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indb002  #顯示到畫面上

            NEXT FIELD indb002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb002
            #add-point:BEFORE FIELD indb002 name="construct.b.page1.indb002"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb002
            
            #add-point:AFTER FIELD indb002 name="construct.a.page1.indb002"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb001
            #add-point:ON ACTION controlp INFIELD indb001 name="construct.c.page1.indb001"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indb001  #顯示到畫面上

            NEXT FIELD indb001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb001
            #add-point:BEFORE FIELD indb001 name="construct.b.page1.indb001"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb001
            
            #add-point:AFTER FIELD indb001 name="construct.a.page1.indb001"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb003
            #add-point:BEFORE FIELD indb003 name="construct.b.page1.indb003"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb003
            
            #add-point:AFTER FIELD indb003 name="construct.a.page1.indb003"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb003
            #add-point:ON ACTION controlp INFIELD indb003 name="construct.c.page1.indb003"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.page1.indb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb004
            #add-point:ON ACTION controlp INFIELD indb004 name="construct.c.page1.indb004"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indb004  #顯示到畫面上

            NEXT FIELD indb004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb004
            #add-point:BEFORE FIELD indb004 name="construct.b.page1.indb004"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb004
            
            #add-point:AFTER FIELD indb004 name="construct.a.page1.indb004"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb005
            #add-point:ON ACTION controlp INFIELD indb005 name="construct.c.page1.indb005"
                                                            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indb005  #顯示到畫面上

            NEXT FIELD indb005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb005
            #add-point:BEFORE FIELD indb005 name="construct.b.page1.indb005"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb005
            
            #add-point:AFTER FIELD indb005 name="construct.a.page1.indb005"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb006
            #add-point:BEFORE FIELD indb006 name="construct.b.page1.indb006"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb006
            
            #add-point:AFTER FIELD indb006 name="construct.a.page1.indb006"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb006
            #add-point:ON ACTION controlp INFIELD indb006 name="construct.c.page1.indb006"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb007
            #add-point:BEFORE FIELD indb007 name="construct.b.page1.indb007"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb007
            
            #add-point:AFTER FIELD indb007 name="construct.a.page1.indb007"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb007
            #add-point:ON ACTION controlp INFIELD indb007 name="construct.c.page1.indb007"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb008
            #add-point:BEFORE FIELD indb008 name="construct.b.page1.indb008"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb008
            
            #add-point:AFTER FIELD indb008 name="construct.a.page1.indb008"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb008
            #add-point:ON ACTION controlp INFIELD indb008 name="construct.c.page1.indb008"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb009
            #add-point:BEFORE FIELD indb009 name="construct.b.page1.indb009"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb009
            
            #add-point:AFTER FIELD indb009 name="construct.a.page1.indb009"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb009
            #add-point:ON ACTION controlp INFIELD indb009 name="construct.c.page1.indb009"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb010
            #add-point:BEFORE FIELD indb010 name="construct.b.page1.indb010"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb010
            
            #add-point:AFTER FIELD indb010 name="construct.a.page1.indb010"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb010
            #add-point:ON ACTION controlp INFIELD indb010 name="construct.c.page1.indb010"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb011
            #add-point:BEFORE FIELD indb011 name="construct.b.page1.indb011"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb011
            
            #add-point:AFTER FIELD indb011 name="construct.a.page1.indb011"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb011
            #add-point:ON ACTION controlp INFIELD indb011 name="construct.c.page1.indb011"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb012
            #add-point:BEFORE FIELD indb012 name="construct.b.page1.indb012"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb012
            
            #add-point:AFTER FIELD indb012 name="construct.a.page1.indb012"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb012
            #add-point:ON ACTION controlp INFIELD indb012 name="construct.c.page1.indb012"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb013
            #add-point:BEFORE FIELD indb013 name="construct.b.page1.indb013"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb013
            
            #add-point:AFTER FIELD indb013 name="construct.a.page1.indb013"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb013
            #add-point:ON ACTION controlp INFIELD indb013 name="construct.c.page1.indb013"
                                                
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
                  WHEN la_wc[li_idx].tableid = "inda_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "indb_t" 
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
 
{<section id="aint500.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aint500_filter()
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
      CONSTRUCT g_wc_filter ON indasite,indadocdt,indadocno,inda001,inda003,inda004,inda005,inda002, 
          inda006
                          FROM s_browse[1].b_indasite,s_browse[1].b_indadocdt,s_browse[1].b_indadocno, 
                              s_browse[1].b_inda001,s_browse[1].b_inda003,s_browse[1].b_inda004,s_browse[1].b_inda005, 
                              s_browse[1].b_inda002,s_browse[1].b_inda006
 
         BEFORE CONSTRUCT
               DISPLAY aint500_filter_parser('indasite') TO s_browse[1].b_indasite
            DISPLAY aint500_filter_parser('indadocdt') TO s_browse[1].b_indadocdt
            DISPLAY aint500_filter_parser('indadocno') TO s_browse[1].b_indadocno
            DISPLAY aint500_filter_parser('inda001') TO s_browse[1].b_inda001
            DISPLAY aint500_filter_parser('inda003') TO s_browse[1].b_inda003
            DISPLAY aint500_filter_parser('inda004') TO s_browse[1].b_inda004
            DISPLAY aint500_filter_parser('inda005') TO s_browse[1].b_inda005
            DISPLAY aint500_filter_parser('inda002') TO s_browse[1].b_inda002
            DISPLAY aint500_filter_parser('inda006') TO s_browse[1].b_inda006
      
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
 
      CALL aint500_filter_show('indasite')
   CALL aint500_filter_show('indadocdt')
   CALL aint500_filter_show('indadocno')
   CALL aint500_filter_show('inda001')
   CALL aint500_filter_show('inda003')
   CALL aint500_filter_show('inda004')
   CALL aint500_filter_show('inda005')
   CALL aint500_filter_show('inda002')
   CALL aint500_filter_show('inda006')
 
END FUNCTION
 
{</section>}
 
{<section id="aint500.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aint500_filter_parser(ps_field)
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
 
{<section id="aint500.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aint500_filter_show(ps_field)
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
   LET ls_condition = aint500_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aint500.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aint500_query()
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
   CALL g_indb_d.clear()
 
   
   #add-point:query段other name="query.other"
            
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aint500_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aint500_browser_fill("")
      CALL aint500_fetch("")
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
      CALL aint500_filter_show('indasite')
   CALL aint500_filter_show('indadocdt')
   CALL aint500_filter_show('indadocno')
   CALL aint500_filter_show('inda001')
   CALL aint500_filter_show('inda003')
   CALL aint500_filter_show('inda004')
   CALL aint500_filter_show('inda005')
   CALL aint500_filter_show('inda002')
   CALL aint500_filter_show('inda006')
   CALL aint500_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aint500_fetch("F") 
      #顯示單身筆數
      CALL aint500_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aint500.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aint500_fetch(p_flag)
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
   
   LET g_inda_m.indadocno = g_browser[g_current_idx].b_indadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aint500_master_referesh USING g_inda_m.indadocno INTO g_inda_m.indasite,g_inda_m.indadocdt, 
       g_inda_m.indadocno,g_inda_m.inda001,g_inda_m.indaunit,g_inda_m.inda003,g_inda_m.inda004,g_inda_m.inda005, 
       g_inda_m.inda101,g_inda_m.inda002,g_inda_m.inda006,g_inda_m.indastus,g_inda_m.indaownid,g_inda_m.indaowndp, 
       g_inda_m.indacrtid,g_inda_m.indacrtdp,g_inda_m.indacrtdt,g_inda_m.indamodid,g_inda_m.indamoddt, 
       g_inda_m.indacnfid,g_inda_m.indacnfdt,g_inda_m.indasite_desc,g_inda_m.inda001_desc,g_inda_m.inda003_desc, 
       g_inda_m.inda004_desc,g_inda_m.inda101_desc,g_inda_m.inda002_desc,g_inda_m.indaownid_desc,g_inda_m.indaowndp_desc, 
       g_inda_m.indacrtid_desc,g_inda_m.indacrtdp_desc,g_inda_m.indamodid_desc,g_inda_m.indacnfid_desc 
 
   
   #遮罩相關處理
   LET g_inda_m_mask_o.* =  g_inda_m.*
   CALL aint500_inda_t_mask()
   LET g_inda_m_mask_n.* =  g_inda_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint500_set_act_visible()   
   CALL aint500_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
            
   #end add-point
   
   #保存單頭舊值
   LET g_inda_m_t.* = g_inda_m.*
   LET g_inda_m_o.* = g_inda_m.*
   
   LET g_data_owner = g_inda_m.indaownid      
   LET g_data_dept  = g_inda_m.indaowndp
   
   #重新顯示   
   CALL aint500_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aint500.insert" >}
#+ 資料新增
PRIVATE FUNCTION aint500_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   DEFINE l_insert      LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_indb_d.clear()   
 
 
   INITIALIZE g_inda_m.* TO NULL             #DEFAULT 設定
   
   LET g_indadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inda_m.indaownid = g_user
      LET g_inda_m.indaowndp = g_dept
      LET g_inda_m.indacrtid = g_user
      LET g_inda_m.indacrtdp = g_dept 
      LET g_inda_m.indacrtdt = cl_get_current()
      LET g_inda_m.indamodid = g_user
      LET g_inda_m.indamoddt = cl_get_current()
      LET g_inda_m.indastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_inda_m.indastus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
     #LET g_inda_m.indasite = g_site
     #LET g_inda_m.indaunit = g_site
      INITIALIZE g_inda_m_t.* TO NULL
     
      #预设值
      CALL s_aooi500_default(g_prog,'indasite',g_inda_m.indasite)
         RETURNING l_insert,g_inda_m.indasite
      IF l_insert = FALSE THEN
         RETURN
      END IF
      CALL s_aooi500_default(g_prog,'inda003',g_inda_m.indasite)
         RETURNING l_insert,g_inda_m.indasite
      IF l_insert = FALSE THEN
         RETURN
      END IF
      LET g_inda_m.indaunit  = g_inda_m.indasite
      LET g_inda_m.indadocdt = g_today
      LET g_inda_m.inda001   = g_user
     #LET g_inda_m.inda003   = g_site
      LET g_inda_m.inda005   = g_today
      CALL aint500_inda002_init()
      CALL aint500_indasite_ref()
      CALL aint500_inda001_ref()
      CALL aint500_inda002_ref()
      CALL aint500_inda003_ref()
      CALL aint500_inda004_ref()
      #sakura---add---str
      LET g_inda_m.inda101 = g_dept 
      CALL s_desc_get_department_desc(g_inda_m.inda101) RETURNING g_inda_m.inda101_desc
      DISPLAY BY NAME g_inda_m.inda101_desc 
      #sakura---add---end
      #预设单别
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_inda_m.indasite,g_prog,'1') RETURNING r_success,r_doctype
      LET g_inda_m.indadocno = r_doctype
      
      LET g_inda_m_t.* = g_inda_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_inda_m_t.* = g_inda_m.*
      LET g_inda_m_o.* = g_inda_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inda_m.indastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "T"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/org_approved.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL aint500_input("a")
      
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
         INITIALIZE g_inda_m.* TO NULL
         INITIALIZE g_indb_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aint500_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_indb_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint500_set_act_visible()   
   CALL aint500_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_indadocno_t = g_inda_m.indadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " indaent = " ||g_enterprise|| " AND",
                      " indadocno = '", g_inda_m.indadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint500_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aint500_cl
   
   CALL aint500_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aint500_master_referesh USING g_inda_m.indadocno INTO g_inda_m.indasite,g_inda_m.indadocdt, 
       g_inda_m.indadocno,g_inda_m.inda001,g_inda_m.indaunit,g_inda_m.inda003,g_inda_m.inda004,g_inda_m.inda005, 
       g_inda_m.inda101,g_inda_m.inda002,g_inda_m.inda006,g_inda_m.indastus,g_inda_m.indaownid,g_inda_m.indaowndp, 
       g_inda_m.indacrtid,g_inda_m.indacrtdp,g_inda_m.indacrtdt,g_inda_m.indamodid,g_inda_m.indamoddt, 
       g_inda_m.indacnfid,g_inda_m.indacnfdt,g_inda_m.indasite_desc,g_inda_m.inda001_desc,g_inda_m.inda003_desc, 
       g_inda_m.inda004_desc,g_inda_m.inda101_desc,g_inda_m.inda002_desc,g_inda_m.indaownid_desc,g_inda_m.indaowndp_desc, 
       g_inda_m.indacrtid_desc,g_inda_m.indacrtdp_desc,g_inda_m.indamodid_desc,g_inda_m.indacnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_inda_m_mask_o.* =  g_inda_m.*
   CALL aint500_inda_t_mask()
   LET g_inda_m_mask_n.* =  g_inda_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_inda_m.indasite,g_inda_m.indasite_desc,g_inda_m.indadocdt,g_inda_m.indadocno,g_inda_m.inda001, 
       g_inda_m.inda001_desc,g_inda_m.indaunit,g_inda_m.inda003,g_inda_m.inda003_desc,g_inda_m.inda004, 
       g_inda_m.inda004_desc,g_inda_m.inda005,g_inda_m.inda101,g_inda_m.inda101_desc,g_inda_m.inda002, 
       g_inda_m.inda002_desc,g_inda_m.inda006,g_inda_m.indastus,g_inda_m.indaownid,g_inda_m.indaownid_desc, 
       g_inda_m.indaowndp,g_inda_m.indaowndp_desc,g_inda_m.indacrtid,g_inda_m.indacrtid_desc,g_inda_m.indacrtdp, 
       g_inda_m.indacrtdp_desc,g_inda_m.indacrtdt,g_inda_m.indamodid,g_inda_m.indamodid_desc,g_inda_m.indamoddt, 
       g_inda_m.indacnfid,g_inda_m.indacnfid_desc,g_inda_m.indacnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_inda_m.indaownid      
   LET g_data_dept  = g_inda_m.indaowndp
   
   #功能已完成,通報訊息中心
   CALL aint500_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aint500.modify" >}
#+ 資料修改
PRIVATE FUNCTION aint500_modify()
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
   LET g_inda_m_t.* = g_inda_m.*
   LET g_inda_m_o.* = g_inda_m.*
   
   IF g_inda_m.indadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_indadocno_t = g_inda_m.indadocno
 
   CALL s_transaction_begin()
   
   OPEN aint500_cl USING g_enterprise,g_inda_m.indadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint500_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint500_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint500_master_referesh USING g_inda_m.indadocno INTO g_inda_m.indasite,g_inda_m.indadocdt, 
       g_inda_m.indadocno,g_inda_m.inda001,g_inda_m.indaunit,g_inda_m.inda003,g_inda_m.inda004,g_inda_m.inda005, 
       g_inda_m.inda101,g_inda_m.inda002,g_inda_m.inda006,g_inda_m.indastus,g_inda_m.indaownid,g_inda_m.indaowndp, 
       g_inda_m.indacrtid,g_inda_m.indacrtdp,g_inda_m.indacrtdt,g_inda_m.indamodid,g_inda_m.indamoddt, 
       g_inda_m.indacnfid,g_inda_m.indacnfdt,g_inda_m.indasite_desc,g_inda_m.inda001_desc,g_inda_m.inda003_desc, 
       g_inda_m.inda004_desc,g_inda_m.inda101_desc,g_inda_m.inda002_desc,g_inda_m.indaownid_desc,g_inda_m.indaowndp_desc, 
       g_inda_m.indacrtid_desc,g_inda_m.indacrtdp_desc,g_inda_m.indamodid_desc,g_inda_m.indacnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT aint500_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_inda_m_mask_o.* =  g_inda_m.*
   CALL aint500_inda_t_mask()
   LET g_inda_m_mask_n.* =  g_inda_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aint500_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_indadocno_t = g_inda_m.indadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_inda_m.indamodid = g_user 
LET g_inda_m.indamoddt = cl_get_current()
LET g_inda_m.indamodid_desc = cl_get_username(g_inda_m.indamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_inda_m.indastus MATCHES "[DR]" THEN 
         LET g_inda_m.indastus = "N"
      END IF
                        
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aint500_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
                        
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE inda_t SET (indamodid,indamoddt) = (g_inda_m.indamodid,g_inda_m.indamoddt)
          WHERE indaent = g_enterprise AND indadocno = g_indadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_inda_m.* = g_inda_m_t.*
            CALL aint500_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_inda_m.indadocno != g_inda_m_t.indadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
                                    
         #end add-point
         
         #更新單身key值
         UPDATE indb_t SET indbdocno = g_inda_m.indadocno
 
          WHERE indbent = g_enterprise AND indbdocno = g_inda_m_t.indadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
                                    
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "indb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "indb_t:",SQLERRMESSAGE 
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
   CALL aint500_set_act_visible()   
   CALL aint500_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " indaent = " ||g_enterprise|| " AND",
                      " indadocno = '", g_inda_m.indadocno, "' "
 
   #填到對應位置
   CALL aint500_browser_fill("")
 
   CLOSE aint500_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint500_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aint500.input" >}
#+ 資料輸入
PRIVATE FUNCTION aint500_input(p_cmd)
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
   DEFINE  l_success             LIKE type_t.chr1
   DEFINE  l_rate                LIKE inaj_t.inaj014
   DEFINE  l_errno               LIKE type_t.chr10
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
   DISPLAY BY NAME g_inda_m.indasite,g_inda_m.indasite_desc,g_inda_m.indadocdt,g_inda_m.indadocno,g_inda_m.inda001, 
       g_inda_m.inda001_desc,g_inda_m.indaunit,g_inda_m.inda003,g_inda_m.inda003_desc,g_inda_m.inda004, 
       g_inda_m.inda004_desc,g_inda_m.inda005,g_inda_m.inda101,g_inda_m.inda101_desc,g_inda_m.inda002, 
       g_inda_m.inda002_desc,g_inda_m.inda006,g_inda_m.indastus,g_inda_m.indaownid,g_inda_m.indaownid_desc, 
       g_inda_m.indaowndp,g_inda_m.indaowndp_desc,g_inda_m.indacrtid,g_inda_m.indacrtid_desc,g_inda_m.indacrtdp, 
       g_inda_m.indacrtdp_desc,g_inda_m.indacrtdt,g_inda_m.indamodid,g_inda_m.indamodid_desc,g_inda_m.indamoddt, 
       g_inda_m.indacnfid,g_inda_m.indacnfid_desc,g_inda_m.indacnfdt
   
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
   LET g_forupd_sql = "SELECT indbsite,indbunit,indbseq,indb002,indb001,indb003,indb004,indb005,indb006, 
       indb007,indb008,indb009,indb010,indb011,indb012,indb013 FROM indb_t WHERE indbent=? AND indbdocno=?  
       AND indbseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
            
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint500_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
            
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aint500_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
            
   #end add-point
   CALL aint500_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_inda_m.indasite,g_inda_m.indadocdt,g_inda_m.indadocno,g_inda_m.inda001,g_inda_m.indaunit, 
       g_inda_m.inda003,g_inda_m.inda004,g_inda_m.inda005,g_inda_m.inda101,g_inda_m.inda002,g_inda_m.inda006, 
       g_inda_m.indastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   IF g_inda_m.inda002 = g_site AND g_inda_m.indastus = 'Y' THEN
      LET l_allow_insert = FALSE
      LET l_allow_delete = FALSE
   END IF
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aint500.input.head" >}
      #單頭段
      INPUT BY NAME g_inda_m.indasite,g_inda_m.indadocdt,g_inda_m.indadocno,g_inda_m.inda001,g_inda_m.indaunit, 
          g_inda_m.inda003,g_inda_m.inda004,g_inda_m.inda005,g_inda_m.inda101,g_inda_m.inda002,g_inda_m.inda006, 
          g_inda_m.indastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aint500_cl USING g_enterprise,g_inda_m.indadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint500_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint500_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aint500_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
 
            #end add-point
            CALL aint500_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indasite
            
            #add-point:AFTER FIELD indasite name="input.a.indasite"
           #CALL aint500_indasite_ref()
            LET g_inda_m.indasite_desc = ''
            DISPLAY BY NAME g_inda_m.indasite
            IF NOT cl_null(g_inda_m.indasite) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_inda_m.indasite != g_inda_m_t.indasite OR g_inda_m_t.indasite IS NULL )) THEN   
                  CALL s_aooi500_chk(g_prog,'indasite',g_inda_m.indasite,g_inda_m.indasite)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_inda_m.indasite = g_inda_m_t.indasite
                     CALL s_desc_get_department_desc(g_inda_m.indasite) RETURNING g_inda_m.indasite_desc
                     DISPLAY BY NAME g_inda_m.indasite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_site_flag = TRUE
            CALL s_desc_get_department_desc(g_inda_m.indasite) RETURNING g_inda_m.indasite_desc
            DISPLAY BY NAME g_inda_m.indasite_desc
            CALL aint500_set_entry(p_cmd)
            CALL aint500_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indasite
            #add-point:BEFORE FIELD indasite name="input.b.indasite"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indasite
            #add-point:ON CHANGE indasite name="input.g.indasite"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indadocdt
            #add-point:BEFORE FIELD indadocdt name="input.b.indadocdt"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indadocdt
            
            #add-point:AFTER FIELD indadocdt name="input.a.indadocdt"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indadocdt
            #add-point:ON CHANGE indadocdt name="input.g.indadocdt"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indadocno
            #add-point:BEFORE FIELD indadocno name="input.b.indadocno"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indadocno
            
            #add-point:AFTER FIELD indadocno name="input.a.indadocno"
                                                            IF p_cmd = 'a' AND NOT cl_null(g_inda_m.indadocno) THEN 
               IF NOT s_aooi200_chk_slip(g_site,'',g_inda_m.indadocno,g_prog) THEN
                  LET g_inda_m.indadocno = g_inda_m_t.indadocno
                  DISPLAY BY NAME g_inda_m.indadocno
                  NEXT FIELD CURRENT
               END IF
            END IF
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_inda_m.indadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_inda_m.indadocno != g_indadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inda_t WHERE "||"indaent = '" ||g_enterprise|| "' AND "||"indadocno = '"||g_inda_m.indadocno ||"'",'std-00004',0) THEN 
                     LET g_inda_m.indadocno = g_inda_m_t.indadocno
                     DISPLAY BY NAME g_inda_m.indadocno
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indadocno
            #add-point:ON CHANGE indadocno name="input.g.indadocno"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda001
            
            #add-point:AFTER FIELD inda001 name="input.a.inda001"
                                                            LET g_inda_m.inda001_desc = ''
            DISPLAY BY NAME g_inda_m.inda001_desc
            IF NOT cl_null(g_inda_m.inda001) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               LET g_errshow = TRUE #是否開窗 #160318-00025#29  add
               LET g_chkparam.arg1 = g_inda_m.inda001
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"#要執行的建議程式待補 #160318-00025#29  add
               IF NOT cl_chk_exist("v_ooag001") THEN
                  LET g_inda_m.inda001 = g_inda_m_t.inda001
                  DISPLAY BY NAME g_inda_m.inda001
                  CALL aint500_inda001_ref()
                  NEXT FIELD CURRENT
               END IF
            #sakura---add---str
               SELECT ooag003 INTO g_inda_m.inda101 FROM ooag_t 
                 WHERE ooagent = g_enterprise AND ooag001 = g_inda_m.inda001
               DISPLAY BY NAME g_inda_m.inda101
               CALL s_desc_get_department_desc(g_inda_m.inda101) RETURNING g_inda_m.inda101_desc
               DISPLAY BY NAME g_inda_m.inda101_desc
            #sakura---add---end
            END IF 
            CALL aint500_inda001_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda001
            #add-point:BEFORE FIELD inda001 name="input.b.inda001"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inda001
            #add-point:ON CHANGE inda001 name="input.g.inda001"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indaunit
            #add-point:BEFORE FIELD indaunit name="input.b.indaunit"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indaunit
            
            #add-point:AFTER FIELD indaunit name="input.a.indaunit"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indaunit
            #add-point:ON CHANGE indaunit name="input.g.indaunit"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda003
            
            #add-point:AFTER FIELD inda003 name="input.a.inda003"
            LET g_inda_m.inda003_desc = ''
            DISPLAY BY NAME g_inda_m.inda003_desc
            IF NOT cl_null(g_inda_m.inda003) THEN 
               #检查
               IF s_aooi500_setpoint(g_prog,'inda003') THEN
                  #按aooi500设置
                  CALL s_aooi500_chk(g_prog,'inda003',g_inda_m.inda003,g_site)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_inda_m.inda003
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_inda_m.inda003 = g_inda_m_t.inda003
                     CALL s_desc_get_department_desc(g_inda_m.inda003) RETURNING g_inda_m.inda003_desc
                     DISPLAY BY NAME g_inda_m.inda003_desc
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #原逻辑
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = '1'
                  LET g_chkparam.arg1 = g_inda_m.inda003
                  LET g_chkparam.arg2 = '8'
                  LET g_chkparam.arg3 = g_site
                  IF NOT cl_chk_exist("v_ooed004") THEN
                     LET g_inda_m.inda003 = g_inda_m_t.inda003
                     DISPLAY BY NAME g_inda_m.inda003
                     CALL aint500_inda003_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            CALL aint500_inda002_init()
            CALL aint500_inda002_ref()
            CALL s_desc_get_department_desc(g_inda_m.inda003) RETURNING g_inda_m.inda003_desc
            DISPLAY BY NAME g_inda_m.inda003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda003
            #add-point:BEFORE FIELD inda003 name="input.b.inda003"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inda003
            #add-point:ON CHANGE inda003 name="input.g.inda003"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda004
            
            #add-point:AFTER FIELD inda004 name="input.a.inda004"
            LET g_inda_m.inda004_desc = ''
            DISPLAY BY NAME g_inda_m.inda004_desc
            IF NOT cl_null(g_inda_m.inda004) THEN 
               #检查
               IF s_aooi500_setpoint(g_prog,'inda004') THEN
                  #按aooi500设置
                  CALL s_aooi500_chk(g_prog,'inda004',g_inda_m.inda004,g_site)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_inda_m.inda004
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_inda_m.inda004 = g_inda_m_t.inda004
                     CALL s_desc_get_department_desc(g_inda_m.inda004) RETURNING g_inda_m.inda004_desc
                     DISPLAY BY NAME g_inda_m.inda004_desc
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #原逻辑
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = '1'
                  LET g_chkparam.arg1 = g_inda_m.inda004
                  IF NOT cl_chk_exist("v_ooef001_20") THEN
                     LET g_inda_m.inda004 = g_inda_m_t.inda004
                     DISPLAY BY NAME g_inda_m.inda004
                     CALL aint500_inda004_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            CALL s_desc_get_department_desc(g_inda_m.inda004) RETURNING g_inda_m.inda004_desc
            DISPLAY BY NAME g_inda_m.inda004_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda004
            #add-point:BEFORE FIELD inda004 name="input.b.inda004"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inda004
            #add-point:ON CHANGE inda004 name="input.g.inda004"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda005
            #add-point:BEFORE FIELD inda005 name="input.b.inda005"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda005
            
            #add-point:AFTER FIELD inda005 name="input.a.inda005"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inda005
            #add-point:ON CHANGE inda005 name="input.g.inda005"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda101
            
            #add-point:AFTER FIELD inda101 name="input.a.inda101"
            CALL s_desc_get_department_desc(g_inda_m.inda101) RETURNING g_inda_m.inda101_desc
            DISPLAY BY NAME g_inda_m.inda101_desc
            IF NOT cl_null(g_inda_m.inda101) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#29  add
               LET g_chkparam.arg1 = g_inda_m.inda101
               LET g_chkparam.arg2 = g_today              
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"#要執行的建議程式待補 #160318-00025#29  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_inda_m.inda101 = g_inda_m_t.inda101
                  CALL s_desc_get_department_desc(g_inda_m.inda101) RETURNING g_inda_m.inda101_desc
                  DISPLAY BY NAME g_inda_m.inda101_desc
                  NEXT FIELD CURRENT
               END IF
               CALL s_desc_get_department_desc(g_inda_m.inda101) RETURNING g_inda_m.inda101_desc
               DISPLAY BY NAME g_inda_m.inda101_desc
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda101
            #add-point:BEFORE FIELD inda101 name="input.b.inda101"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inda101
            #add-point:ON CHANGE inda101 name="input.g.inda101"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda002
            
            #add-point:AFTER FIELD inda002 name="input.a.inda002"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda002
            #add-point:BEFORE FIELD inda002 name="input.b.inda002"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inda002
            #add-point:ON CHANGE inda002 name="input.g.inda002"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inda006
            #add-point:BEFORE FIELD inda006 name="input.b.inda006"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inda006
            
            #add-point:AFTER FIELD inda006 name="input.a.inda006"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inda006
            #add-point:ON CHANGE inda006 name="input.g.inda006"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indastus
            #add-point:BEFORE FIELD indastus name="input.b.indastus"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indastus
            
            #add-point:AFTER FIELD indastus name="input.a.indastus"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indastus
            #add-point:ON CHANGE indastus name="input.g.indastus"
                                                
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.indasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indasite
            #add-point:ON ACTION controlp INFIELD indasite name="input.c.indasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inda_m.indasite
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'indasite',g_inda_m.indasite,'i') #150308-00001#2  By sakura add 'i'
            CALL q_ooef001_24()
            LET g_inda_m.indasite = g_qryparam.return1
            DISPLAY g_inda_m.indasite TO indasite
            CALL s_desc_get_department_desc(g_inda_m.indasite) RETURNING g_inda_m.indasite_desc
            DISPLAY BY NAME g_inda_m.indasite_desc
            NEXT FIELD indasite
            #END add-point
 
 
         #Ctrlp:input.c.indadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indadocdt
            #add-point:ON ACTION controlp INFIELD indadocdt name="input.c.indadocdt"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.indadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indadocno
            #add-point:ON ACTION controlp INFIELD indadocno name="input.c.indadocno"
                                                            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inda_m.indadocno         #給予default值
            #給予arg
            SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise
            LET g_qryparam.arg1 = l_ooef004 #
            #LET g_qryparam.arg2 = "aint500" #   #160705-00042#3 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#3 160711 by sakura add
            #160711-00040#15 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#15 add(e)
            CALL q_ooba002_1()                                   #呼叫開窗
            LET g_inda_m.indadocno = g_qryparam.return1          #將開窗取得的值回傳到變數
            DISPLAY g_inda_m.indadocno TO indadocno              #顯示到畫面上
            NEXT FIELD indadocno                                 #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.inda001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda001
            #add-point:ON ACTION controlp INFIELD inda001 name="input.c.inda001"
                                                #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inda_m.inda001             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_inda_m.inda001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_inda_m.inda001 TO inda001              #顯示到畫面上
            
            CALL aint500_inda001_ref()

            NEXT FIELD inda001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.indaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indaunit
            #add-point:ON ACTION controlp INFIELD indaunit name="input.c.indaunit"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.inda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda003
            #add-point:ON ACTION controlp INFIELD inda003 name="input.c.inda003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inda_m.inda003      #給予default值
            #开窗设定
            IF s_aooi500_setpoint(g_prog,'inda003') THEN
               #aooi500中有设定
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'inda003',g_site,'i') #150308-00001#2  By sakura add 'i'
               CALL q_ooef001_24()
            ELSE
               #aooi500中未设定按原逻辑
               #給予arg
               LET g_qryparam.arg1 = g_site #
               LET g_qryparam.arg2 = "8"    #
               CALL q_ooed004()
            END IF
            LET g_inda_m.inda003 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_inda_m.inda003 TO inda003             #顯示到畫面上
            CALL aint500_inda003_ref()
            NEXT FIELD inda003                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.inda004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda004
            #add-point:ON ACTION controlp INFIELD inda004 name="input.c.inda004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inda_m.inda004      #給予default值
            #开窗设定
            IF s_aooi500_setpoint(g_prog,'inda004') THEN
               #aooi500中有设定
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'inda004',g_site,'i') #150308-00001#2  By sakura add 'i'
               CALL q_ooef001_24()
            ELSE
               #aooi500中未设定按原逻辑
               #給予arg
               LET g_qryparam.arg1 = g_site #
               LET g_qryparam.arg2 = "8"    #
               CALL q_ooed004()
            END IF
            LET g_inda_m.inda004 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_inda_m.inda004 TO inda004             #顯示到畫面上
            CALL aint500_inda004_ref()
            NEXT FIELD inda004                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.inda005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda005
            #add-point:ON ACTION controlp INFIELD inda005 name="input.c.inda005"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.inda101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda101
            #add-point:ON ACTION controlp INFIELD inda101 name="input.c.inda101"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_inda_m.inda101             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()                                #呼叫開窗
            LET g_inda_m.inda101 = g_qryparam.return1              
            DISPLAY g_inda_m.inda101 TO inda101
            CALL s_desc_get_department_desc(g_inda_m.inda101) RETURNING g_inda_m.inda101_desc
            DISPLAY BY NAME g_inda_m.inda101_desc
            NEXT FIELD inda101                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.inda002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda002
            #add-point:ON ACTION controlp INFIELD inda002 name="input.c.inda002"
 
            #END add-point
 
 
         #Ctrlp:input.c.inda006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inda006
            #add-point:ON ACTION controlp INFIELD inda006 name="input.c.inda006"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.indastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indastus
            #add-point:ON ACTION controlp INFIELD indastus name="input.c.indastus"
                                                
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_inda_m.indadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                                                                              CALL s_aooi200_gen_docno(g_site,g_inda_m.indadocno,g_inda_m.indadocdt,g_prog) RETURNING l_success,g_inda_m.indadocno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00003'
                     LET g_errparam.extend = g_inda_m.indadocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD indadocno
                  END IF
               #end add-point
               
               INSERT INTO inda_t (indaent,indasite,indadocdt,indadocno,inda001,indaunit,inda003,inda004, 
                   inda005,inda101,inda002,inda006,indastus,indaownid,indaowndp,indacrtid,indacrtdp, 
                   indacrtdt,indamodid,indamoddt,indacnfid,indacnfdt)
               VALUES (g_enterprise,g_inda_m.indasite,g_inda_m.indadocdt,g_inda_m.indadocno,g_inda_m.inda001, 
                   g_inda_m.indaunit,g_inda_m.inda003,g_inda_m.inda004,g_inda_m.inda005,g_inda_m.inda101, 
                   g_inda_m.inda002,g_inda_m.inda006,g_inda_m.indastus,g_inda_m.indaownid,g_inda_m.indaowndp, 
                   g_inda_m.indacrtid,g_inda_m.indacrtdp,g_inda_m.indacrtdt,g_inda_m.indamodid,g_inda_m.indamoddt, 
                   g_inda_m.indacnfid,g_inda_m.indacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_inda_m:",SQLERRMESSAGE 
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
                  CALL aint500_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aint500_b_fill()
                  CALL aint500_b_fill2('0')
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
               CALL aint500_inda_t_mask_restore('restore_mask_o')
               
               UPDATE inda_t SET (indasite,indadocdt,indadocno,inda001,indaunit,inda003,inda004,inda005, 
                   inda101,inda002,inda006,indastus,indaownid,indaowndp,indacrtid,indacrtdp,indacrtdt, 
                   indamodid,indamoddt,indacnfid,indacnfdt) = (g_inda_m.indasite,g_inda_m.indadocdt, 
                   g_inda_m.indadocno,g_inda_m.inda001,g_inda_m.indaunit,g_inda_m.inda003,g_inda_m.inda004, 
                   g_inda_m.inda005,g_inda_m.inda101,g_inda_m.inda002,g_inda_m.inda006,g_inda_m.indastus, 
                   g_inda_m.indaownid,g_inda_m.indaowndp,g_inda_m.indacrtid,g_inda_m.indacrtdp,g_inda_m.indacrtdt, 
                   g_inda_m.indamodid,g_inda_m.indamoddt,g_inda_m.indacnfid,g_inda_m.indacnfdt)
                WHERE indaent = g_enterprise AND indadocno = g_indadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "inda_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
                                                            
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aint500_inda_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_inda_m_t)
               LET g_log2 = util.JSON.stringify(g_inda_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                                                            
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_indadocno_t = g_inda_m.indadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aint500.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_indb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_indb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aint500_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_indb_d.getLength()
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
            OPEN aint500_cl USING g_enterprise,g_inda_m.indadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint500_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint500_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_indb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_indb_d[l_ac].indbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_indb_d_t.* = g_indb_d[l_ac].*  #BACKUP
               LET g_indb_d_o.* = g_indb_d[l_ac].*  #BACKUP
               CALL aint500_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
                                                            
               #end add-point  
               CALL aint500_set_no_entry_b(l_cmd)
               IF NOT aint500_lock_b("indb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aint500_bcl INTO g_indb_d[l_ac].indbsite,g_indb_d[l_ac].indbunit,g_indb_d[l_ac].indbseq, 
                      g_indb_d[l_ac].indb002,g_indb_d[l_ac].indb001,g_indb_d[l_ac].indb003,g_indb_d[l_ac].indb004, 
                      g_indb_d[l_ac].indb005,g_indb_d[l_ac].indb006,g_indb_d[l_ac].indb007,g_indb_d[l_ac].indb008, 
                      g_indb_d[l_ac].indb009,g_indb_d[l_ac].indb010,g_indb_d[l_ac].indb011,g_indb_d[l_ac].indb012, 
                      g_indb_d[l_ac].indb013
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_indb_d_t.indbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_indb_d_mask_o[l_ac].* =  g_indb_d[l_ac].*
                  CALL aint500_indb_t_mask()
                  LET g_indb_d_mask_n[l_ac].* =  g_indb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aint500_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
                                                LET g_indb_d_o.* = g_indb_d[l_ac].*
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
            INITIALIZE g_indb_d[l_ac].* TO NULL 
            INITIALIZE g_indb_d_t.* TO NULL 
            INITIALIZE g_indb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_indb_d[l_ac].indb006 = "0"
      LET g_indb_d[l_ac].indb007 = "0"
      LET g_indb_d[l_ac].indb008 = "0"
      LET g_indb_d[l_ac].indb009 = "0"
      LET g_indb_d[l_ac].indb010 = "0"
      LET g_indb_d[l_ac].indb011 = "0"
      LET g_indb_d[l_ac].indb012 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_indb_d_t.* = g_indb_d[l_ac].*     #新輸入資料
            LET g_indb_d_o.* = g_indb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aint500_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
                                                
            #end add-point
            CALL aint500_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_indb_d[li_reproduce_target].* = g_indb_d[li_reproduce].*
 
               LET g_indb_d[li_reproduce_target].indbseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            CALL aint500_indbseq_init()
            LET g_indb_d[l_ac].indbsite = g_inda_m.indasite
            LET g_indb_d[l_ac].indbunit = g_inda_m.indaunit
            LET g_indb_d_t.* = g_indb_d[l_ac].*
            LET g_indb_d_o.* = g_indb_d[l_ac].*
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
            SELECT COUNT(1) INTO l_count FROM indb_t 
             WHERE indbent = g_enterprise AND indbdocno = g_inda_m.indadocno
 
               AND indbseq = g_indb_d[l_ac].indbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
                                                            
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inda_m.indadocno
               LET gs_keys[2] = g_indb_d[g_detail_idx].indbseq
               CALL aint500_insert_b('indb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
                                                            
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_indb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "indb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aint500_b_fill()
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
               LET gs_keys[01] = g_inda_m.indadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_indb_d_t.indbseq
 
            
               #刪除同層單身
               IF NOT aint500_delete_b('indb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint500_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aint500_key_delete_b(gs_keys,'indb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint500_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
                                                            
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aint500_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                                                                        
               #end add-point
               LET l_count = g_indb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
                                                
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_indb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indbsite
            #add-point:BEFORE FIELD indbsite name="input.b.page1.indbsite"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indbsite
            
            #add-point:AFTER FIELD indbsite name="input.a.page1.indbsite"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indbsite
            #add-point:ON CHANGE indbsite name="input.g.page1.indbsite"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indbunit
            #add-point:BEFORE FIELD indbunit name="input.b.page1.indbunit"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indbunit
            
            #add-point:AFTER FIELD indbunit name="input.a.page1.indbunit"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indbunit
            #add-point:ON CHANGE indbunit name="input.g.page1.indbunit"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indbseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_indb_d[l_ac].indbseq,"0","0","","","azz-00079",1) THEN
               NEXT FIELD indbseq
            END IF 
 
 
 
            #add-point:AFTER FIELD indbseq name="input.a.page1.indbseq"
                                                            #此段落由子樣板a05產生
            IF  g_inda_m.indadocno IS NOT NULL AND g_indb_d[g_detail_idx].indbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inda_m.indadocno != g_indadocno_t OR g_indb_d[g_detail_idx].indbseq != g_indb_d_t.indbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM indb_t WHERE "||"indbent = '" ||g_enterprise|| "' AND "||"indbdocno = '"||g_inda_m.indadocno ||"' AND "|| "indbseq = '"||g_indb_d[g_detail_idx].indbseq ||"'",'std-00004',0) THEN 
                     LET g_indb_d[l_ac].indbseq = g_indb_d_t.indbseq
                     DISPLAY BY NAME g_indb_d[l_ac].indbseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indbseq
            #add-point:BEFORE FIELD indbseq name="input.b.page1.indbseq"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indbseq
            #add-point:ON CHANGE indbseq name="input.g.page1.indbseq"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb002
            
            #add-point:AFTER FIELD indb002 name="input.a.page1.indb002"
                                                            IF NOT cl_null(g_indb_d[l_ac].indb002) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               LET g_chkparam.arg1 = g_indb_d[l_ac].indb002
               IF NOT cl_chk_exist("v_imay003_1") THEN
                  LET g_indb_d[l_ac].indb002 = g_indb_d_t.indb002   
                  DISPLAY BY NAME g_indb_d[l_ac].indb002
                  NEXT FIELD CURRENT
               END IF
               CALL aint500_indb002_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_indb_d[l_ac].indb002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_indb_d[l_ac].indb002 = g_indb_d_t.indb002  
                  
                  DISPLAY BY NAME g_indb_d[l_ac].indb002
                  NEXT FIELD CURRENT
               END IF
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_indb_d[l_ac].indb002 != g_indb_d_t.indb002 OR g_indb_d_t.indb002 IS NULL)) THEN
                  IF cl_null(g_indb_d_o.indb002) OR g_indb_d_o.indb002 != g_indb_d[l_ac].indb002 THEN
                     CALL aint500_indb002_init()
                  END IF
               END IF
            END IF 
            LET g_indb_d_o.* = g_indb_d[l_ac].*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb002
            #add-point:BEFORE FIELD indb002 name="input.b.page1.indb002"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb002
            #add-point:ON CHANGE indb002 name="input.g.page1.indb002"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb001
            
            #add-point:AFTER FIELD indb001 name="input.a.page1.indb001"
                                                            LET g_indb_d[l_ac].indb001_desc = ''
            DISPLAY BY NAME g_indb_d[l_ac].indb001_desc
            IF NOT cl_null(g_indb_d[l_ac].indb001) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               LET g_chkparam.arg1 = g_indb_d[l_ac].indb001
               LET g_chkparam.arg2 = g_inda_m.inda003
               IF NOT cl_chk_exist("v_rtdx001_1") THEN
                  LET g_indb_d[l_ac].indb001 = g_indb_d_t.indb001
                  DISPLAY BY NAME g_indb_d[l_ac].indb001
                  CALL aint500_indb001_ref()
                  NEXT FIELD CURRENT
               END IF
               CALL aint500_indb001_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_indb_d[l_ac].indb001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_indb_d[l_ac].indb001 = g_indb_d_t.indb001   
                  DISPLAY BY NAME g_indb_d[l_ac].indb001
                  CALL aint500_indb001_ref()
                  NEXT FIELD CURRENT
               END IF
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_indb_d[l_ac].indb001 != g_indb_d_t.indb001 OR g_indb_d_t.indb001 IS NULL)) THEN
                  IF cl_null(g_indb_d_o.indb001) OR g_indb_d_o.indb001 != g_indb_d[l_ac].indb001 OR cl_null(g_indb_d[l_ac].indb002) THEN
                     CALL aint500_indb001_init()
                     IF NOT cl_null(g_indb_d[l_ac].indb002) THEN
                        CALL aint500_indb002_init()
                     END IF
                  END IF
               END IF
            END IF 
            CALL aint500_indb001_ref()
            LET g_indb_d_o.* = g_indb_d[l_ac].*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb001
            #add-point:BEFORE FIELD indb001 name="input.b.page1.indb001"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb001
            #add-point:ON CHANGE indb001 name="input.g.page1.indb001"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb003
            #add-point:BEFORE FIELD indb003 name="input.b.page1.indb003"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb003
            
            #add-point:AFTER FIELD indb003 name="input.a.page1.indb003"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb003
            #add-point:ON CHANGE indb003 name="input.g.page1.indb003"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb004
            
            #add-point:AFTER FIELD indb004 name="input.a.page1.indb004"
                                    LET g_indb_d[l_ac].indb004_desc = ''
            DISPLAY BY NAME g_indb_d[l_ac].indb004_desc
            IF NOT cl_null(g_indb_d[l_ac].indb004) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               LET g_errshow = TRUE #是否開窗 #160318-00025#29  add
               LET g_chkparam.arg1 = g_indb_d[l_ac].indb004
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"#要執行的建議程式待補 #160318-00025#29  add
               IF NOT cl_chk_exist("v_ooca001") THEN
                  #LET g_indb_d[l_ac].indb004 = g_indb_d_t.indb004   
                  DISPLAY BY NAME g_indb_d[l_ac].indb004
                  CALL aint500_indb004_ref()
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL aint500_indb004_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb004
            #add-point:BEFORE FIELD indb004 name="input.b.page1.indb004"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb004
            #add-point:ON CHANGE indb004 name="input.g.page1.indb004"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb005
            
            #add-point:AFTER FIELD indb005 name="input.a.page1.indb005"
                                    LET g_indb_d[l_ac].indb005_desc = ''
            DISPLAY BY NAME g_indb_d[l_ac].indb005_desc
            IF NOT cl_null(g_indb_d[l_ac].indb005) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = '1'
               LET g_errshow = TRUE #是否開窗 #160318-00025#29  add
               LET g_chkparam.arg1 = g_indb_d[l_ac].indb005
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"#要執行的建議程式待補 #160318-00025#29  add
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_indb_d[l_ac].indb005 = g_indb_d_t.indb005
                  DISPLAY BY NAME g_indb_d[l_ac].indb005
                  CALL aint500_indb005_ref()
                  NEXT FIELD CURRENT
               END IF
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_indb_d[l_ac].indb005 != g_indb_d_t.indb005 OR g_indb_d_t.indb005 IS NULL)) THEN  
                  IF NOT cl_null(g_indb_d[l_ac].indb004) AND NOT cl_null(g_indb_d[l_ac].indb001) THEN
                     CALL s_aimi190_get_convert(g_indb_d[l_ac].indb001,g_indb_d[l_ac].indb005,g_indb_d[l_ac].indb004) RETURNING l_success,l_rate
                     IF NOT l_success THEN
                        LET g_indb_d[l_ac].indb005 = g_indb_d_t.indb005
                        DISPLAY BY NAME g_indb_d[l_ac].indb005
                        CALL aint500_indb005_ref()
                        NEXT FIELD CURRENT
                     END IF
                     LET g_indb_d[l_ac].indb006 = l_rate
                     INITIALIZE g_indb_d[l_ac].indb007,g_indb_d[l_ac].indb008,g_indb_d[l_ac].indb009,g_indb_d[l_ac].indb010 TO NULL
                     DISPLAY BY NAME g_indb_d[l_ac].indb006,g_indb_d[l_ac].indb007,g_indb_d[l_ac].indb008,g_indb_d[l_ac].indb009,g_indb_d[l_ac].indb010
                  END IF
               END IF
            END IF 
            CALL aint500_indb005_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb005
            #add-point:BEFORE FIELD indb005 name="input.b.page1.indb005"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb005
            #add-point:ON CHANGE indb005 name="input.g.page1.indb005"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb006
            #add-point:BEFORE FIELD indb006 name="input.b.page1.indb006"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb006
            
            #add-point:AFTER FIELD indb006 name="input.a.page1.indb006"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb006
            #add-point:ON CHANGE indb006 name="input.g.page1.indb006"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_indb_d[l_ac].indb007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD indb007
            END IF 
 
 
 
            #add-point:AFTER FIELD indb007 name="input.a.page1.indb007"
                                                IF NOT cl_null(g_indb_d[l_ac].indb007) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_indb_d[l_ac].indb007 != g_indb_d_t.indb007 OR cl_null(g_indb_d_t.indb007))) THEN
                  IF cl_null(g_indb_d_o.indb007) OR g_indb_d[l_ac].indb007 != g_indb_d_o.indb007 THEN
                     CALL aint500_indb007_init()
                  END IF
               END IF
            END IF 
            LET g_indb_d[l_ac].indb009 = g_indb_d[l_ac].indb007
            LET g_indb_d[l_ac].indb010 = g_indb_d[l_ac].indb008
            LET g_indb_d_o.* = g_indb_d[l_ac].*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb007
            #add-point:BEFORE FIELD indb007 name="input.b.page1.indb007"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb007
            #add-point:ON CHANGE indb007 name="input.g.page1.indb007"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_indb_d[l_ac].indb008,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD indb008
            END IF 
 
 
 
            #add-point:AFTER FIELD indb008 name="input.a.page1.indb008"
                                                IF NOT cl_null(g_indb_d[l_ac].indb008) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_indb_d[l_ac].indb008 != g_indb_d_t.indb008 OR cl_null(g_indb_d_t.indb008))) THEN
                  IF cl_null(g_indb_d_o.indb008) OR g_indb_d[l_ac].indb008 != g_indb_d_o.indb008 THEN
                     CALL aint500_indb008_init()
                  END IF
               END IF
            END IF 
            LET g_indb_d[l_ac].indb009 = g_indb_d[l_ac].indb007
            LET g_indb_d[l_ac].indb010 = g_indb_d[l_ac].indb008
            LET g_indb_d_o.* = g_indb_d[l_ac].*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb008
            #add-point:BEFORE FIELD indb008 name="input.b.page1.indb008"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb008
            #add-point:ON CHANGE indb008 name="input.g.page1.indb008"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_indb_d[l_ac].indb009,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD indb009
            END IF 
 
 
 
            #add-point:AFTER FIELD indb009 name="input.a.page1.indb009"
                                                IF NOT cl_null(g_indb_d[l_ac].indb009) THEN 
               CALL aint500_indb009_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_indb_d[l_ac].indb009
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_indb_d[l_ac].indb009 = g_indb_d_t.indb009   
                  DISPLAY BY NAME g_indb_d[l_ac].indb009
                  NEXT FIELD CURRENT
               END IF
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_indb_d[l_ac].indb009 != g_indb_d_t.indb009 OR cl_null(g_indb_d_t.indb009))) THEN
                  IF cl_null(g_indb_d_o.indb009) OR g_indb_d[l_ac].indb009 != g_indb_d_o.indb009 THEN
                     CALL aint500_indb009_init()
                  END IF
               END IF
            END IF 
            LET g_indb_d_o.* = g_indb_d[l_ac].*

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb009
            #add-point:BEFORE FIELD indb009 name="input.b.page1.indb009"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb009
            #add-point:ON CHANGE indb009 name="input.g.page1.indb009"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_indb_d[l_ac].indb010,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD indb010
            END IF 
 
 
 
            #add-point:AFTER FIELD indb010 name="input.a.page1.indb010"
                                                IF NOT cl_null(g_indb_d[l_ac].indb010) THEN 
               CALL aint500_indb010_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_indb_d[l_ac].indb010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_indb_d[l_ac].indb010 = g_indb_d_t.indb010
                  DISPLAY BY NAME g_indb_d[l_ac].indb010
                  NEXT FIELD CURRENT
               END IF
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_indb_d[l_ac].indb010 != g_indb_d_t.indb010 OR cl_null(g_indb_d_t.indb010))) THEN
                  IF cl_null(g_indb_d_o.indb010) OR g_indb_d[l_ac].indb010 != g_indb_d_o.indb010 THEN
                     CALL aint500_indb010_init()
                  END IF
               END IF
            END IF 
            LET g_indb_d_o.* = g_indb_d[l_ac].*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb010
            #add-point:BEFORE FIELD indb010 name="input.b.page1.indb010"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb010
            #add-point:ON CHANGE indb010 name="input.g.page1.indb010"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb011
            #add-point:BEFORE FIELD indb011 name="input.b.page1.indb011"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb011
            
            #add-point:AFTER FIELD indb011 name="input.a.page1.indb011"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb011
            #add-point:ON CHANGE indb011 name="input.g.page1.indb011"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb012
            #add-point:BEFORE FIELD indb012 name="input.b.page1.indb012"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb012
            
            #add-point:AFTER FIELD indb012 name="input.a.page1.indb012"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb012
            #add-point:ON CHANGE indb012 name="input.g.page1.indb012"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indb013
            #add-point:BEFORE FIELD indb013 name="input.b.page1.indb013"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indb013
            
            #add-point:AFTER FIELD indb013 name="input.a.page1.indb013"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indb013
            #add-point:ON CHANGE indb013 name="input.g.page1.indb013"
                                                
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.indbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indbsite
            #add-point:ON ACTION controlp INFIELD indbsite name="input.c.page1.indbsite"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indbunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indbunit
            #add-point:ON ACTION controlp INFIELD indbunit name="input.c.page1.indbunit"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indbseq
            #add-point:ON ACTION controlp INFIELD indbseq name="input.c.page1.indbseq"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb002
            #add-point:ON ACTION controlp INFIELD indb002 name="input.c.page1.indb002"
                                                #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indb_d[l_ac].indb002             #給予default值

            #給予arg
			LET g_qryparam.where = "     imay001 IN (SELECT rtdx001 ",
			                       "                   FROM rtdx_t ",
			                       "                  WHERE rtdxent = '",g_enterprise,"' ",
			                       "                    AND rtdxsite = '",g_inda_m.inda003,"' ",
			                       "                    AND rtdxstus = 'Y') ",
			                       " AND imay001 IN (SELECT rtdx001 ",
			                       "                   FROM rtdx_t ",
			                       "                  WHERE rtdxent = '",g_enterprise,"' ",
			                       "                    AND rtdxsite = '",g_inda_m.inda004,"' ",
			                       "                    AND rtdxstus = 'Y') "

            CALL q_imay003_2()                                #呼叫開窗

            LET g_indb_d[l_ac].indb002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_indb_d[l_ac].indb002 TO indb002              #顯示到畫面上
            
            CALL aint500_indb002_init()

            NEXT FIELD indb002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb001
            #add-point:ON ACTION controlp INFIELD indb001 name="input.c.page1.indb001"
                                                #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indb_d[l_ac].indb001             #給予default值

            #給予arg
			LET g_qryparam.arg1 = g_inda_m.inda003
			LET g_qryparam.where = "     rtdx001 IN (SELECT rtdx001 ",
			                       "                   FROM rtdx_t ",
			                       "                  WHERE rtdxent = '",g_enterprise,"' ",
			                       "                    AND rtdxsite = '",g_inda_m.inda004,"' ",
			                       "                    AND rtdxstus = 'Y') "

            CALL q_rtdx001_1()                                #呼叫開窗

            LET g_indb_d[l_ac].indb001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_indb_d[l_ac].indb001 TO indb001              #顯示到畫面上
            
            CALL aint500_indb001_init()
            IF NOT cl_null(g_indb_d[l_ac].indb002) THEN
               CALL aint500_indb002_init()
            END IF
            
            CALL aint500_indb001_ref()

            NEXT FIELD indb001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb003
            #add-point:ON ACTION controlp INFIELD indb003 name="input.c.page1.indb003"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb004
            #add-point:ON ACTION controlp INFIELD indb004 name="input.c.page1.indb004"
                                                #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indb_d[l_ac].indb004             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_indb_d[l_ac].indb004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_indb_d[l_ac].indb004 TO indb004              #顯示到畫面上
            
            CALL aint500_indb004_ref()

            NEXT FIELD indb004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb005
            #add-point:ON ACTION controlp INFIELD indb005 name="input.c.page1.indb005"
                                                #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_indb_d[l_ac].indb005             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_indb_d[l_ac].indb005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_indb_d[l_ac].indb005 TO indb005              #顯示到畫面上
            
            CALL aint500_indb005_ref()

            NEXT FIELD indb005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.indb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb006
            #add-point:ON ACTION controlp INFIELD indb006 name="input.c.page1.indb006"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb007
            #add-point:ON ACTION controlp INFIELD indb007 name="input.c.page1.indb007"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb008
            #add-point:ON ACTION controlp INFIELD indb008 name="input.c.page1.indb008"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb009
            #add-point:ON ACTION controlp INFIELD indb009 name="input.c.page1.indb009"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb010
            #add-point:ON ACTION controlp INFIELD indb010 name="input.c.page1.indb010"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb011
            #add-point:ON ACTION controlp INFIELD indb011 name="input.c.page1.indb011"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb012
            #add-point:ON ACTION controlp INFIELD indb012 name="input.c.page1.indb012"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.indb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indb013
            #add-point:ON ACTION controlp INFIELD indb013 name="input.c.page1.indb013"
                                                
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_indb_d[l_ac].* = g_indb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aint500_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_indb_d[l_ac].indbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_indb_d[l_ac].* = g_indb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
                                                            
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aint500_indb_t_mask_restore('restore_mask_o')
      
               UPDATE indb_t SET (indbdocno,indbsite,indbunit,indbseq,indb002,indb001,indb003,indb004, 
                   indb005,indb006,indb007,indb008,indb009,indb010,indb011,indb012,indb013) = (g_inda_m.indadocno, 
                   g_indb_d[l_ac].indbsite,g_indb_d[l_ac].indbunit,g_indb_d[l_ac].indbseq,g_indb_d[l_ac].indb002, 
                   g_indb_d[l_ac].indb001,g_indb_d[l_ac].indb003,g_indb_d[l_ac].indb004,g_indb_d[l_ac].indb005, 
                   g_indb_d[l_ac].indb006,g_indb_d[l_ac].indb007,g_indb_d[l_ac].indb008,g_indb_d[l_ac].indb009, 
                   g_indb_d[l_ac].indb010,g_indb_d[l_ac].indb011,g_indb_d[l_ac].indb012,g_indb_d[l_ac].indb013) 
 
                WHERE indbent = g_enterprise AND indbdocno = g_inda_m.indadocno 
 
                  AND indbseq = g_indb_d_t.indbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
                                                            
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_indb_d[l_ac].* = g_indb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "indb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_indb_d[l_ac].* = g_indb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "indb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inda_m.indadocno
               LET gs_keys_bak[1] = g_indadocno_t
               LET gs_keys[2] = g_indb_d[g_detail_idx].indbseq
               LET gs_keys_bak[2] = g_indb_d_t.indbseq
               CALL aint500_update_b('indb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aint500_indb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_indb_d[g_detail_idx].indbseq = g_indb_d_t.indbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_inda_m.indadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_indb_d_t.indbseq
 
                  CALL aint500_key_update_b(gs_keys,'indb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_inda_m),util.JSON.stringify(g_indb_d_t)
               LET g_log2 = util.JSON.stringify(g_inda_m),util.JSON.stringify(g_indb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
                                                            
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
                                                
            #end add-point
            CALL aint500_unlock_b("indb_t","'1'")
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
               LET g_indb_d[li_reproduce_target].* = g_indb_d[li_reproduce].*
 
               LET g_indb_d[li_reproduce_target].indbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_indb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_indb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="aint500.input.other" >}
      
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
            NEXT FIELD indasite
            #end add-point  
            NEXT FIELD indadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD indbsite
 
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
 
{<section id="aint500.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aint500_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
            
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
            
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aint500_b_fill() #單身填充
      CALL aint500_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aint500_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL s_desc_get_department_desc(g_inda_m.inda101) RETURNING g_inda_m.inda101_desc #sakura add
#   CALL aint500_indasite_ref()
#   CALL aint500_inda001_ref()
#   CALL aint500_inda003_ref()
#   CALL aint500_inda004_ref()
#   CALL aint500_inda002_ref()
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inda_m.indaownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_inda_m.indaownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inda_m.indaownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inda_m.indaowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_inda_m.indaowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inda_m.indaowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inda_m.indacrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_inda_m.indacrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inda_m.indacrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inda_m.indacrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_inda_m.indacrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inda_m.indacrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inda_m.indamodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_inda_m.indamodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inda_m.indamodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_inda_m.indacnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_inda_m.indacnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_inda_m.indacnfid_desc
   #end add-point
   
   #遮罩相關處理
   LET g_inda_m_mask_o.* =  g_inda_m.*
   CALL aint500_inda_t_mask()
   LET g_inda_m_mask_n.* =  g_inda_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_inda_m.indasite,g_inda_m.indasite_desc,g_inda_m.indadocdt,g_inda_m.indadocno,g_inda_m.inda001, 
       g_inda_m.inda001_desc,g_inda_m.indaunit,g_inda_m.inda003,g_inda_m.inda003_desc,g_inda_m.inda004, 
       g_inda_m.inda004_desc,g_inda_m.inda005,g_inda_m.inda101,g_inda_m.inda101_desc,g_inda_m.inda002, 
       g_inda_m.inda002_desc,g_inda_m.inda006,g_inda_m.indastus,g_inda_m.indaownid,g_inda_m.indaownid_desc, 
       g_inda_m.indaowndp,g_inda_m.indaowndp_desc,g_inda_m.indacrtid,g_inda_m.indacrtid_desc,g_inda_m.indacrtdp, 
       g_inda_m.indacrtdp_desc,g_inda_m.indacrtdt,g_inda_m.indamodid,g_inda_m.indamodid_desc,g_inda_m.indamoddt, 
       g_inda_m.indacnfid,g_inda_m.indacnfid_desc,g_inda_m.indacnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inda_m.indastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "T"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/org_approved.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_indb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
#      CALL aint500_indb001_ref()
#      CALL aint500_indb004_ref()
#      CALL aint500_indb005_ref()
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
            
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aint500_detail_show()
 
   #add-point:show段之後 name="show.after"
            
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aint500.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aint500_detail_show()
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
 
{<section id="aint500.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aint500_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE inda_t.indadocno 
   DEFINE l_oldno     LIKE inda_t.indadocno 
 
   DEFINE l_master    RECORD LIKE inda_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE indb_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_inda_m.indadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_indadocno_t = g_inda_m.indadocno
 
    
   LET g_inda_m.indadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inda_m.indaownid = g_user
      LET g_inda_m.indaowndp = g_dept
      LET g_inda_m.indacrtid = g_user
      LET g_inda_m.indacrtdp = g_dept 
      LET g_inda_m.indacrtdt = cl_get_current()
      LET g_inda_m.indamodid = g_user
      LET g_inda_m.indamoddt = cl_get_current()
      LET g_inda_m.indastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_inda_m.indastus = "N"
   LET g_inda_m.indasite = g_site
   LET g_inda_m.indaunit = g_site
   LET g_inda_m.indadocdt = g_today
   LET g_inda_m.inda001 = g_user
   LET g_inda_m.inda003 = g_site
   LET g_inda_m.inda005 = g_today
   CALL aint500_inda002_init()
   CALL aint500_indasite_ref()
   CALL aint500_inda001_ref()
   CALL aint500_inda002_ref()
   CALL aint500_inda003_ref()
   CALL aint500_inda004_ref()
   LET g_inda_m.indacnfid = ""
   LET g_inda_m.indacnfdt = ""
   CALL s_desc_get_department_desc(g_inda_m.inda101) RETURNING g_inda_m.inda101_desc #sakura add
   DISPLAY BY NAME g_inda_m.inda101_desc                                             #sakura add
   #预设单别
   LET r_success = ''
   LET r_doctype = ''
   CALL s_arti200_get_def_doc_type(g_inda_m.indasite,g_prog,'1') RETURNING r_success,r_doctype
   LET g_inda_m.indadocno = r_doctype
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inda_m.indastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "T"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/org_approved.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL aint500_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_inda_m.* TO NULL
      INITIALIZE g_indb_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aint500_show()
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
   CALL aint500_set_act_visible()   
   CALL aint500_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_indadocno_t = g_inda_m.indadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " indaent = " ||g_enterprise|| " AND",
                      " indadocno = '", g_inda_m.indadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint500_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
            
   #end add-point
   
   CALL aint500_idx_chk()
   
   LET g_data_owner = g_inda_m.indaownid      
   LET g_data_dept  = g_inda_m.indaowndp
   
   #功能已完成,通報訊息中心
   CALL aint500_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aint500.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aint500_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE indb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
            
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aint500_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
            
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM indb_t
    WHERE indbent = g_enterprise AND indbdocno = g_indadocno_t
 
    INTO TEMP aint500_detail
 
   #將key修正為調整後   
   UPDATE aint500_detail 
      #更新key欄位
      SET indbdocno = g_inda_m.indadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO indb_t SELECT * FROM aint500_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   UPDATE indb_t SET indb011 = '',indb012 = ''
    WHERE indbent = g_enterprise AND indbdocno = g_inda_m.indadocno
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aint500_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
            
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_indadocno_t = g_inda_m.indadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint500.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aint500_delete()
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
   
   IF g_inda_m.indadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aint500_cl USING g_enterprise,g_inda_m.indadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint500_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint500_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint500_master_referesh USING g_inda_m.indadocno INTO g_inda_m.indasite,g_inda_m.indadocdt, 
       g_inda_m.indadocno,g_inda_m.inda001,g_inda_m.indaunit,g_inda_m.inda003,g_inda_m.inda004,g_inda_m.inda005, 
       g_inda_m.inda101,g_inda_m.inda002,g_inda_m.inda006,g_inda_m.indastus,g_inda_m.indaownid,g_inda_m.indaowndp, 
       g_inda_m.indacrtid,g_inda_m.indacrtdp,g_inda_m.indacrtdt,g_inda_m.indamodid,g_inda_m.indamoddt, 
       g_inda_m.indacnfid,g_inda_m.indacnfdt,g_inda_m.indasite_desc,g_inda_m.inda001_desc,g_inda_m.inda003_desc, 
       g_inda_m.inda004_desc,g_inda_m.inda101_desc,g_inda_m.inda002_desc,g_inda_m.indaownid_desc,g_inda_m.indaowndp_desc, 
       g_inda_m.indacrtid_desc,g_inda_m.indacrtdp_desc,g_inda_m.indamodid_desc,g_inda_m.indacnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT aint500_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_inda_m_mask_o.* =  g_inda_m.*
   CALL aint500_inda_t_mask()
   LET g_inda_m_mask_n.* =  g_inda_m.*
   
   CALL aint500_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
                        
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aint500_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_indadocno_t = g_inda_m.indadocno
 
 
      DELETE FROM inda_t
       WHERE indaent = g_enterprise AND indadocno = g_inda_m.indadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
                        
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_inda_m.indadocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM indb_t
       WHERE indbent = g_enterprise AND indbdocno = g_inda_m.indadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
                        
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "indb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
                        
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_inda_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aint500_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_indb_d.clear() 
 
     
      CALL aint500_ui_browser_refresh()  
      #CALL aint500_ui_headershow()  
      #CALL aint500_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aint500_browser_fill("")
         CALL aint500_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aint500_cl
 
   #功能已完成,通報訊息中心
   CALL aint500_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aint500.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aint500_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
            
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_indb_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
            
   #end add-point
   
   #判斷是否填充
   IF aint500_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT indbsite,indbunit,indbseq,indb002,indb001,indb003,indb004,indb005, 
             indb006,indb007,indb008,indb009,indb010,indb011,indb012,indb013 ,t1.imaal003 ,t2.imaal004 , 
             t3.oocal003 ,t4.oocal003 FROM indb_t",   
                     " INNER JOIN inda_t ON indaent = " ||g_enterprise|| " AND indadocno = indbdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=indb001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=indb001 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=indb004 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=indb005 AND t4.oocal002='"||g_dlang||"' ",
 
                     " WHERE indbent=? AND indbdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
                        
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY indb_t.indbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
                        
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint500_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aint500_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_inda_m.indadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_inda_m.indadocno INTO g_indb_d[l_ac].indbsite,g_indb_d[l_ac].indbunit, 
          g_indb_d[l_ac].indbseq,g_indb_d[l_ac].indb002,g_indb_d[l_ac].indb001,g_indb_d[l_ac].indb003, 
          g_indb_d[l_ac].indb004,g_indb_d[l_ac].indb005,g_indb_d[l_ac].indb006,g_indb_d[l_ac].indb007, 
          g_indb_d[l_ac].indb008,g_indb_d[l_ac].indb009,g_indb_d[l_ac].indb010,g_indb_d[l_ac].indb011, 
          g_indb_d[l_ac].indb012,g_indb_d[l_ac].indb013,g_indb_d[l_ac].indb001_desc,g_indb_d[l_ac].indb001_desc_desc, 
          g_indb_d[l_ac].indb004_desc,g_indb_d[l_ac].indb005_desc   #(ver:78)
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
   
   CALL g_indb_d.deleteElement(g_indb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aint500_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_indb_d.getLength()
      LET g_indb_d_mask_o[l_ac].* =  g_indb_d[l_ac].*
      CALL aint500_indb_t_mask()
      LET g_indb_d_mask_n[l_ac].* =  g_indb_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aint500.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aint500_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM indb_t
       WHERE indbent = g_enterprise AND
         indbdocno = ps_keys_bak[1] AND indbseq = ps_keys_bak[2]
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
         CALL g_indb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
            
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint500.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aint500_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO indb_t
                  (indbent,
                   indbdocno,
                   indbseq
                   ,indbsite,indbunit,indb002,indb001,indb003,indb004,indb005,indb006,indb007,indb008,indb009,indb010,indb011,indb012,indb013) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_indb_d[g_detail_idx].indbsite,g_indb_d[g_detail_idx].indbunit,g_indb_d[g_detail_idx].indb002, 
                       g_indb_d[g_detail_idx].indb001,g_indb_d[g_detail_idx].indb003,g_indb_d[g_detail_idx].indb004, 
                       g_indb_d[g_detail_idx].indb005,g_indb_d[g_detail_idx].indb006,g_indb_d[g_detail_idx].indb007, 
                       g_indb_d[g_detail_idx].indb008,g_indb_d[g_detail_idx].indb009,g_indb_d[g_detail_idx].indb010, 
                       g_indb_d[g_detail_idx].indb011,g_indb_d[g_detail_idx].indb012,g_indb_d[g_detail_idx].indb013) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
                        
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "indb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_indb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
                        
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
            
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aint500.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aint500_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "indb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
                        
      #end add-point 
      
      #將遮罩欄位還原
      CALL aint500_indb_t_mask_restore('restore_mask_o')
               
      UPDATE indb_t 
         SET (indbdocno,
              indbseq
              ,indbsite,indbunit,indb002,indb001,indb003,indb004,indb005,indb006,indb007,indb008,indb009,indb010,indb011,indb012,indb013) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_indb_d[g_detail_idx].indbsite,g_indb_d[g_detail_idx].indbunit,g_indb_d[g_detail_idx].indb002, 
                  g_indb_d[g_detail_idx].indb001,g_indb_d[g_detail_idx].indb003,g_indb_d[g_detail_idx].indb004, 
                  g_indb_d[g_detail_idx].indb005,g_indb_d[g_detail_idx].indb006,g_indb_d[g_detail_idx].indb007, 
                  g_indb_d[g_detail_idx].indb008,g_indb_d[g_detail_idx].indb009,g_indb_d[g_detail_idx].indb010, 
                  g_indb_d[g_detail_idx].indb011,g_indb_d[g_detail_idx].indb012,g_indb_d[g_detail_idx].indb013)  
 
         WHERE indbent = g_enterprise AND indbdocno = ps_keys_bak[1] AND indbseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
                        
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "indb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "indb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aint500_indb_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aint500.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aint500_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aint500.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aint500_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aint500.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aint500_lock_b(ps_table,ps_page)
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
   #CALL aint500_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "indb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aint500_bcl USING g_enterprise,
                                       g_inda_m.indadocno,g_indb_d[g_detail_idx].indbseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint500_bcl:",SQLERRMESSAGE 
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
 
{<section id="aint500.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aint500_unlock_b(ps_table,ps_page)
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
      CLOSE aint500_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
            
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aint500.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aint500_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
            
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("indadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("indadocno",TRUE)
      CALL cl_set_comp_entry("indadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
                        
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("indadocdt,inda001,inda003,inda004,inda005,inda006",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint500.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aint500_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
            
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("indadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("indadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("indadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT s_aooi500_comp_entry(g_prog,'indasite') OR g_site_flag THEN
      CALL cl_set_comp_entry("indasite",FALSE)
   END IF
   IF g_inda_m.inda002 = g_site AND g_inda_m.indastus = 'Y' THEN
      CALL cl_set_comp_entry("inda001,inda003,inda004,inda005,inda006",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint500.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aint500_set_entry_b(p_cmd)
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
      CALL cl_set_comp_entry("indbseq",TRUE)
   CALL cl_set_comp_entry("indb001",TRUE)
   CALL cl_set_comp_entry("indb002",TRUE)
   CALL cl_set_comp_entry("indb003",TRUE)
   CALL cl_set_comp_entry("indb005",TRUE)
   CALL cl_set_comp_entry("indb007",TRUE)
   CALL cl_set_comp_entry("indb008",TRUE)
   CALL cl_set_comp_entry("indb009",TRUE)
   CALL cl_set_comp_entry("indb010",TRUE)
   CALL cl_set_comp_entry("indb013",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aint500.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aint500_set_no_entry_b(p_cmd)
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
      IF g_site != g_inda_m.indasite OR g_inda_m.indastus <> 'N' THEN
      CALL cl_set_comp_entry("indbseq",FALSE)
      CALL cl_set_comp_entry("indb001",FALSE)
      CALL cl_set_comp_entry("indb002",FALSE)
      CALL cl_set_comp_entry("indb003",FALSE)
      CALL cl_set_comp_entry("indb005",FALSE)
      CALL cl_set_comp_entry("indb007",FALSE)
      CALL cl_set_comp_entry("indb008",FALSE)
      CALL cl_set_comp_entry("indb013",FALSE)
   END IF
   IF g_site != g_inda_m.inda002 OR g_inda_m.indastus <> 'Y' THEN
      CALL cl_set_comp_entry("indb009",FALSE)
      CALL cl_set_comp_entry("indb010",FALSE)
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aint500.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aint500_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint500.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aint500_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_inda_m.indastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF

   IF g_inda_m.indasite = g_site AND g_inda_m.indastus = 'N' THEN
      CALL cl_set_act_visible('modify,delete,modify_detail',TRUE)
   ELSE
      CALL cl_set_act_visible('modify,delete,modify_detail',FALSE)
   END IF
   IF g_inda_m.inda002 = g_site AND g_inda_m.indastus = 'Y' THEN
      CALL cl_set_act_visible('modify,modify_detail',TRUE)
   END IF

   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint500.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aint500_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint500.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aint500_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint500.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aint500_default_search()
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
      LET ls_wc = ls_wc, " indadocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "inda_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "indb_t" 
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
 
{<section id="aint500.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aint500_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_errno     LIKE type_t.chr10
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_inda_m.indastus = 'C' OR g_inda_m.indastus = 'T' THEN
      RETURN
   END IF
   IF g_inda_m.indasite <> g_site AND g_inda_m.inda002 <> g_site THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_inda_m.indadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aint500_cl USING g_enterprise,g_inda_m.indadocno
   IF STATUS THEN
      CLOSE aint500_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint500_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aint500_master_referesh USING g_inda_m.indadocno INTO g_inda_m.indasite,g_inda_m.indadocdt, 
       g_inda_m.indadocno,g_inda_m.inda001,g_inda_m.indaunit,g_inda_m.inda003,g_inda_m.inda004,g_inda_m.inda005, 
       g_inda_m.inda101,g_inda_m.inda002,g_inda_m.inda006,g_inda_m.indastus,g_inda_m.indaownid,g_inda_m.indaowndp, 
       g_inda_m.indacrtid,g_inda_m.indacrtdp,g_inda_m.indacrtdt,g_inda_m.indamodid,g_inda_m.indamoddt, 
       g_inda_m.indacnfid,g_inda_m.indacnfdt,g_inda_m.indasite_desc,g_inda_m.inda001_desc,g_inda_m.inda003_desc, 
       g_inda_m.inda004_desc,g_inda_m.inda101_desc,g_inda_m.inda002_desc,g_inda_m.indaownid_desc,g_inda_m.indaowndp_desc, 
       g_inda_m.indacrtid_desc,g_inda_m.indacrtdp_desc,g_inda_m.indamodid_desc,g_inda_m.indacnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT aint500_action_chk() THEN
      CLOSE aint500_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_inda_m.indasite,g_inda_m.indasite_desc,g_inda_m.indadocdt,g_inda_m.indadocno,g_inda_m.inda001, 
       g_inda_m.inda001_desc,g_inda_m.indaunit,g_inda_m.inda003,g_inda_m.inda003_desc,g_inda_m.inda004, 
       g_inda_m.inda004_desc,g_inda_m.inda005,g_inda_m.inda101,g_inda_m.inda101_desc,g_inda_m.inda002, 
       g_inda_m.inda002_desc,g_inda_m.inda006,g_inda_m.indastus,g_inda_m.indaownid,g_inda_m.indaownid_desc, 
       g_inda_m.indaowndp,g_inda_m.indaowndp_desc,g_inda_m.indacrtid,g_inda_m.indacrtid_desc,g_inda_m.indacrtdp, 
       g_inda_m.indacrtdp_desc,g_inda_m.indacrtdt,g_inda_m.indamodid,g_inda_m.indamodid_desc,g_inda_m.indamoddt, 
       g_inda_m.indacnfid,g_inda_m.indacnfid_desc,g_inda_m.indacnfdt
 
   CASE g_inda_m.indastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "C"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "T"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/org_approved.png")
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
         CASE g_inda_m.indastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "C"
               HIDE OPTION "closed"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "T"
               HIDE OPTION "org_approved"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
#         IF g_inda_m.indasite != g_site THEN
#            CALL cl_set_act_visible('confirmed,unconfirmed,invalid',FALSE)
#         ELSE
#            CALL cl_set_act_visible('confirmed,unconfirmed,invalid',TRUE)
#         END IF
      IF g_inda_m.inda002 = g_site THEN
         CALL cl_set_act_visible('org_approved',TRUE)
      ELSE
         CALL cl_set_act_visible('org_approved',FALSE)
      END IF
      CALL cl_set_act_visible("signing,withdraw",FALSE) 
      CASE g_inda_m.indastus
         WHEN 'N'
            CALL cl_set_act_visible("closed,unconfirmed,org_approved",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,org_approved",FALSE)
            
         WHEN 'Y'
            CALL cl_set_act_visible("closed,confirmed,invalid",FALSE)
            
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,org_approved",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,org_approved",FALSE) 
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed,org_approved",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,org_approved",FALSE)
            
      END CASE
        
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aint500_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint500_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aint500_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint500_cl
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
      ON ACTION closed
         IF cl_auth_chk_act("closed") THEN
            LET lc_state = "C"
            #add-point:action控制 name="statechange.closed"
                                    
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
      ON ACTION org_approved
         IF cl_auth_chk_act("org_approved") THEN
            LET lc_state = "T"
            #add-point:action控制 name="statechange.org_approved"
            
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
      AND lc_state <> "C"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "T"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_inda_m.indastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aint500_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   IF lc_state = 'Y' AND g_inda_m.indastus = 'N' THEN
      CALL s_aint500_conf_chk(g_inda_m.indadocno,g_inda_m.indastus) RETURNING l_success,l_errno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = l_errno
         LET g_errparam.extend = g_inda_m.indadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN 
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_aint500_conf_upd(g_inda_m.indadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               IF g_inda_m.inda002 = g_inda_m.inda003 THEN
                  LET lc_state = 'T'
               END IF
            END IF
         END IF
      END IF
   END IF
   IF lc_state = 'N' AND g_inda_m.indastus = 'Y' THEN
      CALL s_aint500_unconf_chk(g_inda_m.indadocno,g_inda_m.indastus) RETURNING l_success,l_errno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = l_errno
         LET g_errparam.extend = g_inda_m.indadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN 
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_aint500_unconf_upd(g_inda_m.indadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
      END IF
   END IF
   IF lc_state = 'X' AND g_inda_m.indastus = 'N' THEN
      CALL s_aint500_void_chk(g_inda_m.indadocno,g_inda_m.indastus) RETURNING l_success,l_errno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = l_errno
         LET g_errparam.extend = g_inda_m.indadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN 
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_aint500_void_upd(g_inda_m.indadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
      END IF
   END IF
   IF lc_state = 'T' AND g_inda_m.indastus = 'Y' THEN
      CALL s_aint500_approve_chk(g_inda_m.indadocno,g_inda_m.indastus) RETURNING l_success,l_errno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = l_errno
         LET g_errparam.extend = g_inda_m.indadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('ain-00182') THEN 
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_aint500_approve_upd(g_inda_m.indadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_inda_m.indamodid = g_user
   LET g_inda_m.indamoddt = cl_get_current()
   LET g_inda_m.indastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE inda_t 
      SET (indastus,indamodid,indamoddt) 
        = (g_inda_m.indastus,g_inda_m.indamodid,g_inda_m.indamoddt)     
    WHERE indaent = g_enterprise AND indadocno = g_inda_m.indadocno
 
    
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
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "T"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/org_approved.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE aint500_master_referesh USING g_inda_m.indadocno INTO g_inda_m.indasite,g_inda_m.indadocdt, 
          g_inda_m.indadocno,g_inda_m.inda001,g_inda_m.indaunit,g_inda_m.inda003,g_inda_m.inda004,g_inda_m.inda005, 
          g_inda_m.inda101,g_inda_m.inda002,g_inda_m.inda006,g_inda_m.indastus,g_inda_m.indaownid,g_inda_m.indaowndp, 
          g_inda_m.indacrtid,g_inda_m.indacrtdp,g_inda_m.indacrtdt,g_inda_m.indamodid,g_inda_m.indamoddt, 
          g_inda_m.indacnfid,g_inda_m.indacnfdt,g_inda_m.indasite_desc,g_inda_m.inda001_desc,g_inda_m.inda003_desc, 
          g_inda_m.inda004_desc,g_inda_m.inda101_desc,g_inda_m.inda002_desc,g_inda_m.indaownid_desc, 
          g_inda_m.indaowndp_desc,g_inda_m.indacrtid_desc,g_inda_m.indacrtdp_desc,g_inda_m.indamodid_desc, 
          g_inda_m.indacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_inda_m.indasite,g_inda_m.indasite_desc,g_inda_m.indadocdt,g_inda_m.indadocno, 
          g_inda_m.inda001,g_inda_m.inda001_desc,g_inda_m.indaunit,g_inda_m.inda003,g_inda_m.inda003_desc, 
          g_inda_m.inda004,g_inda_m.inda004_desc,g_inda_m.inda005,g_inda_m.inda101,g_inda_m.inda101_desc, 
          g_inda_m.inda002,g_inda_m.inda002_desc,g_inda_m.inda006,g_inda_m.indastus,g_inda_m.indaownid, 
          g_inda_m.indaownid_desc,g_inda_m.indaowndp,g_inda_m.indaowndp_desc,g_inda_m.indacrtid,g_inda_m.indacrtid_desc, 
          g_inda_m.indacrtdp,g_inda_m.indacrtdp_desc,g_inda_m.indacrtdt,g_inda_m.indamodid,g_inda_m.indamodid_desc, 
          g_inda_m.indamoddt,g_inda_m.indacnfid,g_inda_m.indacnfid_desc,g_inda_m.indacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
   ELSE      
      CALL s_transaction_end('Y','0')
   END IF
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
            
   #end add-point  
 
   CLOSE aint500_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint500_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint500.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aint500_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
            
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_indb_d.getLength() THEN
         LET g_detail_idx = g_indb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_indb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_indb_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
            
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aint500.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aint500_b_fill2(pi_idx)
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
   
   CALL aint500_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aint500.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aint500_fill_chk(ps_idx)
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
 
{<section id="aint500.status_show" >}
PRIVATE FUNCTION aint500_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aint500.mask_functions" >}
&include "erp/ain/aint500_mask.4gl"
 
{</section>}
 
{<section id="aint500.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aint500_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aint500_show()
   CALL aint500_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_inda_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_indb_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   CALL s_aint500_conf_chk(g_inda_m.indadocno,g_inda_m.indastus) RETURNING g_success,g_errno
   IF NOT g_success THEN
      RETURN FALSE
   END IF
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL aint500_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aint500_ui_headershow()
   CALL aint500_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aint500_draw_out()
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
   CALL aint500_ui_headershow()  
   CALL aint500_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aint500.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aint500_set_pk_array()
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
   LET g_pk_array[1].values = g_inda_m.indadocno
   LET g_pk_array[1].column = 'indadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint500.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aint500.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aint500_msgcentre_notify(lc_state)
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
   CALL aint500_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_inda_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint500.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aint500_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#17 -s by 08172
   SELECT indastus  INTO g_inda_m.indastus
     FROM inda_t
    WHERE indaent = g_enterprise
      AND indadocno = g_inda_m.indadocno
   LET g_errno = ''
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_inda_m.indastus
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
        WHEN 'T'
           LET g_errno = 'sub-01353'
        WHEN 'C'
           LET g_errno = 'ain-00197'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_inda_m.indadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aint500_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#17 -e by 08172
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint500.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION aint500_inda001_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inda_m.inda001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_inda_m.inda001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inda_m.inda001_desc
END FUNCTION
#+
PRIVATE FUNCTION aint500_inda003_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inda_m.inda003
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inda_m.inda003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inda_m.inda003_desc
END FUNCTION
#+
PRIVATE FUNCTION aint500_inda004_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inda_m.inda004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inda_m.inda004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inda_m.inda004_desc
END FUNCTION
#+
PRIVATE FUNCTION aint500_inda002_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inda_m.inda002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inda_m.inda002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inda_m.inda002_desc
END FUNCTION
#+
PRIVATE FUNCTION aint500_indb001_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_indb_d[l_ac].indb001
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_indb_d[l_ac].indb001_desc = '', g_rtn_fields[1] , ''
   LET g_indb_d[l_ac].indb001_desc_desc = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_indb_d[l_ac].indb001_desc
   DISPLAY BY NAME g_indb_d[l_ac].indb001_desc_desc
END FUNCTION
#+
PRIVATE FUNCTION aint500_indasite_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inda_m.indasite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inda_m.indasite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inda_m.indasite_desc
END FUNCTION
#+
PRIVATE FUNCTION aint500_inda002_init()
   IF cl_null(g_inda_m.inda003) THEN
      LET g_inda_m.inda002 = ''
   ELSE
      SELECT ooed005 INTO g_inda_m.inda002
        FROM ooed_t
       WHERE ooedent = g_enterprise AND ooed001 = '8' 
         AND ooed006 <= g_today AND (ooed007 >= g_today OR ooed007 IS NULL)
         AND ooed004 = g_inda_m.inda003
   END IF
   DISPLAY BY NAME g_inda_m.inda002
END FUNCTION
#+
PRIVATE FUNCTION aint500_indbseq_init()
   SELECT MAX(indbseq) + 1 INTO g_indb_d[l_ac].indbseq
     FROM indb_t
    WHERE indbent = g_enterprise AND indbdocno = g_inda_m.indadocno
   
   IF cl_null(g_indb_d[l_ac].indbseq) THEN
      LET g_indb_d[l_ac].indbseq = 1
   END IF
END FUNCTION
#+
PRIVATE FUNCTION aint500_indb002_init()
   IF cl_null(g_indb_d[l_ac].indb002) THEN
      INITIALIZE g_indb_d[l_ac].indb001,g_indb_d[l_ac].indb004,g_indb_d[l_ac].indb005,g_indb_d[l_ac].indb006 TO NULL
      RETURN
   END IF
   
   INITIALIZE g_indb_d[l_ac].indb001,g_indb_d[l_ac].indb004,g_indb_d[l_ac].indb005,g_indb_d[l_ac].indb006 TO NULL
   
   SELECT imay001,imay014,imay004,imay005 
     INTO g_indb_d[l_ac].indb001,g_indb_d[l_ac].indb004,g_indb_d[l_ac].indb005,g_indb_d[l_ac].indb006
     FROM imay_t
    WHERE imayent = g_enterprise AND imay003 = g_indb_d[l_ac].indb002 AND imaystus = 'Y'
    
   DISPLAY BY NAME g_indb_d[l_ac].indb001,
                   g_indb_d[l_ac].indb004,
                   g_indb_d[l_ac].indb005,
                   g_indb_d[l_ac].indb006
                   
   CALL aint500_indb001_ref()
   CALL aint500_indb004_ref()
   CALL aint500_indb005_ref()
END FUNCTION
#+
PRIVATE FUNCTION aint500_indb001_init()
   IF cl_null(g_indb_d[l_ac].indb001) THEN
      INITIALIZE g_indb_d[l_ac].indb002,g_indb_d[l_ac].indb004,g_indb_d[l_ac].indb005,g_indb_d[l_ac].indb006 TO NULL
      RETURN
   END IF
   
   INITIALIZE g_indb_d[l_ac].indb004,g_indb_d[l_ac].indb005,g_indb_d[l_ac].indb006 TO NULL
   SELECT imaa104,imaa104,1 
     INTO g_indb_d[l_ac].indb004,g_indb_d[l_ac].indb005,g_indb_d[l_ac].indb006
     FROM imaa_t
    WHERE imaaent = g_enterprise AND imaa001 = g_indb_d[l_ac].indb001 AND imaastus = 'Y'
    
   CALL aint500_indb001_ref()
   CALL aint500_indb004_ref()
   CALL aint500_indb005_ref()
   
   INITIALIZE g_indb_d[l_ac].indb002 TO NULL
   SELECT imay003 INTO g_indb_d[l_ac].indb002
     FROM imay_t
    WHERE imayent = g_enterprise AND imay001 = g_indb_d[l_ac].indb001 AND imay006 = 'Y' AND imaystus = 'Y'
END FUNCTION
#+
PRIVATE FUNCTION aint500_indb007_init()
   IF cl_null(g_indb_d[l_ac].indb006) OR cl_null(g_indb_d[l_ac].indb007) THEN
      RETURN
   END IF
   
   LET g_indb_d[l_ac].indb008 = g_indb_d[l_ac].indb006 * g_indb_d[l_ac].indb007
   DISPLAY BY NAME g_indb_d[l_ac].indb008
END FUNCTION
#+
PRIVATE FUNCTION aint500_indb008_init()
DEFINE l_num   LIKE type_t.num5
   
   IF cl_null(g_indb_d[l_ac].indb006) OR cl_null(g_indb_d[l_ac].indb008) THEN
      RETURN
   END IF
   
   LET l_num = g_indb_d[l_ac].indb008/g_indb_d[l_ac].indb006
   LET g_indb_d[l_ac].indb007 = l_num
   DISPLAY BY NAME g_indb_d[l_ac].indb007
END FUNCTION
#+
PRIVATE FUNCTION aint500_indb009_init()
   IF cl_null(g_indb_d[l_ac].indb006) OR cl_null(g_indb_d[l_ac].indb009) THEN
      RETURN
   END IF
   
   LET g_indb_d[l_ac].indb010 = g_indb_d[l_ac].indb006 * g_indb_d[l_ac].indb009
   DISPLAY BY NAME g_indb_d[l_ac].indb010
END FUNCTION
#+
PRIVATE FUNCTION aint500_indb009_chk()
   INITIALIZE g_errno TO NULL
   
   IF cl_null(g_indb_d[l_ac].indb006) OR cl_null(g_indb_d[l_ac].indb009) THEN
      RETURN
   END IF
   
   IF g_indb_d[l_ac].indb006 * g_indb_d[l_ac].indb009 > g_indb_d[l_ac].indb008 THEN
      LET g_errno = 'agc-00088' #核准數量不可以大於申請數量，請重新輸入
   END IF
END FUNCTION
#+
PRIVATE FUNCTION aint500_indb010_init()
DEFINE l_num   LIKE type_t.num5
   
   IF cl_null(g_indb_d[l_ac].indb006) OR cl_null(g_indb_d[l_ac].indb010) THEN
      RETURN
   END IF
   
   LET l_num = g_indb_d[l_ac].indb010/g_indb_d[l_ac].indb006
   LET g_indb_d[l_ac].indb009 = l_num
   DISPLAY BY NAME g_indb_d[l_ac].indb009
END FUNCTION
#+
PRIVATE FUNCTION aint500_indb010_chk()
   
   INITIALIZE g_errno TO NULL
   
   IF cl_null(g_indb_d[l_ac].indb008) OR cl_null(g_indb_d[l_ac].indb010) THEN
      RETURN
   END IF
   
   IF g_indb_d[l_ac].indb010 > g_indb_d[l_ac].indb008 THEN
      LET g_errno = 'agc-00088' #核准數量不可以大於申請數量，請重新輸入
   END IF
END FUNCTION
#=
PRIVATE FUNCTION aint500_indb004_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_indb_d[l_ac].indb004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_indb_d[l_ac].indb004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_indb_d[l_ac].indb004_desc
END FUNCTION
#+
PRIVATE FUNCTION aint500_indb005_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_indb_d[l_ac].indb005
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_indb_d[l_ac].indb005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_indb_d[l_ac].indb005_desc
END FUNCTION
#+
PRIVATE FUNCTION aint500_indb001_chk()
DEFINE l_rtdxstus   LIKE rtdx_t.rtdxstus

   INITIALIZE g_errno TO NULL
   
   SELECT rtdxstus INTO l_rtdxstus
     FROM rtdx_t
    WHERE rtdxent = g_enterprise AND rtdx001 = g_indb_d[l_ac].indb001
      AND rtdxsite = g_inda_m.inda004
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'ain-00065' #錄入的資料不存在於撥入組織的門店商品清單中,請至artq400中查詢后重新錄入
      WHEN l_rtdxstus != 'Y'   LET g_errno = 'ain-00066' #錄入的資料在門店商品清單中已無效,請至artq400中查詢后重新錄入
   END CASE
END FUNCTION
#=
PRIVATE FUNCTION aint500_indb002_chk()
DEFINE l_rtdxstus   LIKE rtdx_t.rtdxstus

   INITIALIZE g_errno TO NULL
   
   SELECT rtdxstus INTO l_rtdxstus
     FROM rtdx_t
    WHERE rtdxent = g_enterprise AND rtdx001 = (SELECT imay001 
                                                  FROM imay_t 
                                                 WHERE imayent = g_enterprise 
                                                   AND imay003 = g_indb_d[l_ac].indb002)
      AND rtdxsite = g_inda_m.inda003
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'ain-00067' #錄入條碼對應的料號不存在於撥出組織的門店商品清單中
      WHEN l_rtdxstus != 'Y'   LET g_errno = 'ain-00068' #錄入條碼對應的料號在撥出組織的門店商品清單中已無效
   END CASE
   
   IF cl_null(g_errno) THEN
      SELECT rtdxstus INTO l_rtdxstus
        FROM rtdx_t
       WHERE rtdxent = g_enterprise AND rtdx001 = (SELECT imay001 
                                                     FROM imay_t 
                                                    WHERE imayent = g_enterprise 
                                                      AND imay003 = g_indb_d[l_ac].indb002)
         AND rtdxsite = g_inda_m.inda004
      CASE
         WHEN SQLCA.sqlcode = 100 LET g_errno = 'ain-00069' #錄入條碼對應的料號不存在於撥出組織的門店商品清單中
         WHEN l_rtdxstus != 'Y'   LET g_errno = 'ain-00070' #錄入條碼對應的料號在撥出組織的門店商品清單中已無效
      END CASE
   END IF
END FUNCTION

 
{</section>}
 