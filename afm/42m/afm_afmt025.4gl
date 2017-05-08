#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt025.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2015-11-09 16:54:25), PR版次:0010(2017-02-22 10:29:29)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: afmt025
#+ Description: 融資申請確認維護作業
#+ Creator....: 02291(2015-11-05 10:48:20)
#+ Modifier...: 02291 -SD/PR- 01531
 
{</section>}
 
{<section id="afmt025.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#Modify.........: No.151125-00001#2  15/11/27 By catmoon 作廢前詢問「是否執行作廢？」
#Modify.........: No.160318-00025#6  16/04/14 By 07675   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#Modify.........: No.160415-00013#1  16/04/19 By 07900   单身无资料不能通过审核
#Modify.........: No.160818-00017#12 16/08/24 By 07900   删除修改未重新判断状态码
#Modify.........: No.160822-00008#6  16/09/05 By 08171   新舊值處理
#Modify.........: No.160912-00014#5  16/09/30 By 08171   列印串接afmr025
#Modify.........: No.161006-00005#34 16/10/26 By 08171   資金中心(fmagsite)、對外融資組織(fmah002)開窗改用q_ooef001_33( )，where條件拿掉(q_ooef001_33已經有條件)
#Modify.........: No.161028-00032#1  16/10/31 By 08171   申請組織開窗+校驗增加權限控卡
#Modify.........: No.161026-00023#2  16/11/18 By 01727   AFM模組,增加BPM簽核功能。
#Modify.........: No.161104-00046#15 17/01/03 By 08729   處理單別預設值
#Modify.........: No.170106-00021#1  17/01/17 By 01531   審核額度欄位不需檢查：申请单号+申请单项次的 审核额度之和 大于 融资规模 報錯 ，但实际可大於融資規模，在审核时会检核提醒
#Modify.........: No.170222-00011#1  17/02/22 By 01531   完善單頭預設值
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
PRIVATE type type_g_fmag_m        RECORD
       fmagsite LIKE fmag_t.fmagsite, 
   fmagsite_desc LIKE type_t.chr80, 
   fmagdocdt LIKE fmag_t.fmagdocdt, 
   fmagdocno LIKE fmag_t.fmagdocno, 
   fmagstus LIKE fmag_t.fmagstus, 
   fmagownid LIKE fmag_t.fmagownid, 
   fmagownid_desc LIKE type_t.chr80, 
   fmagowndp LIKE fmag_t.fmagowndp, 
   fmagowndp_desc LIKE type_t.chr80, 
   fmagcrtid LIKE fmag_t.fmagcrtid, 
   fmagcrtid_desc LIKE type_t.chr80, 
   fmagcrtdp LIKE fmag_t.fmagcrtdp, 
   fmagcrtdp_desc LIKE type_t.chr80, 
   fmagcrtdt LIKE fmag_t.fmagcrtdt, 
   fmagmodid LIKE fmag_t.fmagmodid, 
   fmagmodid_desc LIKE type_t.chr80, 
   fmagmoddt LIKE fmag_t.fmagmoddt, 
   fmagcnfid LIKE fmag_t.fmagcnfid, 
   fmagcnfid_desc LIKE type_t.chr80, 
   fmagcnfdt LIKE fmag_t.fmagcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_fmah_d        RECORD
       fmahseq LIKE fmah_t.fmahseq, 
   fmah001 LIKE fmah_t.fmah001, 
   fmah001_desc LIKE type_t.chr500, 
   fmah002 LIKE fmah_t.fmah002, 
   fmah002_desc LIKE type_t.chr500, 
   ooef001 LIKE type_t.chr500, 
   ooef001_desc LIKE type_t.chr500, 
   fmah003 LIKE fmah_t.fmah003, 
   fmah004 LIKE fmah_t.fmah004, 
   fmah005 LIKE fmah_t.fmah005, 
   fmah005_desc LIKE type_t.chr500, 
   fmah006 LIKE fmah_t.fmah006, 
   fmah007 LIKE fmah_t.fmah007, 
   fmah008 LIKE fmah_t.fmah008, 
   fmah009 LIKE fmah_t.fmah009, 
   fmah010 LIKE fmah_t.fmah010
       END RECORD
PRIVATE TYPE type_g_fmah2_d RECORD
       fmaiseq2 LIKE fmai_t.fmaiseq2, 
   fmai001 LIKE fmai_t.fmai001, 
   fmai001_desc LIKE type_t.chr500, 
   glaacomp LIKE type_t.chr500, 
   glaacomp_desc LIKE type_t.chr500, 
   fmai002 LIKE fmai_t.fmai002, 
   fmai003 LIKE fmai_t.fmai003, 
   fmcf002 LIKE type_t.chr500, 
   fmcf003 LIKE type_t.chr500, 
   fmaiseq LIKE fmai_t.fmaiseq, 
   fmah001 LIKE fmah_t.fmah001, 
   fmah001_1_desc LIKE type_t.chr500, 
   fmah006 LIKE fmah_t.fmah006, 
   fmai004 LIKE fmai_t.fmai004
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_fmagdocno LIKE fmag_t.fmagdocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaald          LIKE glaa_t.glaald
DEFINE g_glaacomp        LIKE glaa_t.glaacomp
DEFINE g_glaa003         LIKE glaa_t.glaa003
DEFINE g_glaa024         LIKE glaa_t.glaa024
DEFINE g_user_dept_wc    STRING      #161104-00046#15
DEFINE g_user_dept_wc_q  STRING      #161104-00046#15
DEFINE g_user_slip_wc    STRING      #161104-00046#15
#end add-point
       
#模組變數(Module Variables)
DEFINE g_fmag_m          type_g_fmag_m
DEFINE g_fmag_m_t        type_g_fmag_m
DEFINE g_fmag_m_o        type_g_fmag_m
DEFINE g_fmag_m_mask_o   type_g_fmag_m #轉換遮罩前資料
DEFINE g_fmag_m_mask_n   type_g_fmag_m #轉換遮罩後資料
 
   DEFINE g_fmagdocno_t LIKE fmag_t.fmagdocno
 
 
DEFINE g_fmah_d          DYNAMIC ARRAY OF type_g_fmah_d
DEFINE g_fmah_d_t        type_g_fmah_d
DEFINE g_fmah_d_o        type_g_fmah_d
DEFINE g_fmah_d_mask_o   DYNAMIC ARRAY OF type_g_fmah_d #轉換遮罩前資料
DEFINE g_fmah_d_mask_n   DYNAMIC ARRAY OF type_g_fmah_d #轉換遮罩後資料
DEFINE g_fmah2_d          DYNAMIC ARRAY OF type_g_fmah2_d
DEFINE g_fmah2_d_t        type_g_fmah2_d
DEFINE g_fmah2_d_o        type_g_fmah2_d
DEFINE g_fmah2_d_mask_o   DYNAMIC ARRAY OF type_g_fmah2_d #轉換遮罩前資料
DEFINE g_fmah2_d_mask_n   DYNAMIC ARRAY OF type_g_fmah2_d #轉換遮罩後資料
 
 
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
 
{<section id="afmt025.main" >}
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
   #161104-00046#15-----s
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_fmag_m','','','','','','')RETURNING g_sub_success
   
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('fmagsite','','fmagent','fmagdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#15-----e
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT fmagsite,'',fmagdocdt,fmagdocno,fmagstus,fmagownid,'',fmagowndp,'',fmagcrtid, 
       '',fmagcrtdp,'',fmagcrtdt,fmagmodid,'',fmagmoddt,fmagcnfid,'',fmagcnfdt", 
                      " FROM fmag_t",
                      " WHERE fmagent= ? AND fmagdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt025_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fmagsite,t0.fmagdocdt,t0.fmagdocno,t0.fmagstus,t0.fmagownid,t0.fmagowndp, 
       t0.fmagcrtid,t0.fmagcrtdp,t0.fmagcrtdt,t0.fmagmodid,t0.fmagmoddt,t0.fmagcnfid,t0.fmagcnfdt,t1.ooefl003 , 
       t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooag011",
               " FROM fmag_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.fmagsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.fmagownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.fmagowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.fmagcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.fmagcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.fmagmodid  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.fmagcnfid  ",
 
               " WHERE t0.fmagent = " ||g_enterprise|| " AND t0.fmagdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afmt025_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmt025 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmt025_init()   
 
      #進入選單 Menu (="N")
      CALL afmt025_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afmt025
      
   END IF 
   
   CLOSE afmt025_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afmt025.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afmt025_init()
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('fmagstus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   #初始化搜尋條件
   CALL afmt025_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="afmt025.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION afmt025_ui_dialog()
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
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL afmt025_insert()
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
         INITIALIZE g_fmag_m.* TO NULL
         CALL g_fmah_d.clear()
         CALL g_fmah2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afmt025_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_fmah_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt025_idx_chk()
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
               CALL afmt025_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_fmah2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt025_idx_chk()
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
               CALL afmt025_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL afmt025_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            
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
               CALL afmt025_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL afmt025_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL afmt025_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL afmt025_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL afmt025_set_act_visible()   
            CALL afmt025_set_act_no_visible()
            IF NOT (g_fmag_m.fmagdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " fmagent = " ||g_enterprise|| " AND",
                                  " fmagdocno = '", g_fmag_m.fmagdocno, "' "
 
               #填到對應位置
               CALL afmt025_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "fmag_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmah_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmai_t" 
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
               CALL afmt025_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "fmag_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmah_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmai_t" 
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
                  CALL afmt025_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afmt025_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL afmt025_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt025_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL afmt025_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt025_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL afmt025_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt025_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL afmt025_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt025_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL afmt025_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt025_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_fmah_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_fmah2_d)
                  LET g_export_id[2]   = "s_detail2"
 
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
               CALL afmt025_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afmt025_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afmt025_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afmt025_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = " fmagent = '",g_enterprise,"'  AND fmagsite = '",g_fmag_m.fmagsite,"' AND fmagdocno = '",g_fmag_m.fmagdocno,"' " #160912-00014#5
               #END add-point
               &include "erp/afm/afmt025_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = " fmagent = '",g_enterprise,"'  AND fmagsite = '",g_fmag_m.fmagsite,"' AND fmagdocno = '",g_fmag_m.fmagdocno,"' " #160912-00014#5
               #END add-point
               &include "erp/afm/afmt025_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL afmt025_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afmt025_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afmt025_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmt025_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmt025_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_fmag_m.fmagdocdt)
 
 
 
         
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
 
{<section id="afmt025.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION afmt025_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT fmagdocno ",
                      " FROM fmag_t ",
                      " ",
                      " LEFT JOIN fmah_t ON fmahent = fmagent AND fmagdocno = fmahdocno ", "  ",
                      #add-point:browser_fill段sql(fmah_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN fmai_t ON fmaient = fmagent AND fmagdocno = fmaidocno", "  ",
                      #add-point:browser_fill段sql(fmai_t1) name="browser_fill.cnt.join.fmai_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE fmagent = " ||g_enterprise|| " AND fmahent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("fmag_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT fmagdocno ",
                      " FROM fmag_t ", 
                      "  ",
                      "  ",
                      " WHERE fmagent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("fmag_t")
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
      INITIALIZE g_fmag_m.* TO NULL
      CALL g_fmah_d.clear()        
      CALL g_fmah2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.fmagdocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fmagstus,t0.fmagdocno ",
                  " FROM fmag_t t0",
                  "  ",
                  "  LEFT JOIN fmah_t ON fmahent = fmagent AND fmagdocno = fmahdocno ", "  ", 
                  #add-point:browser_fill段sql(fmah_t1) name="browser_fill.join.fmah_t1"
                  
                  #end add-point
                  "  LEFT JOIN fmai_t ON fmaient = fmagent AND fmagdocno = fmaidocno", "  ", 
                  #add-point:browser_fill段sql(fmai_t1) name="browser_fill.join.fmai_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                  
                  " WHERE t0.fmagent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("fmag_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fmagstus,t0.fmagdocno ",
                  " FROM fmag_t t0",
                  "  ",
                  
                  " WHERE t0.fmagent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("fmag_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY fmagdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"fmag_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_fmagdocno
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
   
   IF cl_null(g_browser[g_cnt].b_fmagdocno) THEN
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
 
{<section id="afmt025.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION afmt025_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_fmag_m.fmagdocno = g_browser[g_current_idx].b_fmagdocno   
 
   EXECUTE afmt025_master_referesh USING g_fmag_m.fmagdocno INTO g_fmag_m.fmagsite,g_fmag_m.fmagdocdt, 
       g_fmag_m.fmagdocno,g_fmag_m.fmagstus,g_fmag_m.fmagownid,g_fmag_m.fmagowndp,g_fmag_m.fmagcrtid, 
       g_fmag_m.fmagcrtdp,g_fmag_m.fmagcrtdt,g_fmag_m.fmagmodid,g_fmag_m.fmagmoddt,g_fmag_m.fmagcnfid, 
       g_fmag_m.fmagcnfdt,g_fmag_m.fmagsite_desc,g_fmag_m.fmagownid_desc,g_fmag_m.fmagowndp_desc,g_fmag_m.fmagcrtid_desc, 
       g_fmag_m.fmagcrtdp_desc,g_fmag_m.fmagmodid_desc,g_fmag_m.fmagcnfid_desc
   
   CALL afmt025_fmag_t_mask()
   CALL afmt025_show()
      
END FUNCTION
 
{</section>}
 
{<section id="afmt025.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION afmt025_ui_detailshow()
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
 
{<section id="afmt025.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afmt025_ui_browser_refresh()
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
      IF g_browser[l_i].b_fmagdocno = g_fmag_m.fmagdocno 
 
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
 
{<section id="afmt025.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmt025_construct()
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
   INITIALIZE g_fmag_m.* TO NULL
   CALL g_fmah_d.clear()        
   CALL g_fmah2_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON fmagsite,fmagdocdt,fmagdocno,fmagstus,fmagownid,fmagowndp,fmagcrtid, 
          fmagcrtdp,fmagcrtdt,fmagmodid,fmagmoddt,fmagcnfid,fmagcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<fmagcrtdt>>----
         AFTER FIELD fmagcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<fmagmoddt>>----
         AFTER FIELD fmagmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmagcnfdt>>----
         AFTER FIELD fmagcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmagpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.fmagsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmagsite
            #add-point:ON ACTION controlp INFIELD fmagsite name="construct.c.fmagsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗 #161006-00005#34 mark
            CALL q_ooef001_33() #161006-00005#34 add
            DISPLAY g_qryparam.return1 TO fmagsite  #顯示到畫面上
            NEXT FIELD fmagsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmagsite
            #add-point:BEFORE FIELD fmagsite name="construct.b.fmagsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmagsite
            
            #add-point:AFTER FIELD fmagsite name="construct.a.fmagsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmagdocdt
            #add-point:BEFORE FIELD fmagdocdt name="construct.b.fmagdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmagdocdt
            
            #add-point:AFTER FIELD fmagdocdt name="construct.a.fmagdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmagdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmagdocdt
            #add-point:ON ACTION controlp INFIELD fmagdocdt name="construct.c.fmagdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmagdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmagdocno
            #add-point:ON ACTION controlp INFIELD fmagdocno name="construct.c.fmagdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161104-00046#15-----s
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_user_dept_wc_q 
            END IF
            #161104-00046#15-----e
            CALL q_fmagdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmagdocno  #顯示到畫面上
            NEXT FIELD fmagdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmagdocno
            #add-point:BEFORE FIELD fmagdocno name="construct.b.fmagdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmagdocno
            
            #add-point:AFTER FIELD fmagdocno name="construct.a.fmagdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmagstus
            #add-point:BEFORE FIELD fmagstus name="construct.b.fmagstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmagstus
            
            #add-point:AFTER FIELD fmagstus name="construct.a.fmagstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmagstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmagstus
            #add-point:ON ACTION controlp INFIELD fmagstus name="construct.c.fmagstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmagownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmagownid
            #add-point:ON ACTION controlp INFIELD fmagownid name="construct.c.fmagownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmagownid  #顯示到畫面上
            NEXT FIELD fmagownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmagownid
            #add-point:BEFORE FIELD fmagownid name="construct.b.fmagownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmagownid
            
            #add-point:AFTER FIELD fmagownid name="construct.a.fmagownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmagowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmagowndp
            #add-point:ON ACTION controlp INFIELD fmagowndp name="construct.c.fmagowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmagowndp  #顯示到畫面上
            NEXT FIELD fmagowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmagowndp
            #add-point:BEFORE FIELD fmagowndp name="construct.b.fmagowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmagowndp
            
            #add-point:AFTER FIELD fmagowndp name="construct.a.fmagowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmagcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmagcrtid
            #add-point:ON ACTION controlp INFIELD fmagcrtid name="construct.c.fmagcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmagcrtid  #顯示到畫面上
            NEXT FIELD fmagcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmagcrtid
            #add-point:BEFORE FIELD fmagcrtid name="construct.b.fmagcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmagcrtid
            
            #add-point:AFTER FIELD fmagcrtid name="construct.a.fmagcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmagcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmagcrtdp
            #add-point:ON ACTION controlp INFIELD fmagcrtdp name="construct.c.fmagcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmagcrtdp  #顯示到畫面上
            NEXT FIELD fmagcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmagcrtdp
            #add-point:BEFORE FIELD fmagcrtdp name="construct.b.fmagcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmagcrtdp
            
            #add-point:AFTER FIELD fmagcrtdp name="construct.a.fmagcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmagcrtdt
            #add-point:BEFORE FIELD fmagcrtdt name="construct.b.fmagcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmagmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmagmodid
            #add-point:ON ACTION controlp INFIELD fmagmodid name="construct.c.fmagmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmagmodid  #顯示到畫面上
            NEXT FIELD fmagmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmagmodid
            #add-point:BEFORE FIELD fmagmodid name="construct.b.fmagmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmagmodid
            
            #add-point:AFTER FIELD fmagmodid name="construct.a.fmagmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmagmoddt
            #add-point:BEFORE FIELD fmagmoddt name="construct.b.fmagmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmagcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmagcnfid
            #add-point:ON ACTION controlp INFIELD fmagcnfid name="construct.c.fmagcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmagcnfid  #顯示到畫面上
            NEXT FIELD fmagcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmagcnfid
            #add-point:BEFORE FIELD fmagcnfid name="construct.b.fmagcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmagcnfid
            
            #add-point:AFTER FIELD fmagcnfid name="construct.a.fmagcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmagcnfdt
            #add-point:BEFORE FIELD fmagcnfdt name="construct.b.fmagcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON fmahseq,fmah001,fmah002,ooef001,fmah003,fmah004,fmah005,fmah006,fmah007, 
          fmah008,fmah009,fmah010
           FROM s_detail1[1].fmahseq,s_detail1[1].fmah001,s_detail1[1].fmah002,s_detail1[1].ooef001, 
               s_detail1[1].fmah003,s_detail1[1].fmah004,s_detail1[1].fmah005,s_detail1[1].fmah006,s_detail1[1].fmah007, 
               s_detail1[1].fmah008,s_detail1[1].fmah009,s_detail1[1].fmah010
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmahseq
            #add-point:BEFORE FIELD fmahseq name="construct.b.page1.fmahseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmahseq
            
            #add-point:AFTER FIELD fmahseq name="construct.a.page1.fmahseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmahseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmahseq
            #add-point:ON ACTION controlp INFIELD fmahseq name="construct.c.page1.fmahseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmah001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah001
            #add-point:ON ACTION controlp INFIELD fmah001 name="construct.c.page1.fmah001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmah001  #顯示到畫面上
            NEXT FIELD fmah001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah001
            #add-point:BEFORE FIELD fmah001 name="construct.b.page1.fmah001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah001
            
            #add-point:AFTER FIELD fmah001 name="construct.a.page1.fmah001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmah002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah002
            #add-point:ON ACTION controlp INFIELD fmah002 name="construct.c.page1.fmah002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗 #161006-00005#34 mark
            CALL q_ooef001_33()                    #161006-00005#34 add
            DISPLAY g_qryparam.return1 TO fmah002  #顯示到畫面上
            NEXT FIELD fmah002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah002
            #add-point:BEFORE FIELD fmah002 name="construct.b.page1.fmah002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah002
            
            #add-point:AFTER FIELD fmah002 name="construct.a.page1.fmah002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooef001
            #add-point:BEFORE FIELD ooef001 name="construct.b.page1.ooef001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooef001
            
            #add-point:AFTER FIELD ooef001 name="construct.a.page1.ooef001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooef001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooef001
            #add-point:ON ACTION controlp INFIELD ooef001 name="construct.c.page1.ooef001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmah003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah003
            #add-point:ON ACTION controlp INFIELD fmah003 name="construct.c.page1.fmah003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmac001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmah003  #顯示到畫面上
            DISPLAY g_qryparam.return2 TO fmah004  #顯示到畫面上
            NEXT FIELD fmah003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah003
            #add-point:BEFORE FIELD fmah003 name="construct.b.page1.fmah003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah003
            
            #add-point:AFTER FIELD fmah003 name="construct.a.page1.fmah003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah004
            #add-point:BEFORE FIELD fmah004 name="construct.b.page1.fmah004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah004
            
            #add-point:AFTER FIELD fmah004 name="construct.a.page1.fmah004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmah004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah004
            #add-point:ON ACTION controlp INFIELD fmah004 name="construct.c.page1.fmah004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmac001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmah003  #顯示到畫面上
            DISPLAY g_qryparam.return2 TO fmah004  #顯示到畫面上
            NEXT FIELD fmah004                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmah005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah005
            #add-point:ON ACTION controlp INFIELD fmah005 name="construct.c.page1.fmah005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmah005  #顯示到畫面上
            NEXT FIELD fmah005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah005
            #add-point:BEFORE FIELD fmah005 name="construct.b.page1.fmah005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah005
            
            #add-point:AFTER FIELD fmah005 name="construct.a.page1.fmah005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmah006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah006
            #add-point:ON ACTION controlp INFIELD fmah006 name="construct.c.page1.fmah006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmah006  #顯示到畫面上
            NEXT FIELD fmah006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah006
            #add-point:BEFORE FIELD fmah006 name="construct.b.page1.fmah006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah006
            
            #add-point:AFTER FIELD fmah006 name="construct.a.page1.fmah006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah007
            #add-point:BEFORE FIELD fmah007 name="construct.b.page1.fmah007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah007
            
            #add-point:AFTER FIELD fmah007 name="construct.a.page1.fmah007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmah007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah007
            #add-point:ON ACTION controlp INFIELD fmah007 name="construct.c.page1.fmah007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah008
            #add-point:BEFORE FIELD fmah008 name="construct.b.page1.fmah008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah008
            
            #add-point:AFTER FIELD fmah008 name="construct.a.page1.fmah008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmah008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah008
            #add-point:ON ACTION controlp INFIELD fmah008 name="construct.c.page1.fmah008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah009
            #add-point:BEFORE FIELD fmah009 name="construct.b.page1.fmah009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah009
            
            #add-point:AFTER FIELD fmah009 name="construct.a.page1.fmah009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmah009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah009
            #add-point:ON ACTION controlp INFIELD fmah009 name="construct.c.page1.fmah009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah010
            #add-point:BEFORE FIELD fmah010 name="construct.b.page1.fmah010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah010
            
            #add-point:AFTER FIELD fmah010 name="construct.a.page1.fmah010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmah010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah010
            #add-point:ON ACTION controlp INFIELD fmah010 name="construct.c.page1.fmah010"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON fmaiseq2,fmai001,glaacomp,fmai002,fmai003,fmcf002,fmcf003,fmaiseq,fmah001_1, 
          fmah006_1,fmai004
           FROM s_detail2[1].fmaiseq2,s_detail2[1].fmai001,s_detail2[1].glaacomp,s_detail2[1].fmai002, 
               s_detail2[1].fmai003,s_detail2[1].fmcf002,s_detail2[1].fmcf003,s_detail2[1].fmaiseq,s_detail2[1].fmah001_1, 
               s_detail2[1].fmah006_1,s_detail2[1].fmai004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaiseq2
            #add-point:BEFORE FIELD fmaiseq2 name="construct.b.page2.fmaiseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaiseq2
            
            #add-point:AFTER FIELD fmaiseq2 name="construct.a.page2.fmaiseq2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmaiseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaiseq2
            #add-point:ON ACTION controlp INFIELD fmaiseq2 name="construct.c.page2.fmaiseq2"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fmai001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmai001
            #add-point:ON ACTION controlp INFIELD fmai001 name="construct.c.page2.fmai001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段  
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmcf007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmai001  #顯示到畫面上
            NEXT FIELD fmai001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmai001
            #add-point:BEFORE FIELD fmai001 name="construct.b.page2.fmai001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmai001
            
            #add-point:AFTER FIELD fmai001 name="construct.a.page2.fmai001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp name="construct.b.page2.glaacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacomp
            
            #add-point:AFTER FIELD glaacomp name="construct.a.page2.glaacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glaacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp name="construct.c.page2.glaacomp"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fmai002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmai002
            #add-point:ON ACTION controlp INFIELD fmai002 name="construct.c.page2.fmai002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmcedocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmai002  #顯示到畫面上
            NEXT FIELD fmai002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmai002
            #add-point:BEFORE FIELD fmai002 name="construct.b.page2.fmai002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmai002
            
            #add-point:AFTER FIELD fmai002 name="construct.a.page2.fmai002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmai003
            #add-point:BEFORE FIELD fmai003 name="construct.b.page2.fmai003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmai003
            
            #add-point:AFTER FIELD fmai003 name="construct.a.page2.fmai003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmai003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmai003
            #add-point:ON ACTION controlp INFIELD fmai003 name="construct.c.page2.fmai003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcf002
            #add-point:BEFORE FIELD fmcf002 name="construct.b.page2.fmcf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcf002
            
            #add-point:AFTER FIELD fmcf002 name="construct.a.page2.fmcf002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmcf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcf002
            #add-point:ON ACTION controlp INFIELD fmcf002 name="construct.c.page2.fmcf002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcf003
            #add-point:BEFORE FIELD fmcf003 name="construct.b.page2.fmcf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcf003
            
            #add-point:AFTER FIELD fmcf003 name="construct.a.page2.fmcf003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmcf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcf003
            #add-point:ON ACTION controlp INFIELD fmcf003 name="construct.c.page2.fmcf003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaiseq
            #add-point:BEFORE FIELD fmaiseq name="construct.b.page2.fmaiseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaiseq
            
            #add-point:AFTER FIELD fmaiseq name="construct.a.page2.fmaiseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmaiseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaiseq
            #add-point:ON ACTION controlp INFIELD fmaiseq name="construct.c.page2.fmaiseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah001_1
            #add-point:BEFORE FIELD fmah001_1 name="construct.b.page2.fmah001_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah001_1
            
            #add-point:AFTER FIELD fmah001_1 name="construct.a.page2.fmah001_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmah001_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah001_1
            #add-point:ON ACTION controlp INFIELD fmah001_1 name="construct.c.page2.fmah001_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah006_1
            #add-point:BEFORE FIELD fmah006_1 name="construct.b.page2.fmah006_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah006_1
            
            #add-point:AFTER FIELD fmah006_1 name="construct.a.page2.fmah006_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmah006_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah006_1
            #add-point:ON ACTION controlp INFIELD fmah006_1 name="construct.c.page2.fmah006_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmai004
            #add-point:BEFORE FIELD fmai004 name="construct.b.page2.fmai004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmai004
            
            #add-point:AFTER FIELD fmai004 name="construct.a.page2.fmai004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmai004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmai004
            #add-point:ON ACTION controlp INFIELD fmai004 name="construct.c.page2.fmai004"
            
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
                  WHEN la_wc[li_idx].tableid = "fmag_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "fmah_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "fmai_t" 
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
   #161104-00046#15-----s
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#15-----e
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afmt025.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afmt025_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_fmah_d.clear()
   CALL g_fmah2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL afmt025_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afmt025_browser_fill("")
      CALL afmt025_fetch("")
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
   CALL afmt025_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL afmt025_fetch("F") 
      #顯示單身筆數
      CALL afmt025_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afmt025.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afmt025_fetch(p_flag)
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
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_fmag_m.fmagdocno = g_browser[g_current_idx].b_fmagdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE afmt025_master_referesh USING g_fmag_m.fmagdocno INTO g_fmag_m.fmagsite,g_fmag_m.fmagdocdt, 
       g_fmag_m.fmagdocno,g_fmag_m.fmagstus,g_fmag_m.fmagownid,g_fmag_m.fmagowndp,g_fmag_m.fmagcrtid, 
       g_fmag_m.fmagcrtdp,g_fmag_m.fmagcrtdt,g_fmag_m.fmagmodid,g_fmag_m.fmagmoddt,g_fmag_m.fmagcnfid, 
       g_fmag_m.fmagcnfdt,g_fmag_m.fmagsite_desc,g_fmag_m.fmagownid_desc,g_fmag_m.fmagowndp_desc,g_fmag_m.fmagcrtid_desc, 
       g_fmag_m.fmagcrtdp_desc,g_fmag_m.fmagmodid_desc,g_fmag_m.fmagcnfid_desc
   
   #遮罩相關處理
   LET g_fmag_m_mask_o.* =  g_fmag_m.*
   CALL afmt025_fmag_t_mask()
   LET g_fmag_m_mask_n.* =  g_fmag_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt025_set_act_visible()   
   CALL afmt025_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   CALL afmt025_fmagsite_ref()
   #end add-point
   
   #保存單頭舊值
   LET g_fmag_m_t.* = g_fmag_m.*
   LET g_fmag_m_o.* = g_fmag_m.*
   
   LET g_data_owner = g_fmag_m.fmagownid      
   LET g_data_dept  = g_fmag_m.fmagowndp
   
   #重新顯示   
   CALL afmt025_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt025.insert" >}
#+ 資料新增
PRIVATE FUNCTION afmt025_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_fmah_d.clear()   
   CALL g_fmah2_d.clear()  
 
 
   INITIALIZE g_fmag_m.* TO NULL             #DEFAULT 設定
   
   LET g_fmagdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmag_m.fmagownid = g_user
      LET g_fmag_m.fmagowndp = g_dept
      LET g_fmag_m.fmagcrtid = g_user
      LET g_fmag_m.fmagcrtdp = g_dept 
      LET g_fmag_m.fmagcrtdt = cl_get_current()
      LET g_fmag_m.fmagmodid = g_user
      LET g_fmag_m.fmagmoddt = cl_get_current()
      LET g_fmag_m.fmagstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      #170222-00011#1 add s---
      LET g_fmag_m.fmagsite = g_site
      LET g_fmag_m.fmagdocdt = g_today
      LET g_fmag_m.fmagsite_desc = s_desc_get_department_desc(g_fmag_m.fmagsite)
      CALL afmt025_fmagsite_ref()
      #170222-00011#1 add e---
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_fmag_m_t.* = g_fmag_m.*
      LET g_fmag_m_o.* = g_fmag_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmag_m.fmagstus 
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
 
 
 
    
      CALL afmt025_input("a")
      
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
         INITIALIZE g_fmag_m.* TO NULL
         INITIALIZE g_fmah_d TO NULL
         INITIALIZE g_fmah2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL afmt025_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_fmah_d.clear()
      #CALL g_fmah2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt025_set_act_visible()   
   CALL afmt025_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fmagdocno_t = g_fmag_m.fmagdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmagent = " ||g_enterprise|| " AND",
                      " fmagdocno = '", g_fmag_m.fmagdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt025_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE afmt025_cl
   
   CALL afmt025_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afmt025_master_referesh USING g_fmag_m.fmagdocno INTO g_fmag_m.fmagsite,g_fmag_m.fmagdocdt, 
       g_fmag_m.fmagdocno,g_fmag_m.fmagstus,g_fmag_m.fmagownid,g_fmag_m.fmagowndp,g_fmag_m.fmagcrtid, 
       g_fmag_m.fmagcrtdp,g_fmag_m.fmagcrtdt,g_fmag_m.fmagmodid,g_fmag_m.fmagmoddt,g_fmag_m.fmagcnfid, 
       g_fmag_m.fmagcnfdt,g_fmag_m.fmagsite_desc,g_fmag_m.fmagownid_desc,g_fmag_m.fmagowndp_desc,g_fmag_m.fmagcrtid_desc, 
       g_fmag_m.fmagcrtdp_desc,g_fmag_m.fmagmodid_desc,g_fmag_m.fmagcnfid_desc
   
   
   #遮罩相關處理
   LET g_fmag_m_mask_o.* =  g_fmag_m.*
   CALL afmt025_fmag_t_mask()
   LET g_fmag_m_mask_n.* =  g_fmag_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmag_m.fmagsite,g_fmag_m.fmagsite_desc,g_fmag_m.fmagdocdt,g_fmag_m.fmagdocno,g_fmag_m.fmagstus, 
       g_fmag_m.fmagownid,g_fmag_m.fmagownid_desc,g_fmag_m.fmagowndp,g_fmag_m.fmagowndp_desc,g_fmag_m.fmagcrtid, 
       g_fmag_m.fmagcrtid_desc,g_fmag_m.fmagcrtdp,g_fmag_m.fmagcrtdp_desc,g_fmag_m.fmagcrtdt,g_fmag_m.fmagmodid, 
       g_fmag_m.fmagmodid_desc,g_fmag_m.fmagmoddt,g_fmag_m.fmagcnfid,g_fmag_m.fmagcnfid_desc,g_fmag_m.fmagcnfdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_fmag_m.fmagownid      
   LET g_data_dept  = g_fmag_m.fmagowndp
   
   #功能已完成,通報訊息中心
   CALL afmt025_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afmt025.modify" >}
#+ 資料修改
PRIVATE FUNCTION afmt025_modify()
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
   LET g_fmag_m_t.* = g_fmag_m.*
   LET g_fmag_m_o.* = g_fmag_m.*
   
   IF g_fmag_m.fmagdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_fmagdocno_t = g_fmag_m.fmagdocno
 
   CALL s_transaction_begin()
   
   OPEN afmt025_cl USING g_enterprise,g_fmag_m.fmagdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt025_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afmt025_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt025_master_referesh USING g_fmag_m.fmagdocno INTO g_fmag_m.fmagsite,g_fmag_m.fmagdocdt, 
       g_fmag_m.fmagdocno,g_fmag_m.fmagstus,g_fmag_m.fmagownid,g_fmag_m.fmagowndp,g_fmag_m.fmagcrtid, 
       g_fmag_m.fmagcrtdp,g_fmag_m.fmagcrtdt,g_fmag_m.fmagmodid,g_fmag_m.fmagmoddt,g_fmag_m.fmagcnfid, 
       g_fmag_m.fmagcnfdt,g_fmag_m.fmagsite_desc,g_fmag_m.fmagownid_desc,g_fmag_m.fmagowndp_desc,g_fmag_m.fmagcrtid_desc, 
       g_fmag_m.fmagcrtdp_desc,g_fmag_m.fmagmodid_desc,g_fmag_m.fmagcnfid_desc
   
   #檢查是否允許此動作
   IF NOT afmt025_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmag_m_mask_o.* =  g_fmag_m.*
   CALL afmt025_fmag_t_mask()
   LET g_fmag_m_mask_n.* =  g_fmag_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL afmt025_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_fmagdocno_t = g_fmag_m.fmagdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_fmag_m.fmagmodid = g_user 
LET g_fmag_m.fmagmoddt = cl_get_current()
LET g_fmag_m.fmagmodid_desc = cl_get_username(g_fmag_m.fmagmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL afmt025_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE fmag_t SET (fmagmodid,fmagmoddt) = (g_fmag_m.fmagmodid,g_fmag_m.fmagmoddt)
          WHERE fmagent = g_enterprise AND fmagdocno = g_fmagdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_fmag_m.* = g_fmag_m_t.*
            CALL afmt025_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_fmag_m.fmagdocno != g_fmag_m_t.fmagdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE fmah_t SET fmahdocno = g_fmag_m.fmagdocno
 
          WHERE fmahent = g_enterprise AND fmahdocno = g_fmag_m_t.fmagdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fmah_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmah_t:",SQLERRMESSAGE 
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
         
         UPDATE fmai_t
            SET fmaidocno = g_fmag_m.fmagdocno
 
          WHERE fmaient = g_enterprise AND
                fmaidocno = g_fmagdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fmai_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmai_t:",SQLERRMESSAGE 
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
   CALL afmt025_set_act_visible()   
   CALL afmt025_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fmagent = " ||g_enterprise|| " AND",
                      " fmagdocno = '", g_fmag_m.fmagdocno, "' "
 
   #填到對應位置
   CALL afmt025_browser_fill("")
 
   CLOSE afmt025_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt025_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="afmt025.input" >}
#+ 資料輸入
PRIVATE FUNCTION afmt025_input(p_cmd)
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
   DEFINE  l_errno               LIKE type_t.chr20
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_cmd1                LIKE type_t.chr1
   DEFINE  l_comp                LIKE ooef_t.ooef017  #161028-00032#1 add 
   DEFINE  l_ld                  STRING  #161028-00032#1 add
   DEFINE  l_flag                LIKE type_t.num5     #161104-00046#15
   DEFINE  l_slip                LIKE ooba_t.ooba002  #161104-00046#15
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
   DISPLAY BY NAME g_fmag_m.fmagsite,g_fmag_m.fmagsite_desc,g_fmag_m.fmagdocdt,g_fmag_m.fmagdocno,g_fmag_m.fmagstus, 
       g_fmag_m.fmagownid,g_fmag_m.fmagownid_desc,g_fmag_m.fmagowndp,g_fmag_m.fmagowndp_desc,g_fmag_m.fmagcrtid, 
       g_fmag_m.fmagcrtid_desc,g_fmag_m.fmagcrtdp,g_fmag_m.fmagcrtdp_desc,g_fmag_m.fmagcrtdt,g_fmag_m.fmagmodid, 
       g_fmag_m.fmagmodid_desc,g_fmag_m.fmagmoddt,g_fmag_m.fmagcnfid,g_fmag_m.fmagcnfid_desc,g_fmag_m.fmagcnfdt 
 
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT fmahseq,fmah001,fmah002,fmah003,fmah004,fmah005,fmah006,fmah007,fmah008, 
       fmah009,fmah010 FROM fmah_t WHERE fmahent=? AND fmahdocno=? AND fmahseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt025_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT fmaiseq2,fmai001,fmai002,fmai003,fmaiseq,fmai004 FROM fmai_t WHERE fmaient=?  
       AND fmaidocno=? AND fmaiseq=? AND fmaiseq2=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt025_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL afmt025_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afmt025_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_fmag_m.fmagsite,g_fmag_m.fmagdocdt,g_fmag_m.fmagdocno,g_fmag_m.fmagstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="afmt025.input.head" >}
      #單頭段
      INPUT BY NAME g_fmag_m.fmagsite,g_fmag_m.fmagdocdt,g_fmag_m.fmagdocno,g_fmag_m.fmagstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN afmt025_cl USING g_enterprise,g_fmag_m.fmagdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt025_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt025_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL afmt025_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL afmt025_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmagsite
            
            #add-point:AFTER FIELD fmagsite name="input.a.fmagsite"
            IF NOT cl_null(g_fmag_m.fmagsite) THEN 
               IF g_fmag_m.fmagsite != g_fmag_m_o.fmagsite OR cl_null(g_fmag_m_o.fmagsite) THEN #160822-00008#6
#應用 a17 樣板自動產生(Version:2)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_fmag_m.fmagsite
                  
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooef001_42") THEN
                     #檢查成功時後續處理
                     CALL afmt025_fmagsite_ref()
                  ELSE
                     #檢查失敗時後續處理
                     #160822-00008#6 ---s
                     LET g_fmag_m.fmagsite = g_fmag_m_o.fmagsite  
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = g_fmag_m.fmagsite
                     CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                     LET g_fmag_m.fmagsite_desc = '', g_rtn_fields[1] , ''
                     DISPLAY BY NAME g_fmag_m.fmagsite_desc
                     #160822-00008#6 ---e
                     NEXT FIELD CURRENT
                  END IF
               END IF  #160822-00008#6

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmag_m.fmagsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmag_m.fmagsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmag_m.fmagsite_desc
            LET g_fmag_m_o.* = g_fmag_m.*   #160822-00008#6

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmagsite
            #add-point:BEFORE FIELD fmagsite name="input.b.fmagsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmagsite
            #add-point:ON CHANGE fmagsite name="input.g.fmagsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmagdocdt
            #add-point:BEFORE FIELD fmagdocdt name="input.b.fmagdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmagdocdt
            
            #add-point:AFTER FIELD fmagdocdt name="input.a.fmagdocdt"
            CALL s_anm_date_chk(g_fmag_m.fmagsite,g_fmag_m.fmagdocdt) RETURNING l_success
            IF NOT l_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = "afm-00208"
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmagdocdt
            #add-point:ON CHANGE fmagdocdt name="input.g.fmagdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmagdocno
            #add-point:BEFORE FIELD fmagdocno name="input.b.fmagdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmagdocno
            
            #add-point:AFTER FIELD fmagdocno name="input.a.fmagdocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_fmag_m.fmagdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fmag_m.fmagdocno != g_fmagdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmag_t WHERE "||"fmagent = '" ||g_enterprise|| "' AND "||"fmagdocno = '"||g_fmag_m.fmagdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_fmag_m.fmagdocno) THEN
               CALL s_aooi200_fin_chk_slip(g_glaald,g_glaa024,g_fmag_m.fmagdocno,'afmt025') RETURNING l_success
               IF l_success = FALSE THEN
                  LET g_fmag_m.fmagdocno = g_fmag_m_t.fmagdocno
                  NEXT FIELD fmagdocno
               END IF
               #161104-00046#15-----s
               CALL s_control_chk_doc('1',g_fmag_m.fmagdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
               IF g_sub_success AND l_flag THEN             
               ELSE
                  LET g_fmag_m.fmagdocno = g_fmag_m_o.fmagdocno 
                  NEXT FIELD CURRENT                  
               END IF
               CALL s_aooi200_fin_get_slip(g_fmag_m.fmagdocno) RETURNING g_sub_success,l_slip
               #刪除單別預設temptable
               DELETE FROM s_aooi200def1
               #以目前畫面資訊新增temp資料   #請勿調整.*
               INSERT INTO s_aooi200def1 VALUES(g_fmag_m.*)
               #依單別預設取用資訊
               CALL s_aooi200def_get('','',g_fmag_m.fmagsite,'2',l_slip,'','',g_glaald)
               #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
               SELECT * INTO g_fmag_m.* FROM s_aooi200def1
               #161104-00046#15-----e  
            END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmagdocno
            #add-point:ON CHANGE fmagdocno name="input.g.fmagdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmagstus
            #add-point:BEFORE FIELD fmagstus name="input.b.fmagstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmagstus
            
            #add-point:AFTER FIELD fmagstus name="input.a.fmagstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmagstus
            #add-point:ON CHANGE fmagstus name="input.g.fmagstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fmagsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmagsite
            #add-point:ON ACTION controlp INFIELD fmagsite name="input.c.fmagsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmag_m.fmagsite             #給予default值
            LET g_qryparam.default2 = "" #g_fmag_m.ooef001 #组织编号
            #LET g_qryparam.where = " ooef206 = 'Y'"  #161006-00005#34 mark
            #給予arg
            LET g_qryparam.arg1 = "" #


            #CALL q_ooef001()                                #呼叫開窗     #161006-00005#34 mark
            CALL q_ooef001_33()                              #161006-00005#34 add
            LET g_fmag_m.fmagsite = g_qryparam.return1              
            #LET g_fmag_m.ooef001 = g_qryparam.return2 
            LET g_qryparam.where = " "
            CALL afmt025_fmagsite_ref()
            LET g_fmag_m.fmagsite_desc = s_desc_get_department_desc(g_fmag_m.fmagsite)
            DISPLAY g_fmag_m.fmagsite_desc TO fmagsite_desc
            DISPLAY g_fmag_m.fmagsite TO fmagsite              #
            #DISPLAY g_fmag_m.ooef001 TO ooef001 #组织编号
            NEXT FIELD fmagsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmagdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmagdocdt
            #add-point:ON ACTION controlp INFIELD fmagdocdt name="input.c.fmagdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmagdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmagdocno
            #add-point:ON ACTION controlp INFIELD fmagdocno name="input.c.fmagdocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmag_m.fmagdocno             #給予default值
            LET g_qryparam.where = "ooba001 = '",g_glaa024,"' AND oobx003 = 'afmt025'"
            #給予arg
            LET g_qryparam.arg1 = "" #
            #161104-00046#15-----s
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_slip_wc CLIPPED
            END IF
            #161104-00046#15-----e

            CALL q_ooba002_4()                                #呼叫開窗

            LET g_fmag_m.fmagdocno = g_qryparam.return1       
            LET g_qryparam.where = ""            

            DISPLAY g_fmag_m.fmagdocno TO fmagdocno              #

            NEXT FIELD fmagdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmagstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmagstus
            #add-point:ON ACTION controlp INFIELD fmagstus name="input.c.fmagstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_fmag_m.fmagdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_fin_gen_docno(g_glaald,g_glaa024,g_glaa003,g_fmag_m.fmagdocno,g_fmag_m.fmagdocdt,g_prog)
                     RETURNING l_success,g_fmag_m.fmagdocno
               IF l_success  = 0  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_fmag_m.fmagdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD fmagdocno
               END IF
               DISPLAY BY NAME g_fmag_m.fmagdocno
               #end add-point
               
               INSERT INTO fmag_t (fmagent,fmagsite,fmagdocdt,fmagdocno,fmagstus,fmagownid,fmagowndp, 
                   fmagcrtid,fmagcrtdp,fmagcrtdt,fmagmodid,fmagmoddt,fmagcnfid,fmagcnfdt)
               VALUES (g_enterprise,g_fmag_m.fmagsite,g_fmag_m.fmagdocdt,g_fmag_m.fmagdocno,g_fmag_m.fmagstus, 
                   g_fmag_m.fmagownid,g_fmag_m.fmagowndp,g_fmag_m.fmagcrtid,g_fmag_m.fmagcrtdp,g_fmag_m.fmagcrtdt, 
                   g_fmag_m.fmagmodid,g_fmag_m.fmagmoddt,g_fmag_m.fmagcnfid,g_fmag_m.fmagcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_fmag_m:",SQLERRMESSAGE 
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
                  CALL afmt025_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL afmt025_b_fill()
                  CALL afmt025_b_fill2('0')
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
               CALL afmt025_fmag_t_mask_restore('restore_mask_o')
               
               UPDATE fmag_t SET (fmagsite,fmagdocdt,fmagdocno,fmagstus,fmagownid,fmagowndp,fmagcrtid, 
                   fmagcrtdp,fmagcrtdt,fmagmodid,fmagmoddt,fmagcnfid,fmagcnfdt) = (g_fmag_m.fmagsite, 
                   g_fmag_m.fmagdocdt,g_fmag_m.fmagdocno,g_fmag_m.fmagstus,g_fmag_m.fmagownid,g_fmag_m.fmagowndp, 
                   g_fmag_m.fmagcrtid,g_fmag_m.fmagcrtdp,g_fmag_m.fmagcrtdt,g_fmag_m.fmagmodid,g_fmag_m.fmagmoddt, 
                   g_fmag_m.fmagcnfid,g_fmag_m.fmagcnfdt)
                WHERE fmagent = g_enterprise AND fmagdocno = g_fmagdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fmag_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL afmt025_fmag_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_fmag_m_t)
               LET g_log2 = util.JSON.stringify(g_fmag_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_fmagdocno_t = g_fmag_m.fmagdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="afmt025.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_fmah_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmah_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt025_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_fmah_d.getLength()
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
            OPEN afmt025_cl USING g_enterprise,g_fmag_m.fmagdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt025_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt025_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmah_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmah_d[l_ac].fmahseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fmah_d_t.* = g_fmah_d[l_ac].*  #BACKUP
               LET g_fmah_d_o.* = g_fmah_d[l_ac].*  #BACKUP
               CALL afmt025_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL afmt025_set_no_entry_b(l_cmd)
               IF NOT afmt025_lock_b("fmah_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt025_bcl INTO g_fmah_d[l_ac].fmahseq,g_fmah_d[l_ac].fmah001,g_fmah_d[l_ac].fmah002, 
                      g_fmah_d[l_ac].fmah003,g_fmah_d[l_ac].fmah004,g_fmah_d[l_ac].fmah005,g_fmah_d[l_ac].fmah006, 
                      g_fmah_d[l_ac].fmah007,g_fmah_d[l_ac].fmah008,g_fmah_d[l_ac].fmah009,g_fmah_d[l_ac].fmah010 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmah_d_t.fmahseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmah_d_mask_o[l_ac].* =  g_fmah_d[l_ac].*
                  CALL afmt025_fmah_t_mask()
                  LET g_fmah_d_mask_n[l_ac].* =  g_fmah_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt025_show()
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
            INITIALIZE g_fmah_d[l_ac].* TO NULL 
            INITIALIZE g_fmah_d_t.* TO NULL 
            INITIALIZE g_fmah_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_fmah_d[l_ac].fmah007 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            IF l_cmd = 'a' THEN
               IF cl_null(g_fmah_d[l_ac].fmahseq) OR g_fmah_d[l_ac].fmahseq = 0 THEN
                  SELECT MAX(fmahseq) INTO g_fmah_d[l_ac].fmahseq
                    FROM fmah_t
                   WHERE fmahent = g_enterprise
                     AND fmahdocno = g_fmag_m.fmagdocno
               
                  IF cl_null(g_fmah_d[l_ac].fmahseq) THEN
                     LET g_fmah_d[l_ac].fmahseq = 1
                  ELSE
                     LET g_fmah_d[l_ac].fmahseq = g_fmah_d[l_ac].fmahseq + 1
                  END IF
               END IF
            END IF
            #end add-point
            LET g_fmah_d_t.* = g_fmah_d[l_ac].*     #新輸入資料
            LET g_fmah_d_o.* = g_fmah_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt025_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt025_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmah_d[li_reproduce_target].* = g_fmah_d[li_reproduce].*
 
               LET g_fmah_d[li_reproduce_target].fmahseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM fmah_t 
             WHERE fmahent = g_enterprise AND fmahdocno = g_fmag_m.fmagdocno
 
               AND fmahseq = g_fmah_d[l_ac].fmahseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmag_m.fmagdocno
               LET gs_keys[2] = g_fmah_d[g_detail_idx].fmahseq
               CALL afmt025_insert_b('fmah_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_fmah_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmah_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt025_b_fill()
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
               LET gs_keys[01] = g_fmag_m.fmagdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_fmah_d_t.fmahseq
 
            
               #刪除同層單身
               IF NOT afmt025_delete_b('fmah_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt025_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt025_key_delete_b(gs_keys,'fmah_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt025_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt025_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_fmah_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmah_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmahseq
            #add-point:BEFORE FIELD fmahseq name="input.b.page1.fmahseq"
            IF cl_null(g_fmah_d[g_detail_idx].fmahseq) OR g_fmah_d[g_detail_idx].fmahseq = 0 THEN
               SELECT MAX(fmahseq) INTO g_fmah_d[g_detail_idx].fmahseq
                 FROM fmah_t
                WHERE fmahent = g_enterprise
                  AND fmahdocno = g_fmag_m.fmagdocno
               
               IF cl_null(g_fmah_d[g_detail_idx].fmahseq) THEN
                  LET g_fmah_d[g_detail_idx].fmahseq = 1
               ELSE
                  LET g_fmah_d[g_detail_idx].fmahseq = g_fmah_d[g_detail_idx].fmahseq + 1
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmahseq
            
            #add-point:AFTER FIELD fmahseq name="input.a.page1.fmahseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmag_m.fmagdocno IS NOT NULL AND g_fmah_d[g_detail_idx].fmahseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmag_m.fmagdocno != g_fmagdocno_t OR g_fmah_d[g_detail_idx].fmahseq != g_fmah_d_t.fmahseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmah_t WHERE "||"fmahent = '" ||g_enterprise|| "' AND "||"fmahdocno = '"||g_fmag_m.fmagdocno ||"' AND "|| "fmahseq = '"||g_fmah_d[g_detail_idx].fmahseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmahseq
            #add-point:ON CHANGE fmahseq name="input.g.page1.fmahseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah001
            
            #add-point:AFTER FIELD fmah001 name="input.a.page1.fmah001"
            IF NOT cl_null(g_fmah_d[l_ac].fmah001) THEN 
               IF g_fmah_d[l_ac].fmah001 != g_fmah_d_o.fmah001 OR cl_null(g_fmah_d_o.fmah001) THEN #160822-00008#6
#應用 a17 樣板自動產生(Version:2)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_fmah_d[l_ac].fmah001
                  #160318-00025#6--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "afm-00140:sub-01302|afmi010|",cl_get_progname("afmi010",g_lang,"2"),"|:EXEPROGafmi010"
                  #160318-00025#6--add--end 
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_fmaa001") THEN
                     #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     #160822-00008#6---(S)
                     LET g_fmah_d[l_ac].fmah001 = g_fmah_d_o.fmah001  
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = g_fmah_d[l_ac].fmah001
                     CALL ap_ref_array2(g_ref_fields,"SELECT fmaal003 FROM fmaal_t WHERE fmaalent='"||g_enterprise||"' AND fmaal001=? AND fmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                     LET g_fmah_d[l_ac].fmah001_desc = '', g_rtn_fields[1] , ''
                     DISPLAY BY NAME g_fmah_d[l_ac].fmah001_desc
                     #160822-00008#6---(E)    
                     NEXT FIELD CURRENT
                  END IF
               END IF   #160822-00008#6

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmah_d[l_ac].fmah001
            CALL ap_ref_array2(g_ref_fields,"SELECT fmaal003 FROM fmaal_t WHERE fmaalent='"||g_enterprise||"' AND fmaal001=? AND fmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmah_d[l_ac].fmah001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmah_d[l_ac].fmah001_desc
            LET g_fmah_d_o.* = g_fmah_d[l_ac].*   #160822-00008#6

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah001
            #add-point:BEFORE FIELD fmah001 name="input.b.page1.fmah001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmah001
            #add-point:ON CHANGE fmah001 name="input.g.page1.fmah001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah002
            
            #add-point:AFTER FIELD fmah002 name="input.a.page1.fmah002"
            IF NOT cl_null(g_fmah_d[l_ac].fmah002) THEN 
               IF g_fmah_d[l_ac].fmah002 != g_fmah_d_o.fmah002 OR cl_null(g_fmah_d_o.fmah002) THEN  #160822-00008#6
#應用 a17 樣板自動產生(Version:2)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_fmah_d[l_ac].fmah002
                  
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooef001_42") THEN
                     #檢查成功時後續處理
                     LET g_fmah_d[l_ac].ooef001      = '' #160822-00008#6
                     LET g_fmah_d[l_ac].ooef001_desc = '' #160822-00008#6
                     CALL afmt025_ooef017(g_fmah_d[l_ac].fmah002) 
                       RETURNING g_fmah_d[l_ac].ooef001,g_fmah_d[l_ac].ooef001_desc
                  ELSE
                     #檢查失敗時後續處理
                     #160822-00008#6---(S)
                     LET g_fmah_d[l_ac].fmah002 = g_fmah_d_o.fmah002 
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = g_fmah_d[l_ac].fmah002
                     CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                     LET g_fmah_d[l_ac].fmah002_desc = '', g_rtn_fields[1] , ''
                     DISPLAY BY NAME g_fmah_d[l_ac].fmah002_desc
                     #160822-00008#6---(E)
                     NEXT FIELD CURRENT
                  END IF
               END IF  #160822-00008#6

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmah_d[l_ac].fmah002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmah_d[l_ac].fmah002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmah_d[l_ac].fmah002_desc
            
            LET g_fmah_d_o.* = g_fmah_d[l_ac].*  #160822-00008#6
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah002
            #add-point:BEFORE FIELD fmah002 name="input.b.page1.fmah002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmah002
            #add-point:ON CHANGE fmah002 name="input.g.page1.fmah002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooef001
            
            #add-point:AFTER FIELD ooef001 name="input.a.page1.ooef001"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmah_d[l_ac].ooef001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmah_d[l_ac].ooef001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmah_d[l_ac].ooef001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooef001
            #add-point:BEFORE FIELD ooef001 name="input.b.page1.ooef001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooef001
            #add-point:ON CHANGE ooef001 name="input.g.page1.ooef001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah003
            #add-point:BEFORE FIELD fmah003 name="input.b.page1.fmah003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah003
            
            #add-point:AFTER FIELD fmah003 name="input.a.page1.fmah003"
            IF NOT cl_null(g_fmah_d[l_ac].fmah003) THEN
               IF g_fmah_d[l_ac].fmah003 != g_fmah_d_o.fmah003 OR cl_null(g_fmah_d_o.fmah003) THEN #160822-00008#6
                  LET g_errno = ''
                  CALL afmt025_fmah003_chk(g_fmah_d[l_ac].fmah003,g_fmah_d[l_ac].fmah004) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmah_d[l_ac].fmah003||g_fmah_d[l_ac].fmah004
                     LET g_errparam.code   = g_errno 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     #160822-00008#6---(S)
                     LET g_fmah_d[l_ac].fmah003 = g_fmah_d_o.fmah003  #160822-00008#6
                     LET g_fmah_d[l_ac].fmah004 = g_fmah_d_o.fmah004  #160822-00008#6 
                     LET g_fmah_d[l_ac].fmah005      = ''
                     LET g_fmah_d[l_ac].fmah005_desc = ''
                     LET g_fmah_d[l_ac].fmah006      = ''
                     LET g_fmah_d[l_ac].fmah007      = ''                     
                     CALL afmt025_fmah003_ref(g_fmah_d[l_ac].fmah003,g_fmah_d[l_ac].fmah004)
                        RETURNING g_fmah_d[l_ac].fmah005,g_fmah_d[l_ac].fmah005_desc,g_fmah_d[l_ac].fmah006,g_fmah_d[l_ac].fmah007
                     #160822-00008#6---(E)
                     NEXT FIELD CURRENT
                  END IF
                  #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmag_m.fmagdocno != g_fmagdocno_t OR g_fmah_d[g_detail_idx].fmah003 != g_fmah_d_t.fmah003)) THEN  #160822-00008#6 Mark
                  IF g_fmag_m.fmagdocno != g_fmag_m_o.fmagdocno OR cl_null(g_fmag_m_o.fmagdocno) OR g_fmah_d[g_detail_idx].fmah003 != g_fmah_d_o.fmah003 OR cl_null(g_fmah_d_o.fmah003) THEN #160822-00008#6 
                     IF NOT cl_null(g_fmah_d[l_ac].fmah003) AND NOT cl_null(g_fmah_d[l_ac].fmah004) THEN
                        #160822-00008#6---(S)
                        LET g_fmah_d[l_ac].fmah005      = ''
                        LET g_fmah_d[l_ac].fmah005_desc = ''
                        LET g_fmah_d[l_ac].fmah006      = ''
                        LET g_fmah_d[l_ac].fmah007      = ''
                        #160822-00008#6---(E)
                        CALL afmt025_fmah003_ref(g_fmah_d[l_ac].fmah003,g_fmah_d[l_ac].fmah004)
                           RETURNING g_fmah_d[l_ac].fmah005,g_fmah_d[l_ac].fmah005_desc,g_fmah_d[l_ac].fmah006,g_fmah_d[l_ac].fmah007
                     END IF
                  END IF #160822-00008#6
               END IF   
            END IF
            LET g_fmah_d_o.* = g_fmah_d[l_ac].*  #160822-00008#6
            LET g_fmag_m_o.* = g_fmag_m.*        #160822-00008#6
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmah003
            #add-point:ON CHANGE fmah003 name="input.g.page1.fmah003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah004
            #add-point:BEFORE FIELD fmah004 name="input.b.page1.fmah004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah004
            
            #add-point:AFTER FIELD fmah004 name="input.a.page1.fmah004"
            IF NOT cl_null(g_fmah_d[l_ac].fmah004) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmag_m.fmagdocno != g_fmagdocno_t OR g_fmah_d[g_detail_idx].fmah004 != g_fmah_d_t.fmah004)) THEN  #160822-00008#6 mark
               IF g_fmag_m.fmagdocno != g_fmag_m_o.fmagdocno OR cl_null(g_fmag_m_o.fmagdocno) OR g_fmah_d[g_detail_idx].fmah004 != g_fmah_d_o.fmah004 OR cl_null(g_fmah_d_o.fmah004) THEN #160822-00008#6
                   LET g_errno = ''
                   CALL afmt025_fmah003_chk(g_fmah_d[l_ac].fmah003,g_fmah_d[l_ac].fmah004) 
                   IF NOT cl_null(g_errno) THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_fmah_d[l_ac].fmah003||g_fmah_d[l_ac].fmah004
                      LET g_errparam.code   = g_errno 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET g_fmah_d[g_detail_idx].fmah004 = g_fmah_d_o.fmah004 #160822-00008#6
                      NEXT FIELD CURRENT
                   END IF
                   IF NOT cl_null(g_fmah_d[l_ac].fmah003) AND NOT cl_null(g_fmah_d[l_ac].fmah004) THEN
                      #160822-00008#6---(S)
                      LET g_fmah_d[l_ac].fmah005 = ''       
                      LET g_fmah_d[l_ac].fmah005_desc = ''  
                      LET g_fmah_d[l_ac].fmah006 = ''       
                      LET g_fmah_d[l_ac].fmah007 = ''   
                      #160822-00008#6---(E)
                      CALL afmt025_fmah003_ref(g_fmah_d[l_ac].fmah003,g_fmah_d[l_ac].fmah004)
                         RETURNING g_fmah_d[l_ac].fmah005,g_fmah_d[l_ac].fmah005_desc,g_fmah_d[l_ac].fmah006,g_fmah_d[l_ac].fmah007
                   END IF
               END IF
            END IF
            LET g_fmag_m_o.* = g_fmag_m.* #160822-00008#6
            LET g_fmah_d_o.* = g_fmah_d[l_ac].* #160822-00008#6
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmah004
            #add-point:ON CHANGE fmah004 name="input.g.page1.fmah004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah005
            
            #add-point:AFTER FIELD fmah005 name="input.a.page1.fmah005"
            IF NOT cl_null(g_fmah_d[l_ac].fmah005) THEN 
               IF g_fmah_d[l_ac].fmah005 != g_fmah_d_o.fmah005 OR cl_null(g_fmah_d_o.fmah005) THEN #160822-00008#6 
#應用 a17 樣板自動產生(Version:2)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_fmah_d[l_ac].fmah005
                  
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_fmac003") THEN
                     #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     #160822-00008#6---(S)
                     LET g_fmah_d[l_ac].fmah005 = g_fmah_d_o.fmah005  
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = g_fmah_d[l_ac].fmah005
                     CALL ap_ref_array2(g_ref_fields,"SELECT nmabl003 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                     LET g_fmah_d[l_ac].fmah005_desc = '', g_rtn_fields[1] , ''
                     DISPLAY BY NAME g_fmah_d[l_ac].fmah005_desc
                     #160822-00008#6---(E)
                     NEXT FIELD CURRENT
                  END IF
               END IF  #160822-00008#6 
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmah_d[l_ac].fmah005
            CALL ap_ref_array2(g_ref_fields,"SELECT nmabl003 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmah_d[l_ac].fmah005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmah_d[l_ac].fmah005_desc
            LET g_fmah_d_o.* = g_fmah_d[l_ac].* #160822-00008#6

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah005
            #add-point:BEFORE FIELD fmah005 name="input.b.page1.fmah005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmah005
            #add-point:ON CHANGE fmah005 name="input.g.page1.fmah005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah006
            
            #add-point:AFTER FIELD fmah006 name="input.a.page1.fmah006"
            IF NOT cl_null(g_fmah_d[l_ac].fmah006) THEN 
               IF g_fmah_d[l_ac].fmah006 != g_fmah_d_o.fmah006 OR cl_null(g_fmah_d_o.fmah006) THEN #160822-00008#6 
#應用 a17 樣板自動產生(Version:2)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_fmah_d[l_ac].fmah006
                  #160318-00025#6--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
                  #160318-00025#6--add--end
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooai001") THEN
                     #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     LET g_fmah_d[l_ac].fmah006 = g_fmah_d_o.fmah006 #160822-00008#6 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_fmah_d_o.* = g_fmah_d[l_ac].*  #160822-00008#6

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah006
            #add-point:BEFORE FIELD fmah006 name="input.b.page1.fmah006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmah006
            #add-point:ON CHANGE fmah006 name="input.g.page1.fmah006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmah_d[l_ac].fmah007,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmah007
            END IF 
 
 
 
            #add-point:AFTER FIELD fmah007 name="input.a.page1.fmah007"
            IF NOT cl_null(g_fmah_d[l_ac].fmah007) THEN 
               IF g_fmah_d[l_ac].fmah007 != g_fmah_d_o.fmah007 OR cl_null(g_fmah_d_o.fmah007) THEN #160822-00008#6 
                  CALL afmt025_fmah007_chk(l_cmd) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmah_d[l_ac].fmah007
                     LET g_errparam.code   = 'afm-00147'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_fmah_d[l_ac].fmah007 = g_fmah_d_o.fmah007 #160822-00008#6 
                     NEXT FIELD CURRENT
                  END IF
               END IF   #160822-00008#6 
            END IF 
            LET g_fmah_d_o.* = g_fmah_d[l_ac].*   #160822-00008#6 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah007
            #add-point:BEFORE FIELD fmah007 name="input.b.page1.fmah007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmah007
            #add-point:ON CHANGE fmah007 name="input.g.page1.fmah007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah008
            #add-point:BEFORE FIELD fmah008 name="input.b.page1.fmah008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah008
            
            #add-point:AFTER FIELD fmah008 name="input.a.page1.fmah008"
            IF NOT cl_null(g_fmah_d[l_ac].fmah008) THEN
               CALL afmt025_fmah008_chk(g_fmah_d[l_ac].fmah008) RETURNING l_errno 
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmah_d[l_ac].fmah008
                  LET g_errparam.code   = l_errno 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmah008
            #add-point:ON CHANGE fmah008 name="input.g.page1.fmah008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah009
            #add-point:BEFORE FIELD fmah009 name="input.b.page1.fmah009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah009
            
            #add-point:AFTER FIELD fmah009 name="input.a.page1.fmah009"
            IF NOT cl_null(g_fmah_d[l_ac].fmah009) THEN
               CALL afmt025_fmah008_chk(g_fmah_d[l_ac].fmah009) RETURNING l_errno 
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmah_d[l_ac].fmah009
                  LET g_errparam.code   = l_errno 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmah009
            #add-point:ON CHANGE fmah009 name="input.g.page1.fmah009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmah_d[l_ac].fmah010,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmah010
            END IF 
 
 
 
            #add-point:AFTER FIELD fmah010 name="input.a.page1.fmah010"
            IF NOT cl_null(g_fmah_d[l_ac].fmah010) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah010
            #add-point:BEFORE FIELD fmah010 name="input.b.page1.fmah010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmah010
            #add-point:ON CHANGE fmah010 name="input.g.page1.fmah010"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.fmahseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmahseq
            #add-point:ON ACTION controlp INFIELD fmahseq name="input.c.page1.fmahseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmah001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah001
            #add-point:ON ACTION controlp INFIELD fmah001 name="input.c.page1.fmah001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmah_d[l_ac].fmah001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_fmaa001_1()                                #呼叫開窗

            LET g_fmah_d[l_ac].fmah001 = g_qryparam.return1    
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmah_d[l_ac].fmah001
            CALL ap_ref_array2(g_ref_fields,"SELECT fmaal003 FROM fmaal_t WHERE fmaalent='"||g_enterprise||"' AND fmaal001=? AND fmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmah_d[l_ac].fmah001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmah_d[l_ac].fmah001_desc            

            DISPLAY g_fmah_d[l_ac].fmah001 TO fmah001              #

            NEXT FIELD fmah001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fmah002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah002
            #add-point:ON ACTION controlp INFIELD fmah002 name="input.c.page1.fmah002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmah_d[l_ac].fmah002             #給予default值
            LET g_qryparam.default2 = "" #g_fmah_d[l_ac].ooef001 #组织编号
            #LET g_qryparam.where = " ooef206 = 'Y'"  #161006-00005#34 mark
            #給予arg
            LET g_qryparam.arg1 = "" #


            #CALL q_ooef001()                                #呼叫開窗 #161006-00005#34 mark
            CALL q_ooef001_33()                                       #161006-00005#34 add
            LET g_fmah_d[l_ac].fmah002 = g_qryparam.return1    
            CALL afmt025_ooef017(g_fmah_d[l_ac].fmah002) 
              RETURNING g_fmah_d[l_ac].ooef001,g_fmah_d[l_ac].ooef001_desc 
            LET g_fmah_d[l_ac].fmah002_desc = s_desc_get_department_desc(g_fmah_d[l_ac].fmah002)  
            LET g_qryparam.where = " "            
            #LET g_fmah_d[l_ac].ooef001 = g_qryparam.return2 
            DISPLAY g_fmah_d[l_ac].fmah002 TO fmah002              #
            #DISPLAY g_fmah_d[l_ac].ooef001 TO ooef001 #组织编号
            NEXT FIELD fmah002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.ooef001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooef001
            #add-point:ON ACTION controlp INFIELD ooef001 name="input.c.page1.ooef001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmah003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah003
            #add-point:ON ACTION controlp INFIELD fmah003 name="input.c.page1.fmah003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmah_d[l_ac].fmah003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            IF NOT cl_null(g_fmah_d[l_ac].fmah002) THEN
               LET g_qryparam.where = " fmac002='",g_fmah_d[l_ac].fmah002,"'"
            END IF


            CALL q_fmac001_1()                                #呼叫開窗

            LET g_fmah_d[l_ac].fmah003 = g_qryparam.return1   
            LET g_fmah_d[l_ac].fmah004 = g_qryparam.return2              
            LET g_qryparam.where = ""            

            DISPLAY g_fmah_d[l_ac].fmah003 TO fmah003              #

            NEXT FIELD fmah003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fmah004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah004
            #add-point:ON ACTION controlp INFIELD fmah004 name="input.c.page1.fmah004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmah_d[l_ac].fmah003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            IF NOT cl_null(g_fmah_d[l_ac].fmah002) THEN
               LET g_qryparam.where = " fmac002='",g_fmah_d[l_ac].fmah002,"'"
            END IF

            CALL q_fmac001_1()                                #呼叫開窗

            LET g_fmah_d[l_ac].fmah003 = g_qryparam.return1    
            LET g_fmah_d[l_ac].fmah004 = g_qryparam.return2
            LET g_qryparam.where = ""            

            DISPLAY g_fmah_d[l_ac].fmah004 TO fmah004              #

            NEXT FIELD fmah004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmah005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah005
            #add-point:ON ACTION controlp INFIELD fmah005 name="input.c.page1.fmah005"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmah_d[l_ac].fmah005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_nmab001()                                #呼叫開窗

            LET g_fmah_d[l_ac].fmah005 = g_qryparam.return1              

            DISPLAY g_fmah_d[l_ac].fmah005 TO fmah005              #

            NEXT FIELD fmah005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fmah006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah006
            #add-point:ON ACTION controlp INFIELD fmah006 name="input.c.page1.fmah006"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmah_d[l_ac].fmah006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooai001()                                #呼叫開窗

            LET g_fmah_d[l_ac].fmah006 = g_qryparam.return1              

            DISPLAY g_fmah_d[l_ac].fmah006 TO fmah006              #

            NEXT FIELD fmah006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fmah007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah007
            #add-point:ON ACTION controlp INFIELD fmah007 name="input.c.page1.fmah007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmah008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah008
            #add-point:ON ACTION controlp INFIELD fmah008 name="input.c.page1.fmah008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmah009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah009
            #add-point:ON ACTION controlp INFIELD fmah009 name="input.c.page1.fmah009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmah010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah010
            #add-point:ON ACTION controlp INFIELD fmah010 name="input.c.page1.fmah010"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fmah_d[l_ac].* = g_fmah_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt025_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_fmah_d[l_ac].fmahseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_fmah_d[l_ac].* = g_fmah_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL afmt025_fmah_t_mask_restore('restore_mask_o')
      
               UPDATE fmah_t SET (fmahdocno,fmahseq,fmah001,fmah002,fmah003,fmah004,fmah005,fmah006, 
                   fmah007,fmah008,fmah009,fmah010) = (g_fmag_m.fmagdocno,g_fmah_d[l_ac].fmahseq,g_fmah_d[l_ac].fmah001, 
                   g_fmah_d[l_ac].fmah002,g_fmah_d[l_ac].fmah003,g_fmah_d[l_ac].fmah004,g_fmah_d[l_ac].fmah005, 
                   g_fmah_d[l_ac].fmah006,g_fmah_d[l_ac].fmah007,g_fmah_d[l_ac].fmah008,g_fmah_d[l_ac].fmah009, 
                   g_fmah_d[l_ac].fmah010)
                WHERE fmahent = g_enterprise AND fmahdocno = g_fmag_m.fmagdocno 
 
                  AND fmahseq = g_fmah_d_t.fmahseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmah_d[l_ac].* = g_fmah_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmah_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmah_d[l_ac].* = g_fmah_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmah_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmag_m.fmagdocno
               LET gs_keys_bak[1] = g_fmagdocno_t
               LET gs_keys[2] = g_fmah_d[g_detail_idx].fmahseq
               LET gs_keys_bak[2] = g_fmah_d_t.fmahseq
               CALL afmt025_update_b('fmah_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL afmt025_fmah_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_fmah_d[g_detail_idx].fmahseq = g_fmah_d_t.fmahseq 
 
                  ) THEN
                  LET gs_keys[01] = g_fmag_m.fmagdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_fmah_d_t.fmahseq
 
                  CALL afmt025_key_update_b(gs_keys,'fmah_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmag_m),util.JSON.stringify(g_fmah_d_t)
               LET g_log2 = util.JSON.stringify(g_fmag_m),util.JSON.stringify(g_fmah_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL afmt025_unlock_b("fmah_t","'1'")
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
               LET g_fmah_d[li_reproduce_target].* = g_fmah_d[li_reproduce].*
 
               LET g_fmah_d[li_reproduce_target].fmahseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmah_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmah_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_fmah2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmah2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt025_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_fmah2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fmah2_d[l_ac].* TO NULL 
            INITIALIZE g_fmah2_d_t.* TO NULL 
            INITIALIZE g_fmah2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_fmah2_d_t.* = g_fmah2_d[l_ac].*     #新輸入資料
            LET g_fmah2_d_o.* = g_fmah2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt025_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            IF l_cmd = 'a' THEN
               IF cl_null(g_fmah2_d[g_detail_idx].fmaiseq2) OR g_fmah2_d[g_detail_idx].fmaiseq2 = 0 THEN
                  SELECT MAX(fmaiseq2) INTO g_fmah2_d[g_detail_idx].fmaiseq2
                    FROM fmai_t
                   WHERE fmaient = g_enterprise
                     AND fmaidocno = g_fmag_m.fmagdocno
               
                  IF cl_null(g_fmah2_d[g_detail_idx].fmaiseq2) THEN
                     LET g_fmah2_d[g_detail_idx].fmaiseq2 = 1
                  ELSE
                     LET g_fmah2_d[g_detail_idx].fmaiseq2 = g_fmah2_d[g_detail_idx].fmaiseq2 + 1
                  END IF
               END IF
               LET g_fmah2_d[l_ac].fmai001 = g_site
               CALL afmt025_ooef017(g_fmah2_d[l_ac].fmai001) 
                 RETURNING g_fmah2_d[l_ac].glaacomp,g_fmah2_d[l_ac].glaacomp_desc 
               LET g_fmah2_d[l_ac].fmai001_desc = s_desc_get_department_desc(g_fmah2_d[l_ac].fmai001) 
            END IF
            #end add-point
            CALL afmt025_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmah2_d[li_reproduce_target].* = g_fmah2_d[li_reproduce].*
 
               LET g_fmah2_d[li_reproduce_target].fmaiseq = NULL
               LET g_fmah2_d[li_reproduce_target].fmaiseq2 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[2] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 2
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN afmt025_cl USING g_enterprise,g_fmag_m.fmagdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt025_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt025_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmah2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmah2_d[l_ac].fmaiseq IS NOT NULL
               AND g_fmah2_d[l_ac].fmaiseq2 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fmah2_d_t.* = g_fmah2_d[l_ac].*  #BACKUP
               LET g_fmah2_d_o.* = g_fmah2_d[l_ac].*  #BACKUP
               CALL afmt025_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL afmt025_set_no_entry_b(l_cmd)
               IF NOT afmt025_lock_b("fmai_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt025_bcl2 INTO g_fmah2_d[l_ac].fmaiseq2,g_fmah2_d[l_ac].fmai001,g_fmah2_d[l_ac].fmai002, 
                      g_fmah2_d[l_ac].fmai003,g_fmah2_d[l_ac].fmaiseq,g_fmah2_d[l_ac].fmai004
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmah2_d_mask_o[l_ac].* =  g_fmah2_d[l_ac].*
                  CALL afmt025_fmai_t_mask()
                  LET g_fmah2_d_mask_n[l_ac].* =  g_fmah2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt025_show()
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
               LET gs_keys[01] = g_fmag_m.fmagdocno
               LET gs_keys[gs_keys.getLength()+1] = g_fmah2_d_t.fmaiseq
               LET gs_keys[gs_keys.getLength()+1] = g_fmah2_d_t.fmaiseq2
            
               #刪除同層單身
               IF NOT afmt025_delete_b('fmai_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt025_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt025_key_delete_b(gs_keys,'fmai_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt025_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt025_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_fmah_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmah2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM fmai_t 
             WHERE fmaient = g_enterprise AND fmaidocno = g_fmag_m.fmagdocno
               AND fmaiseq = g_fmah2_d[l_ac].fmaiseq
               AND fmaiseq2 = g_fmah2_d[l_ac].fmaiseq2
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmag_m.fmagdocno
               LET gs_keys[2] = g_fmah2_d[g_detail_idx].fmaiseq
               LET gs_keys[3] = g_fmah2_d[g_detail_idx].fmaiseq2
               CALL afmt025_insert_b('fmai_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fmah_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "fmai_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt025_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fmah2_d[l_ac].* = g_fmah2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt025_bcl2
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
               LET g_fmah2_d[l_ac].* = g_fmah2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL afmt025_fmai_t_mask_restore('restore_mask_o')
                              
               UPDATE fmai_t SET (fmaidocno,fmaiseq2,fmai001,fmai002,fmai003,fmaiseq,fmai004) = (g_fmag_m.fmagdocno, 
                   g_fmah2_d[l_ac].fmaiseq2,g_fmah2_d[l_ac].fmai001,g_fmah2_d[l_ac].fmai002,g_fmah2_d[l_ac].fmai003, 
                   g_fmah2_d[l_ac].fmaiseq,g_fmah2_d[l_ac].fmai004) #自訂欄位頁簽
                WHERE fmaient = g_enterprise AND fmaidocno = g_fmag_m.fmagdocno
                  AND fmaiseq = g_fmah2_d_t.fmaiseq #項次 
                  AND fmaiseq2 = g_fmah2_d_t.fmaiseq2
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmah2_d[l_ac].* = g_fmah2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmai_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmah2_d[l_ac].* = g_fmah2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmai_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmag_m.fmagdocno
               LET gs_keys_bak[1] = g_fmagdocno_t
               LET gs_keys[2] = g_fmah2_d[g_detail_idx].fmaiseq
               LET gs_keys_bak[2] = g_fmah2_d_t.fmaiseq
               LET gs_keys[3] = g_fmah2_d[g_detail_idx].fmaiseq2
               LET gs_keys_bak[3] = g_fmah2_d_t.fmaiseq2
               CALL afmt025_update_b('fmai_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt025_fmai_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_fmah2_d[g_detail_idx].fmaiseq = g_fmah2_d_t.fmaiseq 
                  AND g_fmah2_d[g_detail_idx].fmaiseq2 = g_fmah2_d_t.fmaiseq2 
                  ) THEN
                  LET gs_keys[01] = g_fmag_m.fmagdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_fmah2_d_t.fmaiseq
                  LET gs_keys[gs_keys.getLength()+1] = g_fmah2_d_t.fmaiseq2
                  CALL afmt025_key_update_b(gs_keys,'fmai_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmag_m),util.JSON.stringify(g_fmah2_d_t)
               LET g_log2 = util.JSON.stringify(g_fmag_m),util.JSON.stringify(g_fmah2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaiseq2
            #add-point:BEFORE FIELD fmaiseq2 name="input.b.page2.fmaiseq2"
            IF cl_null(g_fmah2_d[g_detail_idx].fmaiseq2) OR g_fmah2_d[g_detail_idx].fmaiseq2 = 0 THEN
               SELECT MAX(fmaiseq2) INTO g_fmah2_d[g_detail_idx].fmaiseq2
                 FROM fmai_t
                WHERE fmaient = g_enterprise
                  AND fmaidocno = g_fmag_m.fmagdocno
               
               IF cl_null(g_fmah2_d[g_detail_idx].fmaiseq2) THEN
                  LET g_fmah2_d[g_detail_idx].fmaiseq2 = 1
               ELSE
                  LET g_fmah2_d[g_detail_idx].fmaiseq2 = g_fmah2_d[g_detail_idx].fmaiseq2 + 1
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaiseq2
            
            #add-point:AFTER FIELD fmaiseq2 name="input.a.page2.fmaiseq2"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmag_m.fmagdocno IS NOT NULL AND g_fmah2_d[g_detail_idx].fmaiseq IS NOT NULL AND g_fmah2_d[g_detail_idx].fmaiseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmag_m.fmagdocno != g_fmagdocno_t OR g_fmah2_d[g_detail_idx].fmaiseq != g_fmah2_d_t.fmaiseq OR g_fmah2_d[g_detail_idx].fmaiseq2 != g_fmah2_d_t.fmaiseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmai_t WHERE "||"fmaient = '" ||g_enterprise|| "' AND "||"fmaidocno = '"||g_fmag_m.fmagdocno ||"' AND "|| "fmaiseq = '"||g_fmah2_d[g_detail_idx].fmaiseq ||"' AND "|| "fmaiseq2 = '"||g_fmah2_d[g_detail_idx].fmaiseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaiseq2
            #add-point:ON CHANGE fmaiseq2 name="input.g.page2.fmaiseq2"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmai001
            
            #add-point:AFTER FIELD fmai001 name="input.a.page2.fmai001"
            IF NOT cl_null(g_fmah2_d[l_ac].fmai001) THEN 
               IF g_fmah2_d[l_ac].fmai001 != g_fmah2_d_o.fmai001 OR cl_null(g_fmah2_d_o.fmai001) THEN #160822-00008#6 
#應用 a17 樣板自動產生(Version:2)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_fmah2_d[l_ac].fmai001             
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooef001_42") THEN
                     #檢查成功時後續處理
                    #161028-00032#1--s add
                     CALL s_fin_orga_get_comp_ld(g_fmag_m.fmagsite) RETURNING g_success,g_errno,l_comp,l_ld 
                     LET l_n = 0
                     SELECT COUNT(*) INTO l_n FROM ooef_t
                      WHERE ooefent = g_enterprise AND ooef017 = l_comp
                        AND ooef001 = g_fmah2_d[l_ac].fmai001
                     IF l_n = 0 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = g_fmah2_d[l_ac].fmai001 
                        LET g_errparam.code   = "afm-00138" 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        NEXT FIELD CURRENT
                     END IF
                     #161028-00032#1--e add
                     #160822-00008#6---(S)
                     LET g_fmah2_d[l_ac].glaacomp      = ''
                     LET g_fmah2_d[l_ac].glaacomp_desc = ''
                     #160822-00008#6---(E) 
                     CALL afmt025_ooef017(g_fmah2_d[l_ac].fmai001)                         
                       RETURNING g_fmah2_d[l_ac].glaacomp,g_fmah2_d[l_ac].glaacomp_desc 
                     LET g_fmah2_d[l_ac].fmai001_desc = s_desc_get_department_desc(g_fmah2_d[l_ac].fmai001)  
                  ELSE
                     #檢查失敗時後續處理
                     LET g_fmah2_d[l_ac].fmai001 = g_fmah2_d_o.fmai001 #160822-00008#6
                     NEXT FIELD CURRENT
                  END IF
               END IF   #160822-00008#6 
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmah2_d[l_ac].fmai001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmah2_d[l_ac].fmai001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmah2_d[l_ac].fmai001_desc
            LET g_fmah2_d_o.* = g_fmah2_d[l_ac].*   #160822-00008#6

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmai001
            #add-point:BEFORE FIELD fmai001 name="input.b.page2.fmai001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmai001
            #add-point:ON CHANGE fmai001 name="input.g.page2.fmai001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacomp
            
            #add-point:AFTER FIELD glaacomp name="input.a.page2.glaacomp"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmah2_d[l_ac].glaacomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmah2_d[l_ac].glaacomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmah2_d[l_ac].glaacomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp name="input.b.page2.glaacomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaacomp
            #add-point:ON CHANGE glaacomp name="input.g.page2.glaacomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmai002
            #add-point:BEFORE FIELD fmai002 name="input.b.page2.fmai002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmai002
            
            #add-point:AFTER FIELD fmai002 name="input.a.page2.fmai002"
            IF NOT cl_null(g_fmah2_d[l_ac].fmai002) THEN
               CALL afmt025_fmai002_chk(g_fmah2_d[l_ac].fmai002,g_fmah2_d[l_ac].fmai003) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmah2_d[l_ac].fmai002||g_fmah2_d[l_ac].fmai003
                  LET g_errparam.code   = l_errno 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               CALL afmt025_fmai002_ref(g_fmah2_d[l_ac].fmai002,g_fmah2_d[l_ac].fmai003) 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmai002
            #add-point:ON CHANGE fmai002 name="input.g.page2.fmai002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmai003
            #add-point:BEFORE FIELD fmai003 name="input.b.page2.fmai003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmai003
            
            #add-point:AFTER FIELD fmai003 name="input.a.page2.fmai003"
            IF NOT cl_null(g_fmah2_d[l_ac].fmai003) THEN
               CALL afmt025_fmai002_chk(g_fmah2_d[l_ac].fmai002,g_fmah2_d[l_ac].fmai003) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmah2_d[l_ac].fmai002||g_fmah2_d[l_ac].fmai003
                  LET g_errparam.code   = l_errno 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               CALL afmt025_fmai002_ref(g_fmah2_d[l_ac].fmai002,g_fmah2_d[l_ac].fmai003) 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmai003
            #add-point:ON CHANGE fmai003 name="input.g.page2.fmai003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcf002
            #add-point:BEFORE FIELD fmcf002 name="input.b.page2.fmcf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcf002
            
            #add-point:AFTER FIELD fmcf002 name="input.a.page2.fmcf002"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcf002
            #add-point:ON CHANGE fmcf002 name="input.g.page2.fmcf002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcf003
            #add-point:BEFORE FIELD fmcf003 name="input.b.page2.fmcf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcf003
            
            #add-point:AFTER FIELD fmcf003 name="input.a.page2.fmcf003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcf003
            #add-point:ON CHANGE fmcf003 name="input.g.page2.fmcf003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaiseq
            #add-point:BEFORE FIELD fmaiseq name="input.b.page2.fmaiseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaiseq
            
            #add-point:AFTER FIELD fmaiseq name="input.a.page2.fmaiseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmag_m.fmagdocno IS NOT NULL AND g_fmah2_d[g_detail_idx].fmaiseq IS NOT NULL AND g_fmah2_d[g_detail_idx].fmaiseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmag_m.fmagdocno != g_fmagdocno_t OR g_fmah2_d[g_detail_idx].fmaiseq != g_fmah2_d_t.fmaiseq OR g_fmah2_d[g_detail_idx].fmaiseq2 != g_fmah2_d_t.fmaiseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmai_t WHERE "||"fmaient = '" ||g_enterprise|| "' AND "||"fmaidocno = '"||g_fmag_m.fmagdocno ||"' AND "|| "fmaiseq = '"||g_fmah2_d[g_detail_idx].fmaiseq ||"' AND "|| "fmaiseq2 = '"||g_fmah2_d[g_detail_idx].fmaiseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM fmah_t
                   WHERE fmahent = g_enterprise AND fmahdocno = g_fmag_m.fmagdocno
                     AND fmahseq = g_fmah2_d[l_ac].fmaiseq
                  IF l_n = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmag_m.fmagdocno||g_fmah2_d[l_ac].fmaiseq
                     LET g_errparam.code   = 'afm-00156' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  IF g_fmah2_d[g_detail_idx].fmaiseq != g_fmah2_d_t.fmaiseq THEN
                     CALL afmt025_fmai004_chk('a') RETURNING l_errno
                     IF NOT cl_null(l_errno) THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = g_fmah2_d[l_ac].fmai004
                        LET g_errparam.code   = l_errno 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        NEXT FIELD fmai004
                     END IF 
#170106-00021#1 mark s---                     
#                     CALL afmt025_fmai004_chk1('a') RETURNING l_success
#                     IF NOT l_success THEN
#                        INITIALIZE g_errparam TO NULL 
#                        LET g_errparam.extend = g_fmah2_d[l_ac].fmai004
#                        LET g_errparam.code   = 'afm-00155' 
#                        LET g_errparam.popup  = TRUE 
#                        CALL cl_err()
#                        NEXT FIELD fmai003
#                     END IF
#170106-00021#1 mark e---
                  END IF
               END IF
               CALL afmt025_fmaiseq_ref()
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaiseq
            #add-point:ON CHANGE fmaiseq name="input.g.page2.fmaiseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah001_1
            
            #add-point:AFTER FIELD fmah001_1 name="input.a.page2.fmah001_1"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmah2_d[l_ac].fmah001
            CALL ap_ref_array2(g_ref_fields,"SELECT fmaal003 FROM fmaal_t WHERE fmaalent='"||g_enterprise||"' AND fmaal001=? AND fmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmah2_d[l_ac].fmah001_1_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmah2_d[l_ac].fmah001_1_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah001_1
            #add-point:BEFORE FIELD fmah001_1 name="input.b.page2.fmah001_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmah001_1
            #add-point:ON CHANGE fmah001_1 name="input.g.page2.fmah001_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmah006_1
            #add-point:BEFORE FIELD fmah006_1 name="input.b.page2.fmah006_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmah006_1
            
            #add-point:AFTER FIELD fmah006_1 name="input.a.page2.fmah006_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmah006_1
            #add-point:ON CHANGE fmah006_1 name="input.g.page2.fmah006_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmai004
            #add-point:BEFORE FIELD fmai004 name="input.b.page2.fmai004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmai004
            
            #add-point:AFTER FIELD fmai004 name="input.a.page2.fmai004"
            IF NOT cl_null(g_fmah2_d[l_ac].fmai004) THEN
               IF g_fmah2_d[g_detail_idx].fmaiseq != g_fmah2_d_t.fmaiseq THEN
                  LET l_cmd1 = 'a'
               ELSE
                  LET l_cmd1 = l_cmd
               END IF
               CALL afmt025_fmai004_chk(l_cmd1) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmah2_d[l_ac].fmai004
                  LET g_errparam.code   = l_errno 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF 
#170106-00021#1 mark s---               
#               CALL afmt025_fmai004_chk1(l_cmd1) RETURNING l_success
#               IF NOT l_success THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = g_fmah2_d[l_ac].fmai004
#                  LET g_errparam.code   = 'afm-00155' 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
#                  NEXT FIELD CURRENT
#               END IF
#170106-00021#1 mark e---
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmai004
            #add-point:ON CHANGE fmai004 name="input.g.page2.fmai004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.fmaiseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaiseq2
            #add-point:ON ACTION controlp INFIELD fmaiseq2 name="input.c.page2.fmaiseq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmai001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmai001
            #add-point:ON ACTION controlp INFIELD fmai001 name="input.c.page2.fmai001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            CALL s_fin_orga_get_comp_ld(g_fmag_m.fmagsite) RETURNING g_success,g_errno,l_comp,l_ld #161028-00032#1 add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmah2_d[l_ac].fmai001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " ooef017 = '",l_comp,"'"  #161028-00032#1 add
            
           #CALL q_fmcf007()                                #呼叫開窗 #161028-00032#1 mark
            CALL q_fmcf007_1()                              #161028-00032#1 add
            LET g_fmah2_d[l_ac].fmai001 = g_qryparam.return1              
            CALL afmt025_ooef017(g_fmah2_d[l_ac].fmai001) 
              RETURNING g_fmah2_d[l_ac].glaacomp,g_fmah2_d[l_ac].glaacomp_desc 
            LET g_fmah2_d[l_ac].fmai001_desc = s_desc_get_department_desc(g_fmah2_d[l_ac].fmai001) 

            DISPLAY g_fmah2_d[l_ac].fmai001 TO fmai001              #

            NEXT FIELD fmai001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.glaacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp name="input.c.page2.glaacomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmai002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmai002
            #add-point:ON ACTION controlp INFIELD fmai002 name="input.c.page2.fmai002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmah2_d[l_ac].fmai002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_fmcedocno()                                #呼叫開窗

            LET g_fmah2_d[l_ac].fmai002 = g_qryparam.return1              

            DISPLAY g_fmah2_d[l_ac].fmai002 TO fmai002              #

            NEXT FIELD fmai002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fmai003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmai003
            #add-point:ON ACTION controlp INFIELD fmai003 name="input.c.page2.fmai003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmcf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcf002
            #add-point:ON ACTION controlp INFIELD fmcf002 name="input.c.page2.fmcf002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmcf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcf003
            #add-point:ON ACTION controlp INFIELD fmcf003 name="input.c.page2.fmcf003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmaiseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaiseq
            #add-point:ON ACTION controlp INFIELD fmaiseq name="input.c.page2.fmaiseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmah001_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah001_1
            #add-point:ON ACTION controlp INFIELD fmah001_1 name="input.c.page2.fmah001_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmah006_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmah006_1
            #add-point:ON ACTION controlp INFIELD fmah006_1 name="input.c.page2.fmah006_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmai004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmai004
            #add-point:ON ACTION controlp INFIELD fmai004 name="input.c.page2.fmai004"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmah2_d[l_ac].* = g_fmah2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt025_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afmt025_unlock_b("fmai_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fmah2_d[li_reproduce_target].* = g_fmah2_d[li_reproduce].*
 
               LET g_fmah2_d[li_reproduce_target].fmaiseq = NULL
               LET g_fmah2_d[li_reproduce_target].fmaiseq2 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmah2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmah2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="afmt025.input.other" >}
      
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
            NEXT FIELD fmagsite
            #end add-point  
            NEXT FIELD fmagdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD fmahseq
               WHEN "s_detail2"
                  NEXT FIELD fmaiseq2
 
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
 
{<section id="afmt025.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION afmt025_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL afmt025_b_fill() #單身填充
      CALL afmt025_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afmt025_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_fmag_m_mask_o.* =  g_fmag_m.*
   CALL afmt025_fmag_t_mask()
   LET g_fmag_m_mask_n.* =  g_fmag_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fmag_m.fmagsite,g_fmag_m.fmagsite_desc,g_fmag_m.fmagdocdt,g_fmag_m.fmagdocno,g_fmag_m.fmagstus, 
       g_fmag_m.fmagownid,g_fmag_m.fmagownid_desc,g_fmag_m.fmagowndp,g_fmag_m.fmagowndp_desc,g_fmag_m.fmagcrtid, 
       g_fmag_m.fmagcrtid_desc,g_fmag_m.fmagcrtdp,g_fmag_m.fmagcrtdp_desc,g_fmag_m.fmagcrtdt,g_fmag_m.fmagmodid, 
       g_fmag_m.fmagmodid_desc,g_fmag_m.fmagmoddt,g_fmag_m.fmagcnfid,g_fmag_m.fmagcnfid_desc,g_fmag_m.fmagcnfdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmag_m.fmagstus 
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
   FOR l_ac = 1 TO g_fmah_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_fmah2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL afmt025_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afmt025.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION afmt025_detail_show()
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
 
{<section id="afmt025.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afmt025_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE fmag_t.fmagdocno 
   DEFINE l_oldno     LIKE fmag_t.fmagdocno 
 
   DEFINE l_master    RECORD LIKE fmag_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE fmah_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE fmai_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_fmag_m.fmagdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_fmagdocno_t = g_fmag_m.fmagdocno
 
    
   LET g_fmag_m.fmagdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmag_m.fmagownid = g_user
      LET g_fmag_m.fmagowndp = g_dept
      LET g_fmag_m.fmagcrtid = g_user
      LET g_fmag_m.fmagcrtdp = g_dept 
      LET g_fmag_m.fmagcrtdt = cl_get_current()
      LET g_fmag_m.fmagmodid = g_user
      LET g_fmag_m.fmagmoddt = cl_get_current()
      LET g_fmag_m.fmagstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmag_m.fmagstus 
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
   
   
   CALL afmt025_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_fmag_m.* TO NULL
      INITIALIZE g_fmah_d TO NULL
      INITIALIZE g_fmah2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL afmt025_show()
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
   CALL afmt025_set_act_visible()   
   CALL afmt025_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fmagdocno_t = g_fmag_m.fmagdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmagent = " ||g_enterprise|| " AND",
                      " fmagdocno = '", g_fmag_m.fmagdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt025_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL afmt025_idx_chk()
   
   LET g_data_owner = g_fmag_m.fmagownid      
   LET g_data_dept  = g_fmag_m.fmagowndp
   
   #功能已完成,通報訊息中心
   CALL afmt025_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="afmt025.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION afmt025_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE fmah_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE fmai_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE afmt025_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fmah_t
    WHERE fmahent = g_enterprise AND fmahdocno = g_fmagdocno_t
 
    INTO TEMP afmt025_detail
 
   #將key修正為調整後   
   UPDATE afmt025_detail 
      #更新key欄位
      SET fmahdocno = g_fmag_m.fmagdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO fmah_t SELECT * FROM afmt025_detail
   
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
   DROP TABLE afmt025_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fmai_t 
    WHERE fmaient = g_enterprise AND fmaidocno = g_fmagdocno_t
 
    INTO TEMP afmt025_detail
 
   #將key修正為調整後   
   UPDATE afmt025_detail SET fmaidocno = g_fmag_m.fmagdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO fmai_t SELECT * FROM afmt025_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE afmt025_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_fmagdocno_t = g_fmag_m.fmagdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="afmt025.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afmt025_delete()
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
   
   IF g_fmag_m.fmagdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN afmt025_cl USING g_enterprise,g_fmag_m.fmagdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt025_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afmt025_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt025_master_referesh USING g_fmag_m.fmagdocno INTO g_fmag_m.fmagsite,g_fmag_m.fmagdocdt, 
       g_fmag_m.fmagdocno,g_fmag_m.fmagstus,g_fmag_m.fmagownid,g_fmag_m.fmagowndp,g_fmag_m.fmagcrtid, 
       g_fmag_m.fmagcrtdp,g_fmag_m.fmagcrtdt,g_fmag_m.fmagmodid,g_fmag_m.fmagmoddt,g_fmag_m.fmagcnfid, 
       g_fmag_m.fmagcnfdt,g_fmag_m.fmagsite_desc,g_fmag_m.fmagownid_desc,g_fmag_m.fmagowndp_desc,g_fmag_m.fmagcrtid_desc, 
       g_fmag_m.fmagcrtdp_desc,g_fmag_m.fmagmodid_desc,g_fmag_m.fmagcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT afmt025_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmag_m_mask_o.* =  g_fmag_m.*
   CALL afmt025_fmag_t_mask()
   LET g_fmag_m_mask_n.* =  g_fmag_m.*
   
   CALL afmt025_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      IF g_fmag_m.fmagstus <> 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00052'
         LET g_errparam.extend = 'delete'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afmt025_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_fmagdocno_t = g_fmag_m.fmagdocno
 
 
      DELETE FROM fmag_t
       WHERE fmagent = g_enterprise AND fmagdocno = g_fmag_m.fmagdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_fmag_m.fmagdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_fin_del_docno(g_glaald,g_fmag_m.fmagdocno,g_fmag_m.fmagdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM fmah_t
       WHERE fmahent = g_enterprise AND fmahdocno = g_fmag_m.fmagdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmah_t:",SQLERRMESSAGE 
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
      DELETE FROM fmai_t
       WHERE fmaient = g_enterprise AND
             fmaidocno = g_fmag_m.fmagdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmai_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_fmag_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE afmt025_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_fmah_d.clear() 
      CALL g_fmah2_d.clear()       
 
     
      CALL afmt025_ui_browser_refresh()  
      #CALL afmt025_ui_headershow()  
      #CALL afmt025_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL afmt025_browser_fill("")
         CALL afmt025_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afmt025_cl
 
   #功能已完成,通報訊息中心
   CALL afmt025_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="afmt025.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmt025_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_fmah_d.clear()
   CALL g_fmah2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF afmt025_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT fmahseq,fmah001,fmah002,fmah003,fmah004,fmah005,fmah006,fmah007, 
             fmah008,fmah009,fmah010 ,t1.fmaal003 ,t2.ooefl003 ,t4.nmabl003 FROM fmah_t",   
                     " INNER JOIN fmag_t ON fmagent = " ||g_enterprise|| " AND fmagdocno = fmahdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN fmaal_t t1 ON t1.fmaalent="||g_enterprise||" AND t1.fmaal001=fmah001 AND t1.fmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=fmah002 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN nmabl_t t4 ON t4.nmablent="||g_enterprise||" AND t4.nmabl001=fmah005 AND t4.nmabl002='"||g_dlang||"' ",
 
                     " WHERE fmahent=? AND fmahdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fmah_t.fmahseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt025_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR afmt025_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_fmag_m.fmagdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_fmag_m.fmagdocno INTO g_fmah_d[l_ac].fmahseq,g_fmah_d[l_ac].fmah001, 
          g_fmah_d[l_ac].fmah002,g_fmah_d[l_ac].fmah003,g_fmah_d[l_ac].fmah004,g_fmah_d[l_ac].fmah005, 
          g_fmah_d[l_ac].fmah006,g_fmah_d[l_ac].fmah007,g_fmah_d[l_ac].fmah008,g_fmah_d[l_ac].fmah009, 
          g_fmah_d[l_ac].fmah010,g_fmah_d[l_ac].fmah001_desc,g_fmah_d[l_ac].fmah002_desc,g_fmah_d[l_ac].fmah005_desc  
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
         CALL afmt025_ooef017(g_fmah_d[l_ac].fmah002) RETURNING g_fmah_d[l_ac].ooef001,g_fmah_d[l_ac].ooef001_desc
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
   IF afmt025_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT fmaiseq2,fmai001,fmai002,fmai003,fmaiseq,fmai004 ,t5.ooefl003 FROM fmai_t", 
                
                     " INNER JOIN  fmag_t ON fmagent = " ||g_enterprise|| " AND fmagdocno = fmaidocno ",
 
                     "",
                     
                                    " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=fmai001 AND t5.ooefl002='"||g_dlang||"' ",
 
                     " WHERE fmaient=? AND fmaidocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fmai_t.fmaiseq,fmai_t.fmaiseq2"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt025_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR afmt025_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_fmag_m.fmagdocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_fmag_m.fmagdocno INTO g_fmah2_d[l_ac].fmaiseq2,g_fmah2_d[l_ac].fmai001, 
          g_fmah2_d[l_ac].fmai002,g_fmah2_d[l_ac].fmai003,g_fmah2_d[l_ac].fmaiseq,g_fmah2_d[l_ac].fmai004, 
          g_fmah2_d[l_ac].fmai001_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         CALL afmt025_ooef017(g_fmah2_d[l_ac].fmai001) RETURNING g_fmah2_d[l_ac].glaacomp,g_fmah2_d[l_ac].glaacomp_desc
         CALL afmt025_fmaiseq_ref()
         CALL afmt025_fmai002_ref(g_fmah2_d[l_ac].fmai002,g_fmah2_d[l_ac].fmai003)
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
   
   CALL g_fmah_d.deleteElement(g_fmah_d.getLength())
   CALL g_fmah2_d.deleteElement(g_fmah2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE afmt025_pb
   FREE afmt025_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_fmah_d.getLength()
      LET g_fmah_d_mask_o[l_ac].* =  g_fmah_d[l_ac].*
      CALL afmt025_fmah_t_mask()
      LET g_fmah_d_mask_n[l_ac].* =  g_fmah_d[l_ac].*
   END FOR
   
   LET g_fmah2_d_mask_o.* =  g_fmah2_d.*
   FOR l_ac = 1 TO g_fmah2_d.getLength()
      LET g_fmah2_d_mask_o[l_ac].* =  g_fmah2_d[l_ac].*
      CALL afmt025_fmai_t_mask()
      LET g_fmah2_d_mask_n[l_ac].* =  g_fmah2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="afmt025.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afmt025_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM fmah_t
       WHERE fmahent = g_enterprise AND
         fmahdocno = ps_keys_bak[1] AND fmahseq = ps_keys_bak[2]
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
         CALL g_fmah_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM fmai_t
       WHERE fmaient = g_enterprise AND
             fmaidocno = ps_keys_bak[1] AND fmaiseq = ps_keys_bak[2] AND fmaiseq2 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmai_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_fmah2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt025.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afmt025_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO fmah_t
                  (fmahent,
                   fmahdocno,
                   fmahseq
                   ,fmah001,fmah002,fmah003,fmah004,fmah005,fmah006,fmah007,fmah008,fmah009,fmah010) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_fmah_d[g_detail_idx].fmah001,g_fmah_d[g_detail_idx].fmah002,g_fmah_d[g_detail_idx].fmah003, 
                       g_fmah_d[g_detail_idx].fmah004,g_fmah_d[g_detail_idx].fmah005,g_fmah_d[g_detail_idx].fmah006, 
                       g_fmah_d[g_detail_idx].fmah007,g_fmah_d[g_detail_idx].fmah008,g_fmah_d[g_detail_idx].fmah009, 
                       g_fmah_d[g_detail_idx].fmah010)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmah_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_fmah_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO fmai_t
                  (fmaient,
                   fmaidocno,
                   fmaiseq,fmaiseq2
                   ,fmai001,fmai002,fmai003,fmai004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_fmah2_d[g_detail_idx].fmai001,g_fmah2_d[g_detail_idx].fmai002,g_fmah2_d[g_detail_idx].fmai003, 
                       g_fmah2_d[g_detail_idx].fmai004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmai_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_fmah2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="afmt025.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afmt025_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fmah_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL afmt025_fmah_t_mask_restore('restore_mask_o')
               
      UPDATE fmah_t 
         SET (fmahdocno,
              fmahseq
              ,fmah001,fmah002,fmah003,fmah004,fmah005,fmah006,fmah007,fmah008,fmah009,fmah010) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_fmah_d[g_detail_idx].fmah001,g_fmah_d[g_detail_idx].fmah002,g_fmah_d[g_detail_idx].fmah003, 
                  g_fmah_d[g_detail_idx].fmah004,g_fmah_d[g_detail_idx].fmah005,g_fmah_d[g_detail_idx].fmah006, 
                  g_fmah_d[g_detail_idx].fmah007,g_fmah_d[g_detail_idx].fmah008,g_fmah_d[g_detail_idx].fmah009, 
                  g_fmah_d[g_detail_idx].fmah010) 
         WHERE fmahent = g_enterprise AND fmahdocno = ps_keys_bak[1] AND fmahseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmah_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmah_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afmt025_fmah_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fmai_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL afmt025_fmai_t_mask_restore('restore_mask_o')
               
      UPDATE fmai_t 
         SET (fmaidocno,
              fmaiseq,fmaiseq2
              ,fmai001,fmai002,fmai003,fmai004) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_fmah2_d[g_detail_idx].fmai001,g_fmah2_d[g_detail_idx].fmai002,g_fmah2_d[g_detail_idx].fmai003, 
                  g_fmah2_d[g_detail_idx].fmai004) 
         WHERE fmaient = g_enterprise AND fmaidocno = ps_keys_bak[1] AND fmaiseq = ps_keys_bak[2] AND fmaiseq2 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmai_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmai_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afmt025_fmai_t_mask_restore('restore_mask_n')
 
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
 
{<section id="afmt025.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION afmt025_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="afmt025.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION afmt025_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="afmt025.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afmt025_lock_b(ps_table,ps_page)
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
   #CALL afmt025_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "fmah_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afmt025_bcl USING g_enterprise,
                                       g_fmag_m.fmagdocno,g_fmah_d[g_detail_idx].fmahseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afmt025_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "fmai_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afmt025_bcl2 USING g_enterprise,
                                             g_fmag_m.fmagdocno,g_fmah2_d[g_detail_idx].fmaiseq,g_fmah2_d[g_detail_idx].fmaiseq2 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afmt025_bcl2:",SQLERRMESSAGE 
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
 
{<section id="afmt025.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afmt025_unlock_b(ps_table,ps_page)
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
      CLOSE afmt025_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afmt025_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="afmt025.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afmt025_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("fmagdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("fmagdocno",TRUE)
      CALL cl_set_comp_entry("fmagdocdt",TRUE)
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
 
{<section id="afmt025.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afmt025_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_slip     LIKE type_t.chr10
   DEFINE l_dfin0033  LIKE type_t.chr80
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   CALL cl_set_comp_entry("fmagdocdt",TRUE)
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("fmagdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("fmagdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("fmagdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT cl_null(g_fmag_m.fmagdocno) THEN
      #获取单别
      CALL s_aooi200_fin_get_slip(g_fmag_m.fmagdocno) RETURNING l_success,l_slip
      #是否可改日期
      CALL s_fin_get_doc_para(g_glaald,g_glaacomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      IF l_dfin0033 = "N"  THEN
         CALL cl_set_comp_entry("fmagdocdt",FALSE)
      ELSE
         CALL cl_set_comp_entry("fmagdocdt",TRUE)
      END IF
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt025.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afmt025_set_entry_b(p_cmd)
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
 
{<section id="afmt025.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afmt025_set_no_entry_b(p_cmd)
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
 
{<section id="afmt025.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afmt025_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt025.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afmt025_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_fmag_m.fmagstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt025.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION afmt025_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt025.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION afmt025_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt025.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afmt025_default_search()
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
      LET ls_wc = ls_wc, " fmagdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "fmag_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "fmah_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "fmai_t" 
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
 
{<section id="afmt025.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afmt025_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_today  DATETIME YEAR TO SECOND
   DEFINE l_errno  LIKE type_t.chr20
   DEFINE l_success      LIKE type_t.num5   #161026-00023#2 Add
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_fmag_m.fmagdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN afmt025_cl USING g_enterprise,g_fmag_m.fmagdocno
   IF STATUS THEN
      CLOSE afmt025_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt025_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afmt025_master_referesh USING g_fmag_m.fmagdocno INTO g_fmag_m.fmagsite,g_fmag_m.fmagdocdt, 
       g_fmag_m.fmagdocno,g_fmag_m.fmagstus,g_fmag_m.fmagownid,g_fmag_m.fmagowndp,g_fmag_m.fmagcrtid, 
       g_fmag_m.fmagcrtdp,g_fmag_m.fmagcrtdt,g_fmag_m.fmagmodid,g_fmag_m.fmagmoddt,g_fmag_m.fmagcnfid, 
       g_fmag_m.fmagcnfdt,g_fmag_m.fmagsite_desc,g_fmag_m.fmagownid_desc,g_fmag_m.fmagowndp_desc,g_fmag_m.fmagcrtid_desc, 
       g_fmag_m.fmagcrtdp_desc,g_fmag_m.fmagmodid_desc,g_fmag_m.fmagcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT afmt025_action_chk() THEN
      CLOSE afmt025_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmag_m.fmagsite,g_fmag_m.fmagsite_desc,g_fmag_m.fmagdocdt,g_fmag_m.fmagdocno,g_fmag_m.fmagstus, 
       g_fmag_m.fmagownid,g_fmag_m.fmagownid_desc,g_fmag_m.fmagowndp,g_fmag_m.fmagowndp_desc,g_fmag_m.fmagcrtid, 
       g_fmag_m.fmagcrtid_desc,g_fmag_m.fmagcrtdp,g_fmag_m.fmagcrtdp_desc,g_fmag_m.fmagcrtdt,g_fmag_m.fmagmodid, 
       g_fmag_m.fmagmodid_desc,g_fmag_m.fmagmoddt,g_fmag_m.fmagcnfid,g_fmag_m.fmagcnfid_desc,g_fmag_m.fmagcnfdt 
 
 
   CASE g_fmag_m.fmagstus
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
         CASE g_fmag_m.fmagstus
            
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
      HIDE OPTION "verify"
      HIDE OPTION "unverify"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_fmag_m.fmagstus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "X"
            CALL s_transaction_end('N','0')   
            RETURN

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)

         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT afmt025_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt025_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT afmt025_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt025_cl
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
      g_fmag_m.fmagstus = lc_state OR cl_null(lc_state) THEN
      CLOSE afmt025_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #151125-00001#2 --- add start ---
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0') 
         RETURN
      END IF
   END IF
   #151125-00001#2 --- add end   ---
   LET l_today  = cl_get_current()
   CASE lc_state
      WHEN 'Y'
         #161026-00023#2 Mark ---(S)---
        #CALL afmt025_confirm_chk() RETURNING l_errno 
        #IF NOT cl_null(l_errno) THEN
        #   INITIALIZE g_errparam TO NULL
        #   LET g_errparam.code = l_errno
        #   LET g_errparam.extend = g_fmag_m.fmagdocno
        #   LET g_errparam.popup = TRUE
        #   CALL cl_err()
        #   CALL s_transaction_end('N','0')
        #   RETURN
        #END IF
        #   
        #UPDATE fmag_t SET fmagcnfid = g_user,
        #                  fmagcnfdt = l_today   
        # WHERE fmagent = g_enterprise AND fmagdocno = g_fmag_m.fmagdocno
         #161026-00023#2 Mark ---(E)---
         #161026-00023#2 Add  ---(S)---
         CALL cl_err_collect_init()
         LET l_success = TRUE
         IF s_afmt025_conf_chk(g_fmag_m.fmagdocno) THEN
            IF cl_ask_confirm('aim-00108') THEN
               CALL s_afmt025_conf_upd(g_fmag_m.fmagdocno) RETURNING l_success
            END IF
         ELSE
            LET l_success = FALSE
         END IF
         IF l_success THEN 
            CALL s_transaction_end('Y',1)
            CALL cl_err_collect_init()
            CALL cl_err_collect_show()
         ELSE
            CALL s_transaction_end('N',1)
            CALL cl_err_collect_show()
            RETURN
         END IF
         #161026-00023#2 Add  ---(E)---
      WHEN 'N'
         UPDATE fmag_t SET fmagcnfid = '',
                           fmagcnfdt = ''  
          WHERE fmagent = g_enterprise AND fmagdocno = g_fmag_m.fmagdocno
      WHEN 'X'
         #此資料已確認,不可作廢
         IF g_fmag_m.fmagstus = 'Y' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'anm-00045'
            LET g_errparam.extend = g_fmag_m.fmagdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            RETURN
         END IF
   END CASE
   #end add-point
   
   LET g_fmag_m.fmagmodid = g_user
   LET g_fmag_m.fmagmoddt = cl_get_current()
   LET g_fmag_m.fmagstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE fmag_t 
      SET (fmagstus,fmagmodid,fmagmoddt) 
        = (g_fmag_m.fmagstus,g_fmag_m.fmagmodid,g_fmag_m.fmagmoddt)     
    WHERE fmagent = g_enterprise AND fmagdocno = g_fmag_m.fmagdocno
 
    
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
      EXECUTE afmt025_master_referesh USING g_fmag_m.fmagdocno INTO g_fmag_m.fmagsite,g_fmag_m.fmagdocdt, 
          g_fmag_m.fmagdocno,g_fmag_m.fmagstus,g_fmag_m.fmagownid,g_fmag_m.fmagowndp,g_fmag_m.fmagcrtid, 
          g_fmag_m.fmagcrtdp,g_fmag_m.fmagcrtdt,g_fmag_m.fmagmodid,g_fmag_m.fmagmoddt,g_fmag_m.fmagcnfid, 
          g_fmag_m.fmagcnfdt,g_fmag_m.fmagsite_desc,g_fmag_m.fmagownid_desc,g_fmag_m.fmagowndp_desc, 
          g_fmag_m.fmagcrtid_desc,g_fmag_m.fmagcrtdp_desc,g_fmag_m.fmagmodid_desc,g_fmag_m.fmagcnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_fmag_m.fmagsite,g_fmag_m.fmagsite_desc,g_fmag_m.fmagdocdt,g_fmag_m.fmagdocno, 
          g_fmag_m.fmagstus,g_fmag_m.fmagownid,g_fmag_m.fmagownid_desc,g_fmag_m.fmagowndp,g_fmag_m.fmagowndp_desc, 
          g_fmag_m.fmagcrtid,g_fmag_m.fmagcrtid_desc,g_fmag_m.fmagcrtdp,g_fmag_m.fmagcrtdp_desc,g_fmag_m.fmagcrtdt, 
          g_fmag_m.fmagmodid,g_fmag_m.fmagmodid_desc,g_fmag_m.fmagmoddt,g_fmag_m.fmagcnfid,g_fmag_m.fmagcnfid_desc, 
          g_fmag_m.fmagcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE afmt025_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt025_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt025.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION afmt025_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_fmah_d.getLength() THEN
         LET g_detail_idx = g_fmah_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmah_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmah_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_fmah2_d.getLength() THEN
         LET g_detail_idx = g_fmah2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmah2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmah2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afmt025.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afmt025_b_fill2(pi_idx)
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
   
   CALL afmt025_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="afmt025.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION afmt025_fill_chk(ps_idx)
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
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="afmt025.status_show" >}
PRIVATE FUNCTION afmt025_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt025.mask_functions" >}
&include "erp/afm/afmt025_mask.4gl"
 
{</section>}
 
{<section id="afmt025.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION afmt025_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success         LIKE type_t.num5   #161026-00023#2 Add
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL afmt025_show()
   CALL afmt025_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #161026-00023#2 Add  ---(S)---
   CALL s_afmt025_conf_chk(g_fmag_m.fmagdocno) RETURNING l_success
   IF NOT l_success THEN
      CLOSE afmt025_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #161026-00023#2 Add  ---(E)---
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_fmag_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_fmah_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_fmah2_d))
 
 
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
   #CALL afmt025_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL afmt025_ui_headershow()
   CALL afmt025_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION afmt025_draw_out()
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
   CALL afmt025_ui_headershow()  
   CALL afmt025_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="afmt025.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afmt025_set_pk_array()
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
   LET g_pk_array[1].values = g_fmag_m.fmagdocno
   LET g_pk_array[1].column = 'fmagdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt025.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="afmt025.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afmt025_msgcentre_notify(lc_state)
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
   CALL afmt025_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fmag_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt025.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afmt025_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#12 16/08/24 By 07900  ---add--s--
   SELECT fmagstus INTO g_fmag_m.fmagstus
     FROM fmag_t
    WHERE fmagent = g_enterprise
      AND fmagdocno = g_fmag_m.fmagdocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_fmag_m.fmagstus
        
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
        LET g_errparam.extend = g_fmag_m.fmagdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL afmt025_set_act_visible()
        CALL afmt025_set_act_no_visible()
        CALL afmt025_show()
        RETURN FALSE
     END IF
   END IF
   
   #160818-00017#12 16/08/24 By 07900  ---add--s--
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt025.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 獲取法人主帳套資料
# Memo...........:
# Usage..........: CALL afmt025_fmagsite_ref()
# Date & Author..: 2015/11/06 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt025_fmagsite_ref()
   
   SELECT glaald,glaa003,glaa024,glaacomp INTO g_glaald,g_glaa003,g_glaa024,g_glaacomp FROM glaa_t,ooef_t
    WHERE glaaent = ooefent AND glaacomp = ooef017 
      AND glaaent = g_enterprise AND ooef001 = g_fmag_m.fmagsite
      AND glaa014 = 'Y'
      
END FUNCTION

################################################################################
# Descriptions...: 归属法人及说明
# Memo...........:
# Usage..........: CALL afmt025_ooef017()
#                  RETURNING r_ooef017,r_ooef017_desc
# Input parameter: p_site         组织
# Return code....: r_ooef017      法人
#                : r_ooef017_desc 法人说明
# Date & Author..: 2015/11/06 By  yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt025_ooef017(p_site)
DEFINE p_site           LIKE ooef_t.ooef001
DEFINE r_ooef017        LIKE ooef_t.ooef017
DEFINE r_ooef017_desc   LIKE type_t.chr500

   SELECT ooef017,ooefl003 INTO r_ooef017,r_ooef017_desc FROM ooef_t
     LEFT OUTER JOIN ooefl_t ON ooeflent = ooefent AND ooefl001 = ooef017 AND ooefl002 = g_dlang
    WHERE ooefent = g_enterprise AND ooef001 = p_site
   
   RETURN r_ooef017,r_ooef017_desc
END FUNCTION

################################################################################
# Descriptions...: 合约编号检查
# Memo...........:
# Usage..........: CALL afmt025_fmah003_chk((p_fmah003,p_fmah004)
#                  RETURNING g_errno
# Input parameter: p_fmah003   合约编号
#                : p_fmah004   合约项次
# Return code....: g_errno     错误讯息
# Date & Author..: 2015/11/06 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt025_fmah003_chk(p_fmah003,p_fmah004)
DEFINE p_fmah003         LIKE fmah_t.fmah003
DEFINE p_fmah004         LIKE fmah_t.fmah004
DEFINE l_fmacstus        LIKE fmac_t.fmacstus
DEFINE l_n               LIKE type_t.num5

   LET g_errno = ''
   IF NOT cl_null(p_fmah003) THEN
      SELECT fmacstus INTO l_fmacstus FROM fmac_t
       WHERE fmacent = g_enterprise AND fmac001 = p_fmah003
      CASE 
         WHEN SQLCA.SQLCODE = 100 LET g_errno = 'afm-00144'
         WHEN l_fmacstus <> 'Y' LET g_errno = 'afm-00145'
      END CASE
    END IF
    
    IF NOT cl_null(p_fmah003) AND NOT cl_null(p_fmah004) THEN   
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM fmad_t 
       WHERE fmadent = g_enterprise AND fmad001 = p_fmah003
         AND fmad002 = p_fmah004
      IF l_n = 0 THEN
         LET g_errno = 'afm-00146'
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 根据合约编号+项次栏位带值
# Memo...........:
# Usage..........: CALL afmt025_fmah003_ref(p_fmah003,p_fmah004)
# Date & Author..: 2015/11/06 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt025_fmah003_ref(p_fmah003,p_fmah004)
DEFINE p_fmah003         LIKE fmah_t.fmah003
DEFINE p_fmah004         LIKE fmah_t.fmah004
DEFINE r_fmac003         LIKE fmac_t.fmac003
DEFINE r_fmac003_desc    LIKE type_t.chr500
DEFINE r_fmad003         LIKE fmad_t.fmad003
DEFINE r_fmad004         LIKE fmad_t.fmad004
DEFINE l_fmah007         LIKE fmah_t.fmah007

   #      合约银行，币别，  核准额度
   SELECT fmac003,fmad003,fmad004 INTO r_fmac003,r_fmad003,r_fmad004 FROM fmac_t,fmad_t
    WHERE fmacent = fmadent AND fmac001 = fmad001
      AND fmac001 = p_fmah003 AND fmad002 = p_fmah004
   
   SELECT SUM(fmah007) INTO l_fmah007 FROM fmah_t
    WHERE fmahent = g_enterprise AND fmah003 = p_fmah003
      AND fmah004 = p_fmah004
      
   IF cl_null(r_fmad004) THEN LET r_fmad004 = 0 END IF
   IF cl_null(l_fmah007) THEN LET l_fmah007 = 0 END IF
   LET r_fmad004 = r_fmad004 - l_fmah007
   
   SELECT nmabl003 INTO r_fmac003_desc FROM nmabl_t
    WHERE nmablent = g_enterprise AND nmabl001 = r_fmac003
      AND nmabl002 = g_dlang
   
   RETURN r_fmac003,r_fmac003_desc,r_fmad003,r_fmad004
   
END FUNCTION

################################################################################
# Descriptions...: 金额检查
# Memo...........:
# Usage..........: CALL afmt025_fmah007_chk()
# Date & Author..: 2015/11/09 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt025_fmah007_chk(p_cmd1)
DEFINE p_cmd1         LIKE type_t.chr1
DEFINE l_fmah007_sum  LIKE fmah_t.fmah007
DEFINE l_fmad004      LIKE fmad_t.fmad004
DEFINE r_success      LIKE type_t.num5

   LET r_success = TRUE
   IF NOT cl_null(g_fmah_d[l_ac].fmah003) AND NOT cl_null(g_fmah_d[l_ac].fmah004) THEN
      #当合约编号+项次 不为空且非作废资料时，计算该合约编号+项次的SUM（fmah007),
      #当SUM（fmah007) >该项次的融资总额度时（fmad004），报错，并修改
      
      #SUM(fmah007)
      SELECT SUM(fmah007) INTO l_fmah007_sum FROM fmag_t,fmah_t 
       WHERE fmagent = fmahent AND fmagdocno = fmahdocno 
         AND fmahent = g_enterprise AND fmagstus <> 'X' 
         AND fmah003 = g_fmah_d[l_ac].fmah003 AND fmah004 = g_fmah_d[l_ac].fmah004
         
      #SUM(fmad004)
      SELECT fmad004 INTO l_fmad004 FROM fmad_t,fmac_t
       WHERE fmacent = fmadent AND fmac001 = fmad001
         AND fmadent = g_enterprise AND fmacstus <> 'X'
         AND fmad001 = g_fmah_d[l_ac].fmah003 AND fmad002 = g_fmah_d[l_ac].fmah004
      
      IF p_cmd1 = 'a' THEN   
         IF l_fmah007_sum + g_fmah_d[l_ac].fmah007 > l_fmad004 THEN
            LET r_success = FALSE
         END IF
      ELSE
         IF l_fmah007_sum + g_fmah_d[l_ac].fmah007 - g_fmah_d_t.fmah007 > l_fmad004 THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 日期检查
# Memo...........:
# Usage..........: CALL afmt025_fmah008_chk(p_fmah008)
#                  RETURNING r_success
# Date & Author..: 2015/11/09 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt025_fmah008_chk(p_fmah008)
DEFINE r_errno           LIKE type_t.chr10
DEFINE p_fmah008         LIKE fmah_t.fmah008
DEFINE l_fmac004         LIKE fmac_t.fmac004
DEFINE l_fmac005         LIKE fmac_t.fmac005

   LET r_errno = ''
   IF cl_null(p_fmah008) THEN
      RETURN r_errno
   END IF
   #核准日期,有效日期
   SELECT fmac004,fmac005 INTO l_fmac004,l_fmac005 FROM fmac_t
    WHERE fmacent = g_enterprise AND fmacstus <> 'X'
      AND fmac001 = g_fmah_d[l_ac].fmah003
   
   IF p_fmah008 > l_fmac005 THEN
      LET r_errno = 'afm-00148'
   END IF
   
   IF p_fmah008 < l_fmac004 THEN
     LET r_errno = 'afm-00149'
   END IF
   IF NOT cl_null(g_fmah_d[l_ac].fmah008) AND NOT cl_null(g_fmah_d[l_ac].fmah009) THEN
      IF g_fmah_d[l_ac].fmah008 > g_fmah_d[l_ac].fmah009 THEN
         LET r_errno = 'afm-00150'
      END IF
   END IF
   RETURN r_errno
END FUNCTION

################################################################################
# Descriptions...: 申请单号检查
# Memo...........:
# Usage..........: CALL afmt025_fmai002_chk(p_fmai002,p_fmai003)
#                  RETURNING r_errno
# Date & Author..: 2015/11/09 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt025_fmai002_chk(p_fmai002,p_fmai003)
DEFINE p_fmai002         LIKE fmai_t.fmai002
DEFINE p_fmai003         LIKE fmai_t.fmai003
DEFINE l_fmcestus        LIKE fmce_t.fmcestus
DEFINE l_n               LIKE type_t.num5
DEFINE r_errno           LIKE type_t.chr20

   LET r_errno = ''
   IF NOT cl_null(p_fmai002) THEN
      SELECT fmcestus INTO l_fmcestus FROM fmce_t
       WHERE fmceent = g_enterprise AND fmcedocno = p_fmai002
      CASE 
         WHEN SQLCA.SQLCODE = 100 LET r_errno = 'afm-00151'
         WHEN l_fmcestus <> 'Y' LET r_errno = 'afm-00152'
      END CASE
   END IF
    
   IF NOT cl_null(p_fmai002) AND NOT cl_null(p_fmai003) THEN  
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM fmcf_t 
       WHERE fmcfent = g_enterprise AND fmcfdocno = p_fmai002
         AND fmcfseq = p_fmai003
      IF l_n = 0 THEN
         LET r_errno = 'afm-00153'
      END IF
   END IF
   RETURN r_errno
END FUNCTION

################################################################################
# Descriptions...: 融资申请单号+项次 栏位带孩子
# Memo...........:
# Usage..........: CALL afmt025_fmai002_ref(p_fmai002,p_fmai003)
# Date & Author..: 2015/11/09 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt025_fmai002_ref(p_fmai002,p_fmai003)
DEFINE p_fmai002         LIKE fmai_t.fmai002
DEFINE p_fmai003         LIKE fmai_t.fmai003

   IF NOT cl_null(p_fmai002) AND NOT cl_null(p_fmai003) THEN
      SELECT fmcf002,fmcf003 INTO g_fmah2_d[l_ac].fmcf002,g_fmah2_d[l_ac].fmcf003 FROM fmcf_t
       WHERE fmcfent = g_enterprise AND fmcfdocno = p_fmai002
         AND fmcfseq = p_fmai003
      
   END IF
END FUNCTION

################################################################################
# Descriptions...: 审核单号+融资清单项次 带值
# Memo...........:
# Usage..........: CALL afmt025_fmaiseq_ref()
# Date & Author..: 2015/11/09 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt025_fmaiseq_ref()
   
   SELECT fmah001,fmah006 INTO g_fmah2_d[l_ac].fmah001,g_fmah2_d[l_ac].fmah006 FROM fmah_t
    WHERE fmahent = g_enterprise AND fmahdocno = g_fmag_m.fmagdocno
      AND fmahseq = g_fmah2_d[l_ac].fmaiseq
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fmah2_d[l_ac].fmah001
   CALL ap_ref_array2(g_ref_fields,"SELECT fmaal003 FROM fmaal_t WHERE fmaalent='"||g_enterprise||"' AND fmaal001=? AND fmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fmah2_d[l_ac].fmah001_1_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fmah2_d[l_ac].fmah001_1_desc
END FUNCTION

################################################################################
# Descriptions...: 金额检查
# Memo...........:
# Usage..........: CALL afmt025_fmai004_chk()
#                  RETURNING r_success
# Date & Author..: 2015/11/09 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt025_fmai004_chk(p_cmd1)
DEFINE p_cmd1                LIKE type_t.chr1
DEFINE l_fmai004_sum          LIKE fmai_t.fmai004
DEFINE l_fmah007              LIKE fmah_t.fmah007
DEFINE r_errno                LIKE type_t.chr20

   LET r_errno = ''
   #一个审核单融资清单项次的SUM(fmai004）不可大于该审核单项次的fmah007
   SELECT SUM(fmai004) INTO l_fmai004_sum FROM fmai_t
    WHERE fmaient = g_enterprise AND fmaidocno = g_fmag_m.fmagdocno
      AND fmaiseq = g_fmah2_d[l_ac].fmaiseq
   
   SELECT fmah007 INTO l_fmah007 FROM fmah_t
    WHERE fmahent = g_enterprise AND fmahdocno = g_fmag_m.fmagdocno
      AND fmahseq = g_fmah2_d[l_ac].fmaiseq
   
   IF cl_null(l_fmai004_sum) THEN LET l_fmai004_sum = 0 END IF
   IF cl_null(l_fmah007) THEN LET l_fmah007 = 0 END IF
   IF p_cmd1 = 'a' THEN   
      IF l_fmai004_sum + g_fmah2_d[l_ac].fmai004 > l_fmah007 THEN
         LET r_errno = 'afm-00154'
      END IF
   ELSE
      IF p_cmd1 = '' THEN
         IF l_fmai004_sum > l_fmah007 THEN
            LET r_errno = 'afm-00154'
            
         END IF
      END IF
      IF l_fmai004_sum + g_fmah2_d[l_ac].fmai004 - g_fmah2_d_t.fmai004 > l_fmah007 THEN
         LET r_errno = 'afm-00154'
      END IF
   END IF
      
   RETURN r_errno
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL afmt025_fmai004_chk1(p_cmd1)
# Date & Author..: 2015/11/09 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt025_fmai004_chk1(p_cmd1)
DEFINE p_cmd1         LIKE type_t.chr1
DEFINE l_fmai004_sum  LIKE fmai_t.fmai004
DEFINE l_fmcf003      LIKE fmcf_t.fmcf003
DEFINE r_success      LIKE type_t.num5

   
   LET r_success = TRUE
   IF NOT cl_null(g_fmah2_d[l_ac].fmai002) AND NOT cl_null(g_fmah2_d[l_ac].fmai003) THEN
      ##一个申请单+项次的SUM(fmai004,大于该申请单+项次的融资规模fmaf003时，提醒，确认后继续
      
      #SUM(fmai004)
      SELECT SUM(fmai004) INTO l_fmai004_sum FROM fmag_t,fmai_t 
       WHERE fmagent = fmaient AND fmagdocno = fmahdocno 
         AND fmaient = g_enterprise AND fmagstus <> 'X' 
         AND fmai002 = g_fmah2_d[l_ac].fmai002 AND fmai003 = g_fmah2_d[l_ac].fmai003
         
      #SUM(fmad004)
      SELECT fmcf003 INTO l_fmcf003 FROM fmce_t,fmcf_t
       WHERE fmcfent = fmceent AND fmcfdocno = fmcedocno
         AND fmcfent = g_enterprise AND fmcestus <> 'X'
         AND fmcfdocno = g_fmah2_d[l_ac].fmai002 AND fmcfseq = g_fmah2_d[l_ac].fmai003
      
      IF cl_null(l_fmai004_sum) THEN LET l_fmai004_sum = 0 END IF
      IF cl_null(l_fmcf003) THEN LET l_fmcf003 = 0 END IF
      IF p_cmd1 = 'a' THEN   
         IF l_fmai004_sum + g_fmah2_d[l_ac].fmai004 > l_fmcf003 THEN
            LET r_success = FALSE
         END IF
      ELSE
         IF p_cmd1 = '' THEN
            IF l_fmai004_sum > l_fmcf003 THEN
               LET r_success = FALSE
            END IF
         END IF
         IF l_fmai004_sum + g_fmah2_d[l_ac].fmai004 - g_fmah2_d_t.fmai004 > l_fmcf003 THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 审核段检查
# Memo...........:
# Usage..........: CALL afmt025_confirm_chk()
# Date & Author..: 2015/11/09 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt025_confirm_chk()
DEFINE r_errno           LIKE type_t.chr20
DEFINE l_n               LIKE type_t.num5
DEFINE l_success         LIKE type_t.num5
DEFINE l_fmaiseq         LIKE fmai_t.fmaiseq
DEFINE l_fmai002         LIKE fmai_t.fmai002
DEFINE l_fmai003         LIKE fmai_t.fmai003
DEFINE l_fmai004_sum     LIKE fmai_t.fmai004
DEFINE l_fmah007         LIKE fmah_t.fmah007
DEFINE l_fmcf003         LIKE fmcf_t.fmcf003
DEFINE l_sql             STRING

   #此資料已作廢,不可再異動
   IF g_fmag_m.fmagstus = 'X' THEN
      LET r_errno = 'afm-00029'
     #  RETURN   # 160415-00013#1 16/04/19 By 07900  mark
     # 160415-00013#1 16/04/19 By 07900  add -- str - 
        RETURN  r_errno
     # 160415-00013#1 16/04/19 By 07900  add -- end -      
   END IF
   
   #檢查單身是否有資料
  # 160415-00013#1 16/04/19 By 07900  mark -- s-
  # LET l_n = 0
  #SELECT count(*) INTO l_n
  #   FROM fmag_t
  #  WHERE fmagent = g_enterprise
  #    AND fmagdocno = g_fmag_m.fmagdocno
  # IF l_n = 0 THEN
  #    LET r_errno = 'aec-00020'
  #    RETURN
  # END IF
  # 160415-00013#1 16/04/19 By 07900  mark -- e-  
  
  # 160415-00013#1 16/04/19 By 07900  add -- str -  
    LET l_n = 0
    SELECT count(*) INTO l_n
      FROM fmah_t
     WHERE fmahent = g_enterprise 
       AND fmahdocno = g_fmag_m.fmagdocno
    IF l_n = 0 THEN
      LET r_errno = 'aec-00020'
      RETURN r_errno
    END IF
    LET l_n = 0 
    SELECT count(*) INTO l_n
      FROM fmai_t
     WHERE fmaient = g_enterprise   
       AND fmaidocno = g_fmag_m.fmagdocno
    IF l_n = 0 THEN
      LET r_errno = 'aec-00020'
      RETURN r_errno
    END IF
   # 160415-00013#1 16/04/19 By 07900  add -- end -   
   #金额检查
   LET l_sql = " SELECT fmaiseq,fmai002,fmai003 FROM fmai_t ",
               "  WHERE fmaient = ",g_enterprise," AND fmaidocno = '",g_fmag_m.fmagdocno,"'"
   PREPARE fmai_chk_prep FROM l_sql
   DECLARE fmai_chk_curs CURSOR FOR fmai_chk_prep
   FOREACH fmai_chk_curs INTO l_fmaiseq,l_fmai002,l_fmai003
      #一个申请单+项次的SUM(fmai004,大于该申请单+项次的融资规模fmaf003时，提醒，确认后继续
      
      #SUM(fmai004)
      SELECT SUM(fmai004) INTO l_fmai004_sum FROM fmag_t,fmai_t 
       WHERE fmagent = fmaient AND fmagdocno = fmahdocno 
         AND fmaient = g_enterprise AND fmagstus <> 'X' 
         AND fmai002 = l_fmai002 AND fmai003 = l_fmai003
         
      #SUM(fmad004)
      SELECT fmcf003 INTO l_fmcf003 FROM fmce_t,fmcf_t
       WHERE fmcfent = fmceent AND fmcfdocno = fmcedocno
         AND fmcfent = g_enterprise AND fmcestus <> 'X'
         AND fmcfdocno = l_fmai002 AND fmcfseq = l_fmai003
      
      IF cl_null(l_fmai004_sum) THEN LET l_fmai004_sum = 0 END IF
      IF cl_null(l_fmcf003) THEN LET l_fmcf003 = 0 END IF
      IF l_fmai004_sum > l_fmcf003 THEN
         LET r_errno ='afm-00155' 
         EXIT FOREACH
      END IF
      
      #一个审核单融资清单项次的SUM(fmai004）不可大于该审核单项次的fmah007
      SELECT SUM(fmai004) INTO l_fmai004_sum FROM fmai_t
       WHERE fmaient = g_enterprise AND fmaidocno = g_fmag_m.fmagdocno
         AND fmaiseq = l_fmaiseq
      
      SELECT fmah007 INTO l_fmah007 FROM fmah_t
       WHERE fmahent = g_enterprise AND fmahdocno = g_fmag_m.fmagdocno
         AND fmahseq = l_fmaiseq
      
      IF cl_null(l_fmai004_sum) THEN LET l_fmai004_sum = 0 END IF
      IF cl_null(l_fmah007) THEN LET l_fmah007 = 0 END IF
      IF l_fmai004_sum > l_fmah007 THEN
         LET r_errno = 'afm-00154'
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_errno
END FUNCTION

 
{</section>}
 
