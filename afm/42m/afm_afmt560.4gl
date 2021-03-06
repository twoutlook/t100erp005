#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt560.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2015-12-21 14:11:03), PR版次:0012(2017-01-11 19:32:43)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000061
#+ Filename...: afmt560
#+ Description: 計提投資收益維護
#+ Creator....: 02097(2015-05-19 15:03:05)
#+ Modifier...: 02159 -SD/PR- 08729
 
{</section>}
 
{<section id="afmt560.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150401-00001#13  150716  By RayHuang statechange段問題修正
#150820-00011#11  150909  By Reanna   開放本期計提金額欄位修改
#151029-00012#10  151030  By Reanna   1.增加匯率(fmmt013)、本幣欄位：計提金額(fmmt014)/利息調整(fmmt015)/投資收益(fmmt016)
#                                     2.匯率取法及本幣金額計算方式同於afmt565(批次產生時邏輯)
#151117-00001#4   151124  By albireo  增加fmmn單身顯示,增加fmmt欄位(已收利息,已收本幣,收款類型)
#160321-00016#27  160324  By Jessy    修正azzi920重複定義之錯誤訊息
#160318-00025#44  160426  By 07959    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160818-00017#13 2016/08/23 By 07900  删除修改未重新判断状态码
#160822-00012#2   160905  By 08729    新舊值處理
#161006-00005#34  161028  By 08732    組織類型與職能開窗調整
#160822-00012#4   161031  By 08732    新舊值調整
#161026-00023#12  161108  By 08732    AFM模組,增加BPM簽核功能
#161104-00046#21  170109  By 08729    單別預設值;資料依照單別user dept權限過濾單號
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
PRIVATE type type_g_fmms_m        RECORD
       fmmscomp LIKE fmms_t.fmmscomp, 
   fmmscomp_desc LIKE type_t.chr80, 
   fmmsdocno LIKE fmms_t.fmmsdocno, 
   fmmsdocno_desc LIKE type_t.chr80, 
   fmms001 LIKE fmms_t.fmms001, 
   fmms002 LIKE fmms_t.fmms002, 
   fmmsstus LIKE fmms_t.fmmsstus, 
   fmmsownid LIKE fmms_t.fmmsownid, 
   fmmsownid_desc LIKE type_t.chr80, 
   fmmsowndp LIKE fmms_t.fmmsowndp, 
   fmmsowndp_desc LIKE type_t.chr80, 
   fmmscrtid LIKE fmms_t.fmmscrtid, 
   fmmscrtid_desc LIKE type_t.chr80, 
   fmmscrtdp LIKE fmms_t.fmmscrtdp, 
   fmmscrtdp_desc LIKE type_t.chr80, 
   fmmscrtdt LIKE fmms_t.fmmscrtdt, 
   fmmsmodid LIKE fmms_t.fmmsmodid, 
   fmmsmodid_desc LIKE type_t.chr80, 
   fmmsmoddt LIKE fmms_t.fmmsmoddt, 
   fmmscnfid LIKE fmms_t.fmmscnfid, 
   fmmscnfid_desc LIKE type_t.chr80, 
   fmmscnfdt LIKE fmms_t.fmmscnfdt, 
   fmmspstid LIKE fmms_t.fmmspstid, 
   fmmspstid_desc LIKE type_t.chr80, 
   fmmspstdt LIKE fmms_t.fmmspstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_fmmt_d        RECORD
       fmmtseq LIKE fmmt_t.fmmtseq, 
   fmmt001 LIKE fmmt_t.fmmt001, 
   fmmt001_desc LIKE type_t.chr500, 
   fmmt002 LIKE fmmt_t.fmmt002, 
   fmmt003 LIKE fmmt_t.fmmt003, 
   fmmt017 LIKE fmmt_t.fmmt017, 
   fmmt004 LIKE fmmt_t.fmmt004, 
   fmmt005 LIKE fmmt_t.fmmt005, 
   fmmt006 LIKE fmmt_t.fmmt006, 
   fmmt007 LIKE fmmt_t.fmmt007, 
   fmmt008 LIKE fmmt_t.fmmt008, 
   fmmt009 LIKE fmmt_t.fmmt009, 
   fmmt010 LIKE fmmt_t.fmmt010, 
   fmmt011 LIKE fmmt_t.fmmt011, 
   fmmt012 LIKE fmmt_t.fmmt012, 
   fmmt013 LIKE fmmt_t.fmmt013, 
   fmmt014 LIKE fmmt_t.fmmt014, 
   fmmt015 LIKE fmmt_t.fmmt015, 
   fmmt016 LIKE fmmt_t.fmmt016, 
   fmmt018 LIKE fmmt_t.fmmt018, 
   fmmt019 LIKE fmmt_t.fmmt019
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_fmmsdocno LIKE fmms_t.fmmsdocno,
      b_fmmscomp LIKE fmms_t.fmmscomp
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaald         LIKE glaa_t.glaald
DEFINE g_glaa001        LIKE glaa_t.glaa001   #151029-00012#10
DEFINE g_glaa003        LIKE glaa_t.glaa003
DEFINE g_glaa024        LIKE glaa_t.glaa024
DEFINE g_glaa026        LIKE glaa_t.glaa026
DEFINE g_accdate_s      LIKE glav_t.glav004   #當期起始日
DEFINE g_accdate_e      LIKE glav_t.glav004   #當期起始日
DEFINE g_glav006        LIKE glav_t.glav006
DEFINE g_ar             DYNAMIC ARRAY OF RECORD
                  chr   LIKE type_t.chr100,
                  dat   LIKE type_t.dat,
                  num   LIKE type_t.num5
                    END RECORD
#151117-00001#4-----s
 TYPE type_g_fmmt2_d        RECORD
                    fmmn001        LIKE fmmn_t.fmmn001,
                    fmmn002        LIKE fmmn_t.fmmn002,
                    fmmn003        LIKE fmmn_t.fmmn003,
                    fmmn004        LIKE fmmn_t.fmmn004,
                    fmmn005        LIKE fmmn_t.fmmn005,
                    fmmn006        LIKE fmmn_t.fmmn006
                                   END RECORD
DEFINE g_fmmt2_d          DYNAMIC ARRAY OF type_g_fmmt2_d
DEFINE g_fmmt2_d_t        type_g_fmmt2_d
DEFINE g_fmmt2_d_o        type_g_fmmt2_d 
DEFINE g_rec_b2           LIKE type_t.num10
#151117-00001#4-----e
DEFINE g_wc_cs_comp      STRING   #161006-00005#34   add
DEFINE g_user_dept_wc             STRING      #161104-00046#21
DEFINE g_user_dept_wc_q           STRING      #161104-00046#21
DEFINE g_user_slip_wc             STRING      #161104-00046#21
#end add-point
       
#模組變數(Module Variables)
DEFINE g_fmms_m          type_g_fmms_m
DEFINE g_fmms_m_t        type_g_fmms_m
DEFINE g_fmms_m_o        type_g_fmms_m
DEFINE g_fmms_m_mask_o   type_g_fmms_m #轉換遮罩前資料
DEFINE g_fmms_m_mask_n   type_g_fmms_m #轉換遮罩後資料
 
   DEFINE g_fmmsdocno_t LIKE fmms_t.fmmsdocno
 
 
DEFINE g_fmmt_d          DYNAMIC ARRAY OF type_g_fmmt_d
DEFINE g_fmmt_d_t        type_g_fmmt_d
DEFINE g_fmmt_d_o        type_g_fmmt_d
DEFINE g_fmmt_d_mask_o   DYNAMIC ARRAY OF type_g_fmmt_d #轉換遮罩前資料
DEFINE g_fmmt_d_mask_n   DYNAMIC ARRAY OF type_g_fmmt_d #轉換遮罩後資料
 
 
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
 
{<section id="afmt560.main" >}
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
   CALL s_aooi200def_create('','g_fmms_m','','','','','','')RETURNING g_sub_success
   
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('fmmscomp','','fmmsent','fmmsdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#21-----e
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT fmmscomp,'',fmmsdocno,'',fmms001,fmms002,fmmsstus,fmmsownid,'',fmmsowndp, 
       '',fmmscrtid,'',fmmscrtdp,'',fmmscrtdt,fmmsmodid,'',fmmsmoddt,fmmscnfid,'',fmmscnfdt,fmmspstid, 
       '',fmmspstdt", 
                      " FROM fmms_t",
                      " WHERE fmmsent= ? AND fmmsdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt560_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fmmscomp,t0.fmmsdocno,t0.fmms001,t0.fmms002,t0.fmmsstus,t0.fmmsownid, 
       t0.fmmsowndp,t0.fmmscrtid,t0.fmmscrtdp,t0.fmmscrtdt,t0.fmmsmodid,t0.fmmsmoddt,t0.fmmscnfid,t0.fmmscnfdt, 
       t0.fmmspstid,t0.fmmspstdt,t1.ooefl004 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 , 
       t7.ooag011 ,t8.ooag011",
               " FROM fmms_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.fmmscomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.fmmsownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.fmmsowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.fmmscrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.fmmscrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.fmmsmodid  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.fmmscnfid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.fmmspstid  ",
 
               " WHERE t0.fmmsent = " ||g_enterprise|| " AND t0.fmmsdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afmt560_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmt560 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmt560_init()   
 
      #進入選單 Menu (="N")
      CALL afmt560_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afmt560
      
   END IF 
   
   CLOSE afmt560_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afmt560.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afmt560_init()
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
      CALL cl_set_combo_scc_part('fmmsstus','13','N,Y,X,A,D,R,W')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('fmmt009','8801')
   CALL cl_set_combo_scc('fmmt017','8807')   #151117-00001#4
   
   #161006-00005#34   add---s
   CALL s_fin_create_account_center_tmp() 
   CALL s_fin_azzi800_sons_query(g_today) 
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   #161006-00005#34   add---e
   #end add-point
   
   #初始化搜尋條件
   CALL afmt560_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="afmt560.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION afmt560_ui_dialog()
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
            CALL afmt560_insert()
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
         INITIALIZE g_fmms_m.* TO NULL
         CALL g_fmmt_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afmt560_init()
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
               
               CALL afmt560_fetch('') # reload data
               LET l_ac = 1
               CALL afmt560_ui_detailshow() #Setting the current row 
         
               CALL afmt560_idx_chk()
               #NEXT FIELD fmmtseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_fmmt_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt560_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               CALL afmt560_b_fill3(l_ac)
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
               CALL afmt560_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_fmmt002
                  LET g_action_choice="prog_fmmt002"
                  IF cl_auth_chk_act("prog_fmmt002") THEN
                     
                     #add-point:ON ACTION prog_fmmt002 name="menu.detail_show.page1_sub.prog_fmmt002"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'afmt530'
               LET la_param.param[1] = g_fmmt_d[l_ac].fmmt002

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_fmmt2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2) #page1  
    
            BEFORE ROW
               ##顯示單身筆數
               #CALL afmt560_idx_chk()
               ##確定當下選擇的筆數
               #LET l_ac = DIALOG.getCurrentRow("s_detail1")
               #LET g_detail_idx = l_ac
               #LET g_detail_idx_list[1] = l_ac
               #CALL g_idx_group.addAttribute("'1',",l_ac)
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL afmt560_browser_fill("")
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
               CALL afmt560_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL afmt560_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL afmt560_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL afmt560_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL afmt560_set_act_visible()   
            CALL afmt560_set_act_no_visible()
            IF NOT (g_fmms_m.fmmsdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " fmmsent = " ||g_enterprise|| " AND",
                                  " fmmsdocno = '", g_fmms_m.fmmsdocno, "' "
 
               #填到對應位置
               CALL afmt560_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "fmms_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmmt_t" 
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
               CALL afmt560_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "fmms_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmmt_t" 
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
                  CALL afmt560_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afmt560_fetch("F")
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
               CALL afmt560_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL afmt560_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt560_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL afmt560_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt560_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL afmt560_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt560_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL afmt560_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt560_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL afmt560_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt560_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_fmmt_d)
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
               NEXT FIELD fmmtseq
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
               CALL afmt560_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afmt560_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afmt560_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afmt560_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = " fmmsent = ",g_enterprise," AND fmmsdocno = '",g_fmms_m.fmmsdocno,"'"   #151217-00011#3 20151218 By sakura
               #END add-point
               &include "erp/afm/afmt560_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = " fmmsent = ",g_enterprise," AND fmmsdocno = '",g_fmms_m.fmmsdocno,"'"   #151217-00011#3 20151218 By sakura
               #END add-point
               &include "erp/afm/afmt560_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL afmt560_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afmt560_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afmt560_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmt560_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmt560_set_pk_array()
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
 
{<section id="afmt560.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION afmt560_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT fmmsdocno ",
                      " FROM fmms_t ",
                      " ",
                      " LEFT JOIN fmmt_t ON fmmtent = fmmsent AND fmmsdocno = fmmtdocno ", "  ",
                      #add-point:browser_fill段sql(fmmt_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE fmmsent = " ||g_enterprise|| " AND fmmtent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("fmms_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT fmmsdocno ",
                      " FROM fmms_t ", 
                      "  ",
                      "  ",
                      " WHERE fmmsent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("fmms_t")
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
      INITIALIZE g_fmms_m.* TO NULL
      CALL g_fmmt_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.fmmsdocno,t0.fmmscomp Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fmmsstus,t0.fmmsdocno,t0.fmmscomp ",
                  " FROM fmms_t t0",
                  "  ",
                  "  LEFT JOIN fmmt_t ON fmmtent = fmmsent AND fmmsdocno = fmmtdocno ", "  ", 
                  #add-point:browser_fill段sql(fmmt_t1) name="browser_fill.join.fmmt_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.fmmsent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("fmms_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fmmsstus,t0.fmmsdocno,t0.fmmscomp ",
                  " FROM fmms_t t0",
                  "  ",
                  
                  " WHERE t0.fmmsent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("fmms_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY fmmsdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"fmms_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_fmmsdocno,g_browser[g_cnt].b_fmmscomp 
 
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
         CALL afmt560_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_fmmsdocno) THEN
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
 
{<section id="afmt560.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION afmt560_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_fmms_m.fmmsdocno = g_browser[g_current_idx].b_fmmsdocno   
 
   EXECUTE afmt560_master_referesh USING g_fmms_m.fmmsdocno INTO g_fmms_m.fmmscomp,g_fmms_m.fmmsdocno, 
       g_fmms_m.fmms001,g_fmms_m.fmms002,g_fmms_m.fmmsstus,g_fmms_m.fmmsownid,g_fmms_m.fmmsowndp,g_fmms_m.fmmscrtid, 
       g_fmms_m.fmmscrtdp,g_fmms_m.fmmscrtdt,g_fmms_m.fmmsmodid,g_fmms_m.fmmsmoddt,g_fmms_m.fmmscnfid, 
       g_fmms_m.fmmscnfdt,g_fmms_m.fmmspstid,g_fmms_m.fmmspstdt,g_fmms_m.fmmscomp_desc,g_fmms_m.fmmsownid_desc, 
       g_fmms_m.fmmsowndp_desc,g_fmms_m.fmmscrtid_desc,g_fmms_m.fmmscrtdp_desc,g_fmms_m.fmmsmodid_desc, 
       g_fmms_m.fmmscnfid_desc,g_fmms_m.fmmspstid_desc
   
   CALL afmt560_fmms_t_mask()
   CALL afmt560_show()
      
END FUNCTION
 
{</section>}
 
{<section id="afmt560.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION afmt560_ui_detailshow()
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
 
{<section id="afmt560.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afmt560_ui_browser_refresh()
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
      IF g_browser[l_i].b_fmmsdocno = g_fmms_m.fmmsdocno 
 
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
 
{<section id="afmt560.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmt560_construct()
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
   INITIALIZE g_fmms_m.* TO NULL
   CALL g_fmmt_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON fmmscomp,fmmsdocno,fmmsdocno_desc,fmms001,fmms002,fmmsstus,fmmsownid, 
          fmmsowndp,fmmscrtid,fmmscrtdp,fmmscrtdt,fmmsmodid,fmmsmoddt,fmmscnfid,fmmscnfdt,fmmspstid, 
          fmmspstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<fmmscrtdt>>----
         AFTER FIELD fmmscrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<fmmsmoddt>>----
         AFTER FIELD fmmsmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmmscnfdt>>----
         AFTER FIELD fmmscnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmmspstdt>>----
         AFTER FIELD fmmspstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmscomp
            #add-point:BEFORE FIELD fmmscomp name="construct.b.fmmscomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmscomp
            
            #add-point:AFTER FIELD fmmscomp name="construct.a.fmmscomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmscomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmscomp
            #add-point:ON ACTION controlp INFIELD fmmscomp name="construct.c.fmmscomp"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmsdocno
            #add-point:BEFORE FIELD fmmsdocno name="construct.b.fmmsdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmsdocno
            
            #add-point:AFTER FIELD fmmsdocno name="construct.a.fmmsdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmsdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmsdocno
            #add-point:ON ACTION controlp INFIELD fmmsdocno name="construct.c.fmmsdocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmsdocno_desc
            #add-point:BEFORE FIELD fmmsdocno_desc name="construct.b.fmmsdocno_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmsdocno_desc
            
            #add-point:AFTER FIELD fmmsdocno_desc name="construct.a.fmmsdocno_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmsdocno_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmsdocno_desc
            #add-point:ON ACTION controlp INFIELD fmmsdocno_desc name="construct.c.fmmsdocno_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmms001
            #add-point:BEFORE FIELD fmms001 name="construct.b.fmms001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmms001
            
            #add-point:AFTER FIELD fmms001 name="construct.a.fmms001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmms001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmms001
            #add-point:ON ACTION controlp INFIELD fmms001 name="construct.c.fmms001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmms002
            #add-point:BEFORE FIELD fmms002 name="construct.b.fmms002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmms002
            
            #add-point:AFTER FIELD fmms002 name="construct.a.fmms002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmms002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmms002
            #add-point:ON ACTION controlp INFIELD fmms002 name="construct.c.fmms002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmsstus
            #add-point:BEFORE FIELD fmmsstus name="construct.b.fmmsstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmsstus
            
            #add-point:AFTER FIELD fmmsstus name="construct.a.fmmsstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmsstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmsstus
            #add-point:ON ACTION controlp INFIELD fmmsstus name="construct.c.fmmsstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmsownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmsownid
            #add-point:ON ACTION controlp INFIELD fmmsownid name="construct.c.fmmsownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmsownid  #顯示到畫面上
            NEXT FIELD fmmsownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmsownid
            #add-point:BEFORE FIELD fmmsownid name="construct.b.fmmsownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmsownid
            
            #add-point:AFTER FIELD fmmsownid name="construct.a.fmmsownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmsowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmsowndp
            #add-point:ON ACTION controlp INFIELD fmmsowndp name="construct.c.fmmsowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmsowndp  #顯示到畫面上
            NEXT FIELD fmmsowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmsowndp
            #add-point:BEFORE FIELD fmmsowndp name="construct.b.fmmsowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmsowndp
            
            #add-point:AFTER FIELD fmmsowndp name="construct.a.fmmsowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmscrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmscrtid
            #add-point:ON ACTION controlp INFIELD fmmscrtid name="construct.c.fmmscrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmscrtid  #顯示到畫面上
            NEXT FIELD fmmscrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmscrtid
            #add-point:BEFORE FIELD fmmscrtid name="construct.b.fmmscrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmscrtid
            
            #add-point:AFTER FIELD fmmscrtid name="construct.a.fmmscrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmscrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmscrtdp
            #add-point:ON ACTION controlp INFIELD fmmscrtdp name="construct.c.fmmscrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmscrtdp  #顯示到畫面上
            NEXT FIELD fmmscrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmscrtdp
            #add-point:BEFORE FIELD fmmscrtdp name="construct.b.fmmscrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmscrtdp
            
            #add-point:AFTER FIELD fmmscrtdp name="construct.a.fmmscrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmscrtdt
            #add-point:BEFORE FIELD fmmscrtdt name="construct.b.fmmscrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmsmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmsmodid
            #add-point:ON ACTION controlp INFIELD fmmsmodid name="construct.c.fmmsmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmsmodid  #顯示到畫面上
            NEXT FIELD fmmsmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmsmodid
            #add-point:BEFORE FIELD fmmsmodid name="construct.b.fmmsmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmsmodid
            
            #add-point:AFTER FIELD fmmsmodid name="construct.a.fmmsmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmsmoddt
            #add-point:BEFORE FIELD fmmsmoddt name="construct.b.fmmsmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmscnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmscnfid
            #add-point:ON ACTION controlp INFIELD fmmscnfid name="construct.c.fmmscnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmscnfid  #顯示到畫面上
            NEXT FIELD fmmscnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmscnfid
            #add-point:BEFORE FIELD fmmscnfid name="construct.b.fmmscnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmscnfid
            
            #add-point:AFTER FIELD fmmscnfid name="construct.a.fmmscnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmscnfdt
            #add-point:BEFORE FIELD fmmscnfdt name="construct.b.fmmscnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmmspstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmspstid
            #add-point:ON ACTION controlp INFIELD fmmspstid name="construct.c.fmmspstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmspstid  #顯示到畫面上
            NEXT FIELD fmmspstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmspstid
            #add-point:BEFORE FIELD fmmspstid name="construct.b.fmmspstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmspstid
            
            #add-point:AFTER FIELD fmmspstid name="construct.a.fmmspstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmspstdt
            #add-point:BEFORE FIELD fmmspstdt name="construct.b.fmmspstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON fmmtseq,fmmt001,fmmt002,fmmt003,fmmt017,fmmt004,fmmt005,fmmt006,fmmt007, 
          fmmt008,fmmt009,fmmt010,fmmt011,fmmt012,fmmt013,fmmt014,fmmt015,fmmt016,fmmt018,fmmt019
           FROM s_detail1[1].fmmtseq,s_detail1[1].fmmt001,s_detail1[1].fmmt002,s_detail1[1].fmmt003, 
               s_detail1[1].fmmt017,s_detail1[1].fmmt004,s_detail1[1].fmmt005,s_detail1[1].fmmt006,s_detail1[1].fmmt007, 
               s_detail1[1].fmmt008,s_detail1[1].fmmt009,s_detail1[1].fmmt010,s_detail1[1].fmmt011,s_detail1[1].fmmt012, 
               s_detail1[1].fmmt013,s_detail1[1].fmmt014,s_detail1[1].fmmt015,s_detail1[1].fmmt016,s_detail1[1].fmmt018, 
               s_detail1[1].fmmt019
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmtseq
            #add-point:BEFORE FIELD fmmtseq name="construct.b.page1.fmmtseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmtseq
            
            #add-point:AFTER FIELD fmmtseq name="construct.a.page1.fmmtseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmtseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmtseq
            #add-point:ON ACTION controlp INFIELD fmmtseq name="construct.c.page1.fmmtseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmmt001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt001
            #add-point:ON ACTION controlp INFIELD fmmt001 name="construct.c.page1.fmmt001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                       #161006-00005#34   mark
            CALL q_ooef001_33()                     #161006-00005#34   add    #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmt001  #顯示到畫面上
            NEXT FIELD fmmt001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt001
            #add-point:BEFORE FIELD fmmt001 name="construct.b.page1.fmmt001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt001
            
            #add-point:AFTER FIELD fmmt001 name="construct.a.page1.fmmt001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt002
            #add-point:BEFORE FIELD fmmt002 name="construct.b.page1.fmmt002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt002
            
            #add-point:AFTER FIELD fmmt002 name="construct.a.page1.fmmt002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmt002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt002
            #add-point:ON ACTION controlp INFIELD fmmt002 name="construct.c.page1.fmmt002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmmt003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt003
            #add-point:ON ACTION controlp INFIELD fmmt003 name="construct.c.page1.fmmt003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmt003  #顯示到畫面上
            NEXT FIELD fmmt003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt003
            #add-point:BEFORE FIELD fmmt003 name="construct.b.page1.fmmt003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt003
            
            #add-point:AFTER FIELD fmmt003 name="construct.a.page1.fmmt003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt017
            #add-point:BEFORE FIELD fmmt017 name="construct.b.page1.fmmt017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt017
            
            #add-point:AFTER FIELD fmmt017 name="construct.a.page1.fmmt017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmt017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt017
            #add-point:ON ACTION controlp INFIELD fmmt017 name="construct.c.page1.fmmt017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt004
            #add-point:BEFORE FIELD fmmt004 name="construct.b.page1.fmmt004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt004
            
            #add-point:AFTER FIELD fmmt004 name="construct.a.page1.fmmt004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmt004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt004
            #add-point:ON ACTION controlp INFIELD fmmt004 name="construct.c.page1.fmmt004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt005
            #add-point:BEFORE FIELD fmmt005 name="construct.b.page1.fmmt005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt005
            
            #add-point:AFTER FIELD fmmt005 name="construct.a.page1.fmmt005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmt005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt005
            #add-point:ON ACTION controlp INFIELD fmmt005 name="construct.c.page1.fmmt005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt006
            #add-point:BEFORE FIELD fmmt006 name="construct.b.page1.fmmt006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt006
            
            #add-point:AFTER FIELD fmmt006 name="construct.a.page1.fmmt006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmt006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt006
            #add-point:ON ACTION controlp INFIELD fmmt006 name="construct.c.page1.fmmt006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt007
            #add-point:BEFORE FIELD fmmt007 name="construct.b.page1.fmmt007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt007
            
            #add-point:AFTER FIELD fmmt007 name="construct.a.page1.fmmt007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmt007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt007
            #add-point:ON ACTION controlp INFIELD fmmt007 name="construct.c.page1.fmmt007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt008
            #add-point:BEFORE FIELD fmmt008 name="construct.b.page1.fmmt008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt008
            
            #add-point:AFTER FIELD fmmt008 name="construct.a.page1.fmmt008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmt008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt008
            #add-point:ON ACTION controlp INFIELD fmmt008 name="construct.c.page1.fmmt008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt009
            #add-point:BEFORE FIELD fmmt009 name="construct.b.page1.fmmt009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt009
            
            #add-point:AFTER FIELD fmmt009 name="construct.a.page1.fmmt009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmt009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt009
            #add-point:ON ACTION controlp INFIELD fmmt009 name="construct.c.page1.fmmt009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt010
            #add-point:BEFORE FIELD fmmt010 name="construct.b.page1.fmmt010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt010
            
            #add-point:AFTER FIELD fmmt010 name="construct.a.page1.fmmt010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmt010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt010
            #add-point:ON ACTION controlp INFIELD fmmt010 name="construct.c.page1.fmmt010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt011
            #add-point:BEFORE FIELD fmmt011 name="construct.b.page1.fmmt011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt011
            
            #add-point:AFTER FIELD fmmt011 name="construct.a.page1.fmmt011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmt011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt011
            #add-point:ON ACTION controlp INFIELD fmmt011 name="construct.c.page1.fmmt011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt012
            #add-point:BEFORE FIELD fmmt012 name="construct.b.page1.fmmt012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt012
            
            #add-point:AFTER FIELD fmmt012 name="construct.a.page1.fmmt012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmt012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt012
            #add-point:ON ACTION controlp INFIELD fmmt012 name="construct.c.page1.fmmt012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt013
            #add-point:BEFORE FIELD fmmt013 name="construct.b.page1.fmmt013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt013
            
            #add-point:AFTER FIELD fmmt013 name="construct.a.page1.fmmt013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmt013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt013
            #add-point:ON ACTION controlp INFIELD fmmt013 name="construct.c.page1.fmmt013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt014
            #add-point:BEFORE FIELD fmmt014 name="construct.b.page1.fmmt014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt014
            
            #add-point:AFTER FIELD fmmt014 name="construct.a.page1.fmmt014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmt014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt014
            #add-point:ON ACTION controlp INFIELD fmmt014 name="construct.c.page1.fmmt014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt015
            #add-point:BEFORE FIELD fmmt015 name="construct.b.page1.fmmt015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt015
            
            #add-point:AFTER FIELD fmmt015 name="construct.a.page1.fmmt015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmt015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt015
            #add-point:ON ACTION controlp INFIELD fmmt015 name="construct.c.page1.fmmt015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt016
            #add-point:BEFORE FIELD fmmt016 name="construct.b.page1.fmmt016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt016
            
            #add-point:AFTER FIELD fmmt016 name="construct.a.page1.fmmt016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmt016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt016
            #add-point:ON ACTION controlp INFIELD fmmt016 name="construct.c.page1.fmmt016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt018
            #add-point:BEFORE FIELD fmmt018 name="construct.b.page1.fmmt018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt018
            
            #add-point:AFTER FIELD fmmt018 name="construct.a.page1.fmmt018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmt018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt018
            #add-point:ON ACTION controlp INFIELD fmmt018 name="construct.c.page1.fmmt018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt019
            #add-point:BEFORE FIELD fmmt019 name="construct.b.page1.fmmt019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt019
            
            #add-point:AFTER FIELD fmmt019 name="construct.a.page1.fmmt019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmmt019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt019
            #add-point:ON ACTION controlp INFIELD fmmt019 name="construct.c.page1.fmmt019"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         NEXT FIELD fmmscomp
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
                  WHEN la_wc[li_idx].tableid = "fmms_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "fmmt_t" 
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
   #161104-00046#21-----s
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#21-----e
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afmt560.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION afmt560_filter()
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
      CONSTRUCT g_wc_filter ON fmmsdocno,fmmscomp
                          FROM s_browse[1].b_fmmsdocno,s_browse[1].b_fmmscomp
 
         BEFORE CONSTRUCT
               DISPLAY afmt560_filter_parser('fmmsdocno') TO s_browse[1].b_fmmsdocno
            DISPLAY afmt560_filter_parser('fmmscomp') TO s_browse[1].b_fmmscomp
      
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
 
      CALL afmt560_filter_show('fmmsdocno')
   CALL afmt560_filter_show('fmmscomp')
 
END FUNCTION
 
{</section>}
 
{<section id="afmt560.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION afmt560_filter_parser(ps_field)
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
 
{<section id="afmt560.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION afmt560_filter_show(ps_field)
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
   LET ls_condition = afmt560_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afmt560.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afmt560_query()
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
   CALL g_fmmt_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL afmt560_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afmt560_browser_fill("")
      CALL afmt560_fetch("")
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
      CALL afmt560_filter_show('fmmsdocno')
   CALL afmt560_filter_show('fmmscomp')
   CALL afmt560_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL afmt560_fetch("F") 
      #顯示單身筆數
      CALL afmt560_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afmt560.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afmt560_fetch(p_flag)
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
   
   LET g_fmms_m.fmmsdocno = g_browser[g_current_idx].b_fmmsdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE afmt560_master_referesh USING g_fmms_m.fmmsdocno INTO g_fmms_m.fmmscomp,g_fmms_m.fmmsdocno, 
       g_fmms_m.fmms001,g_fmms_m.fmms002,g_fmms_m.fmmsstus,g_fmms_m.fmmsownid,g_fmms_m.fmmsowndp,g_fmms_m.fmmscrtid, 
       g_fmms_m.fmmscrtdp,g_fmms_m.fmmscrtdt,g_fmms_m.fmmsmodid,g_fmms_m.fmmsmoddt,g_fmms_m.fmmscnfid, 
       g_fmms_m.fmmscnfdt,g_fmms_m.fmmspstid,g_fmms_m.fmmspstdt,g_fmms_m.fmmscomp_desc,g_fmms_m.fmmsownid_desc, 
       g_fmms_m.fmmsowndp_desc,g_fmms_m.fmmscrtid_desc,g_fmms_m.fmmscrtdp_desc,g_fmms_m.fmmsmodid_desc, 
       g_fmms_m.fmmscnfid_desc,g_fmms_m.fmmspstid_desc
   
   #遮罩相關處理
   LET g_fmms_m_mask_o.* =  g_fmms_m.*
   CALL afmt560_fmms_t_mask()
   LET g_fmms_m_mask_n.* =  g_fmms_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt560_set_act_visible()   
   CALL afmt560_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_fmms_m_t.* = g_fmms_m.*
   LET g_fmms_m_o.* = g_fmms_m.*
   
   LET g_data_owner = g_fmms_m.fmmsownid      
   LET g_data_dept  = g_fmms_m.fmmsowndp
   
   #重新顯示   
   CALL afmt560_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt560.insert" >}
#+ 資料新增
PRIVATE FUNCTION afmt560_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_num      LIKE type_t.num5
   DEFINE l_glav004  LIKE glav_t.glav004
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_fmmt_d.clear()   
 
 
   INITIALIZE g_fmms_m.* TO NULL             #DEFAULT 設定
   
   LET g_fmmsdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmms_m.fmmsownid = g_user
      LET g_fmms_m.fmmsowndp = g_dept
      LET g_fmms_m.fmmscrtid = g_user
      LET g_fmms_m.fmmscrtdp = g_dept 
      LET g_fmms_m.fmmscrtdt = cl_get_current()
      LET g_fmms_m.fmmsmodid = g_user
      LET g_fmms_m.fmmsmoddt = cl_get_current()
      LET g_fmms_m.fmmsstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_fmms_m.fmms001 = "0"
      LET g_fmms_m.fmms002 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,g_fmms_m.fmmscomp,g_glaald
      IF NOT cl_null(g_fmms_m.fmmscomp) THEN
         CALL afmt560_set_ld_info()
      END IF
      LET g_fmms_m.fmms001 = YEAR(g_today)
      #取得會計當期起始日
      CALL s_get_accdate(g_glaa003,g_today,'','')
         RETURNING g_sub_success,g_errno,g_fmms_m.fmms001,
                   l_num,l_glav004,l_glav004,
                   g_fmms_m.fmms002,g_accdate_s,g_accdate_e,
                   l_num,l_glav004,l_glav004
      DISPLAY BY NAME g_fmms_m.fmmscomp,g_fmms_m.fmms001,g_fmms_m.fmms002
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_fmms_m_t.* = g_fmms_m.*
      LET g_fmms_m_o.* = g_fmms_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmms_m.fmmsstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
 
 
 
    
      CALL afmt560_input("a")
      
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
         INITIALIZE g_fmms_m.* TO NULL
         INITIALIZE g_fmmt_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL afmt560_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_fmmt_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt560_set_act_visible()   
   CALL afmt560_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fmmsdocno_t = g_fmms_m.fmmsdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmmsent = " ||g_enterprise|| " AND",
                      " fmmsdocno = '", g_fmms_m.fmmsdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt560_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE afmt560_cl
   
   CALL afmt560_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afmt560_master_referesh USING g_fmms_m.fmmsdocno INTO g_fmms_m.fmmscomp,g_fmms_m.fmmsdocno, 
       g_fmms_m.fmms001,g_fmms_m.fmms002,g_fmms_m.fmmsstus,g_fmms_m.fmmsownid,g_fmms_m.fmmsowndp,g_fmms_m.fmmscrtid, 
       g_fmms_m.fmmscrtdp,g_fmms_m.fmmscrtdt,g_fmms_m.fmmsmodid,g_fmms_m.fmmsmoddt,g_fmms_m.fmmscnfid, 
       g_fmms_m.fmmscnfdt,g_fmms_m.fmmspstid,g_fmms_m.fmmspstdt,g_fmms_m.fmmscomp_desc,g_fmms_m.fmmsownid_desc, 
       g_fmms_m.fmmsowndp_desc,g_fmms_m.fmmscrtid_desc,g_fmms_m.fmmscrtdp_desc,g_fmms_m.fmmsmodid_desc, 
       g_fmms_m.fmmscnfid_desc,g_fmms_m.fmmspstid_desc
   
   
   #遮罩相關處理
   LET g_fmms_m_mask_o.* =  g_fmms_m.*
   CALL afmt560_fmms_t_mask()
   LET g_fmms_m_mask_n.* =  g_fmms_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmms_m.fmmscomp,g_fmms_m.fmmscomp_desc,g_fmms_m.fmmsdocno,g_fmms_m.fmmsdocno_desc, 
       g_fmms_m.fmms001,g_fmms_m.fmms002,g_fmms_m.fmmsstus,g_fmms_m.fmmsownid,g_fmms_m.fmmsownid_desc, 
       g_fmms_m.fmmsowndp,g_fmms_m.fmmsowndp_desc,g_fmms_m.fmmscrtid,g_fmms_m.fmmscrtid_desc,g_fmms_m.fmmscrtdp, 
       g_fmms_m.fmmscrtdp_desc,g_fmms_m.fmmscrtdt,g_fmms_m.fmmsmodid,g_fmms_m.fmmsmodid_desc,g_fmms_m.fmmsmoddt, 
       g_fmms_m.fmmscnfid,g_fmms_m.fmmscnfid_desc,g_fmms_m.fmmscnfdt,g_fmms_m.fmmspstid,g_fmms_m.fmmspstid_desc, 
       g_fmms_m.fmmspstdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_fmms_m.fmmsownid      
   LET g_data_dept  = g_fmms_m.fmmsowndp
   
   #功能已完成,通報訊息中心
   CALL afmt560_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afmt560.modify" >}
#+ 資料修改
PRIVATE FUNCTION afmt560_modify()
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
   LET g_fmms_m_t.* = g_fmms_m.*
   LET g_fmms_m_o.* = g_fmms_m.*
   
   IF g_fmms_m.fmmsdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_fmmsdocno_t = g_fmms_m.fmmsdocno
 
   CALL s_transaction_begin()
   
   OPEN afmt560_cl USING g_enterprise,g_fmms_m.fmmsdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt560_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afmt560_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt560_master_referesh USING g_fmms_m.fmmsdocno INTO g_fmms_m.fmmscomp,g_fmms_m.fmmsdocno, 
       g_fmms_m.fmms001,g_fmms_m.fmms002,g_fmms_m.fmmsstus,g_fmms_m.fmmsownid,g_fmms_m.fmmsowndp,g_fmms_m.fmmscrtid, 
       g_fmms_m.fmmscrtdp,g_fmms_m.fmmscrtdt,g_fmms_m.fmmsmodid,g_fmms_m.fmmsmoddt,g_fmms_m.fmmscnfid, 
       g_fmms_m.fmmscnfdt,g_fmms_m.fmmspstid,g_fmms_m.fmmspstdt,g_fmms_m.fmmscomp_desc,g_fmms_m.fmmsownid_desc, 
       g_fmms_m.fmmsowndp_desc,g_fmms_m.fmmscrtid_desc,g_fmms_m.fmmscrtdp_desc,g_fmms_m.fmmsmodid_desc, 
       g_fmms_m.fmmscnfid_desc,g_fmms_m.fmmspstid_desc
   
   #檢查是否允許此動作
   IF NOT afmt560_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmms_m_mask_o.* =  g_fmms_m.*
   CALL afmt560_fmms_t_mask()
   LET g_fmms_m_mask_n.* =  g_fmms_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL afmt560_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_fmmsdocno_t = g_fmms_m.fmmsdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_fmms_m.fmmsmodid = g_user 
LET g_fmms_m.fmmsmoddt = cl_get_current()
LET g_fmms_m.fmmsmodid_desc = cl_get_username(g_fmms_m.fmmsmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL afmt560_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE fmms_t SET (fmmsmodid,fmmsmoddt) = (g_fmms_m.fmmsmodid,g_fmms_m.fmmsmoddt)
          WHERE fmmsent = g_enterprise AND fmmsdocno = g_fmmsdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_fmms_m.* = g_fmms_m_t.*
            CALL afmt560_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_fmms_m.fmmsdocno != g_fmms_m_t.fmmsdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE fmmt_t SET fmmtdocno = g_fmms_m.fmmsdocno
 
          WHERE fmmtent = g_enterprise AND fmmtdocno = g_fmms_m_t.fmmsdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fmmt_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmmt_t:",SQLERRMESSAGE 
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
   CALL afmt560_set_act_visible()   
   CALL afmt560_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fmmsent = " ||g_enterprise|| " AND",
                      " fmmsdocno = '", g_fmms_m.fmmsdocno, "' "
 
   #填到對應位置
   CALL afmt560_browser_fill("")
 
   CLOSE afmt560_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt560_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="afmt560.input" >}
#+ 資料輸入
PRIVATE FUNCTION afmt560_input(p_cmd)
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
   DEFINE l_docdt       LIKE type_t.dat 
   DEFINE l_flag        LIKE type_t.num5      #161104-00046#21
   DEFINE l_slip        LIKE ooba_t.ooba002   #161104-00046#21
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
   DISPLAY BY NAME g_fmms_m.fmmscomp,g_fmms_m.fmmscomp_desc,g_fmms_m.fmmsdocno,g_fmms_m.fmmsdocno_desc, 
       g_fmms_m.fmms001,g_fmms_m.fmms002,g_fmms_m.fmmsstus,g_fmms_m.fmmsownid,g_fmms_m.fmmsownid_desc, 
       g_fmms_m.fmmsowndp,g_fmms_m.fmmsowndp_desc,g_fmms_m.fmmscrtid,g_fmms_m.fmmscrtid_desc,g_fmms_m.fmmscrtdp, 
       g_fmms_m.fmmscrtdp_desc,g_fmms_m.fmmscrtdt,g_fmms_m.fmmsmodid,g_fmms_m.fmmsmodid_desc,g_fmms_m.fmmsmoddt, 
       g_fmms_m.fmmscnfid,g_fmms_m.fmmscnfid_desc,g_fmms_m.fmmscnfdt,g_fmms_m.fmmspstid,g_fmms_m.fmmspstid_desc, 
       g_fmms_m.fmmspstdt
   
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
   LET g_forupd_sql = "SELECT fmmtseq,fmmt001,fmmt002,fmmt003,fmmt017,fmmt004,fmmt005,fmmt006,fmmt007, 
       fmmt008,fmmt009,fmmt010,fmmt011,fmmt012,fmmt013,fmmt014,fmmt015,fmmt016,fmmt018,fmmt019 FROM  
       fmmt_t WHERE fmmtent=? AND fmmtdocno=? AND fmmtseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt560_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL afmt560_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afmt560_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_fmms_m.fmmscomp,g_fmms_m.fmmsdocno,g_fmms_m.fmms001,g_fmms_m.fmms002,g_fmms_m.fmmsstus 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="afmt560.input.head" >}
      #單頭段
      INPUT BY NAME g_fmms_m.fmmscomp,g_fmms_m.fmmsdocno,g_fmms_m.fmms001,g_fmms_m.fmms002,g_fmms_m.fmmsstus  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN afmt560_cl USING g_enterprise,g_fmms_m.fmmsdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt560_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt560_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL afmt560_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
 
            #end add-point
            CALL afmt560_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmscomp
            
            #add-point:AFTER FIELD fmmscomp name="input.a.fmmscomp"
            LET g_fmms_m.fmmscomp_desc = ''
            IF NOT cl_null(g_fmms_m.fmmscomp) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmms_m.fmmscomp != g_fmms_m_t.fmmscomp OR g_fmms_m_t.fmmscomp IS NULL )) THEN #160822-00012#2 mark
               IF g_fmms_m.fmmscomp != g_fmms_m_o.fmmscomp OR cl_null(g_fmms_m_o.fmmscomp) THEN                                     #160822-00012#2   add
                  CALL afmt560_fmms_chk() RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.code   = g_errno 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     #LET g_fmms_m.fmmscomp = g_fmms_m_t.fmmscomp #160822-00012#2 mark
                     LET g_fmms_m.fmmscomp = g_fmms_m_o.fmmscomp #160822-00012#2
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_comp_chk(g_fmms_m.fmmscomp) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.code   = g_errno 
                     #160321-00016#27 --s add
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi100'
                     #160321-00016#27 --e add
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     #LET g_fmms_m.fmmscomp = g_fmms_m_t.fmmscomp #160822-00012#2 mark
                     LET g_fmms_m.fmmscomp = g_fmms_m_o.fmmscomp #160822-00012#2
                     NEXT FIELD CURRENT
                  END IF
                  CALL afmt560_set_ld_info()
               END IF
            END IF
            CALL s_desc_get_department_desc(g_fmms_m.fmmscomp) RETURNING g_fmms_m.fmmscomp_desc
            DISPLAY BY NAME g_fmms_m.fmmscomp_desc
            LET g_fmms_m_o.* = g_fmms_m.*  #160822-00012#2
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmscomp
            #add-point:BEFORE FIELD fmmscomp name="input.b.fmmscomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmscomp
            #add-point:ON CHANGE fmmscomp name="input.g.fmmscomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmsdocno
            
            #add-point:AFTER FIELD fmmsdocno name="input.a.fmmsdocno"

            #應用 a05 樣板自動產生(Version:2)
            LET g_fmms_m.fmmsdocno_desc = ''
            IF NOT cl_null(g_fmms_m.fmmsdocno) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (cl_null(g_fmms_m_t.fmmsdocno) OR g_fmms_m.fmmsdocno != g_fmms_m_t.fmmsdocno)) THEN #160822-00012#2 mark
               IF g_fmms_m.fmmsdocno != g_fmms_m_t.fmmsdocno OR cl_null(g_fmms_m_t.fmmsdocno) THEN #160822-00012#2
                  #檢查是否有重複的單據編號(企業代碼/單號)
                  #IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmms_t WHERE "||"fmmsent = '" ||g_enterprise|| "' AND "||"fmmsdocno = '"||g_fmms_m.fmmsdocno ||"'",'std-00004',0) THEN #160822-00012#2 mark
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM fmms_t WHERE "||"fmmsent = '" ||g_enterprise|| "' AND "||"fmmsdocno = '"||g_fmms_m.fmmsdocno ||"'",'std-00004',0) THEN #160822-00012#2   
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_aooi200_fin_chk_docno(g_glaald,'','',g_fmms_m.fmmsdocno,g_today,g_prog) THEN
                     #LET g_fmms_m.fmmsdocno = g_fmms_m_t.fmmsdocno #160822-00012#2 mark
                     LET g_fmms_m.fmmsdocno = g_fmms_m_o.fmmsdocno #160822-00012#2
                     NEXT FIELD CURRENT
                  END IF
                  #161104-00046#21-----s
                  CALL s_control_chk_doc('1',g_fmms_m.fmmsdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
                  IF g_sub_success AND l_flag THEN             
                  ELSE
                     LET g_fmms_m.fmmsdocno = g_fmms_m_o.fmmsdocno 
                     NEXT FIELD CURRENT                  
                  END IF
                  CALL s_aooi200_fin_get_slip(g_fmms_m.fmmsdocno) RETURNING g_sub_success,l_slip
                  #刪除單別預設temptable
                  DELETE FROM s_aooi200def1
                  #以目前畫面資訊新增temp資料   #請勿調整.*
                  INSERT INTO s_aooi200def1 VALUES(g_fmms_m.*)
                  #依單別預設取用資訊
                  CALL s_aooi200def_get('','',g_fmms_m.fmmscomp,'2',l_slip,'','',g_glaald)
                  #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
                  SELECT * INTO g_fmms_m.* FROM s_aooi200def1
                  #161104-00046#21-----e  
               END IF
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_fmms_m.fmmsdocno) RETURNING g_fmms_m.fmmsdocno_desc
            DISPLAY BY NAME g_fmms_m.fmmsdocno_desc
            LET g_fmms_m_o.* = g_fmms_m.*  #160822-00012#2
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmsdocno
            #add-point:BEFORE FIELD fmmsdocno name="input.b.fmmsdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmsdocno
            #add-point:ON CHANGE fmmsdocno name="input.g.fmmsdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmms001
            #add-point:BEFORE FIELD fmms001 name="input.b.fmms001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmms001
            
            #add-point:AFTER FIELD fmms001 name="input.a.fmms001"
            IF NOT cl_null(g_fmms_m.fmms001) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmms_m.fmms001 != g_fmms_m_t.fmms001 OR g_fmms_m_t.fmms001 IS NULL )) THEN   #160822-00012#4   mark
               IF g_fmms_m.fmms001 != g_fmms_m_o.fmms001 OR cl_null(g_fmms_m_o.fmms001) THEN                                       #160822-00012#4   add
                  IF g_fmms_m.fmms001 < 1900 OR g_fmms_m.fmms001 > 2999 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.code   = 'afa-00310' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  CALL afmt560_fmms_chk() RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.code   = g_errno 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     #LET g_fmms_m.fmms001 = g_fmms_m_t.fmms001   #160822-00012#4   mark
                     LET g_fmms_m.fmms001 = g_fmms_m_o.fmms001    #160822-00012#4   add
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_fmms_m_o.* = g_fmms_m.*  #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmms001
            #add-point:ON CHANGE fmms001 name="input.g.fmms001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmms002
            #add-point:BEFORE FIELD fmms002 name="input.b.fmms002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmms002
            
            #add-point:AFTER FIELD fmms002 name="input.a.fmms002"
            IF NOT cl_null(g_fmms_m.fmms002) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmms_m.fmms002 != g_fmms_m_t.fmms002 OR g_fmms_m_t.fmms002 IS NULL )) THEN   #160822-00012#4   mark
               IF g_fmms_m.fmms002 != g_fmms_m_o.fmms002 OR cl_null(g_fmms_m_o.fmms002) THEN                                       #160822-00012#4   add
                  IF g_fmms_m.fmms002 < 1 OR g_fmms_m.fmms002 > 13 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.code   = 'acr-00044' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  CALL afmt560_fmms_chk() RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.code   = g_errno 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     #LET g_fmms_m.fmms002 = g_fmms_m_t.fmms002   #160822-00012#4   mark
                     LET g_fmms_m.fmms002 = g_fmms_m_o.fmms002    #160822-00012#4   add
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_fmms_m_o.* = g_fmms_m.*  #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmms002
            #add-point:ON CHANGE fmms002 name="input.g.fmms002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmsstus
            #add-point:BEFORE FIELD fmmsstus name="input.b.fmmsstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmsstus
            
            #add-point:AFTER FIELD fmmsstus name="input.a.fmmsstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmsstus
            #add-point:ON CHANGE fmmsstus name="input.g.fmmsstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fmmscomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmscomp
            #add-point:ON ACTION controlp INFIELD fmmscomp name="input.c.fmmscomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y'",
                                   " AND ooef001 IN ",g_wc_cs_comp   #161006-00005#34   add
            CALL q_ooef001()
            LET g_fmms_m.fmmscomp = g_qryparam.return1  
            DISPLAY BY NAME g_fmms_m.fmmscomp
            NEXT FIELD fmmscomp
            #END add-point
 
 
         #Ctrlp:input.c.fmmsdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmsdocno
            #add-point:ON ACTION controlp INFIELD fmmsdocno name="input.c.fmmsdocno"
            #單別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmms_m.fmmsdocno
            LET g_qryparam.arg1 = g_glaa024
            #LET g_qryparam.arg2 = "afmt560"     #计提投资收益维护   #160705-00042#2 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#2 160711 by sakura add
            #161104-00046#21-----s
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF
            #161104-00046#21-----e
            CALL q_ooba002_1()
            LET g_fmms_m.fmmsdocno = g_qryparam.return1    
            CALL s_aooi200_fin_get_slip_desc(g_fmms_m.fmmsdocno) RETURNING g_fmms_m.fmmsdocno_desc
            DISPLAY BY NAME g_fmms_m.fmmsdocno,g_fmms_m.fmmsdocno_desc
            NEXT FIELD CURRENT
            #END add-point
 
 
         #Ctrlp:input.c.fmms001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmms001
            #add-point:ON ACTION controlp INFIELD fmms001 name="input.c.fmms001"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmms002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmms002
            #add-point:ON ACTION controlp INFIELD fmms002 name="input.c.fmms002"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmsstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmsstus
            #add-point:ON ACTION controlp INFIELD fmmsstus name="input.c.fmmsstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_fmms_m.fmmsdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #新增前才取單號
               #151125 albireo -----s
               LET l_docdt = MDY(g_fmms_m.fmms002,1,g_fmms_m.fmms001)
               LET l_docdt =s_date_get_last_date(l_docdt)
               #151125 albireo -----e
               
               CALL s_aooi200_fin_gen_docno(g_glaald,'','',g_fmms_m.fmmsdocno,l_docdt,g_prog)
                    RETURNING g_sub_success,g_fmms_m.fmmsdocno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_fmms_m.fmmsdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD fmmsdocno
               END IF
               DISPLAY BY NAME g_fmms_m.fmmsdocno
               #end add-point
               
               INSERT INTO fmms_t (fmmsent,fmmscomp,fmmsdocno,fmms001,fmms002,fmmsstus,fmmsownid,fmmsowndp, 
                   fmmscrtid,fmmscrtdp,fmmscrtdt,fmmsmodid,fmmsmoddt,fmmscnfid,fmmscnfdt,fmmspstid,fmmspstdt) 
 
               VALUES (g_enterprise,g_fmms_m.fmmscomp,g_fmms_m.fmmsdocno,g_fmms_m.fmms001,g_fmms_m.fmms002, 
                   g_fmms_m.fmmsstus,g_fmms_m.fmmsownid,g_fmms_m.fmmsowndp,g_fmms_m.fmmscrtid,g_fmms_m.fmmscrtdp, 
                   g_fmms_m.fmmscrtdt,g_fmms_m.fmmsmodid,g_fmms_m.fmmsmoddt,g_fmms_m.fmmscnfid,g_fmms_m.fmmscnfdt, 
                   g_fmms_m.fmmspstid,g_fmms_m.fmmspstdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_fmms_m:",SQLERRMESSAGE 
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
                  CALL afmt560_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL afmt560_b_fill()
                  CALL afmt560_b_fill2('0')
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
               CALL afmt560_fmms_t_mask_restore('restore_mask_o')
               
               UPDATE fmms_t SET (fmmscomp,fmmsdocno,fmms001,fmms002,fmmsstus,fmmsownid,fmmsowndp,fmmscrtid, 
                   fmmscrtdp,fmmscrtdt,fmmsmodid,fmmsmoddt,fmmscnfid,fmmscnfdt,fmmspstid,fmmspstdt) = (g_fmms_m.fmmscomp, 
                   g_fmms_m.fmmsdocno,g_fmms_m.fmms001,g_fmms_m.fmms002,g_fmms_m.fmmsstus,g_fmms_m.fmmsownid, 
                   g_fmms_m.fmmsowndp,g_fmms_m.fmmscrtid,g_fmms_m.fmmscrtdp,g_fmms_m.fmmscrtdt,g_fmms_m.fmmsmodid, 
                   g_fmms_m.fmmsmoddt,g_fmms_m.fmmscnfid,g_fmms_m.fmmscnfdt,g_fmms_m.fmmspstid,g_fmms_m.fmmspstdt) 
 
                WHERE fmmsent = g_enterprise AND fmmsdocno = g_fmmsdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fmms_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL afmt560_fmms_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_fmms_m_t)
               LET g_log2 = util.JSON.stringify(g_fmms_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_fmmsdocno_t = g_fmms_m.fmmsdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="afmt560.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_fmmt_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            CALL afmt560_set_ld_info()
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmmt_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt560_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_fmmt_d.getLength()
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
            OPEN afmt560_cl USING g_enterprise,g_fmms_m.fmmsdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt560_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afmt560_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmmt_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmmt_d[l_ac].fmmtseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fmmt_d_t.* = g_fmmt_d[l_ac].*  #BACKUP
               LET g_fmmt_d_o.* = g_fmmt_d[l_ac].*  #BACKUP
               CALL afmt560_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL afmt560_set_no_entry_b(l_cmd)
               IF NOT afmt560_lock_b("fmmt_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt560_bcl INTO g_fmmt_d[l_ac].fmmtseq,g_fmmt_d[l_ac].fmmt001,g_fmmt_d[l_ac].fmmt002, 
                      g_fmmt_d[l_ac].fmmt003,g_fmmt_d[l_ac].fmmt017,g_fmmt_d[l_ac].fmmt004,g_fmmt_d[l_ac].fmmt005, 
                      g_fmmt_d[l_ac].fmmt006,g_fmmt_d[l_ac].fmmt007,g_fmmt_d[l_ac].fmmt008,g_fmmt_d[l_ac].fmmt009, 
                      g_fmmt_d[l_ac].fmmt010,g_fmmt_d[l_ac].fmmt011,g_fmmt_d[l_ac].fmmt012,g_fmmt_d[l_ac].fmmt013, 
                      g_fmmt_d[l_ac].fmmt014,g_fmmt_d[l_ac].fmmt015,g_fmmt_d[l_ac].fmmt016,g_fmmt_d[l_ac].fmmt018, 
                      g_fmmt_d[l_ac].fmmt019
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmmt_d_t.fmmtseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmmt_d_mask_o[l_ac].* =  g_fmmt_d[l_ac].*
                  CALL afmt560_fmmt_t_mask()
                  LET g_fmmt_d_mask_n[l_ac].* =  g_fmmt_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt560_show()
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
            INITIALIZE g_fmmt_d[l_ac].* TO NULL 
            INITIALIZE g_fmmt_d_t.* TO NULL 
            INITIALIZE g_fmmt_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_fmmt_d[l_ac].fmmtseq = "0"
      LET g_fmmt_d[l_ac].fmmt004 = "0"
      LET g_fmmt_d[l_ac].fmmt007 = "0"
      LET g_fmmt_d[l_ac].fmmt008 = "0"
      LET g_fmmt_d[l_ac].fmmt010 = "0"
      LET g_fmmt_d[l_ac].fmmt011 = "0"
      LET g_fmmt_d[l_ac].fmmt012 = "0"
      LET g_fmmt_d[l_ac].fmmt013 = "0"
      LET g_fmmt_d[l_ac].fmmt014 = "0"
      LET g_fmmt_d[l_ac].fmmt015 = "0"
      LET g_fmmt_d[l_ac].fmmt016 = "0"
      LET g_fmmt_d[l_ac].fmmt018 = "0"
      LET g_fmmt_d[l_ac].fmmt019 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #項次
            SELECT MAX(fmmtseq)+1 INTO g_fmmt_d[l_ac].fmmtseq
              FROM fmmt_t
             WHERE fmmtent = g_enterprise
               AND fmmtdocno = g_fmms_m.fmmsdocno
            IF cl_null(g_fmmt_d[l_ac].fmmtseq) THEN LET g_fmmt_d[l_ac].fmmtseq = 1 END IF  
            
            LET g_fmmt_d[l_ac].fmmt017 = '3'   #151117-00001#4
            #end add-point
            LET g_fmmt_d_t.* = g_fmmt_d[l_ac].*     #新輸入資料
            LET g_fmmt_d_o.* = g_fmmt_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt560_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt560_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmmt_d[li_reproduce_target].* = g_fmmt_d[li_reproduce].*
 
               LET g_fmmt_d[li_reproduce_target].fmmtseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM fmmt_t 
             WHERE fmmtent = g_enterprise AND fmmtdocno = g_fmms_m.fmmsdocno
 
               AND fmmtseq = g_fmmt_d[l_ac].fmmtseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmms_m.fmmsdocno
               LET gs_keys[2] = g_fmmt_d[g_detail_idx].fmmtseq
               CALL afmt560_insert_b('fmmt_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_fmmt_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmmt_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt560_b_fill()
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
               LET gs_keys[01] = g_fmms_m.fmmsdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_fmmt_d_t.fmmtseq
 
            
               #刪除同層單身
               IF NOT afmt560_delete_b('fmmt_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt560_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt560_key_delete_b(gs_keys,'fmmt_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt560_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt560_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_fmmt_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmmt_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmtseq
            #add-point:BEFORE FIELD fmmtseq name="input.b.page1.fmmtseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmtseq
            
            #add-point:AFTER FIELD fmmtseq name="input.a.page1.fmmtseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_fmms_m.fmmsdocno IS NOT NULL AND g_fmmt_d[g_detail_idx].fmmtseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmms_m.fmmsdocno != g_fmmsdocno_t OR g_fmmt_d[g_detail_idx].fmmtseq != g_fmmt_d_t.fmmtseq)) THEN 
                  #IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmmt_t WHERE "||"fmmtent = '" ||g_enterprise|| "' AND "||"fmmtdocno = '"||g_fmms_m.fmmsdocno ||"' AND "|| "fmmtseq = '"||g_fmmt_d[g_detail_idx].fmmtseq ||"'",'std-00004',0) THEN #160822-00012#2 mark
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM fmmt_t WHERE "||"fmmtent = '" ||g_enterprise|| "' AND "||"fmmtdocno = '"||g_fmms_m.fmmsdocno ||"' AND "|| "fmmtseq = '"||g_fmmt_d[g_detail_idx].fmmtseq ||"'",'std-00004',0) THEN #160822-00012#2
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmtseq
            #add-point:ON CHANGE fmmtseq name="input.g.page1.fmmtseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt001
            
            #add-point:AFTER FIELD fmmt001 name="input.a.page1.fmmt001"
            LET g_fmmt_d[l_ac].fmmt001_desc = ''
            IF NOT cl_null(g_fmmt_d[l_ac].fmmt001) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fmmt_d[l_ac].fmmt001 != g_fmmt_d_t.fmmt001 OR g_fmmt_d_t.fmmt001 IS NULL )) THEN #160822-00012#2 mark
               IF g_fmmt_d[l_ac].fmmt001 != g_fmmt_d_o.fmmt001 OR cl_null(g_fmmt_d_o.fmmt001) THEN     #160822-00012#2   
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_fmmt_d[l_ac].fmmt001
                  #160318-00025#44  2016/04/26  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#44  2016/04/26  by pengxin  add(E)
                  #IF NOT cl_chk_exist("v_ooef001") THEN     #161006-00005#34   mark
                  IF NOT cl_chk_exist("v_ooef001_42") THEN   #161006-00005#34   add
                     #LET g_fmmt_d[l_ac].fmmt001 = g_fmmt_d_t.fmmt001 #160822-00012#2 mark
                     LET g_fmmt_d[l_ac].fmmt001 = g_fmmt_d_o.fmmt001 #160822-00012#2
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_site_belong_to_comp_chk(g_fmmt_d[l_ac].fmmt001,g_fmms_m.fmmscomp) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno 
                     #160321-00016#27 --s add
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi125'
                     #160321-00016#27 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_fmmt_d[l_ac].fmmt001 = g_fmmt_d_t.fmmt001 #160822-00012#2 mark
                     LET g_fmmt_d[l_ac].fmmt001 = g_fmmt_d_o.fmmt001 #160822-00012#2
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_fmmt_d[l_ac].fmmt002) THEN
                     CALL afmt560_fmmt002_chk() RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_fmmt_d[l_ac].fmmt001 = g_fmmt_d_t.fmmt001 #160822-00012#2 mark
                        LET g_fmmt_d[l_ac].fmmt001 = g_fmmt_d_o.fmmt001 #160822-00012#2
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF  
            END IF
            CALL s_desc_get_department_desc(g_fmmt_d[l_ac].fmmt001) RETURNING g_fmmt_d[l_ac].fmmt001_desc
            DISPLAY BY NAME g_fmmt_d[l_ac].fmmt001_desc
            LET g_fmms_m_o.* = g_fmms_m.*  #160822-00012#2
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt001
            #add-point:BEFORE FIELD fmmt001 name="input.b.page1.fmmt001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmt001
            #add-point:ON CHANGE fmmt001 name="input.g.page1.fmmt001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt002
            #add-point:BEFORE FIELD fmmt002 name="input.b.page1.fmmt002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt002
            
            #add-point:AFTER FIELD fmmt002 name="input.a.page1.fmmt002"
            IF NOT cl_null(g_fmmt_d[l_ac].fmmt002) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fmmt_d[l_ac].fmmt002 != g_fmmt_d_t.fmmt002 OR g_fmmt_d_t.fmmt002 IS NULL )) THEN #160822-00012#2 mark
               IF g_fmmt_d[l_ac].fmmt002 != g_fmmt_d_o.fmmt002 OR cl_null(g_fmmt_d_o.fmmt002) THEN  #160822-00012#2
                  CALL afmt560_fmmt002_chk() RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_fmmt_d[l_ac].fmmt002 = g_fmmt_d_t.fmmt002 #160822-00012#2 mark
                     LET g_fmmt_d[l_ac].fmmt002 = g_fmmt_d_o.fmmt002 #160822-00012#2
                     NEXT FIELD CURRENT
                  END IF
               END IF 
               CALL afmt560_fmmt02_get_detail()
            END IF
            LET g_fmms_m_o.* = g_fmms_m.*  #160822-00012#2
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmt002
            #add-point:ON CHANGE fmmt002 name="input.g.page1.fmmt002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt017
            #add-point:BEFORE FIELD fmmt017 name="input.b.page1.fmmt017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt017
            
            #add-point:AFTER FIELD fmmt017 name="input.a.page1.fmmt017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmt017
            #add-point:ON CHANGE fmmt017 name="input.g.page1.fmmt017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmt_d[l_ac].fmmt010,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmt010
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmt010 name="input.a.page1.fmmt010"
            #150820-00011#11 add ------
            IF NOT cl_null(g_fmmt_d[l_ac].fmmt010) THEN 
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fmmt_d[l_ac].fmmt010 != g_fmmt_d_t.fmmt010 OR g_fmmt_d_t.fmmt010 IS NULL )) THEN   #160822-00012#4   mark
               IF g_fmmt_d[l_ac].fmmt010 != g_fmmt_d_o.fmmt010 OR cl_null(g_fmmt_d_o.fmmt010) THEN                                       #160822-00012#4   add
                  CALL s_curr_round_ld('1',g_glaald,g_fmmt_d[l_ac].fmmt003,g_fmmt_d[l_ac].fmmt010,2) RETURNING g_sub_success,g_errno,g_fmmt_d[l_ac].fmmt010
                  IF cl_null(g_fmmt_d[l_ac].fmmt011) THEN LET g_fmmt_d[l_ac].fmmt011 = 0 END IF
                  CALL s_curr_round_ld('1',g_glaald,g_fmmt_d[l_ac].fmmt003,g_fmmt_d[l_ac].fmmt011,2) RETURNING g_sub_success,g_errno,g_fmmt_d[l_ac].fmmt011
                  #投資收益=本期計提金額+利息調整
                  LET g_fmmt_d[l_ac].fmmt012 = g_fmmt_d[l_ac].fmmt010 + g_fmmt_d[l_ac].fmmt011
                  #151029-00012#10 add ------
                  #本幣計算
                  #計提金額
                  LET g_fmmt_d[l_ac].fmmt014 = g_fmmt_d[l_ac].fmmt010 * g_fmmt_d[l_ac].fmmt013
                  CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_fmmt_d[l_ac].fmmt014,2) RETURNING g_sub_success,g_errno,g_fmmt_d[l_ac].fmmt014
                  #投資收益=本期計提金額+利息調整
                  LET g_fmmt_d[l_ac].fmmt016 = g_fmmt_d[l_ac].fmmt014 + g_fmmt_d[l_ac].fmmt015
                  #151029-00012#10 add end---
               END IF
            END IF
            #150820-00011#11 add end---
            LET g_fmmt_d_o.* = g_fmmt_d[l_ac].*  #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt010
            #add-point:BEFORE FIELD fmmt010 name="input.b.page1.fmmt010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmt010
            #add-point:ON CHANGE fmmt010 name="input.g.page1.fmmt010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmt_d[l_ac].fmmt011,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmt011
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmt011 name="input.a.page1.fmmt011"
            IF NOT cl_null(g_fmmt_d[l_ac].fmmt011) THEN 
               #151125 albireo-----s
               LET g_fmmt_d[l_ac].fmmt012 = g_fmmt_d[l_ac].fmmt010 + g_fmmt_d[l_ac].fmmt011
               LET g_fmmt_d[l_ac].fmmt015 = g_fmmt_d[l_ac].fmmt011 * g_fmmt_d[l_ac].fmmt013
               CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_fmmt_d[l_ac].fmmt015,2) RETURNING g_sub_success,g_errno,g_fmmt_d[l_ac].fmmt015               
               #本幣取位
               LET g_fmmt_d[l_ac].fmmt016 = g_fmmt_d[l_ac].fmmt014 + g_fmmt_d[l_ac].fmmt015
               #151125 albireo-----e
            END IF 
            LET g_fmmt_d_o.* = g_fmmt_d[l_ac].*  #160822-00012#4   add

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt011
            #add-point:BEFORE FIELD fmmt011 name="input.b.page1.fmmt011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmt011
            #add-point:ON CHANGE fmmt011 name="input.g.page1.fmmt011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmt_d[l_ac].fmmt012,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmt012
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmt012 name="input.a.page1.fmmt012"
            IF NOT cl_null(g_fmmt_d[l_ac].fmmt012) THEN 
            END IF 

            LET g_fmmt_d_o.* = g_fmmt_d[l_ac].*  #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt012
            #add-point:BEFORE FIELD fmmt012 name="input.b.page1.fmmt012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmt012
            #add-point:ON CHANGE fmmt012 name="input.g.page1.fmmt012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmt_d[l_ac].fmmt013,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmt013
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmt013 name="input.a.page1.fmmt013"
            IF NOT cl_null(g_fmmt_d[l_ac].fmmt013) THEN 
            END IF 

            LET g_fmmt_d_o.* = g_fmmt_d[l_ac].*  #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt013
            #add-point:BEFORE FIELD fmmt013 name="input.b.page1.fmmt013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmt013
            #add-point:ON CHANGE fmmt013 name="input.g.page1.fmmt013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt014
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmt_d[l_ac].fmmt014,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmt014
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmt014 name="input.a.page1.fmmt014"
            IF NOT cl_null(g_fmmt_d[l_ac].fmmt014) THEN 
            END IF 

            LET g_fmmt_d_o.* = g_fmmt_d[l_ac].*  #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt014
            #add-point:BEFORE FIELD fmmt014 name="input.b.page1.fmmt014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmt014
            #add-point:ON CHANGE fmmt014 name="input.g.page1.fmmt014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmt_d[l_ac].fmmt015,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmt015
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmt015 name="input.a.page1.fmmt015"
            IF NOT cl_null(g_fmmt_d[l_ac].fmmt015) THEN 
            END IF 

            LET g_fmmt_d_o.* = g_fmmt_d[l_ac].*  #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt015
            #add-point:BEFORE FIELD fmmt015 name="input.b.page1.fmmt015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmt015
            #add-point:ON CHANGE fmmt015 name="input.g.page1.fmmt015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt016
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmmt_d[l_ac].fmmt016,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fmmt016
            END IF 
 
 
 
            #add-point:AFTER FIELD fmmt016 name="input.a.page1.fmmt016"
            IF NOT cl_null(g_fmmt_d[l_ac].fmmt016) THEN 
            END IF 

            LET g_fmmt_d_o.* = g_fmmt_d[l_ac].*  #160822-00012#4   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt016
            #add-point:BEFORE FIELD fmmt016 name="input.b.page1.fmmt016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmt016
            #add-point:ON CHANGE fmmt016 name="input.g.page1.fmmt016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt018
            #add-point:BEFORE FIELD fmmt018 name="input.b.page1.fmmt018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt018
            
            #add-point:AFTER FIELD fmmt018 name="input.a.page1.fmmt018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmt018
            #add-point:ON CHANGE fmmt018 name="input.g.page1.fmmt018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmt019
            #add-point:BEFORE FIELD fmmt019 name="input.b.page1.fmmt019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmt019
            
            #add-point:AFTER FIELD fmmt019 name="input.a.page1.fmmt019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmt019
            #add-point:ON CHANGE fmmt019 name="input.g.page1.fmmt019"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.fmmtseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmtseq
            #add-point:ON ACTION controlp INFIELD fmmtseq name="input.c.page1.fmmtseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmt001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt001
            #add-point:ON ACTION controlp INFIELD fmmt001 name="input.c.page1.fmmt001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmt_d[l_ac].fmmt001
            LET g_qryparam.where    = " ooef017 = '",g_fmms_m.fmmscomp ,"' "
            #CALL q_ooef001()                       #161006-00005#34   mark
            CALL q_ooef001_33()                     #161006-00005#34   add 
            LET g_fmmt_d[l_ac].fmmt001 = g_qryparam.return1              
            DISPLAY g_fmmt_d[l_ac].fmmt001 TO fmmt001
            NEXT FIELD fmmt001
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmt002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt002
            #add-point:ON ACTION controlp INFIELD fmmt002 name="input.c.page1.fmmt002"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmmt_d[l_ac].fmmt003
            CALL g_ar.clear()
            LET g_ar[1].dat = g_accdate_s
            LET g_ar[2].dat = g_accdate_e
            LET g_ar[1].num = g_fmms_m.fmms001
            LET g_ar[2].num = g_fmms_m.fmms002
            LET g_ar[1].chr = g_fmmt_d[l_ac].fmmt001
            CALL s_afmp500_get_wc('2',g_ar) RETURNING g_qryparam.where
            CALL q_fmmjdocno()
            LET g_fmmt_d[l_ac].fmmt002 = g_qryparam.return1              
            DISPLAY g_fmmt_d[l_ac].fmmt002 TO fmmt002
            NEXT FIELD fmmt002
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmt017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt017
            #add-point:ON ACTION controlp INFIELD fmmt017 name="input.c.page1.fmmt017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmt010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt010
            #add-point:ON ACTION controlp INFIELD fmmt010 name="input.c.page1.fmmt010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmt011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt011
            #add-point:ON ACTION controlp INFIELD fmmt011 name="input.c.page1.fmmt011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmt012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt012
            #add-point:ON ACTION controlp INFIELD fmmt012 name="input.c.page1.fmmt012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmt013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt013
            #add-point:ON ACTION controlp INFIELD fmmt013 name="input.c.page1.fmmt013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmt014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt014
            #add-point:ON ACTION controlp INFIELD fmmt014 name="input.c.page1.fmmt014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmt015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt015
            #add-point:ON ACTION controlp INFIELD fmmt015 name="input.c.page1.fmmt015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmt016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt016
            #add-point:ON ACTION controlp INFIELD fmmt016 name="input.c.page1.fmmt016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmt018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt018
            #add-point:ON ACTION controlp INFIELD fmmt018 name="input.c.page1.fmmt018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmmt019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmt019
            #add-point:ON ACTION controlp INFIELD fmmt019 name="input.c.page1.fmmt019"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fmmt_d[l_ac].* = g_fmmt_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afmt560_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_fmmt_d[l_ac].fmmtseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_fmmt_d[l_ac].* = g_fmmt_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL afmt560_fmmt_t_mask_restore('restore_mask_o')
      
               UPDATE fmmt_t SET (fmmtdocno,fmmtseq,fmmt001,fmmt002,fmmt003,fmmt017,fmmt004,fmmt005, 
                   fmmt006,fmmt007,fmmt008,fmmt009,fmmt010,fmmt011,fmmt012,fmmt013,fmmt014,fmmt015,fmmt016, 
                   fmmt018,fmmt019) = (g_fmms_m.fmmsdocno,g_fmmt_d[l_ac].fmmtseq,g_fmmt_d[l_ac].fmmt001, 
                   g_fmmt_d[l_ac].fmmt002,g_fmmt_d[l_ac].fmmt003,g_fmmt_d[l_ac].fmmt017,g_fmmt_d[l_ac].fmmt004, 
                   g_fmmt_d[l_ac].fmmt005,g_fmmt_d[l_ac].fmmt006,g_fmmt_d[l_ac].fmmt007,g_fmmt_d[l_ac].fmmt008, 
                   g_fmmt_d[l_ac].fmmt009,g_fmmt_d[l_ac].fmmt010,g_fmmt_d[l_ac].fmmt011,g_fmmt_d[l_ac].fmmt012, 
                   g_fmmt_d[l_ac].fmmt013,g_fmmt_d[l_ac].fmmt014,g_fmmt_d[l_ac].fmmt015,g_fmmt_d[l_ac].fmmt016, 
                   g_fmmt_d[l_ac].fmmt018,g_fmmt_d[l_ac].fmmt019)
                WHERE fmmtent = g_enterprise AND fmmtdocno = g_fmms_m.fmmsdocno 
 
                  AND fmmtseq = g_fmmt_d_t.fmmtseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmmt_d[l_ac].* = g_fmmt_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmmt_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fmmt_d[l_ac].* = g_fmmt_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmmt_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmms_m.fmmsdocno
               LET gs_keys_bak[1] = g_fmmsdocno_t
               LET gs_keys[2] = g_fmmt_d[g_detail_idx].fmmtseq
               LET gs_keys_bak[2] = g_fmmt_d_t.fmmtseq
               CALL afmt560_update_b('fmmt_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL afmt560_fmmt_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_fmmt_d[g_detail_idx].fmmtseq = g_fmmt_d_t.fmmtseq 
 
                  ) THEN
                  LET gs_keys[01] = g_fmms_m.fmmsdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_fmmt_d_t.fmmtseq
 
                  CALL afmt560_key_update_b(gs_keys,'fmmt_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmms_m),util.JSON.stringify(g_fmmt_d_t)
               LET g_log2 = util.JSON.stringify(g_fmms_m),util.JSON.stringify(g_fmmt_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL afmt560_unlock_b("fmmt_t","'1'")
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
               LET g_fmmt_d[li_reproduce_target].* = g_fmmt_d[li_reproduce].*
 
               LET g_fmmt_d[li_reproduce_target].fmmtseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmmt_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmmt_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="afmt560.input.other" >}
      
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
            NEXT FIELD fmmsdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD fmmtseq
 
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
 
{<section id="afmt560.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION afmt560_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL afmt560_b_fill() #單身填充
      CALL afmt560_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afmt560_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL afmt560_set_ld_info()
   #end add-point
   
   #遮罩相關處理
   LET g_fmms_m_mask_o.* =  g_fmms_m.*
   CALL afmt560_fmms_t_mask()
   LET g_fmms_m_mask_n.* =  g_fmms_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fmms_m.fmmscomp,g_fmms_m.fmmscomp_desc,g_fmms_m.fmmsdocno,g_fmms_m.fmmsdocno_desc, 
       g_fmms_m.fmms001,g_fmms_m.fmms002,g_fmms_m.fmmsstus,g_fmms_m.fmmsownid,g_fmms_m.fmmsownid_desc, 
       g_fmms_m.fmmsowndp,g_fmms_m.fmmsowndp_desc,g_fmms_m.fmmscrtid,g_fmms_m.fmmscrtid_desc,g_fmms_m.fmmscrtdp, 
       g_fmms_m.fmmscrtdp_desc,g_fmms_m.fmmscrtdt,g_fmms_m.fmmsmodid,g_fmms_m.fmmsmodid_desc,g_fmms_m.fmmsmoddt, 
       g_fmms_m.fmmscnfid,g_fmms_m.fmmscnfid_desc,g_fmms_m.fmmscnfdt,g_fmms_m.fmmspstid,g_fmms_m.fmmspstid_desc, 
       g_fmms_m.fmmspstdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmms_m.fmmsstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_fmmt_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL afmt560_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afmt560.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION afmt560_detail_show()
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
 
{<section id="afmt560.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afmt560_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE fmms_t.fmmsdocno 
   DEFINE l_oldno     LIKE fmms_t.fmmsdocno 
 
   DEFINE l_master    RECORD LIKE fmms_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE fmmt_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_fmms_m.fmmsdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_fmmsdocno_t = g_fmms_m.fmmsdocno
 
    
   LET g_fmms_m.fmmsdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmms_m.fmmsownid = g_user
      LET g_fmms_m.fmmsowndp = g_dept
      LET g_fmms_m.fmmscrtid = g_user
      LET g_fmms_m.fmmscrtdp = g_dept 
      LET g_fmms_m.fmmscrtdt = cl_get_current()
      LET g_fmms_m.fmmsmodid = g_user
      LET g_fmms_m.fmmsmoddt = cl_get_current()
      LET g_fmms_m.fmmsstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   CALL g_fmmt_d.clear()
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmms_m.fmmsstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_fmms_m.fmmsdocno_desc = ''
   DISPLAY BY NAME g_fmms_m.fmmsdocno_desc
 
   
   CALL afmt560_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_fmms_m.* TO NULL
      INITIALIZE g_fmmt_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL afmt560_show()
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
   CALL afmt560_set_act_visible()   
   CALL afmt560_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fmmsdocno_t = g_fmms_m.fmmsdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmmsent = " ||g_enterprise|| " AND",
                      " fmmsdocno = '", g_fmms_m.fmmsdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt560_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL afmt560_idx_chk()
   
   LET g_data_owner = g_fmms_m.fmmsownid      
   LET g_data_dept  = g_fmms_m.fmmsowndp
   
   #功能已完成,通報訊息中心
   CALL afmt560_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="afmt560.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION afmt560_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE fmmt_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE afmt560_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   CALL s_transaction_end('N','0')
   RETURN
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fmmt_t
    WHERE fmmtent = g_enterprise AND fmmtdocno = g_fmmsdocno_t
 
    INTO TEMP afmt560_detail
 
   #將key修正為調整後   
   UPDATE afmt560_detail 
      #更新key欄位
      SET fmmtdocno = g_fmms_m.fmmsdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO fmmt_t SELECT * FROM afmt560_detail
   
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
   DROP TABLE afmt560_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_fmmsdocno_t = g_fmms_m.fmmsdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="afmt560.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afmt560_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_docdt          LIKE type_t.dat
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_fmms_m.fmmsdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN afmt560_cl USING g_enterprise,g_fmms_m.fmmsdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt560_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afmt560_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt560_master_referesh USING g_fmms_m.fmmsdocno INTO g_fmms_m.fmmscomp,g_fmms_m.fmmsdocno, 
       g_fmms_m.fmms001,g_fmms_m.fmms002,g_fmms_m.fmmsstus,g_fmms_m.fmmsownid,g_fmms_m.fmmsowndp,g_fmms_m.fmmscrtid, 
       g_fmms_m.fmmscrtdp,g_fmms_m.fmmscrtdt,g_fmms_m.fmmsmodid,g_fmms_m.fmmsmoddt,g_fmms_m.fmmscnfid, 
       g_fmms_m.fmmscnfdt,g_fmms_m.fmmspstid,g_fmms_m.fmmspstdt,g_fmms_m.fmmscomp_desc,g_fmms_m.fmmsownid_desc, 
       g_fmms_m.fmmsowndp_desc,g_fmms_m.fmmscrtid_desc,g_fmms_m.fmmscrtdp_desc,g_fmms_m.fmmsmodid_desc, 
       g_fmms_m.fmmscnfid_desc,g_fmms_m.fmmspstid_desc
   
   
   #檢查是否允許此動作
   IF NOT afmt560_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmms_m_mask_o.* =  g_fmms_m.*
   CALL afmt560_fmms_t_mask()
   LET g_fmms_m_mask_n.* =  g_fmms_m.*
   
   CALL afmt560_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afmt560_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_fmmsdocno_t = g_fmms_m.fmmsdocno
 
 
      DELETE FROM fmms_t
       WHERE fmmsent = g_enterprise AND fmmsdocno = g_fmms_m.fmmsdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_fmms_m.fmmsdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      #150401-00001#33
      LET l_docdt = MDY(g_fmms_m.fmms002,1,g_fmms_m.fmms001)
      LET l_docdt = s_date_get_last_date(l_docdt)
      #150401-00001#33
      IF NOT s_aooi200_fin_del_docno(g_glaald,g_fmms_m.fmmsdocno ,l_docdt) THEN        #150401-00001#33
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM fmmt_t
       WHERE fmmtent = g_enterprise AND fmmtdocno = g_fmms_m.fmmsdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmmt_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_fmms_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE afmt560_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_fmmt_d.clear() 
 
     
      CALL afmt560_ui_browser_refresh()  
      #CALL afmt560_ui_headershow()  
      #CALL afmt560_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL afmt560_browser_fill("")
         CALL afmt560_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afmt560_cl
 
   #功能已完成,通報訊息中心
   CALL afmt560_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="afmt560.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmt560_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_fmmt_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL g_fmmt2_d.clear()    #151117-00001#4
   #end add-point
   
   #判斷是否填充
   IF afmt560_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT fmmtseq,fmmt001,fmmt002,fmmt003,fmmt017,fmmt004,fmmt005,fmmt006, 
             fmmt007,fmmt008,fmmt009,fmmt010,fmmt011,fmmt012,fmmt013,fmmt014,fmmt015,fmmt016,fmmt018, 
             fmmt019 ,t1.ooefl004 FROM fmmt_t",   
                     " INNER JOIN fmms_t ON fmmsent = " ||g_enterprise|| " AND fmmsdocno = fmmtdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=fmmt001 AND t1.ooefl002='"||g_dlang||"' ",
 
                     " WHERE fmmtent=? AND fmmtdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fmmt_t.fmmtseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt560_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR afmt560_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_fmms_m.fmmsdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_fmms_m.fmmsdocno INTO g_fmmt_d[l_ac].fmmtseq,g_fmmt_d[l_ac].fmmt001, 
          g_fmmt_d[l_ac].fmmt002,g_fmmt_d[l_ac].fmmt003,g_fmmt_d[l_ac].fmmt017,g_fmmt_d[l_ac].fmmt004, 
          g_fmmt_d[l_ac].fmmt005,g_fmmt_d[l_ac].fmmt006,g_fmmt_d[l_ac].fmmt007,g_fmmt_d[l_ac].fmmt008, 
          g_fmmt_d[l_ac].fmmt009,g_fmmt_d[l_ac].fmmt010,g_fmmt_d[l_ac].fmmt011,g_fmmt_d[l_ac].fmmt012, 
          g_fmmt_d[l_ac].fmmt013,g_fmmt_d[l_ac].fmmt014,g_fmmt_d[l_ac].fmmt015,g_fmmt_d[l_ac].fmmt016, 
          g_fmmt_d[l_ac].fmmt018,g_fmmt_d[l_ac].fmmt019,g_fmmt_d[l_ac].fmmt001_desc   #(ver:78)
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
   CALL afmt560_b_fill3(1)
   #end add-point
   
   CALL g_fmmt_d.deleteElement(g_fmmt_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE afmt560_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_fmmt_d.getLength()
      LET g_fmmt_d_mask_o[l_ac].* =  g_fmmt_d[l_ac].*
      CALL afmt560_fmmt_t_mask()
      LET g_fmmt_d_mask_n[l_ac].* =  g_fmmt_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="afmt560.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afmt560_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM fmmt_t
       WHERE fmmtent = g_enterprise AND
         fmmtdocno = ps_keys_bak[1] AND fmmtseq = ps_keys_bak[2]
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
         CALL g_fmmt_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt560.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afmt560_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO fmmt_t
                  (fmmtent,
                   fmmtdocno,
                   fmmtseq
                   ,fmmt001,fmmt002,fmmt003,fmmt017,fmmt004,fmmt005,fmmt006,fmmt007,fmmt008,fmmt009,fmmt010,fmmt011,fmmt012,fmmt013,fmmt014,fmmt015,fmmt016,fmmt018,fmmt019) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_fmmt_d[g_detail_idx].fmmt001,g_fmmt_d[g_detail_idx].fmmt002,g_fmmt_d[g_detail_idx].fmmt003, 
                       g_fmmt_d[g_detail_idx].fmmt017,g_fmmt_d[g_detail_idx].fmmt004,g_fmmt_d[g_detail_idx].fmmt005, 
                       g_fmmt_d[g_detail_idx].fmmt006,g_fmmt_d[g_detail_idx].fmmt007,g_fmmt_d[g_detail_idx].fmmt008, 
                       g_fmmt_d[g_detail_idx].fmmt009,g_fmmt_d[g_detail_idx].fmmt010,g_fmmt_d[g_detail_idx].fmmt011, 
                       g_fmmt_d[g_detail_idx].fmmt012,g_fmmt_d[g_detail_idx].fmmt013,g_fmmt_d[g_detail_idx].fmmt014, 
                       g_fmmt_d[g_detail_idx].fmmt015,g_fmmt_d[g_detail_idx].fmmt016,g_fmmt_d[g_detail_idx].fmmt018, 
                       g_fmmt_d[g_detail_idx].fmmt019)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmmt_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_fmmt_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="afmt560.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afmt560_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fmmt_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL afmt560_fmmt_t_mask_restore('restore_mask_o')
               
      UPDATE fmmt_t 
         SET (fmmtdocno,
              fmmtseq
              ,fmmt001,fmmt002,fmmt003,fmmt017,fmmt004,fmmt005,fmmt006,fmmt007,fmmt008,fmmt009,fmmt010,fmmt011,fmmt012,fmmt013,fmmt014,fmmt015,fmmt016,fmmt018,fmmt019) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_fmmt_d[g_detail_idx].fmmt001,g_fmmt_d[g_detail_idx].fmmt002,g_fmmt_d[g_detail_idx].fmmt003, 
                  g_fmmt_d[g_detail_idx].fmmt017,g_fmmt_d[g_detail_idx].fmmt004,g_fmmt_d[g_detail_idx].fmmt005, 
                  g_fmmt_d[g_detail_idx].fmmt006,g_fmmt_d[g_detail_idx].fmmt007,g_fmmt_d[g_detail_idx].fmmt008, 
                  g_fmmt_d[g_detail_idx].fmmt009,g_fmmt_d[g_detail_idx].fmmt010,g_fmmt_d[g_detail_idx].fmmt011, 
                  g_fmmt_d[g_detail_idx].fmmt012,g_fmmt_d[g_detail_idx].fmmt013,g_fmmt_d[g_detail_idx].fmmt014, 
                  g_fmmt_d[g_detail_idx].fmmt015,g_fmmt_d[g_detail_idx].fmmt016,g_fmmt_d[g_detail_idx].fmmt018, 
                  g_fmmt_d[g_detail_idx].fmmt019) 
         WHERE fmmtent = g_enterprise AND fmmtdocno = ps_keys_bak[1] AND fmmtseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmmt_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmmt_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afmt560_fmmt_t_mask_restore('restore_mask_n')
               
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
 
{<section id="afmt560.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION afmt560_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="afmt560.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION afmt560_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="afmt560.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afmt560_lock_b(ps_table,ps_page)
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
   #CALL afmt560_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "fmmt_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afmt560_bcl USING g_enterprise,
                                       g_fmms_m.fmmsdocno,g_fmmt_d[g_detail_idx].fmmtseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afmt560_bcl:",SQLERRMESSAGE 
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
 
{<section id="afmt560.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afmt560_unlock_b(ps_table,ps_page)
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
      CLOSE afmt560_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="afmt560.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afmt560_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("fmmsdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("fmmsdocno",TRUE)
      CALL cl_set_comp_entry("",TRUE)
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
 
{<section id="afmt560.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afmt560_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("fmmsdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("fmmsdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt560.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afmt560_set_entry_b(p_cmd)
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
 
{<section id="afmt560.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afmt560_set_no_entry_b(p_cmd)
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
 
{<section id="afmt560.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afmt560_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,modify_detail", TRUE) 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt560.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afmt560_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   DEFINE l_count    LIKE type_t.num10   #151117-00001#4
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_fmms_m.fmmsstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #CALL cl_set_act_visible("output", FALSE)   #151217-00011#3 20151218 By sakura mark

   #151117-00001#4-----s
   #單身無計息來源為3計息的就不可輸入
   LET l_count = NULL
   #SELECT COUNT(*) INTO l_count FROM fmmt_t #160822-00012#2 mark
   SELECT COUNT(1) INTO l_count FROM fmmt_t #160822-00012#2
    WHERE fmmtent = g_enterprise
      AND fmmtdocno = g_fmms_m.fmmsdocno
      AND fmmt017   IN ('1','2')
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   IF l_count > 0 THEN
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #151117-00001#4-----e

   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt560.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION afmt560_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt560.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION afmt560_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt560.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afmt560_default_search()
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
      LET ls_wc = ls_wc, " fmmsdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "fmms_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "fmmt_t" 
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
 
{<section id="afmt560.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afmt560_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_date   DATETIME YEAR TO SECOND
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   CALL afmt560_ui_headershow()
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_fmms_m.fmmsdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN afmt560_cl USING g_enterprise,g_fmms_m.fmmsdocno
   IF STATUS THEN
      CLOSE afmt560_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt560_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afmt560_master_referesh USING g_fmms_m.fmmsdocno INTO g_fmms_m.fmmscomp,g_fmms_m.fmmsdocno, 
       g_fmms_m.fmms001,g_fmms_m.fmms002,g_fmms_m.fmmsstus,g_fmms_m.fmmsownid,g_fmms_m.fmmsowndp,g_fmms_m.fmmscrtid, 
       g_fmms_m.fmmscrtdp,g_fmms_m.fmmscrtdt,g_fmms_m.fmmsmodid,g_fmms_m.fmmsmoddt,g_fmms_m.fmmscnfid, 
       g_fmms_m.fmmscnfdt,g_fmms_m.fmmspstid,g_fmms_m.fmmspstdt,g_fmms_m.fmmscomp_desc,g_fmms_m.fmmsownid_desc, 
       g_fmms_m.fmmsowndp_desc,g_fmms_m.fmmscrtid_desc,g_fmms_m.fmmscrtdp_desc,g_fmms_m.fmmsmodid_desc, 
       g_fmms_m.fmmscnfid_desc,g_fmms_m.fmmspstid_desc
   
 
   #檢查是否允許此動作
   IF NOT afmt560_action_chk() THEN
      CLOSE afmt560_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmms_m.fmmscomp,g_fmms_m.fmmscomp_desc,g_fmms_m.fmmsdocno,g_fmms_m.fmmsdocno_desc, 
       g_fmms_m.fmms001,g_fmms_m.fmms002,g_fmms_m.fmmsstus,g_fmms_m.fmmsownid,g_fmms_m.fmmsownid_desc, 
       g_fmms_m.fmmsowndp,g_fmms_m.fmmsowndp_desc,g_fmms_m.fmmscrtid,g_fmms_m.fmmscrtid_desc,g_fmms_m.fmmscrtdp, 
       g_fmms_m.fmmscrtdp_desc,g_fmms_m.fmmscrtdt,g_fmms_m.fmmsmodid,g_fmms_m.fmmsmodid_desc,g_fmms_m.fmmsmoddt, 
       g_fmms_m.fmmscnfid,g_fmms_m.fmmscnfid_desc,g_fmms_m.fmmscnfdt,g_fmms_m.fmmspstid,g_fmms_m.fmmspstid_desc, 
       g_fmms_m.fmmspstdt
 
   CASE g_fmms_m.fmmsstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_fmms_m.fmmsstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_fmms_m.fmmsstus
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
            CALL s_transaction_end('N','0')      #150401-00001#13
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
            IF NOT afmt560_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt560_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT afmt560_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt560_cl
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
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
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
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      ) OR 
      g_fmms_m.fmmsstus = lc_state OR cl_null(lc_state) THEN
      CLOSE afmt560_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_date = cl_get_current()
   #確認
   #161026-00023#12   mark---s
   #IF lc_state = 'Y' THEN
   #   IF NOT afmt560_conf_chk()  THEN
   #      CALL s_transaction_end('N','0')     #150401-00001#13   
   #      RETURN    #一定要RETURN,避免執行後面的UPDATE狀態的程式段
   #   ELSE
   #      IF NOT cl_ask_confirm('aim-00108') THEN
   #         CALL s_transaction_end('N','0')  #150401-00001#13    
   #         RETURN
   #      ELSE
   #         UPDATE fmms_t SET fmmsmodid = g_user,fmmsmoddt = l_date,
   #                           fmmscnfid = g_user,fmmscnfdt = l_date,
   #                           fmmsstus = 'Y'
   #          WHERE fmmsent = g_enterprise
   #            AND fmmsdocno = g_fmms_m.fmmsdocno
   #         IF SQLCA.SQLERRD[3] = 0 THEN
   #            CALL s_transaction_end('N','0')
   #            RETURN
   #         ELSE
   #            CALL s_transaction_end('Y','0')
   #         END IF
   #      END IF
   #   END IF
   #END IF
   #161026-00023#12   mark---e
   
   #161026-00023#12   add---s
   IF lc_state = 'Y' THEN
      CALL cl_err_collect_init()
      IF NOT s_afmt560_conf_chk(g_fmms_m.fmmsdocno)  THEN
         CALL s_transaction_end('N','0')  
         CALL cl_err_collect_show()
         RETURN    #一定要RETURN,避免執行後面的UPDATE狀態的程式段
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL s_transaction_end('N','0') 
            CALL cl_err_collect_show()   
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_afmt560_conf_upd(g_fmms_m.fmmsdocno) THEN
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
   #161026-00023#12   add---e
   
   #取消確認
   IF lc_state = 'N' THEN
      IF NOT afmt560_unconf_chk()  THEN
         CALL s_transaction_end('N','0')     #150401-00001#13
         RETURN    #一定要RETURN,避免執行後面的UPDATE狀態的程式段
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN
            CALL s_transaction_end('N','0')  #150401-00001#13
            RETURN
         ELSE
            UPDATE fmms_t SET fmmsmodid = g_user,fmmsmoddt = l_date,
                              fmmscnfid = '',fmmscnfdt = '',
                              fmmsstus = 'N'
             WHERE fmmsent = g_enterprise
               AND fmmsdocno = g_fmms_m.fmmsdocno
            IF SQLCA.SQLERRD[3] = 0 THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   #作廢
   IF lc_state = 'X' THEN
      IF NOT afmt560_void_chk()  THEN
         CALL s_transaction_end('N','0')     #150401-00001#13
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL s_transaction_end('N','0')  #150401-00001#13
            RETURN
         ELSE
            UPDATE fmms_t SET fmmsmodid = g_user,fmmsmoddt = l_date,
                              fmmsstus = 'X'
             WHERE fmmsent = g_enterprise
               AND fmmsdocno = g_fmms_m.fmmsdocno
            IF SQLCA.SQLERRD[3] = 0 THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF         
         END IF
      END IF    
   END IF
   #end add-point
   
   LET g_fmms_m.fmmsmodid = g_user
   LET g_fmms_m.fmmsmoddt = cl_get_current()
   LET g_fmms_m.fmmsstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE fmms_t 
      SET (fmmsstus,fmmsmodid,fmmsmoddt) 
        = (g_fmms_m.fmmsstus,g_fmms_m.fmmsmodid,g_fmms_m.fmmsmoddt)     
    WHERE fmmsent = g_enterprise AND fmmsdocno = g_fmms_m.fmmsdocno
 
    
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
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE afmt560_master_referesh USING g_fmms_m.fmmsdocno INTO g_fmms_m.fmmscomp,g_fmms_m.fmmsdocno, 
          g_fmms_m.fmms001,g_fmms_m.fmms002,g_fmms_m.fmmsstus,g_fmms_m.fmmsownid,g_fmms_m.fmmsowndp, 
          g_fmms_m.fmmscrtid,g_fmms_m.fmmscrtdp,g_fmms_m.fmmscrtdt,g_fmms_m.fmmsmodid,g_fmms_m.fmmsmoddt, 
          g_fmms_m.fmmscnfid,g_fmms_m.fmmscnfdt,g_fmms_m.fmmspstid,g_fmms_m.fmmspstdt,g_fmms_m.fmmscomp_desc, 
          g_fmms_m.fmmsownid_desc,g_fmms_m.fmmsowndp_desc,g_fmms_m.fmmscrtid_desc,g_fmms_m.fmmscrtdp_desc, 
          g_fmms_m.fmmsmodid_desc,g_fmms_m.fmmscnfid_desc,g_fmms_m.fmmspstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_fmms_m.fmmscomp,g_fmms_m.fmmscomp_desc,g_fmms_m.fmmsdocno,g_fmms_m.fmmsdocno_desc, 
          g_fmms_m.fmms001,g_fmms_m.fmms002,g_fmms_m.fmmsstus,g_fmms_m.fmmsownid,g_fmms_m.fmmsownid_desc, 
          g_fmms_m.fmmsowndp,g_fmms_m.fmmsowndp_desc,g_fmms_m.fmmscrtid,g_fmms_m.fmmscrtid_desc,g_fmms_m.fmmscrtdp, 
          g_fmms_m.fmmscrtdp_desc,g_fmms_m.fmmscrtdt,g_fmms_m.fmmsmodid,g_fmms_m.fmmsmodid_desc,g_fmms_m.fmmsmoddt, 
          g_fmms_m.fmmscnfid,g_fmms_m.fmmscnfid_desc,g_fmms_m.fmmscnfdt,g_fmms_m.fmmspstid,g_fmms_m.fmmspstid_desc, 
          g_fmms_m.fmmspstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE afmt560_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt560_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt560.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION afmt560_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_fmmt_d.getLength() THEN
         LET g_detail_idx = g_fmmt_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmmt_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmmt_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afmt560.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afmt560_b_fill2(pi_idx)
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
   
   CALL afmt560_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="afmt560.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION afmt560_fill_chk(ps_idx)
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
 
{<section id="afmt560.status_show" >}
PRIVATE FUNCTION afmt560_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt560.mask_functions" >}
&include "erp/afm/afmt560_mask.4gl"
 
{</section>}
 
{<section id="afmt560.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION afmt560_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL afmt560_show()
   CALL afmt560_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_fmms_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_fmmt_d))
 
 
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
   #CALL afmt560_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL afmt560_ui_headershow()
   CALL afmt560_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION afmt560_draw_out()
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
   CALL afmt560_ui_headershow()  
   CALL afmt560_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="afmt560.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afmt560_set_pk_array()
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
   LET g_pk_array[1].values = g_fmms_m.fmmsdocno
   LET g_pk_array[1].column = 'fmmsdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt560.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="afmt560.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afmt560_msgcentre_notify(lc_state)
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
   CALL afmt560_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fmms_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt560.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afmt560_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#13 2016/08/23 By 07900 --add -s-
   SELECT fmmsstus INTO g_fmms_m.fmmsstus
     FROM fmms_t
    WHERE fmmsent = g_enterprise
      AND fmmsdocno = g_fmms_m.fmmsdocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_fmms_m.fmmsstus
      
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
        LET g_errparam.extend = g_fmms_m.fmmsdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL afmt560_set_act_visible()
        CALL afmt560_set_act_no_visible()
        CALL afmt560_show()
        RETURN FALSE
     END IF
   END IF
   
   #160818-00017#13 2016/08/23 By 07900 --add -e-
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt560.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 帳套相關資訊
# Memo...........:
# Date & Author..: 15/05/19 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt560_set_ld_info()
DEFINE l_num      LIKE type_t.num5
DEFINE l_glav004  LIKE glav_t.glav004

   WHENEVER ERROR CONTINUE
   IF cl_null(g_fmms_m.fmmscomp) THEN
      RETURN   
   END IF
   
   CALL s_fin_get_major_ld(g_fmms_m.fmmscomp) RETURNING g_glaald
   #151029-00012#10 add glaa001
   CALL s_ld_sel_glaa(g_glaald,'glaa001|glaa003|glaa024|glaa026')
        RETURNING g_sub_success,g_glaa001,g_glaa003,g_glaa024,g_glaa026
   
   #取得會計當期起始日
   CALL s_get_accdate(g_glaa003,'',g_fmms_m.fmms001,g_fmms_m.fmms002)
         RETURNING g_sub_success,g_errno,l_num,
                   l_num,l_glav004,l_glav004,
                   l_num,g_accdate_s,g_accdate_e,
                   l_num,l_glav004,l_glav004
   
   SELECT MAX(glav006) INTO g_glav006
     FROM glav_t
    WHERE glavent = g_enterprise 
      AND glav001 = g_glaa003 AND glav002 = g_fmms_m.fmms001
   
END FUNCTION

################################################################################
# Descriptions...: 檢核是否為有效的單據
# Memo...........:
# Date & Author..: 15/05/19 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt560_fmmt002_chk()
DEFINE r_success        LIKE type_t.num5
DEFINE r_errno          LIKE gzze_t.gzze001
DEFINE l_fmmjstus       LIKE fmmj_t.fmmjstus
DEFINE l_fmmjsite       LIKE fmmj_t.fmmjsite
DEFINE l_fmmj003        LIKE fmmj_t.fmmj003
DEFINE l_fmma002        LIKE fmma_t.fmma002
DEFINE l_cnt            LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   IF cl_null(g_fmmt_d[l_ac].fmmt001) THEN
      LET r_success = FALSE
      LET r_errno = 'afa-00451'
      RETURN r_success,r_errno
   END IF
   
   SELECT fmmjsite,fmmjstus,fmmj003
     INTO l_fmmjsite,l_fmmjstus,l_fmmj003
     FROM fmmj_t
    WHERE fmmjent = g_enterprise AND fmmjdocno = g_fmmt_d[l_ac].fmmt002
   SELECT fmma002 INTO l_fmma002
     FROM fmma_t
    WHERE fmmaent = g_enterprise AND fmma001 = l_fmmj003
    
   CASE
       WHEN SQLCA.SQLCODE = 100
            LET r_success = FALSE
            LET r_errno = 'sub-00029'
       WHEN l_fmmjstus <> 'Y'
            LET r_success = FALSE
            LET r_errno = 'aap-00118'
       WHEN l_fmmjsite <> g_fmmt_d[l_ac].fmmt001
            LET r_success = FALSE
            LET r_errno = 'afm-00115'
       WHEN l_fmma002 <> '1'
            LET r_success = FALSE
            LET r_errno = 'afm-00133'
   END CASE
   IF NOT r_success THEN
      RETURN r_success,r_errno
   END IF
   
   #判斷是否有存在別張
   LET l_cnt = 0
   #SELECT count(*) INTO l_cnt #160822-00012#2 mark
   SELECT count(1) INTO l_cnt  #160822-00012#2
     FROM fmms_t,fmmt_t
    WHERE fmmsent = fmmtent AND fmmsdocno = fmmtdocno
      AND fmmsent = g_enterprise 
      AND fmms001 = g_fmms_m.fmms001 AND fmms002 = g_fmms_m.fmms002
      AND fmmsdocno <> g_fmms_m.fmmsdocno
      AND fmmt002 = g_fmmt_d[l_ac].fmmt002
   IF l_cnt > 0 THEN
      LET r_success = FALSE
      LET r_errno = 'afm-00112'
      RETURN r_success,r_errno
   END IF
   
   LET l_cnt = 0
   #SELECT count(*) INTO l_cnt #160822-00012#2 mark
   SELECT count(1) INTO l_cnt  #160822-00012#2
     FROM fmms_t,fmmt_t
    WHERE fmmsent = fmmtent AND fmmsdocno = fmmtdocno
      AND fmmsent = g_enterprise 
      AND fmms001 = g_fmms_m.fmms001 AND fmms002 = g_fmms_m.fmms002
      AND fmmsdocno = g_fmms_m.fmmsdocno
      AND fmmt002 = g_fmmt_d[l_ac].fmmt002
      AND fmmtseq <> g_fmmt_d[l_ac].fmmtseq
   
   IF l_cnt > 0 THEN
      LET r_success = FALSE
      LET r_errno = 'afm-00112'
      RETURN r_success,r_errno
   END IF
   
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 取得購買單資料
# Memo...........:
# Date & Author..: 15/05/20 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt560_fmmt02_get_detail()
DEFINE l_fmmt        RECORD
         fmmtdocno   LIKE fmmt_t.fmmtdocno,  #計息單號	
         fmmtseq     LIKE fmmt_t.fmmtseq,    #項次
         fmmt001     LIKE fmmt_t.fmmt001,    #投資組織		
         fmmt002     LIKE fmmt_t.fmmt002,    #投資單號		
         fmmt003     LIKE fmmt_t.fmmt003,    #幣別
         fmmt004     LIKE fmmt_t.fmmt004,    #本金
         fmmt005     LIKE fmmt_t.fmmt005,    #起算日期		
         fmmt006     LIKE fmmt_t.fmmt006,    #止算日期		
         fmmt007     LIKE fmmt_t.fmmt007,    #天數
         fmmt008     LIKE fmmt_t.fmmt008,    #年利率
         fmmt009     LIKE fmmt_t.fmmt009,    #計息方式(由投資類型afmi510:計息方式fmma002)
         fmmt010     LIKE fmmt_t.fmmt010,    #本期計提金額
         #fmmt011     LIKE fmmt_t.fmmt010,    #利息調整  #151029-00012#10 mark
         #fmmt012     LIKE fmmt_t.fmmt010     #投資收益  #151029-00012#10 mark
         #151029-00012#10 add ------
         fmmt011     LIKE fmmt_t.fmmt011,    #利息調整
         fmmt012     LIKE fmmt_t.fmmt012,    #投資收益
         fmmt013     LIKE fmmt_t.fmmt013,    #匯率
         fmmt014     LIKE fmmt_t.fmmt014,    #計提本幣金額
         fmmt015     LIKE fmmt_t.fmmt015,    #本幣利息調整
         fmmt016     LIKE fmmt_t.fmmt016     #本幣投資收益
         #151029-00012#10 add end---
                 END RECORD
DEFINE l_fmmj        RECORD
         fmmjdocdt   LIKE fmmj_t.fmmjdocdt,
         fmmj017     LIKE fmmj_t.fmmj017,
         fmmj018     LIKE fmmj_t.fmmj018,
         fmmj019     LIKE fmmj_t.fmmj019,
         fmmj021     LIKE fmmj_t.fmmj021,
         fmmj022     LIKE fmmj_t.fmmj022
                 END RECORD
DEFINE ls_sql        STRING
DEFINE l_fmma004     LIKE fmma_t.fmma004     #期末計量

   SELECT fmmjsite,fmmjdocno,fmmj006,fmmj008,
          fmma002,fmma004,
          fmmjdocdt,fmmj017,fmmj018,fmmj019,fmmj021,fmmj022
     INTO l_fmmt.fmmt001,l_fmmt.fmmt002,l_fmmt.fmmt003,l_fmmt.fmmt004,
          l_fmmt.fmmt009,l_fmma004,
          l_fmmj.fmmjdocdt,l_fmmj.fmmj017,l_fmmj.fmmj018,l_fmmj.fmmj019,l_fmmj.fmmj021,
          l_fmmj.fmmj022
     FROM fmmj_t,fmma_t 
    WHERE fmmjent = fmmaent 
      AND fmmjstus = 'Y' AND fmma001 = fmmj003 
      AND fmmjent = g_enterprise AND fmmjdocno = g_fmmt_d[l_ac].fmmt002
   
   LET l_fmmt.fmmt005 = g_accdate_s
   LET l_fmmt.fmmt006 = g_accdate_e
   
   CALL s_afmp500_clac_fmmt(g_glaald,l_fmma004,g_glav006,g_fmms_m.fmms001,g_fmms_m.fmms002,l_fmmt.*,l_fmmj.*)
        RETURNING g_fmmt_d[l_ac].fmmt005,g_fmmt_d[l_ac].fmmt006,g_fmmt_d[l_ac].fmmt007,g_fmmt_d[l_ac].fmmt008,
                  g_fmmt_d[l_ac].fmmt010,g_fmmt_d[l_ac].fmmt011,g_fmmt_d[l_ac].fmmt012,
                  g_fmmt_d[l_ac].fmmt013,g_fmmt_d[l_ac].fmmt014,g_fmmt_d[l_ac].fmmt015,g_fmmt_d[l_ac].fmmt016 #151029-00012#10
   
   LET g_fmmt_d[l_ac].fmmt003 = l_fmmt.fmmt003
   LET g_fmmt_d[l_ac].fmmt004 = l_fmmt.fmmt004
   LET g_fmmt_d[l_ac].fmmt009 = l_fmmt.fmmt009
   DISPLAY BY NAME g_fmmt_d[l_ac].fmmt003,g_fmmt_d[l_ac].fmmt004,g_fmmt_d[l_ac].fmmt005,
                   g_fmmt_d[l_ac].fmmt006,g_fmmt_d[l_ac].fmmt007,g_fmmt_d[l_ac].fmmt008,g_fmmt_d[l_ac].fmmt009,g_fmmt_d[l_ac].fmmt010,
                  #g_fmmt_d[l_ac].fmmt011,g_fmmt_d[l_ac].fmmt012  #151029-00012#10 mark
                   #151029-00012#10 add ------
                   g_fmmt_d[l_ac].fmmt011,g_fmmt_d[l_ac].fmmt012,g_fmmt_d[l_ac].fmmt013,g_fmmt_d[l_ac].fmmt014,g_fmmt_d[l_ac].fmmt015,
                   g_fmmt_d[l_ac].fmmt016
                   #151029-00012#10 add end---
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 15/05/20 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt560_fmms_chk()
DEFINE l_cnt            LIKE type_t.num5
DEFINE r_success        LIKE type_t.num5
DEFINE r_errno          LIKE gzze_t.gzze001

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #SELECT count(*) INTO l_cnt #160822-00012#2 mark
   SELECT count(1) INTO l_cnt  #160822-00012#2
     FROM fmmt_t
    WHERE fmmtent = g_enterprise
      AND fmmtdocno = g_fmms_m.fmmsdocno
   IF l_cnt > 0 THEN
      LET r_success = FALSE
      LET r_errno   = 'afm-00116'
   END IF
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 確認檢核
# Memo...........:
# Date & Author..: 15/05/22 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt560_conf_chk()
DEFINE l_cnt        LIKE type_t.num5
DEFINE r_success    LIKE type_t.num10


   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET l_cnt = 0
   
   #SELECT count(*) INTO l_cnt #160822-00012#2 mark
   SELECT count(1) INTO l_cnt  #160822-00012#2
     FROM fmmt_t
    WHERE fmmtent = g_enterprise
      AND fmmtdocno = g_fmms_m.fmmsdocno
    
   IF l_cnt = 0 THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = 'aec-00020'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success   #151117-00001#4 add
   END IF
   

   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 取消確認檢核
# Memo...........:
# Date & Author..: 15/05/20 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt560_unconf_chk()
DEFINE l_cnt        LIKE type_t.num5
DEFINE r_success    LIKE type_t.num10

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #151117-00001#4-----s
   #來源afmt530的也不可取消確認
   #單身無計息來源為3計息的就不可輸入
   LET l_cnt = NULL
   #SELECT COUNT(*) INTO l_cnt FROM fmmt_t #160822-00012#2 mark
   SELECT COUNT(1) INTO l_cnt FROM fmmt_t  #160822-00012#2
    WHERE fmmtent = g_enterprise
      AND fmmtdocno = g_fmms_m.fmmsdocno
      AND fmmt017   IN ('1','2')
   IF cl_null(l_cnt)THEN LET l_cnt = 0 END IF
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'afm-00200'
      LET g_errparam.extend = ''
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   
   #有已沖金額不可取消確認
   LET l_cnt = NULL
   #SELECT COUNT(*) INTO l_cnt #160822-00012#2 mark
   SELECT COUNT(1) INTO l_cnt  #160822-00012#2
     FROM fmmt_t
    WHERE fmmtent = g_enterprise
      AND fmmtdocno = g_fmms_m.fmmsdocno
      AND (fmmt018 > 0 OR fmmt019 >0)
   IF cl_null(l_cnt)THEN LET l_cnt = 0 END IF
   
   IF l_cnt <> 0 THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'afm-00199'
      LET g_errparam.extend = ''
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #151117-00001#4-----e
   
   CALL afmt560_is_exist_fmmu_t() RETURNING r_success
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 作廢檢核
# Memo...........:
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt560_void_chk()
DEFINE l_fmmsstus   LIKE fmms_t.fmmsstus
DEFINE l_cnt        LIKE type_t.num5
DEFINE r_success    LIKE type_t.num10

   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
    
  
  
   CALL afmt560_is_exist_fmmu_t() RETURNING r_success
  
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 是否存在帳務單號
# Memo...........:
# Date & Author..: 15/05/21 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt560_is_exist_fmmu_t()
DEFINE l_cnt        LIKE type_t.num5
DEFINE r_success    LIKE type_t.num10

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET l_cnt = 0
   #SELECT count(*) INTO l_cnt #160822-00012#2 mark
   SELECT count(1) INTO l_cnt  #160822-00012#2
     FROM fmmu_t,fmng_t
    WHERE fmmuent = fmngent AND fmmudocno = fmngdocno
      AND fmmuent = g_enterprise
      AND fmmu002 = g_fmms_m.fmms001 AND fmmu003 = g_fmms_m.fmms002
      AND fmng002 IN ( SELECT fmmt002 FROM fmmt_t
                        WHERE fmmtent = g_enterprise
                          AND fmmtdocno=g_fmms_m.fmmsdocno )
    
   IF l_cnt > 0 THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = 'afm-00119'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: fmmn單身填充
# Memo...........:
# Date & Author..: 151124 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt560_b_fill3(p_ac)
   DEFINE p_ac   LIKE type_t.num10   #第一單身 l_ac
   DEFINE l_sql  STRING
   DEFINE l_idx  LIKE type_t.num10
   
   IF cl_null(p_ac) OR p_ac <= 0 THEN RETURN END IF
   
   LET l_sql = "SELECT fmmn001,fmmn002,fmmn003,fmmn004,fmmn005,fmmn006 ",
               "  FROM fmmn_t ",
               " WHERE fmmnent = ",g_enterprise," ",
               "   AND fmmndocno = ? ",
               "   AND fmmn001 = ? "
   PREPARE sel_fmmnp1 FROM l_sql
   DECLARE sel_fmmnc1 CURSOR FOR sel_fmmnp1
   
   
   CALL g_fmmt2_d.clear()
   LET l_idx = 1
   FOREACH sel_fmmnc1 USING g_fmms_m.fmmsdocno,g_fmmt_d[p_ac].fmmt002
      INTO g_fmmt2_d[l_idx].fmmn001,g_fmmt2_d[l_idx].fmmn002,g_fmmt2_d[l_idx].fmmn003,
           g_fmmt2_d[l_idx].fmmn004,g_fmmt2_d[l_idx].fmmn005,g_fmmt2_d[l_idx].fmmn006
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      #LET g_fmmt2_d[l_idx].fmmn002 = '2'
      LET l_idx = l_idx + 1
   END FOREACH
   
   LET g_rec_b2 = l_idx
END FUNCTION

 
{</section>}
 
