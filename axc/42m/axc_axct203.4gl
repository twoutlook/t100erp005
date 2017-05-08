#該程式未解開Section, 採用最新樣板產出!
{<section id="axct203.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0017(2016-10-26 14:08:15), PR版次:0017(2017-04-11 10:59:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000061
#+ Filename...: axct203
#+ Description: 製程成本工時報工維護作業
#+ Creator....: 05426(2015-02-02 14:45:26)
#+ Modifier...: 02295 -SD/PR- 02111
 
{</section>}
 
{<section id="axct203.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151130-00015#2  2015/12/21 BY Xiaozg  根据是否可以更改單據日期 設定開放單據日期修改
#160318-00025#47 2016/04/29 By 07959   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160816-00068#3  2016/08/17 By earl    調整transaction
#160818-00017#42 2016-08-25 By 08734   删除修改未重新判断状态码
#161019-00017#11 2016/10/20 By 08734   调整营运组织在查询和新增时开窗由q_ooef001_14和q_ooef001变为q_ooef001_1,法人组织开窗由q_ooef001_8变为q_ooef001_2,并修改校验与开窗一致
#160929-00005#2  2016/10/28 By 02295   增加产生期未在制量的处理逻辑
#170203-00001#1  2017/02/28 By lixh    新增時，需控卡是否有法人、帳套權限
#170313-00009#1  2017/03/14 By 08734   单头的【营运组织】栏位，管控不可录入开窗不存在的组织。
#160711-00040#35 2017/03/29 By 08734   T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                      CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
#170410-00045#1  2017/04/11 By 02111   有合計功能，需重新DISPLAY所有頁籤才可以查詢。
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
PRIVATE type type_g_xcbq_m        RECORD
       xcbqdocno LIKE xcbq_t.xcbqdocno, 
   xcbqdocno_desc LIKE type_t.chr80, 
   xcbqsite LIKE xcbq_t.xcbqsite, 
   xcbqsite_desc LIKE type_t.chr80, 
   xcbq002 LIKE xcbq_t.xcbq002, 
   xcbq001 LIKE xcbq_t.xcbq001, 
   xcbqcomp LIKE xcbq_t.xcbqcomp, 
   xcbqcomp_desc LIKE type_t.chr80, 
   xcbqstus LIKE xcbq_t.xcbqstus, 
   xcbqownid LIKE xcbq_t.xcbqownid, 
   xcbqownid_desc LIKE type_t.chr80, 
   xcbqowndp LIKE xcbq_t.xcbqowndp, 
   xcbqowndp_desc LIKE type_t.chr80, 
   xcbqcrtid LIKE xcbq_t.xcbqcrtid, 
   xcbqcrtid_desc LIKE type_t.chr80, 
   xcbqcrtdp LIKE xcbq_t.xcbqcrtdp, 
   xcbqcrtdp_desc LIKE type_t.chr80, 
   xcbqcrtdt LIKE xcbq_t.xcbqcrtdt, 
   xcbqmodid LIKE xcbq_t.xcbqmodid, 
   xcbqmodid_desc LIKE type_t.chr80, 
   xcbqmoddt LIKE xcbq_t.xcbqmoddt, 
   xcbqcnfid LIKE xcbq_t.xcbqcnfid, 
   xcbqcnfid_desc LIKE type_t.chr80, 
   xcbqcnfdt LIKE xcbq_t.xcbqcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcbr_d        RECORD
       xcbrseq LIKE xcbr_t.xcbrseq, 
   xcbr002 LIKE xcbr_t.xcbr002, 
   sffb029 LIKE type_t.chr500, 
   sffb029_desc LIKE type_t.chr500, 
   sffb029_desc_2 LIKE type_t.chr500, 
   sfaa011 LIKE type_t.chr30, 
   sfaa011_desc1 LIKE type_t.chr500, 
   xcbr003 LIKE xcbr_t.xcbr003, 
   xcbr003_desc LIKE type_t.chr500, 
   xcbr004 LIKE xcbr_t.xcbr004, 
   xcbr001 LIKE xcbr_t.xcbr001, 
   xcbr001_desc LIKE type_t.chr500, 
   xcbr099 LIKE xcbr_t.xcbr099, 
   xcbr100 LIKE xcbr_t.xcbr100, 
   xcbr101 LIKE xcbr_t.xcbr101, 
   xcbr102 LIKE xcbr_t.xcbr102, 
   xcbr103 LIKE xcbr_t.xcbr103, 
   xcbr104 LIKE xcbr_t.xcbr104, 
   xcbr201 LIKE xcbr_t.xcbr201, 
   xcbr202 LIKE xcbr_t.xcbr202, 
   xcbr203 LIKE xcbr_t.xcbr203, 
   xcbr204 LIKE xcbr_t.xcbr204, 
   xcbr009 LIKE xcbr_t.xcbr009
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_xcbqdocno LIKE xcbq_t.xcbqdocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_yy                  LIKE type_t.num5
DEFINE g_mm                  LIKE type_t.num5
DEFINE g_ooef004             LIKE ooef_t.ooef004
DEFINE g_glaa003             LIKE glaa_t.glaa003
DEFINE g_glaa024             LIKE glaa_t.glaa024
DEFINE g_glaald              LIKE glaa_t.glaald
DEFINE g_sfaa016             LIKE sfaa_t.sfaa016          #制程编号
#170203-00001#2-S
DEFINE  g_wc_cs_ld    STRING
DEFINE  g_wc_cs_comp  STRING
#170203-00001#2-E
#end add-point
       
#模組變數(Module Variables)
DEFINE g_xcbq_m          type_g_xcbq_m
DEFINE g_xcbq_m_t        type_g_xcbq_m
DEFINE g_xcbq_m_o        type_g_xcbq_m
DEFINE g_xcbq_m_mask_o   type_g_xcbq_m #轉換遮罩前資料
DEFINE g_xcbq_m_mask_n   type_g_xcbq_m #轉換遮罩後資料
 
   DEFINE g_xcbqdocno_t LIKE xcbq_t.xcbqdocno
 
 
DEFINE g_xcbr_d          DYNAMIC ARRAY OF type_g_xcbr_d
DEFINE g_xcbr_d_t        type_g_xcbr_d
DEFINE g_xcbr_d_o        type_g_xcbr_d
DEFINE g_xcbr_d_mask_o   DYNAMIC ARRAY OF type_g_xcbr_d #轉換遮罩前資料
DEFINE g_xcbr_d_mask_n   DYNAMIC ARRAY OF type_g_xcbr_d #轉換遮罩後資料
 
 
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
 
{<section id="axct203.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xcbqdocno,'',xcbqsite,'',xcbq002,xcbq001,xcbqcomp,'',xcbqstus,xcbqownid, 
       '',xcbqowndp,'',xcbqcrtid,'',xcbqcrtdp,'',xcbqcrtdt,xcbqmodid,'',xcbqmoddt,xcbqcnfid,'',xcbqcnfdt", 
        
                      " FROM xcbq_t",
                      " WHERE xcbqent= ? AND xcbqdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct203_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xcbqdocno,t0.xcbqsite,t0.xcbq002,t0.xcbq001,t0.xcbqcomp,t0.xcbqstus, 
       t0.xcbqownid,t0.xcbqowndp,t0.xcbqcrtid,t0.xcbqcrtdp,t0.xcbqcrtdt,t0.xcbqmodid,t0.xcbqmoddt,t0.xcbqcnfid, 
       t0.xcbqcnfdt,t1.ooefl003 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 , 
       t8.ooag011",
               " FROM xcbq_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xcbqsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.xcbqcomp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.xcbqownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.xcbqowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.xcbqcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.xcbqcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.xcbqmodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.xcbqcnfid  ",
 
               " WHERE t0.xcbqent = " ||g_enterprise|| " AND t0.xcbqdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axct203_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axct203 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axct203_init()   
 
      #進入選單 Menu (="N")
      CALL axct203_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axct203
      
   END IF 
   
   CLOSE axct203_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axct203.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axct203_init()
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('xcbqstus','50','N,Y,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #170203-00001#1-S
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld   
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp   
   #170203-00001#1-E
   #end add-point
   
   #初始化搜尋條件
   CALL axct203_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axct203.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axct203_ui_dialog()
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
            CALL axct203_insert()
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
         INITIALIZE g_xcbq_m.* TO NULL
         CALL g_xcbr_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axct203_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_xcbr_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axct203_idx_chk()
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
               CALL axct203_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL axct203_browser_fill("")
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
               CALL axct203_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axct203_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL axct203_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL axct203_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL axct203_set_act_visible()   
            CALL axct203_set_act_no_visible()
            IF NOT (g_xcbq_m.xcbqdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " xcbqent = " ||g_enterprise|| " AND",
                                  " xcbqdocno = '", g_xcbq_m.xcbqdocno, "' "
 
               #填到對應位置
               CALL axct203_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "xcbq_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xcbr_t" 
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
               CALL axct203_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "xcbq_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xcbr_t" 
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
                  CALL axct203_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL axct203_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axct203_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct203_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axct203_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct203_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axct203_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct203_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axct203_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct203_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axct203_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct203_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_xcbr_d)
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
               CALL axct203_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axct203_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axct203_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axct203_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION count_qty
            LET g_action_choice="count_qty"
            IF cl_auth_chk_act("count_qty") THEN
               
               #add-point:ON ACTION count_qty name="menu.count_qty"
               CALL axct203_count_qty()   #160929-00005#2
               CALL axct203_show()        #160929-00005#2
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/axc/axct203_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/axc/axct203_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axct203_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axct203_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axcp203
            LET g_action_choice="open_axcp203"
            IF cl_auth_chk_act("open_axcp203") THEN
               
               #add-point:ON ACTION open_axcp203 name="menu.open_axcp203"
               LET la_param.prog = 'axcp203'
#               LET la_param.param[1] = g_fabg_m.fabgld
#               LET la_param.param[2] = g_fabg_m.fabg008
#               LET ls_js = util.JSON.stringify(la_param)
#               CALL cl_cmdrun(ls_js)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axct203_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axct203_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axct203_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
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
 
{<section id="axct203.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axct203_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT xcbqdocno ",
                      " FROM xcbq_t ",
                      " ",
                      " LEFT JOIN xcbr_t ON xcbrent = xcbqent AND xcbqdocno = xcbrdocno ", "  ",
                      #add-point:browser_fill段sql(xcbr_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE xcbqent = " ||g_enterprise|| " AND xcbrent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcbq_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xcbqdocno ",
                      " FROM xcbq_t ", 
                      "  ",
                      "  ",
                      " WHERE xcbqent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xcbq_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   #170203-00001#2-S
   IF NOT cl_null(g_wc_cs_comp) THEN 
      LET l_sub_sql = l_sub_sql," AND xcbqcomp IN ",g_wc_cs_comp
   END IF 
   #170203-00001#2-E
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
      INITIALIZE g_xcbq_m.* TO NULL
      CALL g_xcbr_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xcbqdocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xcbqstus,t0.xcbqdocno ",
                  " FROM xcbq_t t0",
                  "  ",
                  "  LEFT JOIN xcbr_t ON xcbrent = xcbqent AND xcbqdocno = xcbrdocno ", "  ", 
                  #add-point:browser_fill段sql(xcbr_t1) name="browser_fill.join.xcbr_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.xcbqent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("xcbq_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xcbqstus,t0.xcbqdocno ",
                  " FROM xcbq_t t0",
                  "  ",
                  
                  " WHERE t0.xcbqent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("xcbq_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   #170203-00001#2-S
   IF NOT cl_null(g_wc_cs_comp) THEN 
      LET g_sql = g_sql," AND xcbqcomp IN ",g_wc_cs_comp
   END IF 
   #170203-00001#2-E
   #end add-point
   LET g_sql = g_sql, " ORDER BY xcbqdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcbq_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xcbqdocno
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
            LET g_browser[g_cnt].b_statepic = "stus/16/open.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/valid.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/void.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_xcbqdocno) THEN
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
 
{<section id="axct203.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axct203_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xcbq_m.xcbqdocno = g_browser[g_current_idx].b_xcbqdocno   
 
   EXECUTE axct203_master_referesh USING g_xcbq_m.xcbqdocno INTO g_xcbq_m.xcbqdocno,g_xcbq_m.xcbqsite, 
       g_xcbq_m.xcbq002,g_xcbq_m.xcbq001,g_xcbq_m.xcbqcomp,g_xcbq_m.xcbqstus,g_xcbq_m.xcbqownid,g_xcbq_m.xcbqowndp, 
       g_xcbq_m.xcbqcrtid,g_xcbq_m.xcbqcrtdp,g_xcbq_m.xcbqcrtdt,g_xcbq_m.xcbqmodid,g_xcbq_m.xcbqmoddt, 
       g_xcbq_m.xcbqcnfid,g_xcbq_m.xcbqcnfdt,g_xcbq_m.xcbqsite_desc,g_xcbq_m.xcbqcomp_desc,g_xcbq_m.xcbqownid_desc, 
       g_xcbq_m.xcbqowndp_desc,g_xcbq_m.xcbqcrtid_desc,g_xcbq_m.xcbqcrtdp_desc,g_xcbq_m.xcbqmodid_desc, 
       g_xcbq_m.xcbqcnfid_desc
   
   CALL axct203_xcbq_t_mask()
   CALL axct203_show()
      
END FUNCTION
 
{</section>}
 
{<section id="axct203.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axct203_ui_detailshow()
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
 
{<section id="axct203.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axct203_ui_browser_refresh()
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
      IF g_browser[l_i].b_xcbqdocno = g_xcbq_m.xcbqdocno 
 
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
 
{<section id="axct203.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axct203_construct()
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
   INITIALIZE g_xcbq_m.* TO NULL
   CALL g_xcbr_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON xcbqdocno,xcbqdocno_desc,xcbqsite,xcbq002,xcbq001,xcbqcomp,xcbqstus, 
          xcbqownid,xcbqowndp,xcbqcrtid,xcbqcrtdp,xcbqcrtdt,xcbqmodid,xcbqmoddt,xcbqcnfid,xcbqcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xcbqcrtdt>>----
         AFTER FIELD xcbqcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xcbqmoddt>>----
         AFTER FIELD xcbqmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xcbqcnfdt>>----
         AFTER FIELD xcbqcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xcbqpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.xcbqdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbqdocno
            #add-point:ON ACTION controlp INFIELD xcbqdocno name="construct.c.xcbqdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xcbqdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbqdocno  #顯示到畫面上
            NEXT FIELD xcbqdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqdocno
            #add-point:BEFORE FIELD xcbqdocno name="construct.b.xcbqdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbqdocno
            
            #add-point:AFTER FIELD xcbqdocno name="construct.a.xcbqdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqdocno_desc
            #add-point:BEFORE FIELD xcbqdocno_desc name="construct.b.xcbqdocno_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbqdocno_desc
            
            #add-point:AFTER FIELD xcbqdocno_desc name="construct.a.xcbqdocno_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcbqdocno_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbqdocno_desc
            #add-point:ON ACTION controlp INFIELD xcbqdocno_desc name="construct.c.xcbqdocno_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcbqsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbqsite
            #add-point:ON ACTION controlp INFIELD xcbqsite name="construct.c.xcbqsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_1()                           #呼叫開窗   #161019-00017#11 2016/10/20 By 08734
            DISPLAY g_qryparam.return1 TO xcbqsite  #顯示到畫面上
            NEXT FIELD xcbqsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqsite
            #add-point:BEFORE FIELD xcbqsite name="construct.b.xcbqsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbqsite
            
            #add-point:AFTER FIELD xcbqsite name="construct.a.xcbqsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbq002
            #add-point:BEFORE FIELD xcbq002 name="construct.b.xcbq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbq002
            
            #add-point:AFTER FIELD xcbq002 name="construct.a.xcbq002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcbq002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbq002
            #add-point:ON ACTION controlp INFIELD xcbq002 name="construct.c.xcbq002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbq001
            #add-point:BEFORE FIELD xcbq001 name="construct.b.xcbq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbq001
            
            #add-point:AFTER FIELD xcbq001 name="construct.a.xcbq001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcbq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbq001
            #add-point:ON ACTION controlp INFIELD xcbq001 name="construct.c.xcbq001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcbqcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbqcomp
            #add-point:ON ACTION controlp INFIELD xcbqcomp name="construct.c.xcbqcomp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #170203-00001#2-S
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF                
            #170203-00001#2-E
            CALL q_ooef001_2()                           #呼叫開窗   #161019-00017#11 2016/10/20 By 08734
            DISPLAY g_qryparam.return1 TO xcbqcomp  #顯示到畫面上
            NEXT FIELD xcbqcomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqcomp
            #add-point:BEFORE FIELD xcbqcomp name="construct.b.xcbqcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbqcomp
            
            #add-point:AFTER FIELD xcbqcomp name="construct.a.xcbqcomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqstus
            #add-point:BEFORE FIELD xcbqstus name="construct.b.xcbqstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbqstus
            
            #add-point:AFTER FIELD xcbqstus name="construct.a.xcbqstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcbqstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbqstus
            #add-point:ON ACTION controlp INFIELD xcbqstus name="construct.c.xcbqstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcbqownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbqownid
            #add-point:ON ACTION controlp INFIELD xcbqownid name="construct.c.xcbqownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbqownid  #顯示到畫面上
            NEXT FIELD xcbqownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqownid
            #add-point:BEFORE FIELD xcbqownid name="construct.b.xcbqownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbqownid
            
            #add-point:AFTER FIELD xcbqownid name="construct.a.xcbqownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcbqowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbqowndp
            #add-point:ON ACTION controlp INFIELD xcbqowndp name="construct.c.xcbqowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbqowndp  #顯示到畫面上
            NEXT FIELD xcbqowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqowndp
            #add-point:BEFORE FIELD xcbqowndp name="construct.b.xcbqowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbqowndp
            
            #add-point:AFTER FIELD xcbqowndp name="construct.a.xcbqowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcbqcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbqcrtid
            #add-point:ON ACTION controlp INFIELD xcbqcrtid name="construct.c.xcbqcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbqcrtid  #顯示到畫面上
            NEXT FIELD xcbqcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqcrtid
            #add-point:BEFORE FIELD xcbqcrtid name="construct.b.xcbqcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbqcrtid
            
            #add-point:AFTER FIELD xcbqcrtid name="construct.a.xcbqcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcbqcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbqcrtdp
            #add-point:ON ACTION controlp INFIELD xcbqcrtdp name="construct.c.xcbqcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbqcrtdp  #顯示到畫面上
            NEXT FIELD xcbqcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqcrtdp
            #add-point:BEFORE FIELD xcbqcrtdp name="construct.b.xcbqcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbqcrtdp
            
            #add-point:AFTER FIELD xcbqcrtdp name="construct.a.xcbqcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqcrtdt
            #add-point:BEFORE FIELD xcbqcrtdt name="construct.b.xcbqcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcbqmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbqmodid
            #add-point:ON ACTION controlp INFIELD xcbqmodid name="construct.c.xcbqmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbqmodid  #顯示到畫面上
            NEXT FIELD xcbqmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqmodid
            #add-point:BEFORE FIELD xcbqmodid name="construct.b.xcbqmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbqmodid
            
            #add-point:AFTER FIELD xcbqmodid name="construct.a.xcbqmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqmoddt
            #add-point:BEFORE FIELD xcbqmoddt name="construct.b.xcbqmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcbqcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbqcnfid
            #add-point:ON ACTION controlp INFIELD xcbqcnfid name="construct.c.xcbqcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbqcnfid  #顯示到畫面上
            NEXT FIELD xcbqcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqcnfid
            #add-point:BEFORE FIELD xcbqcnfid name="construct.b.xcbqcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbqcnfid
            
            #add-point:AFTER FIELD xcbqcnfid name="construct.a.xcbqcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqcnfdt
            #add-point:BEFORE FIELD xcbqcnfdt name="construct.b.xcbqcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON xcbrseq,xcbr002,sffb029,sfaa011,sfaa011_desc1,xcbr003,xcbr004,xcbr001, 
          xcbr099,xcbr100,xcbr101,xcbr102,xcbr103,xcbr104,xcbr201,xcbr202,xcbr203,xcbr204,xcbr009
           FROM s_detail1[1].xcbrseq,s_detail1[1].xcbr002,s_detail1[1].sffb029,s_detail1[1].sfaa011, 
               s_detail1[1].sfaa011_desc1,s_detail1[1].xcbr003,s_detail1[1].xcbr004,s_detail1[1].xcbr001, 
               s_detail1[1].xcbr099,s_detail1[1].xcbr100,s_detail1[1].xcbr101,s_detail1[1].xcbr102,s_detail1[1].xcbr103, 
               s_detail1[1].xcbr104,s_detail1[1].xcbr201,s_detail1[1].xcbr202,s_detail1[1].xcbr203,s_detail1[1].xcbr204, 
               s_detail1[1].xcbr009
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbrseq
            #add-point:BEFORE FIELD xcbrseq name="construct.b.page1.xcbrseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbrseq
            
            #add-point:AFTER FIELD xcbrseq name="construct.a.page1.xcbrseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbrseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbrseq
            #add-point:ON ACTION controlp INFIELD xcbrseq name="construct.c.page1.xcbrseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcbr002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr002
            #add-point:ON ACTION controlp INFIELD xcbr002 name="construct.c.page1.xcbr002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where="sffbstus='Y'"
            CALL q_sffbdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbr002  #顯示到畫面上
            NEXT FIELD xcbr002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr002
            #add-point:BEFORE FIELD xcbr002 name="construct.b.page1.xcbr002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr002
            
            #add-point:AFTER FIELD xcbr002 name="construct.a.page1.xcbr002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sffb029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb029
            #add-point:ON ACTION controlp INFIELD sffb029 name="construct.c.page1.sffb029"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffb029  #顯示到畫面上
            NEXT FIELD sffb029                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb029
            #add-point:BEFORE FIELD sffb029 name="construct.b.page1.sffb029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb029
            
            #add-point:AFTER FIELD sffb029 name="construct.a.page1.sffb029"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa011
            #add-point:BEFORE FIELD sfaa011 name="construct.b.page1.sfaa011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa011
            
            #add-point:AFTER FIELD sfaa011 name="construct.a.page1.sfaa011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfaa011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa011
            #add-point:ON ACTION controlp INFIELD sfaa011 name="construct.c.page1.sfaa011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa011_desc1
            #add-point:BEFORE FIELD sfaa011_desc1 name="construct.b.page1.sfaa011_desc1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa011_desc1
            
            #add-point:AFTER FIELD sfaa011_desc1 name="construct.a.page1.sfaa011_desc1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfaa011_desc1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa011_desc1
            #add-point:ON ACTION controlp INFIELD sfaa011_desc1 name="construct.c.page1.sfaa011_desc1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcbr003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr003
            #add-point:ON ACTION controlp INFIELD xcbr003 name="construct.c.page1.xcbr003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_sfcb003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbr003  #顯示到畫面上
            NEXT FIELD xcbr003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr003
            #add-point:BEFORE FIELD xcbr003 name="construct.b.page1.xcbr003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr003
            
            #add-point:AFTER FIELD xcbr003 name="construct.a.page1.xcbr003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr004
            #add-point:BEFORE FIELD xcbr004 name="construct.b.page1.xcbr004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr004
            
            #add-point:AFTER FIELD xcbr004 name="construct.a.page1.xcbr004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbr004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr004
            #add-point:ON ACTION controlp INFIELD xcbr004 name="construct.c.page1.xcbr004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcbr001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr001
            #add-point:ON ACTION controlp INFIELD xcbr001 name="construct.c.page1.xcbr001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbr001  #顯示到畫面上
            NEXT FIELD xcbr001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr001
            #add-point:BEFORE FIELD xcbr001 name="construct.b.page1.xcbr001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr001
            
            #add-point:AFTER FIELD xcbr001 name="construct.a.page1.xcbr001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr099
            #add-point:BEFORE FIELD xcbr099 name="construct.b.page1.xcbr099"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr099
            
            #add-point:AFTER FIELD xcbr099 name="construct.a.page1.xcbr099"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbr099
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr099
            #add-point:ON ACTION controlp INFIELD xcbr099 name="construct.c.page1.xcbr099"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr100
            #add-point:BEFORE FIELD xcbr100 name="construct.b.page1.xcbr100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr100
            
            #add-point:AFTER FIELD xcbr100 name="construct.a.page1.xcbr100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbr100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr100
            #add-point:ON ACTION controlp INFIELD xcbr100 name="construct.c.page1.xcbr100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr101
            #add-point:BEFORE FIELD xcbr101 name="construct.b.page1.xcbr101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr101
            
            #add-point:AFTER FIELD xcbr101 name="construct.a.page1.xcbr101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbr101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr101
            #add-point:ON ACTION controlp INFIELD xcbr101 name="construct.c.page1.xcbr101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr102
            #add-point:BEFORE FIELD xcbr102 name="construct.b.page1.xcbr102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr102
            
            #add-point:AFTER FIELD xcbr102 name="construct.a.page1.xcbr102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbr102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr102
            #add-point:ON ACTION controlp INFIELD xcbr102 name="construct.c.page1.xcbr102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr103
            #add-point:BEFORE FIELD xcbr103 name="construct.b.page1.xcbr103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr103
            
            #add-point:AFTER FIELD xcbr103 name="construct.a.page1.xcbr103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbr103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr103
            #add-point:ON ACTION controlp INFIELD xcbr103 name="construct.c.page1.xcbr103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr104
            #add-point:BEFORE FIELD xcbr104 name="construct.b.page1.xcbr104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr104
            
            #add-point:AFTER FIELD xcbr104 name="construct.a.page1.xcbr104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbr104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr104
            #add-point:ON ACTION controlp INFIELD xcbr104 name="construct.c.page1.xcbr104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr201
            #add-point:BEFORE FIELD xcbr201 name="construct.b.page1.xcbr201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr201
            
            #add-point:AFTER FIELD xcbr201 name="construct.a.page1.xcbr201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbr201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr201
            #add-point:ON ACTION controlp INFIELD xcbr201 name="construct.c.page1.xcbr201"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr202
            #add-point:BEFORE FIELD xcbr202 name="construct.b.page1.xcbr202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr202
            
            #add-point:AFTER FIELD xcbr202 name="construct.a.page1.xcbr202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbr202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr202
            #add-point:ON ACTION controlp INFIELD xcbr202 name="construct.c.page1.xcbr202"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr203
            #add-point:BEFORE FIELD xcbr203 name="construct.b.page1.xcbr203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr203
            
            #add-point:AFTER FIELD xcbr203 name="construct.a.page1.xcbr203"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbr203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr203
            #add-point:ON ACTION controlp INFIELD xcbr203 name="construct.c.page1.xcbr203"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr204
            #add-point:BEFORE FIELD xcbr204 name="construct.b.page1.xcbr204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr204
            
            #add-point:AFTER FIELD xcbr204 name="construct.a.page1.xcbr204"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbr204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr204
            #add-point:ON ACTION controlp INFIELD xcbr204 name="construct.c.page1.xcbr204"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr009
            #add-point:BEFORE FIELD xcbr009 name="construct.b.page1.xcbr009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr009
            
            #add-point:AFTER FIELD xcbr009 name="construct.a.page1.xcbr009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbr009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr009
            #add-point:ON ACTION controlp INFIELD xcbr009 name="construct.c.page1.xcbr009"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         #170410-00045#1 add start -----
         #加上合計功能後無法查詢，需重新DISPLAY所有頁籤
         LET g_xcbr_d[1].xcbrseq = ""
         DISPLAY ARRAY g_xcbr_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         #170410-00045#1 add end   -----
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
                  WHEN la_wc[li_idx].tableid = "xcbq_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xcbr_t" 
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
 
{<section id="axct203.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axct203_query()
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
   CALL g_xcbr_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL axct203_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axct203_browser_fill("")
      CALL axct203_fetch("")
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
   CALL axct203_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL axct203_fetch("F") 
      #顯示單身筆數
      CALL axct203_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axct203.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axct203_fetch(p_flag)
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
   
   LET g_xcbq_m.xcbqdocno = g_browser[g_current_idx].b_xcbqdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axct203_master_referesh USING g_xcbq_m.xcbqdocno INTO g_xcbq_m.xcbqdocno,g_xcbq_m.xcbqsite, 
       g_xcbq_m.xcbq002,g_xcbq_m.xcbq001,g_xcbq_m.xcbqcomp,g_xcbq_m.xcbqstus,g_xcbq_m.xcbqownid,g_xcbq_m.xcbqowndp, 
       g_xcbq_m.xcbqcrtid,g_xcbq_m.xcbqcrtdp,g_xcbq_m.xcbqcrtdt,g_xcbq_m.xcbqmodid,g_xcbq_m.xcbqmoddt, 
       g_xcbq_m.xcbqcnfid,g_xcbq_m.xcbqcnfdt,g_xcbq_m.xcbqsite_desc,g_xcbq_m.xcbqcomp_desc,g_xcbq_m.xcbqownid_desc, 
       g_xcbq_m.xcbqowndp_desc,g_xcbq_m.xcbqcrtid_desc,g_xcbq_m.xcbqcrtdp_desc,g_xcbq_m.xcbqmodid_desc, 
       g_xcbq_m.xcbqcnfid_desc
   
   #遮罩相關處理
   LET g_xcbq_m_mask_o.* =  g_xcbq_m.*
   CALL axct203_xcbq_t_mask()
   LET g_xcbq_m_mask_n.* =  g_xcbq_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axct203_set_act_visible()   
   CALL axct203_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_xcbq_m_t.* = g_xcbq_m.*
   LET g_xcbq_m_o.* = g_xcbq_m.*
   
   LET g_data_owner = g_xcbq_m.xcbqownid      
   LET g_data_dept  = g_xcbq_m.xcbqowndp
   
   #重新顯示   
   CALL axct203_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axct203.insert" >}
#+ 資料新增
PRIVATE FUNCTION axct203_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xcbr_d.clear()   
 
 
   INITIALIZE g_xcbq_m.* TO NULL             #DEFAULT 設定
   
   LET g_xcbqdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xcbq_m.xcbqownid = g_user
      LET g_xcbq_m.xcbqowndp = g_dept
      LET g_xcbq_m.xcbqcrtid = g_user
      LET g_xcbq_m.xcbqcrtdp = g_dept 
      LET g_xcbq_m.xcbqcrtdt = cl_get_current()
      LET g_xcbq_m.xcbqmodid = g_user
      LET g_xcbq_m.xcbqmoddt = cl_get_current()
      LET g_xcbq_m.xcbqstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_xcbq_m.xcbq001=cl_get_current()
      LET g_xcbq_m.xcbqsite=g_site
      SELECT ooef017 INTO g_xcbq_m.xcbqcomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site     
      CALL axct203_ref_show()
      CALL axct203_glaa_get()      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_xcbq_m_t.* = g_xcbq_m.*
      LET g_xcbq_m_o.* = g_xcbq_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xcbq_m.xcbqstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
    
      CALL axct203_input("a")
      
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
         INITIALIZE g_xcbq_m.* TO NULL
         INITIALIZE g_xcbr_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL axct203_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_xcbr_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axct203_set_act_visible()   
   CALL axct203_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xcbqdocno_t = g_xcbq_m.xcbqdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcbqent = " ||g_enterprise|| " AND",
                      " xcbqdocno = '", g_xcbq_m.xcbqdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axct203_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE axct203_cl
   
   CALL axct203_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axct203_master_referesh USING g_xcbq_m.xcbqdocno INTO g_xcbq_m.xcbqdocno,g_xcbq_m.xcbqsite, 
       g_xcbq_m.xcbq002,g_xcbq_m.xcbq001,g_xcbq_m.xcbqcomp,g_xcbq_m.xcbqstus,g_xcbq_m.xcbqownid,g_xcbq_m.xcbqowndp, 
       g_xcbq_m.xcbqcrtid,g_xcbq_m.xcbqcrtdp,g_xcbq_m.xcbqcrtdt,g_xcbq_m.xcbqmodid,g_xcbq_m.xcbqmoddt, 
       g_xcbq_m.xcbqcnfid,g_xcbq_m.xcbqcnfdt,g_xcbq_m.xcbqsite_desc,g_xcbq_m.xcbqcomp_desc,g_xcbq_m.xcbqownid_desc, 
       g_xcbq_m.xcbqowndp_desc,g_xcbq_m.xcbqcrtid_desc,g_xcbq_m.xcbqcrtdp_desc,g_xcbq_m.xcbqmodid_desc, 
       g_xcbq_m.xcbqcnfid_desc
   
   
   #遮罩相關處理
   LET g_xcbq_m_mask_o.* =  g_xcbq_m.*
   CALL axct203_xcbq_t_mask()
   LET g_xcbq_m_mask_n.* =  g_xcbq_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xcbq_m.xcbqdocno,g_xcbq_m.xcbqdocno_desc,g_xcbq_m.xcbqsite,g_xcbq_m.xcbqsite_desc, 
       g_xcbq_m.xcbq002,g_xcbq_m.xcbq001,g_xcbq_m.xcbqcomp,g_xcbq_m.xcbqcomp_desc,g_xcbq_m.xcbqstus, 
       g_xcbq_m.xcbqownid,g_xcbq_m.xcbqownid_desc,g_xcbq_m.xcbqowndp,g_xcbq_m.xcbqowndp_desc,g_xcbq_m.xcbqcrtid, 
       g_xcbq_m.xcbqcrtid_desc,g_xcbq_m.xcbqcrtdp,g_xcbq_m.xcbqcrtdp_desc,g_xcbq_m.xcbqcrtdt,g_xcbq_m.xcbqmodid, 
       g_xcbq_m.xcbqmodid_desc,g_xcbq_m.xcbqmoddt,g_xcbq_m.xcbqcnfid,g_xcbq_m.xcbqcnfid_desc,g_xcbq_m.xcbqcnfdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_xcbq_m.xcbqownid      
   LET g_data_dept  = g_xcbq_m.xcbqowndp
   
   #功能已完成,通報訊息中心
   CALL axct203_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axct203.modify" >}
#+ 資料修改
PRIVATE FUNCTION axct203_modify()
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
   LET g_xcbq_m_t.* = g_xcbq_m.*
   LET g_xcbq_m_o.* = g_xcbq_m.*
   
   IF g_xcbq_m.xcbqdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_xcbqdocno_t = g_xcbq_m.xcbqdocno
 
   CALL s_transaction_begin()
   
   OPEN axct203_cl USING g_enterprise,g_xcbq_m.xcbqdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct203_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axct203_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axct203_master_referesh USING g_xcbq_m.xcbqdocno INTO g_xcbq_m.xcbqdocno,g_xcbq_m.xcbqsite, 
       g_xcbq_m.xcbq002,g_xcbq_m.xcbq001,g_xcbq_m.xcbqcomp,g_xcbq_m.xcbqstus,g_xcbq_m.xcbqownid,g_xcbq_m.xcbqowndp, 
       g_xcbq_m.xcbqcrtid,g_xcbq_m.xcbqcrtdp,g_xcbq_m.xcbqcrtdt,g_xcbq_m.xcbqmodid,g_xcbq_m.xcbqmoddt, 
       g_xcbq_m.xcbqcnfid,g_xcbq_m.xcbqcnfdt,g_xcbq_m.xcbqsite_desc,g_xcbq_m.xcbqcomp_desc,g_xcbq_m.xcbqownid_desc, 
       g_xcbq_m.xcbqowndp_desc,g_xcbq_m.xcbqcrtid_desc,g_xcbq_m.xcbqcrtdp_desc,g_xcbq_m.xcbqmodid_desc, 
       g_xcbq_m.xcbqcnfid_desc
   
   #檢查是否允許此動作
   IF NOT axct203_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xcbq_m_mask_o.* =  g_xcbq_m.*
   CALL axct203_xcbq_t_mask()
   LET g_xcbq_m_mask_n.* =  g_xcbq_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL axct203_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_xcbqdocno_t = g_xcbq_m.xcbqdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_xcbq_m.xcbqmodid = g_user 
LET g_xcbq_m.xcbqmoddt = cl_get_current()
LET g_xcbq_m.xcbqmodid_desc = cl_get_username(g_xcbq_m.xcbqmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL axct203_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE xcbq_t SET (xcbqmodid,xcbqmoddt) = (g_xcbq_m.xcbqmodid,g_xcbq_m.xcbqmoddt)
          WHERE xcbqent = g_enterprise AND xcbqdocno = g_xcbqdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_xcbq_m.* = g_xcbq_m_t.*
            CALL axct203_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_xcbq_m.xcbqdocno != g_xcbq_m_t.xcbqdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE xcbr_t SET xcbrdocno = g_xcbq_m.xcbqdocno
 
          WHERE xcbrent = g_enterprise AND xcbrdocno = g_xcbq_m_t.xcbqdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xcbr_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcbr_t:",SQLERRMESSAGE 
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
   CALL axct203_set_act_visible()   
   CALL axct203_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xcbqent = " ||g_enterprise|| " AND",
                      " xcbqdocno = '", g_xcbq_m.xcbqdocno, "' "
 
   #填到對應位置
   CALL axct203_browser_fill("")
 
   CLOSE axct203_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axct203_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="axct203.input" >}
#+ 資料輸入
PRIVATE FUNCTION axct203_input(p_cmd)
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
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_flag                LIKE type_t.chr1       #檢核狀態
   DEFINE  l_errno               LIKE type_t.chr100     #錯誤訊息
   DEFINE  l_glav002             LIKE glav_t.glav002    #會計年度
   DEFINE  l_glav005             LIKE glav_t.glav005    #歸屬季別
   DEFINE  l_sdate_s             LIKE glav_t.glav004    #當季起始日
   DEFINE  l_sdate_e             LIKE glav_t.glav004    #當季截止日
   DEFINE  l_glav006             LIKE glav_t.glav006    #歸屬期別
   DEFINE  l_pdate_s             LIKE glav_t.glav004    #當期起始日
   DEFINE  l_pdate_e             LIKE glav_t.glav004    #當期截止日
   DEFINE  l_glav007             LIKE glav_t.glav007    #歸屬週別
   DEFINE  l_wdate_s             LIKE glav_t.glav004    #當週起始日
   DEFINE  l_wdate_e             LIKE glav_t.glav004    #當週截止日
   DEFINE  l_yy                  LIKE type_t.num5       #会计年度
   DEFINE  l_mm                  LIKE type_t.num5       #会计期别 
   DEFINE  l_se                  LIKE type_t.num5       #会计季度
   DEFINE  l_week                LIKE type_t.num5       #周
   DEFINE  l_sfca001             LIKE sfca_t.sfca001
   DEFINE  l_where               STRING                 #160204-00004#3 160224 By pomelo add
   DEFINE  l_sql                 STRING                 #170203-00001#2
   DEFINE  l_cot                 LIKE type_t.num10
   DEFINE  l_sql1                STRING   #160711-00040#35 add   
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
   DISPLAY BY NAME g_xcbq_m.xcbqdocno,g_xcbq_m.xcbqdocno_desc,g_xcbq_m.xcbqsite,g_xcbq_m.xcbqsite_desc, 
       g_xcbq_m.xcbq002,g_xcbq_m.xcbq001,g_xcbq_m.xcbqcomp,g_xcbq_m.xcbqcomp_desc,g_xcbq_m.xcbqstus, 
       g_xcbq_m.xcbqownid,g_xcbq_m.xcbqownid_desc,g_xcbq_m.xcbqowndp,g_xcbq_m.xcbqowndp_desc,g_xcbq_m.xcbqcrtid, 
       g_xcbq_m.xcbqcrtid_desc,g_xcbq_m.xcbqcrtdp,g_xcbq_m.xcbqcrtdp_desc,g_xcbq_m.xcbqcrtdt,g_xcbq_m.xcbqmodid, 
       g_xcbq_m.xcbqmodid_desc,g_xcbq_m.xcbqmoddt,g_xcbq_m.xcbqcnfid,g_xcbq_m.xcbqcnfid_desc,g_xcbq_m.xcbqcnfdt 
 
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT xcbrseq,xcbr002,xcbr003,xcbr004,xcbr001,xcbr099,xcbr100,xcbr101,xcbr102, 
       xcbr103,xcbr104,xcbr201,xcbr202,xcbr203,xcbr204,xcbr009 FROM xcbr_t WHERE xcbrent=? AND xcbrdocno=?  
       AND xcbrseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct203_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axct203_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axct203_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_xcbq_m.xcbqdocno,g_xcbq_m.xcbqsite,g_xcbq_m.xcbq002,g_xcbq_m.xcbq001,g_xcbq_m.xcbqcomp, 
       g_xcbq_m.xcbqstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axct203.input.head" >}
      #單頭段
      INPUT BY NAME g_xcbq_m.xcbqdocno,g_xcbq_m.xcbqsite,g_xcbq_m.xcbq002,g_xcbq_m.xcbq001,g_xcbq_m.xcbqcomp, 
          g_xcbq_m.xcbqstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN axct203_cl USING g_enterprise,g_xcbq_m.xcbqdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axct203_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axct203_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL axct203_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL axct203_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbqdocno
            
            #add-point:AFTER FIELD xcbqdocno name="input.a.xcbqdocno"

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xcbq_m.xcbqdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcbqdocno_t IS NULL OR g_xcbq_m.xcbqdocno != g_xcbqdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM xcbq_t WHERE "||"xcbqent = '" ||g_enterprise|| "' AND "||"xcbqdocno = '"||g_xcbq_m.xcbqdocno ||"'",'std-00004',0) THEN 
                    LET g_xcbq_m.xcbqdocno = g_xcbqdocno_t
                    NEXT FIELD CURRENT
                  END IF
                  CALL axct203_glaa_get()
                  CALL s_aooi200_fin_chk_docno(g_glaald,g_glaa024,g_glaa003,g_xcbq_m.xcbqdocno,g_xcbq_m.xcbq001,'axct203') RETURNING l_success
                  IF l_success = FALSE THEN 
                     LET g_xcbq_m.xcbqdocno = g_xcbq_m_t.xcbqdocno
                     NEXT FIELD xcbqdocno
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqdocno
            #add-point:BEFORE FIELD xcbqdocno name="input.b.xcbqdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbqdocno
            #add-point:ON CHANGE xcbqdocno name="input.g.xcbqdocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbqsite
            
            #add-point:AFTER FIELD xcbqsite name="input.a.xcbqsite"
            IF NOT cl_null(g_xcbq_m.xcbqsite) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcbq_m_t.xcbqsite IS NULL OR g_xcbq_m.xcbqsite != g_xcbq_m_t.xcbqsite )) THEN 
                  #應用 a19 樣板自動產生(Version:2)
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xcbq_m.xcbqsite               
                  #160318-00025#47  2016/04/29  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#47  2016/04/29  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                   
                  IF cl_chk_exist("v_ooef001_13") THEN   #161019-00017#11 2016/10/20 By 08734
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME
                     #170313-00009#1  2017/03/14 By 08734 add(S)
                     LET l_cot=0
                     
                     IF g_xcbq_m.xcbqcomp IS NOT NULL THEN
                        SELECT COUNT(1) INTO l_cot FROM ooef_t 
                           WHERE ooef001 = g_xcbq_m.xcbqsite AND ooefent =g_enterprise AND ooef201='Y' AND ooefstus='Y' 
                              AND ooef001 IN(SELECT ooef001 FROM ooef_t WHERE ooefent = g_enterprise    AND ooefstus ='Y' AND ooef017 =g_xcbq_m.xcbqcomp)
                  
                        IF l_cot=0 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'afm-00191'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_xcbq_m.xcbqsite=g_xcbq_m_t.xcbqsite
                           NEXT FIELD CURRENT
                        END IF
                     END IF 
                     #170313-00009#1  2017/03/14 By 08734 add(E)                     
                  ELSE
                     #檢查失敗時後續處理
                     LET g_xcbq_m.xcbqsite=g_xcbq_m_t.xcbqsite
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcbq_m.xcbqsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcbq_m.xcbqsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcbq_m.xcbqsite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqsite
            #add-point:BEFORE FIELD xcbqsite name="input.b.xcbqsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbqsite
            #add-point:ON CHANGE xcbqsite name="input.g.xcbqsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbq002
            #add-point:BEFORE FIELD xcbq002 name="input.b.xcbq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbq002
            
            #add-point:AFTER FIELD xcbq002 name="input.a.xcbq002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbq002
            #add-point:ON CHANGE xcbq002 name="input.g.xcbq002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbq001
            #add-point:BEFORE FIELD xcbq001 name="input.b.xcbq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbq001
            
            #add-point:AFTER FIELD xcbq001 name="input.a.xcbq001"
            IF NOT cl_null(g_xcbq_m.xcbq001) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcbq_m_t.xcbq001 IS NULL OR g_xcbq_m.xcbq001 != g_xcbq_m_t.xcbq001 )) THEN  
                  CALL cl_get_para(g_enterprise,g_xcbq_m.xcbqcomp,'S-FIN-6010') RETURNING g_yy 
                  CALL cl_get_para(g_enterprise,g_xcbq_m.xcbqcomp,'S-FIN-6011') RETURNING g_mm             
                  CALL s_fin_date_get_yspw(g_glaa003,g_glaald,g_xcbq_m.xcbq001) RETURNING l_success,l_yy,l_se,l_mm,l_week
                  IF l_yy*12+l_mm < g_yy*12+g_mm THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axc-00122'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xcbq_m.xcbq001 = g_xcbq_m_t.xcbq001
                     NEXT FIELD xcbq001
                  END IF
               END IF   
            END IF         
           
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbq001
            #add-point:ON CHANGE xcbq001 name="input.g.xcbq001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbqcomp
            
            #add-point:AFTER FIELD xcbqcomp name="input.a.xcbqcomp"
            IF NOT cl_null(g_xcbq_m.xcbqcomp) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcbq_m_t.xcbqcomp IS NULL OR g_xcbq_m.xcbqcomp != g_xcbq_m_t.xcbqcomp )) THEN 
                  #應用 a19 樣板自動產生(Version:2)
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xcbq_m.xcbqcomp   
                  #170203-00001#2-S
                  #增加法人過濾條件
                  IF NOT cl_null(g_wc_cs_comp) THEN
                     LET g_chkparam.where = " ooef001 IN ",g_wc_cs_comp
                  END IF                
                  #170203-00001#2-E                    
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooef001_1") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                     #161019-00017#11 add(S)
                     IF NOT cl_null(g_xcbq_m.xcbqsite) THEN
                        LET l_cnt = 0
                        SELECT COUNT(1) INTO l_cnt
                          FROM ooef_t
                         WHERE ooef001 = g_xcbq_m.xcbqsite
                           AND ooef017 = g_xcbq_m.xcbqcomp
                           AND ooefstus = 'Y'
                           AND ooefent = g_enterprise
                        IF l_cnt = 0 THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = '' 
                           LET g_errparam.code   = 'aoo-00716'
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_xcbq_m.xcbqcomp = g_xcbq_m_t.xcbqcomp
                          # CALL axct203_ref_show()
                           NEXT FIELD CURRENT
                        END IF                        
                     END IF
                     #161019-00017#11 add(E)
                     
                     CALL axct203_glaa_get()
                  ELSE
                     #檢查失敗時後續處理
                     LET g_xcbq_m.xcbqcomp=g_xcbq_m_t.xcbqcomp
                     NEXT FIELD CURRENT
                  END IF
                  #170203-00001#2-S
#                  IF g_wc_cs_comp.getIndexOf(g_xcbq_m.xcbqcomp,1) > 0 THEN                  
#                  ELSE
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = g_xcbq_m.xcbqcomp
#                     LET g_errparam.code   = "axc-00826" 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     LET g_xcbq_m.xcbqcomp=g_xcbq_m_t.xcbqcomp
#                     NEXT FIELD xcbqcomp                
#                  END IF                   
                  #170203-00001#2-E                  
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcbq_m.xcbqcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcbq_m.xcbqcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcbq_m.xcbqcomp_desc

            LET g_xcbq_m_t.xcbqcomp = g_xcbq_m.xcbqcomp #170203-00001#2 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqcomp
            #add-point:BEFORE FIELD xcbqcomp name="input.b.xcbqcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbqcomp
            #add-point:ON CHANGE xcbqcomp name="input.g.xcbqcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqstus
            #add-point:BEFORE FIELD xcbqstus name="input.b.xcbqstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbqstus
            
            #add-point:AFTER FIELD xcbqstus name="input.a.xcbqstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbqstus
            #add-point:ON CHANGE xcbqstus name="input.g.xcbqstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xcbqdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbqdocno
            #add-point:ON ACTION controlp INFIELD xcbqdocno name="input.c.xcbqdocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbq_m.xcbqdocno             #給予default值
            LET g_qryparam.where = " ooba001 = '",g_ooef004,"' AND oobx003 = 'axct203'" 
            #160711-00040#35 add(S)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",l_sql1
            END IF
            #160711-00040#35 add(E)
            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooba002()                                #呼叫開窗

            LET g_xcbq_m.xcbqdocno = g_qryparam.return1              

            DISPLAY g_xcbq_m.xcbqdocno TO xcbqdocno              #

            NEXT FIELD xcbqdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcbqsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbqsite
            #add-point:ON ACTION controlp INFIELD xcbqsite name="input.c.xcbqsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbq_m.xcbqsite             #給予default值
            LET g_qryparam.default2 = "" #g_xcbq_m.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #
            IF NOT cl_null(g_xcbq_m.xcbqcomp) THEN
                LET g_qryparam.where = " ooef001 IN(SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                       "    AND ooefstus ='Y' AND ooef017 ='",g_xcbq_m.xcbqcomp ,"')"
             END IF

            CALL q_ooef001_1()                                #呼叫開窗   #161019-00017#11 2016/10/20 By 08734

            LET g_xcbq_m.xcbqsite = g_qryparam.return1              
            #LET g_xcbq_m.ooefl003 = g_qryparam.return2 
            DISPLAY g_xcbq_m.xcbqsite TO xcbqsite              #
            #DISPLAY g_xcbq_m.ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD xcbqsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcbq002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbq002
            #add-point:ON ACTION controlp INFIELD xcbq002 name="input.c.xcbq002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcbq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbq001
            #add-point:ON ACTION controlp INFIELD xcbq001 name="input.c.xcbq001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcbqcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbqcomp
            #add-point:ON ACTION controlp INFIELD xcbqcomp name="input.c.xcbqcomp"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbq_m.xcbqcomp             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            IF NOT cl_null(g_xcbq_m.xcbqsite) THEN
               LET g_qryparam.where = " ooef001 IN(SELECT ooef017 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                      "    AND ooefstus ='Y' AND ooef001 ='",g_xcbq_m.xcbqsite,"')"
            END IF
            #170203-00001#2-S
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF                
            #170203-00001#2-E
            CALL q_ooef001_2()                                #呼叫開窗

            LET g_xcbq_m.xcbqcomp = g_qryparam.return1              

            DISPLAY g_xcbq_m.xcbqcomp TO xcbqcomp              #

            NEXT FIELD xcbqcomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcbqstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbqstus
            #add-point:ON ACTION controlp INFIELD xcbqstus name="input.c.xcbqstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xcbq_m.xcbqdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_fin_gen_docno(g_glaald,g_glaa024,g_glaa003,g_xcbq_m.xcbqdocno,g_xcbq_m.xcbq001,g_prog)
               RETURNING l_success,g_xcbq_m.xcbqdocno
               IF l_success  = 0  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_xcbq_m.xcbqdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD xcbqdocno
               END IF
               #end add-point
               
               INSERT INTO xcbq_t (xcbqent,xcbqdocno,xcbqsite,xcbq002,xcbq001,xcbqcomp,xcbqstus,xcbqownid, 
                   xcbqowndp,xcbqcrtid,xcbqcrtdp,xcbqcrtdt,xcbqmodid,xcbqmoddt,xcbqcnfid,xcbqcnfdt)
               VALUES (g_enterprise,g_xcbq_m.xcbqdocno,g_xcbq_m.xcbqsite,g_xcbq_m.xcbq002,g_xcbq_m.xcbq001, 
                   g_xcbq_m.xcbqcomp,g_xcbq_m.xcbqstus,g_xcbq_m.xcbqownid,g_xcbq_m.xcbqowndp,g_xcbq_m.xcbqcrtid, 
                   g_xcbq_m.xcbqcrtdp,g_xcbq_m.xcbqcrtdt,g_xcbq_m.xcbqmodid,g_xcbq_m.xcbqmoddt,g_xcbq_m.xcbqcnfid, 
                   g_xcbq_m.xcbqcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_xcbq_m:",SQLERRMESSAGE 
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
                  CALL axct203_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL axct203_b_fill()
                  CALL axct203_b_fill2('0')
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
               CALL axct203_xcbq_t_mask_restore('restore_mask_o')
               
               UPDATE xcbq_t SET (xcbqdocno,xcbqsite,xcbq002,xcbq001,xcbqcomp,xcbqstus,xcbqownid,xcbqowndp, 
                   xcbqcrtid,xcbqcrtdp,xcbqcrtdt,xcbqmodid,xcbqmoddt,xcbqcnfid,xcbqcnfdt) = (g_xcbq_m.xcbqdocno, 
                   g_xcbq_m.xcbqsite,g_xcbq_m.xcbq002,g_xcbq_m.xcbq001,g_xcbq_m.xcbqcomp,g_xcbq_m.xcbqstus, 
                   g_xcbq_m.xcbqownid,g_xcbq_m.xcbqowndp,g_xcbq_m.xcbqcrtid,g_xcbq_m.xcbqcrtdp,g_xcbq_m.xcbqcrtdt, 
                   g_xcbq_m.xcbqmodid,g_xcbq_m.xcbqmoddt,g_xcbq_m.xcbqcnfid,g_xcbq_m.xcbqcnfdt)
                WHERE xcbqent = g_enterprise AND xcbqdocno = g_xcbqdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xcbq_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL axct203_xcbq_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_xcbq_m_t)
               LET g_log2 = util.JSON.stringify(g_xcbq_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_xcbqdocno_t = g_xcbq_m.xcbqdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="axct203.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcbr_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcbr_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axct203_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_xcbr_d.getLength()
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
            OPEN axct203_cl USING g_enterprise,g_xcbq_m.xcbqdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axct203_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axct203_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xcbr_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xcbr_d[l_ac].xcbrseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcbr_d_t.* = g_xcbr_d[l_ac].*  #BACKUP
               LET g_xcbr_d_o.* = g_xcbr_d[l_ac].*  #BACKUP
               CALL axct203_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL axct203_set_no_entry_b(l_cmd)
               IF NOT axct203_lock_b("xcbr_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct203_bcl INTO g_xcbr_d[l_ac].xcbrseq,g_xcbr_d[l_ac].xcbr002,g_xcbr_d[l_ac].xcbr003, 
                      g_xcbr_d[l_ac].xcbr004,g_xcbr_d[l_ac].xcbr001,g_xcbr_d[l_ac].xcbr099,g_xcbr_d[l_ac].xcbr100, 
                      g_xcbr_d[l_ac].xcbr101,g_xcbr_d[l_ac].xcbr102,g_xcbr_d[l_ac].xcbr103,g_xcbr_d[l_ac].xcbr104, 
                      g_xcbr_d[l_ac].xcbr201,g_xcbr_d[l_ac].xcbr202,g_xcbr_d[l_ac].xcbr203,g_xcbr_d[l_ac].xcbr204, 
                      g_xcbr_d[l_ac].xcbr009
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xcbr_d_t.xcbrseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcbr_d_mask_o[l_ac].* =  g_xcbr_d[l_ac].*
                  CALL axct203_xcbr_t_mask()
                  LET g_xcbr_d_mask_n[l_ac].* =  g_xcbr_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axct203_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL axct203_glaa_get()
            #獲取當前年度期別的最后一天
            CALL s_get_accdate(g_glaa003,g_xcbq_m.xcbq001,'','')
            RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
            
            IF g_xcbq_m.xcbq001 = l_pdate_e THEN 
               CALL cl_set_comp_required('xcbr101',TRUE)
            ELSE
               CALL cl_set_comp_required('xcbr101',FALSE)
            END IF
            
            CALL axct203_get_sfaa011()  #150728-00009#1 add
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
            INITIALIZE g_xcbr_d[l_ac].* TO NULL 
            INITIALIZE g_xcbr_d_t.* TO NULL 
            INITIALIZE g_xcbr_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_xcbr_d[l_ac].xcbr099 = "0"
      LET g_xcbr_d[l_ac].xcbr100 = "0"
      LET g_xcbr_d[l_ac].xcbr101 = "0"
      LET g_xcbr_d[l_ac].xcbr103 = "0"
      LET g_xcbr_d[l_ac].xcbr104 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_xcbr_d_t.* = g_xcbr_d[l_ac].*     #新輸入資料
            LET g_xcbr_d_o.* = g_xcbr_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct203_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL axct203_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcbr_d[li_reproduce_target].* = g_xcbr_d[li_reproduce].*
 
               LET g_xcbr_d[li_reproduce_target].xcbrseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"

            IF g_xcbr_d[l_ac].xcbrseq IS NULL OR g_xcbr_d[l_ac].xcbrseq = 0 THEN
               SELECT MAX(xcbrseq)+1 INTO g_xcbr_d[l_ac].xcbrseq
                 FROM xcbr_t
                 WHERE xcbrent = g_enterprise
                     AND xcbrdocno = g_xcbq_m.xcbqdocno
            END IF
            IF g_xcbr_d[l_ac].xcbrseq IS NULL THEN
               LET g_xcbr_d[l_ac].xcbrseq = 1
            END IF   
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
            SELECT COUNT(1) INTO l_count FROM xcbr_t 
             WHERE xcbrent = g_enterprise AND xcbrdocno = g_xcbq_m.xcbqdocno
 
               AND xcbrseq = g_xcbr_d[l_ac].xcbrseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcbq_m.xcbqdocno
               LET gs_keys[2] = g_xcbr_d[g_detail_idx].xcbrseq
               CALL axct203_insert_b('xcbr_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_xcbr_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcbr_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axct203_b_fill()
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
               LET gs_keys[01] = g_xcbq_m.xcbqdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_xcbr_d_t.xcbrseq
 
            
               #刪除同層單身
               IF NOT axct203_delete_b('xcbr_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axct203_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axct203_key_delete_b(gs_keys,'xcbr_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axct203_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE axct203_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_xcbr_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xcbr_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbrseq
            #add-point:BEFORE FIELD xcbrseq name="input.b.page1.xcbrseq"
            IF g_xcbr_d[l_ac].xcbrseq IS NULL OR g_xcbr_d[l_ac].xcbrseq = 0 THEN
               SELECT MAX(xcbrseq)+1 INTO g_xcbr_d[l_ac].xcbrseq
                 FROM xcbr_t
                 WHERE xcbrent = g_enterprise
                     AND xcbrdocno = g_xcbq_m.xcbqdocno
            END IF
            IF g_xcbr_d[l_ac].xcbrseq IS NULL THEN
               LET g_xcbr_d[l_ac].xcbrseq = 1
            END IF 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbrseq
            
            #add-point:AFTER FIELD xcbrseq name="input.a.page1.xcbrseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_xcbq_m.xcbqdocno IS NOT NULL AND g_xcbr_d[g_detail_idx].xcbrseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcbq_m.xcbqdocno != g_xcbqdocno_t OR g_xcbr_d[g_detail_idx].xcbrseq != g_xcbr_d_t.xcbrseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM xcbr_t WHERE "||"xcbrent = '" ||g_enterprise|| "' AND "||"xcbrdocno = '"||g_xcbq_m.xcbqdocno ||"' AND "|| "xcbrseq = '"||g_xcbr_d[g_detail_idx].xcbrseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbrseq
            #add-point:ON CHANGE xcbrseq name="input.g.page1.xcbrseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr002
            
            #add-point:AFTER FIELD xcbr002 name="input.a.page1.xcbr002"
            IF NOT cl_null(g_xcbr_d[l_ac].xcbr002) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcbr_d_t.xcbr002 IS NULL OR g_xcbr_d[l_ac].xcbr002 != g_xcbr_d_t.xcbr002 )) THEN   #160824-00007#220 20161129 mark by beckxie
               IF (g_xcbr_d[l_ac].xcbr002 != g_xcbr_d_o.xcbr002 ) OR cl_null(g_xcbr_d_o.xcbr002) THEN   #160824-00007#220 20161129 add by beckxie
               
                  #160204-00004#3 160224 By pomelo add(S)
                  IF NOT s_aooi210_check_doc(g_xcbq_m.xcbqsite,'', g_xcbr_d[l_ac].xcbr002 , g_xcbq_m.xcbqdocno ,'4','') THEN
                     #檢查失敗時後續處理
                     #160824-00007#220 20161129 mark by beckxie---S
                     #LET g_xcbr_d[l_ac].xcbr002=g_xcbr_d_t.xcbr002
                     #LET g_xcbr_d[l_ac].sffb029=g_xcbr_d_t.sffb029
                     #LET g_xcbr_d[l_ac].xcbr003=g_xcbr_d_t.xcbr003
                     #LET g_xcbr_d[l_ac].xcbr004=g_xcbr_d_t.xcbr004
                     #LET g_xcbr_d[l_ac].xcbr099=g_xcbr_d_t.xcbr099
                     #LET g_xcbr_d[l_ac].xcbr100=g_xcbr_d_t.xcbr100
                     #160824-00007#220 20161129 mark by beckxie---E
                     #160824-00007#220 20161129 add by beckxie---S
                     LET g_xcbr_d[l_ac].xcbr002=g_xcbr_d_o.xcbr002
                     LET g_xcbr_d[l_ac].sffb029=g_xcbr_d_o.sffb029
                     LET g_xcbr_d[l_ac].sffb029_desc=g_xcbr_d_o.sffb029_desc
                     LET g_xcbr_d[l_ac].sffb029_desc_2=g_xcbr_d_o.sffb029_desc_2
                     LET g_xcbr_d[l_ac].xcbr003=g_xcbr_d_o.xcbr003
                     LET g_xcbr_d[l_ac].xcbr004=g_xcbr_d_o.xcbr004
                     LET g_xcbr_d[l_ac].xcbr099=g_xcbr_d_o.xcbr099
                     LET g_xcbr_d[l_ac].xcbr100=g_xcbr_d_o.xcbr100
                     #160824-00007#220 20161129 add by beckxie---E
                     NEXT FIELD CURRENT
                  END IF
                  #160204-00004#3 160224 By pomelo add(E)
                  
                  #應用 a19 樣板自動產生(Version:2)
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xcbq_m.xcbqsite
                  LET g_chkparam.arg2 = g_xcbr_d[l_ac].xcbr002
                  LET g_chkparam.arg3 = g_xcbq_m.xcbq001   #150907 Sarah add
                  
#                  LET g_chkparam.where="sfaastus='F'"     #150907 Sarah mark
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_sfaadocno_1") THEN
                     #檢查成功時後續處理    
                     CALL axct203_get_sfaa010(g_xcbr_d[l_ac].xcbr002) RETURNING g_xcbr_d[l_ac].sffb029,g_sfaa016
                     CALL s_desc_get_item_desc(g_xcbr_d[l_ac].sffb029)
                        RETURNING g_xcbr_d[l_ac].sffb029_desc,g_xcbr_d[l_ac].sffb029_desc_2
                    IF cl_null(g_sfaa016) THEN
                       CALL axct203_get_sfcb(g_xcbr_d[l_ac].xcbr002,g_xcbr_d[l_ac].xcbr003,g_xcbr_d[l_ac].xcbr004) 
                           RETURNING g_xcbr_d[l_ac].xcbr099,g_xcbr_d[l_ac].xcbr100
                     END IF
                     CALL axct203_get_runcard(g_xcbr_d[l_ac].xcbr002) RETURNING l_sfca001
                     DISPLAY BY NAME g_xcbr_d[l_ac].sffb029_desc,g_xcbr_d[l_ac].sffb029_desc_2,g_xcbr_d[l_ac].xcbr099,g_xcbr_d[l_ac].xcbr100 
                  ELSE
                     #檢查失敗時後續處理
                     #160824-00007#220 20161129 mark by beckxie---S
                     #LET g_xcbr_d[l_ac].xcbr002=g_xcbr_d_t.xcbr002
                     #LET g_xcbr_d[l_ac].sffb029=g_xcbr_d_t.sffb029
                     #LET g_xcbr_d[l_ac].xcbr003=g_xcbr_d_t.xcbr003
                     #LET g_xcbr_d[l_ac].xcbr004=g_xcbr_d_t.xcbr004
                     #LET g_xcbr_d[l_ac].xcbr099=g_xcbr_d_t.xcbr099
                     #LET g_xcbr_d[l_ac].xcbr100=g_xcbr_d_t.xcbr100
                     #160824-00007#220 20161129 mark by beckxie---E
                     #160824-00007#220 20161129 add by beckxie---S
                     LET g_xcbr_d[l_ac].xcbr002=g_xcbr_d_o.xcbr002
                     LET g_xcbr_d[l_ac].sffb029=g_xcbr_d_o.sffb029
                     LET g_xcbr_d[l_ac].sffb029_desc=g_xcbr_d_o.sffb029_desc
                     LET g_xcbr_d[l_ac].sffb029_desc_2=g_xcbr_d_o.sffb029_desc_2
                     LET g_xcbr_d[l_ac].xcbr003=g_xcbr_d_o.xcbr003
                     LET g_xcbr_d[l_ac].xcbr004=g_xcbr_d_o.xcbr004
                     LET g_xcbr_d[l_ac].xcbr099=g_xcbr_d_o.xcbr099
                     LET g_xcbr_d[l_ac].xcbr100=g_xcbr_d_o.xcbr100
                     #160824-00007#220 20161129 add by beckxie---E
                     NEXT FIELD CURRENT
                  END IF
            
               END IF              
            END IF 

            LET g_xcbr_d_o.* = g_xcbr_d[l_ac].* #160824-00007#220 20161129 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr002
            #add-point:BEFORE FIELD xcbr002 name="input.b.page1.xcbr002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbr002
            #add-point:ON CHANGE xcbr002 name="input.g.page1.xcbr002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr003
            
            #add-point:AFTER FIELD xcbr003 name="input.a.page1.xcbr003"
            IF NOT cl_null(g_xcbr_d[l_ac].xcbr003) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcbr_d_t.xcbr003 IS NULL OR g_xcbr_d[l_ac].xcbr003 != g_xcbr_d_t.xcbr003 )) THEN   #160824-00007#220 20161129 mark by beckxie
               IF (g_xcbr_d[l_ac].xcbr003 != g_xcbr_d_o.xcbr003 ) OR cl_null(g_xcbr_d_o.xcbr003) THEN   #160824-00007#220 20161129 add by beckxie
                  ### 檢查作業編號是否存在### start ###
                  INITIALIZE g_chkparam.* TO NULL 
                  LET g_chkparam.where = " 1=1"
                  LET g_chkparam.arg1 = g_xcbq_m.xcbqsite
                  LET g_chkparam.arg2 = g_xcbr_d[l_ac].xcbr002
                  LET g_chkparam.arg3 = l_sfca001
                  LET g_chkparam.arg4 =g_xcbr_d[l_ac].xcbr003
                  IF cl_chk_exist("v_sfcb003") THEN
                     IF NOT cl_null( g_xcbr_d[l_ac].xcbr004 ) AND NOT cl_null( g_xcbr_d[l_ac].xcbr002 ) THEN 
                        CALL axct203_get_sfcb(g_xcbr_d[l_ac].xcbr002,g_xcbr_d[l_ac].xcbr003,g_xcbr_d[l_ac].xcbr004)
                           RETURNING g_xcbr_d[l_ac].xcbr099,g_xcbr_d[l_ac].xcbr100
                        DISPLAY BY NAME g_xcbr_d[l_ac].xcbr099,g_xcbr_d[l_ac].xcbr100
                     END IF
                  ELSE
                     #LET g_xcbr_d[l_ac].xcbr003=g_xcbr_d_t.xcbr003   #160824-00007#220 20161129 mark by beckxie
                     #160824-00007#220 20161129 add by beckxie---S
                     LET g_xcbr_d[l_ac].xcbr003=g_xcbr_d_o.xcbr003   
                     LET g_xcbr_d[l_ac].xcbr003_desc=g_xcbr_d_o.xcbr003_desc
                     LET g_xcbr_d[l_ac].xcbr099=g_xcbr_d_o.xcbr099   
                     LET g_xcbr_d[l_ac].xcbr100=g_xcbr_d_o.xcbr100   
                     #160824-00007#220 20161129 add by beckxie---E
                     NEXT FIELD CURRENT                     
                  END IF
               END IF
            END IF   
            ### 檢查作業編號是否存在### end ###

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcbr_d[l_ac].xcbr003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcbr_d[l_ac].xcbr003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcbr_d[l_ac].xcbr003_desc
             
            LET g_xcbr_d_o.* = g_xcbr_d[l_ac].* #160824-00007#220 20161129 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr003
            #add-point:BEFORE FIELD xcbr003 name="input.b.page1.xcbr003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbr003
            #add-point:ON CHANGE xcbr003 name="input.g.page1.xcbr003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr004
            #add-point:BEFORE FIELD xcbr004 name="input.b.page1.xcbr004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr004
            
            #add-point:AFTER FIELD xcbr004 name="input.a.page1.xcbr004"
            IF NOT cl_null(g_xcbr_d[l_ac].xcbr004) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcbr_d_t.xcbr004 IS NULL OR g_xcbr_d[l_ac].xcbr004 != g_xcbr_d_t.xcbr004 )) THEN   #160824-00007#220 20161129 mark by beckxie
               IF (cl_null(g_xcbr_d_o.xcbr004) OR g_xcbr_d[l_ac].xcbr004 != g_xcbr_d_o.xcbr004 ) THEN   #160824-00007#220 20161129 add by beckxie
                  SELECT COUNT(sfcbdocno) INTO l_count FROM sfcb_t WHERE sfcbent=g_enterprise 
                                                                   AND sfcb003=g_xcbr_d[l_ac].xcbr003 
                                                                   AND  sfcb004=g_xcbr_d[l_ac].xcbr004 
                                                                   AND sfcbdocno=g_xcbr_d[l_ac].xcbr002
                  IF l_count>0 THEN
                     IF NOT cl_null( g_xcbr_d[l_ac].xcbr003 ) AND NOT cl_null( g_xcbr_d[l_ac].xcbr002 ) THEN
                        CALL axct203_get_sfcb(g_xcbr_d[l_ac].xcbr002,g_xcbr_d[l_ac].xcbr003,g_xcbr_d[l_ac].xcbr004)
                           RETURNING g_xcbr_d[l_ac].xcbr099,g_xcbr_d[l_ac].xcbr100
                        DISPLAY BY NAME g_xcbr_d[l_ac].xcbr099,g_xcbr_d[l_ac].xcbr100
                     END IF
                  ELSE
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "asf-00674" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     #LET g_xcbr_d[l_ac].xcbr004=g_xcbr_d_t.xcbr004   #160824-00007#220 20161129 mark by beckxie
                     LET g_xcbr_d[l_ac].xcbr004=g_xcbr_d_o.xcbr004   #160824-00007#220 20161129 add by beckxie
                     LET g_xcbr_d[l_ac].xcbr099=g_xcbr_d_o.xcbr099   #160824-00007#220 20161129 add by beckxie
                     LET g_xcbr_d[l_ac].xcbr100=g_xcbr_d_o.xcbr100   #160824-00007#220 20161129 add by beckxie
                     NEXT FIELD CURRENT 
                  END IF
               END IF      
            END IF               
            LET g_xcbr_d_o.* = g_xcbr_d[l_ac].*   #160824-00007#220 20161129 add by beckxie
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbr004
            #add-point:ON CHANGE xcbr004 name="input.g.page1.xcbr004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr001
            
            #add-point:AFTER FIELD xcbr001 name="input.a.page1.xcbr001"
            IF NOT cl_null(g_xcbr_d[l_ac].xcbr001) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcbr_d_t.xcbr001 IS NULL OR g_xcbr_d[l_ac].xcbr001 != g_xcbr_d_t.xcbr001 )) THEN   
                  #應用 a19 樣板自動產生(Version:2)
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xcbr_d[l_ac].xcbr001
                  LET g_chkparam.arg2 = g_xcbq_m.xcbq001
                  #160318-00025#47  2016/04/29  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#47  2016/04/29  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooeg001_4") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_xcbr_d[l_ac].xcbr001=g_xcbr_d_t.xcbr001
                     NEXT FIELD CURRENT
                  END IF
            
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcbr_d[l_ac].xcbr001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcbr_d[l_ac].xcbr001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcbr_d[l_ac].xcbr001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr001
            #add-point:BEFORE FIELD xcbr001 name="input.b.page1.xcbr001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbr001
            #add-point:ON CHANGE xcbr001 name="input.g.page1.xcbr001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr099
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbr_d[l_ac].xcbr099,">=0","0","","","azz-00079",1) THEN
               NEXT FIELD xcbr099
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbr099 name="input.a.page1.xcbr099"
            IF NOT cl_null(g_xcbr_d[l_ac].xcbr099) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcbr_d_t.xcbr099 IS NULL OR g_xcbr_d[l_ac].xcbr099 != g_xcbr_d_t.xcbr099 )) THEN   #160824-00007#220 20161129 mark by beckxie
               IF cl_null(g_xcbr_d_o.xcbr099) OR g_xcbr_d[l_ac].xcbr099 != g_xcbr_d_o.xcbr099 THEN   #160824-00007#220 20161129 add by beckxie
                  LET g_xcbr_d[l_ac].xcbr104=g_xcbr_d[l_ac].xcbr099+g_xcbr_d[l_ac].xcbr100+g_xcbr_d[l_ac].xcbr103
               END IF
            END IF 

            LET g_xcbr_d_o.* = g_xcbr_d[l_ac].*   #160824-00007#220 20161129 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr099
            #add-point:BEFORE FIELD xcbr099 name="input.b.page1.xcbr099"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbr099
            #add-point:ON CHANGE xcbr099 name="input.g.page1.xcbr099"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr100
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbr_d[l_ac].xcbr100,">=0","0","","","azz-00079",1) THEN
               NEXT FIELD xcbr100
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbr100 name="input.a.page1.xcbr100"
            IF NOT cl_null(g_xcbr_d[l_ac].xcbr100) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcbr_d_t.xcbr100 IS NULL OR g_xcbr_d[l_ac].xcbr100 != g_xcbr_d_t.xcbr100 )) THEN   #160824-00007#220 20161129 mark by beckxie
               IF cl_null(g_xcbr_d_o.xcbr100) OR g_xcbr_d[l_ac].xcbr100 != g_xcbr_d_o.xcbr100 THEN   #160824-00007#220 20161129 add by beckxie
                  LET g_xcbr_d[l_ac].xcbr104=g_xcbr_d[l_ac].xcbr099+g_xcbr_d[l_ac].xcbr100+g_xcbr_d[l_ac].xcbr103               
               END IF
            END IF 

            LET g_xcbr_d_o.* = g_xcbr_d[l_ac].*   #160824-00007#220 20161129 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr100
            #add-point:BEFORE FIELD xcbr100 name="input.b.page1.xcbr100"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbr100
            #add-point:ON CHANGE xcbr100 name="input.g.page1.xcbr100"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr101
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbr_d[l_ac].xcbr101,">=0","0","","","azz-00079",1) THEN
               NEXT FIELD xcbr101
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbr101 name="input.a.page1.xcbr101"
            IF NOT cl_null(g_xcbr_d[l_ac].xcbr101) THEN 
               LET g_xcbr_d[l_ac].xcbr103 = g_xcbr_d[l_ac].xcbr101 * g_xcbr_d[l_ac].xcbr102/100
               IF g_xcbq_m.xcbq001 = l_pdate_e AND g_xcbr_d[l_ac].xcbr101 <> 0 THEN 
                  CALL cl_set_comp_required('xcbr102',TRUE)
               ELSE
                  CALL cl_set_comp_required('xcbr102',FALSE)
               END IF
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr101
            #add-point:BEFORE FIELD xcbr101 name="input.b.page1.xcbr101"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbr101
            #add-point:ON CHANGE xcbr101 name="input.g.page1.xcbr101"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr102
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbr_d[l_ac].xcbr102,">=0","0","","","azz-00079",1) THEN
               NEXT FIELD xcbr102
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbr102 name="input.a.page1.xcbr102"
            IF NOT cl_null(g_xcbr_d[l_ac].xcbr102) THEN 
               LET g_xcbr_d[l_ac].xcbr103 = g_xcbr_d[l_ac].xcbr101 * g_xcbr_d[l_ac].xcbr102/100
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr102
            #add-point:BEFORE FIELD xcbr102 name="input.b.page1.xcbr102"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbr102
            #add-point:ON CHANGE xcbr102 name="input.g.page1.xcbr102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr103
            #add-point:BEFORE FIELD xcbr103 name="input.b.page1.xcbr103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr103
            
            #add-point:AFTER FIELD xcbr103 name="input.a.page1.xcbr103"
            IF NOT cl_null(g_xcbr_d[l_ac].xcbr103) THEN
               LET g_xcbr_d[l_ac].xcbr104=g_xcbr_d[l_ac].xcbr099+g_xcbr_d[l_ac].xcbr100+g_xcbr_d[l_ac].xcbr103
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbr103
            #add-point:ON CHANGE xcbr103 name="input.g.page1.xcbr103"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr104
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbr_d[l_ac].xcbr104,">=0","0","","","azz-00079",1) THEN
               NEXT FIELD xcbr104
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbr104 name="input.a.page1.xcbr104"
            IF NOT cl_null(g_xcbr_d[l_ac].xcbr104) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr104
            #add-point:BEFORE FIELD xcbr104 name="input.b.page1.xcbr104"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbr104
            #add-point:ON CHANGE xcbr104 name="input.g.page1.xcbr104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr201
            #add-point:BEFORE FIELD xcbr201 name="input.b.page1.xcbr201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr201
            
            #add-point:AFTER FIELD xcbr201 name="input.a.page1.xcbr201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbr201
            #add-point:ON CHANGE xcbr201 name="input.g.page1.xcbr201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr202
            #add-point:BEFORE FIELD xcbr202 name="input.b.page1.xcbr202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr202
            
            #add-point:AFTER FIELD xcbr202 name="input.a.page1.xcbr202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbr202
            #add-point:ON CHANGE xcbr202 name="input.g.page1.xcbr202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr203
            #add-point:BEFORE FIELD xcbr203 name="input.b.page1.xcbr203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr203
            
            #add-point:AFTER FIELD xcbr203 name="input.a.page1.xcbr203"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbr203
            #add-point:ON CHANGE xcbr203 name="input.g.page1.xcbr203"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr204
            #add-point:BEFORE FIELD xcbr204 name="input.b.page1.xcbr204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr204
            
            #add-point:AFTER FIELD xcbr204 name="input.a.page1.xcbr204"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbr204
            #add-point:ON CHANGE xcbr204 name="input.g.page1.xcbr204"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbr009
            #add-point:BEFORE FIELD xcbr009 name="input.b.page1.xcbr009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbr009
            
            #add-point:AFTER FIELD xcbr009 name="input.a.page1.xcbr009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbr009
            #add-point:ON CHANGE xcbr009 name="input.g.page1.xcbr009"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xcbrseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbrseq
            #add-point:ON ACTION controlp INFIELD xcbrseq name="input.c.page1.xcbrseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbr002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr002
            #add-point:ON ACTION controlp INFIELD xcbr002 name="input.c.page1.xcbr002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbr_d[l_ac].xcbr002             #給予default值
            #LET g_qryparam.where="sfcastus='F'"
            #給予arg
            #LET g_qryparam.arg1 = g_xcbq_m.xcbqsite
            #160204-00004#3 160224 By pomelo add(S)
            IF NOT cl_null(g_xcbq_m.xcbqdocno) THEN
               CALL s_aooi210_get_check_sql(g_xcbq_m.xcbqsite,'', g_xcbq_m.xcbqdocno ,'4','','sfaadocno')
                  RETURNING l_success,l_where
               IF l_success THEN
                  LET g_qryparam.where = l_where
                  CALL q_sfcadocno()
               END IF
            END IF
            #160204-00004#3 160224 By pomelo add(E)

            #CALL q_sfcadocno()                                #呼叫開窗 #160204-00004#3 160224 By pomelo mark

            LET g_xcbr_d[l_ac].xcbr002 = g_qryparam.return1              

            DISPLAY g_xcbr_d[l_ac].xcbr002 TO xcbr002              #

            NEXT FIELD xcbr002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbr003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr003
            #add-point:ON ACTION controlp INFIELD xcbr003 name="input.c.page1.xcbr003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xcbr_d[l_ac].xcbr003             #給予default值
            #給予arg
            LET g_qryparam.where = "sfcbdocno='",g_xcbr_d[l_ac].xcbr002,"'" #s
            CALL q_sfcb003_3()                                #呼叫開窗
            LET g_xcbr_d[l_ac].xcbr003 = g_qryparam.return1              
            #LET g_xcbr_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_xcbr_d[l_ac].xcbr003 TO xcbr003              #
            #DISPLAY g_xcbr_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD xcbr003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbr004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr004
            #add-point:ON ACTION controlp INFIELD xcbr004 name="input.c.page1.xcbr004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbr001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr001
            #add-point:ON ACTION controlp INFIELD xcbr001 name="input.c.page1.xcbr001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbr_d[l_ac].xcbr001             #給予default值

            #給予arg
            
            LET g_qryparam.where = " ooeg003 = '3'"
            LET g_qryparam.arg1 = g_xcbq_m.xcbq001

            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_xcbr_d[l_ac].xcbr001 = g_qryparam.return1              

            DISPLAY g_xcbr_d[l_ac].xcbr001 TO xcbr001              #

            NEXT FIELD xcbr001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbr099
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr099
            #add-point:ON ACTION controlp INFIELD xcbr099 name="input.c.page1.xcbr099"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbr100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr100
            #add-point:ON ACTION controlp INFIELD xcbr100 name="input.c.page1.xcbr100"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbr101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr101
            #add-point:ON ACTION controlp INFIELD xcbr101 name="input.c.page1.xcbr101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbr102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr102
            #add-point:ON ACTION controlp INFIELD xcbr102 name="input.c.page1.xcbr102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbr103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr103
            #add-point:ON ACTION controlp INFIELD xcbr103 name="input.c.page1.xcbr103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbr104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr104
            #add-point:ON ACTION controlp INFIELD xcbr104 name="input.c.page1.xcbr104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbr201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr201
            #add-point:ON ACTION controlp INFIELD xcbr201 name="input.c.page1.xcbr201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbr202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr202
            #add-point:ON ACTION controlp INFIELD xcbr202 name="input.c.page1.xcbr202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbr203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr203
            #add-point:ON ACTION controlp INFIELD xcbr203 name="input.c.page1.xcbr203"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbr204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr204
            #add-point:ON ACTION controlp INFIELD xcbr204 name="input.c.page1.xcbr204"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbr009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbr009
            #add-point:ON ACTION controlp INFIELD xcbr009 name="input.c.page1.xcbr009"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcbr_d[l_ac].* = g_xcbr_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axct203_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xcbr_d[l_ac].xcbrseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xcbr_d[l_ac].* = g_xcbr_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL axct203_xcbr_t_mask_restore('restore_mask_o')
      
               UPDATE xcbr_t SET (xcbrdocno,xcbrseq,xcbr002,xcbr003,xcbr004,xcbr001,xcbr099,xcbr100, 
                   xcbr101,xcbr102,xcbr103,xcbr104,xcbr201,xcbr202,xcbr203,xcbr204,xcbr009) = (g_xcbq_m.xcbqdocno, 
                   g_xcbr_d[l_ac].xcbrseq,g_xcbr_d[l_ac].xcbr002,g_xcbr_d[l_ac].xcbr003,g_xcbr_d[l_ac].xcbr004, 
                   g_xcbr_d[l_ac].xcbr001,g_xcbr_d[l_ac].xcbr099,g_xcbr_d[l_ac].xcbr100,g_xcbr_d[l_ac].xcbr101, 
                   g_xcbr_d[l_ac].xcbr102,g_xcbr_d[l_ac].xcbr103,g_xcbr_d[l_ac].xcbr104,g_xcbr_d[l_ac].xcbr201, 
                   g_xcbr_d[l_ac].xcbr202,g_xcbr_d[l_ac].xcbr203,g_xcbr_d[l_ac].xcbr204,g_xcbr_d[l_ac].xcbr009) 
 
                WHERE xcbrent = g_enterprise AND xcbrdocno = g_xcbq_m.xcbqdocno 
 
                  AND xcbrseq = g_xcbr_d_t.xcbrseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xcbr_d[l_ac].* = g_xcbr_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcbr_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xcbr_d[l_ac].* = g_xcbr_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcbr_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcbq_m.xcbqdocno
               LET gs_keys_bak[1] = g_xcbqdocno_t
               LET gs_keys[2] = g_xcbr_d[g_detail_idx].xcbrseq
               LET gs_keys_bak[2] = g_xcbr_d_t.xcbrseq
               CALL axct203_update_b('xcbr_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL axct203_xcbr_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_xcbr_d[g_detail_idx].xcbrseq = g_xcbr_d_t.xcbrseq 
 
                  ) THEN
                  LET gs_keys[01] = g_xcbq_m.xcbqdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xcbr_d_t.xcbrseq
 
                  CALL axct203_key_update_b(gs_keys,'xcbr_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xcbq_m),util.JSON.stringify(g_xcbr_d_t)
               LET g_log2 = util.JSON.stringify(g_xcbq_m),util.JSON.stringify(g_xcbr_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL axct203_unlock_b("xcbr_t","'1'")
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
               LET g_xcbr_d[li_reproduce_target].* = g_xcbr_d[li_reproduce].*
 
               LET g_xcbr_d[li_reproduce_target].xcbrseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcbr_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcbr_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="axct203.input.other" >}
      
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
            NEXT FIELD xcbqdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcbrseq
 
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
 
{<section id="axct203.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axct203_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL axct203_b_fill() #單身填充
      CALL axct203_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axct203_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_xcbq_m_mask_o.* =  g_xcbq_m.*
   CALL axct203_xcbq_t_mask()
   LET g_xcbq_m_mask_n.* =  g_xcbq_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xcbq_m.xcbqdocno,g_xcbq_m.xcbqdocno_desc,g_xcbq_m.xcbqsite,g_xcbq_m.xcbqsite_desc, 
       g_xcbq_m.xcbq002,g_xcbq_m.xcbq001,g_xcbq_m.xcbqcomp,g_xcbq_m.xcbqcomp_desc,g_xcbq_m.xcbqstus, 
       g_xcbq_m.xcbqownid,g_xcbq_m.xcbqownid_desc,g_xcbq_m.xcbqowndp,g_xcbq_m.xcbqowndp_desc,g_xcbq_m.xcbqcrtid, 
       g_xcbq_m.xcbqcrtid_desc,g_xcbq_m.xcbqcrtdp,g_xcbq_m.xcbqcrtdp_desc,g_xcbq_m.xcbqcrtdt,g_xcbq_m.xcbqmodid, 
       g_xcbq_m.xcbqmodid_desc,g_xcbq_m.xcbqmoddt,g_xcbq_m.xcbqcnfid,g_xcbq_m.xcbqcnfid_desc,g_xcbq_m.xcbqcnfdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xcbq_m.xcbqstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xcbr_d.getLength()
      #add-point:show段單身reference name="show.body.reference"

      CALL axct203_get_sfaa010(g_xcbr_d[l_ac].xcbr002) RETURNING g_xcbr_d[l_ac].sffb029,g_sfaa016
      CALL s_desc_get_item_desc(g_xcbr_d[l_ac].sffb029)
         RETURNING g_xcbr_d[l_ac].sffb029_desc,g_xcbr_d[l_ac].sffb029_desc_2      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL axct203_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axct203.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION axct203_detail_show()
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
 
{<section id="axct203.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axct203_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE xcbq_t.xcbqdocno 
   DEFINE l_oldno     LIKE xcbq_t.xcbqdocno 
 
   DEFINE l_master    RECORD LIKE xcbq_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xcbr_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_xcbq_m.xcbqdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_xcbqdocno_t = g_xcbq_m.xcbqdocno
 
    
   LET g_xcbq_m.xcbqdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xcbq_m.xcbqownid = g_user
      LET g_xcbq_m.xcbqowndp = g_dept
      LET g_xcbq_m.xcbqcrtid = g_user
      LET g_xcbq_m.xcbqcrtdp = g_dept 
      LET g_xcbq_m.xcbqcrtdt = cl_get_current()
      LET g_xcbq_m.xcbqmodid = g_user
      LET g_xcbq_m.xcbqmoddt = cl_get_current()
      LET g_xcbq_m.xcbqstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xcbq_m.xcbqstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_xcbq_m.xcbqdocno_desc = ''
   DISPLAY BY NAME g_xcbq_m.xcbqdocno_desc
 
   
   CALL axct203_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_xcbq_m.* TO NULL
      INITIALIZE g_xcbr_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL axct203_show()
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
   CALL axct203_set_act_visible()   
   CALL axct203_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xcbqdocno_t = g_xcbq_m.xcbqdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcbqent = " ||g_enterprise|| " AND",
                      " xcbqdocno = '", g_xcbq_m.xcbqdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axct203_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL axct203_idx_chk()
   
   LET g_data_owner = g_xcbq_m.xcbqownid      
   LET g_data_dept  = g_xcbq_m.xcbqowndp
   
   #功能已完成,通報訊息中心
   CALL axct203_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="axct203.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axct203_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcbr_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axct203_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcbr_t
    WHERE xcbrent = g_enterprise AND xcbrdocno = g_xcbqdocno_t
 
    INTO TEMP axct203_detail
 
   #將key修正為調整後   
   UPDATE axct203_detail 
      #更新key欄位
      SET xcbrdocno = g_xcbq_m.xcbqdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO xcbr_t SELECT * FROM axct203_detail
   
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
   DROP TABLE axct203_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcbqdocno_t = g_xcbq_m.xcbqdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="axct203.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axct203_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_success        LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_xcbq_m.xcbqdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN axct203_cl USING g_enterprise,g_xcbq_m.xcbqdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct203_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axct203_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axct203_master_referesh USING g_xcbq_m.xcbqdocno INTO g_xcbq_m.xcbqdocno,g_xcbq_m.xcbqsite, 
       g_xcbq_m.xcbq002,g_xcbq_m.xcbq001,g_xcbq_m.xcbqcomp,g_xcbq_m.xcbqstus,g_xcbq_m.xcbqownid,g_xcbq_m.xcbqowndp, 
       g_xcbq_m.xcbqcrtid,g_xcbq_m.xcbqcrtdp,g_xcbq_m.xcbqcrtdt,g_xcbq_m.xcbqmodid,g_xcbq_m.xcbqmoddt, 
       g_xcbq_m.xcbqcnfid,g_xcbq_m.xcbqcnfdt,g_xcbq_m.xcbqsite_desc,g_xcbq_m.xcbqcomp_desc,g_xcbq_m.xcbqownid_desc, 
       g_xcbq_m.xcbqowndp_desc,g_xcbq_m.xcbqcrtid_desc,g_xcbq_m.xcbqcrtdp_desc,g_xcbq_m.xcbqmodid_desc, 
       g_xcbq_m.xcbqcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT axct203_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xcbq_m_mask_o.* =  g_xcbq_m.*
   CALL axct203_xcbq_t_mask()
   LET g_xcbq_m_mask_n.* =  g_xcbq_m.*
   
   CALL axct203_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axct203_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_xcbqdocno_t = g_xcbq_m.xcbqdocno
 
 
      DELETE FROM xcbq_t
       WHERE xcbqent = g_enterprise AND xcbqdocno = g_xcbq_m.xcbqdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xcbq_m.xcbqdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      CALL axct203_glaa_get()
      CALL s_aooi200_fin_del_docno(g_glaald,g_xcbq_m.xcbqdocno,g_xcbq_m.xcbq001) RETURNING l_success
      IF l_success  = 0  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = g_xcbq_m.xcbqdocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF 
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xcbr_t
       WHERE xcbrent = g_enterprise AND xcbrdocno = g_xcbq_m.xcbqdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcbr_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_xcbq_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE axct203_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_xcbr_d.clear() 
 
     
      CALL axct203_ui_browser_refresh()  
      #CALL axct203_ui_headershow()  
      #CALL axct203_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL axct203_browser_fill("")
         CALL axct203_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE axct203_cl
 
   #功能已完成,通報訊息中心
   CALL axct203_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axct203.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axct203_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
 
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_xcbr_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF axct203_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xcbrseq,xcbr002,xcbr003,xcbr004,xcbr001,xcbr099,xcbr100,xcbr101, 
             xcbr102,xcbr103,xcbr104,xcbr201,xcbr202,xcbr203,xcbr204,xcbr009 ,t2.oocql004 ,t3.ooefl003 FROM xcbr_t", 
                
                     " INNER JOIN xcbq_t ON xcbqent = " ||g_enterprise|| " AND xcbqdocno = xcbrdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='221' AND t2.oocql002=xcbr003 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=xcbr001 AND t3.ooefl002='"||g_dlang||"' ",
 
                     " WHERE xcbrent=? AND xcbrdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xcbr_t.xcbrseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axct203_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axct203_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xcbq_m.xcbqdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xcbq_m.xcbqdocno INTO g_xcbr_d[l_ac].xcbrseq,g_xcbr_d[l_ac].xcbr002, 
          g_xcbr_d[l_ac].xcbr003,g_xcbr_d[l_ac].xcbr004,g_xcbr_d[l_ac].xcbr001,g_xcbr_d[l_ac].xcbr099, 
          g_xcbr_d[l_ac].xcbr100,g_xcbr_d[l_ac].xcbr101,g_xcbr_d[l_ac].xcbr102,g_xcbr_d[l_ac].xcbr103, 
          g_xcbr_d[l_ac].xcbr104,g_xcbr_d[l_ac].xcbr201,g_xcbr_d[l_ac].xcbr202,g_xcbr_d[l_ac].xcbr203, 
          g_xcbr_d[l_ac].xcbr204,g_xcbr_d[l_ac].xcbr009,g_xcbr_d[l_ac].xcbr003_desc,g_xcbr_d[l_ac].xcbr001_desc  
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
          CALL axct203_get_sfaa011()   #150728-00009#1 add
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
   
   CALL g_xcbr_d.deleteElement(g_xcbr_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axct203_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcbr_d.getLength()
      LET g_xcbr_d_mask_o[l_ac].* =  g_xcbr_d[l_ac].*
      CALL axct203_xcbr_t_mask()
      LET g_xcbr_d_mask_n[l_ac].* =  g_xcbr_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="axct203.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axct203_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM xcbr_t
       WHERE xcbrent = g_enterprise AND
         xcbrdocno = ps_keys_bak[1] AND xcbrseq = ps_keys_bak[2]
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
         CALL g_xcbr_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axct203.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axct203_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO xcbr_t
                  (xcbrent,
                   xcbrdocno,
                   xcbrseq
                   ,xcbr002,xcbr003,xcbr004,xcbr001,xcbr099,xcbr100,xcbr101,xcbr102,xcbr103,xcbr104,xcbr201,xcbr202,xcbr203,xcbr204,xcbr009) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_xcbr_d[g_detail_idx].xcbr002,g_xcbr_d[g_detail_idx].xcbr003,g_xcbr_d[g_detail_idx].xcbr004, 
                       g_xcbr_d[g_detail_idx].xcbr001,g_xcbr_d[g_detail_idx].xcbr099,g_xcbr_d[g_detail_idx].xcbr100, 
                       g_xcbr_d[g_detail_idx].xcbr101,g_xcbr_d[g_detail_idx].xcbr102,g_xcbr_d[g_detail_idx].xcbr103, 
                       g_xcbr_d[g_detail_idx].xcbr104,g_xcbr_d[g_detail_idx].xcbr201,g_xcbr_d[g_detail_idx].xcbr202, 
                       g_xcbr_d[g_detail_idx].xcbr203,g_xcbr_d[g_detail_idx].xcbr204,g_xcbr_d[g_detail_idx].xcbr009) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcbr_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xcbr_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="axct203.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axct203_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xcbr_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL axct203_xcbr_t_mask_restore('restore_mask_o')
               
      UPDATE xcbr_t 
         SET (xcbrdocno,
              xcbrseq
              ,xcbr002,xcbr003,xcbr004,xcbr001,xcbr099,xcbr100,xcbr101,xcbr102,xcbr103,xcbr104,xcbr201,xcbr202,xcbr203,xcbr204,xcbr009) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_xcbr_d[g_detail_idx].xcbr002,g_xcbr_d[g_detail_idx].xcbr003,g_xcbr_d[g_detail_idx].xcbr004, 
                  g_xcbr_d[g_detail_idx].xcbr001,g_xcbr_d[g_detail_idx].xcbr099,g_xcbr_d[g_detail_idx].xcbr100, 
                  g_xcbr_d[g_detail_idx].xcbr101,g_xcbr_d[g_detail_idx].xcbr102,g_xcbr_d[g_detail_idx].xcbr103, 
                  g_xcbr_d[g_detail_idx].xcbr104,g_xcbr_d[g_detail_idx].xcbr201,g_xcbr_d[g_detail_idx].xcbr202, 
                  g_xcbr_d[g_detail_idx].xcbr203,g_xcbr_d[g_detail_idx].xcbr204,g_xcbr_d[g_detail_idx].xcbr009)  
 
         WHERE xcbrent = g_enterprise AND xcbrdocno = ps_keys_bak[1] AND xcbrseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcbr_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcbr_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axct203_xcbr_t_mask_restore('restore_mask_n')
               
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
 
{<section id="axct203.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION axct203_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="axct203.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axct203_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axct203.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axct203_lock_b(ps_table,ps_page)
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
   #CALL axct203_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "xcbr_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN axct203_bcl USING g_enterprise,
                                       g_xcbq_m.xcbqdocno,g_xcbr_d[g_detail_idx].xcbrseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axct203_bcl:",SQLERRMESSAGE 
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
 
{<section id="axct203.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axct203_unlock_b(ps_table,ps_page)
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
      CLOSE axct203_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axct203.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axct203_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("xcbqdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcbqdocno",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("xcbqdocno,xcbqcomp,xcbqsite,xcbq001",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct203.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axct203_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_success  LIKE type_t.num5     #151130-00015#2 
   DEFINE l_slip     LIKE type_t.chr10  #151130-00015#2
   DEFINE l_dfin0033  LIKE type_t.chr80 #151130-00015#2
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcbqdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("xcbqdocno,xcbqcomp,xcbqsite,xcbq001",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("xcbqdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #151130-00015#2 -begin -add by XZG 20151218
      IF NOT cl_null(g_xcbq_m.xcbqdocno) THEN  
            #获取单别
            CALL s_aooi200_fin_get_slip(g_xcbq_m.xcbqdocno) RETURNING l_success,l_slip
            #是否可改日期
            CALL s_fin_get_doc_para(g_glaald,g_xcbq_m.xcbqcomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
            IF l_dfin0033 = "N"  THEN 
               CALL cl_set_comp_entry("xcbq001",FALSE)
            ELSE 
               CALL cl_set_comp_entry("xcbq001",TRUE)
            END IF          
         END IF 
      #151130-00015#2  -end    
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct203.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axct203_set_entry_b(p_cmd)
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
 
{<section id="axct203.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axct203_set_no_entry_b(p_cmd)
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
 
{<section id="axct203.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axct203_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete", TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axct203.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axct203_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_xcbq_m.xcbqstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axct203.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axct203_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axct203.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axct203_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axct203.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axct203_default_search()
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
      LET ls_wc = ls_wc, " xcbqdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "xcbq_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xcbr_t" 
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
 
{<section id="axct203.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION axct203_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_xcbq_m.xcbqdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN axct203_cl USING g_enterprise,g_xcbq_m.xcbqdocno
   IF STATUS THEN
      CLOSE axct203_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct203_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE axct203_master_referesh USING g_xcbq_m.xcbqdocno INTO g_xcbq_m.xcbqdocno,g_xcbq_m.xcbqsite, 
       g_xcbq_m.xcbq002,g_xcbq_m.xcbq001,g_xcbq_m.xcbqcomp,g_xcbq_m.xcbqstus,g_xcbq_m.xcbqownid,g_xcbq_m.xcbqowndp, 
       g_xcbq_m.xcbqcrtid,g_xcbq_m.xcbqcrtdp,g_xcbq_m.xcbqcrtdt,g_xcbq_m.xcbqmodid,g_xcbq_m.xcbqmoddt, 
       g_xcbq_m.xcbqcnfid,g_xcbq_m.xcbqcnfdt,g_xcbq_m.xcbqsite_desc,g_xcbq_m.xcbqcomp_desc,g_xcbq_m.xcbqownid_desc, 
       g_xcbq_m.xcbqowndp_desc,g_xcbq_m.xcbqcrtid_desc,g_xcbq_m.xcbqcrtdp_desc,g_xcbq_m.xcbqmodid_desc, 
       g_xcbq_m.xcbqcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT axct203_action_chk() THEN
      CLOSE axct203_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xcbq_m.xcbqdocno,g_xcbq_m.xcbqdocno_desc,g_xcbq_m.xcbqsite,g_xcbq_m.xcbqsite_desc, 
       g_xcbq_m.xcbq002,g_xcbq_m.xcbq001,g_xcbq_m.xcbqcomp,g_xcbq_m.xcbqcomp_desc,g_xcbq_m.xcbqstus, 
       g_xcbq_m.xcbqownid,g_xcbq_m.xcbqownid_desc,g_xcbq_m.xcbqowndp,g_xcbq_m.xcbqowndp_desc,g_xcbq_m.xcbqcrtid, 
       g_xcbq_m.xcbqcrtid_desc,g_xcbq_m.xcbqcrtdp,g_xcbq_m.xcbqcrtdp_desc,g_xcbq_m.xcbqcrtdt,g_xcbq_m.xcbqmodid, 
       g_xcbq_m.xcbqmodid_desc,g_xcbq_m.xcbqmoddt,g_xcbq_m.xcbqcnfid,g_xcbq_m.xcbqcnfid_desc,g_xcbq_m.xcbqcnfdt 
 
 
   CASE g_xcbq_m.xcbqstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_xcbq_m.xcbqstus
            
            WHEN "N"
               HIDE OPTION "open"
            WHEN "Y"
               HIDE OPTION "valid"
            WHEN "X"
               HIDE OPTION "void"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      IF g_xcbq_m.xcbqstus = 'X' THEN
         CALL s_transaction_end('N','0')  #160816-00068#3 add
         RETURN
      END IF
         
      HIDE OPTION "signing"
      HIDE OPTION "withdraw"
      HIDE OPTION "closed"
      HIDE OPTION "hold"
      CASE g_xcbq_m.xcbqstus
            WHEN "N"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "posted"
               HIDE OPTION "unposted"
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
               IF cl_bpm_chk() THEN
                  SHOW OPTION "signing"
                  HIDE OPTION "confirmed"
               END IF
            WHEN "X"
               HIDE OPTION "invalid"
               HIDE OPTION "confirmed"
               HIDE OPTION "posted"
               HIDE OPTION "unposted"               
               HIDE OPTION "hold"
            WHEN "Y"
               HIDE OPTION "confirmed"
               HIDE OPTION "invalid"
               HIDE OPTION "hold"
               HIDE OPTION "unposted"
               HIDE OPTION "valid"
               HIDE OPTION "void"
            WHEN "S"
               HIDE OPTION "posted"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "invalid" 
               HIDE OPTION "confirmed"
            WHEN "R"
            #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
               HIDE OPTION "confirmed"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "hold" 
            WHEN "D"
            #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
               HIDE OPTION "confirmed"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "hold" 
            WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
                SHOW OPTION "withdraw"  
                HIDE OPTION "unconfirmed"
                HIDE OPTION "invalid"
                HIDE OPTION "confirmed"
                HIDE OPTION "hold"
            
            WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
                SHOW OPTION "confirmed" 
                HIDE OPTION "unconfirmed"
                HIDE OPTION "invalid"
                HIDE OPTION "hold"                          
      END CASE
      #end add-point
      
      
	  
      ON ACTION open
         IF cl_auth_chk_act("open") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.open"
            IF NOT cl_ask_confirm('aim-00110') THEN
               CALL s_transaction_end('N','0')  #160816-00068#3 add
               RETURN
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION valid
         IF cl_auth_chk_act("valid") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.valid"
            IF g_xcbq_m.xcbqstus = 'X' THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00133'
               LET g_errparam.extend = g_xcbq_m.xcbqstus
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')  #160816-00068#3 add
               RETURN 
            END IF
            IF NOT cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_end('N','0')  #160816-00068#3 add
               RETURN
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION void
         IF cl_auth_chk_act("void") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.void"
            IF g_xcbq_m.xcbqstus = 'Y' THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00134'
               LET g_errparam.extend = g_xcbq_m.xcbqstus
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')  #160816-00068#3 add
               RETURN 
            END IF
            IF NOT cl_ask_confirm('aim-00109') THEN
               CALL s_transaction_end('N','0')  #160816-00068#3 add
               RETURN
            END IF
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
 
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      ) OR 
      g_xcbq_m.xcbqstus = lc_state OR cl_null(lc_state) THEN
      CLOSE axct203_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_xcbq_m.xcbqmodid = g_user
   LET g_xcbq_m.xcbqmoddt = cl_get_current()
   LET g_xcbq_m.xcbqstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE xcbq_t 
      SET (xcbqstus,xcbqmodid,xcbqmoddt) 
        = (g_xcbq_m.xcbqstus,g_xcbq_m.xcbqmodid,g_xcbq_m.xcbqmoddt)     
    WHERE xcbqent = g_enterprise AND xcbqdocno = g_xcbq_m.xcbqdocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE axct203_master_referesh USING g_xcbq_m.xcbqdocno INTO g_xcbq_m.xcbqdocno,g_xcbq_m.xcbqsite, 
          g_xcbq_m.xcbq002,g_xcbq_m.xcbq001,g_xcbq_m.xcbqcomp,g_xcbq_m.xcbqstus,g_xcbq_m.xcbqownid,g_xcbq_m.xcbqowndp, 
          g_xcbq_m.xcbqcrtid,g_xcbq_m.xcbqcrtdp,g_xcbq_m.xcbqcrtdt,g_xcbq_m.xcbqmodid,g_xcbq_m.xcbqmoddt, 
          g_xcbq_m.xcbqcnfid,g_xcbq_m.xcbqcnfdt,g_xcbq_m.xcbqsite_desc,g_xcbq_m.xcbqcomp_desc,g_xcbq_m.xcbqownid_desc, 
          g_xcbq_m.xcbqowndp_desc,g_xcbq_m.xcbqcrtid_desc,g_xcbq_m.xcbqcrtdp_desc,g_xcbq_m.xcbqmodid_desc, 
          g_xcbq_m.xcbqcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_xcbq_m.xcbqdocno,g_xcbq_m.xcbqdocno_desc,g_xcbq_m.xcbqsite,g_xcbq_m.xcbqsite_desc, 
          g_xcbq_m.xcbq002,g_xcbq_m.xcbq001,g_xcbq_m.xcbqcomp,g_xcbq_m.xcbqcomp_desc,g_xcbq_m.xcbqstus, 
          g_xcbq_m.xcbqownid,g_xcbq_m.xcbqownid_desc,g_xcbq_m.xcbqowndp,g_xcbq_m.xcbqowndp_desc,g_xcbq_m.xcbqcrtid, 
          g_xcbq_m.xcbqcrtid_desc,g_xcbq_m.xcbqcrtdp,g_xcbq_m.xcbqcrtdp_desc,g_xcbq_m.xcbqcrtdt,g_xcbq_m.xcbqmodid, 
          g_xcbq_m.xcbqmodid_desc,g_xcbq_m.xcbqmoddt,g_xcbq_m.xcbqcnfid,g_xcbq_m.xcbqcnfid_desc,g_xcbq_m.xcbqcnfdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
 
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE axct203_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axct203_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axct203.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axct203_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xcbr_d.getLength() THEN
         LET g_detail_idx = g_xcbr_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xcbr_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcbr_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axct203.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axct203_b_fill2(pi_idx)
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
   
   CALL axct203_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="axct203.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axct203_fill_chk(ps_idx)
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
 
{<section id="axct203.status_show" >}
PRIVATE FUNCTION axct203_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct203.mask_functions" >}
&include "erp/axc/axct203_mask.4gl"
 
{</section>}
 
{<section id="axct203.signature" >}
   
 
{</section>}
 
{<section id="axct203.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axct203_set_pk_array()
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
   LET g_pk_array[1].values = g_xcbq_m.xcbqdocno
   LET g_pk_array[1].column = 'xcbqdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axct203.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="axct203.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axct203_msgcentre_notify(lc_state)
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
   CALL axct203_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xcbq_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axct203.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION axct203_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#42 add-S
   SELECT xcbqstus  INTO g_xcbq_m.xcbqstus
     FROM xcbq_t
    WHERE xcbqent = g_enterprise
      AND xcbqdocno = g_xcbq_m.xcbqdocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_xcbq_m.xcbqstus
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
        LET g_errparam.extend = g_xcbq_m.xcbqdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL axct203_set_act_visible()
        CALL axct203_set_act_no_visible()
        CALL axct203_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#42 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axct203.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 參考欄位帶值
# Memo...........:
# Usage..........: CALL axct203_ref_show()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/2/4 By liuym
# Modify.........:
################################################################################
PRIVATE FUNCTION axct203_ref_show()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcbq_m.xcbqsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcbq_m.xcbqsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcbq_m.xcbqsite_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcbq_m.xcbqcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcbq_m.xcbqcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcbq_m.xcbqcomp_desc
END FUNCTION

################################################################################
# Descriptions...: 获取制程工单良品、报废数量
# Memo...........:
# Usage..........: axct203_get_sfcb(p_sfcadocno,p_sfcb003,p_sfcb004)
#                  RETURNING r_sfcb028,r_sfcb036
# Input parameter: p_sfcadocno 工单号
#                : p_sfcb003   作业编号
#                : p_sfcb004   作业序
# Return code....: r_sfcb033   良品数量
#                : r_sfcb036   报废数量
# Date & Author..: 2015/2/4  By liuym
# Modify.........:
################################################################################
PRIVATE FUNCTION axct203_get_sfcb(p_sfcadocno,p_sfcb003,p_sfcb004)
DEFINE p_sfcadocno      LIKE sfca_t.sfcadocno
DEFINE p_sfcb003        LIKE sfcb_t.sfcb003
DEFINE p_sfcb004        LIKE sfcb_t.sfcb004
DEFINE r_sfcb033        LIKE sfcb_t.sfcb033
DEFINE r_sfcb036        LIKE sfcb_t.sfcb036

   #如果制程编号不为空，根据工单号+作业编号+作业序获取数量；否则根据工单号获取
   IF NOT cl_null(g_sfaa016) THEN  
      IF NOT cl_null(p_sfcb003) AND NOT cl_null(p_sfcb004) THEN
         SELECT sfcb033,sfcb036 INTO r_sfcb033,r_sfcb036 FROM sfcb_t 
            WHERE sfcbent=g_enterprise AND sfcbdocno=p_sfcadocno AND sfcb003=p_sfcb003  AND sfcb004=p_sfcb004
      END IF
   ELSE 
      SELECT sfcb033,sfcb036 INTO r_sfcb033,r_sfcb036 FROM sfcb_t 
          WHERE sfcbent=g_enterprise AND sfcbdocno=p_sfcadocno
   END IF

                              
   IF cl_null(r_sfcb033) THEN LET r_sfcb033=0 END IF
   IF cl_null(r_sfcb036) THEN LET r_sfcb036=0 END IF
   RETURN r_sfcb033,r_sfcb036


END FUNCTION

################################################################################
# Descriptions...: 获取主帐套+单据别参照表号
# Memo...........:
# Usage..........: CALL axct203_glaa_get()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct203_glaa_get()
  
      SELECT glaa003,glaald,glaa024 INTO g_glaa003,g_glaald,g_glaa024
        FROM glaa_t
        WHERE glaaent = g_enterprise
         AND glaacomp = g_xcbq_m.xcbqcomp
         AND glaa014= 'Y'  
         INITIALIZE g_ref_fields TO NULL  
      LET g_ref_fields[1] = g_xcbq_m.xcbqcomp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooef004 FROM ooef_t WHERE ooefent='"||g_enterprise||"' AND ooef001=? ","") RETURNING g_rtn_fields
      LET g_ooef004 = '', g_rtn_fields[1] , ''   
END FUNCTION

################################################################################
# Descriptions...: 料号获取
# Memo...........:
# Usage..........: CALL axct203_get_sfaa010(p_xcbr002)
#                  RETURNING r_sfaa010
# Input parameter: p_xcbr002   工单号
#                
# Return code....: r_sfaa010   料号
#                
# Date & Author..: 2015/2/11 By liuym
# Modify.........:
################################################################################
PRIVATE FUNCTION axct203_get_sfaa010(p_xcbr002)
DEFINE   p_xcbr002         LIKE xcbr_t.xcbr002
DEFINE   r_sfaa010         LIKE sfaa_t.sfaa010
DEFINE   r_sfaa016         LIKE sfaa_t.sfaa016  #制程编号
DEFINE l_success         LIKE type_t.num5   
   SELECT sfaa010,sfaa016,sfaa011 INTO r_sfaa010,r_sfaa016,g_xcbr_d[l_ac].sfaa011
      FROM sfaa_t
      WHERE sfaaent = g_enterprise
      AND sfaadocno = p_xcbr002
     
   CALL s_feature_description(g_xcbr_d[l_ac].sffb029,g_xcbr_d[l_ac].sfaa011) RETURNING l_success,g_xcbr_d[l_ac].sfaa011_desc1   #150728-00009#1 add
   DISPLAY g_xcbr_d[l_ac].sfaa011 TO s_detail1[l_ac].sfaa011               #150728-00009#1 add
   DISPLAY g_xcbr_d[l_ac].sfaa011_desc1 TO s_detail1[l_ac].sfaa011_desc1   #150728-00009#1 add
     
   RETURN r_sfaa010,r_sfaa016
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
PRIVATE FUNCTION axct203_get_runcard(p_sfcadocno)
DEFINE   p_sfcadocno       LIKE sfca_t.sfcadocno
DEFINE   r_sfca001         LIKE sfca_t.sfca001

   SELECT sfca001 INTO r_sfca001 FROM sfca_t WHERE sfcaent=g_enterprise AND sfcadocno=p_sfcadocno
   RETURN r_sfca001
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
PRIVATE FUNCTION axct203_get_sfaa011()
#150728-00009#1 add
DEFINE   p_xcbr002         LIKE xcbr_t.xcbr002
DEFINE   l_sfaa010         LIKE sfaa_t.sfaa010
DEFINE l_success         LIKE type_t.num5   

 SELECT sfaa010,sfaa011 INTO l_sfaa010,g_xcbr_d[l_ac].sfaa011
      FROM sfaa_t
      WHERE sfaaent = g_enterprise
      AND sfaadocno = g_xcbr_d[l_ac].xcbr002
     
   CALL s_feature_description(l_sfaa010,g_xcbr_d[l_ac].sfaa011) RETURNING l_success,g_xcbr_d[l_ac].sfaa011_desc1
   DISPLAY g_xcbr_d[l_ac].sfaa011 TO s_detail1[l_ac].sfaa011 
   DISPLAY g_xcbr_d[l_ac].sfaa011_desc1 TO s_detail1[l_ac].sfaa011_desc1
     
END FUNCTION

################################################################################
# Descriptions...: 更新单身数据
# Date & Author..: 2016/10/28 By 02295
# Modify.........: #160929-00005#2
################################################################################
PRIVATE FUNCTION axct203_count_qty()
DEFINE l_sql STRING
DEFINE l_success     LIKE type_t.num5
DEFINE l_yy          LIKE type_t.num5       #会计年度
DEFINE l_mm          LIKE type_t.num5       #会计期别 
DEFINE l_se          LIKE type_t.num5       #会计季度
DEFINE l_week        LIKE type_t.num5       #周
DEFINE l_xcbr001     LIKE xcbr_t.xcbr001   
DEFINE l_xcbr101     LIKE xcbr_t.xcbr101
DEFINE l_xcbr102     LIKE xcbr_t.xcbr102
DEFINE l_xcbr103     LIKE xcbr_t.xcbr103

   CALL axct203_glaa_get()
   CALL s_fin_date_get_yspw(g_glaa003,g_glaald,g_xcbq_m.xcbq001) RETURNING l_success,l_yy,l_se,l_mm,l_week
   LET l_sql = "SELECT DISTINCT xcbr001",
               "  FROM xcbr_t ",
               "  WHERE xcbrent='",g_enterprise,"'",
               "    AND xcbrdocno='",g_xcbq_m.xcbqdocno,"'"
   PREPARE axct203_count_pr FROM l_sql
   DECLARE axct203_count_cs CURSOR FOR axct203_count_pr
   FOREACH axct203_count_cs INTO l_xcbr001
      
      SELECT xcbg004 INTO l_xcbr101 FROM xcbg_t
       WHERE xcbgent  = g_enterprise
         AND xcbgcomp = g_xcbq_m.xcbqcomp
         AND xcbg001  = l_yy
         AND xcbg002  = l_yy
         AND xcbg003  = l_xcbr001
      IF cl_null(l_xcbr101) THEN LET l_xcbr101 = 0 END IF
      
      LET l_xcbr102 = 0
      LET l_xcbr103 = l_xcbr101 * l_xcbr102
      
      UPDATE xcbr_t
         SET xcbr101 = l_xcbr101,
             xcbr102 = l_xcbr102,
             xcbr103 = l_xcbr103,
             xcbr104 = xcbr100 + l_xcbr103
       WHERE xcbrent = g_enterprise
         AND xcbrdocno = g_xcbq_m.xcbqdocno
         
   END FOREACH
END FUNCTION

 
{</section>}
 
