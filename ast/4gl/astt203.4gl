#該程式未解開Section, 採用最新樣板產出!
{<section id="astt203.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2016-06-22 14:48:12), PR版次:0014(2016-11-03 23:46:11)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000297
#+ Filename...: astt203
#+ Description: 費用編號異動申請作業
#+ Creator....: 01726(2013-10-23 17:35:09)
#+ Modifier...: 06189 -SD/PR- 06137
 
{</section>}
 
{<section id="astt203.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
# Modify......: NO.160510-00010#9    2016/05/11   By 07959    1.增加栏位：“费用归属类型”和“费用归属组织”，
# ............:                                                 新增时自动从asti203带出，可以修改
# ............:                                               2.栏位控管：“费用归属类型”=1-本营运组织时，不允许录入；“费用归属类型”=2-内部营运组织时，要求必须录入；“费用归属类型”：3-外部营运组织，不允许录入。
# Modify......: NO.160512-00003#2    2016/05/17   By 07959    1.纳入结算单否和票扣否默认都为Y，纳入结算单否为Y才可以修改票扣否，纳入结算单否未N时，票扣否未N，不可修改
# ............:                                               2.隐藏栏位价款类别
# ............:                                               3.新增字段费用用途类型scc，参考asti203，放在进出类型的后面，修改费用的时候，默认从asti203带出，审核后更新到asti203
#+ Modifier...: No.#160510-00010#11  2016/05/20   By 07959    费用归属类型是3.外部营运组织 时，开放费用归属组织可以维护，选apmm801的交易对象（有效的）
#  Modify.....: NO.160816-00068#17   2016/08/19   By 08209    調整transaction
#161024-00025#2 2016/10/25 By dongsz   stad013增加aooi500判断管控
# Modify......: NO.160824-00007#175  2016/11/03   By 06137    修正舊值備份寫法
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
PRIVATE type type_g_stac_m        RECORD
       stacsite LIKE stac_t.stacsite, 
   stacsite_desc LIKE type_t.chr80, 
   stacdocdt LIKE stac_t.stacdocdt, 
   stacdocno LIKE stac_t.stacdocno, 
   stacunit LIKE stac_t.stacunit, 
   stac000 LIKE stac_t.stac000, 
   stac001 LIKE stac_t.stac001, 
   stac001_desc LIKE type_t.chr80, 
   stac002 LIKE stac_t.stac002, 
   stac002_desc LIKE type_t.chr80, 
   stacstus LIKE stac_t.stacstus, 
   stacownid LIKE stac_t.stacownid, 
   stacownid_desc LIKE type_t.chr80, 
   stacowndp LIKE stac_t.stacowndp, 
   stacowndp_desc LIKE type_t.chr80, 
   staccrtid LIKE stac_t.staccrtid, 
   staccrtid_desc LIKE type_t.chr80, 
   staccrtdp LIKE stac_t.staccrtdp, 
   staccrtdp_desc LIKE type_t.chr80, 
   staccrtdt LIKE stac_t.staccrtdt, 
   stacmodid LIKE stac_t.stacmodid, 
   stacmodid_desc LIKE type_t.chr80, 
   stacmoddt LIKE stac_t.stacmoddt, 
   staccnfid LIKE stac_t.staccnfid, 
   staccnfid_desc LIKE type_t.chr80, 
   staccnfdt LIKE stac_t.staccnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_stad_d        RECORD
       stadseq LIKE stad_t.stadseq, 
   stad001 LIKE stad_t.stad001, 
   stadl002 LIKE stadl_t.stadl002, 
   stadl003 LIKE stadl_t.stadl003, 
   stad002 LIKE stad_t.stad002, 
   stad014 LIKE stad_t.stad014, 
   stad003 LIKE stad_t.stad003, 
   stad003_desc LIKE type_t.chr500, 
   stad004 LIKE stad_t.stad004, 
   stad005 LIKE stad_t.stad005, 
   stad006 LIKE stad_t.stad006, 
   stad011 LIKE stad_t.stad011, 
   stad007 LIKE stad_t.stad007, 
   stad008 LIKE stad_t.stad008, 
   stad008_desc LIKE type_t.chr500, 
   stad009 LIKE stad_t.stad009, 
   stad010 LIKE stad_t.stad010, 
   stad010_desc LIKE type_t.chr500, 
   stadacti LIKE stad_t.stadacti, 
   stad012 LIKE stad_t.stad012, 
   stad013 LIKE stad_t.stad013, 
   stad013_desc LIKE type_t.chr500, 
   stad015 LIKE stad_t.stad015, 
   stad016 LIKE stad_t.stad016
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_stacsite LIKE stac_t.stacsite,
   b_stacsite_desc LIKE type_t.chr80,
      b_stacdocno LIKE stac_t.stacdocno,
      b_stacdocdt LIKE stac_t.stacdocdt,
      b_stac000 LIKE stac_t.stac000,
      b_stac001 LIKE stac_t.stac001,
   b_stac001_desc LIKE type_t.chr80,
      b_stac002 LIKE stac_t.stac002,
   b_stac002_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_flag           LIKE type_t.num5 #ken---add 需求單號：141208-00001 項次：17
#end add-point
       
#模組變數(Module Variables)
DEFINE g_stac_m          type_g_stac_m
DEFINE g_stac_m_t        type_g_stac_m
DEFINE g_stac_m_o        type_g_stac_m
DEFINE g_stac_m_mask_o   type_g_stac_m #轉換遮罩前資料
DEFINE g_stac_m_mask_n   type_g_stac_m #轉換遮罩後資料
 
   DEFINE g_stacdocno_t LIKE stac_t.stacdocno
 
 
DEFINE g_stad_d          DYNAMIC ARRAY OF type_g_stad_d
DEFINE g_stad_d_t        type_g_stad_d
DEFINE g_stad_d_o        type_g_stad_d
DEFINE g_stad_d_mask_o   DYNAMIC ARRAY OF type_g_stad_d #轉換遮罩前資料
DEFINE g_stad_d_mask_n   DYNAMIC ARRAY OF type_g_stad_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_detail_multi_table_t    RECORD
      stadldocno LIKE stadl_t.stadldocno,
      stadlseq LIKE stadl_t.stadlseq,
      stadl001 LIKE stadl_t.stadl001,
      stadl002 LIKE stadl_t.stadl002,
      stadl003 LIKE stadl_t.stadl003
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
 
{<section id="astt203.main" >}
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
   CALL cl_ap_init("ast","")
 
   #add-point:作業初始化 name="main.init"
   #150424-00018#1 150528 add by beckxie---S
   IF cl_get_para(g_enterprise,g_site,'E-CIR-0002')='N' THEN
      
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00295'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      CALL cl_ap_exitprogram("0")
   END IF
   #150424-00018#1 150528 add by beckxie---E
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT stacsite,'',stacdocdt,stacdocno,stacunit,stac000,stac001,'',stac002,'', 
       stacstus,stacownid,'',stacowndp,'',staccrtid,'',staccrtdp,'',staccrtdt,stacmodid,'',stacmoddt, 
       staccnfid,'',staccnfdt", 
                      " FROM stac_t",
                      " WHERE stacent= ? AND stacdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astt203_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.stacsite,t0.stacdocdt,t0.stacdocno,t0.stacunit,t0.stac000,t0.stac001, 
       t0.stac002,t0.stacstus,t0.stacownid,t0.stacowndp,t0.staccrtid,t0.staccrtdp,t0.staccrtdt,t0.stacmodid, 
       t0.stacmoddt,t0.staccnfid,t0.staccnfdt,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 , 
       t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011",
               " FROM stac_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.stacsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.stac001  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.stac002 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.stacownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.stacowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.staccrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.staccrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.stacmodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.staccnfid  ",
 
               " WHERE t0.stacent = " ||g_enterprise|| " AND t0.stacdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE astt203_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astt203 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL astt203_init()   
 
      #進入選單 Menu (="N")
      CALL astt203_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_astt203
      
   END IF 
   
   CLOSE astt203_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#5  By benson 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="astt203.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION astt203_init()
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
      CALL cl_set_combo_scc_part('stacstus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('stac000','32') 
   CALL cl_set_combo_scc('stad002','6003') 
   CALL cl_set_combo_scc('stad014','6820') 
   CALL cl_set_combo_scc('stad004','6004') 
   CALL cl_set_combo_scc('stad005','6005') 
   CALL cl_set_combo_scc('stad006','6006') 
   CALL cl_set_combo_scc('stad012','6932') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_stac000','2009') 
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#5  By benson 150309
   CALL cl_set_combo_scc_part('stad004','6004','1,2,3')  #add by geza 20150602 #160604-00009#43
   #end add-point
   
   #初始化搜尋條件
   CALL astt203_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="astt203.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION astt203_ui_dialog()
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
            CALL astt203_insert()
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
         INITIALIZE g_stac_m.* TO NULL
         CALL g_stad_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL astt203_init()
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
               
               CALL astt203_fetch('') # reload data
               LET l_ac = 1
               CALL astt203_ui_detailshow() #Setting the current row 
         
               CALL astt203_idx_chk()
               #NEXT FIELD stadseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_stad_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL astt203_idx_chk()
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
               CALL astt203_idx_chk()
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
            CALL astt203_browser_fill("")
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
               CALL astt203_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL astt203_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL astt203_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL astt203_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL astt203_set_act_visible()   
            CALL astt203_set_act_no_visible()
            IF NOT (g_stac_m.stacdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " stacent = " ||g_enterprise|| " AND",
                                  " stacdocno = '", g_stac_m.stacdocno, "' "
 
               #填到對應位置
               CALL astt203_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "stac_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "stad_t" 
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
               CALL astt203_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "stac_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "stad_t" 
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
                  CALL astt203_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL astt203_fetch("F")
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
               CALL astt203_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL astt203_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt203_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL astt203_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt203_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL astt203_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt203_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL astt203_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt203_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL astt203_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt203_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_stad_d)
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
               NEXT FIELD stadseq
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
               CALL astt203_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL astt203_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL astt203_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL astt203_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/ast/astt203_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/ast/astt203_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL astt203_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL astt203_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL astt203_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL astt203_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_stac_m.stacdocdt)
 
 
 
         
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
 
{<section id="astt203.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION astt203_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING #ken---add 需求單號：141208-00001 項次：17
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   CALL s_aooi500_sql_where(g_prog,'stacsite') RETURNING l_where #ken---add 需求單號：141208-00001 項次：17
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
      LET l_sub_sql = " SELECT DISTINCT stacdocno ",
                      " FROM stac_t ",
                      " ",
                      " LEFT JOIN stad_t ON stadent = stacent AND stacdocno = staddocno ", "  ",
                      #add-point:browser_fill段sql(stad_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " LEFT JOIN stadl_t ON stadlent = "||g_enterprise||" AND stacdocno = stadldocno AND stadseq = stadlseq AND stadl001 = '",g_dlang,"' ", 
 
 
                      " WHERE stacent = " ||g_enterprise|| " AND stadent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("stac_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT stacdocno ",
                      " FROM stac_t ", 
                      "  ",
                      "  ",
                      " WHERE stacent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("stac_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   LET l_sub_sql = l_sub_sql," AND ", l_where #ken---add 需求單號：141208-00001 項次：17
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
      INITIALIZE g_stac_m.* TO NULL
      CALL g_stad_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.stacsite,t0.stacdocno,t0.stacdocdt,t0.stac000,t0.stac001,t0.stac002 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.stacstus,t0.stacsite,t0.stacdocno,t0.stacdocdt,t0.stac000,t0.stac001, 
          t0.stac002,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM stac_t t0",
                  "  ",
                  "  LEFT JOIN stad_t ON stadent = stacent AND stacdocno = staddocno ", "  ", 
                  #add-point:browser_fill段sql(stad_t1) name="browser_fill.join.stad_t1"
                  
                  #end add-point
 
 
                  " LEFT JOIN stadl_t ON stadlent = "||g_enterprise||" AND stacdocno = stadldocno AND stadseq = stadlseq AND stadl001 = '",g_dlang,"' ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.stacsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.stac001  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.stac002 AND t3.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.stacent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("stac_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.stacstus,t0.stacsite,t0.stacdocno,t0.stacdocdt,t0.stac000,t0.stac001, 
          t0.stac002,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM stac_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.stacsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.stac001  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.stac002 AND t3.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.stacent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("stac_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   LET g_sql = g_sql," AND ", l_where #ken---add 需求單號：141208-00001 項次：17
   #end add-point
   LET g_sql = g_sql, " ORDER BY stacdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"stac_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_stacsite,g_browser[g_cnt].b_stacdocno, 
          g_browser[g_cnt].b_stacdocdt,g_browser[g_cnt].b_stac000,g_browser[g_cnt].b_stac001,g_browser[g_cnt].b_stac002, 
          g_browser[g_cnt].b_stacsite_desc,g_browser[g_cnt].b_stac001_desc,g_browser[g_cnt].b_stac002_desc 
 
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
         CALL astt203_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_stacdocno) THEN
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
 
{<section id="astt203.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION astt203_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_stac_m.stacdocno = g_browser[g_current_idx].b_stacdocno   
 
   EXECUTE astt203_master_referesh USING g_stac_m.stacdocno INTO g_stac_m.stacsite,g_stac_m.stacdocdt, 
       g_stac_m.stacdocno,g_stac_m.stacunit,g_stac_m.stac000,g_stac_m.stac001,g_stac_m.stac002,g_stac_m.stacstus, 
       g_stac_m.stacownid,g_stac_m.stacowndp,g_stac_m.staccrtid,g_stac_m.staccrtdp,g_stac_m.staccrtdt, 
       g_stac_m.stacmodid,g_stac_m.stacmoddt,g_stac_m.staccnfid,g_stac_m.staccnfdt,g_stac_m.stacsite_desc, 
       g_stac_m.stac001_desc,g_stac_m.stac002_desc,g_stac_m.stacownid_desc,g_stac_m.stacowndp_desc,g_stac_m.staccrtid_desc, 
       g_stac_m.staccrtdp_desc,g_stac_m.stacmodid_desc,g_stac_m.staccnfid_desc
   
   CALL astt203_stac_t_mask()
   CALL astt203_show()
      
END FUNCTION
 
{</section>}
 
{<section id="astt203.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION astt203_ui_detailshow()
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
 
{<section id="astt203.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION astt203_ui_browser_refresh()
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
      IF g_browser[l_i].b_stacdocno = g_stac_m.stacdocno 
 
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
 
{<section id="astt203.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION astt203_construct()
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
   INITIALIZE g_stac_m.* TO NULL
   CALL g_stad_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON stacsite,stacdocdt,stacdocno,stacunit,stac000,stac001,stac002,stacstus, 
          stacownid,stacowndp,staccrtid,staccrtdp,staccrtdt,stacmodid,stacmoddt,staccnfid,staccnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<staccrtdt>>----
         AFTER FIELD staccrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<stacmoddt>>----
         AFTER FIELD stacmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<staccnfdt>>----
         AFTER FIELD staccnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stacpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.stacsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stacsite
            #add-point:ON ACTION controlp INFIELD stacsite name="construct.c.stacsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            #ken---add---s 需求單號：141208-00001 項次：17
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stacsite',g_site,'c')   #150308-00001#5  By benson add 'c'
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stacsite  #顯示到畫面上
            NEXT FIELD stacsite                     #返回原欄位
            #ken---add---e 


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stacsite
            #add-point:BEFORE FIELD stacsite name="construct.b.stacsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stacsite
            
            #add-point:AFTER FIELD stacsite name="construct.a.stacsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stacdocdt
            #add-point:BEFORE FIELD stacdocdt name="construct.b.stacdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stacdocdt
            
            #add-point:AFTER FIELD stacdocdt name="construct.a.stacdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stacdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stacdocdt
            #add-point:ON ACTION controlp INFIELD stacdocdt name="construct.c.stacdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stacdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stacdocno
            #add-point:ON ACTION controlp INFIELD stacdocno name="construct.c.stacdocno"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_stacdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stacdocno  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO stacdocdt #單據日期 
               #DISPLAY g_qryparam.return3 TO stac000 #作業方式 

            NEXT FIELD stacdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stacdocno
            #add-point:BEFORE FIELD stacdocno name="construct.b.stacdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stacdocno
            
            #add-point:AFTER FIELD stacdocno name="construct.a.stacdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stacunit
            #add-point:BEFORE FIELD stacunit name="construct.b.stacunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stacunit
            
            #add-point:AFTER FIELD stacunit name="construct.a.stacunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stacunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stacunit
            #add-point:ON ACTION controlp INFIELD stacunit name="construct.c.stacunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stac000
            #add-point:BEFORE FIELD stac000 name="construct.b.stac000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stac000
            
            #add-point:AFTER FIELD stac000 name="construct.a.stac000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stac000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stac000
            #add-point:ON ACTION controlp INFIELD stac000 name="construct.c.stac000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stac001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stac001
            #add-point:ON ACTION controlp INFIELD stac001 name="construct.c.stac001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stac001  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 

            NEXT FIELD stac001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stac001
            #add-point:BEFORE FIELD stac001 name="construct.b.stac001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stac001
            
            #add-point:AFTER FIELD stac001 name="construct.a.stac001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stac002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stac002
            #add-point:ON ACTION controlp INFIELD stac002 name="construct.c.stac002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stac002  #顯示到畫面上

            NEXT FIELD stac002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stac002
            #add-point:BEFORE FIELD stac002 name="construct.b.stac002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stac002
            
            #add-point:AFTER FIELD stac002 name="construct.a.stac002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stacstus
            #add-point:BEFORE FIELD stacstus name="construct.b.stacstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stacstus
            
            #add-point:AFTER FIELD stacstus name="construct.a.stacstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stacstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stacstus
            #add-point:ON ACTION controlp INFIELD stacstus name="construct.c.stacstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stacownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stacownid
            #add-point:ON ACTION controlp INFIELD stacownid name="construct.c.stacownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stacownid  #顯示到畫面上

            NEXT FIELD stacownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stacownid
            #add-point:BEFORE FIELD stacownid name="construct.b.stacownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stacownid
            
            #add-point:AFTER FIELD stacownid name="construct.a.stacownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stacowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stacowndp
            #add-point:ON ACTION controlp INFIELD stacowndp name="construct.c.stacowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stacowndp  #顯示到畫面上

            NEXT FIELD stacowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stacowndp
            #add-point:BEFORE FIELD stacowndp name="construct.b.stacowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stacowndp
            
            #add-point:AFTER FIELD stacowndp name="construct.a.stacowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.staccrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD staccrtid
            #add-point:ON ACTION controlp INFIELD staccrtid name="construct.c.staccrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO staccrtid  #顯示到畫面上

            NEXT FIELD staccrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD staccrtid
            #add-point:BEFORE FIELD staccrtid name="construct.b.staccrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD staccrtid
            
            #add-point:AFTER FIELD staccrtid name="construct.a.staccrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.staccrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD staccrtdp
            #add-point:ON ACTION controlp INFIELD staccrtdp name="construct.c.staccrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO staccrtdp  #顯示到畫面上

            NEXT FIELD staccrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD staccrtdp
            #add-point:BEFORE FIELD staccrtdp name="construct.b.staccrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD staccrtdp
            
            #add-point:AFTER FIELD staccrtdp name="construct.a.staccrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD staccrtdt
            #add-point:BEFORE FIELD staccrtdt name="construct.b.staccrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stacmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stacmodid
            #add-point:ON ACTION controlp INFIELD stacmodid name="construct.c.stacmodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stacmodid  #顯示到畫面上

            NEXT FIELD stacmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stacmodid
            #add-point:BEFORE FIELD stacmodid name="construct.b.stacmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stacmodid
            
            #add-point:AFTER FIELD stacmodid name="construct.a.stacmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stacmoddt
            #add-point:BEFORE FIELD stacmoddt name="construct.b.stacmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.staccnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD staccnfid
            #add-point:ON ACTION controlp INFIELD staccnfid name="construct.c.staccnfid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO staccnfid  #顯示到畫面上

            NEXT FIELD staccnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD staccnfid
            #add-point:BEFORE FIELD staccnfid name="construct.b.staccnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD staccnfid
            
            #add-point:AFTER FIELD staccnfid name="construct.a.staccnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD staccnfdt
            #add-point:BEFORE FIELD staccnfdt name="construct.b.staccnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON stadseq,stad001,stadl002,stadl003,stad002,stad014,stad003,stad004,stad005, 
          stad006,stad011,stad007,stad008,stad009,stad010,stadacti,stad012,stad013,stad015,stad016
           FROM s_detail1[1].stadseq,s_detail1[1].stad001,s_detail1[1].stadl002,s_detail1[1].stadl003, 
               s_detail1[1].stad002,s_detail1[1].stad014,s_detail1[1].stad003,s_detail1[1].stad004,s_detail1[1].stad005, 
               s_detail1[1].stad006,s_detail1[1].stad011,s_detail1[1].stad007,s_detail1[1].stad008,s_detail1[1].stad009, 
               s_detail1[1].stad010,s_detail1[1].stadacti,s_detail1[1].stad012,s_detail1[1].stad013, 
               s_detail1[1].stad015,s_detail1[1].stad016
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stadseq
            #add-point:BEFORE FIELD stadseq name="construct.b.page1.stadseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stadseq
            
            #add-point:AFTER FIELD stadseq name="construct.a.page1.stadseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stadseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stadseq
            #add-point:ON ACTION controlp INFIELD stadseq name="construct.c.page1.stadseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stad001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad001
            #add-point:ON ACTION controlp INFIELD stad001 name="construct.c.page1.stad001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_stad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stad001  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO stadl002 #說明 
               #DISPLAY g_qryparam.return3 TO stadl003 #助記碼 

            NEXT FIELD stad001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad001
            #add-point:BEFORE FIELD stad001 name="construct.b.page1.stad001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad001
            
            #add-point:AFTER FIELD stad001 name="construct.a.page1.stad001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stadl002
            #add-point:BEFORE FIELD stadl002 name="construct.b.page1.stadl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stadl002
            
            #add-point:AFTER FIELD stadl002 name="construct.a.page1.stadl002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stadl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stadl002
            #add-point:ON ACTION controlp INFIELD stadl002 name="construct.c.page1.stadl002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stadl003
            #add-point:BEFORE FIELD stadl003 name="construct.b.page1.stadl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stadl003
            
            #add-point:AFTER FIELD stadl003 name="construct.a.page1.stadl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stadl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stadl003
            #add-point:ON ACTION controlp INFIELD stadl003 name="construct.c.page1.stadl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad002
            #add-point:BEFORE FIELD stad002 name="construct.b.page1.stad002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad002
            
            #add-point:AFTER FIELD stad002 name="construct.a.page1.stad002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stad002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad002
            #add-point:ON ACTION controlp INFIELD stad002 name="construct.c.page1.stad002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad014
            #add-point:BEFORE FIELD stad014 name="construct.b.page1.stad014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad014
            
            #add-point:AFTER FIELD stad014 name="construct.a.page1.stad014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stad014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad014
            #add-point:ON ACTION controlp INFIELD stad014 name="construct.c.page1.stad014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stad003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad003
            #add-point:ON ACTION controlp INFIELD stad003 name="construct.c.page1.stad003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stad003  #顯示到畫面上

            NEXT FIELD stad003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad003
            #add-point:BEFORE FIELD stad003 name="construct.b.page1.stad003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad003
            
            #add-point:AFTER FIELD stad003 name="construct.a.page1.stad003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad004
            #add-point:BEFORE FIELD stad004 name="construct.b.page1.stad004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad004
            
            #add-point:AFTER FIELD stad004 name="construct.a.page1.stad004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stad004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad004
            #add-point:ON ACTION controlp INFIELD stad004 name="construct.c.page1.stad004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad005
            #add-point:BEFORE FIELD stad005 name="construct.b.page1.stad005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad005
            
            #add-point:AFTER FIELD stad005 name="construct.a.page1.stad005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stad005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad005
            #add-point:ON ACTION controlp INFIELD stad005 name="construct.c.page1.stad005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad006
            #add-point:BEFORE FIELD stad006 name="construct.b.page1.stad006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad006
            
            #add-point:AFTER FIELD stad006 name="construct.a.page1.stad006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stad006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad006
            #add-point:ON ACTION controlp INFIELD stad006 name="construct.c.page1.stad006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad011
            #add-point:BEFORE FIELD stad011 name="construct.b.page1.stad011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad011
            
            #add-point:AFTER FIELD stad011 name="construct.a.page1.stad011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stad011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad011
            #add-point:ON ACTION controlp INFIELD stad011 name="construct.c.page1.stad011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad007
            #add-point:BEFORE FIELD stad007 name="construct.b.page1.stad007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad007
            
            #add-point:AFTER FIELD stad007 name="construct.a.page1.stad007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stad007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad007
            #add-point:ON ACTION controlp INFIELD stad007 name="construct.c.page1.stad007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stad008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad008
            #add-point:ON ACTION controlp INFIELD stad008 name="construct.c.page1.stad008"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_stad008()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stad008  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO stael003 #說明 
               #DISPLAY g_qryparam.return3 TO stae001 #費用編號 

            NEXT FIELD stad008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad008
            #add-point:BEFORE FIELD stad008 name="construct.b.page1.stad008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad008
            
            #add-point:AFTER FIELD stad008 name="construct.a.page1.stad008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad009
            #add-point:BEFORE FIELD stad009 name="construct.b.page1.stad009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad009
            
            #add-point:AFTER FIELD stad009 name="construct.a.page1.stad009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stad009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad009
            #add-point:ON ACTION controlp INFIELD stad009 name="construct.c.page1.stad009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stad010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad010
            #add-point:ON ACTION controlp INFIELD stad010 name="construct.c.page1.stad010"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oodb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stad010  #顯示到畫面上

            NEXT FIELD stad010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad010
            #add-point:BEFORE FIELD stad010 name="construct.b.page1.stad010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad010
            
            #add-point:AFTER FIELD stad010 name="construct.a.page1.stad010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stadacti
            #add-point:BEFORE FIELD stadacti name="construct.b.page1.stadacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stadacti
            
            #add-point:AFTER FIELD stadacti name="construct.a.page1.stadacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stadacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stadacti
            #add-point:ON ACTION controlp INFIELD stadacti name="construct.c.page1.stadacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad012
            #add-point:BEFORE FIELD stad012 name="construct.b.page1.stad012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad012
            
            #add-point:AFTER FIELD stad012 name="construct.a.page1.stad012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stad012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad012
            #add-point:ON ACTION controlp INFIELD stad012 name="construct.c.page1.stad012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stad013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad013
            #add-point:ON ACTION controlp INFIELD stad013 name="construct.c.page1.stad013"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗   #160510-00010#11  mark
            CALL q_stad013()                            #160510-00010#11  add
            DISPLAY g_qryparam.return1 TO stad013  #顯示到畫面上
            NEXT FIELD stad013                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad013
            #add-point:BEFORE FIELD stad013 name="construct.b.page1.stad013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad013
            
            #add-point:AFTER FIELD stad013 name="construct.a.page1.stad013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad015
            #add-point:BEFORE FIELD stad015 name="construct.b.page1.stad015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad015
            
            #add-point:AFTER FIELD stad015 name="construct.a.page1.stad015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stad015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad015
            #add-point:ON ACTION controlp INFIELD stad015 name="construct.c.page1.stad015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad016
            #add-point:BEFORE FIELD stad016 name="construct.b.page1.stad016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad016
            
            #add-point:AFTER FIELD stad016 name="construct.a.page1.stad016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stad016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad016
            #add-point:ON ACTION controlp INFIELD stad016 name="construct.c.page1.stad016"
            
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
                  WHEN la_wc[li_idx].tableid = "stac_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "stad_t" 
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
 
{<section id="astt203.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION astt203_filter()
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
      CONSTRUCT g_wc_filter ON stacsite,stacdocno,stacdocdt,stac000,stac001,stac002
                          FROM s_browse[1].b_stacsite,s_browse[1].b_stacdocno,s_browse[1].b_stacdocdt, 
                              s_browse[1].b_stac000,s_browse[1].b_stac001,s_browse[1].b_stac002
 
         BEFORE CONSTRUCT
               DISPLAY astt203_filter_parser('stacsite') TO s_browse[1].b_stacsite
            DISPLAY astt203_filter_parser('stacdocno') TO s_browse[1].b_stacdocno
            DISPLAY astt203_filter_parser('stacdocdt') TO s_browse[1].b_stacdocdt
            DISPLAY astt203_filter_parser('stac000') TO s_browse[1].b_stac000
            DISPLAY astt203_filter_parser('stac001') TO s_browse[1].b_stac001
            DISPLAY astt203_filter_parser('stac002') TO s_browse[1].b_stac002
      
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
 
      CALL astt203_filter_show('stacsite')
   CALL astt203_filter_show('stacdocno')
   CALL astt203_filter_show('stacdocdt')
   CALL astt203_filter_show('stac000')
   CALL astt203_filter_show('stac001')
   CALL astt203_filter_show('stac002')
 
END FUNCTION
 
{</section>}
 
{<section id="astt203.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION astt203_filter_parser(ps_field)
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
 
{<section id="astt203.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION astt203_filter_show(ps_field)
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
   LET ls_condition = astt203_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="astt203.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION astt203_query()
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
   CALL g_stad_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL astt203_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL astt203_browser_fill("")
      CALL astt203_fetch("")
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
      CALL astt203_filter_show('stacsite')
   CALL astt203_filter_show('stacdocno')
   CALL astt203_filter_show('stacdocdt')
   CALL astt203_filter_show('stac000')
   CALL astt203_filter_show('stac001')
   CALL astt203_filter_show('stac002')
   CALL astt203_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL astt203_fetch("F") 
      #顯示單身筆數
      CALL astt203_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="astt203.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION astt203_fetch(p_flag)
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
   
   LET g_stac_m.stacdocno = g_browser[g_current_idx].b_stacdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE astt203_master_referesh USING g_stac_m.stacdocno INTO g_stac_m.stacsite,g_stac_m.stacdocdt, 
       g_stac_m.stacdocno,g_stac_m.stacunit,g_stac_m.stac000,g_stac_m.stac001,g_stac_m.stac002,g_stac_m.stacstus, 
       g_stac_m.stacownid,g_stac_m.stacowndp,g_stac_m.staccrtid,g_stac_m.staccrtdp,g_stac_m.staccrtdt, 
       g_stac_m.stacmodid,g_stac_m.stacmoddt,g_stac_m.staccnfid,g_stac_m.staccnfdt,g_stac_m.stacsite_desc, 
       g_stac_m.stac001_desc,g_stac_m.stac002_desc,g_stac_m.stacownid_desc,g_stac_m.stacowndp_desc,g_stac_m.staccrtid_desc, 
       g_stac_m.staccrtdp_desc,g_stac_m.stacmodid_desc,g_stac_m.staccnfid_desc
   
   #遮罩相關處理
   LET g_stac_m_mask_o.* =  g_stac_m.*
   CALL astt203_stac_t_mask()
   LET g_stac_m_mask_n.* =  g_stac_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL astt203_set_act_visible()   
   CALL astt203_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   IF g_stac_m.stacstus = 'Y' OR g_stac_m.stacstus = 'X' THEN
      CALL cl_set_act_visible('modify,delete',FALSE)
   ELSE
      CALL cl_set_act_visible('modify,delete',TRUE)
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_stac_m_t.* = g_stac_m.*
   LET g_stac_m_o.* = g_stac_m.*
   
   LET g_data_owner = g_stac_m.stacownid      
   LET g_data_dept  = g_stac_m.stacowndp
   
   #重新顯示   
   CALL astt203_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="astt203.insert" >}
#+ 資料新增
PRIVATE FUNCTION astt203_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   DEFINE l_insert      LIKE type_t.num5  #ken---add 需求單號：141208-00001 項次：17
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_stad_d.clear()   
 
 
   INITIALIZE g_stac_m.* TO NULL             #DEFAULT 設定
   
   LET g_stacdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_stac_m.stacownid = g_user
      LET g_stac_m.stacowndp = g_dept
      LET g_stac_m.staccrtid = g_user
      LET g_stac_m.staccrtdp = g_dept 
      LET g_stac_m.staccrtdt = cl_get_current()
      LET g_stac_m.stacmodid = g_user
      LET g_stac_m.stacmoddt = cl_get_current()
      LET g_stac_m.stacstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_stac_m.stac000 = "I"
      LET g_stac_m.stacstus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      INITIALIZE g_stac_m_t.* TO NULL
      LET g_stac_m.stacdocdt = g_today
      LET g_stac_m.stac001   = g_user
      
      #ken---add---s 需求單號：141208-00001 項次：17
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'stacsite',g_stac_m.stacsite)
         RETURNING l_insert,g_stac_m.stacsite
      IF NOT l_insert THEN
         RETURN
      END IF
      LET g_stac_m.stacunit = g_stac_m.stacsite
      #ken---add---e
      
      #dongsz--add--str---
      #預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      #CALL s_arti200_get_def_doc_type(g_site,g_prog,'1')
      CALL s_arti200_get_def_doc_type(g_stac_m.stacsite,g_prog,'1')#ken---add
           RETURNING r_success,r_doctype
      LET g_stac_m.stacdocno = r_doctype
      #dongsz--add--end---
      
      CALL astt203_chk_stac001('a')
      CALL astt203_chk_stac002()
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_stac_m_t.* = g_stac_m.*
      LET g_stac_m_o.* = g_stac_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_stac_m.stacstus 
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
 
 
 
    
      CALL astt203_input("a")
      
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
         INITIALIZE g_stac_m.* TO NULL
         INITIALIZE g_stad_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL astt203_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_stad_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL astt203_set_act_visible()   
   CALL astt203_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_stacdocno_t = g_stac_m.stacdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " stacent = " ||g_enterprise|| " AND",
                      " stacdocno = '", g_stac_m.stacdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL astt203_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE astt203_cl
   
   CALL astt203_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE astt203_master_referesh USING g_stac_m.stacdocno INTO g_stac_m.stacsite,g_stac_m.stacdocdt, 
       g_stac_m.stacdocno,g_stac_m.stacunit,g_stac_m.stac000,g_stac_m.stac001,g_stac_m.stac002,g_stac_m.stacstus, 
       g_stac_m.stacownid,g_stac_m.stacowndp,g_stac_m.staccrtid,g_stac_m.staccrtdp,g_stac_m.staccrtdt, 
       g_stac_m.stacmodid,g_stac_m.stacmoddt,g_stac_m.staccnfid,g_stac_m.staccnfdt,g_stac_m.stacsite_desc, 
       g_stac_m.stac001_desc,g_stac_m.stac002_desc,g_stac_m.stacownid_desc,g_stac_m.stacowndp_desc,g_stac_m.staccrtid_desc, 
       g_stac_m.staccrtdp_desc,g_stac_m.stacmodid_desc,g_stac_m.staccnfid_desc
   
   
   #遮罩相關處理
   LET g_stac_m_mask_o.* =  g_stac_m.*
   CALL astt203_stac_t_mask()
   LET g_stac_m_mask_n.* =  g_stac_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_stac_m.stacsite,g_stac_m.stacsite_desc,g_stac_m.stacdocdt,g_stac_m.stacdocno,g_stac_m.stacunit, 
       g_stac_m.stac000,g_stac_m.stac001,g_stac_m.stac001_desc,g_stac_m.stac002,g_stac_m.stac002_desc, 
       g_stac_m.stacstus,g_stac_m.stacownid,g_stac_m.stacownid_desc,g_stac_m.stacowndp,g_stac_m.stacowndp_desc, 
       g_stac_m.staccrtid,g_stac_m.staccrtid_desc,g_stac_m.staccrtdp,g_stac_m.staccrtdp_desc,g_stac_m.staccrtdt, 
       g_stac_m.stacmodid,g_stac_m.stacmodid_desc,g_stac_m.stacmoddt,g_stac_m.staccnfid,g_stac_m.staccnfid_desc, 
       g_stac_m.staccnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_stac_m.stacownid      
   LET g_data_dept  = g_stac_m.stacowndp
   
   #功能已完成,通報訊息中心
   CALL astt203_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="astt203.modify" >}
#+ 資料修改
PRIVATE FUNCTION astt203_modify()
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
   LET g_stac_m_t.* = g_stac_m.*
   LET g_stac_m_o.* = g_stac_m.*
   
   IF g_stac_m.stacdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_stacdocno_t = g_stac_m.stacdocno
 
   CALL s_transaction_begin()
   
   OPEN astt203_cl USING g_enterprise,g_stac_m.stacdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN astt203_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE astt203_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE astt203_master_referesh USING g_stac_m.stacdocno INTO g_stac_m.stacsite,g_stac_m.stacdocdt, 
       g_stac_m.stacdocno,g_stac_m.stacunit,g_stac_m.stac000,g_stac_m.stac001,g_stac_m.stac002,g_stac_m.stacstus, 
       g_stac_m.stacownid,g_stac_m.stacowndp,g_stac_m.staccrtid,g_stac_m.staccrtdp,g_stac_m.staccrtdt, 
       g_stac_m.stacmodid,g_stac_m.stacmoddt,g_stac_m.staccnfid,g_stac_m.staccnfdt,g_stac_m.stacsite_desc, 
       g_stac_m.stac001_desc,g_stac_m.stac002_desc,g_stac_m.stacownid_desc,g_stac_m.stacowndp_desc,g_stac_m.staccrtid_desc, 
       g_stac_m.staccrtdp_desc,g_stac_m.stacmodid_desc,g_stac_m.staccnfid_desc
   
   #檢查是否允許此動作
   IF NOT astt203_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_stac_m_mask_o.* =  g_stac_m.*
   CALL astt203_stac_t_mask()
   LET g_stac_m_mask_n.* =  g_stac_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL astt203_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_stacdocno_t = g_stac_m.stacdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_stac_m.stacmodid = g_user 
LET g_stac_m.stacmoddt = cl_get_current()
LET g_stac_m.stacmodid_desc = cl_get_username(g_stac_m.stacmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL astt203_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE stac_t SET (stacmodid,stacmoddt) = (g_stac_m.stacmodid,g_stac_m.stacmoddt)
          WHERE stacent = g_enterprise AND stacdocno = g_stacdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_stac_m.* = g_stac_m_t.*
            CALL astt203_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_stac_m.stacdocno != g_stac_m_t.stacdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE stad_t SET staddocno = g_stac_m.stacdocno
 
          WHERE stadent = g_enterprise AND staddocno = g_stac_m_t.stacdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "stad_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "stad_t:",SQLERRMESSAGE 
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
LET l_field_key[01] = 'stadlent'
LET l_new_key[02] = g_stac_m.stacdocno
LET l_old_key[02] = g_stacdocno_t
LET l_field_key[02] = 'stadldocno'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'stadl_t')
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL astt203_set_act_visible()   
   CALL astt203_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " stacent = " ||g_enterprise|| " AND",
                      " stacdocno = '", g_stac_m.stacdocno, "' "
 
   #填到對應位置
   CALL astt203_browser_fill("")
 
   CLOSE astt203_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL astt203_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="astt203.input" >}
#+ 資料輸入
PRIVATE FUNCTION astt203_input(p_cmd)
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
   DEFINE  l_ooef004       LIKE ooef_t.ooef004
   DEFINE  l_success       LIKE type_t.chr1
   DEFINE  l_errno         LIKE type_t.chr10 #ken---add 需求單號：141208-00001 項次：17
   
   DEFINE l_stad001_t DYNAMIC ARRAY OF STRING
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
   DISPLAY BY NAME g_stac_m.stacsite,g_stac_m.stacsite_desc,g_stac_m.stacdocdt,g_stac_m.stacdocno,g_stac_m.stacunit, 
       g_stac_m.stac000,g_stac_m.stac001,g_stac_m.stac001_desc,g_stac_m.stac002,g_stac_m.stac002_desc, 
       g_stac_m.stacstus,g_stac_m.stacownid,g_stac_m.stacownid_desc,g_stac_m.stacowndp,g_stac_m.stacowndp_desc, 
       g_stac_m.staccrtid,g_stac_m.staccrtid_desc,g_stac_m.staccrtdp,g_stac_m.staccrtdp_desc,g_stac_m.staccrtdt, 
       g_stac_m.stacmodid,g_stac_m.stacmodid_desc,g_stac_m.stacmoddt,g_stac_m.staccnfid,g_stac_m.staccnfid_desc, 
       g_stac_m.staccnfdt
   
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
   LET g_forupd_sql = "SELECT stadseq,stad001,stad002,stad014,stad003,stad004,stad005,stad006,stad011, 
       stad007,stad008,stad009,stad010,stadacti,stad012,stad013,stad015,stad016 FROM stad_t WHERE stadent=?  
       AND staddocno=? AND stadseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astt203_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL astt203_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL astt203_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_stac_m.stacsite,g_stac_m.stacdocdt,g_stac_m.stacdocno,g_stac_m.stacunit,g_stac_m.stac000, 
       g_stac_m.stac001,g_stac_m.stac002,g_stac_m.stacstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="astt203.input.head" >}
      #單頭段
      INPUT BY NAME g_stac_m.stacsite,g_stac_m.stacdocdt,g_stac_m.stacdocno,g_stac_m.stacunit,g_stac_m.stac000, 
          g_stac_m.stac001,g_stac_m.stac002,g_stac_m.stacstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN astt203_cl USING g_enterprise,g_stac_m.stacdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN astt203_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE astt203_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL astt203_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL astt203_set_entry(p_cmd)
            CALL astt203_set_no_entry(p_cmd)
            NEXT FIELD stacsite #ken---add 需求單號：141208-00001 項次：17 
            #end add-point
            CALL astt203_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stacsite
            
            #add-point:AFTER FIELD stacsite name="input.a.stacsite"
            #ken---add---s 需求單號：141208-00001 項次：17
            IF NOT cl_null(g_stac_m.stacsite) THEN
               CALL s_aooi500_chk(g_prog,'stacsite',g_stac_m.stacsite,g_stac_m.stacsite)
                  RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_stac_m.stacsite = g_stac_m_t.stacsite
                  CALL s_desc_get_department_desc(g_stac_m.stacsite)
                     RETURNING g_stac_m.stacsite_desc
                  DISPLAY BY NAME g_stac_m.stacsite,g_stac_m.stacsite_desc
                  NEXT FIELD CURRENT
               END IF
            #sakura---add---str
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET g_stac_m.stacsite = g_stac_m_t.stacsite
               CALL s_desc_get_department_desc(g_stac_m.stacsite)
                  RETURNING g_stac_m.stacsite_desc
               DISPLAY BY NAME g_stac_m.stacsite,g_stac_m.stacsite_desc
               NEXT FIELD CURRENT
            #sakura---add---end
            END IF              
            LET g_site_flag = TRUE           
            CALL s_desc_get_department_desc(g_stac_m.stacsite)
               RETURNING g_stac_m.stacsite_desc
            DISPLAY BY NAME g_stac_m.stacsite,g_stac_m.stacsite_desc               
            CALL astt203_set_entry(p_cmd)
            CALL astt203_set_no_entry(p_cmd)            
            #ken---add---e            
            
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_stac_m.stacsite
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_stac_m.stacsite_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_stac_m.stacsite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stacsite
            #add-point:BEFORE FIELD stacsite name="input.b.stacsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stacsite
            #add-point:ON CHANGE stacsite name="input.g.stacsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stacdocdt
            #add-point:BEFORE FIELD stacdocdt name="input.b.stacdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stacdocdt
            
            #add-point:AFTER FIELD stacdocdt name="input.a.stacdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stacdocdt
            #add-point:ON CHANGE stacdocdt name="input.g.stacdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stacdocno
            #add-point:BEFORE FIELD stacdocno name="input.b.stacdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stacdocno
            
            #add-point:AFTER FIELD stacdocno name="input.a.stacdocno"
            #此段落由子樣板a05產生
            IF p_cmd = 'a' AND NOT cl_null(g_stac_m.stacdocno) THEN 
              #IF NOT s_aooi200_chk_slip(g_site,'',g_stac_m.stacdocno,g_prog) THEN #sakura mark
               IF NOT s_aooi200_chk_slip(g_stac_m.stacsite,'',g_stac_m.stacdocno,g_prog) THEN #sakura add
                  LET g_stac_m.stacdocno = g_stac_m_t.stacdocno
                  DISPLAY BY NAME g_stac_m.stacdocno
                  NEXT FIELD stacdocno
               END IF
            END IF
            IF NOT cl_null(g_stac_m.stacdocno) AND (p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_stac_m.stacdocno != g_stacdocno_t )))) THEN 
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stac_t WHERE "||"stacent = '" ||g_enterprise|| "' AND "||"stacdocno = '"||g_stac_m.stacdocno ||"'",'std-00004',0) THEN 
                  LET g_stac_m.stacdocno = g_stac_m_t.stacdocno
                  DISPLAY BY NAME g_stac_m.stacdocno
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stacdocno
            #add-point:ON CHANGE stacdocno name="input.g.stacdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stacunit
            #add-point:BEFORE FIELD stacunit name="input.b.stacunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stacunit
            
            #add-point:AFTER FIELD stacunit name="input.a.stacunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stacunit
            #add-point:ON CHANGE stacunit name="input.g.stacunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stac000
            #add-point:BEFORE FIELD stac000 name="input.b.stac000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stac000
            
            #add-point:AFTER FIELD stac000 name="input.a.stac000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stac000
            #add-point:ON CHANGE stac000 name="input.g.stac000"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stac001
            
            #add-point:AFTER FIELD stac001 name="input.a.stac001"
            IF NOT cl_null(g_stac_m.stac001) THEN 
               CALL astt203_chk_stac001('a')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_stac_m.stac001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_stac_m.stac001 = g_stac_m_t.stac001
                  DISPLAY BY NAME g_stac_m.stac001
                  NEXT FIELD stac001
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stac001
            #add-point:BEFORE FIELD stac001 name="input.b.stac001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stac001
            #add-point:ON CHANGE stac001 name="input.g.stac001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stac002
            
            #add-point:AFTER FIELD stac002 name="input.a.stac002"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stac_m.stac002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stac_m.stac002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stac_m.stac002_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stac002
            #add-point:BEFORE FIELD stac002 name="input.b.stac002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stac002
            #add-point:ON CHANGE stac002 name="input.g.stac002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stacstus
            #add-point:BEFORE FIELD stacstus name="input.b.stacstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stacstus
            
            #add-point:AFTER FIELD stacstus name="input.a.stacstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stacstus
            #add-point:ON CHANGE stacstus name="input.g.stacstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.stacsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stacsite
            #add-point:ON ACTION controlp INFIELD stacsite name="input.c.stacsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            #ken---add---s 需求單號：141208-00001 項次：17
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stac_m.stacsite             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stacsite',g_stac_m.stacsite,'i')   #150308-00001#5  By benson add 'i'
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_stac_m.stacsite = g_qryparam.return1              

            DISPLAY g_stac_m.stacsite TO stacsite              #

            NEXT FIELD stacsite                          #返回原欄位
            #ken---add---s

            #END add-point
 
 
         #Ctrlp:input.c.stacdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stacdocdt
            #add-point:ON ACTION controlp INFIELD stacdocdt name="input.c.stacdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.stacdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stacdocno
            #add-point:ON ACTION controlp INFIELD stacdocno name="input.c.stacdocno"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stac_m.stacdocno             #給予default值

            #給予arg
            SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise
            LET g_qryparam.arg1 = l_ooef004 #
            #LET g_qryparam.arg2 = "astt203" #   #160705-00042#5 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#5 160711 by sakura add

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_stac_m.stacdocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stac_m.stacdocno TO stacdocno              #顯示到畫面上

            NEXT FIELD stacdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.stacunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stacunit
            #add-point:ON ACTION controlp INFIELD stacunit name="input.c.stacunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.stac000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stac000
            #add-point:ON ACTION controlp INFIELD stac000 name="input.c.stac000"
            
            #END add-point
 
 
         #Ctrlp:input.c.stac001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stac001
            #add-point:ON ACTION controlp INFIELD stac001 name="input.c.stac001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stac_m.stac001             #給予default值

            #給予arg

            CALL q_ooag001_4()                                #呼叫開窗

            LET g_stac_m.stac001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stac_m.stac001 TO stac001              #顯示到畫面上

            NEXT FIELD stac001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.stac002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stac002
            #add-point:ON ACTION controlp INFIELD stac002 name="input.c.stac002"
            
            #END add-point
 
 
         #Ctrlp:input.c.stacstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stacstus
            #add-point:ON ACTION controlp INFIELD stacstus name="input.c.stacstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_stac_m.stacdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                 #CALL s_aooi200_gen_docno(g_site,g_stac_m.stacdocno,g_stac_m.stacdocdt,g_prog) RETURNING l_success,g_stac_m.stacdocno            #sakura mark  
                  CALL s_aooi200_gen_docno(g_stac_m.stacsite,g_stac_m.stacdocno,g_stac_m.stacdocdt,g_prog) RETURNING l_success,g_stac_m.stacdocno #sakura add
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00003'
                     LET g_errparam.extend = g_stac_m.stacdocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD stacdocno
                  END IF
                  LET g_stac_m.stacunit =  g_stac_m.stacsite #ken---add 需求單號：141208-00001 項次：17
               #end add-point
               
               INSERT INTO stac_t (stacent,stacsite,stacdocdt,stacdocno,stacunit,stac000,stac001,stac002, 
                   stacstus,stacownid,stacowndp,staccrtid,staccrtdp,staccrtdt,stacmodid,stacmoddt,staccnfid, 
                   staccnfdt)
               VALUES (g_enterprise,g_stac_m.stacsite,g_stac_m.stacdocdt,g_stac_m.stacdocno,g_stac_m.stacunit, 
                   g_stac_m.stac000,g_stac_m.stac001,g_stac_m.stac002,g_stac_m.stacstus,g_stac_m.stacownid, 
                   g_stac_m.stacowndp,g_stac_m.staccrtid,g_stac_m.staccrtdp,g_stac_m.staccrtdt,g_stac_m.stacmodid, 
                   g_stac_m.stacmoddt,g_stac_m.staccnfid,g_stac_m.staccnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_stac_m:",SQLERRMESSAGE 
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
                  CALL astt203_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL astt203_b_fill()
                  CALL astt203_b_fill2('0')
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
               CALL astt203_stac_t_mask_restore('restore_mask_o')
               
               UPDATE stac_t SET (stacsite,stacdocdt,stacdocno,stacunit,stac000,stac001,stac002,stacstus, 
                   stacownid,stacowndp,staccrtid,staccrtdp,staccrtdt,stacmodid,stacmoddt,staccnfid,staccnfdt) = (g_stac_m.stacsite, 
                   g_stac_m.stacdocdt,g_stac_m.stacdocno,g_stac_m.stacunit,g_stac_m.stac000,g_stac_m.stac001, 
                   g_stac_m.stac002,g_stac_m.stacstus,g_stac_m.stacownid,g_stac_m.stacowndp,g_stac_m.staccrtid, 
                   g_stac_m.staccrtdp,g_stac_m.staccrtdt,g_stac_m.stacmodid,g_stac_m.stacmoddt,g_stac_m.staccnfid, 
                   g_stac_m.staccnfdt)
                WHERE stacent = g_enterprise AND stacdocno = g_stacdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "stac_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL astt203_stac_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_stac_m_t)
               LET g_log2 = util.JSON.stringify(g_stac_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_stacdocno_t = g_stac_m.stacdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="astt203.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_stad_d FROM s_detail1.*
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
               IF NOT cl_null(g_stad_d[l_ac].stad001)  THEN
                  CALL n_stadl(g_stac_m.stacdocno,g_stad_d[l_ac].stadseq)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_stac_m.stacdocno
                  LET g_ref_fields[2] = g_stad_d[l_ac].stadseq
                  CALL ap_ref_array2(g_ref_fields," SELECT stadl002,stadl003 FROM stadl_t WHERE stadlent = '"
                      ||g_enterprise||"' AND stadldocno = ? AND stadlseq = ? AND stadl001 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_stad_d[l_ac].stadl002 = g_rtn_fields[1]
                  LET g_stad_d[l_ac].stadl003 = g_rtn_fields[2]
                  DISPLAY BY NAME g_stad_d[l_ac].stadl002
                  DISPLAY BY NAME g_stad_d[l_ac].stadl003
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stad_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL astt203_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_stad_d.getLength()
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
            OPEN astt203_cl USING g_enterprise,g_stac_m.stacdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN astt203_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE astt203_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_stad_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_stad_d[l_ac].stadseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_stad_d_t.* = g_stad_d[l_ac].*  #BACKUP
               LET g_stad_d_o.* = g_stad_d[l_ac].*  #BACKUP
               CALL astt203_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL astt203_set_no_entry_b(l_cmd)
               IF NOT astt203_lock_b("stad_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astt203_bcl INTO g_stad_d[l_ac].stadseq,g_stad_d[l_ac].stad001,g_stad_d[l_ac].stad002, 
                      g_stad_d[l_ac].stad014,g_stad_d[l_ac].stad003,g_stad_d[l_ac].stad004,g_stad_d[l_ac].stad005, 
                      g_stad_d[l_ac].stad006,g_stad_d[l_ac].stad011,g_stad_d[l_ac].stad007,g_stad_d[l_ac].stad008, 
                      g_stad_d[l_ac].stad009,g_stad_d[l_ac].stad010,g_stad_d[l_ac].stadacti,g_stad_d[l_ac].stad012, 
                      g_stad_d[l_ac].stad013,g_stad_d[l_ac].stad015,g_stad_d[l_ac].stad016
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_stad_d_t.stadseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_stad_d_mask_o[l_ac].* =  g_stad_d[l_ac].*
                  CALL astt203_stad_t_mask()
                  LET g_stad_d_mask_n[l_ac].* =  g_stad_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL astt203_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.stadldocno = g_stac_m.stacdocno
LET g_detail_multi_table_t.stadlseq = g_stad_d[l_ac].stadseq
LET g_detail_multi_table_t.stadl001 = g_dlang
LET g_detail_multi_table_t.stadl002 = g_stad_d[l_ac].stadl002
LET g_detail_multi_table_t.stadl003 = g_stad_d[l_ac].stadl003
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'stadlent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'stadldocno'
            LET l_var_keys[02] = g_stac_m.stacdocno
            LET l_field_keys[03] = 'stadlseq'
            LET l_var_keys[03] = g_stad_d[l_ac].stadseq
            LET l_field_keys[04] = 'stadl001'
            LET l_var_keys[04] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'stadl_t') THEN
               RETURN 
            END IF 
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_stad_d[l_ac].* TO NULL 
            INITIALIZE g_stad_d_t.* TO NULL 
            INITIALIZE g_stad_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_stad_d[l_ac].stad011 = "Y"
      LET g_stad_d[l_ac].stad007 = "N"
      LET g_stad_d[l_ac].stad009 = "Y"
      LET g_stad_d[l_ac].stadacti = "Y"
      LET g_stad_d[l_ac].stad016 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #160510-00010#9   add(S)
            #费用归属类型新增时默认给1
            IF cl_null(g_stad_d[l_ac].stad012) THEN
               LET g_stad_d[l_ac].stad012 = 1
            END IF
            #160510-00010#9   add(E)
            #end add-point
            LET g_stad_d_t.* = g_stad_d[l_ac].*     #新輸入資料
            LET g_stad_d_o.* = g_stad_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL astt203_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL astt203_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stad_d[li_reproduce_target].* = g_stad_d[li_reproduce].*
 
               LET g_stad_d[li_reproduce_target].stadseq = NULL
 
            END IF
            
LET g_detail_multi_table_t.stadldocno = g_stac_m.stacdocno
LET g_detail_multi_table_t.stadlseq = g_stad_d[l_ac].stadseq
LET g_detail_multi_table_t.stadl001 = g_dlang
LET g_detail_multi_table_t.stadl002 = g_stad_d[l_ac].stadl002
LET g_detail_multi_table_t.stadl003 = g_stad_d[l_ac].stadl003
 
            #add-point:modify段before insert name="input.body.before_insert"
            CALL astt203_get_stadseq()
            
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
            SELECT COUNT(1) INTO l_count FROM stad_t 
             WHERE stadent = g_enterprise AND staddocno = g_stac_m.stacdocno
 
               AND stadseq = g_stad_d[l_ac].stadseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stac_m.stacdocno
               LET gs_keys[2] = g_stad_d[g_detail_idx].stadseq
               CALL astt203_insert_b('stad_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_stad_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "stad_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL astt203_b_fill()
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_stac_m.stacdocno = g_detail_multi_table_t.stadldocno AND
         g_stad_d[l_ac].stadseq = g_detail_multi_table_t.stadlseq AND
         g_stad_d[l_ac].stadl002 = g_detail_multi_table_t.stadl002 AND
         g_stad_d[l_ac].stadl003 = g_detail_multi_table_t.stadl003 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'stadlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_stac_m.stacdocno
            LET l_field_keys[02] = 'stadldocno'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.stadldocno
            LET l_var_keys[03] = g_stad_d[l_ac].stadseq
            LET l_field_keys[03] = 'stadlseq'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.stadlseq
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'stadl001'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.stadl001
            LET l_vars[01] = g_stad_d[l_ac].stadl002
            LET l_fields[01] = 'stadl002'
            LET l_vars[02] = g_stad_d[l_ac].stadl003
            LET l_fields[02] = 'stadl003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'stadl_t')
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
#               LET l_stad001_t[l_ac] = ""
               INITIALIZE g_stad_d[l_ac].* TO NULL 
               INITIALIZE g_stad_d_t.* TO NULL 
               INITIALIZE g_stad_d_o.* TO NULL 
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
               IF astt203_stad001_del() = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00011'
                  LET g_errparam.extend = g_stad_d_t.stad001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 #该费用编号已被使用，不可删除
                  CANCEL DELETE
               END IF
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_stac_m.stacdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_stad_d_t.stadseq
 
            
               #刪除同層單身
               IF NOT astt203_delete_b('stad_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE astt203_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT astt203_key_delete_b(gs_keys,'stad_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE astt203_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'stadlent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'stadldocno'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.stadldocno
                  LET l_field_keys[03] = 'stadlseq'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.stadlseq
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'stadl_t')
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE astt203_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_stad_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_stad_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stadseq
            #add-point:BEFORE FIELD stadseq name="input.b.page1.stadseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stadseq
            
            #add-point:AFTER FIELD stadseq name="input.a.page1.stadseq"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_stac_m.stacdocno) AND NOT cl_null(g_stad_d[g_detail_idx].stadseq) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_stac_m.stacdocno != g_stacdocno_t OR g_stad_d[g_detail_idx].stadseq != g_stad_d_t.stadseq))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stad_t WHERE "||"stadent = '" ||g_enterprise|| "' AND "||"staddocno = '"||g_stac_m.stacdocno ||"' AND "|| "stadseq = '"||g_stad_d[g_detail_idx].stadseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stadseq
            #add-point:ON CHANGE stadseq name="input.g.page1.stadseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad001
            #add-point:BEFORE FIELD stad001 name="input.b.page1.stad001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad001
            
            #add-point:AFTER FIELD stad001 name="input.a.page1.stad001"
            IF NOT cl_null(g_stad_d[l_ac].stad001) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_stad_d[l_ac].stad001 != g_stad_d_t.stad001))) THEN   #160824-00007#175 Mark BY Ken 161103
               IF (g_stad_d[l_ac].stad001 != g_stad_d_o.stad001) THEN   #160824-00007#175 Add BY Ken 161103
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stad_t WHERE "||"stadent = '" ||g_enterprise|| "' AND "||"staddocno = '"||g_stac_m.stacdocno ||"' AND "|| "stad001 = '"||g_stad_d[l_ac].stad001 ||"'",'std-00004',0) THEN 
                     #LET g_stad_d[l_ac].stad001 = g_stad_d_t.stad001  #160824-00007#175 Mark BY Ken 161103
                     LET g_stad_d[l_ac].stad001 = g_stad_d_o.stad001   #160824-00007#175 Add BY Ken 161103
                     DISPLAY BY NAME g_stad_d[l_ac].stad001
                     IF (g_stad_d[l_ac].stad001 != g_stad_d_o.stad001) OR (cl_null(g_stad_d_o.stad001)) THEN   #160510-00010#9   add(S)
                        CALL astt203_stad001_init()
                     END IF
                     NEXT FIELD CURRENT
                  END IF
                  CALL astt203_chk_stad001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_stad_d[l_ac].stad001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_stad_d[l_ac].stad001 = g_stad_d_t.stad001  #160824-00007#175 Mark BY Ken 161103
                     LET g_stad_d[l_ac].stad001 = g_stad_d_o.stad001   #160824-00007#175 Add BY Ken 161103
                     DISPLAY BY NAME g_stad_d[l_ac].stad001
                     CALL astt203_stad001_init()
                     NEXT FIELD stad001
                  END IF
                  IF (g_stad_d[l_ac].stad001 != g_stad_d_o.stad001) OR (cl_null(g_stad_d_o.stad001)) THEN   #160510-00010#9   add(S)
                     CALL astt203_stad001_init()
                  END IF
                  IF g_stac_m.stac000 = 'I' THEN
                     LET g_stad_d[l_ac].stad008 = g_stad_d[l_ac].stad001
                     DISPLAY BY NAME g_stad_d[l_ac].stad008
                  END IF
               END IF
            ELSE
               IF (g_stad_d[l_ac].stad001 != g_stad_d_o.stad001) OR (cl_null(g_stad_d_o.stad001)) THEN   #160510-00010#9   add(S)
                  CALL astt203_stad001_init()
               END IF
            END IF
            
            #160510-00010#9   add(S)
            #新增时自动从asti203带出 stad012,stad013,stad013_desc,stad014,stad011,stad007
            IF NOT cl_null(g_stad_d[l_ac].stad001) AND g_stac_m.stac000 = 'U' THEN
               
#               IF (l_cmd = 'a' AND cl_null(l_stad001_t[l_ac])) #第一次新增时
#                  OR (l_cmd = 'a' AND g_stad_d[l_ac].stad001 != l_stad001_t[l_ac]) #新增状态下，编号有异动
#                  OR (l_cmd = 'u' AND cl_null(l_stad001_t[l_ac]))#第一次修改时
#                  OR (l_cmd = 'u' AND g_stad_d[l_ac].stad001 != l_stad001_t[l_ac]) #修改状态下，编号有异动
#               THEN    
               IF (g_stad_d[l_ac].stad001 != g_stad_d_o.stad001) OR (cl_null(g_stad_d_o.stad001)) THEN   #判断费用编号是否有异动，或为第一次新增时
                  CALL astt203_stad001_init()
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_stad_d[l_ac].stad001
                  CALL ap_ref_array2(g_ref_fields,"SELECT stae013,stae014,stae012,stae011,stae007 FROM stae_t WHERE staeent='"||g_enterprise||"' AND stae001=? ","") RETURNING g_rtn_fields 
                  LET g_stad_d[l_ac].stad012 = '', g_rtn_fields[1] , ''
                  LET g_stad_d[l_ac].stad013 = '', g_rtn_fields[2] , ''
                  LET g_stad_d[l_ac].stad014 = '', g_rtn_fields[3] , ''
                  LET g_stad_d[l_ac].stad011 = '', g_rtn_fields[4] , ''
                  LET g_stad_d[l_ac].stad007 = '', g_rtn_fields[5] , ''
                  
                  IF cl_null(g_stad_d[l_ac].stad012)  THEN
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = g_stad_d[l_ac].stad001
                     CALL ap_ref_array2(g_ref_fields,"SELECT stad012 FROM stad_t WHERE stadent='"||g_enterprise||"' AND stad001=? ","") RETURNING g_rtn_fields
                     LET g_stad_d[l_ac].stad012 = '', g_rtn_fields[1] , ''
                  END IF
                  
                  IF cl_null(g_stad_d[l_ac].stad013) THEN
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = g_stad_d[l_ac].stad001
                     CALL ap_ref_array2(g_ref_fields,"SELECT stad013 FROM stad_t WHERE stadent='"||g_enterprise||"' AND stad001=? ","") RETURNING g_rtn_fields
                     LET g_stad_d[l_ac].stad013 = '', g_rtn_fields[1] , ''
                  END IF
                  
                  IF cl_null(g_stad_d[l_ac].stad014) THEN
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = g_stad_d[l_ac].stad001
                     CALL ap_ref_array2(g_ref_fields,"SELECT stad014 FROM stad_t WHERE stadent='"||g_enterprise||"' AND stad001=? ","") RETURNING g_rtn_fields
                     LET g_stad_d[l_ac].stad014 = '', g_rtn_fields[1] , ''
                  END IF
                  
                  IF cl_null(g_stad_d[l_ac].stad011) THEN
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = g_stad_d[l_ac].stad001
                     CALL ap_ref_array2(g_ref_fields,"SELECT stad011 FROM stad_t WHERE stadent='"||g_enterprise||"' AND stad001=? ","") RETURNING g_rtn_fields
                     LET g_stad_d[l_ac].stad011 = '', g_rtn_fields[1] , ''
                  END IF
                  
                  IF cl_null(g_stad_d[l_ac].stad007) THEN
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = g_stad_d[l_ac].stad001
                     CALL ap_ref_array2(g_ref_fields,"SELECT stad007 FROM stad_t WHERE stadent='"||g_enterprise||"' AND stad001=? ","") RETURNING g_rtn_fields
                     LET g_stad_d[l_ac].stad007 = '', g_rtn_fields[1] , ''
                  END IF
                  
                  DISPLAY BY NAME g_stad_d[l_ac].stad012,g_stad_d[l_ac].stad013,g_stad_d[l_ac].stad014,g_stad_d[l_ac].stad011,g_stad_d[l_ac].stad007
                  
                  IF g_stad_d[l_ac].stad012 = '2' THEN
                     SELECT ooefl003 INTO g_stad_d[l_ac].stad013_desc
                     FROM ooefl_t WHERE ooeflent= g_enterprise  AND ooefl001 = g_stad_d[l_ac].stad013 AND ooefl002= g_dlang
                     DISPLAY BY NAME g_stad_d[l_ac].stad013_desc
                  END IF
                  
                  IF g_stad_d[l_ac].stad012 = '3' THEN
                     SELECT pmaal003 INTO g_stad_d[l_ac].stad013_desc
                     FROM pmaal_t WHERE pmaalent= g_enterprise  AND pmaal001 = g_stad_d[l_ac].stad013 AND pmaal002= g_dlang
                     DISPLAY BY NAME g_stad_d[l_ac].stad013_desc
                  END IF
                  
                  IF cl_null(g_stad_d[l_ac].stad013) THEN
                     LET g_stad_d[l_ac].stad013_desc = ''
                     DISPLAY BY NAME g_stad_d[l_ac].stad013_desc
                  END IF
                  
#                  LET l_stad001_t[l_ac] = g_stad_d[l_ac].stad001
                  LET g_stad_d_o.stad001 = g_stad_d[l_ac].stad001
               END IF
           
            END IF
            
            IF g_stad_d[l_ac].stad012!='1' THEN
               CALL cl_set_comp_entry('stad013',TRUE)
            ELSE
               CALL cl_set_comp_entry('stad013',FALSE)
            END IF
            #160510-00010#9   add(E)
            LET g_stad_d_o.* = g_stad_d[l_ac].*   #160824-00007#175 Add BY Ken 161103
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stad001
            #add-point:ON CHANGE stad001 name="input.g.page1.stad001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stadl002
            #add-point:BEFORE FIELD stadl002 name="input.b.page1.stadl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stadl002
            
            #add-point:AFTER FIELD stadl002 name="input.a.page1.stadl002"
            IF NOT cl_null(g_stad_d[l_ac].stadl002) THEN
               IF g_stad_d[l_ac].stad008 = g_stad_d[l_ac].stad001 THEN
                  LET g_stad_d[l_ac].stad008_desc = g_stad_d[l_ac].stadl002
                  DISPLAY BY NAME g_stad_d[l_ac].stad008_desc
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stadl002
            #add-point:ON CHANGE stadl002 name="input.g.page1.stadl002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stadl003
            #add-point:BEFORE FIELD stadl003 name="input.b.page1.stadl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stadl003
            
            #add-point:AFTER FIELD stadl003 name="input.a.page1.stadl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stadl003
            #add-point:ON CHANGE stadl003 name="input.g.page1.stadl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad002
            #add-point:BEFORE FIELD stad002 name="input.b.page1.stad002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad002
            
            #add-point:AFTER FIELD stad002 name="input.a.page1.stad002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stad002
            #add-point:ON CHANGE stad002 name="input.g.page1.stad002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad014
            #add-point:BEFORE FIELD stad014 name="input.b.page1.stad014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad014
            
            #add-point:AFTER FIELD stad014 name="input.a.page1.stad014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stad014
            #add-point:ON CHANGE stad014 name="input.g.page1.stad014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad003
            
            #add-point:AFTER FIELD stad003 name="input.a.page1.stad003"
            IF NOT cl_null(g_stad_d[l_ac].stad003) THEN
               CALL astt203_chk_stad003()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_stad_d[l_ac].stad003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_stad_d[l_ac].stad003 = g_stad_d_t.stad003  #160824-00007#175 Mark BY Ken 161103
                  LET g_stad_d[l_ac].stad003 = g_stad_d_o.stad003   #160824-00007#175 Add BY Ken 161103
                  DISPLAY BY NAME g_stad_d[l_ac].stad003
                  NEXT FIELD stad003
               END IF
            ELSE
               LET g_stad_d[l_ac].stad003_desc = ''
               DISPLAY BY NAME g_stad_d[l_ac].stad003_desc
            END IF
            LET g_stad_d_o.* = g_stad_d[l_ac].*   #160824-00007#175 Add BY Ken 161103
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad003
            #add-point:BEFORE FIELD stad003 name="input.b.page1.stad003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stad003
            #add-point:ON CHANGE stad003 name="input.g.page1.stad003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad004
            #add-point:BEFORE FIELD stad004 name="input.b.page1.stad004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad004
            
            #add-point:AFTER FIELD stad004 name="input.a.page1.stad004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stad004
            #add-point:ON CHANGE stad004 name="input.g.page1.stad004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad005
            #add-point:BEFORE FIELD stad005 name="input.b.page1.stad005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad005
            
            #add-point:AFTER FIELD stad005 name="input.a.page1.stad005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stad005
            #add-point:ON CHANGE stad005 name="input.g.page1.stad005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad006
            #add-point:BEFORE FIELD stad006 name="input.b.page1.stad006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad006
            
            #add-point:AFTER FIELD stad006 name="input.a.page1.stad006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stad006
            #add-point:ON CHANGE stad006 name="input.g.page1.stad006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad011
            #add-point:BEFORE FIELD stad011 name="input.b.page1.stad011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad011
            
            #add-point:AFTER FIELD stad011 name="input.a.page1.stad011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stad011
            #add-point:ON CHANGE stad011 name="input.g.page1.stad011"
            
            IF g_stad_d[l_ac].stad011 = 'N' OR cl_null(g_stad_d[l_ac].stad011) THEN
               LET g_stad_d[l_ac].stad007 = 'N'
               DISPLAY BY NAME g_stad_d[l_ac].stad007
            END IF
            CALL astt203_set_entry_b("u")
            CALL astt203_set_no_entry_b("u")
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad007
            #add-point:BEFORE FIELD stad007 name="input.b.page1.stad007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad007
            
            #add-point:AFTER FIELD stad007 name="input.a.page1.stad007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stad007
            #add-point:ON CHANGE stad007 name="input.g.page1.stad007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad008
            
            #add-point:AFTER FIELD stad008 name="input.a.page1.stad008"
            LET g_stad_d[l_ac].stad008_desc = ''
            DISPLAY BY NAME g_stad_d[l_ac].stad008_desc
            IF NOT cl_null(g_stad_d[l_ac].stad008) AND NOT cl_null(g_stad_d[l_ac].stad008) THEN
               IF g_stad_d[l_ac].stad008 <> g_stad_d[l_ac].stad001 THEN
                  CALL astt203_chk_stad008()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_stad_d[l_ac].stad008
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_stad_d[l_ac].stad008 = g_stad_d_t.stad008  #160824-00007#175 Mark BY Ken 161103
                     LET g_stad_d[l_ac].stad008 = g_stad_d_o.stad008   #160824-00007#175 Add BY Ken 161103
                     DISPLAY BY NAME g_stad_d[l_ac].stad008
                     CALL astt203_stad008_ref()
                     NEXT FIELD stad008
                  END IF
               END IF
            END IF
            CALL astt203_stad008_ref()
            LET g_stad_d_o.* = g_stad_d[l_ac].*   #160824-00007#175 Add BY Ken 161103
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad008
            #add-point:BEFORE FIELD stad008 name="input.b.page1.stad008"
            IF cl_null(g_stad_d[l_ac].stad001) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ast-00012'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 #请先录入费用编号
               NEXT FIELD stad001
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stad008
            #add-point:ON CHANGE stad008 name="input.g.page1.stad008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad009
            #add-point:BEFORE FIELD stad009 name="input.b.page1.stad009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad009
            
            #add-point:AFTER FIELD stad009 name="input.a.page1.stad009"
            CALL astt203_set_entry_b("u")
            CALL astt203_set_no_entry_b("u")
            IF g_stad_d[l_ac].stad009 = 'N' THEN
               INITIALIZE g_stad_d[l_ac].stad010 TO NULL
               INITIALIZE g_stad_d[l_ac].stad010_desc TO NULL
               DISPLAY BY NAME g_stad_d[l_ac].stad010,g_stad_d[l_ac].stad010_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stad009
            #add-point:ON CHANGE stad009 name="input.g.page1.stad009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad010
            
            #add-point:AFTER FIELD stad010 name="input.a.page1.stad010"
            IF NOT cl_null(g_stad_d[l_ac].stad010) THEN
               CALL astt203_chk_stad010()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_stad_d[l_ac].stad010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_stad_d[l_ac].stad010 = g_stad_d_t.stad010  #160824-00007#175 Mark BY Ken 161103
                  LET g_stad_d[l_ac].stad010 = g_stad_d_o.stad010   #160824-00007#175 Add BY Ken 161103
                  DISPLAY BY NAME g_stad_d[l_ac].stad010
                  NEXT FIELD stad010
               END IF
            ELSE
               LET g_stad_d[l_ac].stad010_desc = ''
               DISPLAY BY NAME g_stad_d[l_ac].stad010_desc
            END IF
            LET g_stad_d_o.* = g_stad_d[l_ac].*   #160824-00007#175 Add BY Ken 161103
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad010
            #add-point:BEFORE FIELD stad010 name="input.b.page1.stad010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stad010
            #add-point:ON CHANGE stad010 name="input.g.page1.stad010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stadacti
            #add-point:BEFORE FIELD stadacti name="input.b.page1.stadacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stadacti
            
            #add-point:AFTER FIELD stadacti name="input.a.page1.stadacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stadacti
            #add-point:ON CHANGE stadacti name="input.g.page1.stadacti"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad012
            #add-point:BEFORE FIELD stad012 name="input.b.page1.stad012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad012
            
            #add-point:AFTER FIELD stad012 name="input.a.page1.stad012"
            IF cl_null(g_stad_d[l_ac].stad012) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ast-00749'      #费用归属类型不可唯恐
               LET g_errparam.extend = g_stad_d[l_ac].stad012
               LET g_errparam.popup = TRUE
               CALL cl_err() 
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stad012
            #add-point:ON CHANGE stad012 name="input.g.page1.stad012"
            CALL astt203_set_entry_b("u")
            CALL astt203_set_no_entry_b("u")
#            IF g_stad_d[l_ac].stad012 != 2 OR cl_null(g_stad_d[l_ac].stad012) THEN
#               LET g_stad_d[l_ac].stad013 = ''
#               LET g_stad_d[l_ac].stad013_desc = ''
#               DISPLAY BY NAME g_stad_d[l_ac].stad013,g_stad_d[l_ac].stad013_desc
#            END IF
            #如果更改费用归属组织类型,费用归属组织和说明栏位置空   #160510-00010#11 add(S)
            LET g_stad_d[l_ac].stad013 = ''
            LET g_stad_d[l_ac].stad013_desc = ''
            DISPLAY BY NAME g_stad_d[l_ac].stad013,g_stad_d[l_ac].stad013_desc
            #160510-00010#11 add(E)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad013
            
            #add-point:AFTER FIELD stad013 name="input.a.page1.stad013"
            IF NOT cl_null(g_stad_d[l_ac].stad013) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_stad_d[l_ac].stad013

               IF g_stad_d[l_ac].stad012 = '2' THEN   #160510-00010#11  add   费用归属类型为2时的栏位校验
                  #161024-00025#2--mark--s
#                  #呼叫檢查存在並帶值的library
#                  IF cl_chk_exist("v_ooef001") THEN
#                     #檢查成功時後續處理
#                  ELSE
#                     #檢查失敗時後續處理
#                     NEXT FIELD CURRENT
#                  END IF
                  #161024-00025#2--mark--e
                  #161024-00025#2--add--s
                  IF s_aooi500_setpoint(g_prog,'stad013') THEN
                     CALL s_aooi500_chk(g_prog,'stad013',g_stad_d[l_ac].stad013,g_stac_m.stacsite) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_stad_d[l_ac].stad013
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                     
                        LET g_stad_d[l_ac].stad013 = g_stad_d_t.stad013
                        CALL s_desc_get_department_desc(g_stad_d[l_ac].stad013) RETURNING g_stad_d[l_ac].stad013_desc
                        DISPLAY BY NAME g_stad_d[l_ac].stad013,g_stad_d[l_ac].stad013_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_ooef001") THEN
                        #檢查成功時後續處理
                     ELSE
                        #檢查失敗時後續處理
                        LET g_stad_d[l_ac].stad013 = g_stad_d_t.stad013
                        CALL s_desc_get_department_desc(g_stad_d[l_ac].stad013) RETURNING g_stad_d[l_ac].stad013_desc
                        DISPLAY BY NAME g_stad_d[l_ac].stad013,g_stad_d[l_ac].stad013_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #161024-00025#2--add--e
               END IF
               
               IF g_stad_d[l_ac].stad012 = '3' THEN   #160510-00010#11  add   费用归属类型为3时的栏位校验
                  LET g_errshow = TRUE
                  LET g_chkparam.err_str[1] = "apm-00024:apm-01098"
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_pmaa001_1") THEN
                     #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               END IF
 
            END IF 
            
            #160510-00010#11  add （S）
            IF g_stad_d[l_ac].stad012 = '2' THEN   #160510-00010#11  add   费用归属类型为2时的说明栏位校验带值
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_stad_d[l_ac].stad013
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_stad_d[l_ac].stad013_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_stad_d[l_ac].stad013_desc
            END IF
            
            IF g_stad_d[l_ac].stad012 = '3' THEN   #160510-00010#11  add   费用归属类型为3时的说明栏位校验带值
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_stad_d[l_ac].stad013
               CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_stad_d[l_ac].stad013_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_stad_d[l_ac].stad013_desc
            END IF
            #160510-00010#11  add （E）

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad013
            #add-point:BEFORE FIELD stad013 name="input.b.page1.stad013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stad013
            #add-point:ON CHANGE stad013 name="input.g.page1.stad013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad015
            #add-point:BEFORE FIELD stad015 name="input.b.page1.stad015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad015
            
            #add-point:AFTER FIELD stad015 name="input.a.page1.stad015"
            IF NOT cl_null(g_stad_d[l_ac].stad015) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_stad_d[l_ac].stad015 != g_stad_d_t.stad015 OR g_stad_d_t.stad015 IS NULL )) THEN   #160824-00007#175 Mark BY Ken 161103
               IF (g_stad_d[l_ac].stad015 != g_stad_d_o.stad015 OR g_stad_d_o.stad015 IS NULL ) THEN   #160824-00007#175 Add BY Ken 161103
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM stad_t
                   WHERE stadent = g_enterprise
                     AND staddocno = g_stac_m.stacdocno
                     AND stad001 <> g_stad_d[l_ac].stad001
                     AND stad015 = g_stad_d[l_ac].stad015    
                     
                  IF l_cnt > 0 THEN
                     #優先序不可重複
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "asf-00376"
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()            
                     
                     #LET g_stad_d[l_ac].stad015 = g_stad_d_t.stad015   #160824-00007#175 Mark BY Ken 161103
                     LET g_stad_d[l_ac].stad015 = g_stad_d_o.stad015    #160824-00007#175 Add BY Ken 161103
                     NEXT FIELD CURRENT
                  ELSE
                     LET l_cnt = 0
                     
                     SELECT COUNT(*) INTO l_cnt
                       FROM stae_t
                      WHERE staeent = g_enterprise
                        AND stae001 <> g_stad_d[l_ac].stad001
                        AND stae015 = g_stad_d[l_ac].stad015  
                        AND NOT EXISTS(SELECT 1 FROM stad_t 
                                        WHERE stadent = staeent
                                          AND staddocno = g_stac_m.stacdocno                                         
                                          AND stad001 = stae001)  
                                          
                     IF l_cnt > 0 THEN
                        #優先序不可重複
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = "asf-00376"
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()            
                        
                        #LET g_stad_d[l_ac].stad015 = g_stad_d_t.stad015   #160824-00007#175 Mark BY Ken 161103
                        LET g_stad_d[l_ac].stad015 = g_stad_d_o.stad015    #160824-00007#175 Add BY Ken 161103
                        NEXT FIELD CURRENT                     
                     END IF                     
                  END IF
               END IF
            END IF
            LET g_stad_d_o.* = g_stad_d[l_ac].*   #160824-00007#175 Add BY Ken 161103
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stad015
            #add-point:ON CHANGE stad015 name="input.g.page1.stad015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stad016
            #add-point:BEFORE FIELD stad016 name="input.b.page1.stad016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stad016
            
            #add-point:AFTER FIELD stad016 name="input.a.page1.stad016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stad016
            #add-point:ON CHANGE stad016 name="input.g.page1.stad016"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.stadseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stadseq
            #add-point:ON ACTION controlp INFIELD stadseq name="input.c.page1.stadseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stad001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad001
            #add-point:ON ACTION controlp INFIELD stad001 name="input.c.page1.stad001"
#此段落由子樣板a07產生            
            #開窗i段
            IF g_stac_m.stac000 = 'U' THEN
			   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

               LET g_qryparam.default1 = g_stad_d[l_ac].stad001             #給予default值
               LET g_qryparam.default2 = "" #g_stad_d[l_ac].stael003 #說明
               LET g_qryparam.default3 = "" #g_stad_d[l_ac].stae001 #費用編號

               #給予arg

               CALL q_stae001_1()                                #呼叫開窗

               LET g_stad_d[l_ac].stad001 = g_qryparam.return1              #將開窗取得的值回傳到變數
               #LET g_stad_d[l_ac].stael003 = g_qryparam.return2 #說明
               #LET g_stad_d[l_ac].stae001 = g_qryparam.return3 #費用編號

               DISPLAY g_stad_d[l_ac].stad001 TO stad001              #顯示到畫面上
               
               IF (g_stad_d[l_ac].stad001 != g_stad_d_o.stad001) OR (cl_null(g_stad_d_o.stad001)) THEN
                  CALL astt203_stad001_init()
               END IF
               #DISPLAY g_stad_d[l_ac].stael003 TO stael003 #說明
               #DISPLAY g_stad_d[l_ac].stae001 TO stae001 #費用編號
               
               #160510-00010#9   add(S)
               #新增时自动从asti203带出 stad012,stad013,stad013_desc
               IF NOT cl_null(g_stad_d[l_ac].stad001) THEN
#                  INITIALIZE g_ref_fields TO NULL
#                  LET g_ref_fields[1] = g_stad_d[l_ac].stad001
#                  CALL ap_ref_array2(g_ref_fields,"SELECT stae013,stae014 FROM stae_t WHERE staeent='"||g_enterprise||"' AND stae001=? ","") RETURNING g_rtn_fields
#                  LET g_stad_d[l_ac].stad012 = '', g_rtn_fields[1] , ''
#                  LET g_stad_d[l_ac].stad013 = '', g_rtn_fields[2] , ''
#                  DISPLAY BY NAME g_stad_d[l_ac].stad012,g_stad_d[l_ac].stad013
#                  
#                  SELECT ooefl003 INTO g_stad_d[l_ac].stad013_desc
#                  FROM ooefl_t WHERE ooeflent= g_enterprise  AND ooefl001 = g_stad_d[l_ac].stad013 AND ooefl002= g_dlang
#                  DISPLAY BY NAME g_stad_d[l_ac].stad013_desc
                  IF NOT cl_null(g_stad_d[l_ac].stad001) AND g_stac_m.stac000 = 'U' THEN     #只有状态为修改时才有可能带出值
                     
#                     IF (l_cmd = 'a' AND cl_null(l_stad001_t[l_ac])) #第一次新增时
#                        OR (l_cmd = 'a' AND g_stad_d[l_ac].stad001 != l_stad001_t[l_ac]) #新增状态下，编号有异动
#                        OR (l_cmd = 'u' AND cl_null(l_stad001_t[l_ac]))#第一次修改时
#                        OR (l_cmd = 'u' AND g_stad_d[l_ac].stad001 != l_stad001_t[l_ac]) #修改状态下，编号有异动
#                     THEN
                     IF (g_stad_d[l_ac].stad001 != g_stad_d_o.stad001) OR (cl_null(g_stad_d_o.stad001)) THEN   #判断费用编号是否有异动，或为第一次新增时
                        CALL astt203_stad001_init()
                        INITIALIZE g_ref_fields TO NULL
                        LET g_ref_fields[1] = g_stad_d[l_ac].stad001
                        CALL ap_ref_array2(g_ref_fields,"SELECT stae013,stae014,stae012 FROM stae_t WHERE staeent='"||g_enterprise||"' AND stae001=? ","") RETURNING g_rtn_fields
                        LET g_stad_d[l_ac].stad012 = '', g_rtn_fields[1] , ''
                        LET g_stad_d[l_ac].stad013 = '', g_rtn_fields[2] , ''
                        LET g_stad_d[l_ac].stad014 = '', g_rtn_fields[3] , ''
                        
                        IF cl_null(g_stad_d[l_ac].stad012)  THEN
                           INITIALIZE g_ref_fields TO NULL
                           LET g_ref_fields[1] = g_stad_d[l_ac].stad001
                           CALL ap_ref_array2(g_ref_fields,"SELECT stad012 FROM stad_t WHERE stadent='"||g_enterprise||"' AND stad001=? ","") RETURNING g_rtn_fields
                           LET g_stad_d[l_ac].stad012 = '', g_rtn_fields[1] , ''
                        END IF
                        
                        IF cl_null(g_stad_d[l_ac].stad013) THEN
                           INITIALIZE g_ref_fields TO NULL
                           LET g_ref_fields[1] = g_stad_d[l_ac].stad001
                           CALL ap_ref_array2(g_ref_fields,"SELECT stad013 FROM stad_t WHERE stadent='"||g_enterprise||"' AND stad001=? ","") RETURNING g_rtn_fields
                           LET g_stad_d[l_ac].stad013 = '', g_rtn_fields[1] , ''
                        END IF
                        
                        IF cl_null(g_stad_d[l_ac].stad014) THEN
                           INITIALIZE g_ref_fields TO NULL
                           LET g_ref_fields[1] = g_stad_d[l_ac].stad001
                           CALL ap_ref_array2(g_ref_fields,"SELECT stad014 FROM stad_t WHERE stadent='"||g_enterprise||"' AND stad001=? ","") RETURNING g_rtn_fields
                           LET g_stad_d[l_ac].stad014 = '', g_rtn_fields[1] , ''
                        END IF
                        
                        DISPLAY BY NAME g_stad_d[l_ac].stad012,g_stad_d[l_ac].stad013,g_stad_d[l_ac].stad014
                        
                        SELECT ooefl003 INTO g_stad_d[l_ac].stad013_desc
                        FROM ooefl_t WHERE ooeflent= g_enterprise  AND ooefl001 = g_stad_d[l_ac].stad013 AND ooefl002= g_dlang
                        DISPLAY BY NAME g_stad_d[l_ac].stad013_desc
                        
                        IF cl_null(g_stad_d[l_ac].stad013) THEN
                           LET g_stad_d[l_ac].stad013_desc = ''
                           DISPLAY BY NAME g_stad_d[l_ac].stad013_desc
                        END IF
                        
#                        LET l_stad001_t[l_ac] = g_stad_d[l_ac].stad001
                        LET g_stad_d_o.stad001 = g_stad_d[l_ac].stad001
                     END IF

                  END IF
                  
               END IF
               #160510-00010#9   add(E)
            END IF
            
            IF g_stad_d[l_ac].stad012='2' THEN
               CALL cl_set_comp_entry('stad013',TRUE)
            ELSE
               CALL cl_set_comp_entry('stad013',FALSE)
            END IF
            
            NEXT FIELD stad001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.stadl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stadl002
            #add-point:ON ACTION controlp INFIELD stadl002 name="input.c.page1.stadl002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stadl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stadl003
            #add-point:ON ACTION controlp INFIELD stadl003 name="input.c.page1.stadl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stad002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad002
            #add-point:ON ACTION controlp INFIELD stad002 name="input.c.page1.stad002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stad014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad014
            #add-point:ON ACTION controlp INFIELD stad014 name="input.c.page1.stad014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stad003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad003
            #add-point:ON ACTION controlp INFIELD stad003 name="input.c.page1.stad003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stad_d[l_ac].stad003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2058" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_stad_d[l_ac].stad003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stad_d[l_ac].stad003 TO stad003              #顯示到畫面上
            
            CALL astt203_chk_stad003()

            NEXT FIELD stad003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.stad004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad004
            #add-point:ON ACTION controlp INFIELD stad004 name="input.c.page1.stad004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stad005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad005
            #add-point:ON ACTION controlp INFIELD stad005 name="input.c.page1.stad005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stad006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad006
            #add-point:ON ACTION controlp INFIELD stad006 name="input.c.page1.stad006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stad011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad011
            #add-point:ON ACTION controlp INFIELD stad011 name="input.c.page1.stad011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stad007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad007
            #add-point:ON ACTION controlp INFIELD stad007 name="input.c.page1.stad007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stad008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad008
            #add-point:ON ACTION controlp INFIELD stad008 name="input.c.page1.stad008"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stad_d[l_ac].stad008             #給予default值
            LET g_qryparam.default2 = "" #g_stad_d[l_ac].stael003 #說明
            LET g_qryparam.default3 = "" #g_stad_d[l_ac].stae001 #費用編號

            #給予arg
            LET g_qryparam.arg1 = g_stac_m.stacdocno

            CALL q_stad001_1()                                #呼叫開窗

            LET g_stad_d[l_ac].stad008 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_stad_d[l_ac].stael003 = g_qryparam.return2 #說明
            #LET g_stad_d[l_ac].stae001 = g_qryparam.return3 #費用編號

            DISPLAY g_stad_d[l_ac].stad008 TO stad008              #顯示到畫面上
            #DISPLAY g_stad_d[l_ac].stael003 TO stael003 #說明
            #DISPLAY g_stad_d[l_ac].stae001 TO stae001 #費用編號
            
            CALL astt203_stad008_ref()

            NEXT FIELD stad008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.stad009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad009
            #add-point:ON ACTION controlp INFIELD stad009 name="input.c.page1.stad009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stad010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad010
            #add-point:ON ACTION controlp INFIELD stad010 name="input.c.page1.stad010"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stad_d[l_ac].stad010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site

            CALL q_oodb002_1()                                #呼叫開窗

            LET g_stad_d[l_ac].stad010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_stad_d[l_ac].stad010 TO stad010              #顯示到畫面上
            
            CALL astt203_chk_stad010()

            NEXT FIELD stad010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.stadacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stadacti
            #add-point:ON ACTION controlp INFIELD stadacti name="input.c.page1.stadacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stad012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad012
            #add-point:ON ACTION controlp INFIELD stad012 name="input.c.page1.stad012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stad013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad013
            #add-point:ON ACTION controlp INFIELD stad013 name="input.c.page1.stad013"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            IF g_stad_d[l_ac].stad012 = '2' THEN   #160510-00010#11 add
               LET g_qryparam.default1 = g_stad_d[l_ac].stad013             #給予default值
               LET g_qryparam.default2 = "" #g_stad_d[l_ac].ooef001 #组织编号
               #給予arg
               LET g_qryparam.arg1 = "" #s
   
               #161024-00025#2--add--s
               IF s_aooi500_setpoint(g_prog,'stad013') THEN
                  LET g_qryparam.where = s_aooi500_q_where(g_prog,'stad013',g_stac_m.stacsite,'i')
                  CALL q_ooef001_24()
               ELSE
                  CALL q_ooef001()                                #呼叫開窗
               END IF       
               #161024-00025#2--add--e
               #CALL q_ooef001()                                #呼叫開窗   #161024-00025#2 mark
    
               LET g_stad_d[l_ac].stad013 = g_qryparam.return1              
               #LET g_stad_d[l_ac].ooef001 = g_qryparam.return2 
               DISPLAY g_stad_d[l_ac].stad013 TO stad013              #
               #DISPLAY g_stad_d[l_ac].ooef001 TO ooef001 #组织编号
               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_stad_d[l_ac].stad013
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_stad_d[l_ac].stad013_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_stad_d[l_ac].stad013_desc
            END IF
            
            IF g_stad_d[l_ac].stad012 = '3' THEN
               LET g_qryparam.arg1 = "" #s
               CALL q_pmaa001_10()
    
               LET g_stad_d[l_ac].stad013 = g_qryparam.return1              
               #LET g_stad_d[l_ac].ooef001 = g_qryparam.return2 
               DISPLAY g_stad_d[l_ac].stad013 TO stad013              #
               #DISPLAY g_stad_d[l_ac].ooef001 TO ooef001 #组织编号
               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_stad_d[l_ac].stad013
               CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_stad_d[l_ac].stad013_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_stad_d[l_ac].stad013_desc
            END IF
            NEXT FIELD stad013                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.stad015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad015
            #add-point:ON ACTION controlp INFIELD stad015 name="input.c.page1.stad015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stad016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stad016
            #add-point:ON ACTION controlp INFIELD stad016 name="input.c.page1.stad016"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_stad_d[l_ac].* = g_stad_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE astt203_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_stad_d[l_ac].stadseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_stad_d[l_ac].* = g_stad_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL astt203_stad_t_mask_restore('restore_mask_o')
      
               UPDATE stad_t SET (staddocno,stadseq,stad001,stad002,stad014,stad003,stad004,stad005, 
                   stad006,stad011,stad007,stad008,stad009,stad010,stadacti,stad012,stad013,stad015, 
                   stad016) = (g_stac_m.stacdocno,g_stad_d[l_ac].stadseq,g_stad_d[l_ac].stad001,g_stad_d[l_ac].stad002, 
                   g_stad_d[l_ac].stad014,g_stad_d[l_ac].stad003,g_stad_d[l_ac].stad004,g_stad_d[l_ac].stad005, 
                   g_stad_d[l_ac].stad006,g_stad_d[l_ac].stad011,g_stad_d[l_ac].stad007,g_stad_d[l_ac].stad008, 
                   g_stad_d[l_ac].stad009,g_stad_d[l_ac].stad010,g_stad_d[l_ac].stadacti,g_stad_d[l_ac].stad012, 
                   g_stad_d[l_ac].stad013,g_stad_d[l_ac].stad015,g_stad_d[l_ac].stad016)
                WHERE stadent = g_enterprise AND staddocno = g_stac_m.stacdocno 
 
                  AND stadseq = g_stad_d_t.stadseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_stad_d[l_ac].* = g_stad_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stad_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_stad_d[l_ac].* = g_stad_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stad_t:",SQLERRMESSAGE 
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
         IF g_stac_m.stacdocno = g_detail_multi_table_t.stadldocno AND
         g_stad_d[l_ac].stadseq = g_detail_multi_table_t.stadlseq AND
         g_stad_d[l_ac].stadl002 = g_detail_multi_table_t.stadl002 AND
         g_stad_d[l_ac].stadl003 = g_detail_multi_table_t.stadl003 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'stadlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_stac_m.stacdocno
            LET l_field_keys[02] = 'stadldocno'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.stadldocno
            LET l_var_keys[03] = g_stad_d[l_ac].stadseq
            LET l_field_keys[03] = 'stadlseq'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.stadlseq
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'stadl001'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.stadl001
            LET l_vars[01] = g_stad_d[l_ac].stadl002
            LET l_fields[01] = 'stadl002'
            LET l_vars[02] = g_stad_d[l_ac].stadl003
            LET l_fields[02] = 'stadl003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'stadl_t')
         END IF 
 
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stac_m.stacdocno
               LET gs_keys_bak[1] = g_stacdocno_t
               LET gs_keys[2] = g_stad_d[g_detail_idx].stadseq
               LET gs_keys_bak[2] = g_stad_d_t.stadseq
               CALL astt203_update_b('stad_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL astt203_stad_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_stad_d[g_detail_idx].stadseq = g_stad_d_t.stadseq 
 
                  ) THEN
                  LET gs_keys[01] = g_stac_m.stacdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_stad_d_t.stadseq
 
                  CALL astt203_key_update_b(gs_keys,'stad_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_stac_m),util.JSON.stringify(g_stad_d_t)
               LET g_log2 = util.JSON.stringify(g_stac_m),util.JSON.stringify(g_stad_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL astt203_unlock_b("stad_t","'1'")
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
               LET g_stad_d[li_reproduce_target].* = g_stad_d[li_reproduce].*
 
               LET g_stad_d[li_reproduce_target].stadseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_stad_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_stad_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="astt203.input.other" >}
      
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
            NEXT FIELD stacsite
            #end add-point  
            NEXT FIELD stacdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD stadseq
 
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
 
{<section id="astt203.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION astt203_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL astt203_b_fill() #單身填充
      CALL astt203_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL astt203_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stac_m.stac001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_stac_m.stac001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stac_m.stac001_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stac_m.stac002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stac_m.stac002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stac_m.stac002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stac_m.stacownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_stac_m.stacownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stac_m.stacownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stac_m.stacowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stac_m.stacowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stac_m.stacowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stac_m.staccrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_stac_m.staccrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stac_m.staccrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stac_m.staccrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stac_m.staccrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stac_m.staccrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stac_m.stacmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_stac_m.stacmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stac_m.stacmodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stac_m.staccnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_stac_m.staccnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stac_m.staccnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_stac_m_mask_o.* =  g_stac_m.*
   CALL astt203_stac_t_mask()
   LET g_stac_m_mask_n.* =  g_stac_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_stac_m.stacsite,g_stac_m.stacsite_desc,g_stac_m.stacdocdt,g_stac_m.stacdocno,g_stac_m.stacunit, 
       g_stac_m.stac000,g_stac_m.stac001,g_stac_m.stac001_desc,g_stac_m.stac002,g_stac_m.stac002_desc, 
       g_stac_m.stacstus,g_stac_m.stacownid,g_stac_m.stacownid_desc,g_stac_m.stacowndp,g_stac_m.stacowndp_desc, 
       g_stac_m.staccrtid,g_stac_m.staccrtid_desc,g_stac_m.staccrtdp,g_stac_m.staccrtdp_desc,g_stac_m.staccrtdt, 
       g_stac_m.stacmodid,g_stac_m.stacmodid_desc,g_stac_m.stacmoddt,g_stac_m.staccnfid,g_stac_m.staccnfid_desc, 
       g_stac_m.staccnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_stac_m.stacstus 
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
   FOR l_ac = 1 TO g_stad_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      CALL astt203_chk_stad003()
      CALL astt203_chk_stad010()

   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_stac_m.stacdocno
   LET g_ref_fields[2] = g_stad_d[l_ac].stadseq
   CALL ap_ref_array2(g_ref_fields," SELECT stadl002,stadl003 FROM stadl_t WHERE stadlent = '"||g_enterprise||"' AND stadldocno = ? AND stadlseq = ? AND stadl001 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_stad_d[l_ac].stadl002 = g_rtn_fields[1] 
   LET g_stad_d[l_ac].stadl003 = g_rtn_fields[2] 
   DISPLAY BY NAME g_stad_d[l_ac].stadl002
   DISPLAY BY NAME g_stad_d[l_ac].stadl003
   
      CALL astt203_stad008_ref()
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL astt203_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astt203.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION astt203_detail_show()
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
 
{<section id="astt203.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION astt203_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE stac_t.stacdocno 
   DEFINE l_oldno     LIKE stac_t.stacdocno 
 
   DEFINE l_master    RECORD LIKE stac_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE stad_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   DEFINE l_insert      LIKE type_t.num5 #ken---add 需求單號：141208-00001 項次：17
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
   
   IF g_stac_m.stacdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_stacdocno_t = g_stac_m.stacdocno
 
    
   LET g_stac_m.stacdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_stac_m.stacownid = g_user
      LET g_stac_m.stacowndp = g_dept
      LET g_stac_m.staccrtid = g_user
      LET g_stac_m.staccrtdp = g_dept 
      LET g_stac_m.staccrtdt = cl_get_current()
      LET g_stac_m.stacmodid = g_user
      LET g_stac_m.stacmoddt = cl_get_current()
      LET g_stac_m.stacstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #ken---add---s 需求單號：141208-00001 項次：17
   CALL s_aooi500_default(g_prog,'stacsite',g_stac_m.stacsite)
      RETURNING l_insert,g_stac_m.stacsite
   IF l_insert = FALSE THEN
      RETURN
   END IF   
   #ken---add---e
   
   #dongsz--add--str---
   #預設單據的單別
   LET r_success = ''
   LET r_doctype = ''
   #CALL s_arti200_get_def_doc_type(g_site,g_prog,'1')
   CALL s_arti200_get_def_doc_type(g_stac_m.stacsite,g_prog,'1') #ken---add
        RETURNING r_success,r_doctype
   LET g_stac_m.stacdocno = r_doctype
   #dongsz--add--end---
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_stac_m.stacstus 
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
   
   
   CALL astt203_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_stac_m.* TO NULL
      INITIALIZE g_stad_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL astt203_show()
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
   CALL astt203_set_act_visible()   
   CALL astt203_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_stacdocno_t = g_stac_m.stacdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " stacent = " ||g_enterprise|| " AND",
                      " stacdocno = '", g_stac_m.stacdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL astt203_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL astt203_idx_chk()
   
   LET g_data_owner = g_stac_m.stacownid      
   LET g_data_dept  = g_stac_m.stacowndp
   
   #功能已完成,通報訊息中心
   CALL astt203_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="astt203.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION astt203_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE stad_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE astt203_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM stad_t
    WHERE stadent = g_enterprise AND staddocno = g_stacdocno_t
 
    INTO TEMP astt203_detail
 
   #將key修正為調整後   
   UPDATE astt203_detail 
      #更新key欄位
      SET staddocno = g_stac_m.stacdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO stad_t SELECT * FROM astt203_detail
   
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
   DROP TABLE astt203_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
      #應用 a38 樣板自動產生(Version:6)
   #單身多語言複製
   DROP TABLE astt203_detail_lang
   
   #add-point:單身複製前1 name="detail_reproduce.body.lang0.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE & INSERT 
   SELECT * FROM stadl_t 
    WHERE stadlent = g_enterprise AND stadldocno = g_stacdocno_t
 
     INTO TEMP astt203_detail_lang
 
   #將key修正為調整後   
   UPDATE astt203_detail_lang 
      #更新key欄位
      SET stadldocno = g_stac_m.stacdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.lang0.b_update"
   
   #end add-point   
  
   #將資料塞回原table   
   INSERT INTO stadl_t SELECT * FROM astt203_detail_lang
   
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
   DROP TABLE astt203_detail_lang
   
   #add-point:單身複製後1 name="detail_reproduce.lang0.table1.a_insert"
   
   #end add-point
 
 
 
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_stacdocno_t = g_stac_m.stacdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="astt203.delete" >}
#+ 資料刪除
PRIVATE FUNCTION astt203_delete()
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
   
   IF g_stac_m.stacdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN astt203_cl USING g_enterprise,g_stac_m.stacdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN astt203_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE astt203_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE astt203_master_referesh USING g_stac_m.stacdocno INTO g_stac_m.stacsite,g_stac_m.stacdocdt, 
       g_stac_m.stacdocno,g_stac_m.stacunit,g_stac_m.stac000,g_stac_m.stac001,g_stac_m.stac002,g_stac_m.stacstus, 
       g_stac_m.stacownid,g_stac_m.stacowndp,g_stac_m.staccrtid,g_stac_m.staccrtdp,g_stac_m.staccrtdt, 
       g_stac_m.stacmodid,g_stac_m.stacmoddt,g_stac_m.staccnfid,g_stac_m.staccnfdt,g_stac_m.stacsite_desc, 
       g_stac_m.stac001_desc,g_stac_m.stac002_desc,g_stac_m.stacownid_desc,g_stac_m.stacowndp_desc,g_stac_m.staccrtid_desc, 
       g_stac_m.staccrtdp_desc,g_stac_m.stacmodid_desc,g_stac_m.staccnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT astt203_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_stac_m_mask_o.* =  g_stac_m.*
   CALL astt203_stac_t_mask()
   LET g_stac_m_mask_n.* =  g_stac_m.*
   
   CALL astt203_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL astt203_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_stacdocno_t = g_stac_m.stacdocno
 
 
      DELETE FROM stac_t
       WHERE stacent = g_enterprise AND stacdocno = g_stac_m.stacdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_stac_m.stacdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      #ken---add---str 需求單號：141208-00001 項次：17
      IF NOT s_aooi200_del_docno(g_stac_m.stacdocno,g_stac_m.stacdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #ken---add---end
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM stad_t
       WHERE stadent = g_enterprise AND staddocno = g_stac_m.stacdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stad_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_stac_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE astt203_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_stad_d.clear() 
 
     
      CALL astt203_ui_browser_refresh()  
      #CALL astt203_ui_headershow()  
      #CALL astt203_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
         INITIALIZE l_field_keys TO NULL 
         LET l_field_keys[01] = 'stadlent'
         LET l_var_keys_bak[01] = g_enterprise
         LET l_field_keys[02] = 'stadldocno'
         LET l_var_keys_bak[02] = g_stac_m.stacdocno
         CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'stadl_t')
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL astt203_browser_fill("")
         CALL astt203_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE astt203_cl
 
   #功能已完成,通報訊息中心
   CALL astt203_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="astt203.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astt203_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_stad_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF astt203_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT stadseq,stad001,stad002,stad014,stad003,stad004,stad005,stad006, 
             stad011,stad007,stad008,stad009,stad010,stadacti,stad012,stad013,stad015,stad016 ,t1.oocql004 , 
             t2.stael003 ,t3.ooefl003 FROM stad_t",   
                     " INNER JOIN stac_t ON stacent = " ||g_enterprise|| " AND stacdocno = staddocno ",
 
                     #" LEFT JOIN stadl_t ON stadlent = "||g_enterprise||" AND stacdocno = stadldocno AND stadseq = stadlseq AND stadl001 = '",g_dlang,"'",
                     
                     " LEFT JOIN stadl_t ON stadlent = "||g_enterprise||" AND stacdocno = stadldocno AND stadseq = stadlseq AND stadl001 = '",g_dlang,"'",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='2058' AND t1.oocql002=stad003 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN stael_t t2 ON t2.staelent="||g_enterprise||" AND t2.stael001=stad008 AND t2.stael002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=stad013 AND t3.ooefl002='"||g_dlang||"' ",
 
                     " WHERE stadent=? AND staddocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY stad_t.stadseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE astt203_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR astt203_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_stac_m.stacdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_stac_m.stacdocno INTO g_stad_d[l_ac].stadseq,g_stad_d[l_ac].stad001, 
          g_stad_d[l_ac].stad002,g_stad_d[l_ac].stad014,g_stad_d[l_ac].stad003,g_stad_d[l_ac].stad004, 
          g_stad_d[l_ac].stad005,g_stad_d[l_ac].stad006,g_stad_d[l_ac].stad011,g_stad_d[l_ac].stad007, 
          g_stad_d[l_ac].stad008,g_stad_d[l_ac].stad009,g_stad_d[l_ac].stad010,g_stad_d[l_ac].stadacti, 
          g_stad_d[l_ac].stad012,g_stad_d[l_ac].stad013,g_stad_d[l_ac].stad015,g_stad_d[l_ac].stad016, 
          g_stad_d[l_ac].stad003_desc,g_stad_d[l_ac].stad008_desc,g_stad_d[l_ac].stad013_desc   #(ver:78) 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL astt203_chk_stad003()
         CALL astt203_chk_stad010()
         IF g_stad_d[l_ac].stad012 = '3' THEN
            CALL s_desc_get_trading_partner_full_desc(g_stad_d[l_ac].stad013) RETURNING g_stad_d[l_ac].stad013_desc
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
   
   CALL g_stad_d.deleteElement(g_stad_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE astt203_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_stad_d.getLength()
      LET g_stad_d_mask_o[l_ac].* =  g_stad_d[l_ac].*
      CALL astt203_stad_t_mask()
      LET g_stad_d_mask_n[l_ac].* =  g_stad_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="astt203.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION astt203_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM stad_t
       WHERE stadent = g_enterprise AND
         staddocno = ps_keys_bak[1] AND stadseq = ps_keys_bak[2]
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
         CALL g_stad_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="astt203.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION astt203_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO stad_t
                  (stadent,
                   staddocno,
                   stadseq
                   ,stad001,stad002,stad014,stad003,stad004,stad005,stad006,stad011,stad007,stad008,stad009,stad010,stadacti,stad012,stad013,stad015,stad016) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_stad_d[g_detail_idx].stad001,g_stad_d[g_detail_idx].stad002,g_stad_d[g_detail_idx].stad014, 
                       g_stad_d[g_detail_idx].stad003,g_stad_d[g_detail_idx].stad004,g_stad_d[g_detail_idx].stad005, 
                       g_stad_d[g_detail_idx].stad006,g_stad_d[g_detail_idx].stad011,g_stad_d[g_detail_idx].stad007, 
                       g_stad_d[g_detail_idx].stad008,g_stad_d[g_detail_idx].stad009,g_stad_d[g_detail_idx].stad010, 
                       g_stad_d[g_detail_idx].stadacti,g_stad_d[g_detail_idx].stad012,g_stad_d[g_detail_idx].stad013, 
                       g_stad_d[g_detail_idx].stad015,g_stad_d[g_detail_idx].stad016)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stad_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_stad_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="astt203.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION astt203_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "stad_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL astt203_stad_t_mask_restore('restore_mask_o')
               
      UPDATE stad_t 
         SET (staddocno,
              stadseq
              ,stad001,stad002,stad014,stad003,stad004,stad005,stad006,stad011,stad007,stad008,stad009,stad010,stadacti,stad012,stad013,stad015,stad016) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_stad_d[g_detail_idx].stad001,g_stad_d[g_detail_idx].stad002,g_stad_d[g_detail_idx].stad014, 
                  g_stad_d[g_detail_idx].stad003,g_stad_d[g_detail_idx].stad004,g_stad_d[g_detail_idx].stad005, 
                  g_stad_d[g_detail_idx].stad006,g_stad_d[g_detail_idx].stad011,g_stad_d[g_detail_idx].stad007, 
                  g_stad_d[g_detail_idx].stad008,g_stad_d[g_detail_idx].stad009,g_stad_d[g_detail_idx].stad010, 
                  g_stad_d[g_detail_idx].stadacti,g_stad_d[g_detail_idx].stad012,g_stad_d[g_detail_idx].stad013, 
                  g_stad_d[g_detail_idx].stad015,g_stad_d[g_detail_idx].stad016) 
         WHERE stadent = g_enterprise AND staddocno = ps_keys_bak[1] AND stadseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stad_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stad_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL astt203_stad_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      LET l_new_key[01] = g_enterprise
LET l_old_key[01] = g_enterprise
LET l_field_key[01] = 'stadlent'
LET l_new_key[02] = ps_keys[1] 
LET l_old_key[02] = ps_keys_bak[1] 
LET l_field_key[02] = 'stadldocno'
LET l_new_key[03] = ps_keys[2] 
LET l_old_key[03] = ps_keys_bak[2] 
LET l_field_key[03] = 'stadlseq'
LET l_new_key[04] = g_dlang 
LET l_old_key[04] = g_dlang 
LET l_field_key[04] = 'stadl001'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'stadl_t')
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="astt203.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION astt203_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="astt203.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION astt203_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="astt203.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION astt203_lock_b(ps_table,ps_page)
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
   #CALL astt203_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "stad_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN astt203_bcl USING g_enterprise,
                                       g_stac_m.stacdocno,g_stad_d[g_detail_idx].stadseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "astt203_bcl:",SQLERRMESSAGE 
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
 
{<section id="astt203.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION astt203_unlock_b(ps_table,ps_page)
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
      CLOSE astt203_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="astt203.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION astt203_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("stacdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("stacdocno",TRUE)
      CALL cl_set_comp_entry("stacdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("stacdocdt",TRUE)
      CALL cl_set_comp_entry("stacsite",TRUE) #ken---add
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("stac000",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="astt203.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION astt203_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("stacdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      IF NOT astt203_stad001_count() THEN
         CALL cl_set_comp_entry("stac000",FALSE)
      END IF
      IF NOT cl_null(g_stac_m.stacdocno) THEN
         CALL cl_set_comp_entry("stacdocdt",FALSE)
      END IF
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("stacdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("stacdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #ken---add---str 需求單號：141208-00001 項次：17
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("stacsite",FALSE)
      CALL cl_set_comp_entry("stacdocno",FALSE)
      CALL cl_set_comp_entry("stacdocdt",FALSE)
   END IF
   
   IF NOT s_aooi500_comp_entry(g_prog,'stacsite') OR g_site_flag THEN
      CALL cl_set_comp_entry("stacsite",FALSE)
   END IF 
   #ken---add---end
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="astt203.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION astt203_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry('stad010',TRUE)
   CALL cl_set_comp_entry('stadacti',TRUE)
   CALL cl_set_comp_entry('stad013',TRUE)    #160510-00010#9 add
   CALL cl_set_comp_entry('stad007',TRUE)    #160512-00003#2 add
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="astt203.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION astt203_set_no_entry_b(p_cmd)
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
   IF cl_null(g_stad_d[l_ac].stad009) OR g_stad_d[l_ac].stad009 = 'N' THEN
      CALL cl_set_comp_entry('stad010',FALSE)
   END IF
   IF cl_null(g_stac_m.stac000) OR g_stac_m.stac000 = 'I' THEN
      CALL cl_set_comp_entry('stadacti',FALSE)
   END IF
   #160510-00010#9 add(S)
#   IF g_stad_d[l_ac].stad012 != '2' OR cl_null(g_stad_d[l_ac].stad012) THEN
#      CALL cl_set_comp_entry('stad013',FALSE)      
#   END IF
   #160510-00010#9 add(E)
   #160512-00003#2 add(S)
   IF g_stad_d[l_ac].stad011 != 'Y' OR cl_null(g_stad_d[l_ac].stad011) THEN
      CALL cl_set_comp_entry('stad007',FALSE)      
   END IF
   #160512-00003#2 add(E)
   #160510-00010#11 add(S)    #费用归属类型为1时,关闭费用归属组织栏位
   IF g_stad_d[l_ac].stad012 = '1'  THEN
      CALL cl_set_comp_entry('stad013',FALSE)      
   END IF
   #160510-00010#11 add(E)
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="astt203.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION astt203_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="astt203.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION astt203_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_stac_m.stacstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="astt203.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION astt203_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="astt203.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION astt203_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="astt203.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION astt203_default_search()
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
      LET ls_wc = ls_wc, " stacdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "stac_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "stad_t" 
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
 
{<section id="astt203.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION astt203_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_errno     LIKE type_t.chr10
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_stac_m.stacstus != 'N' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_stac_m.stacdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN astt203_cl USING g_enterprise,g_stac_m.stacdocno
   IF STATUS THEN
      CLOSE astt203_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN astt203_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE astt203_master_referesh USING g_stac_m.stacdocno INTO g_stac_m.stacsite,g_stac_m.stacdocdt, 
       g_stac_m.stacdocno,g_stac_m.stacunit,g_stac_m.stac000,g_stac_m.stac001,g_stac_m.stac002,g_stac_m.stacstus, 
       g_stac_m.stacownid,g_stac_m.stacowndp,g_stac_m.staccrtid,g_stac_m.staccrtdp,g_stac_m.staccrtdt, 
       g_stac_m.stacmodid,g_stac_m.stacmoddt,g_stac_m.staccnfid,g_stac_m.staccnfdt,g_stac_m.stacsite_desc, 
       g_stac_m.stac001_desc,g_stac_m.stac002_desc,g_stac_m.stacownid_desc,g_stac_m.stacowndp_desc,g_stac_m.staccrtid_desc, 
       g_stac_m.staccrtdp_desc,g_stac_m.stacmodid_desc,g_stac_m.staccnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT astt203_action_chk() THEN
      CLOSE astt203_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_stac_m.stacsite,g_stac_m.stacsite_desc,g_stac_m.stacdocdt,g_stac_m.stacdocno,g_stac_m.stacunit, 
       g_stac_m.stac000,g_stac_m.stac001,g_stac_m.stac001_desc,g_stac_m.stac002,g_stac_m.stac002_desc, 
       g_stac_m.stacstus,g_stac_m.stacownid,g_stac_m.stacownid_desc,g_stac_m.stacowndp,g_stac_m.stacowndp_desc, 
       g_stac_m.staccrtid,g_stac_m.staccrtid_desc,g_stac_m.staccrtdp,g_stac_m.staccrtdp_desc,g_stac_m.staccrtdt, 
       g_stac_m.stacmodid,g_stac_m.stacmodid_desc,g_stac_m.stacmoddt,g_stac_m.staccnfid,g_stac_m.staccnfid_desc, 
       g_stac_m.staccnfdt
 
   CASE g_stac_m.stacstus
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
         CASE g_stac_m.stacstus
            
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
      
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT astt203_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE astt203_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT astt203_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE astt203_cl
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
      IF g_stac_m.stacstus = 'Y' THEN
         CALL cl_set_act_visible("unconfirmed", FALSE)
      END IF
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
      g_stac_m.stacstus = lc_state OR cl_null(lc_state) THEN
      CLOSE astt203_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   IF lc_state = 'Y' THEN
      CALL s_astt203_conf_chk(g_stac_m.stacdocno,g_stac_m.stacstus) RETURNING l_success,l_errno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = l_errno
         LET g_errparam.extend = g_stac_m.stacdocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')   #160816-00068#17 by 08209 add
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN 
            CALL s_transaction_end('N','0')   #160816-00068#17 by 08209 add
            RETURN
         ELSE
            CALL s_astt203_conf_upd(g_stac_m.stacdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')   #160816-00068#17 by 08209 add
               RETURN
            END IF
         END IF
      END IF
   END IF
   IF lc_state = 'X' THEN
      CALL s_astt203_void_chk(g_stac_m.stacdocno,g_stac_m.stacstus) RETURNING l_success,l_errno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = l_errno
         LET g_errparam.extend = g_stac_m.stacdocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')   #160816-00068#17 by 08209 add
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN 
            CALL s_transaction_end('N','0')   #160816-00068#17 by 08209 add
            RETURN
         ELSE
            CALL s_astt203_void_upd(g_stac_m.stacdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')   #160816-00068#17 by 08209 add
               RETURN
            END IF
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_stac_m.stacmodid = g_user
   LET g_stac_m.stacmoddt = cl_get_current()
   LET g_stac_m.stacstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE stac_t 
      SET (stacstus,stacmodid,stacmoddt) 
        = (g_stac_m.stacstus,g_stac_m.stacmodid,g_stac_m.stacmoddt)     
    WHERE stacent = g_enterprise AND stacdocno = g_stac_m.stacdocno
 
    
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
      EXECUTE astt203_master_referesh USING g_stac_m.stacdocno INTO g_stac_m.stacsite,g_stac_m.stacdocdt, 
          g_stac_m.stacdocno,g_stac_m.stacunit,g_stac_m.stac000,g_stac_m.stac001,g_stac_m.stac002,g_stac_m.stacstus, 
          g_stac_m.stacownid,g_stac_m.stacowndp,g_stac_m.staccrtid,g_stac_m.staccrtdp,g_stac_m.staccrtdt, 
          g_stac_m.stacmodid,g_stac_m.stacmoddt,g_stac_m.staccnfid,g_stac_m.staccnfdt,g_stac_m.stacsite_desc, 
          g_stac_m.stac001_desc,g_stac_m.stac002_desc,g_stac_m.stacownid_desc,g_stac_m.stacowndp_desc, 
          g_stac_m.staccrtid_desc,g_stac_m.staccrtdp_desc,g_stac_m.stacmodid_desc,g_stac_m.staccnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_stac_m.stacsite,g_stac_m.stacsite_desc,g_stac_m.stacdocdt,g_stac_m.stacdocno, 
          g_stac_m.stacunit,g_stac_m.stac000,g_stac_m.stac001,g_stac_m.stac001_desc,g_stac_m.stac002, 
          g_stac_m.stac002_desc,g_stac_m.stacstus,g_stac_m.stacownid,g_stac_m.stacownid_desc,g_stac_m.stacowndp, 
          g_stac_m.stacowndp_desc,g_stac_m.staccrtid,g_stac_m.staccrtid_desc,g_stac_m.staccrtdp,g_stac_m.staccrtdp_desc, 
          g_stac_m.staccrtdt,g_stac_m.stacmodid,g_stac_m.stacmodid_desc,g_stac_m.stacmoddt,g_stac_m.staccnfid, 
          g_stac_m.staccnfid_desc,g_stac_m.staccnfdt
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
 
   CLOSE astt203_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL astt203_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="astt203.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION astt203_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_stad_d.getLength() THEN
         LET g_detail_idx = g_stad_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_stad_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_stad_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="astt203.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION astt203_b_fill2(pi_idx)
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
   
   CALL astt203_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="astt203.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION astt203_fill_chk(ps_idx)
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
 
{<section id="astt203.status_show" >}
PRIVATE FUNCTION astt203_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astt203.mask_functions" >}
&include "erp/ast/astt203_mask.4gl"
 
{</section>}
 
{<section id="astt203.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION astt203_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL astt203_show()
   CALL astt203_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_stac_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_stad_d))
 
 
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
   #CALL astt203_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL astt203_ui_headershow()
   CALL astt203_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION astt203_draw_out()
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
   CALL astt203_ui_headershow()  
   CALL astt203_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="astt203.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION astt203_set_pk_array()
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
   LET g_pk_array[1].values = g_stac_m.stacdocno
   LET g_pk_array[1].column = 'stacdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="astt203.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="astt203.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION astt203_msgcentre_notify(lc_state)
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
   CALL astt203_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_stac_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="astt203.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION astt203_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="astt203.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION astt203_chk_stacdocno()
DEFINE l_oobastus   LIKE ooba_t.oobastus
DEFINE l_ooef004    LIKE ooef_t.ooef004

   INITIALIZE g_errno TO NULL
   SELECT ooef004 INTO l_ooef004
     FROM ooef_t
    WHERE ooef001 = g_site AND ooefent = g_enterprise
   IF cl_null(l_ooef004) THEN
      LET g_errno = 'art-00007' #當前登入組織設定的"單據別使用參照表"尚未設定
   ELSE
      SELECT oobastus INTO l_oobastus
        FROM ooba_t,oobl_t
       WHERE oobaent = ooblent AND ooba001 = oobl001 AND ooba002 = oobl002
         AND ooba001 = l_ooef004
         AND ooba002 = g_stac_m.stacdocno
         AND oobaent = g_enterprise
         AND oobl003 = 'astt203'
      CASE
         WHEN SQLCA.sqlcode = 100 LET g_errno = 'sub-00113' #在單據別主檔中不存在
         WHEN l_oobastus <> 'Y'   LET g_errno = 'sub-00114' #此單據別無效！
         OTHERWISE LET g_errno = SQLCA.sqlcode USING '---------'
      END CASE
   END IF
END FUNCTION
#+
PRIVATE FUNCTION astt203_chk_stac001(p_cmd)
DEFINE p_cmd        LIKE type_t.chr1
DEFINE l_ooagstus   LIKE ooag_t.ooagstus
DEFINE l_oofa011    LIKE oofa_t.oofa011

   INITIALIZE g_errno TO NULL
   SELECT ooag003,ooagstus INTO g_stac_m.stac002,l_ooagstus
     FROM ooag_t
    WHERE ooagent = g_enterprise AND ooag001 = g_stac_m.stac001
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = '' #
                               LET g_stac_m.stac002 = ''
                               DISPLAY '' TO stac001_desc
                               DISPLAY '' TO stac002_desc
      WHEN l_ooagstus <> 'Y'   LET g_errno = '' #
                               LET g_stac_m.stac002 = ''
                               DISPLAY '' TO stac001_desc
                               DISPLAY '' TO stac002_desc
      OTHERWISE LET g_errno = SQLCA.sqlcode USING '---------'
   END CASE
   IF cl_null(g_errno) OR p_cmd = 'd' THEN
      SELECT oofa011 INTO l_oofa011
        FROM oofa_t
       WHERE oofaent = g_enterprise AND oofa002 = '2' AND oofa003 = g_stac_m.stac001
      DISPLAY l_oofa011 TO stac001_desc
      IF NOT cl_null(g_stac_m.stac002) THEN
         DISPLAY BY NAME g_stac_m.stac002
         CALL astt203_chk_stac002()
      END IF
   END IF
END FUNCTION
#+
PRIVATE FUNCTION astt203_chk_stac002()
DEFINE l_ooefl003   LIKE ooefl_t.ooefl003

   SELECT ooefl003 INTO l_ooefl003
     FROM ooefl_t
    WHERE ooeflent = g_enterprise AND ooefl001 = g_stac_m.stac002 AND ooefl002 = g_dlang
   DISPLAY l_ooefl003 TO stac002_desc
END FUNCTION
#+
PRIVATE FUNCTION astt203_get_stadseq()
   SELECT MAX(stadseq) + 1 INTO g_stad_d[l_ac].stadseq
     FROM stad_t
    WHERE stadent = g_enterprise AND staddocno = g_stac_m.stacdocno
   IF cl_null(g_stad_d[l_ac].stadseq) THEN
      LET g_stad_d[l_ac].stadseq = 1
   END IF
END FUNCTION
#+
PRIVATE FUNCTION astt203_chk_stad001()
DEFINE l_cnt   LIKE type_t.num10

   INITIALIZE g_errno TO NULL
   SELECT COUNT(*) INTO l_cnt 
     FROM stae_t
    WHERE staeent = g_enterprise AND stae001 = g_stad_d[l_ac].stad001
   CASE g_stac_m.stac000
      WHEN 'I'
         IF l_cnt > 0 THEN
            LET g_errno = 'ast-00026' #作业方式为新增时(stac000='I')，费用编号不可存在于费用基本资料(stae_t)中
         ELSE
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM stad_t,stac_t
             WHERE stadent = stacent AND staddocno = stacdocno AND stadent = g_enterprise 
               AND stad001 = g_stad_d[l_ac].stad001 AND stacstus = 'N'
            IF l_cnt > 0 THEN
               LET g_errno = 'ast-00028' #费用编号不可存在于未确认的申请单(stad_t)中，请检查!
            END IF
         END IF
      WHEN 'U'
         IF l_cnt <= 0 THEN
            LET g_errno = 'ast-00027' #作业方式为更改时(stac000='U')，费用编号需存在于费用基本资料(stae_t)中
         ELSE
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM stad_t,stac_t
             WHERE stadent = stacent AND staddocno = stacdocno AND stadent = g_enterprise 
               AND stad001 = g_stad_d[l_ac].stad001 AND stacstus = 'N'
            IF l_cnt > 0 THEN
               LET g_errno = 'ast-00028' #费用编号不可存在于未确认的申请单(stad_t)中，请检查!
            END IF
         END IF
   END CASE
END FUNCTION
#+
PRIVATE FUNCTION astt203_chk_stad003()
DEFINE l_oocqstus   LIKE oocq_t.oocqstus

   INITIALIZE g_errno TO NULL
   SELECT oocqstus INTO l_oocqstus 
     FROM oocq_t
    WHERE oocqent = g_enterprise AND oocq001 = '2058' AND oocq002 = g_stad_d[l_ac].stad003
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'ast-00007' #費用總類不存在
                               LET g_stad_d[l_ac].stad003_desc = ''
      WHEN l_oocqstus <> 'Y'   LET g_errno = 'ast-00008' #費用總類已無效
                               LET g_stad_d[l_ac].stad003_desc = ''
   END CASE
   IF cl_null(g_errno) THEN
      SELECT oocql004 INTO g_stad_d[l_ac].stad003_desc
        FROM oocql_t
       WHERE oocqlent = g_enterprise AND oocql001 = '2058' AND oocql002 = g_stad_d[l_ac].stad003 AND oocql003 = g_dlang
      DISPLAY BY NAME g_stad_d[l_ac].stad003_desc
   END IF
END FUNCTION
#+
PRIVATE FUNCTION astt203_chk_stad008()
DEFINE l_staestus   LIKE stae_t.staestus
DEFINE l_stadacti   LIKE stad_t.stadacti
DEFINE l_stae_chr   LIKE type_t.chr1 #1.资料存在 2.资料不存在
DEFINE l_stad_chr   LIKE type_t.chr1 #1.资料存在 2.资料不存在

   INITIALIZE g_errno TO NULL
   SELECT staestus INTO l_staestus
     FROM stae_t
    WHERE staeent = g_enterprise AND stae001 = g_stad_d[l_ac].stad008
   IF SQLCA.sqlcode = 100 THEN 
      LET l_stae_chr = '2'
   ELSE
      LET l_stae_chr = '1'
   END IF
   SELECT stadacti INTO l_stadacti
     FROM stad_t
    WHERE stadent = g_enterprise AND staddocno = g_stac_m.stacdocno AND stad001 = g_stad_d[l_ac].stad008
   IF SQLCA.sqlcode = 100 THEN
      LET l_stad_chr = '2'
   ELSE
      LET l_stad_chr = '1'
   END IF
   CASE g_stac_m.stac000
      WHEN 'I' #新增
         CASE l_stae_chr
            WHEN '1' #存在于基本资料档(stae_t)中
               IF l_staestus <> 'Y' THEN LET g_errno = 'ast-00002' END IF #资料已无效
            WHEN '2' #不存在于基本资料档(stae_t)中
               CASE l_stad_chr
                  WHEN '1' #存在于申请档(stad_t)中
                     IF l_stadacti <> 'Y' THEN LET g_errno = 'ast-00002' END IF #资料已无效
                  WHEN '2' #不存在于申请档(stad_t)中
                     LET g_errno = 'ast-00001' #资料不存在
               END CASE
         END CASE
      WHEN 'U' #修改
         CASE l_stae_chr
            WHEN '1' #存在于基本资料档(stae_t)中
               IF l_stad_chr = '1' AND l_stadacti <> 'Y' THEN
                  LET g_errno = 'ast-00002' #资料已无效
               END IF
            WHEN '2' #不存在于基本资料档(stae_t)中
               LET g_errno = 'ast-00001' #资料不存在
         END CASE
   END CASE
END FUNCTION
#+
PRIVATE FUNCTION astt203_chk_stad010()
DEFINE l_oodcstus   LIKE oodc_t.oodcstus

   INITIALIZE g_errno TO NULL
   SELECT oodbstus INTO l_oodcstus
     FROM oodb_t,ooef_t
    WHERE oodbent = g_enterprise AND oodb001 = ooef019 AND oodb002 = g_stad_d[l_ac].stad010 AND oodb004 = '1'
      AND ooefent = g_enterprise AND ooef001 = g_site
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'ast-00009' #發票稅目不存在
                               LET g_stad_d[l_ac].stad010_desc = ''
      WHEN l_oodcstus <> 'Y'   LET g_errno = 'ast-00010' #發票稅目已無效
                               LET g_stad_d[l_ac].stad010_desc = ''
   END CASE
   IF cl_null(g_errno) THEN
      SELECT oodbl004 INTO g_stad_d[l_ac].stad010_desc
        FROM oodbl_t,ooef_t
       WHERE oodblent = g_enterprise AND oodbl001 = ooef019 
         AND oodbl002 = g_stad_d[l_ac].stad010 AND oodbl003 = g_dlang
         AND ooefent = g_enterprise AND ooef001 = g_site
      DISPLAY BY NAME g_stad_d[l_ac].stad010_desc
   END IF
END FUNCTION
#+
PRIVATE FUNCTION astt203_stad001_init()
   IF g_stac_m.stac000 = 'U' THEN
      IF NOT cl_null(g_stad_d[l_ac].stad001) THEN
         SELECT stael003,stael004 INTO g_stad_d[l_ac].stadl002,g_stad_d[l_ac].stadl003
           FROM stael_t
          WHERE staelent = g_enterprise AND stael001 = g_stad_d[l_ac].stad001 AND stael002 = g_dlang
         DISPLAY BY NAME g_stad_d[l_ac].stadl002,g_stad_d[l_ac].stadl003
         
         SELECT stae002,stae003,stae004,stae005,stae006,
                stae007,stae008,stae009,stae010,staestus,
                stae015,stae016                                                  #160516-00014#4 160604 by lori add #160604-00009#93 add by geza 20160622 stae016 
           INTO g_stad_d[l_ac].stad002 ,g_stad_d[l_ac].stad003,g_stad_d[l_ac].stad004,
                g_stad_d[l_ac].stad005 ,g_stad_d[l_ac].stad006,g_stad_d[l_ac].stad007,
                g_stad_d[l_ac].stad008 ,g_stad_d[l_ac].stad009,g_stad_d[l_ac].stad010,
                g_stad_d[l_ac].stadacti,g_stad_d[l_ac].stad015,g_stad_d[l_ac].stad016           #160516-00014#4 160604 by lori add stad015 #160604-00009#93 add by geza 20160622 stad016 
           FROM stae_t
          WHERE staeent = g_enterprise AND stae001 = g_stad_d[l_ac].stad001
      ELSE
         INITIALIZE g_stad_d[l_ac].stadl002,g_stad_d[l_ac].stadl003 TO NULL
         INITIALIZE g_stad_d[l_ac].stad002 ,g_stad_d[l_ac].stad003,g_stad_d[l_ac].stad004,
                    g_stad_d[l_ac].stad005 ,g_stad_d[l_ac].stad006,g_stad_d[l_ac].stad007,
                    g_stad_d[l_ac].stad008 ,g_stad_d[l_ac].stad009,g_stad_d[l_ac].stad010,
                    g_stad_d[l_ac].stadacti,g_stad_d[l_ac].stad015      #160516-00014#4 160604 by lori add stad015
                 TO NULL
                 
         LET g_stad_d[l_ac].stad007  = 'N'
         LET g_stad_d[l_ac].stad009  = 'N'
         LET g_stad_d[l_ac].stadacti = 'Y'
      END IF
      CALL astt203_chk_stad003()
      CALL astt203_stad008_ref()
      CALL astt203_chk_stad010()
   END IF
END FUNCTION
#+
PRIVATE FUNCTION astt203_stad008_ref()
DEFINE l_cnt   LIKE type_t.num5

   IF cl_null(g_stad_d[l_ac].stad008) THEN
      LET g_stad_d[l_ac].stad008_desc = ''
      DISPLAY BY NAME g_stad_d[l_ac].stad008_desc
      RETURN
   END IF

   IF g_stad_d[l_ac].stad008 = g_stad_d[l_ac].stad001 THEN
      LET g_stad_d[l_ac].stad008_desc = g_stad_d[l_ac].stadl002
   ELSE
      SELECT COUNT(*) INTO l_cnt
        FROM stad_t
       WHERE stadent = g_enterprise AND staddocno = g_stac_m.stacdocno AND stad001 = g_stad_d[l_ac].stad008
      IF l_cnt = 0 THEN
         SELECT stael003 INTO g_stad_d[l_ac].stad008_desc
           FROM stael_t
          WHERE staelent = g_enterprise AND stael001 = g_stad_d[l_ac].stad008 AND stael002 = g_dlang
      ELSE
         SELECT stadl002 INTO g_stad_d[l_ac].stad008_desc
           FROM stadl_t
          WHERE stadlent = g_enterprise AND stadldocno = g_stac_m.stacdocno 
            AND stadl001 = g_dlang 
            AND stadlseq IN (SELECT stadseq 
                               FROM stad_t
                              WHERE stadent = g_enterprise AND staddocno = g_stac_m.stacdocno 
                                AND stad001 = g_stad_d[l_ac].stad008)
      END IF
   END IF
END FUNCTION
#+
PRIVATE FUNCTION astt203_stad001_del()
DEFINE r_success   LIKE type_t.chr1
DEFINE l_cnt       LIKE type_t.num10

   SELECT COUNT(*) INTO l_cnt
     FROM stad_t
    WHERE stadent = g_enterprise AND staddocno = g_stac_m.stacdocno 
      AND stad008 = g_stad_d_t.stad001 AND stad001 <> g_stad_d_t.stad001
   IF l_cnt > 0 THEN
      LET r_success = 'N'
   ELSE
      LET r_success = 'Y'
   END IF
   RETURN r_success
END FUNCTION
#+
PRIVATE FUNCTION astt203_stad001_count()
DEFINE l_success    LIKE type_t.num5
DEFINE l_cnt        LIKE type_t.num5
   
   LET l_success = TRUE
   IF cl_null(g_stac_m.stacdocno) THEN
      LET l_success = TRUE
      RETURN l_success
   END IF
   SELECT COUNT(*) INTO l_cnt
     FROM stad_t
    WHERE stadent = g_enterprise AND staddocno = g_stac_m.stacdocno
   IF l_cnt > 0 THEN
      LET l_success = FALSE
      RETURN l_success
   END IF
   RETURN l_success
END FUNCTION

 
{</section>}
 
