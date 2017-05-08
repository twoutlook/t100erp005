#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt015.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2015-11-04 13:58:47), PR版次:0009(2017-01-06 18:41:29)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: afmt015
#+ Description: 融資申請單
#+ Creator....: 02291(2015-11-03 14:44:03)
#+ Modifier...: 02291 -SD/PR- 08729
 
{</section>}
 
{<section id="afmt015.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#6   2016/04/19  By 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160818-00017#12  2016/08/24  By 07900    删除修改未重新判断状态码
#161006-00005#12  2016/10/19  By 08732    組織類型與職能開窗調整
#161026-00023#1   2016/11/18  By 01727    AFM模組,增加BPM簽核功能。
#161207-00032#1   2016/12/07  By 01727    1.抽单状态要可以修改删除
#                                         2.已拒绝状态要可以修改删除
#                                         3.在s_conf_upd中要更新状态码
#161212-00003#1   2016/12/12  By 01727    狀況碼為「D抽單 / R已拒絕」時允許修改資料再重新進行提交，但更改單頭或單身資料後，狀況碼需還原為”N未確認”。
#161104-00046#15  2017/01/03  By 08729    處理單別預設質
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
PRIVATE type type_g_fmce_m        RECORD
       fmcesite LIKE fmce_t.fmcesite, 
   fmcesite_desc LIKE type_t.chr80, 
   fmcecomp LIKE fmce_t.fmcecomp, 
   fmcecomp_desc LIKE type_t.chr80, 
   fmcedocno LIKE fmce_t.fmcedocno, 
   fmcedocdt LIKE fmce_t.fmcedocdt, 
   fmcestus LIKE fmce_t.fmcestus, 
   fmceownid LIKE fmce_t.fmceownid, 
   fmceownid_desc LIKE type_t.chr80, 
   fmceowndp LIKE fmce_t.fmceowndp, 
   fmceowndp_desc LIKE type_t.chr80, 
   fmcecrtid LIKE fmce_t.fmcecrtid, 
   fmcecrtid_desc LIKE type_t.chr80, 
   fmcecrtdp LIKE fmce_t.fmcecrtdp, 
   fmcecrtdp_desc LIKE type_t.chr80, 
   fmcecrtdt LIKE fmce_t.fmcecrtdt, 
   fmcemodid LIKE fmce_t.fmcemodid, 
   fmcemodid_desc LIKE type_t.chr80, 
   fmcemoddt LIKE fmce_t.fmcemoddt, 
   fmcecnfid LIKE fmce_t.fmcecnfid, 
   fmcecnfid_desc LIKE type_t.chr80, 
   fmcecnfdt LIKE fmce_t.fmcecnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_fmcf_d        RECORD
       fmcfseq LIKE fmcf_t.fmcfseq, 
   fmcf007 LIKE fmcf_t.fmcf007, 
   fmcf007_desc LIKE type_t.chr500, 
   fmcf001 LIKE fmcf_t.fmcf001, 
   fmcf001_desc LIKE type_t.chr500, 
   fmcf002 LIKE fmcf_t.fmcf002, 
   fmcf002_desc LIKE type_t.chr500, 
   fmcf003 LIKE fmcf_t.fmcf003, 
   fmcf004 LIKE fmcf_t.fmcf004, 
   fmcf005 LIKE fmcf_t.fmcf005, 
   fmcf006 LIKE fmcf_t.fmcf006
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_fmcedocno LIKE fmce_t.fmcedocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaald          LIKE glaa_t.glaald
DEFINE g_glaa003         LIKE glaa_t.glaa003
DEFINE g_glaa024         LIKE glaa_t.glaa024
DEFINE g_fmcecomp_str    STRING
DEFINE g_wc_cs_comp      STRING   #161006-00005#12   add
DEFINE g_user_dept_wc    STRING   #161104-00046#15   add
DEFINE g_user_dept_wc_q  STRING   #161104-00046#15   add
DEFINE g_user_slip_wc    STRING   #161104-00046#15   add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_fmce_m          type_g_fmce_m
DEFINE g_fmce_m_t        type_g_fmce_m
DEFINE g_fmce_m_o        type_g_fmce_m
DEFINE g_fmce_m_mask_o   type_g_fmce_m #轉換遮罩前資料
DEFINE g_fmce_m_mask_n   type_g_fmce_m #轉換遮罩後資料
 
   DEFINE g_fmcedocno_t LIKE fmce_t.fmcedocno
 
 
DEFINE g_fmcf_d          DYNAMIC ARRAY OF type_g_fmcf_d
DEFINE g_fmcf_d_t        type_g_fmcf_d
DEFINE g_fmcf_d_o        type_g_fmcf_d
DEFINE g_fmcf_d_mask_o   DYNAMIC ARRAY OF type_g_fmcf_d #轉換遮罩前資料
DEFINE g_fmcf_d_mask_n   DYNAMIC ARRAY OF type_g_fmcf_d #轉換遮罩後資料
 
 
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
 
{<section id="afmt015.main" >}
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
   #161104-00046#15-add(s)
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_fmce_m','','','','','','')RETURNING g_sub_success
   
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('fmcecomp','','fmceent','fmcedocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#15-add(e)
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT fmcesite,'',fmcecomp,'',fmcedocno,fmcedocdt,fmcestus,fmceownid,'',fmceowndp, 
       '',fmcecrtid,'',fmcecrtdp,'',fmcecrtdt,fmcemodid,'',fmcemoddt,fmcecnfid,'',fmcecnfdt", 
                      " FROM fmce_t",
                      " WHERE fmceent= ? AND fmcedocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt015_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fmcesite,t0.fmcecomp,t0.fmcedocno,t0.fmcedocdt,t0.fmcestus,t0.fmceownid, 
       t0.fmceowndp,t0.fmcecrtid,t0.fmcecrtdp,t0.fmcecrtdt,t0.fmcemodid,t0.fmcemoddt,t0.fmcecnfid,t0.fmcecnfdt, 
       t1.ooefl003 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooag011", 
 
               " FROM fmce_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.fmcesite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.fmcecomp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.fmceownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.fmceowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.fmcecrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.fmcecrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.fmcemodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.fmcecnfid  ",
 
               " WHERE t0.fmceent = " ||g_enterprise|| " AND t0.fmcedocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afmt015_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmt015 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmt015_init()   
 
      #進入選單 Menu (="N")
      CALL afmt015_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afmt015
      
   END IF 
   
   CLOSE afmt015_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afmt015.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afmt015_init()
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
      CALL cl_set_combo_scc_part('fmcestus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #展組織下階成員所需之暫存檔
   CALL s_fin_create_account_center_tmp()
   
   #161006-00005#14   add---s
   CALL s_fin_azzi800_sons_query(g_today) 
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   #161006-00005#14   add---e
   #end add-point
   
   #初始化搜尋條件
   CALL afmt015_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="afmt015.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION afmt015_ui_dialog()
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
            CALL afmt015_insert()
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
         INITIALIZE g_fmce_m.* TO NULL
         CALL g_fmcf_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afmt015_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_fmcf_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt015_idx_chk()
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
               CALL afmt015_idx_chk()
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
            CALL afmt015_browser_fill("")
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
               CALL afmt015_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL afmt015_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL afmt015_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL afmt015_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL afmt015_set_act_visible()   
            CALL afmt015_set_act_no_visible()
            IF NOT (g_fmce_m.fmcedocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " fmceent = " ||g_enterprise|| " AND",
                                  " fmcedocno = '", g_fmce_m.fmcedocno, "' "
 
               #填到對應位置
               CALL afmt015_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "fmce_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmcf_t" 
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
               CALL afmt015_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "fmce_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmcf_t" 
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
                  CALL afmt015_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afmt015_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL afmt015_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt015_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL afmt015_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt015_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL afmt015_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt015_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL afmt015_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt015_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL afmt015_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt015_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_fmcf_d)
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
               CALL afmt015_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afmt015_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afmt015_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afmt015_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL afmt015_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afmt015_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afmt015_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmt015_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmt015_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_fmce_m.fmcedocdt)
 
 
 
         
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
 
{<section id="afmt015.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION afmt015_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT fmcedocno ",
                      " FROM fmce_t ",
                      " ",
                      " LEFT JOIN fmcf_t ON fmcfent = fmceent AND fmcedocno = fmcfdocno ", "  ",
                      #add-point:browser_fill段sql(fmcf_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE fmceent = " ||g_enterprise|| " AND fmcfent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("fmce_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT fmcedocno ",
                      " FROM fmce_t ", 
                      "  ",
                      "  ",
                      " WHERE fmceent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("fmce_t")
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
      INITIALIZE g_fmce_m.* TO NULL
      CALL g_fmcf_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.fmcedocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fmcestus,t0.fmcedocno ",
                  " FROM fmce_t t0",
                  "  ",
                  "  LEFT JOIN fmcf_t ON fmcfent = fmceent AND fmcedocno = fmcfdocno ", "  ", 
                  #add-point:browser_fill段sql(fmcf_t1) name="browser_fill.join.fmcf_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.fmceent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("fmce_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fmcestus,t0.fmcedocno ",
                  " FROM fmce_t t0",
                  "  ",
                  
                  " WHERE t0.fmceent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("fmce_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY fmcedocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"fmce_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_fmcedocno
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
   
   IF cl_null(g_browser[g_cnt].b_fmcedocno) THEN
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
 
{<section id="afmt015.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION afmt015_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_fmce_m.fmcedocno = g_browser[g_current_idx].b_fmcedocno   
 
   EXECUTE afmt015_master_referesh USING g_fmce_m.fmcedocno INTO g_fmce_m.fmcesite,g_fmce_m.fmcecomp, 
       g_fmce_m.fmcedocno,g_fmce_m.fmcedocdt,g_fmce_m.fmcestus,g_fmce_m.fmceownid,g_fmce_m.fmceowndp, 
       g_fmce_m.fmcecrtid,g_fmce_m.fmcecrtdp,g_fmce_m.fmcecrtdt,g_fmce_m.fmcemodid,g_fmce_m.fmcemoddt, 
       g_fmce_m.fmcecnfid,g_fmce_m.fmcecnfdt,g_fmce_m.fmcesite_desc,g_fmce_m.fmcecomp_desc,g_fmce_m.fmceownid_desc, 
       g_fmce_m.fmceowndp_desc,g_fmce_m.fmcecrtid_desc,g_fmce_m.fmcecrtdp_desc,g_fmce_m.fmcemodid_desc, 
       g_fmce_m.fmcecnfid_desc
   
   CALL afmt015_fmce_t_mask()
   CALL afmt015_show()
      
END FUNCTION
 
{</section>}
 
{<section id="afmt015.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION afmt015_ui_detailshow()
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
 
{<section id="afmt015.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afmt015_ui_browser_refresh()
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
      IF g_browser[l_i].b_fmcedocno = g_fmce_m.fmcedocno 
 
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
 
{<section id="afmt015.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmt015_construct()
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
   INITIALIZE g_fmce_m.* TO NULL
   CALL g_fmcf_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON fmcesite,fmcecomp,fmcedocno,fmcedocdt,fmcestus,fmceownid,fmceowndp,fmcecrtid, 
          fmcecrtdp,fmcecrtdt,fmcemodid,fmcemoddt,fmcecnfid,fmcecnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<fmcecrtdt>>----
         AFTER FIELD fmcecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<fmcemoddt>>----
         AFTER FIELD fmcemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmcecnfdt>>----
         AFTER FIELD fmcecnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmcepstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.fmcesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcesite
            #add-point:ON ACTION controlp INFIELD fmcesite name="construct.c.fmcesite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161006-00005#12   mark                    
            CALL q_ooef001_33()   #161006-00005#12   add
            DISPLAY g_qryparam.return1 TO fmcesite  #顯示到畫面上
            NEXT FIELD fmcesite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcesite
            #add-point:BEFORE FIELD fmcesite name="construct.b.fmcesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcesite
            
            #add-point:AFTER FIELD fmcesite name="construct.a.fmcesite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcecomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcecomp
            #add-point:ON ACTION controlp INFIELD fmcecomp name="construct.c.fmcecomp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",g_wc_cs_comp   #161006-00005#12   add
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcecomp  #顯示到畫面上
            NEXT FIELD fmcecomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcecomp
            #add-point:BEFORE FIELD fmcecomp name="construct.b.fmcecomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcecomp
            
            #add-point:AFTER FIELD fmcecomp name="construct.a.fmcecomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcedocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcedocno
            #add-point:ON ACTION controlp INFIELD fmcedocno name="construct.c.fmcedocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161104-00046#15-add(s)
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#15-add(e)
            CALL q_fmcedocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcedocno  #顯示到畫面上
            NEXT FIELD fmcedocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcedocno
            #add-point:BEFORE FIELD fmcedocno name="construct.b.fmcedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcedocno
            
            #add-point:AFTER FIELD fmcedocno name="construct.a.fmcedocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcedocdt
            #add-point:BEFORE FIELD fmcedocdt name="construct.b.fmcedocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcedocdt
            
            #add-point:AFTER FIELD fmcedocdt name="construct.a.fmcedocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcedocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcedocdt
            #add-point:ON ACTION controlp INFIELD fmcedocdt name="construct.c.fmcedocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcestus
            #add-point:BEFORE FIELD fmcestus name="construct.b.fmcestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcestus
            
            #add-point:AFTER FIELD fmcestus name="construct.a.fmcestus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcestus
            #add-point:ON ACTION controlp INFIELD fmcestus name="construct.c.fmcestus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmceownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmceownid
            #add-point:ON ACTION controlp INFIELD fmceownid name="construct.c.fmceownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmceownid  #顯示到畫面上
            NEXT FIELD fmceownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmceownid
            #add-point:BEFORE FIELD fmceownid name="construct.b.fmceownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmceownid
            
            #add-point:AFTER FIELD fmceownid name="construct.a.fmceownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmceowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmceowndp
            #add-point:ON ACTION controlp INFIELD fmceowndp name="construct.c.fmceowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmceowndp  #顯示到畫面上
            NEXT FIELD fmceowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmceowndp
            #add-point:BEFORE FIELD fmceowndp name="construct.b.fmceowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmceowndp
            
            #add-point:AFTER FIELD fmceowndp name="construct.a.fmceowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcecrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcecrtid
            #add-point:ON ACTION controlp INFIELD fmcecrtid name="construct.c.fmcecrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcecrtid  #顯示到畫面上
            NEXT FIELD fmcecrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcecrtid
            #add-point:BEFORE FIELD fmcecrtid name="construct.b.fmcecrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcecrtid
            
            #add-point:AFTER FIELD fmcecrtid name="construct.a.fmcecrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcecrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcecrtdp
            #add-point:ON ACTION controlp INFIELD fmcecrtdp name="construct.c.fmcecrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcecrtdp  #顯示到畫面上
            NEXT FIELD fmcecrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcecrtdp
            #add-point:BEFORE FIELD fmcecrtdp name="construct.b.fmcecrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcecrtdp
            
            #add-point:AFTER FIELD fmcecrtdp name="construct.a.fmcecrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcecrtdt
            #add-point:BEFORE FIELD fmcecrtdt name="construct.b.fmcecrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmcemodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcemodid
            #add-point:ON ACTION controlp INFIELD fmcemodid name="construct.c.fmcemodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcemodid  #顯示到畫面上
            NEXT FIELD fmcemodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcemodid
            #add-point:BEFORE FIELD fmcemodid name="construct.b.fmcemodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcemodid
            
            #add-point:AFTER FIELD fmcemodid name="construct.a.fmcemodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcemoddt
            #add-point:BEFORE FIELD fmcemoddt name="construct.b.fmcemoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmcecnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcecnfid
            #add-point:ON ACTION controlp INFIELD fmcecnfid name="construct.c.fmcecnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcecnfid  #顯示到畫面上
            NEXT FIELD fmcecnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcecnfid
            #add-point:BEFORE FIELD fmcecnfid name="construct.b.fmcecnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcecnfid
            
            #add-point:AFTER FIELD fmcecnfid name="construct.a.fmcecnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcecnfdt
            #add-point:BEFORE FIELD fmcecnfdt name="construct.b.fmcecnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON fmcfseq,fmcf007,fmcf001,fmcf002,fmcf003,fmcf004,fmcf005,fmcf006
           FROM s_detail1[1].fmcfseq,s_detail1[1].fmcf007,s_detail1[1].fmcf001,s_detail1[1].fmcf002, 
               s_detail1[1].fmcf003,s_detail1[1].fmcf004,s_detail1[1].fmcf005,s_detail1[1].fmcf006
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcfseq
            #add-point:BEFORE FIELD fmcfseq name="construct.b.page1.fmcfseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcfseq
            
            #add-point:AFTER FIELD fmcfseq name="construct.a.page1.fmcfseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmcfseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcfseq
            #add-point:ON ACTION controlp INFIELD fmcfseq name="construct.c.page1.fmcfseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmcf007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcf007
            #add-point:ON ACTION controlp INFIELD fmcf007 name="construct.c.page1.fmcf007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161006-00005#12   mark                    
            CALL q_ooef001_33()   #161006-00005#12   add
            DISPLAY g_qryparam.return1 TO fmcf007  #顯示到畫面上
            NEXT FIELD fmcf007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcf007
            #add-point:BEFORE FIELD fmcf007 name="construct.b.page1.fmcf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcf007
            
            #add-point:AFTER FIELD fmcf007 name="construct.a.page1.fmcf007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcf001
            #add-point:BEFORE FIELD fmcf001 name="construct.b.page1.fmcf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcf001
            
            #add-point:AFTER FIELD fmcf001 name="construct.a.page1.fmcf001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmcf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcf001
            #add-point:ON ACTION controlp INFIELD fmcf001 name="construct.c.page1.fmcf001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmcf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcf002
            #add-point:ON ACTION controlp INFIELD fmcf002 name="construct.c.page1.fmcf002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcf002  #顯示到畫面上
            NEXT FIELD fmcf002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcf002
            #add-point:BEFORE FIELD fmcf002 name="construct.b.page1.fmcf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcf002
            
            #add-point:AFTER FIELD fmcf002 name="construct.a.page1.fmcf002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcf003
            #add-point:BEFORE FIELD fmcf003 name="construct.b.page1.fmcf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcf003
            
            #add-point:AFTER FIELD fmcf003 name="construct.a.page1.fmcf003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmcf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcf003
            #add-point:ON ACTION controlp INFIELD fmcf003 name="construct.c.page1.fmcf003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcf004
            #add-point:BEFORE FIELD fmcf004 name="construct.b.page1.fmcf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcf004
            
            #add-point:AFTER FIELD fmcf004 name="construct.a.page1.fmcf004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmcf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcf004
            #add-point:ON ACTION controlp INFIELD fmcf004 name="construct.c.page1.fmcf004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcf005
            #add-point:BEFORE FIELD fmcf005 name="construct.b.page1.fmcf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcf005
            
            #add-point:AFTER FIELD fmcf005 name="construct.a.page1.fmcf005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmcf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcf005
            #add-point:ON ACTION controlp INFIELD fmcf005 name="construct.c.page1.fmcf005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcf006
            #add-point:BEFORE FIELD fmcf006 name="construct.b.page1.fmcf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcf006
            
            #add-point:AFTER FIELD fmcf006 name="construct.a.page1.fmcf006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmcf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcf006
            #add-point:ON ACTION controlp INFIELD fmcf006 name="construct.c.page1.fmcf006"
            
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
                  WHEN la_wc[li_idx].tableid = "fmce_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "fmcf_t" 
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
   #161104-00046#15-add(s)
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#15-add(e)
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afmt015.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afmt015_query()
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
   CALL g_fmcf_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL afmt015_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afmt015_browser_fill("")
      CALL afmt015_fetch("")
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
   CALL afmt015_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL afmt015_fetch("F") 
      #顯示單身筆數
      CALL afmt015_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afmt015.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afmt015_fetch(p_flag)
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
   
   LET g_fmce_m.fmcedocno = g_browser[g_current_idx].b_fmcedocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE afmt015_master_referesh USING g_fmce_m.fmcedocno INTO g_fmce_m.fmcesite,g_fmce_m.fmcecomp, 
       g_fmce_m.fmcedocno,g_fmce_m.fmcedocdt,g_fmce_m.fmcestus,g_fmce_m.fmceownid,g_fmce_m.fmceowndp, 
       g_fmce_m.fmcecrtid,g_fmce_m.fmcecrtdp,g_fmce_m.fmcecrtdt,g_fmce_m.fmcemodid,g_fmce_m.fmcemoddt, 
       g_fmce_m.fmcecnfid,g_fmce_m.fmcecnfdt,g_fmce_m.fmcesite_desc,g_fmce_m.fmcecomp_desc,g_fmce_m.fmceownid_desc, 
       g_fmce_m.fmceowndp_desc,g_fmce_m.fmcecrtid_desc,g_fmce_m.fmcecrtdp_desc,g_fmce_m.fmcemodid_desc, 
       g_fmce_m.fmcecnfid_desc
   
   #遮罩相關處理
   LET g_fmce_m_mask_o.* =  g_fmce_m.*
   CALL afmt015_fmce_t_mask()
   LET g_fmce_m_mask_n.* =  g_fmce_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt015_set_act_visible()   
   CALL afmt015_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL afmt015_fmcecomp_ref()
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_fmce_m_t.* = g_fmce_m.*
   LET g_fmce_m_o.* = g_fmce_m.*
   
   LET g_data_owner = g_fmce_m.fmceownid      
   LET g_data_dept  = g_fmce_m.fmceowndp
   
   #重新顯示   
   CALL afmt015_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt015.insert" >}
#+ 資料新增
PRIVATE FUNCTION afmt015_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_errno   LIKE gzze_t.gzze001
   DEFINE l_ld      LIKE glaa_t.glaald
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_fmcf_d.clear()   
 
 
   INITIALIZE g_fmce_m.* TO NULL             #DEFAULT 設定
   
   LET g_fmcedocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmce_m.fmceownid = g_user
      LET g_fmce_m.fmceowndp = g_dept
      LET g_fmce_m.fmcecrtid = g_user
      LET g_fmce_m.fmcecrtdp = g_dept 
      LET g_fmce_m.fmcecrtdt = cl_get_current()
      LET g_fmce_m.fmcemodid = g_user
      LET g_fmce_m.fmcemoddt = cl_get_current()
      LET g_fmce_m.fmcestus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_fmce_m.fmcesite = g_site
      LET g_fmce_m.fmcedocdt = g_today
      CALL s_fin_orga_get_comp_ld(g_fmce_m.fmcesite) RETURNING l_success,l_errno,g_fmce_m.fmcecomp,l_ld
      LET g_fmce_m.fmcesite_desc = s_desc_get_department_desc(g_fmce_m.fmcesite)
      LET g_fmce_m.fmcecomp_desc = s_desc_get_department_desc(g_fmce_m.fmcecomp)
      CALL afmt015_fmcecomp_ref()
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_fmce_m_t.* = g_fmce_m.*
      LET g_fmce_m_o.* = g_fmce_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmce_m.fmcestus 
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
 
 
 
    
      CALL afmt015_input("a")
      
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
         INITIALIZE g_fmce_m.* TO NULL
         INITIALIZE g_fmcf_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL afmt015_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_fmcf_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt015_set_act_visible()   
   CALL afmt015_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fmcedocno_t = g_fmce_m.fmcedocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmceent = " ||g_enterprise|| " AND",
                      " fmcedocno = '", g_fmce_m.fmcedocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt015_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE afmt015_cl
   
   CALL afmt015_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afmt015_master_referesh USING g_fmce_m.fmcedocno INTO g_fmce_m.fmcesite,g_fmce_m.fmcecomp, 
       g_fmce_m.fmcedocno,g_fmce_m.fmcedocdt,g_fmce_m.fmcestus,g_fmce_m.fmceownid,g_fmce_m.fmceowndp, 
       g_fmce_m.fmcecrtid,g_fmce_m.fmcecrtdp,g_fmce_m.fmcecrtdt,g_fmce_m.fmcemodid,g_fmce_m.fmcemoddt, 
       g_fmce_m.fmcecnfid,g_fmce_m.fmcecnfdt,g_fmce_m.fmcesite_desc,g_fmce_m.fmcecomp_desc,g_fmce_m.fmceownid_desc, 
       g_fmce_m.fmceowndp_desc,g_fmce_m.fmcecrtid_desc,g_fmce_m.fmcecrtdp_desc,g_fmce_m.fmcemodid_desc, 
       g_fmce_m.fmcecnfid_desc
   
   
   #遮罩相關處理
   LET g_fmce_m_mask_o.* =  g_fmce_m.*
   CALL afmt015_fmce_t_mask()
   LET g_fmce_m_mask_n.* =  g_fmce_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmce_m.fmcesite,g_fmce_m.fmcesite_desc,g_fmce_m.fmcecomp,g_fmce_m.fmcecomp_desc, 
       g_fmce_m.fmcedocno,g_fmce_m.fmcedocdt,g_fmce_m.fmcestus,g_fmce_m.fmceownid,g_fmce_m.fmceownid_desc, 
       g_fmce_m.fmceowndp,g_fmce_m.fmceowndp_desc,g_fmce_m.fmcecrtid,g_fmce_m.fmcecrtid_desc,g_fmce_m.fmcecrtdp, 
       g_fmce_m.fmcecrtdp_desc,g_fmce_m.fmcecrtdt,g_fmce_m.fmcemodid,g_fmce_m.fmcemodid_desc,g_fmce_m.fmcemoddt, 
       g_fmce_m.fmcecnfid,g_fmce_m.fmcecnfid_desc,g_fmce_m.fmcecnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_fmce_m.fmceownid      
   LET g_data_dept  = g_fmce_m.fmceowndp
   
   #功能已完成,通報訊息中心
   CALL afmt015_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afmt015.modify" >}
#+ 資料修改
PRIVATE FUNCTION afmt015_modify()
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
   LET g_fmce_m_t.* = g_fmce_m.*
   LET g_fmce_m_o.* = g_fmce_m.*
   
   IF g_fmce_m.fmcedocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_fmcedocno_t = g_fmce_m.fmcedocno
 
   CALL s_transaction_begin()
   
   OPEN afmt015_cl USING g_enterprise,g_fmce_m.fmcedocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt015_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afmt015_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt015_master_referesh USING g_fmce_m.fmcedocno INTO g_fmce_m.fmcesite,g_fmce_m.fmcecomp, 
       g_fmce_m.fmcedocno,g_fmce_m.fmcedocdt,g_fmce_m.fmcestus,g_fmce_m.fmceownid,g_fmce_m.fmceowndp, 
       g_fmce_m.fmcecrtid,g_fmce_m.fmcecrtdp,g_fmce_m.fmcecrtdt,g_fmce_m.fmcemodid,g_fmce_m.fmcemoddt, 
       g_fmce_m.fmcecnfid,g_fmce_m.fmcecnfdt,g_fmce_m.fmcesite_desc,g_fmce_m.fmcecomp_desc,g_fmce_m.fmceownid_desc, 
       g_fmce_m.fmceowndp_desc,g_fmce_m.fmcecrtid_desc,g_fmce_m.fmcecrtdp_desc,g_fmce_m.fmcemodid_desc, 
       g_fmce_m.fmcecnfid_desc
   
   #檢查是否允許此動作
   IF NOT afmt015_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmce_m_mask_o.* =  g_fmce_m.*
   CALL afmt015_fmce_t_mask()
   LET g_fmce_m_mask_n.* =  g_fmce_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL afmt015_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_fmcedocno_t = g_fmce_m.fmcedocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_fmce_m.fmcemodid = g_user 
LET g_fmce_m.fmcemoddt = cl_get_current()
LET g_fmce_m.fmcemodid_desc = cl_get_username(g_fmce_m.fmcemodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #161212-00003#1 Add  ---(S)---
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_fmce_m.fmcestus MATCHES "[DR]" THEN 
         LET g_fmce_m.fmcestus = "N"
      END IF
      #161212-00003#1 Add  ---(E)---
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL afmt015_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE fmce_t SET (fmcemodid,fmcemoddt) = (g_fmce_m.fmcemodid,g_fmce_m.fmcemoddt)
          WHERE fmceent = g_enterprise AND fmcedocno = g_fmcedocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_fmce_m.* = g_fmce_m_t.*
            CALL afmt015_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_fmce_m.fmcedocno != g_fmce_m_t.fmcedocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE fmcf_t SET fmcfdocno = g_fmce_m.fmcedocno
 
          WHERE fmcfent = g_enterprise AND fmcfdocno = g_fmce_m_t.fmcedocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fmcf_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmcf_t:",SQLERRMESSAGE 
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
   CALL afmt015_set_act_visible()   
   CALL afmt015_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fmceent = " ||g_enterprise|| " AND",
                      " fmcedocno = '", g_fmce_m.fmcedocno, "' "
 
   #填到對應位置
   CALL afmt015_browser_fill("")
 
   CLOSE afmt015_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt015_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="afmt015.input" >}
#+ 資料輸入
PRIVATE FUNCTION afmt015_input(p_cmd)
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
   DEFINE  l_sql                 STRING
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE gzze_t.gzze001
   DEFINE  l_ld                  LIKE glaa_t.glaald
   DEFINE  l_flag                LIKE type_t.num5    #161104-00046#15-add
   DEFINE  l_slip                LIKE ooba_t.ooba002 #161104-00046#15-add
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
   DISPLAY BY NAME g_fmce_m.fmcesite,g_fmce_m.fmcesite_desc,g_fmce_m.fmcecomp,g_fmce_m.fmcecomp_desc, 
       g_fmce_m.fmcedocno,g_fmce_m.fmcedocdt,g_fmce_m.fmcestus,g_fmce_m.fmceownid,g_fmce_m.fmceownid_desc, 
       g_fmce_m.fmceowndp,g_fmce_m.fmceowndp_desc,g_fmce_m.fmcecrtid,g_fmce_m.fmcecrtid_desc,g_fmce_m.fmcecrtdp, 
       g_fmce_m.fmcecrtdp_desc,g_fmce_m.fmcecrtdt,g_fmce_m.fmcemodid,g_fmce_m.fmcemodid_desc,g_fmce_m.fmcemoddt, 
       g_fmce_m.fmcecnfid,g_fmce_m.fmcecnfid_desc,g_fmce_m.fmcecnfdt
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT fmcfseq,fmcf007,fmcf001,fmcf002,fmcf003,fmcf004,fmcf005,fmcf006 FROM fmcf_t  
       WHERE fmcfent=? AND fmcfdocno=? AND fmcfseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt015_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL afmt015_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afmt015_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_fmce_m.fmcesite,g_fmce_m.fmcecomp,g_fmce_m.fmcedocno,g_fmce_m.fmcedocdt,g_fmce_m.fmcestus 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="afmt015.input.head" >}
      #單頭段
      INPUT BY NAME g_fmce_m.fmcesite,g_fmce_m.fmcecomp,g_fmce_m.fmcedocno,g_fmce_m.fmcedocdt,g_fmce_m.fmcestus  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN afmt015_cl USING g_enterprise,g_fmce_m.fmcedocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt015_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt015_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL afmt015_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
 
            #end add-point
            CALL afmt015_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcesite
            
            #add-point:AFTER FIELD fmcesite name="input.a.fmcesite"
            IF NOT cl_null(g_fmce_m.fmcesite) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmce_m.fmcesite

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_42") THEN
                  #檢查成功時後續處理
                  CALL s_fin_orga_get_comp_ld(g_fmce_m.fmcesite) RETURNING l_success,l_errno,g_fmce_m.fmcecomp,l_ld     
                  CALL s_fin_account_center_sons_query('6',g_fmce_m.fmcesite,g_today,'')
                  CALL s_fin_account_center_comp_str()  RETURNING g_fmcecomp_str
                  CALL s_fin_get_wc_str(g_fmcecomp_str) RETURNING g_fmcecomp_str
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            END IF 
            LET g_fmce_m.fmcesite_desc = s_desc_get_department_desc(g_fmce_m.fmcesite)
            LET g_fmce_m.fmcecomp_desc = s_desc_get_department_desc(g_fmce_m.fmcecomp)
            DISPLAY BY NAME g_fmce_m.fmcesite_desc,g_fmce_m.fmcecomp_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcesite
            #add-point:BEFORE FIELD fmcesite name="input.b.fmcesite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcesite
            #add-point:ON CHANGE fmcesite name="input.g.fmcesite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcecomp
            
            #add-point:AFTER FIELD fmcecomp name="input.a.fmcecomp"
            IF NOT cl_null(g_fmce_m.fmcecomp) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmce_m.fmcecomp

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_42") THEN
                  #檢查成功時後續處理
                  IF NOT cl_null(g_fmce_m.fmcesite) THEN
                     LET l_n = 0 
                     LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = ",g_enterprise
                     IF NOT cl_null(g_fmcecomp_str) THEN
                        LET l_sql = l_sql CLIPPED," AND ooef001 IN ",g_fmcecomp_str CLIPPED,
                                                  " AND ooef001 = '",g_fmce_m.fmcecomp,"'"
                     ELSE 
                        LET l_sql = l_sql CLIPPED," AND ooef001 IN(SELECT ooef017 FROM ooef_t 
                                    WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_fmce_m.fmcesite,"')",
                                    " AND ooef001 = '",g_fmce_m.fmcecomp,"'"
                     END IF
                     PREPARE ooef001_prep FROM l_sql
                     EXECUTE ooef001_prep INTO l_n
                     IF l_n = 0 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = g_fmce_m.fmcecomp 
                        LET g_errparam.code   = 'afm-00137'
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        NEXT FIELD fmcecomp
                     END IF
                     CALL afmt015_fmcecomp_ref()
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmce_m.fmcecomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmce_m.fmcecomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmce_m.fmcecomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcecomp
            #add-point:BEFORE FIELD fmcecomp name="input.b.fmcecomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcecomp
            #add-point:ON CHANGE fmcecomp name="input.g.fmcecomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcedocno
            #add-point:BEFORE FIELD fmcedocno name="input.b.fmcedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcedocno
            
            #add-point:AFTER FIELD fmcedocno name="input.a.fmcedocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_fmce_m.fmcedocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fmce_m.fmcedocno != g_fmcedocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmce_t WHERE "||"fmceent = '" ||g_enterprise|| "' AND "||"fmcedocno = '"||g_fmce_m.fmcedocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_fmce_m.fmcedocno) THEN
               CALL s_aooi200_fin_chk_slip(g_glaald,g_glaa024,g_fmce_m.fmcedocno,'afmt015') RETURNING l_success
               IF l_success = FALSE THEN
                  LET g_fmce_m.fmcedocno = g_fmce_m_t.fmcedocno
                  NEXT FIELD fmcedocno
               END IF
               #161104-00046#15-----s
               CALL s_aooi200_fin_get_slip(g_fmce_m.fmcedocno) RETURNING g_sub_success,l_slip
               CALL s_control_chk_doc('1',g_fmce_m.fmcedocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
               IF g_sub_success AND l_flag THEN             
               ELSE
                  LET g_fmce_m.fmcedocno = g_fmce_m_o.fmcedocno 
                  NEXT FIELD CURRENT                  
               END IF
               #刪除單別預設temptable
               DELETE FROM s_aooi200def1
               #以目前畫面資訊新增temp資料   #請勿調整.*
               INSERT INTO s_aooi200def1 VALUES(g_fmce_m.*)
               #依單別預設取用資訊
               CALL s_aooi200def_get('','',g_fmce_m.fmcesite,'2',l_slip,'','',g_glaald)
               #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
               SELECT * INTO g_fmce_m.* FROM s_aooi200def1
               #161104-00046#15-----e        
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcedocno
            #add-point:ON CHANGE fmcedocno name="input.g.fmcedocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcedocdt
            #add-point:BEFORE FIELD fmcedocdt name="input.b.fmcedocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcedocdt
            
            #add-point:AFTER FIELD fmcedocdt name="input.a.fmcedocdt"
            CALL s_anm_date_chk(g_fmce_m.fmcesite,g_fmce_m.fmcedocdt) RETURNING l_success
            IF NOT l_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = "afm-00207"
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcedocdt
            #add-point:ON CHANGE fmcedocdt name="input.g.fmcedocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcestus
            #add-point:BEFORE FIELD fmcestus name="input.b.fmcestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcestus
            
            #add-point:AFTER FIELD fmcestus name="input.a.fmcestus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcestus
            #add-point:ON CHANGE fmcestus name="input.g.fmcestus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fmcesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcesite
            #add-point:ON ACTION controlp INFIELD fmcesite name="input.c.fmcesite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmce_m.fmcesite             #給予default值
            LET g_qryparam.default2 = "" #g_fmce_m.ooef001 #组织编号
            #LET g_qryparam.where = " ooef206 = 'Y'"   #161006-00005#12   mark  
            #給予arg
            LET g_qryparam.arg1 = "" #


            #CALL q_ooef001()     #161006-00005#12   mark                    
            CALL q_ooef001_33()   #161006-00005#12   add            

            LET g_fmce_m.fmcesite = g_qryparam.return1              
            #LET g_fmce_m.ooef001 = g_qryparam.return2 
            DISPLAY g_fmce_m.fmcesite TO fmcesite              #
            LET g_fmce_m.fmcesite_desc = s_desc_get_department_desc(g_fmce_m.fmcesite)
            DISPLAY BY NAME g_fmce_m.fmcesite_desc
            LET g_qryparam.where = ""
            #DISPLAY g_fmce_m.ooef001 TO ooef001 #组织编号
            NEXT FIELD fmcesite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmcecomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcecomp
            #add-point:ON ACTION controlp INFIELD fmcecomp name="input.c.fmcecomp"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            #161028-00032#1 --s add
            CALL s_fin_account_center_sons_query('3',g_fmce_m.fmcesite,g_today,'')
            CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp
            CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
            #161028-00032#1 --e add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmce_m.fmcecomp             #給予default值
            LET g_qryparam.default2 = "" #g_fmce_m.ooef001 #组织编号
            LET g_qryparam.where = " ooef003 = 'Y'"   #161006-00005#12   add
            IF NOT cl_null(g_fmcecomp_str) THEN
               LET g_qryparam.where = g_qryparam.where,
            #                        " ooef206 = 'Y'   #161006-00005#12   mark
                                     " AND ooef001 IN ",g_fmcecomp_str CLIPPED
            ELSE 
            #   LET g_qryparam.where = " ooef206 = 'Y' AND ooef001 IN(SELECT ooef017 FROM ooef_t                  #161006-00005#12   mark
            #                          WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_fmce_m.fmcesite,"')"   #161006-00005#12   mark
               LET g_qryparam.where = g_qryparam.where, " AND ooef001 IN ",g_wc_cs_comp   #161006-00005#12   add
            END IF
            
            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooef001()                                #呼叫開窗

            LET g_fmce_m.fmcecomp = g_qryparam.return1              
            #LET g_fmce_m.ooef001 = g_qryparam.return2 
            LET g_fmce_m.fmcecomp_desc = s_desc_get_department_desc(g_fmce_m.fmcecomp)
            CALL afmt015_fmcecomp_ref()
            DISPLAY BY NAME g_fmce_m.fmcecomp_desc
            DISPLAY g_fmce_m.fmcecomp TO fmcecomp              #
            LET g_qryparam.where = " "
            #DISPLAY g_fmce_m.ooef001 TO ooef001 #组织编号
            NEXT FIELD fmcecomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmcedocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcedocno
            #add-point:ON ACTION controlp INFIELD fmcedocno name="input.c.fmcedocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmce_m.fmcedocno
            LET g_qryparam.where = "ooba001 = '",g_glaa024,"' AND oobx003 = 'afmt015'"            
            #161104-00046#15-----s
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_slip_wc CLIPPED
            END IF
            #161104-00046#15-----e
            CALL q_ooba002_4()
            LET g_fmce_m.fmcedocno = g_qryparam.return1
            DISPLAY g_fmce_m.fmcedocno TO fmcedocno
            NEXT FIELD fmcedocno
            #END add-point
 
 
         #Ctrlp:input.c.fmcedocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcedocdt
            #add-point:ON ACTION controlp INFIELD fmcedocdt name="input.c.fmcedocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmcestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcestus
            #add-point:ON ACTION controlp INFIELD fmcestus name="input.c.fmcestus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_fmce_m.fmcedocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_fin_gen_docno(g_glaald,g_glaa024,g_glaa003,g_fmce_m.fmcedocno,g_fmce_m.fmcedocdt,g_prog)
                     RETURNING l_success,g_fmce_m.fmcedocno
               IF l_success  = 0  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_fmce_m.fmcedocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD fmcedocno
               END IF
               DISPLAY BY NAME g_fmce_m.fmcedocno
               #end add-point
               
               INSERT INTO fmce_t (fmceent,fmcesite,fmcecomp,fmcedocno,fmcedocdt,fmcestus,fmceownid, 
                   fmceowndp,fmcecrtid,fmcecrtdp,fmcecrtdt,fmcemodid,fmcemoddt,fmcecnfid,fmcecnfdt)
               VALUES (g_enterprise,g_fmce_m.fmcesite,g_fmce_m.fmcecomp,g_fmce_m.fmcedocno,g_fmce_m.fmcedocdt, 
                   g_fmce_m.fmcestus,g_fmce_m.fmceownid,g_fmce_m.fmceowndp,g_fmce_m.fmcecrtid,g_fmce_m.fmcecrtdp, 
                   g_fmce_m.fmcecrtdt,g_fmce_m.fmcemodid,g_fmce_m.fmcemoddt,g_fmce_m.fmcecnfid,g_fmce_m.fmcecnfdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_fmce_m:",SQLERRMESSAGE 
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
                  CALL afmt015_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL afmt015_b_fill()
                  CALL afmt015_b_fill2('0')
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
               CALL afmt015_fmce_t_mask_restore('restore_mask_o')
               
               UPDATE fmce_t SET (fmcesite,fmcecomp,fmcedocno,fmcedocdt,fmcestus,fmceownid,fmceowndp, 
                   fmcecrtid,fmcecrtdp,fmcecrtdt,fmcemodid,fmcemoddt,fmcecnfid,fmcecnfdt) = (g_fmce_m.fmcesite, 
                   g_fmce_m.fmcecomp,g_fmce_m.fmcedocno,g_fmce_m.fmcedocdt,g_fmce_m.fmcestus,g_fmce_m.fmceownid, 
                   g_fmce_m.fmceowndp,g_fmce_m.fmcecrtid,g_fmce_m.fmcecrtdp,g_fmce_m.fmcecrtdt,g_fmce_m.fmcemodid, 
                   g_fmce_m.fmcemoddt,g_fmce_m.fmcecnfid,g_fmce_m.fmcecnfdt)
                WHERE fmceent = g_enterprise AND fmcedocno = g_fmcedocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fmce_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL afmt015_fmce_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_fmce_m_t)
               LET g_log2 = util.JSON.stringify(g_fmce_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_fmcedocno_t = g_fmce_m.fmcedocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="afmt015.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_fmcf_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmcf_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt015_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_fmcf_d.getLength()
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
            OPEN afmt015_cl USING g_enterprise,g_fmce_m.fmcedocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt015_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt015_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmcf_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmcf_d[l_ac].fmcfseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fmcf_d_t.* = g_fmcf_d[l_ac].*  #BACKUP
               LET g_fmcf_d_o.* = g_fmcf_d[l_ac].*  #BACKUP
               CALL afmt015_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL afmt015_set_no_entry_b(l_cmd)
               IF NOT afmt015_lock_b("fmcf_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt015_bcl INTO g_fmcf_d[l_ac].fmcfseq,g_fmcf_d[l_ac].fmcf007,g_fmcf_d[l_ac].fmcf001, 
                      g_fmcf_d[l_ac].fmcf002,g_fmcf_d[l_ac].fmcf003,g_fmcf_d[l_ac].fmcf004,g_fmcf_d[l_ac].fmcf005, 
                      g_fmcf_d[l_ac].fmcf006
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmcf_d_t.fmcfseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmcf_d_mask_o[l_ac].* =  g_fmcf_d[l_ac].*
                  CALL afmt015_fmcf_t_mask()
                  LET g_fmcf_d_mask_n[l_ac].* =  g_fmcf_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt015_show()
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
            INITIALIZE g_fmcf_d[l_ac].* TO NULL 
            INITIALIZE g_fmcf_d_t.* TO NULL 
            INITIALIZE g_fmcf_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_fmcf_d[l_ac].fmcfseq = "0"
      LET g_fmcf_d[l_ac].fmcf003 = "0"
      LET g_fmcf_d[l_ac].fmcf004 = "0"
      LET g_fmcf_d[l_ac].fmcf005 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            IF l_cmd = 'a' THEN
               IF cl_null(g_fmcf_d[l_ac].fmcfseq) OR g_fmcf_d[l_ac].fmcfseq = 0 THEN
                  SELECT MAX(fmcfseq) INTO g_fmcf_d[l_ac].fmcfseq
                    FROM fmcf_t
                   WHERE fmcfent = g_enterprise
                     AND fmcfdocno = g_fmce_m.fmcedocno
               
                  IF cl_null(g_fmcf_d[l_ac].fmcfseq) THEN
                     LET g_fmcf_d[l_ac].fmcfseq = 1
                  ELSE
                     LET g_fmcf_d[l_ac].fmcfseq = g_fmcf_d[l_ac].fmcfseq + 1
                  END IF
               END IF
            END IF
            LET g_fmcf_d[l_ac].fmcf007 = g_fmce_m.fmcesite
            LET g_fmcf_d[l_ac].fmcf007_desc = s_desc_get_department_desc(g_fmcf_d[l_ac].fmcf007)
            #end add-point
            LET g_fmcf_d_t.* = g_fmcf_d[l_ac].*     #新輸入資料
            LET g_fmcf_d_o.* = g_fmcf_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt015_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt015_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmcf_d[li_reproduce_target].* = g_fmcf_d[li_reproduce].*
 
               LET g_fmcf_d[li_reproduce_target].fmcfseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM fmcf_t 
             WHERE fmcfent = g_enterprise AND fmcfdocno = g_fmce_m.fmcedocno
 
               AND fmcfseq = g_fmcf_d[l_ac].fmcfseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmce_m.fmcedocno
               LET gs_keys[2] = g_fmcf_d[g_detail_idx].fmcfseq
               CALL afmt015_insert_b('fmcf_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_fmcf_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmcf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt015_b_fill()
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
               LET gs_keys[01] = g_fmce_m.fmcedocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_fmcf_d_t.fmcfseq
 
            
               #刪除同層單身
               IF NOT afmt015_delete_b('fmcf_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt015_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt015_key_delete_b(gs_keys,'fmcf_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt015_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt015_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_fmcf_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmcf_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcfseq
            #add-point:BEFORE FIELD fmcfseq name="input.b.page1.fmcfseq"
            IF cl_null(g_fmcf_d[g_detail_idx].fmcfseq) OR g_fmcf_d[g_detail_idx].fmcfseq = 0 THEN
               SELECT MAX(fmcfseq) INTO g_fmcf_d[g_detail_idx].fmcfseq
                 FROM fmcf_t
                WHERE fmcfent = g_enterprise
                  AND fmcfdocno = g_fmce_m.fmcedocno

               IF cl_null(g_fmcf_d[g_detail_idx].fmcfseq) THEN
                  LET g_fmcf_d[g_detail_idx].fmcfseq = 1
               ELSE
                  LET g_fmcf_d[g_detail_idx].fmcfseq = g_fmcf_d[g_detail_idx].fmcfseq + 1
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcfseq
            
            #add-point:AFTER FIELD fmcfseq name="input.a.page1.fmcfseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmce_m.fmcedocno IS NOT NULL AND g_fmcf_d[g_detail_idx].fmcfseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmce_m.fmcedocno != g_fmcedocno_t OR g_fmcf_d[g_detail_idx].fmcfseq != g_fmcf_d_t.fmcfseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmcf_t WHERE "||"fmcfent = '" ||g_enterprise|| "' AND "||"fmcfdocno = '"||g_fmce_m.fmcedocno ||"' AND "|| "fmcfseq = '"||g_fmcf_d[g_detail_idx].fmcfseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcfseq
            #add-point:ON CHANGE fmcfseq name="input.g.page1.fmcfseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcf007
            
            #add-point:AFTER FIELD fmcf007 name="input.a.page1.fmcf007"
            IF NOT cl_null(g_fmcf_d[l_ac].fmcf007) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmcf_d[l_ac].fmcf007

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_42") THEN
                  #檢查成功時後續處理
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM ooef_t
                   WHERE ooefent = g_enterprise AND ooef017 = g_fmce_m.fmcecomp
                     AND ooef001 = g_fmcf_d[l_ac].fmcf007
                  IF l_n = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmcf_d[l_ac].fmcf007
                     LET g_errparam.code   = "afm-00138" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmcf_d[l_ac].fmcf007
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmcf_d[l_ac].fmcf007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmcf_d[l_ac].fmcf007_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcf007
            #add-point:BEFORE FIELD fmcf007 name="input.b.page1.fmcf007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcf007
            #add-point:ON CHANGE fmcf007 name="input.g.page1.fmcf007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcf001
            
            #add-point:AFTER FIELD fmcf001 name="input.a.page1.fmcf001"
            IF NOT cl_null(g_fmcf_d[l_ac].fmcf001) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmcf_d[l_ac].fmcf001
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afm-00140:sub-01302|afmi010|",cl_get_progname("afmi010",g_lang,"2"),"|:EXEPROGafmi010"
               #160318-00025#6--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_fmaa001") THEN
                  #檢查成功時後續處理

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmcf_d[l_ac].fmcf001
            CALL ap_ref_array2(g_ref_fields,"SELECT fmaal003 FROM fmaal_t WHERE fmaalent='"||g_enterprise||"' AND fmaal001=? AND fmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmcf_d[l_ac].fmcf001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmcf_d[l_ac].fmcf001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcf001
            #add-point:BEFORE FIELD fmcf001 name="input.b.page1.fmcf001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcf001
            #add-point:ON CHANGE fmcf001 name="input.g.page1.fmcf001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcf002
            
            #add-point:AFTER FIELD fmcf002 name="input.a.page1.fmcf002"
            IF NOT cl_null(g_fmcf_d[l_ac].fmcf002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmcf_d[l_ac].fmcf002
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
               #160318-00025#6--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmcf_d[l_ac].fmcf002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmcf_d[l_ac].fmcf002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmcf_d[l_ac].fmcf002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcf002
            #add-point:BEFORE FIELD fmcf002 name="input.b.page1.fmcf002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcf002
            #add-point:ON CHANGE fmcf002 name="input.g.page1.fmcf002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcf003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmcf_d[l_ac].fmcf003,"0","0","","","azz-00079",1) THEN
               NEXT FIELD fmcf003
            END IF 
 
 
 
            #add-point:AFTER FIELD fmcf003 name="input.a.page1.fmcf003"
            IF NOT cl_null(g_fmcf_d[l_ac].fmcf003) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcf003
            #add-point:BEFORE FIELD fmcf003 name="input.b.page1.fmcf003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcf003
            #add-point:ON CHANGE fmcf003 name="input.g.page1.fmcf003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcf004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmcf_d[l_ac].fmcf004,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmcf004
            END IF 
 
 
 
            #add-point:AFTER FIELD fmcf004 name="input.a.page1.fmcf004"
            IF NOT cl_null(g_fmcf_d[l_ac].fmcf004) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcf004
            #add-point:BEFORE FIELD fmcf004 name="input.b.page1.fmcf004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcf004
            #add-point:ON CHANGE fmcf004 name="input.g.page1.fmcf004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcf005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmcf_d[l_ac].fmcf005,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmcf005
            END IF 
 
 
 
            #add-point:AFTER FIELD fmcf005 name="input.a.page1.fmcf005"
            IF NOT cl_null(g_fmcf_d[l_ac].fmcf005) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcf005
            #add-point:BEFORE FIELD fmcf005 name="input.b.page1.fmcf005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcf005
            #add-point:ON CHANGE fmcf005 name="input.g.page1.fmcf005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcf006
            #add-point:BEFORE FIELD fmcf006 name="input.b.page1.fmcf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcf006
            
            #add-point:AFTER FIELD fmcf006 name="input.a.page1.fmcf006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcf006
            #add-point:ON CHANGE fmcf006 name="input.g.page1.fmcf006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.fmcfseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcfseq
            #add-point:ON ACTION controlp INFIELD fmcfseq name="input.c.page1.fmcfseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcf007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcf007
            #add-point:ON ACTION controlp INFIELD fmcf007 name="input.c.page1.fmcf007"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmcf_d[l_ac].fmcf007             #給予default值
            LET g_qryparam.default2 = "" #g_fmcf_d[l_ac].ooef001 #组织编号
            #LET g_qryparam.where = " ooef206 = 'Y' AND ooef017 = '",g_fmce_m.fmcecomp,"'"   #161006-00005#12   mark
            LET g_qryparam.where = " ooef017 = '",g_fmce_m.fmcecomp,"'"                      #161006-00005#12   add
            #給予arg
            LET g_qryparam.arg1 = "" #


            #CALL q_ooef001()     #161006-00005#12   mark                    
            CALL q_ooef001_33()   #161006-00005#12   add

            LET g_fmcf_d[l_ac].fmcf007 = g_qryparam.return1    
            LET g_qryparam.where = ""            
            #LET g_fmcf_d[l_ac].ooef001 = g_qryparam.return2 
            LET g_fmcf_d[l_ac].fmcf007_desc = s_desc_get_department_desc(g_fmcf_d[l_ac].fmcf007)
            DISPLAY g_fmcf_d[l_ac].fmcf007 TO fmcf007              #
            #DISPLAY g_fmcf_d[l_ac].ooef001 TO ooef001 #组织编号
            NEXT FIELD fmcf007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcf001
            #add-point:ON ACTION controlp INFIELD fmcf001 name="input.c.page1.fmcf001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmcf_d[l_ac].fmcf001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_fmaa001_1()                                #呼叫開窗

            LET g_fmcf_d[l_ac].fmcf001 = g_qryparam.return1            
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmcf_d[l_ac].fmcf001
            CALL ap_ref_array2(g_ref_fields,"SELECT fmaal003 FROM fmaal_t WHERE fmaalent='"||g_enterprise||"' AND fmaal001=? AND fmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmcf_d[l_ac].fmcf001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmcf_d[l_ac].fmcf001_desc 
            DISPLAY g_fmcf_d[l_ac].fmcf001 TO fmcf001              #

            NEXT FIELD fmcf001                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcf002
            #add-point:ON ACTION controlp INFIELD fmcf002 name="input.c.page1.fmcf002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmcf_d[l_ac].fmcf002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooai001()                                #呼叫開窗

            LET g_fmcf_d[l_ac].fmcf002 = g_qryparam.return1   
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmcf_d[l_ac].fmcf002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmcf_d[l_ac].fmcf002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmcf_d[l_ac].fmcf002_desc            

            DISPLAY g_fmcf_d[l_ac].fmcf002 TO fmcf002              #

            NEXT FIELD fmcf002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcf003
            #add-point:ON ACTION controlp INFIELD fmcf003 name="input.c.page1.fmcf003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcf004
            #add-point:ON ACTION controlp INFIELD fmcf004 name="input.c.page1.fmcf004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcf005
            #add-point:ON ACTION controlp INFIELD fmcf005 name="input.c.page1.fmcf005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmcf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcf006
            #add-point:ON ACTION controlp INFIELD fmcf006 name="input.c.page1.fmcf006"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fmcf_d[l_ac].* = g_fmcf_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt015_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_fmcf_d[l_ac].fmcfseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_fmcf_d[l_ac].* = g_fmcf_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL afmt015_fmcf_t_mask_restore('restore_mask_o')
      
               UPDATE fmcf_t SET (fmcfdocno,fmcfseq,fmcf007,fmcf001,fmcf002,fmcf003,fmcf004,fmcf005, 
                   fmcf006) = (g_fmce_m.fmcedocno,g_fmcf_d[l_ac].fmcfseq,g_fmcf_d[l_ac].fmcf007,g_fmcf_d[l_ac].fmcf001, 
                   g_fmcf_d[l_ac].fmcf002,g_fmcf_d[l_ac].fmcf003,g_fmcf_d[l_ac].fmcf004,g_fmcf_d[l_ac].fmcf005, 
                   g_fmcf_d[l_ac].fmcf006)
                WHERE fmcfent = g_enterprise AND fmcfdocno = g_fmce_m.fmcedocno 
 
                  AND fmcfseq = g_fmcf_d_t.fmcfseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmcf_d[l_ac].* = g_fmcf_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmcf_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmcf_d[l_ac].* = g_fmcf_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmcf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmce_m.fmcedocno
               LET gs_keys_bak[1] = g_fmcedocno_t
               LET gs_keys[2] = g_fmcf_d[g_detail_idx].fmcfseq
               LET gs_keys_bak[2] = g_fmcf_d_t.fmcfseq
               CALL afmt015_update_b('fmcf_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL afmt015_fmcf_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_fmcf_d[g_detail_idx].fmcfseq = g_fmcf_d_t.fmcfseq 
 
                  ) THEN
                  LET gs_keys[01] = g_fmce_m.fmcedocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_fmcf_d_t.fmcfseq
 
                  CALL afmt015_key_update_b(gs_keys,'fmcf_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmce_m),util.JSON.stringify(g_fmcf_d_t)
               LET g_log2 = util.JSON.stringify(g_fmce_m),util.JSON.stringify(g_fmcf_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL afmt015_unlock_b("fmcf_t","'1'")
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
               LET g_fmcf_d[li_reproduce_target].* = g_fmcf_d[li_reproduce].*
 
               LET g_fmcf_d[li_reproduce_target].fmcfseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmcf_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmcf_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="afmt015.input.other" >}
      
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
            NEXT FIELD fmcedocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD fmcfseq
 
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
 
{<section id="afmt015.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION afmt015_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL afmt015_b_fill() #單身填充
      CALL afmt015_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afmt015_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_fmce_m_mask_o.* =  g_fmce_m.*
   CALL afmt015_fmce_t_mask()
   LET g_fmce_m_mask_n.* =  g_fmce_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fmce_m.fmcesite,g_fmce_m.fmcesite_desc,g_fmce_m.fmcecomp,g_fmce_m.fmcecomp_desc, 
       g_fmce_m.fmcedocno,g_fmce_m.fmcedocdt,g_fmce_m.fmcestus,g_fmce_m.fmceownid,g_fmce_m.fmceownid_desc, 
       g_fmce_m.fmceowndp,g_fmce_m.fmceowndp_desc,g_fmce_m.fmcecrtid,g_fmce_m.fmcecrtid_desc,g_fmce_m.fmcecrtdp, 
       g_fmce_m.fmcecrtdp_desc,g_fmce_m.fmcecrtdt,g_fmce_m.fmcemodid,g_fmce_m.fmcemodid_desc,g_fmce_m.fmcemoddt, 
       g_fmce_m.fmcecnfid,g_fmce_m.fmcecnfid_desc,g_fmce_m.fmcecnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmce_m.fmcestus 
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
   FOR l_ac = 1 TO g_fmcf_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL afmt015_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afmt015.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION afmt015_detail_show()
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
 
{<section id="afmt015.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afmt015_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE fmce_t.fmcedocno 
   DEFINE l_oldno     LIKE fmce_t.fmcedocno 
 
   DEFINE l_master    RECORD LIKE fmce_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE fmcf_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_fmce_m.fmcedocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_fmcedocno_t = g_fmce_m.fmcedocno
 
    
   LET g_fmce_m.fmcedocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmce_m.fmceownid = g_user
      LET g_fmce_m.fmceowndp = g_dept
      LET g_fmce_m.fmcecrtid = g_user
      LET g_fmce_m.fmcecrtdp = g_dept 
      LET g_fmce_m.fmcecrtdt = cl_get_current()
      LET g_fmce_m.fmcemodid = g_user
      LET g_fmce_m.fmcemoddt = cl_get_current()
      LET g_fmce_m.fmcestus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmce_m.fmcestus 
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
   
   
   CALL afmt015_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_fmce_m.* TO NULL
      INITIALIZE g_fmcf_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL afmt015_show()
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
   CALL afmt015_set_act_visible()   
   CALL afmt015_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fmcedocno_t = g_fmce_m.fmcedocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmceent = " ||g_enterprise|| " AND",
                      " fmcedocno = '", g_fmce_m.fmcedocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt015_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL afmt015_idx_chk()
   
   LET g_data_owner = g_fmce_m.fmceownid      
   LET g_data_dept  = g_fmce_m.fmceowndp
   
   #功能已完成,通報訊息中心
   CALL afmt015_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="afmt015.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION afmt015_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE fmcf_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE afmt015_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fmcf_t
    WHERE fmcfent = g_enterprise AND fmcfdocno = g_fmcedocno_t
 
    INTO TEMP afmt015_detail
 
   #將key修正為調整後   
   UPDATE afmt015_detail 
      #更新key欄位
      SET fmcfdocno = g_fmce_m.fmcedocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO fmcf_t SELECT * FROM afmt015_detail
   
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
   DROP TABLE afmt015_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_fmcedocno_t = g_fmce_m.fmcedocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="afmt015.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afmt015_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_n      LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_fmce_m.fmcedocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN afmt015_cl USING g_enterprise,g_fmce_m.fmcedocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt015_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afmt015_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt015_master_referesh USING g_fmce_m.fmcedocno INTO g_fmce_m.fmcesite,g_fmce_m.fmcecomp, 
       g_fmce_m.fmcedocno,g_fmce_m.fmcedocdt,g_fmce_m.fmcestus,g_fmce_m.fmceownid,g_fmce_m.fmceowndp, 
       g_fmce_m.fmcecrtid,g_fmce_m.fmcecrtdp,g_fmce_m.fmcecrtdt,g_fmce_m.fmcemodid,g_fmce_m.fmcemoddt, 
       g_fmce_m.fmcecnfid,g_fmce_m.fmcecnfdt,g_fmce_m.fmcesite_desc,g_fmce_m.fmcecomp_desc,g_fmce_m.fmceownid_desc, 
       g_fmce_m.fmceowndp_desc,g_fmce_m.fmcecrtid_desc,g_fmce_m.fmcecrtdp_desc,g_fmce_m.fmcemodid_desc, 
       g_fmce_m.fmcecnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT afmt015_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmce_m_mask_o.* =  g_fmce_m.*
   CALL afmt015_fmce_t_mask()
   LET g_fmce_m_mask_n.* =  g_fmce_m.*
   
   CALL afmt015_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      IF g_fmce_m.fmcestus <> 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00052'
         LET g_errparam.extend = 'delete'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM fmai_t
       WHERE fmaient = g_enterprise AND fmai002 = g_fmce_m.fmcedocno
      IF l_n > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afm-00141'
         LET g_errparam.extend = g_fmce_m.fmcedocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afmt015_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_fmcedocno_t = g_fmce_m.fmcedocno
 
 
      DELETE FROM fmce_t
       WHERE fmceent = g_enterprise AND fmcedocno = g_fmce_m.fmcedocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_fmce_m.fmcedocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_fin_del_docno(g_glaald,g_fmce_m.fmcedocno,g_fmce_m.fmcedocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM fmcf_t
       WHERE fmcfent = g_enterprise AND fmcfdocno = g_fmce_m.fmcedocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmcf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_fmce_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE afmt015_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_fmcf_d.clear() 
 
     
      CALL afmt015_ui_browser_refresh()  
      #CALL afmt015_ui_headershow()  
      #CALL afmt015_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL afmt015_browser_fill("")
         CALL afmt015_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afmt015_cl
 
   #功能已完成,通報訊息中心
   CALL afmt015_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="afmt015.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmt015_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_fmcf_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF afmt015_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT fmcfseq,fmcf007,fmcf001,fmcf002,fmcf003,fmcf004,fmcf005,fmcf006 , 
             t1.ooefl003 ,t2.fmaal003 ,t3.ooail003 FROM fmcf_t",   
                     " INNER JOIN fmce_t ON fmceent = " ||g_enterprise|| " AND fmcedocno = fmcfdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=fmcf007 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN fmaal_t t2 ON t2.fmaalent="||g_enterprise||" AND t2.fmaal001=fmcf001 AND t2.fmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=fmcf002 AND t3.ooail002='"||g_dlang||"' ",
 
                     " WHERE fmcfent=? AND fmcfdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fmcf_t.fmcfseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt015_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR afmt015_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_fmce_m.fmcedocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_fmce_m.fmcedocno INTO g_fmcf_d[l_ac].fmcfseq,g_fmcf_d[l_ac].fmcf007, 
          g_fmcf_d[l_ac].fmcf001,g_fmcf_d[l_ac].fmcf002,g_fmcf_d[l_ac].fmcf003,g_fmcf_d[l_ac].fmcf004, 
          g_fmcf_d[l_ac].fmcf005,g_fmcf_d[l_ac].fmcf006,g_fmcf_d[l_ac].fmcf007_desc,g_fmcf_d[l_ac].fmcf001_desc, 
          g_fmcf_d[l_ac].fmcf002_desc   #(ver:78)
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
   
   CALL g_fmcf_d.deleteElement(g_fmcf_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE afmt015_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_fmcf_d.getLength()
      LET g_fmcf_d_mask_o[l_ac].* =  g_fmcf_d[l_ac].*
      CALL afmt015_fmcf_t_mask()
      LET g_fmcf_d_mask_n[l_ac].* =  g_fmcf_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="afmt015.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afmt015_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM fmcf_t
       WHERE fmcfent = g_enterprise AND
         fmcfdocno = ps_keys_bak[1] AND fmcfseq = ps_keys_bak[2]
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
         CALL g_fmcf_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt015.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afmt015_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO fmcf_t
                  (fmcfent,
                   fmcfdocno,
                   fmcfseq
                   ,fmcf007,fmcf001,fmcf002,fmcf003,fmcf004,fmcf005,fmcf006) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_fmcf_d[g_detail_idx].fmcf007,g_fmcf_d[g_detail_idx].fmcf001,g_fmcf_d[g_detail_idx].fmcf002, 
                       g_fmcf_d[g_detail_idx].fmcf003,g_fmcf_d[g_detail_idx].fmcf004,g_fmcf_d[g_detail_idx].fmcf005, 
                       g_fmcf_d[g_detail_idx].fmcf006)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmcf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_fmcf_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="afmt015.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afmt015_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fmcf_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL afmt015_fmcf_t_mask_restore('restore_mask_o')
               
      UPDATE fmcf_t 
         SET (fmcfdocno,
              fmcfseq
              ,fmcf007,fmcf001,fmcf002,fmcf003,fmcf004,fmcf005,fmcf006) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_fmcf_d[g_detail_idx].fmcf007,g_fmcf_d[g_detail_idx].fmcf001,g_fmcf_d[g_detail_idx].fmcf002, 
                  g_fmcf_d[g_detail_idx].fmcf003,g_fmcf_d[g_detail_idx].fmcf004,g_fmcf_d[g_detail_idx].fmcf005, 
                  g_fmcf_d[g_detail_idx].fmcf006) 
         WHERE fmcfent = g_enterprise AND fmcfdocno = ps_keys_bak[1] AND fmcfseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmcf_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmcf_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afmt015_fmcf_t_mask_restore('restore_mask_n')
               
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
 
{<section id="afmt015.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION afmt015_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="afmt015.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION afmt015_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="afmt015.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afmt015_lock_b(ps_table,ps_page)
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
   #CALL afmt015_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "fmcf_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afmt015_bcl USING g_enterprise,
                                       g_fmce_m.fmcedocno,g_fmcf_d[g_detail_idx].fmcfseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afmt015_bcl:",SQLERRMESSAGE 
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
 
{<section id="afmt015.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afmt015_unlock_b(ps_table,ps_page)
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
      CLOSE afmt015_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="afmt015.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afmt015_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("fmcedocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("fmcedocno",TRUE)
      CALL cl_set_comp_entry("fmcedocdt",TRUE)
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
 
{<section id="afmt015.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afmt015_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_slip     LIKE type_t.chr10
   DEFINE l_dfin0033  LIKE type_t.chr80
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   CALL cl_set_comp_entry("fmcedocdt",TRUE)
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("fmcedocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("fmcedocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("fmcedocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT cl_null(g_fmce_m.fmcedocno) THEN
      #获取单别
      CALL s_aooi200_fin_get_slip(g_fmce_m.fmcedocno) RETURNING l_success,l_slip
      #是否可改日期
      CALL s_fin_get_doc_para(g_glaald,g_fmce_m.fmcecomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      IF l_dfin0033 = "N"  THEN
         CALL cl_set_comp_entry("fmcedocdt",FALSE)
      ELSE
         CALL cl_set_comp_entry("fmcedocdt",TRUE)
      END IF
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt015.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afmt015_set_entry_b(p_cmd)
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
 
{<section id="afmt015.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afmt015_set_no_entry_b(p_cmd)
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
 
{<section id="afmt015.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afmt015_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible('modify,modify_detail,delete',TRUE)    #161207-00032#1 Add
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt015.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afmt015_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #161207-00032#1 Mark ---(S)---
  #IF g_fmce_m.fmcestus <> 'N' THEN
  #   CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
  #END IF
   #161207-00032#1 Mark ---(E)---
   #161207-00032#1 Add  ---(S)---
   IF g_fmce_m.fmcestus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #161207-00032#1 Add  ---(E)---
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt015.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION afmt015_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt015.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION afmt015_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt015.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afmt015_default_search()
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
      LET ls_wc = ls_wc, " fmcedocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "fmce_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "fmcf_t" 
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
 
{<section id="afmt015.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afmt015_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_today        DATETIME YEAR TO SECOND
   DEFINE l_n            LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5   #161026-00023#1 Add
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_fmce_m.fmcedocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN afmt015_cl USING g_enterprise,g_fmce_m.fmcedocno
   IF STATUS THEN
      CLOSE afmt015_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt015_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afmt015_master_referesh USING g_fmce_m.fmcedocno INTO g_fmce_m.fmcesite,g_fmce_m.fmcecomp, 
       g_fmce_m.fmcedocno,g_fmce_m.fmcedocdt,g_fmce_m.fmcestus,g_fmce_m.fmceownid,g_fmce_m.fmceowndp, 
       g_fmce_m.fmcecrtid,g_fmce_m.fmcecrtdp,g_fmce_m.fmcecrtdt,g_fmce_m.fmcemodid,g_fmce_m.fmcemoddt, 
       g_fmce_m.fmcecnfid,g_fmce_m.fmcecnfdt,g_fmce_m.fmcesite_desc,g_fmce_m.fmcecomp_desc,g_fmce_m.fmceownid_desc, 
       g_fmce_m.fmceowndp_desc,g_fmce_m.fmcecrtid_desc,g_fmce_m.fmcecrtdp_desc,g_fmce_m.fmcemodid_desc, 
       g_fmce_m.fmcecnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT afmt015_action_chk() THEN
      CLOSE afmt015_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmce_m.fmcesite,g_fmce_m.fmcesite_desc,g_fmce_m.fmcecomp,g_fmce_m.fmcecomp_desc, 
       g_fmce_m.fmcedocno,g_fmce_m.fmcedocdt,g_fmce_m.fmcestus,g_fmce_m.fmceownid,g_fmce_m.fmceownid_desc, 
       g_fmce_m.fmceowndp,g_fmce_m.fmceowndp_desc,g_fmce_m.fmcecrtid,g_fmce_m.fmcecrtid_desc,g_fmce_m.fmcecrtdp, 
       g_fmce_m.fmcecrtdp_desc,g_fmce_m.fmcecrtdt,g_fmce_m.fmcemodid,g_fmce_m.fmcemodid_desc,g_fmce_m.fmcemoddt, 
       g_fmce_m.fmcecnfid,g_fmce_m.fmcecnfid_desc,g_fmce_m.fmcecnfdt
 
   CASE g_fmce_m.fmcestus
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
         CASE g_fmce_m.fmcestus
            
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

      CASE g_fmce_m.fmcestus
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
            CALL cl_set_act_visible("invalid,confirmed,void",FALSE)

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
            IF NOT afmt015_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt015_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT afmt015_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt015_cl
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
      g_fmce_m.fmcestus = lc_state OR cl_null(lc_state) THEN
      CLOSE afmt015_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_today  = cl_get_current()
   CASE lc_state
      WHEN 'Y'
         #161026-00023#1 Mark ---(S)---
        ##此資料已作廢,不可再異動
        #IF g_fmce_m.fmcestus = 'X' THEN
        #   INITIALIZE g_errparam TO NULL
        #   LET g_errparam.code = 'afm-00029'
        #   LET g_errparam.extend = g_fmce_m.fmcedocno
        #   LET g_errparam.popup = TRUE
        #   CALL cl_err()
        #   CALL s_transaction_end('N','0')
        #   RETURN
        #END IF
        ##檢查單身是否有資料
        #LET l_n = 0
        #SELECT count(*) INTO l_n
        #  FROM fmcf_t
        # WHERE fmcfent = g_enterprise
        #   AND fmcfdocno = g_fmce_m.fmcedocno
        #IF l_n = 0 THEN
        #   INITIALIZE g_errparam TO NULL
        #   LET g_errparam.code = 'aec-00020'
        #   LET g_errparam.extend = g_fmce_m.fmcedocno
        #   LET g_errparam.popup = TRUE
        #   CALL cl_err()
        #   CALL s_transaction_end('N','0')
        #   RETURN
        #END IF
        #
        #UPDATE fmce_t SET fmcecnfid = g_user,
        #                  fmcecnfdt = l_today   
        # WHERE fmceent = g_enterprise AND fmcedocno = g_fmce_m.fmcedocno
         #161026-00023#1 Mark ---(E)---
         #161026-00023#1 Add  ---(S)---
         CALL cl_err_collect_init()
         LET l_success = TRUE
         IF s_afmt015_conf_chk(g_fmce_m.fmcedocno) THEN
            IF cl_ask_confirm('aim-00108') THEN
               CALL s_afmt015_conf_upd(g_fmce_m.fmcedocno) RETURNING l_success
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
         #161026-00023#1 Add  ---(E)---
      WHEN 'N'
         #若存在于融资申请审核明细档，不可取消审核
         LET l_n = 0
         SELECT COUNT(*) INTO l_n FROM fmai_t
          WHERE fmaient = g_enterprise AND fmai002 = g_fmce_m.fmcedocno
         IF l_n > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'afm-00141'
            LET g_errparam.extend = g_fmce_m.fmcedocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            RETURN
         END IF
         UPDATE fmce_t SET fmcecnfid = '',
                           fmcecnfdt = ''  
          WHERE fmceent = g_enterprise AND fmcedocno = g_fmce_m.fmcedocno
      WHEN 'X'
         #此資料已確認,不可作廢
         IF g_fmce_m.fmcestus = 'Y' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'anm-00045'
            LET g_errparam.extend = g_fmce_m.fmcedocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            RETURN
         END IF
   END CASE
   #end add-point
   
   LET g_fmce_m.fmcemodid = g_user
   LET g_fmce_m.fmcemoddt = cl_get_current()
   LET g_fmce_m.fmcestus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE fmce_t 
      SET (fmcestus,fmcemodid,fmcemoddt) 
        = (g_fmce_m.fmcestus,g_fmce_m.fmcemodid,g_fmce_m.fmcemoddt)     
    WHERE fmceent = g_enterprise AND fmcedocno = g_fmce_m.fmcedocno
 
    
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
      EXECUTE afmt015_master_referesh USING g_fmce_m.fmcedocno INTO g_fmce_m.fmcesite,g_fmce_m.fmcecomp, 
          g_fmce_m.fmcedocno,g_fmce_m.fmcedocdt,g_fmce_m.fmcestus,g_fmce_m.fmceownid,g_fmce_m.fmceowndp, 
          g_fmce_m.fmcecrtid,g_fmce_m.fmcecrtdp,g_fmce_m.fmcecrtdt,g_fmce_m.fmcemodid,g_fmce_m.fmcemoddt, 
          g_fmce_m.fmcecnfid,g_fmce_m.fmcecnfdt,g_fmce_m.fmcesite_desc,g_fmce_m.fmcecomp_desc,g_fmce_m.fmceownid_desc, 
          g_fmce_m.fmceowndp_desc,g_fmce_m.fmcecrtid_desc,g_fmce_m.fmcecrtdp_desc,g_fmce_m.fmcemodid_desc, 
          g_fmce_m.fmcecnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_fmce_m.fmcesite,g_fmce_m.fmcesite_desc,g_fmce_m.fmcecomp,g_fmce_m.fmcecomp_desc, 
          g_fmce_m.fmcedocno,g_fmce_m.fmcedocdt,g_fmce_m.fmcestus,g_fmce_m.fmceownid,g_fmce_m.fmceownid_desc, 
          g_fmce_m.fmceowndp,g_fmce_m.fmceowndp_desc,g_fmce_m.fmcecrtid,g_fmce_m.fmcecrtid_desc,g_fmce_m.fmcecrtdp, 
          g_fmce_m.fmcecrtdp_desc,g_fmce_m.fmcecrtdt,g_fmce_m.fmcemodid,g_fmce_m.fmcemodid_desc,g_fmce_m.fmcemoddt, 
          g_fmce_m.fmcecnfid,g_fmce_m.fmcecnfid_desc,g_fmce_m.fmcecnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE afmt015_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt015_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt015.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION afmt015_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_fmcf_d.getLength() THEN
         LET g_detail_idx = g_fmcf_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmcf_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmcf_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afmt015.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afmt015_b_fill2(pi_idx)
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
   
   CALL afmt015_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="afmt015.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION afmt015_fill_chk(ps_idx)
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
 
{<section id="afmt015.status_show" >}
PRIVATE FUNCTION afmt015_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt015.mask_functions" >}
&include "erp/afm/afmt015_mask.4gl"
 
{</section>}
 
{<section id="afmt015.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION afmt015_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success         LIKE type_t.num5   #161026-00023#1 Add
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL afmt015_show()
   CALL afmt015_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #161026-00023#1 Add  ---(S)---
   CALL s_afmt015_conf_chk(g_fmce_m.fmcedocno) RETURNING l_success
   IF NOT l_success THEN
      CLOSE afmt015_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #161026-00023#1 Add  ---(E)---
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_fmce_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_fmcf_d))
 
 
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
   #CALL afmt015_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL afmt015_ui_headershow()
   CALL afmt015_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION afmt015_draw_out()
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
   CALL afmt015_ui_headershow()  
   CALL afmt015_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="afmt015.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afmt015_set_pk_array()
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
   LET g_pk_array[1].values = g_fmce_m.fmcedocno
   LET g_pk_array[1].column = 'fmcedocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt015.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="afmt015.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afmt015_msgcentre_notify(lc_state)
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
   CALL afmt015_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fmce_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt015.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afmt015_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#12 By 07900  --add--s--
   SELECT fmcestus INTO g_fmce_m.fmcestus
     FROM fmce_t
    WHERE fmceent = g_enterprise
      AND fmcedocno = g_fmce_m.fmcedocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_fmce_m.fmcestus
        
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
        LET g_errparam.extend = g_fmce_m.fmcedocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL afmt015_set_act_visible()
        CALL afmt015_set_act_no_visible()
        CALL afmt015_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#12 By 07900  --add--e--
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt015.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 獲取法人主帳套資料
# Memo...........:
# Usage..........: CALL afmt015_fmcecomp_ref()
# Date & Author..: 2015/11/03 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt015_fmcecomp_ref()
   
   SELECT glaald,glaa003,glaa024 INTO g_glaald,g_glaa003,g_glaa024 FROM glaa_t
    WHERE glaaent = g_enterprise AND glaacomp = g_fmce_m.fmcecomp
      AND glaa014 = 'Y'
      
END FUNCTION

 
{</section>}
 
