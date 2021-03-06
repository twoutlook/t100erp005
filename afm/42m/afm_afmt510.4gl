#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2015-12-22 14:48:11), PR版次:0011(2017-01-11 18:37:08)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000064
#+ Filename...: afmt510
#+ Description: 投資確認單
#+ Creator....: 03080(2015-04-29 11:44:26)
#+ Modifier...: 02159 -SD/PR- 08729
 
{</section>}
 
{<section id="afmt510.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#150528-00006#1   150529  By Jessy    財務優化；單頭隱藏alt+s改為單頭固定
#150401-00001#13  150716  By RayHuang statechange段問題修正
#150820-00011#1   150821  By Jessy    增加列印功能(加簽核)
#151217-00011#4   151222  By sakura   明細信息頁籤增加欄位:到期日,本幣金額,出售金額;更改金額欄位抓取規則
#151130-00015#2  2015/12/22 BY Xiaozg  根据是否可以更改單據日期 設定開放單據日期修改
#160321-00016#27 2016/03/24 By Jessy   修正azzi920重複定義之錯誤訊息
#160818-00017#12 2016/08/24 By 07900  删除修改未重新判断状态码
#160822-00012#2  2016/09/07 By 08729  新舊值處理
#161006-00005#34 2016/10/28 By 08732  組織類型與職能開窗調整
#161104-00024#11 2016/11/08 By 08171  程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義(包含INSERT)
#161104-00046#21 2017/01/09 By 08729  單別預設值;資料依照單別user dept權限過濾單號
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
PRIVATE TYPE type_g_fmmg_m RECORD
       fmmg002 LIKE fmmg_t.fmmg002, 
   fmmg002_desc LIKE type_t.chr80, 
   fmmgdocdt LIKE fmmg_t.fmmgdocdt, 
   fmmg001 LIKE fmmg_t.fmmg001, 
   fmmg008 LIKE fmmg_t.fmmg008, 
   fmmg008_desc LIKE type_t.chr80, 
   l_fmmg004_desc_desc LIKE type_t.chr100, 
   l_fmmg004_desc_desc_desc LIKE type_t.chr100, 
   fmmg005 LIKE fmmg_t.fmmg005, 
   fmmgdocno LIKE fmmg_t.fmmgdocno, 
   fmmg003 LIKE fmmg_t.fmmg003, 
   fmmg003_desc LIKE type_t.chr80, 
   fmmg004 LIKE fmmg_t.fmmg004, 
   fmmg004_desc LIKE type_t.chr80, 
   fmmg009 LIKE fmmg_t.fmmg009, 
   fmmg006 LIKE fmmg_t.fmmg006, 
   fmmg006_desc LIKE type_t.chr80, 
   fmmg007 LIKE fmmg_t.fmmg007, 
   l_fmmg003_desc_desc LIKE type_t.chr500, 
   fmmgstus LIKE fmmg_t.fmmgstus, 
   l_amount1 LIKE type_t.num20_6, 
   l_amount2 LIKE type_t.num20_6, 
   l_amount3 LIKE type_t.num20_6, 
   l_price1 LIKE type_t.num20_6, 
   l_cost1 LIKE type_t.num20_6, 
   l_account1 LIKE type_t.num20_6, 
   l_account2 LIKE type_t.num20_6, 
   l_account3 LIKE type_t.num20_6, 
   l_sumall LIKE type_t.num20_6, 
   fmmgownid LIKE fmmg_t.fmmgownid, 
   fmmgownid_desc LIKE type_t.chr80, 
   fmmgowndp LIKE fmmg_t.fmmgowndp, 
   fmmgowndp_desc LIKE type_t.chr80, 
   fmmgcrtid LIKE fmmg_t.fmmgcrtid, 
   fmmgcrtid_desc LIKE type_t.chr80, 
   fmmgcrtdp LIKE fmmg_t.fmmgcrtdp, 
   fmmgcrtdp_desc LIKE type_t.chr80, 
   fmmgcrtdt LIKE fmmg_t.fmmgcrtdt, 
   fmmgmodid LIKE fmmg_t.fmmgmodid, 
   fmmgmodid_desc LIKE type_t.chr80, 
   fmmgmoddt LIKE fmmg_t.fmmgmoddt, 
   fmmgcnfid LIKE fmmg_t.fmmgcnfid, 
   fmmgcnfid_desc LIKE type_t.chr80, 
   fmmgcnfdt LIKE fmmg_t.fmmgcnfdt, 
   fmmgpstid LIKE fmmg_t.fmmgpstid, 
   fmmgpstid_desc LIKE type_t.chr80, 
   fmmgpstdt LIKE fmmg_t.fmmgpstdt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_fmmgdocno LIKE fmmg_t.fmmgdocno,
      b_fmmg001 LIKE fmmg_t.fmmg001,
      b_fmmg002 LIKE fmmg_t.fmmg002,
      b_fmmg003 LIKE fmmg_t.fmmg003,
      b_fmmg004 LIKE fmmg_t.fmmg004,
      b_fmmg005 LIKE fmmg_t.fmmg005,
      b_fmmg006 LIKE fmmg_t.fmmg006,
      b_fmmg007 LIKE fmmg_t.fmmg007,
      b_fmmg008 LIKE fmmg_t.fmmg008,
      b_fmmg009 LIKE fmmg_t.fmmg009,
      b_fmmgdocdt LIKE fmmg_t.fmmgdocdt
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaald              LIKE glaa_t.glaald    #組織所屬法人主帳套
DEFINE g_glaa                RECORD
             glaacomp        LIKE glaa_t.glaacomp,
             glaa024         LIKE glaa_t.glaa024,
             glaa026         LIKE glaa_t.glaa026
                             END RECORD
DEFINE g_memo_afmt510  DYNAMIC ARRAY OF RECORD
                       l_type     LIKE type_t.chr1,
                       l_docdt    LIKE type_t.dat,
                       l_docdt1   LIKE type_t.dat,   #151217-00011#4
                       l_docno    LIKE type_t.chr80,
                       l_amount   LIKE type_t.num20_6,
                       l_price    LIKE type_t.num20_6,
                       l_account  LIKE type_t.num20_6,
                       l_account4 LIKE type_t.num20_6,   #151217-00011#4   
                       l_account5 LIKE type_t.num20_6,   #151217-00011#4
                       l_sumcost  LIKE type_t.num20_6,
                       l_price2   LIKE type_t.num20_6
                       END RECORD
DEFINE g_rec_b2        LIKE type_t.num10
DEFINE g_user_dept_wc             STRING      #161104-00046#21
DEFINE g_user_dept_wc_q           STRING      #161104-00046#21
DEFINE g_user_slip_wc             STRING      #161104-00046#21
#end add-point
 
#模組變數(Module Variables)
DEFINE g_fmmg_m        type_g_fmmg_m  #單頭變數宣告
DEFINE g_fmmg_m_t      type_g_fmmg_m  #單頭舊值宣告(系統還原用)
DEFINE g_fmmg_m_o      type_g_fmmg_m  #單頭舊值宣告(其他用途)
DEFINE g_fmmg_m_mask_o type_g_fmmg_m  #轉換遮罩前資料
DEFINE g_fmmg_m_mask_n type_g_fmmg_m  #轉換遮罩後資料
 
   DEFINE g_fmmgdocno_t LIKE fmmg_t.fmmgdocno
 
   
 
   
 
DEFINE g_wc                  STRING                        #儲存查詢條件
DEFINE g_wc_t                STRING                        #備份查詢條件
DEFINE g_wc_filter           STRING                        #儲存過濾查詢條件
DEFINE g_wc_filter_t         STRING                        #備份過濾查詢條件
DEFINE g_sql                 STRING                        #資料撈取用SQL(含reference)
DEFINE g_forupd_sql          STRING                        #資料鎖定用SQL
DEFINE g_cnt                 LIKE type_t.num10             #指標/統計用變數
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數 
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗 
DEFINE g_rec_b               LIKE type_t.num10             #單身筆數                         
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num10             #page起始筆數
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING                        #確認前一個動作是否為新增/複製
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_error_show          LIKE type_t.num5              #是否顯示資料過多的錯誤訊息
DEFINE g_aw                  STRING                        #確定當下點擊的單身(modify_detail用)
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #cl_log_modified_record用(舊值)
DEFINE g_log2                STRING                        #cl_log_modified_record用(新值)
 
#快速搜尋用
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序模式
 
#Browser用
DEFINE g_current_idx         LIKE type_t.num10             #Browser 所在筆數(當下page)
DEFINE g_current_row         LIKE type_t.num10             #Browser 所在筆數(暫存用)
DEFINE g_current_cnt         LIKE type_t.num10             #Browser 總筆數(當下page)
DEFINE g_browser_idx         LIKE type_t.num10             #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser 總筆數(所有資料)
DEFINE g_row_index           LIKE type_t.num10             #階層樹狀用指標
DEFINE g_add_browse          STRING                        #新增填充用WC
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization" 

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afmt510.main" >}
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
   CALL cl_ap_init("afm","")
 
   #add-point:作業初始化 name="main.init"
   #161104-00046#21-----s
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_fmmg_m','','','','','','')RETURNING g_sub_success
   
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('fmmg002','','fmmgent','fmmgdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#21-----e
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT fmmg002,'',fmmgdocdt,fmmg001,fmmg008,'','','',fmmg005,fmmgdocno,fmmg003, 
       '',fmmg004,'',fmmg009,fmmg006,'',fmmg007,'',fmmgstus,'','','','','','','','','',fmmgownid,'', 
       fmmgowndp,'',fmmgcrtid,'',fmmgcrtdp,'',fmmgcrtdt,fmmgmodid,'',fmmgmoddt,fmmgcnfid,'',fmmgcnfdt, 
       fmmgpstid,'',fmmgpstdt", 
                      " FROM fmmg_t",
                      " WHERE fmmgent= ? AND fmmgdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt510_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fmmg002,t0.fmmgdocdt,t0.fmmg001,t0.fmmg008,t0.fmmg005,t0.fmmgdocno, 
       t0.fmmg003,t0.fmmg004,t0.fmmg009,t0.fmmg006,t0.fmmg007,t0.fmmgstus,t0.fmmgownid,t0.fmmgowndp, 
       t0.fmmgcrtid,t0.fmmgcrtdp,t0.fmmgcrtdt,t0.fmmgmodid,t0.fmmgmoddt,t0.fmmgcnfid,t0.fmmgcnfdt,t0.fmmgpstid, 
       t0.fmmgpstdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooag011 ,t7.ooag011", 
 
               " FROM fmmg_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.fmmgownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.fmmgowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.fmmgcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.fmmgcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.fmmgmodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.fmmgcnfid  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.fmmgpstid  ",
 
               " WHERE t0.fmmgent = " ||g_enterprise|| " AND t0.fmmgdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afmt510_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmt510 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmt510_init()   
 
      #進入選單 Menu (="N")
      CALL afmt510_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afmt510
      
   END IF 
   
   CLOSE afmt510_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afmt510.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afmt510_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('fmmgstus','13','Y,N,A,D,R,W,X')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('l_type','8868')
   CALL cl_set_combo_scc('l_fmmg003_desc_desc','8802')
   #end add-point
   
   #根據外部參數進行搜尋
   CALL afmt510_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="afmt510.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmt510_ui_dialog() 
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num10       #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10       #指標變數
   DEFINE ls_wc     STRING                  #wc用
   DEFINE la_param  RECORD                  #程式串查用變數
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING                  #轉換後的json字串
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_wc      STRING                  #150820-00011#1 報表where condition  
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 0
 
   #若有外部參數查詢, 則直接顯示資料(隱藏查詢方案)
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
            CALL afmt510_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   LET g_main_hidden = 1
   #end add-point
 
   WHILE li_exit = FALSE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_fmmg_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL afmt510_init()
      END IF
      
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
    
      #確保g_current_idx位於正常區間內
      #小於,等於0則指到第1筆
      IF g_current_idx <= 0 THEN
         LET g_current_idx = 1
      END IF
               
      IF g_main_hidden = 0 THEN
         MENU
            BEFORE MENU 
               #先填充browser資料
               CALL afmt510_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL afmt510_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL afmt510_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL afmt510_set_act_visible()
               CALL afmt510_set_act_no_visible()
               IF NOT (g_fmmg_m.fmmgdocno IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " fmmgent = " ||g_enterprise|| " AND",
                                     " fmmgdocno = '", g_fmmg_m.fmmgdocno, "' "
 
                  #填到對應位置
                  CALL afmt510_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL afmt510_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL afmt510_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL afmt510_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL afmt510_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL afmt510_fetch("L")  
               LET g_current_row = g_current_idx
            
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU 
            
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU
            
            #主頁摺疊
            ON ACTION mainhidden   
               LET g_action_choice = "mainhidden"            
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
               EXIT MENU
               
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
               END IF
               EXIT MENU
            
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
          
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL afmt510_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afmt510_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afmt510_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afmt510_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afmt510_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afmt510_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu2.output"
 
               #END add-point
               &include "erp/afm/afmt510_rep.4gl"
               #add-point:ON ACTION output.after name="menu2.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu2.quickprint"
               
               #END add-point
               &include "erp/afm/afmt510_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu2.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL afmt510_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afmt510_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt510_02
            LET g_action_choice="open_afmt510_02"
            IF cl_auth_chk_act("open_afmt510_02") THEN
               
               #add-point:ON ACTION open_afmt510_02 name="menu2.open_afmt510_02"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt510_s01
            LET g_action_choice="open_afmt510_s01"
            IF cl_auth_chk_act("open_afmt510_s01") THEN
               
               #add-point:ON ACTION open_afmt510_s01 name="menu2.open_afmt510_s01"
                  
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page1
            LET g_action_choice="touch_page1"
               
               #add-point:ON ACTION touch_page1 name="menu2.touch_page1"
               
               #END add-point
 
 
 
 
            
            #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu2.bpm_status"
            
            #END add-point
 
 
 
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afmt510_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmt510_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmt510_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.menu.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_fmmg_m.fmmgdocdt)
 
 
 
            
            #主選單用ACTION
            &include "main_menu_exit_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END MENU
      
      ELSE
      
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
           
      
            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)
            
               BEFORE ROW
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_idx = 0 THEN
                     LET g_current_idx = 1
                  END IF
                  LET g_current_row = g_current_idx  #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont()     
                  
                  #當每次點任一筆資料都會需要用到               
                  CALL afmt510_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            DISPLAY ARRAY g_memo_afmt510 TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b2)

               BEFORE ROW

            
               BEFORE DISPLAY
                  CALL afmt510_b_fill2(g_fmmg_m.fmmgdocno)   
            
            END DISPLAY
            #end add-point
 
            #查詢方案用
            SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
            SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL afmt510_browser_fill(g_wc,"")
               END IF
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #還原為原本指定筆數
               IF g_current_row > 1 THEN
                  #當刪除最後一筆資料時可能產生錯誤, 進行額外判斷
                  IF g_current_row > g_browser.getLength() THEN
                     LET g_current_row = g_browser.getLength()
                  END IF 
                  LET g_current_idx = g_current_row
                  CALL DIALOG.setCurrentRow("s_browse",g_current_idx)
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL afmt510_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               CALL gfrm_curr.ensureFieldVisible("fmmg_t.fmmg002") 
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL afmt510_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL afmt510_set_act_visible()
               CALL afmt510_set_act_no_visible()
               IF NOT (g_fmmg_m.fmmgdocno IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " fmmgent = " ||g_enterprise|| " AND",
                                     " fmmgdocno = '", g_fmmg_m.fmmgdocno, "' "
 
                  #填到對應位置
                  CALL afmt510_browser_fill(g_wc,"")
               END IF
         
            #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL afmt510_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL afmt510_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL afmt510_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL afmt510_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL afmt510_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL afmt510_fetch("L")  
               LET g_current_row = g_current_idx
         
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
         
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
    
            #主頁摺疊
            ON ACTION mainhidden 
               LET g_action_choice = "mainhidden"                
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
               #EXIT DIALOG
               
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
               END IF
               #EXIT DIALOG
         
            ON ACTION exporttoexcel
               LET g_action_choice="exporttoexcel"
               IF cl_auth_chk_act("exporttoexcel") THEN
                  #browser
                  CALL g_export_node.clear()
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
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
 
            
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL afmt510_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afmt510_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afmt510_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afmt510_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afmt510_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afmt510_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #150820-00011#1-----s
               LET l_wc = " fmmgdocno = '",g_fmmg_m.fmmgdocno,"' "
               CALL afmt510_g01(l_wc)
               #150820-00011#1-----e
               #END add-point
               &include "erp/afm/afmt510_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #150820-00011#1-----s
               LET l_wc = " fmmgdocno = '",g_fmmg_m.fmmgdocno,"' "
               CALL afmt510_g01(l_wc)
               #150820-00011#1-----e
               #END add-point
               &include "erp/afm/afmt510_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL afmt510_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afmt510_query()
               #add-point:ON ACTION query name="menu.query"
               NEXT FIELD b_fmmgdocno    #避免畫面重刷跳回第二頁簽
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt510_02
            LET g_action_choice="open_afmt510_02"
            IF cl_auth_chk_act("open_afmt510_02") THEN
               
               #add-point:ON ACTION open_afmt510_02 name="menu.open_afmt510_02"
               IF NOT cl_null(g_fmmg_m.fmmgdocno)THEN
                  CALL afmt510_02(g_fmmg_m.fmmgdocno)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt510_s01
            LET g_action_choice="open_afmt510_s01"
            IF cl_auth_chk_act("open_afmt510_s01") THEN
               
               #add-point:ON ACTION open_afmt510_s01 name="menu.open_afmt510_s01"
               IF NOT cl_null(g_fmmg_m.fmmgdocno)THEN
                  CALL s_transaction_begin()
   
                  OPEN afmt510_cl USING g_enterprise,g_fmmg_m.fmmgdocno
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN afmt510_cl:" 
                     LET g_errparam.code   = 'afm-00101'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLOSE afmt510_cl
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL afmt510_01(g_fmmg_m.fmmgdocno)
                  END IF
                  CLOSE afmt510_cl
                  CALL s_transaction_end('Y','0')
                  
                  SELECT fmmg001 INTO g_fmmg_m.fmmg001 FROM fmmg_t
                   WHERE fmmgent = g_enterprise
                     AND fmmgdocno = g_fmmg_m.fmmgdocno
                     
                  DISPLAY BY NAME g_fmmg_m.fmmg001 

               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION touch_page1
            LET g_action_choice="touch_page1"
               
               #add-point:ON ACTION touch_page1 name="menu.touch_page1"
               NEXT FIELD b_fmmgdocno     #避免畫面重刷跳回第二頁簽
               #END add-point
 
 
 
 
            
            #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afmt510_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmt510_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmt510_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_fmmg_m.fmmgdocdt)
 
 
 
 
            #主選單用ACTION
            &include "main_menu_exit_dialog.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 
      
      END IF
      
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      
      #(ver:50) ---start---
      IF li_exit THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
      #(ver:50) --- end ---
 
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="afmt510.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION afmt510_browser_fill(p_wc,ps_page_action) 
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.pre_function"
   
   #end add-point
   
   LET l_searchcol = "fmmgdocno"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM fmmg_t ",
               "  ",
               "  ",
               " WHERE fmmgent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("fmmg_t")
                
   #add-point:browser_fill段cnt_sql name="browser_fill.cnt_sql"
   
   #end add-point
                
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt
      FREE header_cnt_pre 
   END IF
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt 
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
   END IF
   
   LET g_error_show = 0
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF
   
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM
      INITIALIZE g_fmmg_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.fmmgstus,t0.fmmgdocno,t0.fmmg001,t0.fmmg002,t0.fmmg003,t0.fmmg004,t0.fmmg005, 
       t0.fmmg006,t0.fmmg007,t0.fmmg008,t0.fmmg009,t0.fmmgdocdt",
               " FROM fmmg_t t0 ",
               "  ",
               
               " WHERE t0.fmmgent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("fmmg_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"fmmg_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_fmmgdocno,g_browser[g_cnt].b_fmmg001, 
          g_browser[g_cnt].b_fmmg002,g_browser[g_cnt].b_fmmg003,g_browser[g_cnt].b_fmmg004,g_browser[g_cnt].b_fmmg005, 
          g_browser[g_cnt].b_fmmg006,g_browser[g_cnt].b_fmmg007,g_browser[g_cnt].b_fmmg008,g_browser[g_cnt].b_fmmg009, 
          g_browser[g_cnt].b_fmmgdocdt
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
         
         #遮罩相關處理
         CALL afmt510_browser_mask()
         
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
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
         IF g_cnt > g_max_rec THEN
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
   
   IF cl_null(g_browser[g_cnt].b_fmmgdocno) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_current_cnt = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   LET g_rec_b = g_browser.getLength()
   LET g_cnt = 0
   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt510.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmt510_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_fmmg_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON fmmg002,fmmgdocdt,fmmg001,fmmg008,fmmg005,fmmgdocno,fmmg003,fmmg004, 
          fmmg009,fmmg006,fmmg007,fmmgstus,fmmgownid,fmmgowndp,fmmgcrtid,fmmgcrtdp,fmmgcrtdt,fmmgmodid, 
          fmmgmoddt,fmmgcnfid,fmmgcnfdt,fmmgpstid,fmmgpstdt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<fmmgcrtdt>>----
         AFTER FIELD fmmgcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<fmmgmoddt>>----
         AFTER FIELD fmmgmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmmgcnfdt>>----
         AFTER FIELD fmmgcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmmgpstdt>>----
         AFTER FIELD fmmgpstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
      
         #一般欄位
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg002
            #add-point:BEFORE FIELD fmmg002 name="construct.b.fmmg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg002
            
            #add-point:AFTER FIELD fmmg002 name="construct.a.fmmg002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg002
            #add-point:ON ACTION controlp INFIELD fmmg002 name="construct.c.fmmg002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161006-00005#34   mark
            CALL q_ooef001_33()   #161006-00005#34   add
            DISPLAY g_qryparam.return1 TO fmmg002
            NEXT FIELD fmmg002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmgdocdt
            #add-point:BEFORE FIELD fmmgdocdt name="construct.b.fmmgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmgdocdt
            
            #add-point:AFTER FIELD fmmgdocdt name="construct.a.fmmgdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmgdocdt
            #add-point:ON ACTION controlp INFIELD fmmgdocdt name="construct.c.fmmgdocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg001
            #add-point:BEFORE FIELD fmmg001 name="construct.b.fmmg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg001
            
            #add-point:AFTER FIELD fmmg001 name="construct.a.fmmg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg001
            #add-point:ON ACTION controlp INFIELD fmmg001 name="construct.c.fmmg001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg008
            #add-point:BEFORE FIELD fmmg008 name="construct.b.fmmg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg008
            
            #add-point:AFTER FIELD fmmg008 name="construct.a.fmmg008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmg008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg008
            #add-point:ON ACTION controlp INFIELD fmmg008 name="construct.c.fmmg008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO fmmg008  #顯示到畫面上
            NEXT FIELD fmmg008
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg005
            #add-point:BEFORE FIELD fmmg005 name="construct.b.fmmg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg005
            
            #add-point:AFTER FIELD fmmg005 name="construct.a.fmmg005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg005
            #add-point:ON ACTION controlp INFIELD fmmg005 name="construct.c.fmmg005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmmg005()
            DISPLAY g_qryparam.return1 TO fmmg005
            NEXT FIELD fmmg005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmgdocno
            #add-point:BEFORE FIELD fmmgdocno name="construct.b.fmmgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmgdocno
            
            #add-point:AFTER FIELD fmmgdocno name="construct.a.fmmgdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmgdocno
            #add-point:ON ACTION controlp INFIELD fmmgdocno name="construct.c.fmmgdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161104-00046#21-----s
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_user_dept_wc_q 
            END IF
            #161104-00046#21-----e
            CALL q_fmmgdocno()
            DISPLAY g_qryparam.return1 TO fmmgdocno
            NEXT FIELD fmmgdocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg003
            #add-point:BEFORE FIELD fmmg003 name="construct.b.fmmg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg003
            
            #add-point:AFTER FIELD fmmg003 name="construct.a.fmmg003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg003
            #add-point:ON ACTION controlp INFIELD fmmg003 name="construct.c.fmmg003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmma001()
            DISPLAY g_qryparam.return1 TO fmmg003
            NEXT FIELD fmmg003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg004
            #add-point:BEFORE FIELD fmmg004 name="construct.b.fmmg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg004
            
            #add-point:AFTER FIELD fmmg004 name="construct.a.fmmg004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg004
            #add-point:ON ACTION controlp INFIELD fmmg004 name="construct.c.fmmg004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmme001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmg004  #顯示到畫面上
            NEXT FIELD fmmg004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg009
            #add-point:BEFORE FIELD fmmg009 name="construct.b.fmmg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg009
            
            #add-point:AFTER FIELD fmmg009 name="construct.a.fmmg009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg009
            #add-point:ON ACTION controlp INFIELD fmmg009 name="construct.c.fmmg009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg006
            #add-point:BEFORE FIELD fmmg006 name="construct.b.fmmg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg006
            
            #add-point:AFTER FIELD fmmg006 name="construct.a.fmmg006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg006
            #add-point:ON ACTION controlp INFIELD fmmg006 name="construct.c.fmmg006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bgaa001()
            DISPLAY g_qryparam.return1 TO fmmg006  #顯示到畫面上
            NEXT FIELD fmmg006
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg007
            #add-point:BEFORE FIELD fmmg007 name="construct.b.fmmg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg007
            
            #add-point:AFTER FIELD fmmg007 name="construct.a.fmmg007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg007
            #add-point:ON ACTION controlp INFIELD fmmg007 name="construct.c.fmmg007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmgstus
            #add-point:BEFORE FIELD fmmgstus name="construct.b.fmmgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmgstus
            
            #add-point:AFTER FIELD fmmgstus name="construct.a.fmmgstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmgstus
            #add-point:ON ACTION controlp INFIELD fmmgstus name="construct.c.fmmgstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmgownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmgownid
            #add-point:ON ACTION controlp INFIELD fmmgownid name="construct.c.fmmgownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmgownid  #顯示到畫面上
            NEXT FIELD fmmgownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmgownid
            #add-point:BEFORE FIELD fmmgownid name="construct.b.fmmgownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmgownid
            
            #add-point:AFTER FIELD fmmgownid name="construct.a.fmmgownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmgowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmgowndp
            #add-point:ON ACTION controlp INFIELD fmmgowndp name="construct.c.fmmgowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmgowndp  #顯示到畫面上
            NEXT FIELD fmmgowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmgowndp
            #add-point:BEFORE FIELD fmmgowndp name="construct.b.fmmgowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmgowndp
            
            #add-point:AFTER FIELD fmmgowndp name="construct.a.fmmgowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmgcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmgcrtid
            #add-point:ON ACTION controlp INFIELD fmmgcrtid name="construct.c.fmmgcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmgcrtid  #顯示到畫面上
            NEXT FIELD fmmgcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmgcrtid
            #add-point:BEFORE FIELD fmmgcrtid name="construct.b.fmmgcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmgcrtid
            
            #add-point:AFTER FIELD fmmgcrtid name="construct.a.fmmgcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmgcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmgcrtdp
            #add-point:ON ACTION controlp INFIELD fmmgcrtdp name="construct.c.fmmgcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmgcrtdp  #顯示到畫面上
            NEXT FIELD fmmgcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmgcrtdp
            #add-point:BEFORE FIELD fmmgcrtdp name="construct.b.fmmgcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmgcrtdp
            
            #add-point:AFTER FIELD fmmgcrtdp name="construct.a.fmmgcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmgcrtdt
            #add-point:BEFORE FIELD fmmgcrtdt name="construct.b.fmmgcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmgmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmgmodid
            #add-point:ON ACTION controlp INFIELD fmmgmodid name="construct.c.fmmgmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmgmodid  #顯示到畫面上
            NEXT FIELD fmmgmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmgmodid
            #add-point:BEFORE FIELD fmmgmodid name="construct.b.fmmgmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmgmodid
            
            #add-point:AFTER FIELD fmmgmodid name="construct.a.fmmgmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmgmoddt
            #add-point:BEFORE FIELD fmmgmoddt name="construct.b.fmmgmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmgcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmgcnfid
            #add-point:ON ACTION controlp INFIELD fmmgcnfid name="construct.c.fmmgcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmgcnfid  #顯示到畫面上
            NEXT FIELD fmmgcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmgcnfid
            #add-point:BEFORE FIELD fmmgcnfid name="construct.b.fmmgcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmgcnfid
            
            #add-point:AFTER FIELD fmmgcnfid name="construct.a.fmmgcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmgcnfdt
            #add-point:BEFORE FIELD fmmgcnfdt name="construct.b.fmmgcnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmgpstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmgpstid
            #add-point:ON ACTION controlp INFIELD fmmgpstid name="construct.c.fmmgpstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmgpstid  #顯示到畫面上
            NEXT FIELD fmmgpstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmgpstid
            #add-point:BEFORE FIELD fmmgpstid name="construct.b.fmmgpstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmgpstid
            
            #add-point:AFTER FIELD fmmgpstid name="construct.a.fmmgpstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmgpstdt
            #add-point:BEFORE FIELD fmmgpstdt name="construct.b.fmmgpstdt"
            
            #END add-point
 
 
 
           
      END CONSTRUCT
      
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point   
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
  
   #add-point:cs段after_construct name="cs.after_construct"
   #161104-00046#21-----s
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#21-----e
   #end add-point
  
END FUNCTION
 
{</section>}
 
{<section id="afmt510.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION afmt510_filter()
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
      CONSTRUCT g_wc_filter ON fmmgdocno,fmmg001,fmmg002,fmmg003,fmmg004,fmmg005,fmmg006,fmmg007,fmmg008, 
          fmmg009,fmmgdocdt
                          FROM s_browse[1].b_fmmgdocno,s_browse[1].b_fmmg001,s_browse[1].b_fmmg002,s_browse[1].b_fmmg003, 
                              s_browse[1].b_fmmg004,s_browse[1].b_fmmg005,s_browse[1].b_fmmg006,s_browse[1].b_fmmg007, 
                              s_browse[1].b_fmmg008,s_browse[1].b_fmmg009,s_browse[1].b_fmmgdocdt
 
         BEFORE CONSTRUCT
               DISPLAY afmt510_filter_parser('fmmgdocno') TO s_browse[1].b_fmmgdocno
            DISPLAY afmt510_filter_parser('fmmg001') TO s_browse[1].b_fmmg001
            DISPLAY afmt510_filter_parser('fmmg002') TO s_browse[1].b_fmmg002
            DISPLAY afmt510_filter_parser('fmmg003') TO s_browse[1].b_fmmg003
            DISPLAY afmt510_filter_parser('fmmg004') TO s_browse[1].b_fmmg004
            DISPLAY afmt510_filter_parser('fmmg005') TO s_browse[1].b_fmmg005
            DISPLAY afmt510_filter_parser('fmmg006') TO s_browse[1].b_fmmg006
            DISPLAY afmt510_filter_parser('fmmg007') TO s_browse[1].b_fmmg007
            DISPLAY afmt510_filter_parser('fmmg008') TO s_browse[1].b_fmmg008
            DISPLAY afmt510_filter_parser('fmmg009') TO s_browse[1].b_fmmg009
            DISPLAY afmt510_filter_parser('fmmgdocdt') TO s_browse[1].b_fmmgdocdt
      
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
 
      CALL afmt510_filter_show('fmmgdocno')
   CALL afmt510_filter_show('fmmg001')
   CALL afmt510_filter_show('fmmg002')
   CALL afmt510_filter_show('fmmg003')
   CALL afmt510_filter_show('fmmg004')
   CALL afmt510_filter_show('fmmg005')
   CALL afmt510_filter_show('fmmg006')
   CALL afmt510_filter_show('fmmg007')
   CALL afmt510_filter_show('fmmg008')
   CALL afmt510_filter_show('fmmg009')
   CALL afmt510_filter_show('fmmgdocdt')
 
END FUNCTION
 
{</section>}
 
{<section id="afmt510.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION afmt510_filter_parser(ps_field)
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
 
{<section id="afmt510.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION afmt510_filter_show(ps_field)
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
   LET ls_condition = afmt510_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afmt510.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afmt510_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL g_browser.clear() 
 
   #browser panel折疊
   IF g_worksheet_hidden THEN
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   
   #單頭折疊
   IF g_header_hidden THEN
      CALL gfrm_curr.setElementHidden("vb_master",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF
 
   INITIALIZE g_fmmg_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL afmt510_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afmt510_browser_fill(g_wc,"F")
      CALL afmt510_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL afmt510_browser_fill(g_wc,"F")   # 移到第一頁
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL afmt510_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="afmt510.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afmt510_fetch(p_fl)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   #根據傳入的條件決定抓取的資料
   CASE p_fl
      WHEN "F" 
         LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN "L" 
         #LET g_current_idx = g_header_cnt        
         LET g_current_idx = g_browser.getLength()    
      WHEN "/"
         #詢問要指定的筆數
         IF (NOT g_no_ask) THEN      
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT
            
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF           
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE     
   END CASE
 
   #筆數顯示
   LET g_browser_idx = g_current_idx 
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
   END IF
   
   
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength() 
   END IF
   
   # 設定browse索引
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx)
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt) 
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   #根據選定的筆數給予key欄位值
   LET g_fmmg_m.fmmgdocno = g_browser[g_current_idx].b_fmmgdocno
 
                       
   #讀取單頭所有欄位資料
   EXECUTE afmt510_master_referesh USING g_fmmg_m.fmmgdocno INTO g_fmmg_m.fmmg002,g_fmmg_m.fmmgdocdt, 
       g_fmmg_m.fmmg001,g_fmmg_m.fmmg008,g_fmmg_m.fmmg005,g_fmmg_m.fmmgdocno,g_fmmg_m.fmmg003,g_fmmg_m.fmmg004, 
       g_fmmg_m.fmmg009,g_fmmg_m.fmmg006,g_fmmg_m.fmmg007,g_fmmg_m.fmmgstus,g_fmmg_m.fmmgownid,g_fmmg_m.fmmgowndp, 
       g_fmmg_m.fmmgcrtid,g_fmmg_m.fmmgcrtdp,g_fmmg_m.fmmgcrtdt,g_fmmg_m.fmmgmodid,g_fmmg_m.fmmgmoddt, 
       g_fmmg_m.fmmgcnfid,g_fmmg_m.fmmgcnfdt,g_fmmg_m.fmmgpstid,g_fmmg_m.fmmgpstdt,g_fmmg_m.fmmgownid_desc, 
       g_fmmg_m.fmmgowndp_desc,g_fmmg_m.fmmgcrtid_desc,g_fmmg_m.fmmgcrtdp_desc,g_fmmg_m.fmmgmodid_desc, 
       g_fmmg_m.fmmgcnfid_desc,g_fmmg_m.fmmgpstid_desc
   
   #遮罩相關處理
   LET g_fmmg_m_mask_o.* =  g_fmmg_m.*
   CALL afmt510_fmmg_t_mask()
   LET g_fmmg_m_mask_n.* =  g_fmmg_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afmt510_set_act_visible()
   CALL afmt510_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL gfrm_curr.ensureFieldVisible("fmmg_t.fmmg002") 
   
 

   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_fmmg_m_t.* = g_fmmg_m.*
   LET g_fmmg_m_o.* = g_fmmg_m.*
   
   LET g_data_owner = g_fmmg_m.fmmgownid      
   LET g_data_dept  = g_fmmg_m.fmmgowndp
   
   #重新顯示
   CALL afmt510_show()
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt510.insert" >}
#+ 資料新增
PRIVATE FUNCTION afmt510_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_fmmg_m.* TO NULL             #DEFAULT 設定
   LET g_fmmgdocno_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmmg_m.fmmgownid = g_user
      LET g_fmmg_m.fmmgowndp = g_dept
      LET g_fmmg_m.fmmgcrtid = g_user
      LET g_fmmg_m.fmmgcrtdp = g_dept 
      LET g_fmmg_m.fmmgcrtdt = cl_get_current()
      LET g_fmmg_m.fmmgmodid = g_user
      LET g_fmmg_m.fmmgmoddt = cl_get_current()
      LET g_fmmg_m.fmmgstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_fmmg_m.fmmg009 = "0"
      LET g_fmmg_m.fmmg007 = "0"
      LET g_fmmg_m.l_amount1 = "0"
      LET g_fmmg_m.l_amount2 = "0"
      LET g_fmmg_m.l_amount3 = "0"
      LET g_fmmg_m.l_price1 = "0"
      LET g_fmmg_m.l_cost1 = "0"
      LET g_fmmg_m.l_account1 = "0"
      LET g_fmmg_m.l_account2 = "0"
      LET g_fmmg_m.l_account3 = "0"
      LET g_fmmg_m.l_sumall = "0"
 
 
      #add-point:單頭預設值 name="insert.default"
      LET g_fmmg_m.fmmgdocdt = g_today
      LET g_fmmg_m.fmmg001   = g_today
      LET g_fmmg_m_t.* = g_fmmg_m.*    #設定預設值後
      LET g_fmmg_m_o.* = g_fmmg_m.*    #舊值備份
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmmg_m.fmmgstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
 
 
 
     
      #資料輸入
      CALL afmt510_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_fmmg_m.* TO NULL
         CALL afmt510_show()
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afmt510_set_act_visible()
   CALL afmt510_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_fmmgdocno_t = g_fmmg_m.fmmgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmmgent = " ||g_enterprise|| " AND",
                      " fmmgdocno = '", g_fmmg_m.fmmgdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt510_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afmt510_master_referesh USING g_fmmg_m.fmmgdocno INTO g_fmmg_m.fmmg002,g_fmmg_m.fmmgdocdt, 
       g_fmmg_m.fmmg001,g_fmmg_m.fmmg008,g_fmmg_m.fmmg005,g_fmmg_m.fmmgdocno,g_fmmg_m.fmmg003,g_fmmg_m.fmmg004, 
       g_fmmg_m.fmmg009,g_fmmg_m.fmmg006,g_fmmg_m.fmmg007,g_fmmg_m.fmmgstus,g_fmmg_m.fmmgownid,g_fmmg_m.fmmgowndp, 
       g_fmmg_m.fmmgcrtid,g_fmmg_m.fmmgcrtdp,g_fmmg_m.fmmgcrtdt,g_fmmg_m.fmmgmodid,g_fmmg_m.fmmgmoddt, 
       g_fmmg_m.fmmgcnfid,g_fmmg_m.fmmgcnfdt,g_fmmg_m.fmmgpstid,g_fmmg_m.fmmgpstdt,g_fmmg_m.fmmgownid_desc, 
       g_fmmg_m.fmmgowndp_desc,g_fmmg_m.fmmgcrtid_desc,g_fmmg_m.fmmgcrtdp_desc,g_fmmg_m.fmmgmodid_desc, 
       g_fmmg_m.fmmgcnfid_desc,g_fmmg_m.fmmgpstid_desc
   
   
   #遮罩相關處理
   LET g_fmmg_m_mask_o.* =  g_fmmg_m.*
   CALL afmt510_fmmg_t_mask()
   LET g_fmmg_m_mask_n.* =  g_fmmg_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmmg_m.fmmg002,g_fmmg_m.fmmg002_desc,g_fmmg_m.fmmgdocdt,g_fmmg_m.fmmg001,g_fmmg_m.fmmg008, 
       g_fmmg_m.fmmg008_desc,g_fmmg_m.l_fmmg004_desc_desc,g_fmmg_m.l_fmmg004_desc_desc_desc,g_fmmg_m.fmmg005, 
       g_fmmg_m.fmmgdocno,g_fmmg_m.fmmg003,g_fmmg_m.fmmg003_desc,g_fmmg_m.fmmg004,g_fmmg_m.fmmg004_desc, 
       g_fmmg_m.fmmg009,g_fmmg_m.fmmg006,g_fmmg_m.fmmg006_desc,g_fmmg_m.fmmg007,g_fmmg_m.l_fmmg003_desc_desc, 
       g_fmmg_m.fmmgstus,g_fmmg_m.l_amount1,g_fmmg_m.l_amount2,g_fmmg_m.l_amount3,g_fmmg_m.l_price1, 
       g_fmmg_m.l_cost1,g_fmmg_m.l_account1,g_fmmg_m.l_account2,g_fmmg_m.l_account3,g_fmmg_m.l_sumall, 
       g_fmmg_m.fmmgownid,g_fmmg_m.fmmgownid_desc,g_fmmg_m.fmmgowndp,g_fmmg_m.fmmgowndp_desc,g_fmmg_m.fmmgcrtid, 
       g_fmmg_m.fmmgcrtid_desc,g_fmmg_m.fmmgcrtdp,g_fmmg_m.fmmgcrtdp_desc,g_fmmg_m.fmmgcrtdt,g_fmmg_m.fmmgmodid, 
       g_fmmg_m.fmmgmodid_desc,g_fmmg_m.fmmgmoddt,g_fmmg_m.fmmgcnfid,g_fmmg_m.fmmgcnfid_desc,g_fmmg_m.fmmgcnfdt, 
       g_fmmg_m.fmmgpstid,g_fmmg_m.fmmgpstid_desc,g_fmmg_m.fmmgpstdt
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_fmmg_m.fmmgownid      
   LET g_data_dept  = g_fmmg_m.fmmgowndp
 
   #功能已完成,通報訊息中心
   CALL afmt510_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afmt510.modify" >}
#+ 資料修改
PRIVATE FUNCTION afmt510_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_fmmg_m.fmmgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF 
 
   ERROR ""
  
   #備份key值
   LET g_fmmgdocno_t = g_fmmg_m.fmmgdocno
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN afmt510_cl USING g_enterprise,g_fmmg_m.fmmgdocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt510_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE afmt510_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt510_master_referesh USING g_fmmg_m.fmmgdocno INTO g_fmmg_m.fmmg002,g_fmmg_m.fmmgdocdt, 
       g_fmmg_m.fmmg001,g_fmmg_m.fmmg008,g_fmmg_m.fmmg005,g_fmmg_m.fmmgdocno,g_fmmg_m.fmmg003,g_fmmg_m.fmmg004, 
       g_fmmg_m.fmmg009,g_fmmg_m.fmmg006,g_fmmg_m.fmmg007,g_fmmg_m.fmmgstus,g_fmmg_m.fmmgownid,g_fmmg_m.fmmgowndp, 
       g_fmmg_m.fmmgcrtid,g_fmmg_m.fmmgcrtdp,g_fmmg_m.fmmgcrtdt,g_fmmg_m.fmmgmodid,g_fmmg_m.fmmgmoddt, 
       g_fmmg_m.fmmgcnfid,g_fmmg_m.fmmgcnfdt,g_fmmg_m.fmmgpstid,g_fmmg_m.fmmgpstdt,g_fmmg_m.fmmgownid_desc, 
       g_fmmg_m.fmmgowndp_desc,g_fmmg_m.fmmgcrtid_desc,g_fmmg_m.fmmgcrtdp_desc,g_fmmg_m.fmmgmodid_desc, 
       g_fmmg_m.fmmgcnfid_desc,g_fmmg_m.fmmgpstid_desc
 
   #檢查是否允許此動作
   IF NOT afmt510_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_fmmg_m_mask_o.* =  g_fmmg_m.*
   CALL afmt510_fmmg_t_mask()
   LET g_fmmg_m_mask_n.* =  g_fmmg_m.*
   
   
 
   #顯示資料
   CALL afmt510_show()
   
   WHILE TRUE
      LET g_fmmg_m.fmmgdocno = g_fmmgdocno_t
 
      
      #寫入修改者/修改日期資訊
      LET g_fmmg_m.fmmgmodid = g_user 
LET g_fmmg_m.fmmgmoddt = cl_get_current()
LET g_fmmg_m.fmmgmodid_desc = cl_get_username(g_fmmg_m.fmmgmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      IF g_fmmg_m.fmmgstus MATCHES "[DR]" THEN 
         LET g_fmmg_m.fmmgstus = "N"
      END IF
      #end add-point
 
      #資料輸入
      CALL afmt510_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_fmmg_m.* = g_fmmg_m_t.*
         CALL afmt510_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE fmmg_t SET (fmmgmodid,fmmgmoddt) = (g_fmmg_m.fmmgmodid,g_fmmg_m.fmmgmoddt)
       WHERE fmmgent = g_enterprise AND fmmgdocno = g_fmmgdocno_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afmt510_set_act_visible()
   CALL afmt510_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fmmgent = " ||g_enterprise|| " AND",
                      " fmmgdocno = '", g_fmmg_m.fmmgdocno, "' "
 
   #填到對應位置
   CALL afmt510_browser_fill(g_wc,"")
 
   CLOSE afmt510_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt510_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="afmt510.input" >}
#+ 資料輸入
PRIVATE FUNCTION afmt510_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_n             LIKE type_t.num10       #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num10       #檢查重複用  
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否  
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_i             LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num10
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_flag                 LIKE type_t.num5      #161104-00046#21
   DEFINE l_slip                 LIKE ooba_t.ooba002   #161104-00046#21
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #切換至輸入畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fmmg_m.fmmg002,g_fmmg_m.fmmg002_desc,g_fmmg_m.fmmgdocdt,g_fmmg_m.fmmg001,g_fmmg_m.fmmg008, 
       g_fmmg_m.fmmg008_desc,g_fmmg_m.l_fmmg004_desc_desc,g_fmmg_m.l_fmmg004_desc_desc_desc,g_fmmg_m.fmmg005, 
       g_fmmg_m.fmmgdocno,g_fmmg_m.fmmg003,g_fmmg_m.fmmg003_desc,g_fmmg_m.fmmg004,g_fmmg_m.fmmg004_desc, 
       g_fmmg_m.fmmg009,g_fmmg_m.fmmg006,g_fmmg_m.fmmg006_desc,g_fmmg_m.fmmg007,g_fmmg_m.l_fmmg003_desc_desc, 
       g_fmmg_m.fmmgstus,g_fmmg_m.l_amount1,g_fmmg_m.l_amount2,g_fmmg_m.l_amount3,g_fmmg_m.l_price1, 
       g_fmmg_m.l_cost1,g_fmmg_m.l_account1,g_fmmg_m.l_account2,g_fmmg_m.l_account3,g_fmmg_m.l_sumall, 
       g_fmmg_m.fmmgownid,g_fmmg_m.fmmgownid_desc,g_fmmg_m.fmmgowndp,g_fmmg_m.fmmgowndp_desc,g_fmmg_m.fmmgcrtid, 
       g_fmmg_m.fmmgcrtid_desc,g_fmmg_m.fmmgcrtdp,g_fmmg_m.fmmgcrtdp_desc,g_fmmg_m.fmmgcrtdt,g_fmmg_m.fmmgmodid, 
       g_fmmg_m.fmmgmodid_desc,g_fmmg_m.fmmgmoddt,g_fmmg_m.fmmgcnfid,g_fmmg_m.fmmgcnfid_desc,g_fmmg_m.fmmgcnfdt, 
       g_fmmg_m.fmmgpstid,g_fmmg_m.fmmgpstid_desc,g_fmmg_m.fmmgpstdt
   
   CALL cl_set_head_visible("","YES")  
   
   #a-新增,r-複製,u-修改
   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET g_qryparam.state = "i"
   
   #控制key欄位可否輸入
   CALL afmt510_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afmt510_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_fmmg_m.fmmg002,g_fmmg_m.fmmgdocdt,g_fmmg_m.fmmg001,g_fmmg_m.fmmg008,g_fmmg_m.l_fmmg004_desc_desc, 
          g_fmmg_m.l_fmmg004_desc_desc_desc,g_fmmg_m.fmmg005,g_fmmg_m.fmmgdocno,g_fmmg_m.fmmg003,g_fmmg_m.fmmg004, 
          g_fmmg_m.fmmg009,g_fmmg_m.fmmg006,g_fmmg_m.fmmg007,g_fmmg_m.l_fmmg003_desc_desc,g_fmmg_m.fmmgstus, 
          g_fmmg_m.l_amount1,g_fmmg_m.l_amount2,g_fmmg_m.l_amount3,g_fmmg_m.l_price1,g_fmmg_m.l_cost1, 
          g_fmmg_m.l_account1,g_fmmg_m.l_account2,g_fmmg_m.l_account3,g_fmmg_m.l_sumall 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前 name="input.before.input"
            
            #end add-point
   
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg002
            
            #add-point:AFTER FIELD fmmg002 name="input.a.fmmg002"
            LET g_fmmg_m.fmmg002_desc  = ' '
            DISPLAY BY NAME g_fmmg_m.fmmg002_desc 
            IF NOT cl_null(g_fmmg_m.fmmg002) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmmg_m.fmmg002  != g_fmmg_m_t.fmmg002 OR g_fmmg_m_t.fmmg002 IS NULL )) THEN #160822-00012#2 mark
               IF g_fmmg_m.fmmg002  != g_fmmg_m_o.fmmg002 OR cl_null(g_fmmg_m_o.fmmg002) THEN #160822-00012#2
                  CALL s_fin_account_center_chk(g_fmmg_m.fmmg002,'','6','')RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_fmmg_m.fmmg002  = g_fmmg_m_t.fmmg002 #160822-00012#2 mark
                     LET g_fmmg_m.fmmg002  = g_fmmg_m_o.fmmg002  #160822-00012#2
                     LET g_fmmg_m.fmmg004  = g_fmmg_m_o.fmmg004  #160822-00012#2
                     LET g_fmmg_m.fmmg002_desc = s_desc_get_department_desc(g_fmmg_m.fmmg002)
                     DISPLAY BY NAME g_fmmg_m.fmmg002_desc
                     CALL afmt510_fmmg004_desc(g_fmmg_m.fmmg002,g_fmmg_m.fmmg004)
                     NEXT FIELD CURRENT
                  END IF
                  
                  #投資組織修改 交易市場應要重新選擇
                  LET g_fmmg_m.fmmg004 = ''
                  LET g_fmmg_m.fmmg004_desc = ''
                  DISPLAY BY NAME g_fmmg_m.fmmg004,g_fmmg_m.fmmg004_desc
                  #抓組織所屬法人主帳套
                  SELECT glaald INTO g_glaald FROM glaa_t,ooef_t
                   WHERE glaaent = ooefent
                     AND glaacomp = ooef017
                     AND ooef001 = g_fmmg_m.fmmg002
                     AND ooefent = g_enterprise
                     AND glaa014 = 'Y'
                  SELECT glaacomp,glaa024,glaa026
                    INTO g_glaa.*
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald = g_glaald
               END IF
            END IF
            LET g_fmmg_m.fmmg002_desc = s_desc_get_department_desc(g_fmmg_m.fmmg002)
            DISPLAY BY NAME g_fmmg_m.fmmg002_desc
            CALL afmt510_fmmg004_desc(g_fmmg_m.fmmg002,g_fmmg_m.fmmg004)
            LET g_fmmg_m_o.* = g_fmmg_m.* #160822-00012#2
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg002
            #add-point:BEFORE FIELD fmmg002 name="input.b.fmmg002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmg002
            #add-point:ON CHANGE fmmg002 name="input.g.fmmg002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmgdocdt
            #add-point:BEFORE FIELD fmmgdocdt name="input.b.fmmgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmgdocdt
            
            #add-point:AFTER FIELD fmmgdocdt name="input.a.fmmgdocdt"
            IF NOT cl_null(g_fmmg_m.fmmgdocdt) AND NOT cl_null(g_fmmg_m.fmmg001)THEN
               IF g_fmmg_m.fmmgdocdt > g_fmmg_m.fmmg001 THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code = 'afm-00076'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_fmmg_m.fmmg001 = g_fmmg_m.fmmgdocdt
                  DISPLAY BY NAME g_fmmg_m.fmmg001
                  NEXT FIELD fmmgdocdt                  
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmgdocdt
            #add-point:ON CHANGE fmmgdocdt name="input.g.fmmgdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg001
            #add-point:BEFORE FIELD fmmg001 name="input.b.fmmg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg001
            
            #add-point:AFTER FIELD fmmg001 name="input.a.fmmg001"
            IF NOT cl_null(g_fmmg_m.fmmgdocdt) AND NOT cl_null(g_fmmg_m.fmmg001)THEN
               IF g_fmmg_m.fmmgdocdt > g_fmmg_m.fmmg001 THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code = 'afm-00076'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_fmmg_m.fmmg001 = g_fmmg_m.fmmgdocdt
                  DISPLAY BY NAME g_fmmg_m.fmmg001
                  NEXT FIELD fmmg001                 
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmg001
            #add-point:ON CHANGE fmmg001 name="input.g.fmmg001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg008
            
            #add-point:AFTER FIELD fmmg008 name="input.a.fmmg008"
            IF NOT cl_null(g_fmmg_m.fmmg008) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmmg_m.fmmg008 != g_fmmg_m_t.fmmg008  OR g_fmmg_m_t.fmmg008 IS NULL )) THEN #160822-00012#2 mark
               IF g_fmmg_m.fmmg008 != g_fmmg_m_o.fmmg008  OR cl_null(g_fmmg_m_o.fmmg008) THEN #160822-00012#2
                  CALL s_aap_ooaj001_chk(g_glaald,g_fmmg_m.fmmg008) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#27 --s add
                     LET g_errparam.replace[1] = 'aooi150'
                     LET g_errparam.replace[2] = cl_get_progname('aooi150',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi150'
                     #160321-00016#27 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_fmmg_m.fmmg008 = g_fmmg_m_t.fmmg008 #160822-00012#2 mark
                     LET g_fmmg_m.fmmg008 = g_fmmg_m_o.fmmg008  #160822-00012#2
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_fmmg_m_o.* = g_fmmg_m.*  #160822-00012#2
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg008
            #add-point:BEFORE FIELD fmmg008 name="input.b.fmmg008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmg008
            #add-point:ON CHANGE fmmg008 name="input.g.fmmg008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmg004_desc_desc
            
            #add-point:AFTER FIELD l_fmmg004_desc_desc name="input.a.l_fmmg004_desc_desc"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmg004_desc_desc
            #add-point:BEFORE FIELD l_fmmg004_desc_desc name="input.b.l_fmmg004_desc_desc"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmmg004_desc_desc
            #add-point:ON CHANGE l_fmmg004_desc_desc name="input.g.l_fmmg004_desc_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmg004_desc_desc_desc
            #add-point:BEFORE FIELD l_fmmg004_desc_desc_desc name="input.b.l_fmmg004_desc_desc_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmg004_desc_desc_desc
            
            #add-point:AFTER FIELD l_fmmg004_desc_desc_desc name="input.a.l_fmmg004_desc_desc_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmmg004_desc_desc_desc
            #add-point:ON CHANGE l_fmmg004_desc_desc_desc name="input.g.l_fmmg004_desc_desc_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg005
            #add-point:BEFORE FIELD fmmg005 name="input.b.fmmg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg005
            
            #add-point:AFTER FIELD fmmg005 name="input.a.fmmg005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmg005
            #add-point:ON CHANGE fmmg005 name="input.g.fmmg005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmgdocno
            #add-point:BEFORE FIELD fmmgdocno name="input.b.fmmgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmgdocno
            
            #add-point:AFTER FIELD fmmgdocno name="input.a.fmmgdocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF NOT cl_null(g_fmmg_m.fmmgdocno) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmmg_m.fmmgdocno != g_fmmg_m_t.fmmgdocno OR g_fmmg_m_t.fmmgdocno IS NULL )) THEN #160822-00012#2 mark
               IF g_fmmg_m.fmmgdocno != g_fmmg_m_o.fmmgdocno OR cl_null(g_fmmg_m_o.fmmgdocno) THEN #160822-00012#2
                   IF NOT s_aooi200_fin_chk_docno(g_glaald,'','',g_fmmg_m.fmmgdocno,g_fmmg_m.fmmgdocdt,g_prog) THEN
                     #LET g_fmmg_m.fmmgdocno = g_fmmg_m_t.fmmgdocno #160822-00012#2 mark
                     LET g_fmmg_m.fmmgdocno = g_fmmg_m_o.fmmgdocno #160822-00012#2
                     NEXT FIELD CURRENT
                  END IF
                  #161104-00046#21-----s
                  CALL s_control_chk_doc('1',g_fmmg_m.fmmgdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
                  IF g_sub_success AND l_flag THEN             
                  ELSE
                     LET g_fmmg_m.fmmgdocno = g_fmmg_m_o.fmmgdocno 
                     NEXT FIELD CURRENT                  
                  END IF
                  CALL s_aooi200_fin_get_slip(g_fmmg_m.fmmgdocno) RETURNING g_sub_success,l_slip
                  #刪除單別預設temptable
                  DELETE FROM s_aooi200def1
                  #以目前畫面資訊新增temp資料   #請勿調整.*
                  INSERT INTO s_aooi200def1 VALUES(g_fmmg_m.*)
                  #依單別預設取用資訊
                  CALL s_aooi200def_get('','',g_fmmg_m.fmmg002,'2',l_slip,'','',g_glaald)
                  #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
                  SELECT * INTO g_fmmg_m.* FROM s_aooi200def1
                  #161104-00046#21-----e  
               END IF
            END IF
            LET g_fmmg_m_o.* = g_fmmg_m.* #160822-00012#2
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmgdocno
            #add-point:ON CHANGE fmmgdocno name="input.g.fmmgdocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg003
            
            #add-point:AFTER FIELD fmmg003 name="input.a.fmmg003"
            LET  g_fmmg_m.fmmg003_desc = ' '
            DISPLAY BY NAME g_fmmg_m.fmmg003_desc
            IF NOT cl_null(g_fmmg_m.fmmg003) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmmg_m.fmmg003 != g_fmmg_m_t.fmmg003 OR g_fmmg_m_t.fmmg003 IS NULL )) THEN #160822-00012#2 mark
               IF g_fmmg_m.fmmg003 != g_fmmg_m_o.fmmg003 OR cl_null(g_fmmg_m_o.fmmg003) THEN #160822-00012#2
                  CALL afmt510_fmma001_chk(g_fmmg_m.fmmg003)
                     RETURNING g_sub_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                      INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = g_errno
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                     #LET g_fmmg_m.fmmg003 = g_fmmg_m_t.fmmg003 #160822-00012#2 mark
                     LET g_fmmg_m.fmmg003 = g_fmmg_m_o.fmmg003  #160822-00012#2
                     LET g_fmmg_m.fmmg003_desc = s_desc_fmma001_desc(g_fmmg_m.fmmg003)
                     DISPLAY BY NAME g_fmmg_m.fmmg003_desc
                     CALL afmt510_fmmg003_desc(g_fmmg_m.fmmg003)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_fmmg_m.fmmg003_desc = s_desc_fmma001_desc(g_fmmg_m.fmmg003)
            DISPLAY BY NAME g_fmmg_m.fmmg003_desc
            CALL afmt510_fmmg003_desc(g_fmmg_m.fmmg003)
            LET g_fmmg_m_o.* = g_fmmg_m.*   #160822-00012#2
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg003
            #add-point:BEFORE FIELD fmmg003 name="input.b.fmmg003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmg003
            #add-point:ON CHANGE fmmg003 name="input.g.fmmg003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg003_desc
            #add-point:BEFORE FIELD fmmg003_desc name="input.b.fmmg003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg003_desc
            
            #add-point:AFTER FIELD fmmg003_desc name="input.a.fmmg003_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmg003_desc
            #add-point:ON CHANGE fmmg003_desc name="input.g.fmmg003_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg004
            
            #add-point:AFTER FIELD fmmg004 name="input.a.fmmg004"
            LET g_fmmg_m.fmmg004_desc = ' '
            DISPLAY BY NAME g_fmmg_m.fmmg004_desc
            IF NOT cl_null(g_fmmg_m.fmmg004) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmmg_m.fmmg004 != g_fmmg_m_t.fmmg004 OR g_fmmg_m_t.fmmg004 IS NULL )) THEN #160822-00012#2 mark
               IF g_fmmg_m.fmmg004 != g_fmmg_m_o.fmmg004 OR cl_null(g_fmmg_m_o.fmmg004) THEN #160822-00012#2
                  CALL afmt510_fmme_fmmf_chk(g_fmmg_m.fmmg004,g_fmmg_m.fmmg002)  RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_fmmg_m.fmmg004 = g_fmmg_m_t.fmmg004 #160822-00012#2 mark
                     LET g_fmmg_m.fmmg004 = g_fmmg_m_o.fmmg004  #160822-00012#2
                     CALL s_desc_fmme001_desc(g_fmmg_m.fmmg004) RETURNING g_fmmg_m.fmmg004_desc
                     DISPLAY BY NAME g_fmmg_m.fmmg004_desc
                     CALL afmt510_fmmg004_desc(g_fmmg_m.fmmg002,g_fmmg_m.fmmg004)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_fmme001_desc(g_fmmg_m.fmmg004) RETURNING g_fmmg_m.fmmg004_desc
            DISPLAY BY NAME g_fmmg_m.fmmg004_desc
            CALL afmt510_fmmg004_desc(g_fmmg_m.fmmg002,g_fmmg_m.fmmg004)
            LET g_fmmg_m_o.* = g_fmmg_m.*  #160822-00012#2
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg004
            #add-point:BEFORE FIELD fmmg004 name="input.b.fmmg004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmg004
            #add-point:ON CHANGE fmmg004 name="input.g.fmmg004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg004_desc
            
            #add-point:AFTER FIELD fmmg004_desc name="input.a.fmmg004_desc"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg004_desc
            #add-point:BEFORE FIELD fmmg004_desc name="input.b.fmmg004_desc"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmg004_desc
            #add-point:ON CHANGE fmmg004_desc name="input.g.fmmg004_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmg_m.fmmg009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmg009
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmg009 name="input.a.fmmg009"
            IF NOT cl_null(g_fmmg_m.fmmg009) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg009
            #add-point:BEFORE FIELD fmmg009 name="input.b.fmmg009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmg009
            #add-point:ON CHANGE fmmg009 name="input.g.fmmg009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg006
            
            #add-point:AFTER FIELD fmmg006 name="input.a.fmmg006"
            CALL s_desc_get_budget_desc(g_fmmg_m.fmmg006) RETURNING g_fmmg_m.fmmg006_desc
            DISPLAY BY NAME g_fmmg_m.fmmg006
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg006
            #add-point:BEFORE FIELD fmmg006 name="input.b.fmmg006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmg006
            #add-point:ON CHANGE fmmg006 name="input.g.fmmg006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmg007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmg_m.fmmg007,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmg007
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmg007 name="input.a.fmmg007"
            IF NOT cl_null(g_fmmg_m.fmmg007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmg007
            #add-point:BEFORE FIELD fmmg007 name="input.b.fmmg007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmg007
            #add-point:ON CHANGE fmmg007 name="input.g.fmmg007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_fmmg003_desc_desc
            #add-point:BEFORE FIELD l_fmmg003_desc_desc name="input.b.l_fmmg003_desc_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_fmmg003_desc_desc
            
            #add-point:AFTER FIELD l_fmmg003_desc_desc name="input.a.l_fmmg003_desc_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_fmmg003_desc_desc
            #add-point:ON CHANGE l_fmmg003_desc_desc name="input.g.l_fmmg003_desc_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmgstus
            #add-point:BEFORE FIELD fmmgstus name="input.b.fmmgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmgstus
            
            #add-point:AFTER FIELD fmmgstus name="input.a.fmmgstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmgstus
            #add-point:ON CHANGE fmmgstus name="input.g.fmmgstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amount1
            #add-point:BEFORE FIELD l_amount1 name="input.b.l_amount1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amount1
            
            #add-point:AFTER FIELD l_amount1 name="input.a.l_amount1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amount1
            #add-point:ON CHANGE l_amount1 name="input.g.l_amount1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amount2
            #add-point:BEFORE FIELD l_amount2 name="input.b.l_amount2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amount2
            
            #add-point:AFTER FIELD l_amount2 name="input.a.l_amount2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amount2
            #add-point:ON CHANGE l_amount2 name="input.g.l_amount2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amount3
            #add-point:BEFORE FIELD l_amount3 name="input.b.l_amount3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amount3
            
            #add-point:AFTER FIELD l_amount3 name="input.a.l_amount3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amount3
            #add-point:ON CHANGE l_amount3 name="input.g.l_amount3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_price1
            #add-point:BEFORE FIELD l_price1 name="input.b.l_price1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_price1
            
            #add-point:AFTER FIELD l_price1 name="input.a.l_price1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_price1
            #add-point:ON CHANGE l_price1 name="input.g.l_price1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_cost1
            #add-point:BEFORE FIELD l_cost1 name="input.b.l_cost1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_cost1
            
            #add-point:AFTER FIELD l_cost1 name="input.a.l_cost1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_cost1
            #add-point:ON CHANGE l_cost1 name="input.g.l_cost1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_account1
            #add-point:BEFORE FIELD l_account1 name="input.b.l_account1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_account1
            
            #add-point:AFTER FIELD l_account1 name="input.a.l_account1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_account1
            #add-point:ON CHANGE l_account1 name="input.g.l_account1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_account2
            #add-point:BEFORE FIELD l_account2 name="input.b.l_account2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_account2
            
            #add-point:AFTER FIELD l_account2 name="input.a.l_account2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_account2
            #add-point:ON CHANGE l_account2 name="input.g.l_account2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_account3
            #add-point:BEFORE FIELD l_account3 name="input.b.l_account3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_account3
            
            #add-point:AFTER FIELD l_account3 name="input.a.l_account3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_account3
            #add-point:ON CHANGE l_account3 name="input.g.l_account3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_sumall
            #add-point:BEFORE FIELD l_sumall name="input.b.l_sumall"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_sumall
            
            #add-point:AFTER FIELD l_sumall name="input.a.l_sumall"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_sumall
            #add-point:ON CHANGE l_sumall name="input.g.l_sumall"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fmmg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg002
            #add-point:ON ACTION controlp INFIELD fmmg002 name="input.c.fmmg002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmg_m.fmmg002
            #LET g_qryparam.where = "ooef206='Y'"   #161006-00005#34   mark
            #CALL q_ooef001()                       #161006-00005#34   mark
            CALL q_ooef001_33()                     #161006-00005#34   add
            LET g_fmmg_m.fmmg002 = g_qryparam.return1
            LET g_fmmg_m.fmmg002_desc = s_desc_get_department_desc(g_fmmg_m.fmmg002)
            DISPLAY BY NAME g_fmmg_m.fmmg002,g_fmmg_m.fmmg002_desc
            NEXT FIELD fmmg002
            #END add-point
 
 
         #Ctrlp:input.c.fmmgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmgdocdt
            #add-point:ON ACTION controlp INFIELD fmmgdocdt name="input.c.fmmgdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg001
            #add-point:ON ACTION controlp INFIELD fmmg001 name="input.c.fmmg001"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmg008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg008
            #add-point:ON ACTION controlp INFIELD fmmg008 name="input.c.fmmg008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmg_m.fmmg008
            LET g_qryparam.arg1 = g_glaa.glaacomp
            CALL q_ooaj002_1()
            LET g_fmmg_m.fmmg008 = g_qryparam.return1
            DISPLAY BY NAME g_fmmg_m.fmmg008
            NEXT FIELD fmmg008
            #END add-point
 
 
         #Ctrlp:input.c.l_fmmg004_desc_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmg004_desc_desc
            #add-point:ON ACTION controlp INFIELD l_fmmg004_desc_desc name="input.c.l_fmmg004_desc_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_fmmg004_desc_desc_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmg004_desc_desc_desc
            #add-point:ON ACTION controlp INFIELD l_fmmg004_desc_desc_desc name="input.c.l_fmmg004_desc_desc_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg005
            #add-point:ON ACTION controlp INFIELD fmmg005 name="input.c.fmmg005"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmgdocno
            #add-point:ON ACTION controlp INFIELD fmmgdocno name="input.c.fmmgdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmg_m.fmmgdocno
            LET g_qryparam.arg1 = g_glaa.glaa024
            LET g_qryparam.arg2 = g_prog
            #161104-00046#21-----s
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF
            #161104-00046#21-----e
            CALL q_ooba002_1()
            LET g_fmmg_m.fmmgdocno = g_qryparam.return1
            DISPLAY BY NAME g_fmmg_m.fmmgdocno
            NEXT FIELD fmmgdocno
            #END add-point
 
 
         #Ctrlp:input.c.fmmg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg003
            #add-point:ON ACTION controlp INFIELD fmmg003 name="input.c.fmmg003"
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmg_m.fmmg003
            LET g_qryparam.where = "fmmastus='Y'"
            CALL q_fmma001()
            LET g_fmmg_m.fmmg003 = g_qryparam.return1
            LET g_fmmg_m.fmmg003_desc = s_desc_fmma001_desc(g_fmmg_m.fmmg003)
            DISPLAY BY NAME g_fmmg_m.fmmg003,g_fmmg_m.fmmg003_desc
            NEXT FIELD fmmg003
            #END add-point
 
 
         #Ctrlp:input.c.fmmg003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg003_desc
            #add-point:ON ACTION controlp INFIELD fmmg003_desc name="input.c.fmmg003_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg004
            #add-point:ON ACTION controlp INFIELD fmmg004 name="input.c.fmmg004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmg_m.fmmg004       #給予default值
            LET g_qryparam.where = " fmme001 IN (SELECT fmmf002 FROM fmmf_t ",
                                   "              WHERE fmmfent = ",g_enterprise," ",
                                   "                AND fmmf001 = '",g_fmmg_m.fmmg002,"') "
            CALL q_fmme001()                                #呼叫開窗
            LET g_fmmg_m.fmmg004 = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL s_desc_fmme001_desc(g_fmmg_m.fmmg004) RETURNING g_fmmg_m.fmmg004_desc
            DISPLAY BY NAME g_fmmg_m.fmmg004,g_fmmg_m.fmmg004_desc
            NEXT FIELD fmmg004
            #END add-point
 
 
         #Ctrlp:input.c.fmmg004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg004_desc
            #add-point:ON ACTION controlp INFIELD fmmg004_desc name="input.c.fmmg004_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg009
            #add-point:ON ACTION controlp INFIELD fmmg009 name="input.c.fmmg009"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg006
            #add-point:ON ACTION controlp INFIELD fmmg006 name="input.c.fmmg006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmg_m.fmmg006
            CALL q_bgaa001()
            LET g_fmmg_m.fmmg006 = g_qryparam.return1
            CALL s_desc_get_budget_desc(g_fmmg_m.fmmg006) RETURNING g_fmmg_m.fmmg006_desc
            DISPLAY BY NAME g_fmmg_m.fmmg006,g_fmmg_m.fmmg006_desc
            NEXT FIELD fmmg006
            #END add-point
 
 
         #Ctrlp:input.c.fmmg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmg007
            #add-point:ON ACTION controlp INFIELD fmmg007 name="input.c.fmmg007"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_fmmg003_desc_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_fmmg003_desc_desc
            #add-point:ON ACTION controlp INFIELD l_fmmg003_desc_desc name="input.c.l_fmmg003_desc_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmgstus
            #add-point:ON ACTION controlp INFIELD fmmgstus name="input.c.fmmgstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_amount1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amount1
            #add-point:ON ACTION controlp INFIELD l_amount1 name="input.c.l_amount1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_amount2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amount2
            #add-point:ON ACTION controlp INFIELD l_amount2 name="input.c.l_amount2"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_amount3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amount3
            #add-point:ON ACTION controlp INFIELD l_amount3 name="input.c.l_amount3"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_price1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_price1
            #add-point:ON ACTION controlp INFIELD l_price1 name="input.c.l_price1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_cost1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_cost1
            #add-point:ON ACTION controlp INFIELD l_cost1 name="input.c.l_cost1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_account1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_account1
            #add-point:ON ACTION controlp INFIELD l_account1 name="input.c.l_account1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_account2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_account2
            #add-point:ON ACTION controlp INFIELD l_account2 name="input.c.l_account2"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_account3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_account3
            #add-point:ON ACTION controlp INFIELD l_account3 name="input.c.l_account3"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_sumall
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_sumall
            #add-point:ON ACTION controlp INFIELD l_sumall name="input.c.l_sumall"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #若點選cancel則離開dialog
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
  
            IF p_cmd <> "u" THEN
               #當p_cmd不為u代表為新增/複製
               LET l_count = 1  
 
               #確定新增的資料不存在(不重複)
               SELECT COUNT(1) INTO l_count FROM fmmg_t
                WHERE fmmgent = g_enterprise AND fmmgdocno = g_fmmg_m.fmmgdocno
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  CALL s_aooi200_fin_gen_docno(g_glaald,'','',g_fmmg_m.fmmgdocno,g_fmmg_m.fmmgdocdt,g_prog)
                       RETURNING g_sub_success,g_fmmg_m.fmmgdocno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00003'
                     LET g_errparam.extend = g_fmmg_m.fmmgdocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD fmmgdocno
                  END IF
                  DISPLAY BY NAME g_fmmg_m.fmmgdocno
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO fmmg_t (fmmgent,fmmg002,fmmgdocdt,fmmg001,fmmg008,fmmg005,fmmgdocno,fmmg003, 
                      fmmg004,fmmg009,fmmg006,fmmg007,fmmgstus,fmmgownid,fmmgowndp,fmmgcrtid,fmmgcrtdp, 
                      fmmgcrtdt,fmmgmodid,fmmgmoddt,fmmgcnfid,fmmgcnfdt,fmmgpstid,fmmgpstdt)
                  VALUES (g_enterprise,g_fmmg_m.fmmg002,g_fmmg_m.fmmgdocdt,g_fmmg_m.fmmg001,g_fmmg_m.fmmg008, 
                      g_fmmg_m.fmmg005,g_fmmg_m.fmmgdocno,g_fmmg_m.fmmg003,g_fmmg_m.fmmg004,g_fmmg_m.fmmg009, 
                      g_fmmg_m.fmmg006,g_fmmg_m.fmmg007,g_fmmg_m.fmmgstus,g_fmmg_m.fmmgownid,g_fmmg_m.fmmgowndp, 
                      g_fmmg_m.fmmgcrtid,g_fmmg_m.fmmgcrtdp,g_fmmg_m.fmmgcrtdt,g_fmmg_m.fmmgmodid,g_fmmg_m.fmmgmoddt, 
                      g_fmmg_m.fmmgcnfid,g_fmmg_m.fmmgcnfdt,g_fmmg_m.fmmgpstid,g_fmmg_m.fmmgpstdt) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmmg_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                  
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmmg_m.fmmgdocno
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afmt510_fmmg_t_mask_restore('restore_mask_o')
               
               UPDATE fmmg_t SET (fmmg002,fmmgdocdt,fmmg001,fmmg008,fmmg005,fmmgdocno,fmmg003,fmmg004, 
                   fmmg009,fmmg006,fmmg007,fmmgstus,fmmgownid,fmmgowndp,fmmgcrtid,fmmgcrtdp,fmmgcrtdt, 
                   fmmgmodid,fmmgmoddt,fmmgcnfid,fmmgcnfdt,fmmgpstid,fmmgpstdt) = (g_fmmg_m.fmmg002, 
                   g_fmmg_m.fmmgdocdt,g_fmmg_m.fmmg001,g_fmmg_m.fmmg008,g_fmmg_m.fmmg005,g_fmmg_m.fmmgdocno, 
                   g_fmmg_m.fmmg003,g_fmmg_m.fmmg004,g_fmmg_m.fmmg009,g_fmmg_m.fmmg006,g_fmmg_m.fmmg007, 
                   g_fmmg_m.fmmgstus,g_fmmg_m.fmmgownid,g_fmmg_m.fmmgowndp,g_fmmg_m.fmmgcrtid,g_fmmg_m.fmmgcrtdp, 
                   g_fmmg_m.fmmgcrtdt,g_fmmg_m.fmmgmodid,g_fmmg_m.fmmgmoddt,g_fmmg_m.fmmgcnfid,g_fmmg_m.fmmgcnfdt, 
                   g_fmmg_m.fmmgpstid,g_fmmg_m.fmmgpstdt)
                WHERE fmmgent = g_enterprise AND fmmgdocno = g_fmmgdocno_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmmg_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmmg_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL afmt510_fmmg_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_fmmg_m_t)
                     LET g_log2 = util.JSON.stringify(g_fmmg_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
               
            END IF
           #controlp
      END INPUT
      
      #add-point:input段more input  name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG
         #CALL cl_err_collect_init()
         #add-point:input段before_dialog  name="input.before_dialog"
         
         #end add-point
          
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)
 
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
         
      #放棄輸入
      ON ACTION cancel
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #在dialog 右上角 (X)
      ON ACTION close 
         LET INT_FLAG = TRUE 
         EXIT DIALOG
    
      #toolbar 離開
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="afmt510.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afmt510_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE fmmg_t.fmmgdocno 
   DEFINE l_oldno     LIKE fmmg_t.fmmgdocno 
 
   DEFINE l_master    RECORD LIKE fmmg_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   #先確定key值無遺漏
   IF g_fmmg_m.fmmgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_fmmgdocno_t = g_fmmg_m.fmmgdocno
 
   
   #清空key值
   LET g_fmmg_m.fmmgdocno = ""
 
    
   CALL afmt510_set_entry("a")
   CALL afmt510_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmmg_m.fmmgownid = g_user
      LET g_fmmg_m.fmmgowndp = g_dept
      LET g_fmmg_m.fmmgcrtid = g_user
      LET g_fmmg_m.fmmgcrtdp = g_dept 
      LET g_fmmg_m.fmmgcrtdt = cl_get_current()
      LET g_fmmg_m.fmmgmodid = g_user
      LET g_fmmg_m.fmmgmoddt = cl_get_current()
      LET g_fmmg_m.fmmgstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_fmmg_m.fmmgcnfid = ''
   LET g_fmmg_m.fmmgcnfdt = ''
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmmg_m.fmmgstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
   
   
   #資料輸入
   CALL afmt510_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_fmmg_m.* TO NULL
      CALL afmt510_show()
      CALL s_transaction_end('N','0')
      LET INT_FLAG = 0
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   CALL s_transaction_begin()
   
   #add-point:單頭複製前 name="reproduce.head.b_insert"
   
   #end add-point
   
   #add-point:單頭複製中 name="reproduce.head.m_insert"
   
   #end add-point
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "fmmg_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單頭複製後 name="reproduce.head.a_insert"
   
   #end add-point
   
   CALL s_transaction_end('Y','0')
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afmt510_set_act_visible()
   CALL afmt510_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_fmmgdocno_t = g_fmmg_m.fmmgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmmgent = " ||g_enterprise|| " AND",
                      " fmmgdocno = '", g_fmmg_m.fmmgdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt510_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_fmmg_m.fmmgownid      
   LET g_data_dept  = g_fmmg_m.fmmgowndp
              
   #功能已完成,通報訊息中心
   CALL afmt510_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="afmt510.show" >}
#+ 資料顯示 
PRIVATE FUNCTION afmt510_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afmt510_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   SELECT glaald INTO g_glaald FROM glaa_t,ooef_t
    WHERE glaaent = ooefent
      AND glaacomp = ooef017
      AND ooef001 = g_fmmg_m.fmmg002
      AND ooefent = g_enterprise
      AND glaa014 = 'Y'
   SELECT glaacomp,glaa024,glaa026
     INTO g_glaa.*
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_glaald
      
   LET g_fmmg_m.fmmg002_desc = s_desc_get_department_desc(g_fmmg_m.fmmg002)
   LET g_fmmg_m.fmmg003_desc = s_desc_fmma001_desc(g_fmmg_m.fmmg003)
   CALL s_desc_fmme001_desc(g_fmmg_m.fmmg004) RETURNING g_fmmg_m.fmmg004_desc
   CALL s_desc_get_budget_desc(g_fmmg_m.fmmg006) RETURNING g_fmmg_m.fmmg006_desc
   CALL afmt510_fmmg004_desc(g_fmmg_m.fmmg002,g_fmmg_m.fmmg004)
   CALL afmt510_fmmg003_desc(g_fmmg_m.fmmg003)
   CALL afmt510_b_fill2(g_fmmg_m.fmmgdocno)
   
   
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fmmg_m.fmmg002,g_fmmg_m.fmmg002_desc,g_fmmg_m.fmmgdocdt,g_fmmg_m.fmmg001,g_fmmg_m.fmmg008, 
       g_fmmg_m.fmmg008_desc,g_fmmg_m.l_fmmg004_desc_desc,g_fmmg_m.l_fmmg004_desc_desc_desc,g_fmmg_m.fmmg005, 
       g_fmmg_m.fmmgdocno,g_fmmg_m.fmmg003,g_fmmg_m.fmmg003_desc,g_fmmg_m.fmmg004,g_fmmg_m.fmmg004_desc, 
       g_fmmg_m.fmmg009,g_fmmg_m.fmmg006,g_fmmg_m.fmmg006_desc,g_fmmg_m.fmmg007,g_fmmg_m.l_fmmg003_desc_desc, 
       g_fmmg_m.fmmgstus,g_fmmg_m.l_amount1,g_fmmg_m.l_amount2,g_fmmg_m.l_amount3,g_fmmg_m.l_price1, 
       g_fmmg_m.l_cost1,g_fmmg_m.l_account1,g_fmmg_m.l_account2,g_fmmg_m.l_account3,g_fmmg_m.l_sumall, 
       g_fmmg_m.fmmgownid,g_fmmg_m.fmmgownid_desc,g_fmmg_m.fmmgowndp,g_fmmg_m.fmmgowndp_desc,g_fmmg_m.fmmgcrtid, 
       g_fmmg_m.fmmgcrtid_desc,g_fmmg_m.fmmgcrtdp,g_fmmg_m.fmmgcrtdp_desc,g_fmmg_m.fmmgcrtdt,g_fmmg_m.fmmgmodid, 
       g_fmmg_m.fmmgmodid_desc,g_fmmg_m.fmmgmoddt,g_fmmg_m.fmmgcnfid,g_fmmg_m.fmmgcnfid_desc,g_fmmg_m.fmmgcnfdt, 
       g_fmmg_m.fmmgpstid,g_fmmg_m.fmmgpstid_desc,g_fmmg_m.fmmgpstdt
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL afmt510_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmmg_m.fmmgstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
 
 
 
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmt510.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION afmt510_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_fmmg_m.fmmgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_fmmgdocno_t = g_fmmg_m.fmmgdocno
 
   
   
 
   OPEN afmt510_cl USING g_enterprise,g_fmmg_m.fmmgdocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt510_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE afmt510_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt510_master_referesh USING g_fmmg_m.fmmgdocno INTO g_fmmg_m.fmmg002,g_fmmg_m.fmmgdocdt, 
       g_fmmg_m.fmmg001,g_fmmg_m.fmmg008,g_fmmg_m.fmmg005,g_fmmg_m.fmmgdocno,g_fmmg_m.fmmg003,g_fmmg_m.fmmg004, 
       g_fmmg_m.fmmg009,g_fmmg_m.fmmg006,g_fmmg_m.fmmg007,g_fmmg_m.fmmgstus,g_fmmg_m.fmmgownid,g_fmmg_m.fmmgowndp, 
       g_fmmg_m.fmmgcrtid,g_fmmg_m.fmmgcrtdp,g_fmmg_m.fmmgcrtdt,g_fmmg_m.fmmgmodid,g_fmmg_m.fmmgmoddt, 
       g_fmmg_m.fmmgcnfid,g_fmmg_m.fmmgcnfdt,g_fmmg_m.fmmgpstid,g_fmmg_m.fmmgpstdt,g_fmmg_m.fmmgownid_desc, 
       g_fmmg_m.fmmgowndp_desc,g_fmmg_m.fmmgcrtid_desc,g_fmmg_m.fmmgcrtdp_desc,g_fmmg_m.fmmgmodid_desc, 
       g_fmmg_m.fmmgcnfid_desc,g_fmmg_m.fmmgpstid_desc
   
   
   #檢查是否允許此動作
   IF NOT afmt510_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmmg_m_mask_o.* =  g_fmmg_m.*
   CALL afmt510_fmmg_t_mask()
   LET g_fmmg_m_mask_n.* =  g_fmmg_m.*
   
   #將最新資料顯示到畫面上
   CALL afmt510_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afmt510_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM fmmg_t 
       WHERE fmmgent = g_enterprise AND fmmgdocno = g_fmmg_m.fmmgdocno 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmmg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_fin_del_docno(g_glaald,g_fmmg_m.fmmgdocno ,g_fmmg_m.fmmgdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_fmmg_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE afmt510_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL afmt510_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL afmt510_browser_fill(g_wc,"")
         CALL afmt510_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afmt510_cl
 
   #功能已完成,通報訊息中心
   CALL afmt510_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmt510.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afmt510_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_fmmgdocno = g_fmmg_m.fmmgdocno
 
         THEN
         CALL g_browser.deleteElement(l_i)
       END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt  TO FORMONLY.h_count     #page count
  
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
  
END FUNCTION
 
{</section>}
 
{<section id="afmt510.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afmt510_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("fmmgdocno",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("fmmg002",TRUE)
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt510.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afmt510_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_success  LIKE type_t.num5     #151130-00015#2 
   DEFINE l_slip     LIKE type_t.chr10  #151130-00015#2
   DEFINE l_dfin0033  LIKE type_t.chr80 #151130-00015#2
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("fmmgdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("fmmg002",FALSE)
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #151130-00015#2 -begin -add by XZG 20151222
      IF NOT cl_null(g_fmmg_m.fmmgdocno) THEN  
            #获取单别
            CALL s_aooi200_fin_get_slip(g_fmmg_m.fmmgdocno) RETURNING l_success,l_slip
            #是否可改日期
            CALL s_fin_get_doc_para(g_glaald,g_glaa.glaacomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
            IF l_dfin0033 = "N"  THEN 
               CALL cl_set_comp_entry("fmmgdocdt",FALSE)
            ELSE 
               CALL cl_set_comp_entry("fmmgdocdt",TRUE)
            END IF          
         END IF 
      #151130-00015#2  -end 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt510.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afmt510_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,insert,modify_detail,open_afmt510_s01", TRUE)
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt510.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afmt510_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   # IF g_pmda_m.pmdastus != 'N' THEN
   IF g_fmmg_m.fmmgstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   IF g_fmmg_m.fmmgstus NOT MATCHES "[Y]" THEN   
      CALL cl_set_act_visible("open_afmt510_s01", FALSE)
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt510.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afmt510_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization" 
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="default_search.pre_function"
   
   #end add-point
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point  
   
   #根據外部參數(g_argv)組合wc
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " fmmgdocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      #若有外部參數則根據該參數組合
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
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
 
{<section id="afmt510.mask_functions" >}
&include "erp/afm/afmt510_mask.4gl"
 
{</section>}
 
{<section id="afmt510.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afmt510_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_fmmg_m.fmmgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN afmt510_cl USING g_enterprise,g_fmmg_m.fmmgdocno
   IF STATUS THEN
      CLOSE afmt510_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt510_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afmt510_master_referesh USING g_fmmg_m.fmmgdocno INTO g_fmmg_m.fmmg002,g_fmmg_m.fmmgdocdt, 
       g_fmmg_m.fmmg001,g_fmmg_m.fmmg008,g_fmmg_m.fmmg005,g_fmmg_m.fmmgdocno,g_fmmg_m.fmmg003,g_fmmg_m.fmmg004, 
       g_fmmg_m.fmmg009,g_fmmg_m.fmmg006,g_fmmg_m.fmmg007,g_fmmg_m.fmmgstus,g_fmmg_m.fmmgownid,g_fmmg_m.fmmgowndp, 
       g_fmmg_m.fmmgcrtid,g_fmmg_m.fmmgcrtdp,g_fmmg_m.fmmgcrtdt,g_fmmg_m.fmmgmodid,g_fmmg_m.fmmgmoddt, 
       g_fmmg_m.fmmgcnfid,g_fmmg_m.fmmgcnfdt,g_fmmg_m.fmmgpstid,g_fmmg_m.fmmgpstdt,g_fmmg_m.fmmgownid_desc, 
       g_fmmg_m.fmmgowndp_desc,g_fmmg_m.fmmgcrtid_desc,g_fmmg_m.fmmgcrtdp_desc,g_fmmg_m.fmmgmodid_desc, 
       g_fmmg_m.fmmgcnfid_desc,g_fmmg_m.fmmgpstid_desc
   
 
   #檢查是否允許此動作
   IF NOT afmt510_action_chk() THEN
      CLOSE afmt510_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmmg_m.fmmg002,g_fmmg_m.fmmg002_desc,g_fmmg_m.fmmgdocdt,g_fmmg_m.fmmg001,g_fmmg_m.fmmg008, 
       g_fmmg_m.fmmg008_desc,g_fmmg_m.l_fmmg004_desc_desc,g_fmmg_m.l_fmmg004_desc_desc_desc,g_fmmg_m.fmmg005, 
       g_fmmg_m.fmmgdocno,g_fmmg_m.fmmg003,g_fmmg_m.fmmg003_desc,g_fmmg_m.fmmg004,g_fmmg_m.fmmg004_desc, 
       g_fmmg_m.fmmg009,g_fmmg_m.fmmg006,g_fmmg_m.fmmg006_desc,g_fmmg_m.fmmg007,g_fmmg_m.l_fmmg003_desc_desc, 
       g_fmmg_m.fmmgstus,g_fmmg_m.l_amount1,g_fmmg_m.l_amount2,g_fmmg_m.l_amount3,g_fmmg_m.l_price1, 
       g_fmmg_m.l_cost1,g_fmmg_m.l_account1,g_fmmg_m.l_account2,g_fmmg_m.l_account3,g_fmmg_m.l_sumall, 
       g_fmmg_m.fmmgownid,g_fmmg_m.fmmgownid_desc,g_fmmg_m.fmmgowndp,g_fmmg_m.fmmgowndp_desc,g_fmmg_m.fmmgcrtid, 
       g_fmmg_m.fmmgcrtid_desc,g_fmmg_m.fmmgcrtdp,g_fmmg_m.fmmgcrtdp_desc,g_fmmg_m.fmmgcrtdt,g_fmmg_m.fmmgmodid, 
       g_fmmg_m.fmmgmodid_desc,g_fmmg_m.fmmgmoddt,g_fmmg_m.fmmgcnfid,g_fmmg_m.fmmgcnfid_desc,g_fmmg_m.fmmgcnfdt, 
       g_fmmg_m.fmmgpstid,g_fmmg_m.fmmgpstid_desc,g_fmmg_m.fmmgpstdt
 
   CASE g_fmmg_m.fmmgstus
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
         CASE g_fmmg_m.fmmgstus
            
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "N"
               HIDE OPTION "unconfirmed"
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
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_fmmg_m.fmmgstus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
 
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE) 
          
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,hold",FALSE)
         
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)

      END CASE

      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT afmt510_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt510_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT afmt510_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt510_cl
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
   IF (lc_state <> "Y" 
      AND lc_state <> "N"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_fmmg_m.fmmgstus = lc_state OR cl_null(lc_state) THEN
      CLOSE afmt510_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   IF lc_state = 'N' THEN
      CALL cl_err_collect_init()
      IF NOT s_afmt510_unconf_chk(g_fmmg_m.fmmgdocno)  THEN
         CALL s_transaction_end('N','0')      #150401-00001#13
         CALL cl_err_collect_show()
         RETURN    #一定要RETURN,避免執行後面的UPDATE狀態的程式段
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN
            CALL s_transaction_end('N','0')      #150401-00001#13
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_afmt510_unconf_upd(g_fmmg_m.fmmgdocno) THEN
               CALL s_transaction_end('N','0')   #避免transaction被卡住,所以 rollback 後 再顯示錯誤訊息
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   
   #確認
   IF lc_state = 'Y' THEN
      CALL cl_err_collect_init()
      IF NOT s_afmt510_conf_chk(g_fmmg_m.fmmgdocno)  THEN
         CALL s_transaction_end('N','0')      #150401-00001#13
         CALL cl_err_collect_show()
         RETURN    #一定要RETURN,避免執行後面的UPDATE狀態的程式段
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL s_transaction_end('N','0')      #150401-00001#13
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_afmt510_conf_upd(g_fmmg_m.fmmgdocno) THEN
               CALL s_transaction_end('N','0')   #避免transaction被卡住,所以 rollback 後 再顯示錯誤訊息
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
      CALL cl_err_collect_init()
      IF NOT s_afmt510_void_chk(g_fmmg_m.fmmgdocno)  THEN
         CALL s_transaction_end('N','0')      #150401-00001#13
         CALL cl_err_collect_show()
         RETURN    #一定要RETURN,避免執行後面的UPDATE狀態的程式段
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL s_transaction_end('N','0')      #150401-00001#13
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_afmt510_void_upd(g_fmmg_m.fmmgdocno) THEN
               CALL s_transaction_end('N','0')   #避免transaction被卡住,所以 rollback 後 再顯示錯誤訊息
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
   
   LET g_fmmg_m.fmmgmodid = g_user
   LET g_fmmg_m.fmmgmoddt = cl_get_current()
   LET g_fmmg_m.fmmgstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE fmmg_t 
      SET (fmmgstus,fmmgmodid,fmmgmoddt) 
        = (g_fmmg_m.fmmgstus,g_fmmg_m.fmmgmodid,g_fmmg_m.fmmgmoddt)     
    WHERE fmmgent = g_enterprise AND fmmgdocno = g_fmmg_m.fmmgdocno
 
    
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
      EXECUTE afmt510_master_referesh USING g_fmmg_m.fmmgdocno INTO g_fmmg_m.fmmg002,g_fmmg_m.fmmgdocdt, 
          g_fmmg_m.fmmg001,g_fmmg_m.fmmg008,g_fmmg_m.fmmg005,g_fmmg_m.fmmgdocno,g_fmmg_m.fmmg003,g_fmmg_m.fmmg004, 
          g_fmmg_m.fmmg009,g_fmmg_m.fmmg006,g_fmmg_m.fmmg007,g_fmmg_m.fmmgstus,g_fmmg_m.fmmgownid,g_fmmg_m.fmmgowndp, 
          g_fmmg_m.fmmgcrtid,g_fmmg_m.fmmgcrtdp,g_fmmg_m.fmmgcrtdt,g_fmmg_m.fmmgmodid,g_fmmg_m.fmmgmoddt, 
          g_fmmg_m.fmmgcnfid,g_fmmg_m.fmmgcnfdt,g_fmmg_m.fmmgpstid,g_fmmg_m.fmmgpstdt,g_fmmg_m.fmmgownid_desc, 
          g_fmmg_m.fmmgowndp_desc,g_fmmg_m.fmmgcrtid_desc,g_fmmg_m.fmmgcrtdp_desc,g_fmmg_m.fmmgmodid_desc, 
          g_fmmg_m.fmmgcnfid_desc,g_fmmg_m.fmmgpstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_fmmg_m.fmmg002,g_fmmg_m.fmmg002_desc,g_fmmg_m.fmmgdocdt,g_fmmg_m.fmmg001,g_fmmg_m.fmmg008, 
          g_fmmg_m.fmmg008_desc,g_fmmg_m.l_fmmg004_desc_desc,g_fmmg_m.l_fmmg004_desc_desc_desc,g_fmmg_m.fmmg005, 
          g_fmmg_m.fmmgdocno,g_fmmg_m.fmmg003,g_fmmg_m.fmmg003_desc,g_fmmg_m.fmmg004,g_fmmg_m.fmmg004_desc, 
          g_fmmg_m.fmmg009,g_fmmg_m.fmmg006,g_fmmg_m.fmmg006_desc,g_fmmg_m.fmmg007,g_fmmg_m.l_fmmg003_desc_desc, 
          g_fmmg_m.fmmgstus,g_fmmg_m.l_amount1,g_fmmg_m.l_amount2,g_fmmg_m.l_amount3,g_fmmg_m.l_price1, 
          g_fmmg_m.l_cost1,g_fmmg_m.l_account1,g_fmmg_m.l_account2,g_fmmg_m.l_account3,g_fmmg_m.l_sumall, 
          g_fmmg_m.fmmgownid,g_fmmg_m.fmmgownid_desc,g_fmmg_m.fmmgowndp,g_fmmg_m.fmmgowndp_desc,g_fmmg_m.fmmgcrtid, 
          g_fmmg_m.fmmgcrtid_desc,g_fmmg_m.fmmgcrtdp,g_fmmg_m.fmmgcrtdp_desc,g_fmmg_m.fmmgcrtdt,g_fmmg_m.fmmgmodid, 
          g_fmmg_m.fmmgmodid_desc,g_fmmg_m.fmmgmoddt,g_fmmg_m.fmmgcnfid,g_fmmg_m.fmmgcnfid_desc,g_fmmg_m.fmmgcnfdt, 
          g_fmmg_m.fmmgpstid,g_fmmg_m.fmmgpstid_desc,g_fmmg_m.fmmgpstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE afmt510_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt510_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt510.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION afmt510_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
 
 
   CALL afmt510_show()
   CALL afmt510_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #151013-00016#11 151106 by sakura add(S)
   IF NOT s_afmt510_unconf_chk(g_fmmg_m.fmmgdocno) THEN
      CLOSE afmt510_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #151013-00016#11 151106 by sakura add(E)
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_fmmg_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
 
 
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
   #CALL afmt510_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION afmt510_draw_out()
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
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="afmt510.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afmt510_set_pk_array()
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
   LET g_pk_array[1].values = g_fmmg_m.fmmgdocno
   LET g_pk_array[1].column = 'fmmgdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt510.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="afmt510.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afmt510_msgcentre_notify(lc_state)
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
   CALL afmt510_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fmmg_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt510.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afmt510_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#12 2016/08/24 By 07900 --add--s--
   SELECT fmmgstus INTO g_fmmg_m.fmmgstus
     FROM fmmg_t
    WHERE fmmgent = g_enterprise
      AND fmmgdocno = g_fmmg_m.fmmgdocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_fmmg_m.fmmgstus
        
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
        LET g_errparam.extend = g_fmmg_m.fmmgdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL afmt510_set_act_visible()
        CALL afmt510_set_act_no_visible()
        CALL afmt510_show()
        RETURN FALSE
     END IF
   END IF
   
   #160818-00017#12 2016/08/24 By 07900 --add--e--
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt510.other_function" readonly="Y" >}

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
PRIVATE FUNCTION afmt510_b_fill2(p_docno)
   DEFINE p_docno   LIKE fmmg_t.fmmgdocno
   DEFINE l_sql     STRING
   DEFINE l_idx     LIKE type_t.num10
   
   #151217-00011#4 add fmmj021,fmmj028,0
   LET l_sql = "SELECT 1,fmmjdocdt,fmmj021,fmmjdocno,fmmj005,fmmj007,fmmj008,COALESCE(fmmj028,0),0,COALESCE(fmmk005,0),0 ",
               "  FROM fmmj_t ",
               "       LEFT OUTER JOIN(",
               "       SELECT fmmkent,fmmk001,SUM(fmmk005) fmmk005 ",
               "         FROM fmmk_t ",
               "        GROUP BY fmmkent,fmmk001 ",
               "       ) ON fmmkent = fmmkent AND fmmk001 = fmmjdocno ",
               " WHERE fmmjent = ",g_enterprise," ",
               "   AND fmmj001 = '",p_docno,"' "
   PREPARE sel_fmmjp1 FROM l_sql
   DECLARE sel_fmmjc1 CURSOR FOR sel_fmmjp1

  #LET l_sql="SELECT 2,fmmydocdt,fmmydocno,fmmy003,fmmy004,fmmy005,COALESCE(fmmz003,0),fmmj007 ",  #151217-00011#4
   LET l_sql="SELECT 2,fmmydocdt,fmmydocdt,fmmydocno,fmmy003,fmmy004,COALESCE(fmmy015,0),COALESCE(fmmy016,0),COALESCE(fmmy005,0),COALESCE(fmmz003,0),fmmj007 ",   #151217-00011#4
             "  FROM fmmy_t ",
             "       LEFT OUTER JOIN(",
             "       SELECT fmmzent,fmmzdocno,SUM(fmmz003) fmmz003 ",
             "         FROM fmmz_t  ",
             "        GROUP BY fmmzent,fmmzdocno ",
                     ") ON fmmzent = fmmyent AND fmmzdocno = fmmydocno",
             "     ,",
             "       fmmj_t ",
             " WHERE fmmyent = ",g_enterprise," ",
             "   AND fmmy001 = fmmjdocno ",
             "   AND fmmyent = fmmjent ",
             "   AND fmmj001 = '",p_docno,"' "
   PREPARE sel_fmmjp2 FROM l_sql
   DECLARE sel_fmmjc2 CURSOR FOR sel_fmmjp2 
   
   LET g_fmmg_m.l_amount1 = 0 
   LET g_fmmg_m.l_amount2 = 0
   LET g_fmmg_m.l_amount3 = 0
   LET g_fmmg_m.l_price1 = 0 
   LET g_fmmg_m.l_cost1 = 0
   LET g_fmmg_m.l_account1 = 0
   LET g_fmmg_m.l_account2 = 0
   LET g_fmmg_m.l_account3 = 0
   LET g_fmmg_m.l_sumall = 0
   CALL g_memo_afmt510.clear()
   LET l_idx = 1
   FOREACH sel_fmmjc1 INTO g_memo_afmt510[l_idx].*
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH:sel_fmmjc1'
         CALL cl_err()
      END IF
      IF cl_null(g_memo_afmt510[l_idx].l_amount)THEN LET g_memo_afmt510[l_idx].l_amount = 0 END IF
      IF cl_null(g_memo_afmt510[l_idx].l_account)THEN LET g_memo_afmt510[l_idx].l_account = 0 END IF
      LET g_fmmg_m.l_amount1 = g_fmmg_m.l_amount1 + g_memo_afmt510[l_idx].l_amount
      LET g_fmmg_m.l_account2 = g_fmmg_m.l_account2 + g_memo_afmt510[l_idx].l_account
      LET l_idx = l_idx + 1
   END FOREACH
 
   FOREACH sel_fmmjc2 INTO g_memo_afmt510[l_idx].*
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH:sel_fmmjc2'
         CALL cl_err()
      END IF
      
      IF cl_null(g_memo_afmt510[l_idx].l_amount)THEN LET g_memo_afmt510[l_idx].l_amount = 0 END IF
      IF cl_null(g_memo_afmt510[l_idx].l_price2)THEN LET g_memo_afmt510[l_idx].l_price2 = 0 END IF
      #IF cl_null(g_memo_afmt510[l_idx].l_account)THEN LET g_memo_afmt510[l_idx].l_account = 0 END IF   #151127-00002#6 mark
      IF cl_null(g_memo_afmt510[l_idx].l_account5)THEN LET g_memo_afmt510[l_idx].l_account5 = 0 END IF  #151127-00002#6 add
      LET g_fmmg_m.l_amount2 = g_fmmg_m.l_amount2 + g_memo_afmt510[l_idx].l_amount   #
      LET g_fmmg_m.l_cost1 = g_fmmg_m.l_cost1 + (g_memo_afmt510[l_idx].l_amount * g_memo_afmt510[l_idx].l_price2)
      #LET g_fmmg_m.l_account3 = g_fmmg_m.l_account3 + g_memo_afmt510[l_idx].l_account   #151127-00002#6 mark
      LET g_fmmg_m.l_account3 = g_fmmg_m.l_account3 + g_memo_afmt510[l_idx].l_account5    #151127-00002#6 add
      LET l_idx = l_idx + 1
   END FOREACH
   CALL g_memo_afmt510.deleteElement(g_memo_afmt510.getLength())
   LET g_rec_b2 = l_idx - 1
   
   LET g_fmmg_m.l_amount3 = g_fmmg_m.l_amount1 - g_fmmg_m.l_amount2
   IF g_fmmg_m.l_amount1 != 0 THEN
      LET g_fmmg_m.l_price1 = g_fmmg_m.l_account2 /  g_fmmg_m.l_amount1
   ELSE
      LET g_fmmg_m.l_price1 = 0 
   END IF
   LET g_fmmg_m.l_account1 = g_fmmg_m.l_account2 - g_fmmg_m.l_cost1
   LET g_fmmg_m.l_sumall = g_fmmg_m.l_account3 - g_fmmg_m.l_cost1
   
   DISPLAY BY NAME g_fmmg_m.l_amount1,g_fmmg_m.l_amount2,g_fmmg_m.l_amount3,
                   g_fmmg_m.l_price1,   g_fmmg_m.l_cost1 ,   g_fmmg_m.l_account1,
                   g_fmmg_m.l_account2,   g_fmmg_m.l_account3,   g_fmmg_m.l_sumall
   DISPLAY ARRAY g_memo_afmt510 TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b2)
      BEFORE DISPLAY
         EXIT DISPLAY    
   END DISPLAY
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
PRIVATE FUNCTION afmt510_upd_fmmh()
  #DEFINE l_fmmh    RECORD LIKE fmmh_t.*   #161104-00024#11 mark
   #161104-00024#11 --s add
   DEFINE l_fmmh RECORD  #延長平倉期限記錄檔
          fmmhent LIKE fmmh_t.fmmhent, #企業編號
          fmmh001 LIKE fmmh_t.fmmh001, #投資確認單號
          fmmh002 LIKE fmmh_t.fmmh002, #原始平倉日期
          fmmh003 LIKE fmmh_t.fmmh003, #更新平倉日期
          fmmhud001 LIKE fmmh_t.fmmhud001, #自定義欄位(文字)001
          fmmhud002 LIKE fmmh_t.fmmhud002, #自定義欄位(文字)002
          fmmhud003 LIKE fmmh_t.fmmhud003, #自定義欄位(文字)003
          fmmhud004 LIKE fmmh_t.fmmhud004, #自定義欄位(文字)004
          fmmhud005 LIKE fmmh_t.fmmhud005, #自定義欄位(文字)005
          fmmhud006 LIKE fmmh_t.fmmhud006, #自定義欄位(文字)006
          fmmhud007 LIKE fmmh_t.fmmhud007, #自定義欄位(文字)007
          fmmhud008 LIKE fmmh_t.fmmhud008, #自定義欄位(文字)008
          fmmhud009 LIKE fmmh_t.fmmhud009, #自定義欄位(文字)009
          fmmhud010 LIKE fmmh_t.fmmhud010, #自定義欄位(文字)010
          fmmhud011 LIKE fmmh_t.fmmhud011, #自定義欄位(數字)011
          fmmhud012 LIKE fmmh_t.fmmhud012, #自定義欄位(數字)012
          fmmhud013 LIKE fmmh_t.fmmhud013, #自定義欄位(數字)013
          fmmhud014 LIKE fmmh_t.fmmhud014, #自定義欄位(數字)014
          fmmhud015 LIKE fmmh_t.fmmhud015, #自定義欄位(數字)015
          fmmhud016 LIKE fmmh_t.fmmhud016, #自定義欄位(數字)016
          fmmhud017 LIKE fmmh_t.fmmhud017, #自定義欄位(數字)017
          fmmhud018 LIKE fmmh_t.fmmhud018, #自定義欄位(數字)018
          fmmhud019 LIKE fmmh_t.fmmhud019, #自定義欄位(數字)019
          fmmhud020 LIKE fmmh_t.fmmhud020, #自定義欄位(數字)020
          fmmhud021 LIKE fmmh_t.fmmhud021, #自定義欄位(日期時間)021
          fmmhud022 LIKE fmmh_t.fmmhud022, #自定義欄位(日期時間)022
          fmmhud023 LIKE fmmh_t.fmmhud023, #自定義欄位(日期時間)023
          fmmhud024 LIKE fmmh_t.fmmhud024, #自定義欄位(日期時間)024
          fmmhud025 LIKE fmmh_t.fmmhud025, #自定義欄位(日期時間)025
          fmmhud026 LIKE fmmh_t.fmmhud026, #自定義欄位(日期時間)026
          fmmhud027 LIKE fmmh_t.fmmhud027, #自定義欄位(日期時間)027
          fmmhud028 LIKE fmmh_t.fmmhud028, #自定義欄位(日期時間)028
          fmmhud029 LIKE fmmh_t.fmmhud029, #自定義欄位(日期時間)029
          fmmhud030 LIKE fmmh_t.fmmhud030, #自定義欄位(日期時間)030
          fmmh004 LIKE fmmh_t.fmmh004  #異動日期
   END RECORD
   #161104-00024#11 --e add
   INITIALIZE l_fmmh.* TO NULL
   LET l_fmmh.fmmh001 = g_fmmg_m.fmmgdocno
   LET l_fmmh.fmmh002 = g_fmmg_m.fmmg001
   LET l_fmmh.fmmh003 = g_today
   LET l_fmmh.fmmhent = g_enterprise
   
   #單頭無資料則不可執行
   IF cl_null(l_fmmh.fmmh001)THEN RETURN END IF
  
  
   OPEN WINDOW afmt510_s01 WITH FORM cl_ap_formpath("afm",'afmt510_s01')
   DISPLAY l_fmmh.fmmh002 TO fmmh_t.fmmh002
   INPUT BY NAME l_fmmh.fmmh002,l_fmmh.fmmh003
        ATTRIBUTE(WITHOUT DEFAULTS)
      ON ACTION accept
         EXIT INPUT
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT INPUT
      ON ACTION exit
         LET INT_FLAG = 1
         EXIT INPUT      
   END INPUT
   
   CLOSE WINDOW afmt510_s01
   
   IF NOT INT_FLAG THEN
      LET INT_FLAG = 0 
      RETURN
   ELSE
   END IF
   
   #開transaction
   #LOCK
   #INSERT fmmh_t
  #INSERT INTO fmmh_t VALUES(l_fmmh.*) #161104-00024#11  mark
   #161104-00024#11 --s add
   INSERT INTO fmmh_t(fmmhent,fmmh001,fmmh002,fmmh003,fmmhud001,
                      fmmhud002,fmmhud003,fmmhud004,fmmhud005,fmmhud006,
                      fmmhud007,fmmhud008,fmmhud009,fmmhud010,fmmhud011,
                      fmmhud012,fmmhud013,fmmhud014,fmmhud015,fmmhud016,
                      fmmhud017,fmmhud018,fmmhud019,fmmhud020,fmmhud021,
                      fmmhud022,fmmhud023,fmmhud024,fmmhud025,fmmhud026,
                      fmmhud027,fmmhud028,fmmhud029,fmmhud030,fmmh004)
   VALUES(l_fmmh.fmmhent,l_fmmh.fmmh001,l_fmmh.fmmh002,l_fmmh.fmmh003,l_fmmh.fmmhud001,
          l_fmmh.fmmhud002,l_fmmh.fmmhud003,l_fmmh.fmmhud004,l_fmmh.fmmhud005,l_fmmh.fmmhud006,
          l_fmmh.fmmhud007,l_fmmh.fmmhud008,l_fmmh.fmmhud009,l_fmmh.fmmhud010,l_fmmh.fmmhud011,
          l_fmmh.fmmhud012,l_fmmh.fmmhud013,l_fmmh.fmmhud014,l_fmmh.fmmhud015,l_fmmh.fmmhud016,
          l_fmmh.fmmhud017,l_fmmh.fmmhud018,l_fmmh.fmmhud019,l_fmmh.fmmhud020,l_fmmh.fmmhud021,
          l_fmmh.fmmhud022,l_fmmh.fmmhud023,l_fmmh.fmmhud024,l_fmmh.fmmhud025,l_fmmh.fmmhud026,
          l_fmmh.fmmhud027,l_fmmh.fmmhud028,l_fmmh.fmmhud029,l_fmmh.fmmhud030,l_fmmh.fmmh004)
   #161104-00024#11 --e add
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = 'ins_fmmh'
      CALL cl_err()
   END IF
   #UPDATE fmmg_t
   UPDATE fmmg_t SET fmmg001 = l_fmmh.fmmh003
    WHERE fmmgent = g_enterprise
      AND fmmgdocno = l_fmmh.fmmh001
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = 'upd_fmmg'
      CALL cl_err()
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
PRIVATE FUNCTION afmt510_fmmg004_desc(p_fmmf001,p_fmmf002)
   DEFINE p_fmmf001   LIKE fmmf_t.fmmf001
   DEFINE p_fmmf002   LIKE fmmf_t.fmmf002
   LET g_fmmg_m.l_fmmg004_desc_desc = NULL
   LET g_fmmg_m.l_fmmg004_desc_desc_desc = NULL
   #開戶名不知道抓哪個欄位
   #先抓開戶帳號
   SELECT fmmf003,fmmf005
     INTO g_fmmg_m.l_fmmg004_desc_desc,
          g_fmmg_m.l_fmmg004_desc_desc_desc
     FROM fmmf_t
    WHERE fmmfent = g_enterprise
      AND fmmf001 = p_fmmf001
      AND fmmf002 = p_fmmf002
   DISPLAY BY NAME g_fmmg_m.l_fmmg004_desc_desc_desc
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
PRIVATE FUNCTION afmt510_fmmg003_desc(p_fmma001)
   DEFINE p_fmma001   LIKE fmma_t.fmma001
   LET g_fmmg_m.l_fmmg003_desc_desc = NULL
   
   SELECT fmma003 INTO g_fmmg_m.l_fmmg003_desc_desc FROM fmma_t
    WHERE fmmaent = g_enterprise
      AND fmma001 = p_fmma001
   DISPLAY BY NAME g_fmmg_m.l_fmmg003_desc_desc
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
PRIVATE FUNCTION afmt510_fmma001_chk(p_fmma001)
   DEFINE p_fmma001   LIKE fmma_t.fmma001
   DEFINE r_success   LIKE type_t.num10
   DEFINE r_errno     LIKE gzze_t.gzze001
   DEFINE l_fmma      RECORD
                      fmmastus   LIKE fmma_t.fmmastus
                      END RECORD
   LET r_errno  = ''
   LET r_success = TRUE
   INITIALIZE l_fmma.* TO NULL
   SELECT fmmastus INTO l_fmma.*
     FROM fmma_t
    WHERE fmmaent = g_enterprise
      AND fmma001 = p_fmma001
      
   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_errno = 'afm-00070'
         LET r_success = FALSE
      WHEN l_fmma.fmmastus = 'N'
         LET r_errno = 'afm-00073'
         LET r_success = FALSE
   END CASE
   RETURN r_success,r_errno
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
PRIVATE FUNCTION afmt510_fmme_fmmf_chk(p_fmmg004,p_fmmg002)
   DEFINE p_fmmg004   LIKE fmmg_t.fmmg004
   DEFINE p_fmmg002   LIKE fmmg_t.fmmg002
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_errno     LIKE gzze_t.gzze001
   DEFINE l_fmme      RECORD
                      fmmestus   LIKE fmme_t.fmmestus
                      END RECORD
   DEFINE l_count     LIKE type_t.num10
   
   LET r_success = TRUE
   LET r_errno  = ''
   IF NOT cl_null(p_fmmg004)THEN
      #檢查fmme是否存在
      INITIALIZE l_fmme.* TO NULL
      SELECT fmmestus  INTO l_fmme.*
        FROM fmme_t
       WHERE fmmeent  = g_enterprise
         AND fmme001  = p_fmmg004
      CASE
         WHEN SQLCA.SQLCODE=100
            LET r_errno = 'afm-00072'
            LET r_success = FALSE
         WHEN l_fmme.fmmestus = 'N'
            LET r_errno = 'afm-00074'
            LET r_success = FALSE
      END CASE
      
   END IF
   IF NOT r_success THEN
      RETURN r_success,r_errno
   END IF
   
   IF NOT cl_null(p_fmmg004) AND NOT cl_null(p_fmmg002)THEN
      LET l_count = NULL
      SELECT COUNT(*) INTO l_count  FROM fmmf_t
       WHERE fmmfent = g_enterprise
         AND fmmf001 = p_fmmg002
         AND fmmf002 = p_fmmg004
      IF cl_null(l_count)THEN LET l_count = 0 END IF
      
      IF l_count = 0 THEN
         LET r_errno = 'afm-00075'
         LET r_success = FALSE
      END IF
       
   END IF
   RETURN r_success,r_errno
END FUNCTION

 
{</section>}
 
