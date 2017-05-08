#該程式未解開Section, 採用最新樣板產出!
{<section id="aglt400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2016-11-16 14:32:30), PR版次:0015(2016-11-16 14:13:49)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000482
#+ Filename...: aglt400
#+ Description: 傳票細項立沖開帳資料維護作業
#+ Creator....: 02298(2014-01-06 16:46:33)
#+ Modifier...: 01531 -SD/PR- 01531
 
{</section>}
 
{<section id="aglt400.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#150827-00036#7   2015/09/14 BY 02291    添加“是否是子系统科目”字段，如果打勾后在总账凭证输入时不能选该类科目
#151110-00030#1   2015/11/11 BY Shiun    'ON ACTION unconf'少了權限控管
#151117-00009#1   2015/11/18 BY 02599    当有账套时，科目检查改为检查是否存在于glad_t中
#151125-00001#2   2015/11/30 BY catmoon  作廢前詢問「是否執行作廢？」
#151130-00015#2   2015/12/21 BY taozf    判断 是否可以更改單據日期 設定開放單據日期修改
#160321-00016#31  2016/03/28 BY Jessy    修正azzi920重複定義之錯誤訊息
#160318-00005#18  2016/03/29 BY 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#160816-00068#6   2016/08/16 BY earl     調整transaction
#160518-00075#27  2016/08/25 BY 02114    AGL,作業開啟時,只依azzi850可執行作業否管制，不卡帳套權限，會造成作業無法執行。 查詢及維護時才檢核帳權限。
#160913-00017#3   2016/09/21 By 07900    AGL模组调整交易客商开窗
#160918-00006#3   2016/10/10 By 02599    抓取汇率时根据账套汇率来源(glaa028:1.日汇率,2.月汇率)抓取汇率
#161021-00037#4   2016/10/24 By 06821    組織類型與職能開窗調整
#161111-00049#4   2016/11/12 By 01531    调整问题6(用到agli130摘要设置的作业如aglt310）
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
GLOBALS "../../cfg/top_finance.inc"
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_glax_m        RECORD
       glaxld LIKE glax_t.glaxld, 
   glaxld_desc LIKE type_t.chr80, 
   glaxcomp LIKE glax_t.glaxcomp, 
   glaxcomp_desc LIKE type_t.chr80, 
   glaa001 LIKE glaa_t.glaa001, 
   glaa016 LIKE glaa_t.glaa016, 
   glaa020 LIKE glaa_t.glaa020, 
   glaxdocno LIKE glax_t.glaxdocno, 
   glaxdocdt LIKE glax_t.glaxdocdt, 
   glax049 LIKE glax_t.glax049, 
   glax050 LIKE glax_t.glax050, 
   glaxstus LIKE glax_t.glaxstus, 
   glax027_desc LIKE type_t.chr80, 
   glax028_desc LIKE type_t.chr80, 
   conf LIKE type_t.chr80, 
   crt LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_glax_d        RECORD
       glaxseq LIKE glax_t.glaxseq, 
   glax002 LIKE glax_t.glax002, 
   lc_subject LIKE type_t.chr500, 
   glax005 LIKE glax_t.glax005, 
   glax006 LIKE glax_t.glax006, 
   glax007 LIKE glax_t.glax007, 
   glax008 LIKE glax_t.glax008, 
   glax009 LIKE glax_t.glax009, 
   glax010 LIKE glax_t.glax010, 
   glax003 LIKE glax_t.glax003, 
   glax051 LIKE glax_t.glax051, 
   glax052 LIKE glax_t.glax052, 
   glax055 LIKE glax_t.glax055, 
   glax056 LIKE glax_t.glax056, 
   glax048 LIKE glax_t.glax048, 
   glax001 LIKE glax_t.glax001, 
   edit1 LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_glax2_d RECORD
       glaxseq LIKE glax_t.glaxseq, 
   glaxmodid LIKE glax_t.glaxmodid, 
   glaxmodid_desc LIKE type_t.chr500, 
   glaxownid LIKE glax_t.glaxownid, 
   glaxownid_desc LIKE type_t.chr500, 
   glaxowndp LIKE glax_t.glaxowndp, 
   glaxowndp_desc LIKE type_t.chr500, 
   glaxcrtid LIKE glax_t.glaxcrtid, 
   glaxcrtid_desc LIKE type_t.chr500, 
   glaxcrtdp LIKE glax_t.glaxcrtdp, 
   glaxcrtdp_desc LIKE type_t.chr500, 
   glaxcrtdt DATETIME YEAR TO SECOND, 
   glaxcnfid LIKE glax_t.glaxcnfid, 
   glaxcnfid_desc LIKE type_t.chr500, 
   glaxcnfdt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#冻结单身定义
DEFINE g_glax        RECORD
   glax017      LIKE glax_t.glax017,
   glax017_desc LIKE type_t.chr80, 
   glax018      LIKE glax_t.glax018,
   glax018_desc LIKE type_t.chr80, 
   glax019      LIKE glax_t.glax019,
   glax019_desc LIKE type_t.chr80, 
   glax020      LIKE glax_t.glax020,
   glax020_desc LIKE type_t.chr80, 
   glax021      LIKE glax_t.glax021,
   glax021_desc LIKE type_t.chr80, 
   glax022      LIKE glax_t.glax021,
   glax022_desc LIKE type_t.chr80, 
   glax023      LIKE glax_t.glax023,
   glax023_desc LIKE type_t.chr80, 
   glax024      LIKE glax_t.glax024,
   glax024_desc LIKE type_t.chr80, 
   glax025      LIKE glax_t.glax025,
   glax025_desc LIKE type_t.chr80, 
   glax027      LIKE glax_t.glax027,
   glax027_desc LIKE type_t.chr80, 
   glax028      LIKE glax_t.glax028,
   glax028_desc LIKE type_t.chr80,
   glax061      LIKE glax_t.glax061,
   glax062      LIKE glax_t.glax062,
   glax062_desc LIKE type_t.chr80, 
   glax063      LIKE glax_t.glax063,
   glax063_desc LIKE type_t.chr80,   
   glax011      LIKE glax_t.glax011,
   glax012      LIKE glax_t.glax012,
   glax013      LIKE glax_t.glax013,
   glax013_desc LIKE type_t.chr80,  
   glax014      LIKE glax_t.glax014,
   glax015      LIKE glax_t.glax015,
   glax016      LIKE glax_t.glax016
END RECORD
#單頭條件備份
DEFINE g_wc1         STRING
#依据归属的营运据点抓取对应的归属法人

#当前用户归属的营运据点预设的行事历参照表号,办公行事历对应类别
DEFINE g_ooef004    LIKE ooef_t.ooef004
DEFINE g_ooef008    LIKE ooef_t.ooef008
DEFINE g_ooef010    LIKE ooef_t.ooef010
#依据当前账别，抓取账别所归属的法人，使用币别，汇率参照表号，会计科目参照表号，关账日期
DEFINE g_glaacomp    LIKE glaa_t.glaacomp
DEFINE g_glaa001     LIKE glaa_t.glaa001
DEFINE g_glaa002     LIKE glaa_t.glaa002
DEFINE g_glaa003     LIKE glaa_t.glaa003
DEFINE g_glaa004     LIKE glaa_t.glaa004
DEFINE g_glaa013     LIKE glaa_t.glaa013
DEFINE g_glaa015     LIKE glaa_t.glaa015
DEFINE g_glaa016     LIKE glaa_t.glaa016
DEFINE g_glaa017     LIKE glaa_t.glaa017
DEFINE g_glaa018     LIKE glaa_t.glaa018
DEFINE g_glaa019     LIKE glaa_t.glaa019
DEFINE g_glaa020     LIKE glaa_t.glaa020
DEFINE g_glaa021     LIKE glaa_t.glaa021
DEFINE g_glaa022     LIKE glaa_t.glaa022
DEFINE g_glaa024     LIKE glaa_t.glaa024
DEFINE g_glaa025     LIKE glaa_t.glaa025
DEFINE g_glaa028     LIKE glaa_t.glaa028 #160918-00006#3 add
#帐别
DEFINE g_glaxld      LIKE glax_t.glaxld
DEFINE g_bookno      LIKE glax_t.glaxld
#自由核算项
DEFINE g_glax029     LIKE glax_t.glax029
DEFINE g_glax030     LIKE glax_t.glax030
DEFINE g_glax031     LIKE glax_t.glax031
DEFINE g_glax032     LIKE glax_t.glax032
DEFINE g_glax033     LIKE glax_t.glax033
DEFINE g_glax034     LIKE glax_t.glax034
DEFINE g_glax035     LIKE glax_t.glax035
DEFINE g_glax036     LIKE glax_t.glax036
DEFINE g_glax037     LIKE glax_t.glax037
DEFINE g_glax038     LIKE glax_t.glax038
#摘要
DEFINE g_msg         LIKE type_t.chr80
DEFINE g_wc_frozen   STRING
type type_g_glax_r   RECORD
       glax017       LIKE glax_t.glax017,
       glax018       LIKE glax_t.glax018,
       glax019       LIKE glax_t.glax019,
       glax020       LIKE glax_t.glax020,
       glax021       LIKE glax_t.glax021,
       glax022       LIKE glax_t.glax022,
       glax023       LIKE glax_t.glax023, 
       glax024       LIKE glax_t.glax024, 
       glax061       LIKE glax_t.glax061, 
       glax062       LIKE glax_t.glax062,
       glax063       LIKE glax_t.glax063,
       glax025       LIKE glax_t.glax025,
       glax027       LIKE glax_t.glax027,
       glax028       LIKE glax_t.glax028, 
       glax029       LIKE glax_t.glax029, 
       glax030       LIKE glax_t.glax030, 
       glax031       LIKE glax_t.glax031, 
       glax032       LIKE glax_t.glax032, 
       glax033       LIKE glax_t.glax033, 
       glax034       LIKE glax_t.glax034, 
       glax035       LIKE glax_t.glax035, 
       glax036       LIKE glax_t.glax036, 
       glax037       LIKE glax_t.glax037, 
       glax038       LIKE glax_t.glax038,
       glbc004       LIKE glbc_t.glbc004
       END RECORD
DEFINE g_glax_r          type_g_glax_r

#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_glax_m          type_g_glax_m
DEFINE g_glax_m_t        type_g_glax_m
DEFINE g_glax_m_o        type_g_glax_m
DEFINE g_glax_m_mask_o   type_g_glax_m #轉換遮罩前資料
DEFINE g_glax_m_mask_n   type_g_glax_m #轉換遮罩後資料
 
   DEFINE g_glaxld_t LIKE glax_t.glaxld
DEFINE g_glaxdocno_t LIKE glax_t.glaxdocno
 
 
DEFINE g_glax_d          DYNAMIC ARRAY OF type_g_glax_d
DEFINE g_glax_d_t        type_g_glax_d
DEFINE g_glax_d_o        type_g_glax_d
DEFINE g_glax_d_mask_o   DYNAMIC ARRAY OF type_g_glax_d #轉換遮罩前資料
DEFINE g_glax_d_mask_n   DYNAMIC ARRAY OF type_g_glax_d #轉換遮罩後資料
DEFINE g_glax2_d   DYNAMIC ARRAY OF type_g_glax2_d
DEFINE g_glax2_d_t type_g_glax2_d
DEFINE g_glax2_d_o type_g_glax2_d
DEFINE g_glax2_d_mask_o   DYNAMIC ARRAY OF type_g_glax2_d #轉換遮罩前資料
DEFINE g_glax2_d_mask_n   DYNAMIC ARRAY OF type_g_glax2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_glaxld LIKE glax_t.glaxld,
   b_glaxld_desc LIKE type_t.chr80,
      b_glaxdocno LIKE glax_t.glaxdocno,
      b_glaxdocdt LIKE glax_t.glaxdocdt
       #,rank           LIKE type_t.num10
      END RECORD 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING 
 
 
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
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num10           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
 
DEFINE g_detail_cnt          LIKE type_t.num10             #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10             #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10             #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10             #Browser目前所在筆數(暫存用)
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING                        
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
DEFINE g_current_row         LIKE type_t.num10             #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入(僅用於三階)
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglt400.main" >}
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
   CALL cl_ap_init("agl","")
 
   #add-point:作業初始化 name="main.init"
      
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
      
   #end add-point
   LET g_forupd_sql = " SELECT glaxld,'',glaxcomp,'','','','',glaxdocno,glaxdocdt,glax049,glax050,glaxstus, 
       '','','',''", 
                      " FROM glax_t",
                      " WHERE glaxent= ? AND glaxld=? AND glaxdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglt400_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.glaxld,t0.glaxcomp,t0.glaxdocno,t0.glaxdocdt,t0.glax049,t0.glax050, 
       t0.glaxstus,t1.glaal002 ,t2.ooefl003",
               " FROM glax_t t0",
                              " LEFT JOIN glaal_t t1 ON t1.glaalent="||g_enterprise||" AND t1.glaalld=t0.glaxld AND t1.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.glaxcomp AND t2.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.glaxent = " ||g_enterprise|| " AND t0.glaxld = ? AND t0.glaxdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglt400_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
            
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglt400 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglt400_init()   
 
      #進入選單 Menu (="N")
      CALL aglt400_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
            
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglt400
      
   END IF 
   
   CLOSE aglt400_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
      
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglt400.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aglt400_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
         DEFINE l_success     LIKE type_t.num5
   DEFINE l_pass        LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('glaxstus','13','N,Y,X')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   IF NOT cl_null(g_argv[01]) THEN
      CALL s_ld_chk_authorization(g_user,g_argv[01]) RETURNING l_pass
      IF l_pass = TRUE THEN
         LET g_glaald=g_argv[01]
      END IF
   END IF
   #依据登陆的site，抓取单别参照表号，行事历参照表号,辦公行事曆對應類別   
   SELECT ooef004,ooef008,ooef010 INTO g_ooef004,g_ooef008,g_ooef010 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   #获取账别
   IF cl_null(g_glaald) THEN
      CALL s_ld_bookno()  RETURNING l_success,g_glaxld
      IF l_success = FALSE THEN
         RETURN 
      END IF 
      #160518-00075#27--mark--str--lujh
      #CALL s_ld_chk_authorization(g_user,g_glaxld) RETURNING l_pass
      #IF l_pass = FALSE THEN
      #   INITIALIZE g_errparam TO NULL
      #   LET g_errparam.code = 'agl-00164'
      #   LET g_errparam.extend = g_glaxld
      #   LET g_errparam.popup = TRUE
      #   CALL cl_err()
      #
      #   RETURN
      #END IF
      #160518-00075#27--mark--end--lujh
      LET g_glaald=g_glaxld
   ELSE
      LET g_glaxld=g_glaald
   END IF      
#   CALL cl_set_comp_visible('glaa016,glaa020,glax051.glax052,glax055,glax056',FALSE)
   CALL aglt400_glaxld_desc(g_glaxld)         #帐别说明
   CALL cl_set_combo_scc('glax015','8310')  
   CALL cl_set_combo_scc('glax061','6013') 
   #end add-point
   
   CALL aglt400_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aglt400.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aglt400_ui_dialog()
   #add-point:ui_dialog段define name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE la_param  RECORD
          prog                  STRING,
          actionid              STRING,
          background            LIKE type_t.chr1,
          param                 DYNAMIC ARRAY OF STRING
                                END RECORD
   DEFINE ls_js                 STRING
   DEFINE li_idx                LIKE type_t.num10
   DEFINE ls_wc                 STRING
   DEFINE lb_first              BOOLEAN
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0 
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
      
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_glax_m.* TO NULL
         CALL g_glax_d.clear()
         CALL g_glax2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aglt400_init()
      END IF
 
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
 
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
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aglt400_idx_chk()
               CALL aglt400_fetch('') # reload data
               LET g_detail_idx = 1
               CALL aglt400_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_glax_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL aglt400_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aglt400_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body.before_row"
                                             CALL aglt400_b_detail()
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
    
               #控制stus哪個按鈕可以按
                              #此段落i02,i07樣板使用, 但目前不支援批次修改狀態, 先註解
			   ##此段落由子樣板a22產生
               ##目前選取的stus為N
               #IF . = "N" THEN
               #                     CALL cl_set_act_visible('unconfirmed',FALSE)
                  CALL cl_set_act_visible('confirmed',TRUE)
                  CALL cl_set_act_visible('invalid',TRUE)
 
               #END IF
               ##stus - Start - 
               ##目前選取的stus為}
               #IF . = "}" THEN
               #   }
               #END IF        
               ##stus -  End  -               
    
 
 
               
            
 
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
                        
            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_glax2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aglt400_idx_chk()
               CALL aglt400_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body2.before_row"
                              
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 2
            
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
                        
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
                  
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps 
         
         BEFORE DIALOG
            #先填充browser資料
            CALL aglt400_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)         
            LET g_page = "first"
            LET g_current_sw = FALSE
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
            
            IF g_current_idx = 0 AND g_browser.getLength() > 0 THEN
               LET g_current_idx = 1 
            END IF
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL aglt400_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aglt400_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
         ON ACTION prog_glax025
            LET g_action_choice="prog_glax025"
            IF cl_auth_chk_act("prog_glax025") THEN
               
               #add-point:ON ACTION prog_xrca003
               IF NOT cl_null(g_glax.glax025) THEN
                  CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_glax.glax025)
               END IF
               #END add-point
               
            END IF            
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL aglt400_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aglt400_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt400_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aglt400_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt400_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aglt400_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt400_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aglt400_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt400_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aglt400_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt400_idx_chk()
            LET g_action_choice = ""
            
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
                  LET g_export_node[1] = base.typeInfo.create(g_glax_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_glax2_d)
                  LET g_export_id[2]   = "s_detail2"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
          
         ON ACTION close
            LET INT_FLAG=FALSE        
            LET g_action_choice = "exit"
            EXIT DIALOG     
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION mainhidden       #主頁摺疊
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
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD glaxseq
            END IF
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
            
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL aglt400_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL aglt400_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL aglt400_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aglt400_modify()
               #add-point:ON ACTION modify name="menu.modify"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aglt400_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION bus_cons
            LET g_action_choice="bus_cons"
            IF cl_auth_chk_act("bus_cons") THEN
               
               #add-point:ON ACTION bus_cons name="menu.bus_cons"
                                             CALL aglt400_bus_cons()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aglt400_delete()
               #add-point:ON ACTION delete name="menu.delete"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aglt400_insert()
               #add-point:ON ACTION insert name="menu.insert"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
                              
               #END add-point
               &include "erp/agl/aglt400_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
                              
               #END add-point
               &include "erp/agl/aglt400_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aglt400_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglt400_query()
               #add-point:ON ACTION query name="menu.query"
                              
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION fix_account
            LET g_action_choice="fix_account"
            IF cl_auth_chk_act("fix_account") THEN
               
               #add-point:ON ACTION fix_account name="menu.fix_account"
               CALL aglt400_fix_acc()          {#ADP版次:1#}
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION statechange
            LET g_action_choice="statechange"
            IF cl_auth_chk_act("statechange") THEN
               
               #add-point:ON ACTION statechange name="menu.statechange"
               CALL aglt400_statechange()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION exchange_ld
            LET g_action_choice="exchange_ld"
            IF cl_auth_chk_act("exchange_ld") THEN
               
               #add-point:ON ACTION exchange_ld name="menu.exchange_ld"
               CALL aglt310_01(g_glax_m.glaxld) RETURNING g_bookno
               LET g_glaald = g_bookno
               LET g_glaxld = g_bookno
               #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
               CALL aglt400_glaxld_desc(g_glaxld) 
               IF cl_null(g_wc) THEN
                  LET g_wc = '1=1'
               END IF
               LET g_wc1 = " glaxld='",g_glaxld,"' "         {#ADP版次:1#}
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aglt400_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aglt400_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aglt400_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_glax_m.glaxdocdt)
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl" 
         CONTINUE DIALOG
            
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
   
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION aglt400_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
      
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aglt400.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aglt400_browser_fill(ps_page_action)
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point   
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
         LET g_wc = '1=1'
   IF cl_null(g_wc1) THEN LET g_wc1 = ' 1=1' END IF 
   LET g_wc = g_wc1," AND  glaxld = '",g_glaxld,"'"
   #end add-point    
 
   LET l_searchcol = "glaxld,glaxdocno"
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      LET l_wc = " 1=1"
   END IF
   IF cl_null(l_wc2) THEN  #p_wc 查詢條件
      LET l_wc2 = " 1=1"
   END IF
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT glaxld ",
                      ", glaxdocno ",
 
                      " FROM glax_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE glaxent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("glax_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT glaxld ",
                      ", glaxdocno ",
 
                      " FROM glax_t ",
                      " ",
                      " ", 
 
 
                      " WHERE glaxent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("glax_t")
   END IF 
   
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
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt 
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   LET g_error_show = 0
 
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_glax_m.* TO NULL
      CALL g_glax_d.clear()        
      CALL g_glax2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.glaxld,t0.glaxdocno,t0.glaxdocdt Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.glaxld,t0.glaxdocno,t0.glaxdocdt,t1.glaal002",
                " FROM glax_t t0",
                #" ",
                " ",
 
 
 
                               " LEFT JOIN glaal_t t1 ON t1.glaalent="||g_enterprise||" AND t1.glaalld=t0.glaxld AND t1.glaal001='"||g_dlang||"' ",
 
                " WHERE t0.glaxent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("glax_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"glax_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_glaxld,g_browser[g_cnt].b_glaxdocno,g_browser[g_cnt].b_glaxdocdt, 
          g_browser[g_cnt].b_glaxld_desc 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
            
         #end add-point  
      
         #遮罩相關處理
         CALL aglt400_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_glaxld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_glax_m.* TO NULL
      CALL g_glax_d.clear()
      CALL g_glax2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL aglt400_fetch('')
   
   #筆數顯示
   LET g_browser_idx = g_current_idx 
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
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
 
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aglt400_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
      
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_glax_m.glaxld = g_browser[g_current_idx].b_glaxld   
   LET g_glax_m.glaxdocno = g_browser[g_current_idx].b_glaxdocno   
 
   EXECUTE aglt400_master_referesh USING g_glax_m.glaxld,g_glax_m.glaxdocno INTO g_glax_m.glaxld,g_glax_m.glaxcomp, 
       g_glax_m.glaxdocno,g_glax_m.glaxdocdt,g_glax_m.glax049,g_glax_m.glax050,g_glax_m.glaxstus,g_glax_m.glaxld_desc, 
       g_glax_m.glaxcomp_desc
   CALL aglt400_show()
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aglt400_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
      
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
      
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
            
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
      
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aglt400_ui_browser_refresh()
   #add-point:ui_browser_refresh段define name="ui_browser_refresh.define_customerization"
   
   #end add-point   
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
      
   #end add-point 
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_glaxld = g_glax_m.glaxld 
         AND g_browser[l_i].b_glaxdocno = g_glax_m.glaxdocno 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
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
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglt400_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
      
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_glax_m.* TO NULL
   CALL g_glax_d.clear()
   CALL g_glax2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
      
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON glaxld,glaxcomp,glaxdocno,glaxdocdt,glax049,glax050,glaxstus,glax027_desc, 
          glax028_desc,conf,crt
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
                        
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxld
            #add-point:BEFORE FIELD glaxld name="construct.b.glaxld"
                                    NEXT FIELD glaxdocno
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaxld
            
            #add-point:AFTER FIELD glaxld name="construct.a.glaxld"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaxld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaxld
            #add-point:ON ACTION controlp INFIELD glaxld name="construct.c.glaxld"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.glaxcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaxcomp
            #add-point:ON ACTION controlp INFIELD glaxcomp name="construct.c.glaxcomp"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where =" ooef201 = 'Y'" #161021-00037#4 add
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaxcomp  #顯示到畫面上

            NEXT FIELD glaxcomp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxcomp
            #add-point:BEFORE FIELD glaxcomp name="construct.b.glaxcomp"
                                    NEXT FIELD glaxdocno
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaxcomp
            
            #add-point:AFTER FIELD glaxcomp name="construct.a.glaxcomp"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaxdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaxdocno
            #add-point:ON ACTION controlp INFIELD glaxdocno name="construct.c.glaxdocno"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_glaxdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaxdocno  #顯示到畫面上

            NEXT FIELD glaxdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxdocno
            #add-point:BEFORE FIELD glaxdocno name="construct.b.glaxdocno"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaxdocno
            
            #add-point:AFTER FIELD glaxdocno name="construct.a.glaxdocno"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxdocdt
            #add-point:BEFORE FIELD glaxdocdt name="construct.b.glaxdocdt"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaxdocdt
            
            #add-point:AFTER FIELD glaxdocdt name="construct.a.glaxdocdt"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaxdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaxdocdt
            #add-point:ON ACTION controlp INFIELD glaxdocdt name="construct.c.glaxdocdt"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax049
            #add-point:BEFORE FIELD glax049 name="construct.b.glax049"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax049
            
            #add-point:AFTER FIELD glax049 name="construct.a.glax049"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glax049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax049
            #add-point:ON ACTION controlp INFIELD glax049 name="construct.c.glax049"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax050
            #add-point:BEFORE FIELD glax050 name="construct.b.glax050"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax050
            
            #add-point:AFTER FIELD glax050 name="construct.a.glax050"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glax050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax050
            #add-point:ON ACTION controlp INFIELD glax050 name="construct.c.glax050"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxstus
            #add-point:BEFORE FIELD glaxstus name="construct.b.glaxstus"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaxstus
            
            #add-point:AFTER FIELD glaxstus name="construct.a.glaxstus"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaxstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaxstus
            #add-point:ON ACTION controlp INFIELD glaxstus name="construct.c.glaxstus"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax027_desc
            #add-point:BEFORE FIELD glax027_desc name="construct.b.glax027_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax027_desc
            
            #add-point:AFTER FIELD glax027_desc name="construct.a.glax027_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glax027_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax027_desc
            #add-point:ON ACTION controlp INFIELD glax027_desc name="construct.c.glax027_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax028_desc
            #add-point:BEFORE FIELD glax028_desc name="construct.b.glax028_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax028_desc
            
            #add-point:AFTER FIELD glax028_desc name="construct.a.glax028_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glax028_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax028_desc
            #add-point:ON ACTION controlp INFIELD glax028_desc name="construct.c.glax028_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD conf
            #add-point:BEFORE FIELD conf name="construct.b.conf"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD conf
            
            #add-point:AFTER FIELD conf name="construct.a.conf"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.conf
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD conf
            #add-point:ON ACTION controlp INFIELD conf name="construct.c.conf"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crt
            #add-point:BEFORE FIELD crt name="construct.b.crt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crt
            
            #add-point:AFTER FIELD crt name="construct.a.crt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.crt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crt
            #add-point:ON ACTION controlp INFIELD crt name="construct.c.crt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON glaxseq,glax002,lc_subject,glax005,glax006,glax007,glax008,glax009,glax010, 
          glax003,glax051,glax052,glax055,glax056,glax048,glax001,glaxmodid,glaxownid,glaxowndp,glaxcrtid, 
          glaxcrtdp,glaxcrtdt,glaxcnfid,glaxcnfdt
           FROM s_detail1[1].glaxseq,s_detail1[1].glax002,s_detail1[1].lc_subject,s_detail1[1].glax005, 
               s_detail1[1].glax006,s_detail1[1].glax007,s_detail1[1].glax008,s_detail1[1].glax009,s_detail1[1].glax010, 
               s_detail1[1].glax003,s_detail1[1].glax051,s_detail1[1].glax052,s_detail1[1].glax055,s_detail1[1].glax056, 
               s_detail1[1].glax048,s_detail1[1].glax001,s_detail2[1].glaxmodid,s_detail2[1].glaxownid, 
               s_detail2[1].glaxowndp,s_detail2[1].glaxcrtid,s_detail2[1].glaxcrtdp,s_detail2[1].glaxcrtdt, 
               s_detail2[1].glaxcnfid,s_detail2[1].glaxcnfdt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
                        
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<glaxcrtdt>>----
         AFTER FIELD glaxcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<glaxmoddt>>----
         
         #----<<glaxcnfdt>>----
         AFTER FIELD glaxcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<glaxpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxseq
            #add-point:BEFORE FIELD glaxseq name="construct.b.page1.glaxseq"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaxseq
            
            #add-point:AFTER FIELD glaxseq name="construct.a.page1.glaxseq"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glaxseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaxseq
            #add-point:ON ACTION controlp INFIELD glaxseq name="construct.c.page1.glaxseq"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.page1.glax002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax002
            #add-point:ON ACTION controlp INFIELD glax002 name="construct.c.page1.glax002"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax002  #顯示到畫面上

            NEXT FIELD glax002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax002
            #add-point:BEFORE FIELD glax002 name="construct.b.page1.glax002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax002
            
            #add-point:AFTER FIELD glax002 name="construct.a.page1.glax002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.lc_subject
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lc_subject
            #add-point:ON ACTION controlp INFIELD lc_subject name="construct.c.page1.lc_subject"
                                    #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #151117-00009#1--add--str--
			   LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1'",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_glaxld,"'",
                                   "                    AND glad003 = 'Y' AND glad035='N' AND gladstus='Y' )"
            #151117-00009#1--add--end
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO lc_subject  #顯示到畫面上

            NEXT FIELD lc_subject                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lc_subject
            #add-point:BEFORE FIELD lc_subject name="construct.b.page1.lc_subject"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lc_subject
            
            #add-point:AFTER FIELD lc_subject name="construct.a.page1.lc_subject"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glax005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax005
            #add-point:ON ACTION controlp INFIELD glax005 name="construct.c.page1.glax005"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax005  #顯示到畫面上

            NEXT FIELD glax005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax005
            #add-point:BEFORE FIELD glax005 name="construct.b.page1.glax005"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax005
            
            #add-point:AFTER FIELD glax005 name="construct.a.page1.glax005"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax006
            #add-point:BEFORE FIELD glax006 name="construct.b.page1.glax006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax006
            
            #add-point:AFTER FIELD glax006 name="construct.a.page1.glax006"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glax006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax006
            #add-point:ON ACTION controlp INFIELD glax006 name="construct.c.page1.glax006"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.page1.glax007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax007
            #add-point:ON ACTION controlp INFIELD glax007 name="construct.c.page1.glax007"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax007  #顯示到畫面上

            NEXT FIELD glax007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax007
            #add-point:BEFORE FIELD glax007 name="construct.b.page1.glax007"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax007
            
            #add-point:AFTER FIELD glax007 name="construct.a.page1.glax007"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax008
            #add-point:BEFORE FIELD glax008 name="construct.b.page1.glax008"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax008
            
            #add-point:AFTER FIELD glax008 name="construct.a.page1.glax008"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glax008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax008
            #add-point:ON ACTION controlp INFIELD glax008 name="construct.c.page1.glax008"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax009
            #add-point:BEFORE FIELD glax009 name="construct.b.page1.glax009"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax009
            
            #add-point:AFTER FIELD glax009 name="construct.a.page1.glax009"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glax009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax009
            #add-point:ON ACTION controlp INFIELD glax009 name="construct.c.page1.glax009"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax010
            #add-point:BEFORE FIELD glax010 name="construct.b.page1.glax010"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax010
            
            #add-point:AFTER FIELD glax010 name="construct.a.page1.glax010"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glax010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax010
            #add-point:ON ACTION controlp INFIELD glax010 name="construct.c.page1.glax010"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax003
            #add-point:BEFORE FIELD glax003 name="construct.b.page1.glax003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax003
            
            #add-point:AFTER FIELD glax003 name="construct.a.page1.glax003"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glax003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax003
            #add-point:ON ACTION controlp INFIELD glax003 name="construct.c.page1.glax003"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax051
            #add-point:BEFORE FIELD glax051 name="construct.b.page1.glax051"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax051
            
            #add-point:AFTER FIELD glax051 name="construct.a.page1.glax051"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glax051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax051
            #add-point:ON ACTION controlp INFIELD glax051 name="construct.c.page1.glax051"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax052
            #add-point:BEFORE FIELD glax052 name="construct.b.page1.glax052"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax052
            
            #add-point:AFTER FIELD glax052 name="construct.a.page1.glax052"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glax052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax052
            #add-point:ON ACTION controlp INFIELD glax052 name="construct.c.page1.glax052"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax055
            #add-point:BEFORE FIELD glax055 name="construct.b.page1.glax055"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax055
            
            #add-point:AFTER FIELD glax055 name="construct.a.page1.glax055"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glax055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax055
            #add-point:ON ACTION controlp INFIELD glax055 name="construct.c.page1.glax055"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax056
            #add-point:BEFORE FIELD glax056 name="construct.b.page1.glax056"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax056
            
            #add-point:AFTER FIELD glax056 name="construct.a.page1.glax056"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glax056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax056
            #add-point:ON ACTION controlp INFIELD glax056 name="construct.c.page1.glax056"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax048
            #add-point:BEFORE FIELD glax048 name="construct.b.page1.glax048"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax048
            
            #add-point:AFTER FIELD glax048 name="construct.a.page1.glax048"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glax048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax048
            #add-point:ON ACTION controlp INFIELD glax048 name="construct.c.page1.glax048"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax001
            #add-point:BEFORE FIELD glax001 name="construct.b.page1.glax001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax001
            
            #add-point:AFTER FIELD glax001 name="construct.a.page1.glax001"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glax001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax001
            #add-point:ON ACTION controlp INFIELD glax001 name="construct.c.page1.glax001"
            #開窗c段
            #161111-00049#4 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "( oocq004 = '",g_glaacomp,"' OR oocq004 IS NULL )" 
            CALL q_oocq002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax001  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD glax001                     #返回原欄位     
            #161111-00049#4 add e---            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.glaxmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaxmodid
            #add-point:ON ACTION controlp INFIELD glaxmodid name="construct.c.page2.glaxmodid"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaxmodid  #顯示到畫面上

            NEXT FIELD glaxmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxmodid
            #add-point:BEFORE FIELD glaxmodid name="construct.b.page2.glaxmodid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaxmodid
            
            #add-point:AFTER FIELD glaxmodid name="construct.a.page2.glaxmodid"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glaxownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaxownid
            #add-point:ON ACTION controlp INFIELD glaxownid name="construct.c.page2.glaxownid"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaxownid  #顯示到畫面上

            NEXT FIELD glaxownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxownid
            #add-point:BEFORE FIELD glaxownid name="construct.b.page2.glaxownid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaxownid
            
            #add-point:AFTER FIELD glaxownid name="construct.a.page2.glaxownid"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glaxowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaxowndp
            #add-point:ON ACTION controlp INFIELD glaxowndp name="construct.c.page2.glaxowndp"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaxowndp  #顯示到畫面上

            NEXT FIELD glaxowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxowndp
            #add-point:BEFORE FIELD glaxowndp name="construct.b.page2.glaxowndp"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaxowndp
            
            #add-point:AFTER FIELD glaxowndp name="construct.a.page2.glaxowndp"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glaxcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaxcrtid
            #add-point:ON ACTION controlp INFIELD glaxcrtid name="construct.c.page2.glaxcrtid"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaxcrtid  #顯示到畫面上

            NEXT FIELD glaxcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxcrtid
            #add-point:BEFORE FIELD glaxcrtid name="construct.b.page2.glaxcrtid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaxcrtid
            
            #add-point:AFTER FIELD glaxcrtid name="construct.a.page2.glaxcrtid"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glaxcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaxcrtdp
            #add-point:ON ACTION controlp INFIELD glaxcrtdp name="construct.c.page2.glaxcrtdp"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaxcrtdp  #顯示到畫面上

            NEXT FIELD glaxcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxcrtdp
            #add-point:BEFORE FIELD glaxcrtdp name="construct.b.page2.glaxcrtdp"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaxcrtdp
            
            #add-point:AFTER FIELD glaxcrtdp name="construct.a.page2.glaxcrtdp"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxcrtdt
            #add-point:BEFORE FIELD glaxcrtdt name="construct.b.page2.glaxcrtdt"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.page2.glaxcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaxcnfid
            #add-point:ON ACTION controlp INFIELD glaxcnfid name="construct.c.page2.glaxcnfid"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaxcnfid  #顯示到畫面上

            NEXT FIELD glaxcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxcnfid
            #add-point:BEFORE FIELD glaxcnfid name="construct.b.page2.glaxcnfid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaxcnfid
            
            #add-point:AFTER FIELD glaxcnfid name="construct.a.page2.glaxcnfid"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxcnfdt
            #add-point:BEFORE FIELD glaxcnfdt name="construct.b.page2.glaxcnfdt"
                        
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      CONSTRUCT BY NAME g_wc_frozen ON glax017,glax018,glax019,glax020,glax021,glax022,
                                       glax023,glax024,glax061,glax062,glax063,glax025,glax027,glax028,
                                       glax011,glax012,glax013,glax014,glax015,glax016
        BEFORE CONSTRUCT
            CALL cl_qbe_init()
                       
         #申請人
         ON ACTION controlp INFIELD glax013
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax013  #顯示到畫面上
            NEXT FIELD glax013                    #返回原欄位
            
         #營運據點
         ON ACTION controlp INFIELD glax017
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where =" ooef201 = 'Y'" #161021-00037#4 add
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax017  #顯示到畫面上
            NEXT FIELD glax017                    #返回原欄位 
         #部門
         ON ACTION controlp INFIELD glax018
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax018  #顯示到畫面上
            NEXT FIELD glax018                    #返回原欄位 
         #利潤/成本中心
         ON ACTION controlp INFIELD glax019
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax019      #顯示到畫面上
            NEXT FIELD glax019                         #返回原欄位 
         #区域        
         ON ACTION controlp INFIELD glax020
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax020      #顯示到畫面上
            NEXT FIELD glax020                         #返回原欄位    
         #交易客商
         ON ACTION controlp INFIELD glax021
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#4  add
            #CALL q_pmaa001()        #160913-00017#4  mark               #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax021      #顯示到畫面上
            NEXT FIELD glax021                         #返回原欄位               
         #帳款客戶
         ON ACTION controlp INFIELD glax022
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pmaa001_25()      #160913-00017#4  add
            #CALL q_pmaa001()        #160913-00017#4  mark               #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax022      #顯示到畫面上
            NEXT FIELD glax022                         #返回原欄位   
            
         #客群      
         ON ACTION controlp INFIELD glax023
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax023      #顯示到畫面上
            NEXT FIELD glax023                         #返回原欄位   
         #產品類別
         ON ACTION controlp INFIELD glax024
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax024      #顯示到畫面上
            NEXT FIELD glax024                         #返回原欄位   

         #人員
         ON ACTION controlp INFIELD glax025
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax025      #顯示到畫面上
            NEXT FIELD glax025                         #返回原欄位   

         #渠道
         ON ACTION controlp INFIELD glax062
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = " oojdstus='Y' " 
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax062      #顯示到畫面上
            NEXT FIELD glax062                         #返回原欄位 
         
         #品牌
         ON ACTION controlp INFIELD glax063
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax063      #顯示到畫面上
            NEXT FIELD glax063                         #返回原欄位 
         #专案
          ON ACTION controlp INFIELD glax027
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pjba001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax027     #顯示到畫面上
            NEXT FIELD glax027
            
          #WBS
          ON ACTION controlp INFIELD glax028
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = "pjbb012='1' "
            CALL q_pjbb002()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax028     #顯示到畫面上
            NEXT FIELD glax028
      END CONSTRUCT                                       
            
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
                  
         #end add-point
      
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
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
   
   #add-point:cs段after_construct name="cs.after_construct"
   #单头条件备份
   LET g_wc1 = g_wc
   #单身
   IF NOT cl_null(g_wc2_table1) AND g_wc2_table1 <>" 1=1" THEN
      LET g_wc2_table1 = cl_replace_str(g_wc2_table1,"lc_subject","glax002")
   END IF          {#ADP版次:1#}
   IF cl_null(g_wc2_table1) THEN
      LET g_wc2_table1=" 1=1"
   END IF
   #冻结单身
   IF NOT cl_null(g_wc_frozen) AND g_wc_frozen <>' 1=1' THEN
      LET g_wc2_table1  = g_wc2_table1 CLIPPED,' AND ',g_wc_frozen
   END IF
   #end add-point
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   LET g_current_row = 1
 
   IF INT_FLAG THEN
      RETURN
   END IF
   
   LET g_wc_filter = ""
 
END FUNCTION
 
{</section>}
 
{<section id="aglt400.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aglt400_filter()
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
      CONSTRUCT g_wc_filter ON glaxld,glaxdocno,glaxdocdt
                          FROM s_browse[1].b_glaxld,s_browse[1].b_glaxdocno,s_browse[1].b_glaxdocdt
 
         BEFORE CONSTRUCT
               DISPLAY aglt400_filter_parser('glaxld') TO s_browse[1].b_glaxld
            DISPLAY aglt400_filter_parser('glaxdocno') TO s_browse[1].b_glaxdocno
            DISPLAY aglt400_filter_parser('glaxdocdt') TO s_browse[1].b_glaxdocdt
      
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
 
      CALL aglt400_filter_show('glaxld')
   CALL aglt400_filter_show('glaxdocno')
   CALL aglt400_filter_show('glaxdocdt')
 
END FUNCTION
 
{</section>}
 
{<section id="aglt400.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aglt400_filter_parser(ps_field)
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
 
{<section id="aglt400.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aglt400_filter_show(ps_field)
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
   LET ls_condition = aglt400_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglt400.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aglt400_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_pass        LIKE type_t.num5      #160518-00075#27 add lujh     
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
   #160518-00075#27--add--str--lujh
   CALL s_ld_chk_authorization(g_user,g_glaxld) RETURNING l_pass
   IF l_pass = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00164'
      LET g_errparam.extend = g_glaxld
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN         
   END IF    
   #160518-00075#27--add--end--lujh   
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
   CALL g_glax_d.clear()
   CALL g_glax2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL aglt400_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aglt400_browser_fill(g_wc)
      CALL aglt400_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL aglt400_browser_fill("F")
   
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
      CALL aglt400_fetch("F") 
   END IF
   
   CALL aglt400_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aglt400_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
      
   #end add-point    
 
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L' 
         LET g_current_idx = g_header_cnt
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
 
            PROMPT ls_msg CLIPPED,': ' FOR g_jump
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
   
   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   
   
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   LET g_detail_cnt = g_header_cnt                  
   
   #單身筆數顯示
   DISPLAY g_detail_cnt TO FORMONLY.cnt                      #設定page 總筆數 
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart + g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數
   
   CALL cl_navigator_setting(g_current_idx,g_detail_cnt)
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_glax_m.glaxld = g_browser[g_current_idx].b_glaxld
   LET g_glax_m.glaxdocno = g_browser[g_current_idx].b_glaxdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aglt400_master_referesh USING g_glax_m.glaxld,g_glax_m.glaxdocno INTO g_glax_m.glaxld,g_glax_m.glaxcomp, 
       g_glax_m.glaxdocno,g_glax_m.glaxdocdt,g_glax_m.glax049,g_glax_m.glax050,g_glax_m.glaxstus,g_glax_m.glaxld_desc, 
       g_glax_m.glaxcomp_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "glax_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_glax_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_glax_m_mask_o.* =  g_glax_m.*
   CALL aglt400_glax_t_mask()
   LET g_glax_m_mask_n.* =  g_glax_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aglt400_set_act_visible()
   CALL aglt400_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_glax_m_t.* = g_glax_m.*
   LET g_glax_m_o.* = g_glax_m.*
   
   #重新顯示   
   CALL aglt400_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aglt400.insert" >}
#+ 資料新增
PRIVATE FUNCTION aglt400_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_errno         LIKE type_t.chr100
   DEFINE l_glav002       LIKE glav_t.glav002
   DEFINE l_glav005       LIKE glav_t.glav005
   DEFINE l_sdate_s       LIKE glav_t.glav004
   DEFINE l_sdate_e       LIKE glav_t.glav004
   DEFINE l_glav006       LIKE glav_t.glav006
   DEFINE l_pdate_s       LIKE glav_t.glav004
   DEFINE l_pdate_e       LIKE glav_t.glav004
   DEFINE l_glav007       LIKE glav_t.glav007
   DEFINE l_wdate_s       LIKE glav_t.glav004
   DEFINE l_wdate_e       LIKE glav_t.glav004
   DEFINE l_pass          LIKE type_t.num5      #160518-00075#27 add lujh
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
      
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_glax_d.clear()
   CALL g_glax2_d.clear()
 
 
   INITIALIZE g_glax_m.* TO NULL             #DEFAULT 設定
   LET g_glaxld_t = NULL
   LET g_glaxdocno_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_glax_m.glaxstus = "N"
 
     
      #add-point:單頭預設值 name="insert.default"
#      CALL cl_set_comp_visible("glax007,glax008,glax009",FALSE)
      
      #160518-00075#27--add--str--lujh
      CALL s_ld_chk_authorization(g_user,g_glaxld) RETURNING l_pass
      IF l_pass = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axr-00022'
         LET g_errparam.extend = g_glaxld
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN 
      END IF 
      #160518-00075#27--add--end--lujh
      
      INITIALIZE g_glax_m_t.* LIKE glax_t.*             #DEFAULT 設定
      LET g_glax_m.glaxld = g_glaxld                    #账别
      CALL aglt400_glaxld_desc(g_glax_m.glaxld)         #帐别说明
      DISPLAY BY NAME g_glax_m.glaxld,g_glax_m.glaxld_desc,g_glax_m.glaxcomp,g_glax_m.glaxcomp_desc,
                      g_glax_m.glaa001,g_glax_m.glaa016,g_glax_m.glaa020
      LET g_glax_m.glaxdocdt = g_today     #传票日期
      CALL s_get_accdate(g_glaa003,g_glax_m.glaxdocdt,'','')
      RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
      LET g_glax_m.glax049 = l_glav002
      LET g_glax_m.glax050 = l_glav006
      #狀態碼賦值
      LET g_glax_m.glaxstus = 'N'
      CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      #end add-point 
 
      CALL aglt400_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
            
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_glax_m.* TO NULL
         INITIALIZE g_glax_d TO NULL
         INITIALIZE g_glax2_d TO NULL
 
         CALL aglt400_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_glax_m.* = g_glax_m_t.*
         CALL aglt400_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_glax_d.clear()
      #CALL g_glax2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
            
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aglt400_set_act_visible()
   CALL aglt400_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_glaxld_t = g_glax_m.glaxld
   LET g_glaxdocno_t = g_glax_m.glaxdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " glaxent = " ||g_enterprise|| " AND",
                      " glaxld = '", g_glax_m.glaxld, "' "
                      ," AND glaxdocno = '", g_glax_m.glaxdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aglt400_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL aglt400_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aglt400_master_referesh USING g_glax_m.glaxld,g_glax_m.glaxdocno INTO g_glax_m.glaxld,g_glax_m.glaxcomp, 
       g_glax_m.glaxdocno,g_glax_m.glaxdocdt,g_glax_m.glax049,g_glax_m.glax050,g_glax_m.glaxstus,g_glax_m.glaxld_desc, 
       g_glax_m.glaxcomp_desc
   
   #遮罩相關處理
   LET g_glax_m_mask_o.* =  g_glax_m.*
   CALL aglt400_glax_t_mask()
   LET g_glax_m_mask_n.* =  g_glax_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_glax_m.glaxld,g_glax_m.glaxld_desc,g_glax_m.glaxcomp,g_glax_m.glaxcomp_desc,g_glax_m.glaa001, 
       g_glax_m.glaa016,g_glax_m.glaa020,g_glax_m.glaxdocno,g_glax_m.glaxdocdt,g_glax_m.glax049,g_glax_m.glax050, 
       g_glax_m.glaxstus,g_glax_m.glax027_desc,g_glax_m.glax028_desc,g_glax_m.conf,g_glax_m.crt
   
   #功能已完成,通報訊息中心
   CALL aglt400_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.modify" >}
#+ 資料修改
PRIVATE FUNCTION aglt400_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
         DEFINE l_success    LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_glax_m.glaxld IS NULL
   OR g_glax_m.glaxdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_glaxld_t = g_glax_m.glaxld
   LET g_glaxdocno_t = g_glax_m.glaxdocno
 
   CALL s_transaction_begin()
   
   OPEN aglt400_cl USING g_enterprise,g_glax_m.glaxld,g_glax_m.glaxdocno
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglt400_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aglt400_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglt400_master_referesh USING g_glax_m.glaxld,g_glax_m.glaxdocno INTO g_glax_m.glaxld,g_glax_m.glaxcomp, 
       g_glax_m.glaxdocno,g_glax_m.glaxdocdt,g_glax_m.glax049,g_glax_m.glax050,g_glax_m.glaxstus,g_glax_m.glaxld_desc, 
       g_glax_m.glaxcomp_desc
   
   #遮罩相關處理
   LET g_glax_m_mask_o.* =  g_glax_m.*
   CALL aglt400_glax_t_mask()
   LET g_glax_m_mask_n.* =  g_glax_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL aglt400_show()
   WHILE TRUE
      LET g_glaxld_t = g_glax_m.glaxld
      LET g_glaxdocno_t = g_glax_m.glaxdocno
 
 
      #add-point:modify段修改前 name="modify.before_input"
      CALL s_ld_chk_authorization(g_user,g_glax_m.glaxld) RETURNING l_success
      IF l_success = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00164'
         LET g_errparam.extend = g_glax_m.glaxld
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CLOSE aglt400_cl
         CALL s_transaction_end('N','0')
         RETURN         
      END IF
      
      IF g_glax_m.glaxstus <> 'N' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00313'
         LET g_errparam.extend = g_glax_m.glaxld
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CLOSE aglt400_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #檢查當單據日期小於等於關帳日期時，不可異動單據
      CALL s_fin_date_close_chk(g_glax_m.glaxld,'','AGL',g_glax_m.glaxdocdt) RETURNING l_success
      IF l_success = FALSE THEN
         CLOSE aglt400_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   
      CALL aglt400_chk_glax047() RETURNING l_success
      IF l_success=TRUE THEN
         CLOSE aglt400_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF         
      #end add-point
      
      CALL aglt400_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
            
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_glax_m.* = g_glax_m_t.*
         CALL aglt400_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_glax_m.glaxld != g_glaxld_t 
      OR g_glax_m.glaxdocno != g_glaxdocno_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前 name="modify.b_key_update"
                  
         #end add-point
         
         #add-point:單頭(偽)修改中 name="modify.m_key_update"
                  
         #end add-point
         
 
         
         #add-point:單頭(偽)修改後 name="modify.a_key_update"
                  
         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aglt400_set_act_visible()
   CALL aglt400_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " glaxent = " ||g_enterprise|| " AND",
                      " glaxld = '", g_glax_m.glaxld, "' "
                      ," AND glaxdocno = '", g_glax_m.glaxdocno, "' "
 
   #填到對應位置
   CALL aglt400_browser_fill("")
 
   CALL aglt400_idx_chk()
 
   CLOSE aglt400_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aglt400_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="aglt400.input" >}
#+ 資料輸入
PRIVATE FUNCTION aglt400_input(p_cmd)
   #add-point:input段define name="input.define_customerization"
   
   #end add-point   
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
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
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_glax002       STRING
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_errno         LIKE type_t.chr100
   DEFINE l_glav002       LIKE glav_t.glav002
   DEFINE l_glav005       LIKE glav_t.glav005
   DEFINE l_sdate_s       LIKE glav_t.glav004
   DEFINE l_sdate_e       LIKE glav_t.glav004
   DEFINE l_glav006       LIKE glav_t.glav006
   DEFINE l_pdate_s       LIKE glav_t.glav004
   DEFINE l_pdate_e       LIKE glav_t.glav004
   DEFINE l_glav007       LIKE glav_t.glav007
   DEFINE l_wdate_s       LIKE glav_t.glav004
   DEFINE l_wdate_e       LIKE glav_t.glav004
   DEFINE l_str           STRING
   DEFINE l_glaa004       LIKE glaa_t.glaa004  #150916-00015#1 -add
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
   DISPLAY BY NAME g_glax_m.glaxld,g_glax_m.glaxld_desc,g_glax_m.glaxcomp,g_glax_m.glaxcomp_desc,g_glax_m.glaa001, 
       g_glax_m.glaa016,g_glax_m.glaa020,g_glax_m.glaxdocno,g_glax_m.glaxdocdt,g_glax_m.glax049,g_glax_m.glax050, 
       g_glax_m.glaxstus,g_glax_m.glax027_desc,g_glax_m.glax028_desc,g_glax_m.conf,g_glax_m.crt
   
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
   LET g_forupd_sql = "SELECT glaxseq,glax002,glax005,glax006,glax007,glax008,glax009,glax010,glax003, 
       glax051,glax052,glax055,glax056,glax048,glax001,glaxseq,glaxmodid,glaxownid,glaxowndp,glaxcrtid, 
       glaxcrtdp,glaxcrtdt,glaxcnfid,glaxcnfdt FROM glax_t WHERE glaxent=? AND glaxld=? AND glaxdocno=?  
       AND glaxseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
      
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglt400_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aglt400_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
      
   #end add-point
   CALL aglt400_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
      
   #end add-point
 
   DISPLAY BY NAME g_glax_m.glaxld,g_glax_m.glaxcomp,g_glax_m.glaxdocno,g_glax_m.glaxdocdt,g_glax_m.glax049, 
       g_glax_m.glax050,g_glax_m.glaxstus
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
         CALL cl_set_comp_entry("glaxld",FALSE)
   IF l_cmd_t = 'r' THEN
      LET g_glax_m.glaxstus = 'N'
   END IF 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aglt400.input.head" >}
   
      #單頭段
      INPUT BY NAME g_glax_m.glaxld,g_glax_m.glaxcomp,g_glax_m.glaxdocno,g_glax_m.glaxdocdt,g_glax_m.glax049, 
          g_glax_m.glax050,g_glax_m.glaxstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
                        
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaxld
            
            #add-point:AFTER FIELD glaxld name="input.a.glaxld"
                                    #此段落由子樣板a05產生
            IF  NOT cl_null(g_glax_m.glaxld) AND NOT cl_null(g_glax_m.glaxdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_glax_m.glaxld != g_glaxld_t  OR g_glax_m.glaxdocno != g_glaxdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glax_t WHERE "||"glaxent = '" ||g_enterprise|| "' AND "||"glaxld = '"||g_glax_m.glaxld ||"' AND "|| "glaxdocno = '"||g_glax_m.glaxdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glax_m.glaxld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glax_m.glaxld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glax_m.glaxld_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxld
            #add-point:BEFORE FIELD glaxld name="input.b.glaxld"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaxld
            #add-point:ON CHANGE glaxld name="input.g.glaxld"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaxcomp
            
            #add-point:AFTER FIELD glaxcomp name="input.a.glaxcomp"
                                    INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glax_m.glaxcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glax_m.glaxcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glax_m.glaxcomp_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxcomp
            #add-point:BEFORE FIELD glaxcomp name="input.b.glaxcomp"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaxcomp
            #add-point:ON CHANGE glaxcomp name="input.g.glaxcomp"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxdocno
            #add-point:BEFORE FIELD glaxdocno name="input.b.glaxdocno"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaxdocno
            
            #add-point:AFTER FIELD glaxdocno name="input.a.glaxdocno"
            IF NOT cl_null(g_glax_m.glaxld) AND NOT cl_null(g_glax_m.glaxdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_glax_m.glaxld != g_glaxld_t  OR g_glax_m.glaxdocno != g_glaxdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glax_t WHERE "||"glaxent = '" ||g_enterprise|| "' AND "||"glaxld = '"||g_glax_m.glaxld ||"' AND "|| "glaxdocno = '"||g_glax_m.glaxdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_glax_m.glaxdocno) THEN
#               CALL aglt400_glaxdocno_chk(g_glax_m.glaxdocno)
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_glax_m.glaxdocno
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  LET g_glax_m.glaxdocno = ''
#                  NEXT FIELD glaxdocno
#               END IF 
               CALL s_aooi200_fin_chk_docno(g_glax_m.glaxld,'','',g_glax_m.glaxdocno,g_glax_m.glaxdocdt,g_prog) 
               RETURNING l_success
               IF NOT l_success THEN
                  LET g_glax_m.glaxdocno = ''
                  NEXT FIELD CURRENT
               END IF
            END IF               


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaxdocno
            #add-point:ON CHANGE glaxdocno name="input.g.glaxdocno"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxdocdt
            #add-point:BEFORE FIELD glaxdocdt name="input.b.glaxdocdt"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaxdocdt
            
            #add-point:AFTER FIELD glaxdocdt name="input.a.glaxdocdt"
                                    IF NOT cl_null(g_glax_m.glaxdocdt) THEN
               IF g_glax_m.glaxdocdt < g_glaa013 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00160'
                  LET g_errparam.extend = g_glax_m.glaxdocdt
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glax_m.glaxdocdt = ''
                  LET g_glax_m.glax049 = ''
                  LET g_glax_m.glax050 = ''
                  DISPLAY BY NAME g_glax_m.glax049,g_glax_m.glax050
                  NEXT FIELD glaxdocdt
               END IF 
               #抓取年度期别
#               SELECT oogc015,oogc006 INTO g_glax_m.glax049,g_glax_m.glax050 FROM oogc_t
#                WHERE oogcent = g_enterprise
#                  AND oogc001 = g_ooef008
#                  AND oogc002 = g_ooef010
#                  AND oogc003 = g_glax_m.glaxdocdt
               CALL s_get_accdate(g_glaa003,g_glax_m.glaxdocdt,'','')
               RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               LET g_glax_m.glax049 = l_glav002
               LET g_glax_m.glax050 = l_glav006
               IF l_flag='N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD glaxdocdt
               END IF
            END IF       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaxdocdt
            #add-point:ON CHANGE glaxdocdt name="input.g.glaxdocdt"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax049
            #add-point:BEFORE FIELD glax049 name="input.b.glax049"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax049
            
            #add-point:AFTER FIELD glax049 name="input.a.glax049"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glax049
            #add-point:ON CHANGE glax049 name="input.g.glax049"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax050
            #add-point:BEFORE FIELD glax050 name="input.b.glax050"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax050
            
            #add-point:AFTER FIELD glax050 name="input.a.glax050"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glax050
            #add-point:ON CHANGE glax050 name="input.g.glax050"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxstus
            #add-point:BEFORE FIELD glaxstus name="input.b.glaxstus"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaxstus
            
            #add-point:AFTER FIELD glaxstus name="input.a.glaxstus"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaxstus
            #add-point:ON CHANGE glaxstus name="input.g.glaxstus"
                        
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glaxld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaxld
            #add-point:ON ACTION controlp INFIELD glaxld name="input.c.glaxld"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaxcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaxcomp
            #add-point:ON ACTION controlp INFIELD glaxcomp name="input.c.glaxcomp"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaxdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaxdocno
            #add-point:ON ACTION controlp INFIELD glaxdocno name="input.c.glaxdocno"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glax_m.glaxdocno             #給予default值

            #給予arg
#            LET g_qryparam.where = "ooba001 = '",g_ooef004,"' AND oobx002 = 'AGL' AND oobx003 = 'aglt400' "
#            CALL q_ooba002_4()                                #呼叫開窗
            LET g_qryparam.arg1 = g_glaa024
            #LET g_qryparam.arg2 = 'aglt400'     #160705-00042#3 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#3 160711 by sakura add
            CALL q_ooba002_1()
            LET g_glax_m.glaxdocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glax_m.glaxdocno TO glaxdocno              #顯示到畫面上

            NEXT FIELD glaxdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaxdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaxdocdt
            #add-point:ON ACTION controlp INFIELD glaxdocdt name="input.c.glaxdocdt"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glax049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax049
            #add-point:ON ACTION controlp INFIELD glax049 name="input.c.glax049"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glax050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax050
            #add-point:ON ACTION controlp INFIELD glax050 name="input.c.glax050"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaxstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaxstus
            #add-point:ON ACTION controlp INFIELD glaxstus name="input.c.glaxstus"
                        
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            DISPLAY BY NAME g_glax_m.glaxld             
                            ,g_glax_m.glaxdocno   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
                              
               #end add-point
            
               #將遮罩欄位還原
               CALL aglt400_glax_t_mask_restore('restore_mask_o')
            
               UPDATE glax_t SET (glaxld,glaxcomp,glaxdocno,glaxdocdt,glax049,glax050,glaxstus) = (g_glax_m.glaxld, 
                   g_glax_m.glaxcomp,g_glax_m.glaxdocno,g_glax_m.glaxdocdt,g_glax_m.glax049,g_glax_m.glax050, 
                   g_glax_m.glaxstus)
                WHERE glaxent = g_enterprise AND glaxld = g_glaxld_t
                  AND glaxdocno = g_glaxdocno_t
 
               #add-point:單頭修改中 name="input.head.m_update"
                              
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glax_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glax_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glax_m.glaxld
               LET gs_keys_bak[1] = g_glaxld_t
               LET gs_keys[2] = g_glax_m.glaxdocno
               LET gs_keys_bak[2] = g_glaxdocno_t
               LET gs_keys[3] = g_glax_d[g_detail_idx].glaxseq
               LET gs_keys_bak[3] = g_glax_d_t.glaxseq
               CALL aglt400_update_b('glax_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                                          
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_glax_m_t)
                     #LET g_log2 = util.JSON.stringify(g_glax_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL aglt400_glax_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
              CALL s_aooi200_fin_gen_docno(g_glax_m.glaxld,g_glaa024,g_glaa003,g_glax_m.glaxdocno,g_glax_m.glaxdocdt,g_prog)
               RETURNING l_success,g_glax_m.glaxdocno
               IF l_success  = FALSE  THEN
                  RETURN
               END IF
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aglt400_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_glaxld_t = g_glax_m.glaxld
           LET g_glaxdocno_t = g_glax_m.glaxdocno
 
           
           IF g_glax_d.getLength() = 0 THEN
              NEXT FIELD glaxseq
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="aglt400.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_glax_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_glax_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aglt400_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
                        
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt400_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN aglt400_cl USING g_enterprise,g_glax_m.glaxld,g_glax_m.glaxdocno                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE aglt400_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aglt400_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_glax_d[l_ac].glaxseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_glax_d_t.* = g_glax_d[l_ac].*  #BACKUP
               LET g_glax_d_o.* = g_glax_d[l_ac].*  #BACKUP
               CALL aglt400_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL aglt400_set_no_entry_b(l_cmd)
               OPEN aglt400_bcl USING g_enterprise,g_glax_m.glaxld,
                                                g_glax_m.glaxdocno,
 
                                                g_glax_d_t.glaxseq
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aglt400_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aglt400_bcl INTO g_glax_d[l_ac].glaxseq,g_glax_d[l_ac].glax002,g_glax_d[l_ac].glax005, 
                      g_glax_d[l_ac].glax006,g_glax_d[l_ac].glax007,g_glax_d[l_ac].glax008,g_glax_d[l_ac].glax009, 
                      g_glax_d[l_ac].glax010,g_glax_d[l_ac].glax003,g_glax_d[l_ac].glax051,g_glax_d[l_ac].glax052, 
                      g_glax_d[l_ac].glax055,g_glax_d[l_ac].glax056,g_glax_d[l_ac].glax048,g_glax_d[l_ac].glax001, 
                      g_glax2_d[l_ac].glaxseq,g_glax2_d[l_ac].glaxmodid,g_glax2_d[l_ac].glaxownid,g_glax2_d[l_ac].glaxowndp, 
                      g_glax2_d[l_ac].glaxcrtid,g_glax2_d[l_ac].glaxcrtdp,g_glax2_d[l_ac].glaxcrtdt, 
                      g_glax2_d[l_ac].glaxcnfid,g_glax2_d[l_ac].glaxcnfdt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_glax_d_t.glaxseq,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_glax_d_mask_o[l_ac].* =  g_glax_d[l_ac].*
                  CALL aglt400_glax_t_mask()
                  LET g_glax_d_mask_n[l_ac].* =  g_glax_d[l_ac].*
                  
                  CALL aglt400_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            #核算项
            INITIALIZE g_glax_r.* TO NULL
            SELECT glax017,glax018,glax019,glax020,glax021,glax022,glax023,
                   glax024,glax025,glax027,glax028,glax061,glax062,glax063,
                   glax029,glax030,glax031,glax032,glax033,glax034,glax035,
                   glax036,glax037,glax038
              INTO g_glax_r.glax017,g_glax_r.glax018,g_glax_r.glax019,g_glax_r.glax020,
                   g_glax_r.glax021,g_glax_r.glax022,g_glax_r.glax023,g_glax_r.glax024,
                   g_glax_r.glax025,g_glax_r.glax027,g_glax_r.glax028,g_glax_r.glax061,
                   g_glax_r.glax062,g_glax_r.glax063,g_glax_r.glax029,g_glax_r.glax030,
                   g_glax_r.glax031,g_glax_r.glax032,g_glax_r.glax033,g_glax_r.glax034,
                   g_glax_r.glax035,g_glax_r.glax036,g_glax_r.glax037,g_glax_r.glax038
              FROM glax_t
             WHERE glaxent = g_enterprise
               AND glaxld = g_glax_m.glaxld
               AND glaxdocno = g_glax_m.glaxdocno
               AND glaxseq = g_glax_d[l_ac].glaxseq
            #组合科目，科目名称，以及各核算项
            IF NOT cl_null(g_glax_d[l_ac].glax002) THEN
               CALL aglt400_glax002() RETURNING l_glax002,l_str
               LET g_glax_d[l_ac].lc_subject = g_glax_d[l_ac].glax002,l_str,'\n',l_glax002
               DISPLAY BY NAME g_glax_d[l_ac].lc_subject 
            END IF            
            #end add-point  
            
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_glax_d_t.* TO NULL
            INITIALIZE g_glax_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_glax_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_glax2_d[l_ac].glaxownid = g_user
      LET g_glax2_d[l_ac].glaxowndp = g_dept
      LET g_glax2_d[l_ac].glaxcrtid = g_user
      LET g_glax2_d[l_ac].glaxcrtdp = g_dept 
      LET g_glax2_d[l_ac].glaxcrtdt = cl_get_current()
      LET g_glax2_d[l_ac].glaxmodid = g_user
 
 
  
            #一般欄位預設值
            
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_glax_d_t.* = g_glax_d[l_ac].*     #新輸入資料
            LET g_glax_d_o.* = g_glax_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglt400_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL aglt400_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glax_d[li_reproduce_target].* = g_glax_d[li_reproduce].*
               LET g_glax2_d[li_reproduce_target].* = g_glax2_d[li_reproduce].*
 
               LET g_glax_d[g_glax_d.getLength()].glaxseq = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            IF g_glax_d[l_ac].glaxseq IS NULL OR g_glax_d[l_ac].glaxseq = 0 THEN
              SELECT max(glaxseq)+1
                INTO g_glax_d[l_ac].glaxseq
                FROM glax_t
               WHERE glaxent = g_enterprise
                 AND glaxld = g_glax_m.glaxld
                 AND glaxdocno = g_glax_m.glaxdocno
              IF g_glax_d[l_ac].glaxseq IS NULL THEN
                 LET g_glax_d[l_ac].glaxseq = 1
              END IF
           END IF
           LET g_glax_d[l_ac].glax005=g_glaa001
           LET g_glax_d[l_ac].glax051=0
           LET g_glax_d[l_ac].glax052=0
           LET g_glax_d[l_ac].glax055=0
           LET g_glax_d[l_ac].glax056=0
            #核算项
            INITIALIZE g_glax_r.* TO NULL
            #end add-point  
 
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM glax_t 
             WHERE glaxent = g_enterprise AND glaxld = g_glax_m.glaxld
               AND glaxdocno = g_glax_m.glaxdocno
 
               AND glaxseq = g_glax_d[l_ac].glaxseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
                                            
               IF cl_null(g_glax_d[l_ac].glax003) THEN LET g_glax_d[l_ac].glax003 = 0  END IF 
               IF cl_null(g_glax_d[l_ac].glax008) THEN LET g_glax_d[l_ac].glax008 = 0  END IF 
               IF cl_null(g_glax_d[l_ac].glax009) THEN LET g_glax_d[l_ac].glax009 = 0  END IF 
               IF cl_null(g_glax_d[l_ac].glax010) THEN LET g_glax_d[l_ac].glax010 = 0  END IF 
               #end add-point
               INSERT INTO glax_t
                           (glaxent,
                            glaxld,glaxcomp,glaxdocno,glaxdocdt,glax049,glax050,glaxstus,
                            glaxseq
                            ,glax002,glax005,glax006,glax007,glax008,glax009,glax010,glax003,glax051,glax052,glax055,glax056,glax048,glax001,glaxmodid,glaxownid,glaxowndp,glaxcrtid,glaxcrtdp,glaxcrtdt,glaxcnfid,glaxcnfdt) 
                     VALUES(g_enterprise,
                            g_glax_m.glaxld,g_glax_m.glaxcomp,g_glax_m.glaxdocno,g_glax_m.glaxdocdt,g_glax_m.glax049,g_glax_m.glax050,g_glax_m.glaxstus,
                            g_glax_d[l_ac].glaxseq
                            ,g_glax_d[l_ac].glax002,g_glax_d[l_ac].glax005,g_glax_d[l_ac].glax006,g_glax_d[l_ac].glax007, 
                                g_glax_d[l_ac].glax008,g_glax_d[l_ac].glax009,g_glax_d[l_ac].glax010, 
                                g_glax_d[l_ac].glax003,g_glax_d[l_ac].glax051,g_glax_d[l_ac].glax052, 
                                g_glax_d[l_ac].glax055,g_glax_d[l_ac].glax056,g_glax_d[l_ac].glax048, 
                                g_glax_d[l_ac].glax001,g_glax2_d[l_ac].glaxmodid,g_glax2_d[l_ac].glaxownid, 
                                g_glax2_d[l_ac].glaxowndp,g_glax2_d[l_ac].glaxcrtid,g_glax2_d[l_ac].glaxcrtdp, 
                                g_glax2_d[l_ac].glaxcrtdt,g_glax2_d[l_ac].glaxcnfid,g_glax2_d[l_ac].glaxcnfdt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
                                             
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_glax_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "glax_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert"
               #預設預沖相關金額數量為0
               UPDATE glax_t
                  SET (glax041,glax042,glax043,glax044,glax045,glax046,glax047,glax053,glax054,glax057,glax058)
                     =(0,0,0,0,0,0,'0',0,0,0,0)
                WHERE glaxent=g_enterprise AND glaxld=g_glax_m.glaxld
                  AND glaxdocno=g_glax_m.glaxdocno 
                  AND glaxseq=g_glax_d[l_ac].glaxseq
              
               #業務諮詢新增
               LET g_glax.glax011 = ''  LET g_glax.glax012=''  LET g_glax.glax013=''
               LET g_glax.glax014 = ''  LET g_glax.glax015=''  LET g_glax.glax016=''
               CALL aglt400_01('a',g_glax_m.glaxld,g_glax_m.glaxdocno,g_glax_m.glaxdocdt,g_glax_d[l_ac].glax002,g_glax_d[l_ac].glaxseq)
               RETURNING g_glax.glax011,g_glax.glax012,g_glax.glax013,g_glax.glax014,g_glax.glax015,g_glax.glax016
               #更新業務諮詢，固定覈算項資料
               CALL aglt400_update_frozen() RETURNING l_success
               IF l_success = FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "glax_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF 
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後 name="input.body.after_insert"
                        
            #end add-point
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete"
                              
               #end add-point
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               IF aglt400_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_glax_m.glaxld
                  LET gs_keys[gs_keys.getLength()+1] = g_glax_m.glaxdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_glax_d_t.glaxseq
 
 
                  #刪除下層單身
                  IF NOT aglt400_key_delete_b(gs_keys,'glax_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aglt400_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aglt400_bcl
               LET l_count = g_glax_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
                        
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
                        
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_glax_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaxseq
            #add-point:BEFORE FIELD glaxseq name="input.b.page1.glaxseq"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaxseq
            
            #add-point:AFTER FIELD glaxseq name="input.a.page1.glaxseq"
                                    #此段落由子樣板a05產生
            IF  g_glax_m.glaxld IS NOT NULL AND g_glax_m.glaxdocno IS NOT NULL AND g_glax_d[g_detail_idx].glaxseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glax_m.glaxld != g_glaxld_t OR g_glax_m.glaxdocno != g_glaxdocno_t OR g_glax_d[g_detail_idx].glaxseq != g_glax_d_t.glaxseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glax_t WHERE "||"glaxent = '" ||g_enterprise|| "' AND "||"glaxld = '"||g_glax_m.glaxld ||"' AND "|| "glaxdocno = '"||g_glax_m.glaxdocno ||"' AND "|| "glaxseq = '"||g_glax_d[g_detail_idx].glaxseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaxseq
            #add-point:ON CHANGE glaxseq name="input.g.page1.glaxseq"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax002
            #add-point:BEFORE FIELD glax002 name="input.b.page1.glax002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax002
            
            #add-point:AFTER FIELD glax002 name="input.a.page1.glax002"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glax002
            #add-point:ON CHANGE glax002 name="input.g.page1.glax002"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lc_subject
            #add-point:BEFORE FIELD lc_subject name="input.b.page1.lc_subject"
                                    LET g_glax_d[l_ac].lc_subject = g_glax_d[l_ac].glax002 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lc_subject
            
            #add-point:AFTER FIELD lc_subject name="input.a.page1.lc_subject"
            IF NOT cl_null(g_glax_d[l_ac].lc_subject) THEN
               # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_glax_m.glaxld,g_glax_d[l_ac].lc_subject,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_glax_m.glaxld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 =g_glax_d[l_ac].lc_subject
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_glax_d[l_ac].lc_subject
                  LET g_qryparam.arg3 = g_glax_m.glaxld
                  LET g_qryparam.arg4 = " 1 AND glad035='N' AND glad003 = 'Y' "
                
                  CALL q_glac002_6()
                  LET  g_glax_d[l_ac].lc_subject = g_qryparam.return1 
                  DISPLAY g_glax_d[l_ac].lc_subject TO lc_subject                  
               END IF
               # 150916-00015#1 --end
               #151117-00009#1--add--str--
               #科目存在性，有效性，非统治科目，账户科目属性检查
               CALL s_voucher_glaq002_chk(g_glax_m.glaxld,g_glax_d[l_ac].lc_subject)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glax_d[l_ac].lc_subject
                  #160321-00016#31 --s add
                  LET g_errparam.replace[1] = 'agli030'
                  LET g_errparam.replace[2] = cl_get_progname('agli030',g_lang,"2")
                  LET g_errparam.exeprog = 'agli030'
                  #160321-00016#31 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glax_d[l_ac].lc_subject = g_glax_d_t.lc_subject
                  NEXT FIELD lc_subject                  
               END IF
               #151117-00009#1--add--end
               #科目为细项立冲，为非子系统科目
               CALL aglt400_glax002_chk(g_glax_d[l_ac].lc_subject)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glax_d[l_ac].lc_subject
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glax_d[l_ac].lc_subject = g_glax_d_t.lc_subject
                  NEXT FIELD lc_subject                  
               END IF  
               LET g_glax_d[l_ac].glax002 =g_glax_d[l_ac].lc_subject                
               #录入核算项   
               CALL aglt310_02('',g_glax_m.glaxld,'',g_glax_m.glaxdocdt,g_glax_d[l_ac].lc_subject,'','aglt400',g_glax_r.*) 
               RETURNING g_glax_r.glax017,g_glax_r.glax018,g_glax_r.glax019,g_glax_r.glax020,g_glax_r.glax021,
                         g_glax_r.glax022,g_glax_r.glax023,g_glax_r.glax024,g_glax_r.glax061,g_glax_r.glax062,
                         g_glax_r.glax063,g_glax_r.glax025,g_glax_r.glax027,g_glax_r.glax028,g_glax_r.glax029,
                         g_glax_r.glax030,g_glax_r.glax031,g_glax_r.glax032,g_glax_r.glax033,g_glax_r.glax034,
                         g_glax_r.glax035,g_glax_r.glax036,g_glax_r.glax037,g_glax_r.glax038,g_glax_r.glbc004

               #组合科目，科目名称，以及各核算项
               CALL aglt400_glax002() RETURNING l_glax002,l_str
               LET g_glax_d[l_ac].lc_subject = g_glax_d[l_ac].glax002,l_str,'\n',l_glax002
               DISPLAY BY NAME g_glax_d[l_ac].lc_subject
               
               #科目有設定為數量金額式='Y'時,計價單位/數量/單價才呈現且為必輸不可空白
               CALL aglt400_glad005_chk()
               
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lc_subject
            #add-point:ON CHANGE lc_subject name="input.g.page1.lc_subject"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax005
            #add-point:BEFORE FIELD glax005 name="input.b.page1.glax005"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax005
            
            #add-point:AFTER FIELD glax005 name="input.a.page1.glax005"
            IF NOT cl_null(g_glax_d[l_ac].glax005) THEN
               CALL aglt400_glax005_chk(g_glax_d[l_ac].glax005) 
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glax_d[l_ac].glax005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glax_d[l_ac].glax005 = g_glax_d_t.glax005
                  NEXT FIELD glax005
               ELSE
                  #錄入幣別與當前預設的幣別相同，匯率就是1
                  #本位幣一匯率
                  #日汇率
                  IF g_glaa028 = '1' THEN #160918-00006#3 add
                  CALL s_aooi160_get_exrate('2',g_glax_m.glaxld,g_glax_m.glaxdocdt,g_glax_d[l_ac].glax005,g_glaa001,0,g_glaa025)
                  RETURNING  g_glax_d[l_ac].glax006
                  #160918-00006#3--add--str--
                  ELSE
                     #月汇率
                     CALL s_aooi160_get_exrate_avg('2',g_glax_m.glaxld,g_glax_m.glaxdocdt,g_glax_d[l_ac].glax005,g_glaa001,0,g_glaa025)
                     RETURNING l_success,g_errno,g_glax_d[l_ac].glax006
                  END IF
                  #160918-00006#3--add--end
                  #本位幣二匯率
                  IF g_glaa015='Y' THEN
                     IF g_glaa017='1' THEN #依交易原幣轉換
                        #日汇率
                        IF g_glaa028 = '1' THEN #160918-00006#3 add
                        CALL s_aooi160_get_exrate('2',g_glax_m.glaxld,g_glax_m.glaxdocdt,g_glax_d[l_ac].glax005,g_glaa016,0,g_glaa018)
                        RETURNING  g_glax_d[l_ac].glax051
                        #160918-00006#3--add--str--
                        ELSE
                           #月汇率
                           CALL s_aooi160_get_exrate_avg('2',g_glax_m.glaxld,g_glax_m.glaxdocdt,g_glax_d[l_ac].glax005,g_glaa016,0,g_glaa018)
                           RETURNING l_success,g_errno,g_glax_d[l_ac].glax051
                        END IF
                        #160918-00006#3--add--end
                     ELSE #依帳簿幣別
                        #日汇率
                        IF g_glaa028 = '1' THEN #160918-00006#3 add
                        CALL s_aooi160_get_exrate('2',g_glax_m.glaxld,g_glax_m.glaxdocdt,g_glaa001,g_glaa016,0,g_glaa018)
                        RETURNING  g_glax_d[l_ac].glax051
                        #160918-00006#3--add--str--
                        ELSE
                           #月汇率
                           CALL s_aooi160_get_exrate_avg('2',g_glax_m.glaxld,g_glax_m.glaxdocdt,g_glaa001,g_glaa016,0,g_glaa018)
                           RETURNING l_success,g_errno,g_glax_d[l_ac].glax051
                        END IF
                        #160918-00006#3--add--end
                     END IF
                  END IF 
                  #本位幣三匯率
                  IF g_glaa019='Y' THEN
                     IF g_glaa021='1' THEN
                        #日汇率
                        IF g_glaa028 = '1' THEN #160918-00006#3 add
                        CALL s_aooi160_get_exrate('2',g_glax_m.glaxld,g_glax_m.glaxdocdt,g_glax_d[l_ac].glax005,g_glaa020,0,g_glaa022) 
                        RETURNING  g_glax_d[l_ac].glax055
                        #160918-00006#3--add--str--
                        ELSE
                           #月汇率
                           CALL s_aooi160_get_exrate_avg('2',g_glax_m.glaxld,g_glax_m.glaxdocdt,g_glax_d[l_ac].glax005,g_glaa020,0,g_glaa022)
                           RETURNING l_success,g_errno,g_glax_d[l_ac].glax055
                        END IF
                        #160918-00006#3--add--end
                     ELSE
                        #日汇率
                        IF g_glaa028 = '1' THEN #160918-00006#3 add
                        CALL s_aooi160_get_exrate('2',g_glax_m.glaxld,g_glax_m.glaxdocdt,g_glaa001,g_glaa020,0,g_glaa022) 
                        RETURNING  g_glax_d[l_ac].glax055
                        #160918-00006#3--add--str--
                        ELSE
                           #月汇率
                           CALL s_aooi160_get_exrate_avg('2',g_glax_m.glaxld,g_glax_m.glaxdocdt,g_glaa001,g_glaa020,0,g_glaa022)
                           RETURNING l_success,g_errno,g_glax_d[l_ac].glax055
                        END IF
                        #160918-00006#3--add--end
                     END IF
                  END IF
               END IF 
               #金額計算
               IF g_glax_d[l_ac].glax010<>0 THEN
                  LET g_glax_d[l_ac].glax003=g_glax_d[l_ac].glax010*g_glax_d[l_ac].glax006
                  #金額(本位幣二)
                  IF g_glaa015='Y' THEN
                     IF g_glaa017='1' THEN
                        LET g_glax_d[l_ac].glax052=g_glax_d[l_ac].glax010*g_glax_d[l_ac].glax051
                     ELSE
                        LET g_glax_d[l_ac].glax052=g_glax_d[l_ac].glax003*g_glax_d[l_ac].glax051
                     END IF
                  END IF
                  #金額(本位幣三)
                  IF g_glaa019='Y' THEN
                     IF g_glaa021='1' THEN
                        LET g_glax_d[l_ac].glax056=g_glax_d[l_ac].glax010*g_glax_d[l_ac].glax055
                     ELSE
                        LET g_glax_d[l_ac].glax056=g_glax_d[l_ac].glax003*g_glax_d[l_ac].glax055
                     END IF
                  END IF
               END IF
               
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glax005
            #add-point:ON CHANGE glax005 name="input.g.page1.glax005"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax006
            #add-point:BEFORE FIELD glax006 name="input.b.page1.glax006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax006
            
            #add-point:AFTER FIELD glax006 name="input.a.page1.glax006"
                                    #预设 開帳金額=原幣開帳金額*匯率 
            IF l_cmd = 'a' THEN         
               IF NOT cl_null(g_glax_d[l_ac].glax006) AND NOT cl_null(g_glax_d[l_ac].glax010) THEN
                  LET g_glax_d[l_ac].glax003 = g_glax_d[l_ac].glax006 * g_glax_d[l_ac].glax010
                  #金額(本位幣二)
                  IF g_glaa015='Y' THEN
                     IF g_glaa017='1' THEN
                        LET g_glax_d[l_ac].glax052=g_glax_d[l_ac].glax010*g_glax_d[l_ac].glax051
                     ELSE
                        LET g_glax_d[l_ac].glax052=g_glax_d[l_ac].glax003*g_glax_d[l_ac].glax051
                     END IF
                  END IF
                  #金額(本位幣三)
                  IF g_glaa019='Y' THEN
                     IF g_glaa021='1' THEN
                        LET g_glax_d[l_ac].glax056=g_glax_d[l_ac].glax010*g_glax_d[l_ac].glax055
                     ELSE
                        LET g_glax_d[l_ac].glax056=g_glax_d[l_ac].glax003*g_glax_d[l_ac].glax055
                     END IF
                  END IF
               END IF 
            END IF    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glax006
            #add-point:ON CHANGE glax006 name="input.g.page1.glax006"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax007
            #add-point:BEFORE FIELD glax007 name="input.b.page1.glax007"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax007
            
            #add-point:AFTER FIELD glax007 name="input.a.page1.glax007"
                                    IF NOT cl_null(g_glax_d[l_ac].glax007) THEN
               CALL aglt400_glax007_chk(g_glax_d[l_ac].glax007) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glax_d[l_ac].glax007
                  #160318-00005#18  --add--str
                   LET g_errparam.replace[1] ='aooi250'
                   LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                   LET g_errparam.exeprog    ='aooi250'
                   #160318-00005#18 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glax_d[l_ac].glax007 = g_glax_d_t.glax007
                  NEXT FIELD glax007
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glax007
            #add-point:ON CHANGE glax007 name="input.g.page1.glax007"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glax_d[l_ac].glax008,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glax008
            END IF 
 
 
 
            #add-point:AFTER FIELD glax008 name="input.a.page1.glax008"
                                    #原幣開帳金額=數量*單價
            IF l_cmd = 'a' THEN
               IF NOT cl_null(g_glax_d[l_ac].glax008) AND NOT cl_null(g_glax_d[l_ac].glax009) THEN
                  LET g_glax_d[l_ac].glax010 = g_glax_d[l_ac].glax008 * g_glax_d[l_ac].glax009
               END IF
            END IF                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax008
            #add-point:BEFORE FIELD glax008 name="input.b.page1.glax008"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glax008
            #add-point:ON CHANGE glax008 name="input.g.page1.glax008"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glax_d[l_ac].glax009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glax009
            END IF 
 
 
 
            #add-point:AFTER FIELD glax009 name="input.a.page1.glax009"
                                    #原幣開帳金額=數量*單價
            IF l_cmd = 'a' THEN
               IF NOT cl_null(g_glax_d[l_ac].glax009) AND NOT cl_null(g_glax_d[l_ac].glax008) THEN
                  LET g_glax_d[l_ac].glax010 = g_glax_d[l_ac].glax008 * g_glax_d[l_ac].glax009
               END IF
            END IF                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax009
            #add-point:BEFORE FIELD glax009 name="input.b.page1.glax009"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glax009
            #add-point:ON CHANGE glax009 name="input.g.page1.glax009"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glax_d[l_ac].glax010,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glax010
            END IF 
 
 
 
            #add-point:AFTER FIELD glax010 name="input.a.page1.glax010"
                                    #预设 開帳金額=原幣開帳金額*匯率 
             IF l_cmd = 'a' THEN         
               IF NOT cl_null(g_glax_d[l_ac].glax006) AND NOT cl_null(g_glax_d[l_ac].glax010) THEN
                  LET g_glax_d[l_ac].glax003 = g_glax_d[l_ac].glax006 * g_glax_d[l_ac].glax010
                  #金額(本位幣二)
                  IF g_glaa015='Y' THEN
                     IF g_glaa017='1' THEN
                        LET g_glax_d[l_ac].glax052=g_glax_d[l_ac].glax010*g_glax_d[l_ac].glax051
                     ELSE
                        LET g_glax_d[l_ac].glax052=g_glax_d[l_ac].glax003*g_glax_d[l_ac].glax051
                     END IF
                  END IF
                  #金額(本位幣三)
                  IF g_glaa019='Y' THEN
                     IF g_glaa021='1' THEN
                        LET g_glax_d[l_ac].glax056=g_glax_d[l_ac].glax010*g_glax_d[l_ac].glax055
                     ELSE
                        LET g_glax_d[l_ac].glax056=g_glax_d[l_ac].glax003*g_glax_d[l_ac].glax055
                     END IF
                  END IF
               END IF 
            END IF  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax010
            #add-point:BEFORE FIELD glax010 name="input.b.page1.glax010"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glax010
            #add-point:ON CHANGE glax010 name="input.g.page1.glax010"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glax_d[l_ac].glax003,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glax003
            END IF 
 
 
 
            #add-point:AFTER FIELD glax003 name="input.a.page1.glax003"
                                    IF NOT cl_null(g_glax_d[l_ac].glax003) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax003
            #add-point:BEFORE FIELD glax003 name="input.b.page1.glax003"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glax003
            #add-point:ON CHANGE glax003 name="input.g.page1.glax003"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax051
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glax_d[l_ac].glax051,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glax051
            END IF 
 
 
 
            #add-point:AFTER FIELD glax051 name="input.a.page1.glax051"
                                    IF NOT cl_null(g_glax_d[l_ac].glax051) THEN 
               IF g_glaa017='1' THEN
                  LET g_glax_d[l_ac].glax052=g_glax_d[l_ac].glax010*g_glax_d[l_ac].glax051
               ELSE
                  LET g_glax_d[l_ac].glax052=g_glax_d[l_ac].glax003*g_glax_d[l_ac].glax051 
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax051
            #add-point:BEFORE FIELD glax051 name="input.b.page1.glax051"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glax051
            #add-point:ON CHANGE glax051 name="input.g.page1.glax051"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax052
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glax_d[l_ac].glax052,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glax052
            END IF 
 
 
 
            #add-point:AFTER FIELD glax052 name="input.a.page1.glax052"
                                    IF NOT cl_null(g_glax_d[l_ac].glax052) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax052
            #add-point:BEFORE FIELD glax052 name="input.b.page1.glax052"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glax052
            #add-point:ON CHANGE glax052 name="input.g.page1.glax052"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax055
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glax_d[l_ac].glax055,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glax055
            END IF 
 
 
 
            #add-point:AFTER FIELD glax055 name="input.a.page1.glax055"
                                    IF NOT cl_null(g_glax_d[l_ac].glax055) THEN 
               IF g_glaa021='1' THEN
                  LET g_glax_d[l_ac].glax056=g_glax_d[l_ac].glax010*g_glax_d[l_ac].glax055
               ELSE
                  LET g_glax_d[l_ac].glax056=g_glax_d[l_ac].glax003*g_glax_d[l_ac].glax055
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax055
            #add-point:BEFORE FIELD glax055 name="input.b.page1.glax055"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glax055
            #add-point:ON CHANGE glax055 name="input.g.page1.glax055"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax056
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glax_d[l_ac].glax056,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glax056
            END IF 
 
 
 
            #add-point:AFTER FIELD glax056 name="input.a.page1.glax056"
                                    IF NOT cl_null(g_glax_d[l_ac].glax056) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax056
            #add-point:BEFORE FIELD glax056 name="input.b.page1.glax056"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glax056
            #add-point:ON CHANGE glax056 name="input.g.page1.glax056"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax048
            #add-point:BEFORE FIELD glax048 name="input.b.page1.glax048"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax048
            
            #add-point:AFTER FIELD glax048 name="input.a.page1.glax048"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glax048
            #add-point:ON CHANGE glax048 name="input.g.page1.glax048"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glax001
            #add-point:BEFORE FIELD glax001 name="input.b.page1.glax001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glax001
            
            #add-point:AFTER FIELD glax001 name="input.a.page1.glax001"
            #161111-00049#1 add s---
            IF NOT cl_null(g_glax_d[l_ac].glax001) THEN
              IF l_ac>1 THEN
                 IF g_glax_d[l_ac].glax001='cc' OR g_glax_d[l_ac].glax001='CC' OR g_glax_d[l_ac].glax001='Cc' OR g_glax_d[l_ac].glax001='cC' THEN
                    LET g_glax_d[l_ac].glax001= g_glax_d[l_ac-1].glax001
                 END IF
              END IF
              LET g_msg = g_glax_d[l_ac].glax001
              IF g_msg[1,1] = '.' THEN
                 LET g_msg = g_msg[2,10]
                 SELECT oocql004 INTO g_glax_d[l_ac].glax001 FROM oocql_t
                  WHERE oocqlent = g_enterprise
                    AND oocql001 = '3005'
                    AND oocql002 = g_msg
                    AND oocql003 = g_dlang
                 DISPLAY BY NAME g_glax_d[l_ac].glax001
              END IF
            END IF 
            #161111-00049#1 add e---                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glax001
            #add-point:ON CHANGE glax001 name="input.g.page1.glax001"
                        
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.glaxseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaxseq
            #add-point:ON ACTION controlp INFIELD glaxseq name="input.c.page1.glaxseq"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.glax002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax002
            #add-point:ON ACTION controlp INFIELD glax002 name="input.c.page1.glax002"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glax_d[l_ac].glax002             #給予default值

            #給予arg

            CALL aglt310_04()                                #呼叫開窗

            LET g_glax_d[l_ac].glax002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glax_d[l_ac].glax002 TO glax002              #顯示到畫面上

            NEXT FIELD glax002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.lc_subject
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lc_subject
            #add-point:ON ACTION controlp INFIELD lc_subject name="input.c.page1.lc_subject"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glax_d[l_ac].lc_subject             #給予default值

            #給予arg
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1' AND glac002 IN (SELECT glad001 FROM glad_t WHERE gladent = '",g_enterprise,"' AND gladld ='",g_glax_m.glaxld,"' AND glad003 = 'Y' AND gladstus = 'Y' AND glad035 = 'N')  "   #150827-00036#7 add glac035 = 'N'
            CALL aglt310_04()                                #呼叫開窗
            LET g_glax_d[l_ac].glax002 = g_qryparam.return1 
            LET g_glax_d[l_ac].lc_subject = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glax_d[l_ac].lc_subject TO lc_subject              #顯示到畫面上

            NEXT FIELD lc_subject                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glax005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax005
            #add-point:ON ACTION controlp INFIELD glax005 name="input.c.page1.glax005"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glax_d[l_ac].glax005             #給予default值

            #給予arg

            CALL q_ooai001()                                #呼叫開窗

            LET g_glax_d[l_ac].glax005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glax_d[l_ac].glax005 TO glax005              #顯示到畫面上

            NEXT FIELD glax005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glax006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax006
            #add-point:ON ACTION controlp INFIELD glax006 name="input.c.page1.glax006"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.glax007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax007
            #add-point:ON ACTION controlp INFIELD glax007 name="input.c.page1.glax007"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glax_d[l_ac].glax007             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_glax_d[l_ac].glax007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glax_d[l_ac].glax007 TO glax007              #顯示到畫面上

            NEXT FIELD glax007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glax008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax008
            #add-point:ON ACTION controlp INFIELD glax008 name="input.c.page1.glax008"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.glax009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax009
            #add-point:ON ACTION controlp INFIELD glax009 name="input.c.page1.glax009"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.glax010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax010
            #add-point:ON ACTION controlp INFIELD glax010 name="input.c.page1.glax010"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.glax003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax003
            #add-point:ON ACTION controlp INFIELD glax003 name="input.c.page1.glax003"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.glax051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax051
            #add-point:ON ACTION controlp INFIELD glax051 name="input.c.page1.glax051"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.glax052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax052
            #add-point:ON ACTION controlp INFIELD glax052 name="input.c.page1.glax052"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.glax055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax055
            #add-point:ON ACTION controlp INFIELD glax055 name="input.c.page1.glax055"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.glax056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax056
            #add-point:ON ACTION controlp INFIELD glax056 name="input.c.page1.glax056"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.glax048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax048
            #add-point:ON ACTION controlp INFIELD glax048 name="input.c.page1.glax048"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.glax001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glax001
            #add-point:ON ACTION controlp INFIELD glax001 name="input.c.page1.glax001"
            #開窗i段
            #161111-00049#4 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glax_d[l_ac].glax001             #給予default值 
            LET g_qryparam.where = " ( oocq004 = '",g_glax_m.glaxcomp,"' OR oocq004 IS NULL) " #161111-00049#4 add
            #給予arg
            CALL q_oocq002_2()                                #呼叫開窗

            LET g_glax_d[l_ac].glax001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glax_d[l_ac].glax001 TO glax001              #顯示到畫面上

            NEXT FIELD glax001                          #返回原欄位
            #161111-00049#4 add e---            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_glax_d[l_ac].* = g_glax_d_t.*
               CLOSE aglt400_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_glax_d[l_ac].glaxseq 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_glax_d[l_ac].* = g_glax_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_glax2_d[l_ac].glaxmodid = g_user 
LET g_glax2_d[l_ac].glaxmodid_desc = cl_get_username(g_glax2_d[l_ac].glaxmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
                                             IF cl_null(g_glax_d[l_ac].glax003) THEN LET g_glax_d[l_ac].glax003 = 0  END IF 
               IF cl_null(g_glax_d[l_ac].glax008) THEN LET g_glax_d[l_ac].glax008 = 0  END IF 
               IF cl_null(g_glax_d[l_ac].glax009) THEN LET g_glax_d[l_ac].glax009 = 0  END IF 
               IF cl_null(g_glax_d[l_ac].glax010) THEN LET g_glax_d[l_ac].glax010 = 0  END IF 
               #end add-point
         
               #將遮罩欄位還原
               CALL aglt400_glax_t_mask_restore('restore_mask_o')
         
               UPDATE glax_t SET (glaxld,glaxdocno,glaxseq,glax002,glax005,glax006,glax007,glax008,glax009, 
                   glax010,glax003,glax051,glax052,glax055,glax056,glax048,glax001,glaxmodid,glaxownid, 
                   glaxowndp,glaxcrtid,glaxcrtdp,glaxcrtdt,glaxcnfid,glaxcnfdt) = (g_glax_m.glaxld,g_glax_m.glaxdocno, 
                   g_glax_d[l_ac].glaxseq,g_glax_d[l_ac].glax002,g_glax_d[l_ac].glax005,g_glax_d[l_ac].glax006, 
                   g_glax_d[l_ac].glax007,g_glax_d[l_ac].glax008,g_glax_d[l_ac].glax009,g_glax_d[l_ac].glax010, 
                   g_glax_d[l_ac].glax003,g_glax_d[l_ac].glax051,g_glax_d[l_ac].glax052,g_glax_d[l_ac].glax055, 
                   g_glax_d[l_ac].glax056,g_glax_d[l_ac].glax048,g_glax_d[l_ac].glax001,g_glax2_d[l_ac].glaxmodid, 
                   g_glax2_d[l_ac].glaxownid,g_glax2_d[l_ac].glaxowndp,g_glax2_d[l_ac].glaxcrtid,g_glax2_d[l_ac].glaxcrtdp, 
                   g_glax2_d[l_ac].glaxcrtdt,g_glax2_d[l_ac].glaxcnfid,g_glax2_d[l_ac].glaxcnfdt)
                WHERE glaxent = g_enterprise AND glaxld = g_glax_m.glaxld 
                 AND glaxdocno = g_glax_m.glaxdocno 
 
                 AND glaxseq = g_glax_d_t.glaxseq #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
                              
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glax_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "glax_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glax_m.glaxld
               LET gs_keys_bak[1] = g_glaxld_t
               LET gs_keys[2] = g_glax_m.glaxdocno
               LET gs_keys_bak[2] = g_glaxdocno_t
               LET gs_keys[3] = g_glax_d[g_detail_idx].glaxseq
               LET gs_keys_bak[3] = g_glax_d_t.glaxseq
               CALL aglt400_update_b('glax_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_glax_m),util.JSON.stringify(g_glax_d_t)
                     LET g_log2 = util.JSON.stringify(g_glax_m),util.JSON.stringify(g_glax_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aglt400_glax_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_glax_m.glaxld
               LET ls_keys[ls_keys.getLength()+1] = g_glax_m.glaxdocno
 
               LET ls_keys[ls_keys.getLength()+1] = g_glax_d_t.glaxseq
 
               CALL aglt400_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               #更新業務諮詢，固定覈算項資料
               CALL aglt400_update_frozen() RETURNING l_success
               IF l_success = FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "glax_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
               END IF   
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE aglt400_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_glax_d[l_ac].* = g_glax_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE aglt400_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_glax_d.getLength() = 0 THEN
               NEXT FIELD glaxseq
            END IF
            #add-point:input段after input  name="input.body.after_input"
                        
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_glax_d[li_reproduce_target].* = g_glax_d[li_reproduce].*
               LET g_glax2_d[li_reproduce_target].* = g_glax2_d[li_reproduce].*
 
               LET g_glax_d[li_reproduce_target].glaxseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_glax_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glax_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_glax2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL aglt400_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL aglt400_idx_chk()
            CALL aglt400_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為 name="input.body2.action"
                  
         #end add-point
         
      END DISPLAY
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
            
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
                            IF p_cmd = 'a' THEN
            NEXT FIELD glaxdocno
         END IF
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD glaxld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD glaxseq
               WHEN "s_detail2"
                  NEXT FIELD glaxseq_2
 
            END CASE
         END IF
   
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
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
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
   
   #將畫面指標同步到當下指定的位置上
   CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
 
   
   #add-point:input段after_input name="input.after_input"
      
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aglt400_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   #不為開立狀態的資料不可異動  
   IF g_glax_m.glaxstus <>'N' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)    
   END IF 
   #依據不同狀態加載狀態頁簽圖片
   CASE g_glax_m.glaxstus
        WHEN "N"
           CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
        WHEN "Y"
           CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
        WHEN "X"
           CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
   END CASE
   CALL aglt400_glaxld_desc(g_glax_m.glaxld)         #帐别说明
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL aglt400_b_fill(g_wc2) #第一階單身填充
      CALL aglt400_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aglt400_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_glax_m.glaxld,g_glax_m.glaxld_desc,g_glax_m.glaxcomp,g_glax_m.glaxcomp_desc,g_glax_m.glaa001, 
       g_glax_m.glaa016,g_glax_m.glaa020,g_glax_m.glaxdocno,g_glax_m.glaxdocdt,g_glax_m.glax049,g_glax_m.glax050, 
       g_glax_m.glaxstus,g_glax_m.glax027_desc,g_glax_m.glax028_desc,g_glax_m.conf,g_glax_m.crt
 
   CALL aglt400_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
      
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION aglt400_ref_show()
   #add-point:ref_show段define name="ref_show.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ref_show.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="ref_show.pre_function"
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference name="ref_show.head.reference"
         
  #依据对应的主账套编码，抓取币别
   SELECT glaa001 INTO g_glax_m.glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_glax_m.glaxld

   CALL aglt400_b_detail()
#   #营运据点
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_glax.glax017
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_glax.glax017_desc =  g_rtn_fields[1] 
#   DISPLAY BY NAME g_glax.glax017_desc
#   #部门
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_glax.glax018
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_glax.glax018_desc =  g_rtn_fields[1]
#   DISPLAY BY NAME g_glax.glax018_desc
#   #成本利润中心
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_glax.glax019
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_glax.glax019_desc =  g_rtn_fields[1]
#   DISPLAY BY NAME g_glax.glax019_desc
#   #区域 
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = '287'
#   LET g_ref_fields[2] = g_glax.glax020
#   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_glax.glax020_desc =  g_rtn_fields[1]
#   DISPLAY BY NAME g_glax.glax020_desc 
#
#   #交易客商
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_glax.glax021
#   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_glax.glax021_desc = g_rtn_fields[1]
#   DISPLAY BY NAME g_glax.glax021_desc
#   #帐款客商
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_glax.glax022
#   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_glax.glax022_desc = g_rtn_fields[1]
#   DISPLAY BY NAME g_glax.glax022_desc
#   #客群
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = '281'
#   LET g_ref_fields[2] = g_glax.glax023
#   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_glax.glax023_desc =  g_rtn_fields[1]
#   DISPLAY BY NAME g_glax.glax023_desc 
#   
#   #产品分类
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_glax.glax024
#   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_glax.glax024_desc = g_rtn_fields[1]
#   DISPLAY BY NAME g_glax.glax024_desc
#   
#   #人员
#   LET g_glax.glax025_desc = ''
#   CALL aglt400_glax013_desc(g_glax.glax025) RETURNING g_glax.glax025_desc
#   DISPLAY BY NAME g_glax.glax025_desc
#   
#   #预算编号
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_glax.glax026
#   CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent='"||g_enterprise||"' AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_glax.glax026_desc = g_rtn_fields[1]
#   DISPLAY BY NAME g_glax.glax026_desc      
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_glax_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
            
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_glax2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
               
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="aglt400.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aglt400_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE glax_t.glaxld 
   DEFINE l_oldno     LIKE glax_t.glaxld 
   DEFINE l_newno02     LIKE glax_t.glaxdocno 
   DEFINE l_oldno02     LIKE glax_t.glaxdocno 
 
   DEFINE l_master    RECORD LIKE glax_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE glax_t.* #此變數樣板目前無使用
 
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
 
   IF g_glax_m.glaxld IS NULL
      OR g_glax_m.glaxdocno IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_glaxld_t = g_glax_m.glaxld
   LET g_glaxdocno_t = g_glax_m.glaxdocno
 
   
   LET g_glax_m.glaxld = ""
   LET g_glax_m.glaxdocno = ""
 
   LET g_master_insert = FALSE
   CALL aglt400_set_entry('a')
   CALL aglt400_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_glax_m.glaxld = g_glaald   
   #end add-point
   
   #清空key欄位的desc
      LET g_glax_m.glaxld_desc = ''
   DISPLAY BY NAME g_glax_m.glaxld_desc
 
   
   CALL aglt400_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_glax_m.* TO NULL
      INITIALIZE g_glax_d TO NULL
      INITIALIZE g_glax2_d TO NULL
 
      CALL aglt400_show()
      LET INT_FLAG = 0
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN 
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aglt400_set_act_visible()
   CALL aglt400_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_glaxld_t = g_glax_m.glaxld
   LET g_glaxdocno_t = g_glax_m.glaxdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " glaxent = " ||g_enterprise|| " AND",
                      " glaxld = '", g_glax_m.glaxld, "' "
                      ," AND glaxdocno = '", g_glax_m.glaxdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aglt400_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL aglt400_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
      
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL aglt400_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aglt400_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE glax_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
      
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aglt400_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
      
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM glax_t
    WHERE glaxent = g_enterprise AND glaxld = g_glaxld_t
    AND glaxdocno = g_glaxdocno_t
 
       INTO TEMP aglt400_detail
   
   #將key修正為調整後   
   UPDATE aglt400_detail 
      #更新key欄位
      SET glaxld = g_glax_m.glaxld
          , glaxdocno = g_glax_m.glaxdocno
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , glaxownid = g_user 
       , glaxowndp = g_dept
       , glaxcrtid = g_user
       , glaxcrtdp = g_dept 
       , glaxcrtdt = ld_date
       , glaxmodid = g_user
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO glax_t SELECT * FROM aglt400_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   UPDATE glax_t SET glaxstus='N',glaxcnfid="",glaxcnfdt="",
                     glax041=0,glax042=0,glax043=0,glax044=0,glax045=0,glax046=0,
                     glax053=0,glax054=0,glax057=0,glax058=0
    WHERE glaxent=g_enterprise 
      AND glaxld = g_glax_m.glaxld 
      AND glaxdocno = g_glax_m.glaxdocno   
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aglt400_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
      
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_glaxld_t = g_glax_m.glaxld
   LET g_glaxdocno_t = g_glax_m.glaxdocno
 
   
   DROP TABLE aglt400_detail
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aglt400_delete()
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
         DEFINE l_success        LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_glax_m.glaxld IS NULL
   OR g_glax_m.glaxdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN aglt400_cl USING g_enterprise,g_glax_m.glaxld,g_glax_m.glaxdocno
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglt400_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aglt400_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglt400_master_referesh USING g_glax_m.glaxld,g_glax_m.glaxdocno INTO g_glax_m.glaxld,g_glax_m.glaxcomp, 
       g_glax_m.glaxdocno,g_glax_m.glaxdocdt,g_glax_m.glax049,g_glax_m.glax050,g_glax_m.glaxstus,g_glax_m.glaxld_desc, 
       g_glax_m.glaxcomp_desc
   
   #遮罩相關處理
   LET g_glax_m_mask_o.* =  g_glax_m.*
   CALL aglt400_glax_t_mask()
   LET g_glax_m_mask_n.* =  g_glax_m.*
   
   CALL aglt400_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aglt400_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      IF g_glax_m.glaxstus <> 'N' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00313'
         LET g_errparam.extend = g_glax_m.glaxld
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CLOSE aglt400_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #檢查當單據日期小於等於關帳日期時，不可異動單據
      CALL s_fin_date_close_chk(g_glax_m.glaxld,'','AGL',g_glax_m.glaxdocdt) RETURNING l_success
      IF l_success = FALSE THEN
         CLOSE aglt400_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CALL aglt400_chk_glax047() RETURNING l_success
      IF l_success=TRUE THEN
         CLOSE aglt400_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      #end add-point
      
      DELETE FROM glax_t WHERE glaxent = g_enterprise AND glaxld = g_glax_m.glaxld
                                                               AND glaxdocno = g_glax_m.glaxdocno
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
            
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glax_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"
      IF NOT s_aooi200_fin_del_docno(g_glax_m.glaxld,g_glax_m.glaxdocno,g_glax_m.glaxdocdt) THEN
         CALL s_transaction_end('N','0')
         CLOSE aglt400_cl
         RETURN
      END IF
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE aglt400_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_glax_d.clear() 
      CALL g_glax2_d.clear()       
 
     
      CALL aglt400_ui_browser_refresh()  
      #CALL aglt400_ui_headershow()  
      #CALL aglt400_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL aglt400_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL aglt400_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE aglt400_cl
 
   #功能已完成,通報訊息中心
   CALL aglt400_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aglt400.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglt400_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_glax002_desc    STRING
   DEFINE l_str             STRING
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_glax_d.clear()
   CALL g_glax2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
      
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT glaxseq,glax002,glax005,glax006,glax007,glax008,glax009,glax010,glax003, 
       glax051,glax052,glax055,glax056,glax048,glax001,glaxseq,glaxmodid,glaxownid,glaxowndp,glaxcrtid, 
       glaxcrtdp,glaxcrtdt,glaxcnfid,glaxcnfdt,t1.ooag011 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 , 
       t6.ooag011 FROM glax_t",   
               "",
               
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=glaxmodid  ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=glaxownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=glaxowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=glaxcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=glaxcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=glaxcnfid  ",
 
               " WHERE glaxent= ? AND glaxld=? AND glaxdocno=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("glax_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
      
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF aglt400_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY glax_t.glaxseq"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aglt400_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aglt400_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_glax_m.glaxld,g_glax_m.glaxdocno   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_glax_m.glaxld,g_glax_m.glaxdocno INTO g_glax_d[l_ac].glaxseq, 
          g_glax_d[l_ac].glax002,g_glax_d[l_ac].glax005,g_glax_d[l_ac].glax006,g_glax_d[l_ac].glax007, 
          g_glax_d[l_ac].glax008,g_glax_d[l_ac].glax009,g_glax_d[l_ac].glax010,g_glax_d[l_ac].glax003, 
          g_glax_d[l_ac].glax051,g_glax_d[l_ac].glax052,g_glax_d[l_ac].glax055,g_glax_d[l_ac].glax056, 
          g_glax_d[l_ac].glax048,g_glax_d[l_ac].glax001,g_glax2_d[l_ac].glaxseq,g_glax2_d[l_ac].glaxmodid, 
          g_glax2_d[l_ac].glaxownid,g_glax2_d[l_ac].glaxowndp,g_glax2_d[l_ac].glaxcrtid,g_glax2_d[l_ac].glaxcrtdp, 
          g_glax2_d[l_ac].glaxcrtdt,g_glax2_d[l_ac].glaxcnfid,g_glax2_d[l_ac].glaxcnfdt,g_glax2_d[l_ac].glaxmodid_desc, 
          g_glax2_d[l_ac].glaxownid_desc,g_glax2_d[l_ac].glaxowndp_desc,g_glax2_d[l_ac].glaxcrtid_desc, 
          g_glax2_d[l_ac].glaxcrtdp_desc,g_glax2_d[l_ac].glaxcnfid_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
                           #項次
         LET g_glax2_d[l_ac].glaxseq = g_glax_d[l_ac].glaxseq
         #科目+名称+核算项组合
         LET g_glax.glax017=''    LET g_glax.glax018=''   LET g_glax.glax019='' LET g_glax.glax020=''
         LET g_glax.glax021=''    LET g_glax.glax022=''   LET g_glax.glax023='' LET g_glax.glax024=''
         LET g_glax.glax025=''    LET g_glax.glax027=''   LET g_glax.glax028='' LET g_glax.glax061=''
         LET g_glax.glax062=''    LET g_glax.glax063=''
         SELECT glax017,glax018,glax019,glax020,glax021,glax022,
                glax023,glax024,glax025,glax027,glax028,glax061,glax062,glax063
           INTO g_glax.glax017,g_glax.glax018,g_glax.glax019,g_glax.glax020,g_glax.glax021,g_glax.glax022,
                g_glax.glax023,g_glax.glax024,g_glax.glax025,g_glax.glax027,g_glax.glax028,
                g_glax.glax061,g_glax.glax062,g_glax.glax063                
           FROM glax_t
          WHERE glaxent = g_enterprise
            AND glaxld = g_glax_m.glaxld
            AND glaxdocno = g_glax_m.glaxdocno
            AND glaxseq = g_glax_d[l_ac].glaxseq 
            
         CALL aglt400_glax002() RETURNING l_glax002_desc,l_str
         LET g_glax_d[l_ac].lc_subject = g_glax_d[l_ac].glax002,l_str,'\n',l_glax002_desc
         CALL aglt400_frozen_clear(0)
         #end add-point
      
         #帶出公用欄位reference值
         
         
         #應用 a12 樣板自動產生(Version:4)
 
 
 
 
        
         #add-point:單身資料抓取 name="bfill.foreach"
                  
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code   = 9035 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF 
            EXIT FOREACH
         END IF
      
         LET l_ac = l_ac + 1
         
      END FOREACH
 
            CALL g_glax_d.deleteElement(g_glax_d.getLength())
      CALL g_glax2_d.deleteElement(g_glax2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
      
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_glax_d.getLength()
      LET g_glax_d_mask_o[l_ac].* =  g_glax_d[l_ac].*
      CALL aglt400_glax_t_mask()
      LET g_glax_d_mask_n[l_ac].* =  g_glax_d[l_ac].*
   END FOR
   
   LET g_glax2_d_mask_o.* =  g_glax2_d.*
   FOR l_ac = 1 TO g_glax2_d.getLength()
      LET g_glax2_d_mask_o[l_ac].* =  g_glax2_d[l_ac].*
      CALL aglt400_glax_t_mask()
      LET g_glax2_d_mask_n[l_ac].* =  g_glax2_d[l_ac].*
   END FOR
 
 
   FREE aglt400_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aglt400_idx_chk()
   #add-point:idx_chk段define name="idx_chk.define_customerization"
   
   #end add-point
   #add-point:idx_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   #判定目前選擇的頁面
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      #確保當下指標的位置未超過上限
      IF g_detail_idx > g_glax_d.getLength() THEN
         LET g_detail_idx = g_glax_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_glax_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glax_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_glax2_d.getLength() THEN
         LET g_detail_idx = g_glax2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_glax2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glax2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglt400_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_glax_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
      
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION aglt400_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
      
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
      
   #end add-point
   
   DELETE FROM glax_t
    WHERE glaxent = g_enterprise AND glaxld = g_glax_m.glaxld AND
                              glaxdocno = g_glax_m.glaxdocno AND
 
          glaxseq = g_glax_d_t.glaxseq
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
      
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "glax_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後 name="delete.body.a_single_delete"
      
   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
 
{</section>}
 
{<section id="aglt400.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aglt400_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define name="delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
      
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aglt400_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
      
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aglt400_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define name="update_b.define_customerization"
   
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
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
      
   #end add-point     
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
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
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION aglt400_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_glax_d[l_ac].glaxseq = g_glax_d_t.glaxseq 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aglt400_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table    STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aglt400_lock_b(ps_table,ps_page)
   #add-point:lock_b段define name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
      
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aglt400_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aglt400.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aglt400_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define name="unlock_b.define_customerization"
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
      
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="aglt400.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aglt400_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
      
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("glaxld,glaxdocno",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("glaxdocdt",TRUE)
      CALL cl_set_comp_entry("glaxld",FALSE)    #160518-00075#27 add lujh
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
      
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aglt400.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aglt400_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_dfin0033  LIKE type_t.chr1  #151130-00015#2
   DEFINE l_success   LIKE type_t.chr1  #151130-00015#2
   DEFINE l_slip      LIKE type_t.chr80  #151130-00015#2       
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("glaxld,glaxdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
            
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("glaxdocdt",FALSE)
   END IF   
   #151130-00015#2  -add -str
   IF NOT cl_null(g_glax_m.glaxdocno) THEN  
      #获取单别
      CALL s_aooi200_fin_get_slip(g_glax_m.glaxdocno) RETURNING l_success,l_slip
      #取得單別設置的"是否直接審核"參數
      CALL s_fin_get_doc_para(g_glax_m.glaxld,g_glax_m.glaxcomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      IF l_dfin0033 = "Y"  THEN 
         CALL cl_set_comp_entry("glaxdocdt",TRUE)
    
      END IF          
   END IF 
   #151130-00015#2  -end -str

   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aglt400.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aglt400_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
      
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
      
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aglt400_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
      
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
      
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aglt400_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglt400.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aglt400_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_glax_m.glaxstus <>'N' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglt400.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aglt400_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglt400.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aglt400_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglt400.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aglt400_default_search()
   #add-point:default_search段define name="default_search.define_customerization"
   
   #end add-point    
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
      
   #end add-point 
   
   #add-point:Function前置處理  name="default_search.pre_function"
   
   #end add-point
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前 name="default_search.before"
      
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " glaxld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " glaxdocno = '", g_argv[02], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   LET g_wc1=g_wc  
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aglt400.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aglt400_fill_chk(ps_idx)
   #add-point:fill_chk段define name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   #add-point:fill_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="fill_chk.pre_function"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
   
   #add-point:fill_chk段other name="fill_chk.other"
      
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aglt400.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION aglt400_modify_detail_chk(ps_record)
   #add-point:modify_detail_chk段define name="modify_detail_chk.define_customerization"
   
   #end add-point
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify_detail_chk.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="modify_detail_chk.before"
      
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "glaxseq"
      WHEN "s_detail2"
         LET ls_return = "glaxseq_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
            
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
      
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aglt400.mask_functions" >}
&include "erp/agl/aglt400_mask.4gl"
 
{</section>}
 
{<section id="aglt400.state_change" >}
    
 
{</section>}
 
{<section id="aglt400.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aglt400_set_pk_array()
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
   LET g_pk_array[1].values = g_glax_m.glaxld
   LET g_pk_array[1].column = 'glaxld'
   LET g_pk_array[2].values = g_glax_m.glaxdocno
   LET g_pk_array[2].column = 'glaxdocno'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglt400.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aglt400_msgcentre_notify(lc_state)
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
   CALL aglt400_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_glax_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglt400.other_function" readonly="Y" >}
#帳別說明
PRIVATE FUNCTION aglt400_glaxld_desc(p_glaxld)
   DEFINE p_glaxld    LIKE glax_t.glaxld
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaxld 
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glax_m.glaxld_desc=g_rtn_fields[1]
   
   #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
   SELECT glaacomp,glaa001,glaa002,glaa003,glaa004,glaa013,
          glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
          glaa021,glaa022,glaa024,glaa025,glaa028  #160918-00006#3 add glaa028
     INTO g_glaacomp,g_glaa001,g_glaa002,g_glaa003,g_glaa004,g_glaa013,
          g_glaa015,g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,
          g_glaa021,g_glaa022,g_glaa024,g_glaa025,g_glaa028 #160918-00006#3 add g_glaa028
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glaxld 
   LET g_glax_m.glaxcomp = g_glaacomp
   LET g_glax_m.glaa001 = g_glaa001
   LET g_glax_m.glaa016 = g_glaa016
   LET g_glax_m.glaa020 = g_glaa020
   
   IF g_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible("glaa016,glax051,glax052",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa016,glax051,glax052",FALSE)
   END IF 
    
   IF g_glaa019 = 'Y' THEN
      CALL cl_set_comp_visible("glaa020,glax055,glax056",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa020,glax055,glax056",FALSE)
   END IF  
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glax_m.glaxcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glax_m.glaxcomp_desc= g_rtn_fields[1]   
END FUNCTION
#法人說明
PRIVATE FUNCTION aglt400_glaxcomp_desc(p_glaxcomp)
   DEFINE p_glaxcomp    LIKE glax_t.glaxcomp
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaxcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]
END FUNCTION
#單別檢查
PRIVATE FUNCTION aglt400_glaxdocno_chk(p_glaxdocno)
   DEFINE p_glaxdocno      LIKE glax_t.glaxdocno
   DEFINE l_oobastus       LIKE ooba_t.oobastus
   
   LET g_errno = '' 
   SELECT oobastus INTO l_oobastus 
     FROM ooba_t LEFT OUTER JOIN oobx_t ON (oobaent=oobxent AND ooba002=oobx001)
    WHERE oobaent = g_enterprise
      AND ooba001 = g_glaa024      #单据别参照表号
      AND ooba002 = p_glaxdocno    #单据别
      AND oobx002 = 'AGL'          #模组 
      AND oobx003 = 'aglt400'      #单据性质
   CASE
      WHEN SQLCA.SQLCODE =100  LET g_errno = 'aim-00056'
      WHEN l_oobastus = 'N'    LET g_errno = 'sub-01302'  #160318-00005#18 mod#'aim-00057'
   END CASE
END FUNCTION
#組合科目，名稱，覈算項
PRIVATE FUNCTION aglt400_glax002()
   DEFINE l_glax002_desc      LIKE glacl_t.glacl004
   DEFINE r_glax002           STRING
   DEFINE r_str               STRING
   DEFINE l_desc              STRING
   
   #抓取科目名称
   LET l_glax002_desc = ''
   SELECT glacl004 INTO l_glax002_desc FROM glacl_t
    WHERE glaclent = g_enterprise
      AND glacl001 = g_glaa004
      AND glacl002 = g_glax_d[l_ac].glax002
      AND glacl003 = g_dlang   
   
   #组合名称以及核算项
   LET r_glax002 = ''
   LET r_str = ''
   #營運據點
   IF NOT cl_null(g_glax.glax017) THEN
      CALL aglt400_ooef001_desc(g_glax.glax017) RETURNING g_glax.glax017_desc
      LET r_glax002 = g_glax.glax017_desc
      LET r_str= g_glax.glax017    
   END IF
   #部门
   IF NOT cl_null(g_glax.glax018) THEN
      CALL aglt400_ooef001_desc(g_glax.glax018) RETURNING g_glax.glax018_desc
      IF NOT cl_null(r_glax002) THEN
         LET r_glax002 = r_glax002 ,'-',g_glax.glax018_desc
      ELSE
         LET r_glax002 = g_glax.glax018_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glax.glax018
      ELSE
         LET r_str=g_glax.glax018
      END IF 
   END IF 
   #成本利润中心
   IF NOT cl_null(g_glax.glax019) THEN
      CALL aglt400_ooef001_desc(g_glax.glax019) RETURNING g_glax.glax019_desc
      IF NOT cl_null(r_glax002) THEN
         LET r_glax002 = r_glax002 ,'-',g_glax.glax019_desc
      ELSE
         LET r_glax002 = g_glax.glax019_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glax.glax019
      ELSE
         LET r_str=g_glax.glax019
      END IF      
   END IF 
   
   #区域
   IF NOT cl_null(g_glax.glax020) THEN 
      CALL aglt400_glax020_desc('287',g_glax.glax020) RETURNING g_glax.glax020_desc   
      IF NOT cl_null(r_glax002) THEN
         LET r_glax002 = r_glax002 ,'-',g_glax.glax020_desc
      ELSE
         LET r_glax002 = g_glax.glax020_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glax.glax020
      ELSE
         LET r_str=g_glax.glax020
      END IF      
   END IF 
   #交易客商
   IF NOT cl_null(g_glax.glax021) THEN
      CALL aglt400_glax021_desc(g_glax.glax021) RETURNING g_glax.glax021_desc
      IF NOT cl_null(r_glax002) THEN
         LET r_glax002 = r_glax002 ,'-',g_glax.glax021_desc
      ELSE
         LET r_glax002 = g_glax.glax021_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glax.glax021
      ELSE
         LET r_str=g_glax.glax021
      END IF      
   END IF 
   #帐款客商
   IF NOT cl_null(g_glax.glax022) THEN
      CALL aglt400_glax021_desc(g_glax.glax022) RETURNING g_glax.glax022_desc
      IF NOT cl_null(r_glax002) THEN
         LET r_glax002 = r_glax002 ,'-',g_glax.glax022_desc
      ELSE
         LET r_glax002 = g_glax.glax022_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glax.glax022
      ELSE
         LET r_str=g_glax.glax022
      END IF      
   END IF 
   #客群
   IF NOT cl_null(g_glax.glax023) THEN
      CALL aglt400_glax020_desc('281',g_glax.glax023) RETURNING g_glax.glax023_desc
      IF NOT cl_null(r_glax002) THEN
         LET r_glax002 = r_glax002 ,'-',g_glax.glax023_desc
      ELSE
         LET r_glax002 = g_glax.glax023_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glax.glax023
      ELSE
         LET r_str=g_glax.glax023
      END IF      
   END IF 
   
   #产品分类
   IF NOT cl_null(g_glax.glax024) THEN
      CALL aglt400_glax024_desc(g_glax.glax024) RETURNING g_glax.glax024_desc
      IF NOT cl_null(r_glax002) THEN
         LET r_glax002 = r_glax002 ,'-',g_glax.glax024_desc
      ELSE
         LET r_glax002 = g_glax.glax024_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glax.glax024
      ELSE
         LET r_str=g_glax.glax024
      END IF      
   END IF 
   
   #經營方式
   IF NOT cl_null(g_glax.glax061) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '6013'
      LET g_ref_fields[2] = g_glax.glax061
      CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001=? AND gzcbl002=? AND gzcbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET l_desc = g_rtn_fields[1]
      
      IF NOT cl_null(r_glax002) THEN
         LET r_glax002 = r_glax002 ,'-',l_desc
      ELSE
         LET r_glax002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glax.glax061
      ELSE
         LET r_str=g_glax.glax061
      END IF      
   END IF 
   
   #渠道
   IF NOT cl_null(g_glax.glax062) THEN
       CALL aglt400_glax062_desc(g_glax.glax062) RETURNING g_glax.glax062_desc
      IF NOT cl_null(r_glax002) THEN
         LET r_glax002 = r_glax002 ,'-',g_glax.glax062_desc
      ELSE
         LET r_glax002 = g_glax.glax062_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glax.glax062
      ELSE
         LET r_str=g_glax.glax062
      END IF      
   END IF 
   
   #品牌
   IF NOT cl_null(g_glax.glax063) THEN
      CALL aglt400_glax020_desc('2002',g_glax.glax063) RETURNING g_glax.glax063_desc
      IF NOT cl_null(r_glax002) THEN
         LET r_glax002 = r_glax002 ,'-',g_glax.glax063_desc
      ELSE
         LET r_glax002 = g_glax.glax063_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glax.glax063
      ELSE
         LET r_str=g_glax.glax063
      END IF      
   END IF
   
   #人员
   IF NOT cl_null(g_glax.glax025) THEN
       CALL aglt400_glax013_desc(g_glax.glax025) RETURNING g_glax.glax025_desc
      IF NOT cl_null(r_glax002) THEN
         LET r_glax002 = r_glax002 ,'-',g_glax.glax025_desc
      ELSE
         LET r_glax002 = g_glax.glax025_desc
      END IF 
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glax.glax025
      ELSE
         LET r_str=g_glax.glax025
      END IF       
   END IF 
#   #预算编号
#   IF NOT cl_null(g_glax.glax026) THEN
#       CALL aglt400_glax026_desc(g_glax.glax026) RETURNING g_glax.glax026_desc
#      IF NOT cl_null(r_glax002) THEN
#         LET r_glax002 = r_glax002 ,'-',g_glax.glax026_desc
#      ELSE
#         LET r_glax002 = g_glax.glax026_desc
#      END IF
#      IF NOT cl_null(r_str) THEN
#         LET r_str=r_str,'-',g_glax.glax026
#      ELSE
#         LET r_str=g_glax.glax026
#      END IF      
#   END IF 
   #专案编号
   IF NOT cl_null(g_glax.glax027) THEN
      CALL s_desc_get_project_desc(g_glax.glax027) RETURNING g_glax.glax027_desc
      IF NOT cl_null(r_glax002) THEN
         LET r_glax002 = r_glax002 ,'-',g_glax.glax027_desc
      ELSE
         LET r_glax002 = g_glax.glax027_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glax.glax027
      ELSE
         LET r_str=g_glax.glax027
      END IF      
   END IF 
   #WBS
   IF NOT cl_null(g_glax.glax028) THEN
      CALL s_desc_get_wbs_desc(g_glax.glax027,g_glax.glax028) RETURNING g_glax.glax028_desc
      IF NOT cl_null(r_glax002) THEN
         LET r_glax002 = r_glax002 ,'-',g_glax.glax028_desc
      ELSE
         LET r_glax002 = g_glax.glax028_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glax.glax028
      ELSE
         LET r_str=g_glax.glax028
      END IF      
   END IF 
   #组合科目名称以及核算项
   LET r_glax002 = l_glax002_desc,'\n',
                   r_glax002
   IF NOT cl_null(r_str) THEN
      LET r_str="(",r_str,")"
   END IF   
   RETURN r_glax002,r_str
END FUNCTION
#凍結顯示
PRIVATE FUNCTION aglt400_b_detail()
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   SELECT   glax011,glax012,glax013,glax014,glax015,glax016,
            glax017,glax018,glax019,glax020,glax021,glax022,
            glax023,glax024,glax025,glax027,glax028,glax061,glax062,glax063
       INTO g_glax.glax011,g_glax.glax012,g_glax.glax013,g_glax.glax014,g_glax.glax015,g_glax.glax016,
            g_glax.glax017,g_glax.glax018,g_glax.glax019,g_glax.glax020,g_glax.glax021,g_glax.glax022,
            g_glax.glax023,g_glax.glax024,g_glax.glax025,g_glax.glax027,g_glax.glax028,
            g_glax.glax061,g_glax.glax062,g_glax.glax063
       FROM glax_t
      WHERE glaxent = g_enterprise
        AND glaxld = g_glax_m.glaxld
        AND glaxdocno = g_glax_m.glaxdocno
        AND glaxseq = g_glax_d[g_detail_idx].glaxseq

     #抓取說明
     CALL aglt400_glax013_desc(g_glax.glax013) RETURNING g_glax.glax013_desc
     DISPLAY BY NAME g_glax.glax013_desc     
     CALL aglt400_ooef001_desc(g_glax.glax017) RETURNING g_glax.glax017_desc
     DISPLAY BY NAME g_glax.glax017_desc
     CALL aglt400_ooef001_desc(g_glax.glax018) RETURNING g_glax.glax018_desc
     DISPLAY BY NAME g_glax.glax018_desc
     CALL aglt400_ooef001_desc(g_glax.glax019) RETURNING g_glax.glax019_desc
     DISPLAY BY NAME g_glax.glax019_desc 
      CALL aglt400_glax020_desc('287',g_glax.glax020) RETURNING g_glax.glax020_desc
     DISPLAY BY NAME g_glax.glax020_desc     
     CALL aglt400_glax021_desc(g_glax.glax021) RETURNING g_glax.glax021_desc
     DISPLAY BY NAME g_glax.glax021_desc     
     CALL aglt400_glax021_desc(g_glax.glax022) RETURNING g_glax.glax022_desc
     DISPLAY BY NAME g_glax.glax022_desc
     CALL aglt400_glax020_desc('281',g_glax.glax023) RETURNING g_glax.glax023_desc
     DISPLAY BY NAME g_glax.glax023_desc          
     CALL aglt400_glax024_desc(g_glax.glax024) RETURNING g_glax.glax024_desc
     DISPLAY BY NAME g_glax.glax024_desc       
     CALL aglt400_glax013_desc(g_glax.glax025) RETURNING g_glax.glax025_desc
     DISPLAY BY NAME g_glax.glax025_desc 
#     CALL aglt400_glax026_desc(g_glax.glax026) RETURNING g_glax.glax026_desc
#     DISPLAY BY NAME g_glax.glax026_desc       
     CALL aglt400_glax062_desc(g_glax.glax062) RETURNING g_glax.glax062_desc
     DISPLAY BY NAME g_glax.glax062_desc   
     CALL aglt400_glax020_desc('2002',g_glax.glax063) RETURNING g_glax.glax063_desc
     DISPLAY BY NAME g_glax.glax063_desc
     CALL s_desc_get_project_desc(g_glax.glax027) RETURNING g_glax.glax027_desc
     DISPLAY BY NAME g_glax.glax027_desc
     CALL s_desc_get_wbs_desc(g_glax.glax027,g_glax.glax028) RETURNING g_glax.glax028_desc
     DISPLAY BY NAME g_glax.glax028_desc
     
     DISPLAY BY NAME 
            g_glax.glax011,g_glax.glax012,g_glax.glax013,g_glax.glax014,g_glax.glax015,g_glax.glax016,
            g_glax.glax017,g_glax.glax018,g_glax.glax019,g_glax.glax020,g_glax.glax021,g_glax.glax022,
            g_glax.glax023,g_glax.glax024,g_glax.glax025,g_glax.glax027,g_glax.glax028,
            g_glax.glax061,g_glax.glax062,g_glax.glax063
END FUNCTION
#人員姓名
PRIVATE FUNCTION aglt400_glax013_desc(p_glax013)
   DEFINE l_ooag011        LIKE ooag_t.ooag011
   DEFINE p_glax013        LIKE glax_t.glax013

   LET  l_ooag011 = ''
   SELECT ooag011 INTO l_ooag011 FROM ooag_t
    WHERE ooagent = g_enterprise AND ooag001 = p_glax013
   RETURN l_ooag011
END FUNCTION
#客商說明
PRIVATE FUNCTION aglt400_glax021_desc(p_glax021)
   DEFINE p_glax021    LIKE pmaa_t.pmaa001

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glax021
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN  g_rtn_fields[1]
END FUNCTION
#產品分類
PRIVATE FUNCTION aglt400_glax024_desc(p_glax024)
    DEFINE p_glax024   LIKE glax_t.glax024
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glax024
    CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    RETURN g_rtn_fields[1]
END FUNCTION
#預算編號說明
PRIVATE FUNCTION aglt400_glax026_desc(p_glax026)
    DEFINE p_glax026      LIKE glax_t.glax026
   
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glax026
    CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent='"||g_enterprise||"' AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]
END FUNCTION
#營運據點
PRIVATE FUNCTION aglt400_ooef001_desc(p_ooef001)
   DEFINE p_ooef001     LIKE ooef_t.ooef001
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =p_ooef001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]
END FUNCTION
#區域，客商說明
PRIVATE FUNCTION aglt400_glax020_desc(p_oocql001,p_oocql002)
    DEFINE p_oocql001      LIKE oocql_t.oocql001
    DEFINE p_oocql002      LIKE oocql_t.oocql002
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_oocql001
    LET g_ref_fields[2] = p_oocql002
    CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
    RETURN g_rtn_fields[1] 
END FUNCTION
#固定核算项维护
PRIVATE FUNCTION aglt400_fix_acc()
    DEFINE l_glax002  LIKE glax_t.glax002
    DEFINE l_success  LIKE type_t.num5
    DEFINE l_cnt      LIKE type_t.num5
    
    #开立状态资料才可进行此操作
    IF g_glax_m.glaxstus  ='N' THEN
       #单身无资料不需开出画面
       IF g_detail_idx =0 OR cl_null(g_detail_idx) THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = -400
          LET g_errparam.extend = ''
          LET g_errparam.popup = FALSE
          CALL cl_err()

          RETURN
       END IF 
       #檢查當單據日期小於等於關帳日期時，不可異動單據
       CALL s_fin_date_close_chk(g_glax_m.glaxld,'','AGL',g_glax_m.glaxdocdt) RETURNING l_success
       IF l_success = FALSE THEN
          RETURN
       END IF
       #當資料來源glax047=1:傳票輸入產生的不可異動
       CALL aglt400_chk_glax047() RETURNING l_success
       IF l_success=TRUE THEN
          RETURN
       END IF
       
       #抓取科目
       LET l_glax002 = ''
       SELECT glax002 INTO l_glax002 FROM glax_t 
        WHERE glaxent = g_enterprise
          AND glaxld = g_glax_m.glaxld
          AND glaxdocno = g_glax_m.glaxdocno
          AND glaxseq = g_glax_d[g_detail_idx].glaxseq 
       #核算項資料
       INITIALIZE g_glax_r.* TO NULL
       SELECT glax017,glax018,glax019,glax020,glax021,glax022,glax023,
              glax024,glax025,glax027,glax028,glax061,glax062,glax063,
              glax029,glax030,glax031,glax032,glax033,glax034,glax035,
              glax036,glax037,glax038
         INTO g_glax_r.glax017,g_glax_r.glax018,g_glax_r.glax019,g_glax_r.glax020,
              g_glax_r.glax021,g_glax_r.glax022,g_glax_r.glax023,g_glax_r.glax024,
              g_glax_r.glax025,g_glax_r.glax027,g_glax_r.glax028,g_glax_r.glax061,
              g_glax_r.glax062,g_glax_r.glax063,g_glax_r.glax029,g_glax_r.glax030,
              g_glax_r.glax031,g_glax_r.glax032,g_glax_r.glax033,g_glax_r.glax034,
              g_glax_r.glax035,g_glax_r.glax036,g_glax_r.glax037,g_glax_r.glax038
         FROM glax_t
        WHERE glaxent = g_enterprise
          AND glaxld = g_glax_m.glaxld
          AND glaxdocno = g_glax_m.glaxdocno
          AND glaxseq = g_glax_d[g_detail_idx].glaxseq
          
       CALL aglt310_02('',g_glax_m.glaxld,'',g_glax_m.glaxdocdt,l_glax002,'','aglt400',g_glax_r.*) 
       RETURNING g_glax_r.glax017,g_glax_r.glax018,g_glax_r.glax019,g_glax_r.glax020,g_glax_r.glax021,
                 g_glax_r.glax022,g_glax_r.glax023,g_glax_r.glax024,g_glax_r.glax061,g_glax_r.glax062,
                 g_glax_r.glax063,g_glax_r.glax025,g_glax_r.glax027,g_glax_r.glax028,g_glax_r.glax029,
                 g_glax_r.glax030,g_glax_r.glax031,g_glax_r.glax032,g_glax_r.glax033,g_glax_r.glax034,
                 g_glax_r.glax035,g_glax_r.glax036,g_glax_r.glax037,g_glax_r.glax038,g_glax_r.glbc004
       #更新数据库
       CALL s_transaction_begin()
       CALL aglt400_update_frozen()  RETURNING l_success
       IF l_success = TRUE THEN 
          UPDATE glax_t SET glaxmodid = g_user,
                            glaxmoddt = g_today
                      WHERE glaxent = g_enterprise
                        And glaxld = g_glax_m.glaxld
                        AND glaxdocno = g_glax_m.glaxdocno                                
          CALL s_transaction_end('Y','0') 
       ELSE
          CALL s_transaction_end('N','0')   
       END IF          
       #重新抓取单身冻结部分显示               
       CALL aglt400_b_detail()       
    ELSE
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'agl-00052'
       LET g_errparam.extend = 'mod fix_account'
       LET g_errparam.popup = TRUE
       CALL cl_err()

    END IF  
END FUNCTION
#业务咨询维护
PRIVATE FUNCTION aglt400_bus_cons()
     DEFINE l_glax002  LIKE glax_t.glax002
    DEFINE l_success  LIKE type_t.num5
    DEFINE l_cnt      LIKE type_t.num5
    
    #开立状态资料才可进行此操作
    IF g_glax_m.glaxstus  ='N' THEN
       #单身无资料不需开出画面
       IF g_detail_idx =0 OR cl_null(g_detail_idx) THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = -400
          LET g_errparam.extend = ''
          LET g_errparam.popup = FALSE
          CALL cl_err()

          RETURN
       END IF 
       #檢查當單據日期小於等於關帳日期時，不可異動單據
       CALL s_fin_date_close_chk(g_glax_m.glaxld,'','AGL',g_glax_m.glaxdocdt) RETURNING l_success
       IF l_success = FALSE THEN
          RETURN
       END IF
       #當資料來源glax047=1:傳票輸入產生的不可異動
       CALL aglt400_chk_glax047() RETURNING l_success
       IF l_success=TRUE THEN
          RETURN
       END IF
       #清空业务资讯/核算项的值
       CALL aglt400_frozen_clear(2)
       #业务资讯核算项维护
       #抓取科目
       LET l_glax002 = ''
       SELECT glax002 INTO l_glax002 FROM glax_t 
        WHERE glaxent = g_enterprise
          AND glaxld = g_glax_m.glaxld
          AND glaxdocno = g_glax_m.glaxdocno
          AND glaxseq = g_glax_d[g_detail_idx].glaxseq
       CALL aglt400_bus_cons_open_chk(l_glax002) RETURNING l_cnt
       IF l_cnt >0  THEN       
          CALL aglt400_01('u',g_glax_m.glaxld,g_glax_m.glaxdocno,g_glax_m.glaxdocdt,l_glax002,g_glax_d[g_detail_idx].glaxseq) 
          RETURNING g_glax.glax011,g_glax.glax012,g_glax.glax013,g_glax.glax014,g_glax.glax015,g_glax.glax016
          #更新数据库
          CALL s_transaction_begin()
          CALL aglt400_update_frozen()  RETURNING l_success
          IF l_success = TRUE THEN 
             UPDATE glax_t SET glaxmodid = g_user,
                               glaxmoddt = g_today
                         WHERE glaxent = g_enterprise
                           And glaxld = g_glax_m.glaxld
                           AND glaxdocno = g_glax_m.glaxdocno                                
             CALL s_transaction_end('Y','0') 
          ELSE
             CALL s_transaction_end('N','0')   
          END IF          
          #重新抓取单身冻结部分显示               
          CALL aglt400_b_detail() 
       ELSE
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'agl-00109'
          LET g_errparam.extend = l_glax002
          LET g_errparam.popup = TRUE
          CALL cl_err()
       
       END IF    
    ELSE           
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'agl-00052'
       LET g_errparam.extend = 'mod bus_cons'
       LET g_errparam.popup = TRUE
       CALL cl_err()

    END IF  
END FUNCTION
#自由核算项维护
PRIVATE FUNCTION aglt400_main_free_acc()
    DEFINE l_glax002  LIKE glax_t.glax002
    DEFINE l_success  LIKE type_t.num5
    DEFINE l_cnt      LIKE type_t.num5
    #开立状态才可进行进行维护
    IF g_glax_m.glaxstus = 'N' THEN
       #单身无资料不需开出画面
       IF g_detail_idx =0 OR cl_null(g_detail_idx) THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = -400
          LET g_errparam.extend = ''
          LET g_errparam.popup = FALSE
          CALL cl_err()

          RETURN
       END IF 
       #當資料來源glax047=1:傳票輸入產生的不可異動
       CALL aglt400_chk_glax047() RETURNING l_success
       IF l_success=TRUE THEN
          RETURN
       END IF
       #初始化自由核算项
       LET g_glax029 = ''  LET g_glax030 = '' LET g_glax031 = '' LET g_glax032=''  LET g_glax033=''
       LET g_glax034 = ''  LET g_glax035 = '' LET g_glax036 = '' LET g_glax037=''  LET g_glax038=''
       #抓取科目
       LET l_glax002 = ''
       SELECT glax002 INTO l_glax002 FROM glax_t 
        WHERE glaxent = g_enterprise
          AND glaxld = g_glax_m.glaxld
          AND glaxdocno = g_glax_m.glaxdocno
          AND glaxseq = g_glax_d[g_detail_idx].glaxseq  
       #检查该科目是否启用自由核算项，如果未启用则不开启子画面
       CALL aglt400_free_acc_open_chk(l_glax002) RETURNING l_cnt
       IF l_cnt >0  THEN       
          #自由核算项维护   
#          CALL aglt310_03(g_glax_m.glaxld,g_glax_m.glaxdocno,g_glax_d[g_detail_idx].glaxseq,l_glax002,"aglt400",'','','')
#          RETURNING g_glax029,g_glax030,g_glax031,g_glax032,g_glax033,
#                    g_glax034,g_glax035,g_glax036,g_glax037,g_glax038
           #更新数据库
          CALL s_transaction_begin()
          CALL aglt400_free_account()  RETURNING l_success
          IF l_success = TRUE THEN 
             UPDATE glax_t SET glaxmodid = g_user,
                               glaxmoddt = g_today
                         WHERE glaxent = g_enterprise
                           And glaxld = g_glax_m.glaxld
                           AND glaxdocno = g_glax_m.glaxdocno                                
             CALL s_transaction_end('Y','0') 
          ELSE
             CALL s_transaction_end('N','0')   
          END IF
       ELSE
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'agl-00106'
          LET g_errparam.extend = l_glax002
          LET g_errparam.popup = TRUE
          CALL cl_err()
       
       END IF   
    ELSE 
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'agl-00052'
       LET g_errparam.extend = 'free account'
       LET g_errparam.popup = TRUE
       CALL cl_err()

    END IF 
END FUNCTION
#自由覈算項更新
PRIVATE FUNCTION aglt400_free_account()
   DEFINE  l_success   LIKE type_t.num5
   
   LET l_success = TRUE
    
    UPDATE glax_t SET glax029 = g_glax029,
                      glax030 = g_glax030,
                      glax031 = g_glax031,
                      glax032 = g_glax032,
                      glax033 = g_glax033,
                      glax034 = g_glax034,
                      glax035 = g_glax035,
                      glax036 = g_glax036,
                      glax037 = g_glax037,
                      glax038 = g_glax038
           
    WHERE glaxent = g_enterprise
      AND glaxld = g_glax_m.glaxld
      AND glaxdocno = g_glax_m.glaxdocno
      AND glaxseq =   g_glax_d[g_detail_idx].glaxseq

    IF SQLCA.SQLCODE THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = sqlca.sqlcode
       LET g_errparam.extend = 'update_b1'
       LET g_errparam.popup = TRUE
       CALL cl_err()
 
       LET l_success = FALSE
    END IF 
    RETURN l_success     
END FUNCTION
#檢查科目是否啟用了覈算項管理
PRIVATE FUNCTION aglt400_fix_open_chk(p_glax002)
   DEFINE p_glax002     LIKE glax_t.glax002
   DEFINE r_cnt         LIKE type_t.num5
   #科目核算项
   DEFINE l_glad005       LIKE glad_t.glad005
   DEFINE l_glad007       LIKE glad_t.glad007
   DEFINE l_glad008       LIKE glad_t.glad008
   DEFINE l_glad009       LIKE glad_t.glad009
   DEFINE l_glad010       LIKE glad_t.glad010
   DEFINE l_glad027       LIKE glad_t.glad027
   DEFINE l_glad011       LIKE glad_t.glad011
   DEFINE l_glad012       LIKE glad_t.glad012
   DEFINE l_glad013       LIKE glad_t.glad013
   DEFINE l_glad015       LIKE glad_t.glad015
   DEFINE l_glad016       LIKE glad_t.glad016
   DEFINE l_glad031       LIKE glad_t.glad031
   DEFINE l_glad032       LIKE glad_t.glad032
   DEFINE l_glad033       LIKE glad_t.glad033
  
   #记录隐藏栏位标示
   DEFINE l_flag1         LIKE type_t.num5 

   LET l_flag1 = 0
   #依據是否啟用數量金額式,帳別，科目編號，判斷該科目是否做部門管理， 利潤成本中心管理，區域管理，客商管理，客群管理，產品類別，人員，預算，專案，wbs管理
#   SELECT glad007,glad008,glad009,glad010,glad027,glad011,glad012,glad013,glad014,glad015,glad016 
#     INTO l_glad007,l_glad008,l_glad009,l_glad010,l_glad027,l_glad011,l_glad012,l_glad013,l_glad014,l_glad015,l_glad016
#     FROM glad_t
#   WHERE gladent = g_enterprise
#     AND gladld = g_glax_m.glaxld
#     AND glad001 =p_glax002
   CALL s_voucher_fix_acc_open_chk(g_glax_m.glaxld,p_glax002)
   RETURNING l_glad007,l_glad008,l_glad009,l_glad010,l_glad027,
             l_glad011,l_glad012,l_glad013,l_glad015,l_glad016,
             l_glad031,l_glad032,l_glad033
   #該科目做部門管理
   IF l_glad007 = 'Y' THEN
      LET l_flag1 = l_flag1+1      
   END IF 
   #該科目做利潤成本管理時
   IF l_glad008 = 'Y' THEN
      LET l_flag1 = l_flag1+1      
   END IF 
   #該科目做區域管理時
   IF l_glad009 = 'Y' THEN
      LET l_flag1 = l_flag1+1      
   END IF 
   #該科目做客商管理
   IF l_glad010 = 'Y' THEN
       LET l_flag1 = l_flag1+1
   END IF 
   #該科目做账款客商管理時
   IF l_glad027 = 'Y' THEN
       LET l_flag1 = l_flag1+1
   END IF 
   #該科目做客群管理時
   IF l_glad011 = 'Y' THEN
      LET l_flag1 = l_flag1+1      
   END IF 
   #該科目做產品分類管理時，
   IF l_glad012 = 'Y' THEN
      LET l_flag1 = l_flag1+1     
   END IF 
   
   #該科目做經營方式管理時，
   IF l_glad031 = 'Y' THEN
      LET l_flag1 = l_flag1+1     
   END IF 
   #該科目做渠道管理時，
   IF l_glad032 = 'Y' THEN
      LET l_flag1 = l_flag1+1     
   END IF 
   #該科目做品牌管理時，
   IF l_glad033 = 'Y' THEN
      LET l_flag1 = l_flag1+1     
   END IF 
   
   #該科目做人員管理時，
   IF l_glad013 = 'Y' THEN
      LET l_flag1 = l_flag1+1         
   END IF 
#   #該科目做預算管理時，
#   IF l_glad014 = 'Y' THEN
#      LET l_flag1 = l_flag1+1         
#   END IF 
   #該科目做專案管理時，
   IF l_glad015 = 'Y' THEN
      LET l_flag1 = l_flag1+1         
   END IF 
   #該科目做WBS管理時，
   IF l_glad016 = 'Y' THEN
      LET l_flag1 = l_flag1+1    
   END IF    
    
   #如果核算项没有启用，则不需开出子视窗  
   RETURN l_flag1
END FUNCTION
#科目检查
PRIVATE FUNCTION aglt400_glax002_chk(p_glax002)
   DEFINE p_glax002    LIKE glax_t.glax002
   DEFINE l_glacstus   LIKE glac_t.glacstus
   DEFINE l_glac003    LIKE glac_t.glac003
   DEFINE l_glac006    LIKE glac_t.glac006
   DEFINE l_glad003    LIKE glad_t.glad003
   DEFINE l_glad035    LIKE glad_t.glad035    #150827-00036#7 add
   
   LET g_errno = ''
#151117-00009#1--mark--str--
#   SELECT glacstus,glac003,glac006 INTO l_glacstus,l_glac003,l_glac006
#     FROM glac_t
#    WHERE glacent = g_enterprise
#      AND glac001 = g_glaa004       #会计科目参照表号
#      AND glac002 = p_glax002
#151117-00009#1--mark--end    
   LET l_glad003=''   
   SELECT glad003,glad035 INTO l_glad003,l_glad035 FROM glad_t  #150827-00036#7 add glad035 
    WHERE gladent=g_enterprise AND gladld=g_glaald
      AND glad001=p_glax002
#151117-00009#1--mark--str--          
#   CASE
#      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'agl-00011'
#      WHEN l_glacstus = 'N'      LET g_errno = 'sub-01302'  #160318-00005#18 mod'agl-00012'
#      WHEN l_glac003 = '1'       LET g_errno = 'agl-00013'  #必须为非统治类科目
#      WHEN l_glac006 <>'1'       LET g_errno = 'agl-00030'  #须为账户性质 
#   END CASE
#151117-00009#1--mark--end   
   
   IF l_glad003 <> 'Y' THEN
      LET g_errno = 'agl-00187'  #细项立冲 
   END IF 
   #150827-00036#7 add---str 
   IF l_glad035 = 'Y' THEN
      LET g_errno = 'agl-00358'  #必須為非子系統科目    
   END IF
   #150827-00036#7 add---end
END FUNCTION
#自由核算项开窗检查
PRIVATE FUNCTION aglt400_free_acc_open_chk(p_glax002)
   DEFINE p_glax002     LIKE glax_t.glax002
   DEFINE r_flag        LIKE type_t.num5
   #是否做自由科目核算项管理A
   DEFINE l_glad017     LIKE glad_t.glad017
   DEFINE l_glad018     LIKE glad_t.glad018
   DEFINE l_glad019     LIKE glad_t.glad019
   DEFINE l_glad020     LIKE glad_t.glad020
   DEFINE l_glad021     LIKE glad_t.glad021
   DEFINE l_glad022     LIKE glad_t.glad022
   DEFINE l_glad023     LIKE glad_t.glad023
   DEFINE l_glad024     LIKE glad_t.glad024
   DEFINE l_glad025     LIKE glad_t.glad025
   DEFINE l_glad026     LIKE glad_t.glad026
   
   #总体说明：若启用该核算项管理则对应控制方式为2.必须输入不检查，3.必须输入必检查，则栏位不可空白，为1时可以空白，否则栏位不可进去
   SELECT glad017,glad018,glad019,glad020,glad021,glad022,glad023,glad024,
          glad025,glad026
     INTO l_glad017,l_glad018,l_glad019,l_glad020,l_glad021,
          l_glad022,l_glad023,l_glad024,l_glad025,l_glad026
    FROM  glad_t
    WHERE gladent = g_enterprise
      AND gladld =  g_glax_m.glaxld
      AND glad001 = p_glax002

   LET r_flag = 0 
   #啟用自由核算項一
   IF l_glad017 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF

   #啟用自由核算項二
   IF l_glad018 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF

   #啟用自由核算項三
   IF l_glad019 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF

   #啟用自由核算項四
   IF l_glad020 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF

   #啟用自由核算項五
   IF l_glad021 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF
   
   #啟用自由核算項六
   IF l_glad022 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF

   #啟用自由核算項七
   IF l_glad023 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF

   #啟用自由核算項八
   IF l_glad024 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF

   #啟用自由核算項九
   IF l_glad025 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF

   #啟用自由核算項十
   IF l_glad026 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF
   
   RETURN r_flag
END FUNCTION
#业务咨询开窗检查，若启用对应核算项则开窗，否则不开
PRIVATE FUNCTION aglt400_bus_cons_open_chk(p_glax002)
   DEFINE p_glax002    LIKE glax_t.glax002
   DEFINE l_glac016    LIKE glac_t.glac016
   DEFINE l_glad005    LIKE glad_t.glad005
   DEFINE r_flag       LIKE type_t.num5
   
   LET r_flag = 0
   #依據是否啟用數量金額式
   SELECT glad005 INTO l_glad005 FROM glad_t
   WHERE gladent = g_enterprise
     AND gladld = g_glax_m.glaxld
     AND glad001 =p_glax002
   IF l_glad005 = 'Y' THEN
      LET r_flag = r_flag + 1
   END IF 
   #判断是否为现金科目
   SELECT glac016 INTO l_glac016 FROM glac_t
    WHERE glacent = g_enterprise
      AND glac001 = g_glaa004
      AND glac002 =p_glax002 
   IF l_glac016 = 'Y' THEN
      LET r_flag = r_flag + 1 
   END IF 
   
   RETURN r_flag
END FUNCTION
#计价单位/数量/金额是否可录入
PRIVATE FUNCTION aglt400_glad005_chk()
   DEFINE l_glad005   LIKE glad_t.glad005
   
   #科目有設定為數量金額式='Y'時,計價單位/數量/單價才可录入且為必輸不可空白
   SELECT glad005 INTO l_glad005 FROM glad_t
    WHERE gladent = g_enterprise
      AND gladld  = g_glax_m.glaxld
      AND glad001 = g_glax_d[l_ac].glax002
      
   IF l_glad005 = 'Y' THEN
      CALL cl_set_comp_entry("glax007,glax008,glax009",TRUE)
   ELSE
      CALL cl_set_comp_entry("glax007,glax008,glax009",FALSE)
   END IF 
END FUNCTION
#更新業務諮詢，固定覈算項資料
PRIVATE FUNCTION aglt400_update_frozen()
    DEFINE  l_success   LIKE type_t.num5
    
    LET l_success = TRUE
 
    UPDATE glax_t SET glax011 = g_glax.glax011,
                      glax012 = g_glax.glax012,
                      glax013 = g_glax.glax013,
                      glax014 = g_glax.glax014,
                      glax015 = g_glax.glax015,
                      glax016 = g_glax.glax016,
                      glax017 = g_glax_r.glax017,
                      glax018 = g_glax_r.glax018,
                      glax019 = g_glax_r.glax019,
                      glax020 = g_glax_r.glax020,
                      glax021 = g_glax_r.glax021,
                      glax022 = g_glax_r.glax022,
                      glax023 = g_glax_r.glax023,
                      glax024 = g_glax_r.glax024,
                      glax025 = g_glax_r.glax025,
                      glax027 = g_glax_r.glax027,
                      glax028 = g_glax_r.glax028,
                      glax061 = g_glax_r.glax061,
                      glax062 = g_glax_r.glax062,
                      glax063 = g_glax_r.glax063,
                      glax029 = g_glax_r.glax029,
                      glax030 = g_glax_r.glax030,
                      glax031 = g_glax_r.glax031,
                      glax032 = g_glax_r.glax032,
                      glax033 = g_glax_r.glax033,
                      glax034 = g_glax_r.glax034,
                      glax035 = g_glax_r.glax035,
                      glax036 = g_glax_r.glax036,
                      glax037 = g_glax_r.glax037,
                      glax038 = g_glax_r.glax038
    WHERE glaxent = g_enterprise
      AND glaxld = g_glax_m.glaxld
      AND glaxdocno = g_glax_m.glaxdocno
      AND glaxseq =   g_glax_d[g_detail_idx].glaxseq

    IF SQLCA.SQLCODE THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = sqlca.sqlcode
       LET g_errparam.extend = 'update_b1'
       LET g_errparam.popup = TRUE
       CALL cl_err()
 
       LET l_success = FALSE
    END IF 
    RETURN l_success
    
END FUNCTION
#币别检查
PRIVATE FUNCTION aglt400_glax005_chk(p_glax005)
    DEFINE l_ooaistus   LIKE ooai_t.ooaistus
    DEFINE p_glax005    LIKE glax_t.glax005
     
     LET g_errno = ''
     SELECT ooaistus INTO l_ooaistus FROM ooai_t
      WHERE ooaient = g_enterprise
        AND ooai001 = p_glax005
     IF SQLCA.sqlcode = 100 THEN
        LET g_errno = 'aoo-00028'
     END IF 
END FUNCTION
#计价单位检查
PRIVATE FUNCTION aglt400_glax007_chk(p_glax007)
   DEFINE p_glax007     LIKE glax_t.glax007
   DEFINE l_oocastus    LIKE ooca_t.oocastus
   
   LET g_errno = ''
   SELECT oocastus INTO l_oocastus FROM ooca_t
    WHERE oocaent = g_enterprise
      AND ooca001 = p_glax007
    
    CASE  
        WHEN SQLCA.sqlcode = 100   LET g_errno = 'aim-00004'
        WHEN l_oocastus = 'N'      LET g_errno =  'sub-01302'  #160318-00005#18 mod #'aim-00005'
     END CASE
END FUNCTION
#状态码
PRIVATE FUNCTION aglt400_statechange()
   DEFINE lc_state LIKE type_t.chr5
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_cnt        LIKE type_t.num5

   ERROR ""     #清空畫面右下側ERROR區塊

   IF g_glax_m.glaxld IS NULL OR g_glax_m.glaxdocno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   
   CALL s_transaction_begin()
   OPEN aglt400_cl USING g_enterprise,g_glax_m.glaxld,g_glax_m.glaxdocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglt400_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE aglt400_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglt400_master_referesh USING g_glax_m.glaxld,g_glax_m.glaxdocno INTO g_glax_m.glaxld,g_glax_m.glaxcomp, 
       g_glax_m.glaxdocno,g_glax_m.glaxdocdt,g_glax_m.glax049,g_glax_m.glax050,g_glax_m.glaxstus,g_glax_m.glaxld_desc, 
       g_glax_m.glaxcomp_desc
   
   #遮罩相關處理
   LET g_glax_m_mask_o.* =  g_glax_m.*
   CALL aglt400_glax_t_mask()
   LET g_glax_m_mask_n.* =  g_glax_m.*
   
   CALL aglt400_show()
   
   IF g_glax_m.glaxstus = 'X' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00044'
      LET g_errparam.extend = g_glax_m.glaxld
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE aglt400_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #檢查當單據日期小於等於關帳日期時，不可異動單據
   CALL s_fin_date_close_chk(g_glax_m.glaxld,'','AGL',g_glax_m.glaxdocdt) RETURNING l_success
   IF l_success = FALSE THEN
      CLOSE aglt400_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
      
   CALL aglt400_chk_glax047() RETURNING l_success 
   IF l_success=TRUE THEN
      CLOSE aglt400_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
      
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         CASE g_glax_m.glaxstus
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE

      #add-point:menu前
      CALL cl_set_act_visible("confirmed,unconfirmed,invalid",FALSE)
      CASE g_glax_m.glaxstus
         WHEN "N"
            CALL cl_set_act_visible("confirmed,invalid",TRUE)   
         WHEN "Y"
            CALL cl_set_act_visible("unconfirmed",TRUE)
         WHEN "X"
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'anm-00044'
            LET g_errparam.extend = g_glax_m.glaxdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CLOSE aglt400_cl
            CALL s_transaction_end('N','0')
            RETURN
      END CASE
      
      LET l_success=TRUE
      
      #end add-point

      ON ACTION unconfirmed
         #modify--151110-00030#1--By shiun--(S)
         LET g_action_choice = "unconfirmed"
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制
            CALL cl_err_collect_init()
            CALL s_voucher_unconf_chk_glax(g_glax_m.glaxld,g_glax_m.glaxdocno) RETURNING l_success
            IF l_success = TRUE THEN
               CALL s_voucher_unconf_upd_glax(g_glax_m.glaxld,g_glax_m.glaxdocno) RETURNING l_success
            END IF          {#ADP版次:1#}
            #end add-point
         END IF
         #modify--151110-00030#1--By shiun--(E)
         EXIT MENU
      
      ON ACTION confirmed
         LET lc_state = "Y"
         #add-point:action控制
         CALL cl_err_collect_init()
         CALL s_voucher_conf_chk_glax(g_glax_m.glaxld,g_glax_m.glaxdocno) RETURNING l_success
         IF l_success = TRUE THEN
            CALL s_voucher_conf_upd_glax(g_glax_m.glaxld,g_glax_m.glaxdocno) RETURNING l_success
         END IF            {#ADP版次:1#}
         #end add-point
         EXIT MENU

      ON ACTION invalid
         LET lc_state = "X"
         #add-point:action控制
         CALL cl_err_collect_init()
         #151125-00001#2 --- mark start ---
         #CALL s_voucher_void_chk_glax(g_glax_m.glaxld,g_glax_m.glaxdocno) RETURNING l_success
         #IF l_success = TRUE THEN
         #   CALL s_voucher_void_upd_glax(g_glax_m.glaxld,g_glax_m.glaxdocno) RETURNING l_success
         #END IF           {#ADP版次:1#}
         #151125-00001#2 --- mark end   ---
         #end add-point
         EXIT MENU



      #add-point:stus控制
      
      #end add-point

   END MENU

   IF (lc_state <> "N"
      AND lc_state <> "X"

      AND lc_state <> "Y"

      ) OR
      cl_null(lc_state) THEN
      CALL s_transaction_end('N','0')    #160816-00068#6 add
      RETURN
   END IF

   #add-point:stus修改前
   #151125-00001#2 --- add start ---
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0') 
         RETURN
      END IF
      CALL s_voucher_void_chk_glax(g_glax_m.glaxld,g_glax_m.glaxdocno) RETURNING l_success
      IF l_success = TRUE THEN
         CALL s_voucher_void_upd_glax(g_glax_m.glaxld,g_glax_m.glaxdocno) RETURNING l_success
      END IF           {#ADP版次:1#}
   END IF
   #151125-00001#2 --- add end   ---
   CALL cl_err_collect_show()
   IF l_success = FALSE  THEN
      CALL s_transaction_end('N','0')
      CLOSE aglt400_cl
      CALL s_transaction_end('N','0')
      RETURN
   ELSE
      CALL s_transaction_end('Y','0')   
   END IF           {#ADP版次:1#}
   #end add-point

   UPDATE glax_t SET glaxstus = lc_state
    WHERE glaxent = g_enterprise AND glaxld = g_glax_m.glaxld
      AND glaxdocno = g_glax_m.glaxdocno


   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      END CASE
      LET g_glax_m.glaxstus = lc_state
      DISPLAY BY NAME g_glax_m.glaxstus
   END IF

   IF g_glax_m.glaxstus <>'N' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)    
   END IF
                                                                                    
END FUNCTION
################################################################################
# Descriptions...: 判斷該資料是否是傳票輸入時產生
# Memo...........:
# Usage..........: CALL aglt400_chk_glax047()
#                  RETURNING r_success
# Return code....: r_success   判斷結果
# Date & Author..: 14/02/19 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt400_chk_glax047()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   
   LET r_success=FALSE
   SELECT COUNT(*) INTO l_cnt FROM glax_t
      WHERE glaxent=g_enterprise AND glaxld=g_glax_m.glaxld
        AND glaxdocno=g_glax_m.glaxdocno
        AND glax047='1' 
      IF l_cnt>0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00209'
         LET g_errparam.extend = g_glax_m.glaxdocno
         LET g_errparam.popup = FALSE
         CALL cl_err()

         LET r_success=TRUE
      END IF 
      RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 清空固定核算項/業務訊息
# Memo...........:
# Usage..........: CALL aglt400_frozen_clear(p_type)
#                  RETURNING 回传参数
# Input parameter: p_type   要清空那個頁簽
#                : 0：清空固定核算項和業務訊息
#                : 1：清空固定核算項
#                : 2：清空業務訊息
# Date & Author..: 14/02/19 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt400_frozen_clear(p_type)
   DEFINE p_type   LIKE type_t.num5
  
   #清空固定核算項
   IF p_type=0 OR p_type=1 THEN
      LET g_glax.glax017 = ''
      LET g_glax.glax017_desc = ''
      LET g_glax.glax018 = ''
      LET g_glax.glax018_desc = ''
      LET g_glax.glax019 = ''
      LET g_glax.glax019_desc = ''
      LET g_glax.glax020 = ''
      LET g_glax.glax020_desc = ''
      LET g_glax.glax021 = ''
      LET g_glax.glax021_desc = ''
      LET g_glax.glax022 = ''
      LET g_glax.glax022_desc = ''
      LET g_glax.glax023 = ''
      LET g_glax.glax023_desc = ''
      LET g_glax.glax024 = ''
      LET g_glax.glax024_desc = ''
      LET g_glax.glax025 = ''
      LET g_glax.glax025_desc = ''
      LET g_glax.glax027 = ''
      LET g_glax.glax027_desc = ''
      LET g_glax.glax028 = ''
      LET g_glax.glax028_desc = ''
      LET g_glax.glax061 = ''
      LET g_glax.glax062 = ''
      LET g_glax.glax062_desc = ''
      LET g_glax.glax063 = ''
      LET g_glax.glax063_desc = ''
   END IF
   #清空業務訊息
   IF p_type=0 OR p_type=2 THEN
      LET g_glax.glax011 = ''
      LET g_glax.glax012 = ''
      LET g_glax.glax013 = ''
      LET g_glax.glax013_desc = ''
      LET g_glax.glax014 = ''
      LET g_glax.glax015 = ''
      LET g_glax.glax016 = ''
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 渠道说明
# Memo...........:
# Usage..........: CALL aglt400_glax062_desc(p_glax062)
# Date & Author..: 2014/10/14 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt400_glax062_desc(p_glax062)
   DEFINE p_glax062    LIKE glax_t.glax062

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glax062
   CALL ap_ref_array2(g_ref_fields,"SELECT oojdl004 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN  g_rtn_fields[1]
END FUNCTION

 
{</section>}
 
