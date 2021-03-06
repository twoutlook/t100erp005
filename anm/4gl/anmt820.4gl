#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt820.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0020(2016-08-04 14:46:57), PR版次:0020(2017-02-16 10:04:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000119
#+ Filename...: anmt820
#+ Description: 銀行調匯會計帳務作業
#+ Creator....: 01531(2014-08-16 16:27:48)
#+ Modifier...: 02599 -SD/PR- 01531
 
{</section>}
 
{<section id="anmt820.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#150729-00002#1   2015/07/29 By Jessy    anmt* bug修復(簡繁標籤、欄位名稱修正/新增幣別開窗/修正下拉選單數量/ACTION處理不正確修正)
#150707-00001#8   2015/07/31 By apo      整測bug修正
#151001-00006#1   2015/10/08 By yangtt   傳票拋轉後，回寫傳票編號，欄位可以串查傳票資料aglt310
#151013-00016#4   2015/10/19 By yangtt   产生凭证时，凭证单别开窗：按照AP AR作法 拋傳票的時候  如果是 不迴轉（agli171的设置 直接開aglt310的單別 )迴轉的時候 開t350的單別
#150930-00010#2   2015/10/22 By 02599    已抛转产生凭证时，凭证预览采用分录底稿预览方式
#151013-00019#13  2015/12/04 By Reanna   1.修改底稿之後產生的分錄還是原來的2.依照agli170設定迴轉不迴轉走aglt310 or aglt350
#151125-00006#3   2015/12/03 By 07166    新增[編輯完單據後立即拋轉憑證]功能
#150813-00015#20  2016/01/19 By 02599    增加日期控管，日期不可小于等于关账日期
#160318-00025#39  2016/04/22 By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160513-00008#3   2016/05/13 By 02599    修改汇总报错信息，以防无法提示报错
#                                        删除操作时，同步删除nmbc_t资料
#160530-00003#1   2016/05/30 By 02599    影藏本期应提列金额nmde106 nmde116 nmde126栏位，调汇凭证要根据agli171中设置的次月是否回转计算凭证金额，故凭证金额抓取nmde106
#160628-00013#1   2016/06/28 By 01531    凭证日期预设单据日期
#160530-00003#4   2016/07/08 By 02599    增加功能：未启用分录底稿时抓取临时表资料产生凭证
#                                        修正抛转凭证和凭证还原逻辑
#                                        当重评价处理方式为2.次月回转时，抛转凭证系统别为'AC'
#160708-00016#1   2016/08/01 By 02599    显示本期应提列金额nmde106 nmde116 nmde126栏位
#160326-00001#25  2016/08/01 By 02599    1.画面上增加其他信息的页签（核算项）从整单操作按钮拉下来，
#                                        2.判断帐套是否启用本位币二与三，如果不启用，则本位币二与三的页面不显示，
#                                        3.现金变动码已存时，分录里面没有，4.删除时如果存在后期的数据，或是小于关帐日期，或是有凭证号，则不允许删除
#160125-00005#8   2016/08/08 By 02599    查詢時加上帳套人員權限條件過濾
#160727-00019#33  2016/08/15 By 08742    系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 
#                                        Mod   s_anmt820_nm_tmp--> anmt820_tmp01
#                                        Mod   s_anmt820_nm_group--> anmt820_tmp02
#160726-00020#16  2016/08/25 By 08729    複製時清空特定欄位
#160816-00012#3   2016/09/12 By 01531    ANM增加资金中心，帐套，法人三个栏位权限
#160913-00017#6   2016/09/23 By 07900    ANM模组调整交易客商开窗
#161021-00050#10  2016/10/28 By Reanna   账务中心开窗调整为q_ooef001_46 ;
#                                        法人开窗调整为q_ooef001_2,要注意原本where条件中的权限设置要保留；
#                                        开户组织见excel"资金单身来源组织"
#161128-00061#2   2016/11/30 by 02481    标准程式定义采用宣告模式,弃用.*写法
#161212-00032#1   2016/12/12 By 01531    anmt820凭证预览时，现金变动码未显示
#170118-00030#1   2017/01/18 By 01531    anmt820/anmt821/anmt822 產生傳票科目+幣別+摘要+核算項 未匯總
#161221-00054#3   2017/02/10 By 01531    相關單身(會計科目+部門) 及傳票預覽( 會計科目+部門), 要擋<<科目拒絕部門>> 參照agli060擋拒絕部門設定
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
PRIVATE type type_g_nmde_m        RECORD
       nmdesite LIKE nmde_t.nmdesite, 
   nmdesite_desc LIKE type_t.chr80, 
   nmdecomp LIKE nmde_t.nmdecomp, 
   nmdecomp_desc LIKE type_t.chr80, 
   nmde001_i LIKE type_t.chr500, 
   nmde002_i LIKE type_t.chr500, 
   nmdeld LIKE nmde_t.nmdeld, 
   nmdeld_desc LIKE type_t.chr80, 
   nmdedocdt LIKE nmde_t.nmdedocdt, 
   nmde017 LIKE nmde_t.nmde017, 
   nmde001 LIKE nmde_t.nmde001, 
   nmde002 LIKE nmde_t.nmde002, 
   nmdedocno LIKE nmde_t.nmdedocno
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_nmde_d        RECORD
       nmde005 LIKE nmde_t.nmde005, 
   nmde004 LIKE nmde_t.nmde004, 
   nmde100 LIKE nmde_t.nmde100, 
   nmde101 LIKE nmde_t.nmde101, 
   nmde102 LIKE nmde_t.nmde102, 
   nmde103 LIKE nmde_t.nmde103, 
   nmde104 LIKE nmde_t.nmde104, 
   nmde105 LIKE nmde_t.nmde105, 
   nmde106 LIKE nmde_t.nmde106
       END RECORD
PRIVATE TYPE type_g_nmde2_d RECORD
       nmde004 LIKE nmde_t.nmde004, 
   nmde005 LIKE nmde_t.nmde005, 
   nmde100 LIKE nmde_t.nmde100, 
   nmde111 LIKE nmde_t.nmde111, 
   nmde102 LIKE nmde_t.nmde102, 
   nmde113 LIKE nmde_t.nmde113, 
   nmde114 LIKE nmde_t.nmde114, 
   nmde115 LIKE nmde_t.nmde115, 
   nmde116 LIKE nmde_t.nmde116
       END RECORD
PRIVATE TYPE type_g_nmde3_d RECORD
       nmde004 LIKE nmde_t.nmde004, 
   nmde005 LIKE nmde_t.nmde005, 
   nmde100 LIKE nmde_t.nmde100, 
   nmde121 LIKE nmde_t.nmde121, 
   nmde102 LIKE nmde_t.nmde102, 
   nmde123 LIKE nmde_t.nmde123, 
   nmde124 LIKE nmde_t.nmde124, 
   nmde125 LIKE nmde_t.nmde125, 
   nmde126 LIKE nmde_t.nmde126
       END RECORD
PRIVATE TYPE type_g_nmde4_d RECORD
       nmde004 LIKE nmde_t.nmde004, 
   nmde015 LIKE nmde_t.nmde015, 
   nmde015_desc LIKE type_t.chr500, 
   nmde033 LIKE nmde_t.nmde033, 
   nmde006 LIKE nmde_t.nmde006, 
   nmde006_desc LIKE type_t.chr500, 
   nmde007 LIKE nmde_t.nmde007, 
   nmde007_desc LIKE type_t.chr500, 
   nmde008 LIKE nmde_t.nmde008, 
   nmde008_desc LIKE type_t.chr500, 
   nmde018 LIKE nmde_t.nmde018, 
   nmde018_desc LIKE type_t.chr500, 
   nmde019 LIKE nmde_t.nmde019, 
   nmde019_desc LIKE type_t.chr500, 
   nmde009 LIKE nmde_t.nmde009, 
   nmde009_desc LIKE type_t.chr500, 
   nmde010 LIKE nmde_t.nmde010, 
   nmde010_desc LIKE type_t.chr500, 
   nmde020 LIKE nmde_t.nmde020, 
   nmde021 LIKE nmde_t.nmde021, 
   nmde021_desc LIKE type_t.chr500, 
   nmde022 LIKE nmde_t.nmde022, 
   nmde022_desc LIKE type_t.chr500, 
   nmde011 LIKE nmde_t.nmde011, 
   nmde011_desc LIKE type_t.chr500, 
   nmde013 LIKE nmde_t.nmde013, 
   nmde013_desc LIKE type_t.chr500, 
   nmde014 LIKE nmde_t.nmde014, 
   nmde014_desc LIKE type_t.chr500, 
   nmde023 LIKE nmde_t.nmde023, 
   nmde023_desc LIKE type_t.chr500, 
   nmde024 LIKE nmde_t.nmde024, 
   nmde024_desc LIKE type_t.chr500, 
   nmde025 LIKE nmde_t.nmde025, 
   nmde025_desc LIKE type_t.chr500, 
   nmde026 LIKE nmde_t.nmde026, 
   nmde026_desc LIKE type_t.chr500, 
   nmde027 LIKE nmde_t.nmde027, 
   nmde027_desc LIKE type_t.chr500, 
   nmde028 LIKE nmde_t.nmde028, 
   nmde028_desc LIKE type_t.chr500, 
   nmde029 LIKE nmde_t.nmde029, 
   nmde029_desc LIKE type_t.chr500, 
   nmde030 LIKE nmde_t.nmde030, 
   nmde030_desc LIKE type_t.chr500, 
   nmde031 LIKE nmde_t.nmde031, 
   nmde031_desc LIKE type_t.chr500, 
   nmde032 LIKE nmde_t.nmde032, 
   nmde032_desc LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_chk_gen             LIKE type_t.chr1
DEFINE g_ooaa002             LIKE ooaa_t.ooaa002 #160326-00001#25 add
DEFINE g_wc_cs_ld            STRING                #160125-00005#8
DEFINE g_site_str            STRING                #160125-00005#8
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_nmde_m          type_g_nmde_m
DEFINE g_nmde_m_t        type_g_nmde_m
DEFINE g_nmde_m_o        type_g_nmde_m
DEFINE g_nmde_m_mask_o   type_g_nmde_m #轉換遮罩前資料
DEFINE g_nmde_m_mask_n   type_g_nmde_m #轉換遮罩後資料
 
   DEFINE g_nmdeld_t LIKE nmde_t.nmdeld
DEFINE g_nmde001_t LIKE nmde_t.nmde001
DEFINE g_nmde002_t LIKE nmde_t.nmde002
 
 
DEFINE g_nmde_d          DYNAMIC ARRAY OF type_g_nmde_d
DEFINE g_nmde_d_t        type_g_nmde_d
DEFINE g_nmde_d_o        type_g_nmde_d
DEFINE g_nmde_d_mask_o   DYNAMIC ARRAY OF type_g_nmde_d #轉換遮罩前資料
DEFINE g_nmde_d_mask_n   DYNAMIC ARRAY OF type_g_nmde_d #轉換遮罩後資料
DEFINE g_nmde2_d   DYNAMIC ARRAY OF type_g_nmde2_d
DEFINE g_nmde2_d_t type_g_nmde2_d
DEFINE g_nmde2_d_o type_g_nmde2_d
DEFINE g_nmde2_d_mask_o   DYNAMIC ARRAY OF type_g_nmde2_d #轉換遮罩前資料
DEFINE g_nmde2_d_mask_n   DYNAMIC ARRAY OF type_g_nmde2_d #轉換遮罩後資料
DEFINE g_nmde3_d   DYNAMIC ARRAY OF type_g_nmde3_d
DEFINE g_nmde3_d_t type_g_nmde3_d
DEFINE g_nmde3_d_o type_g_nmde3_d
DEFINE g_nmde3_d_mask_o   DYNAMIC ARRAY OF type_g_nmde3_d #轉換遮罩前資料
DEFINE g_nmde3_d_mask_n   DYNAMIC ARRAY OF type_g_nmde3_d #轉換遮罩後資料
DEFINE g_nmde4_d   DYNAMIC ARRAY OF type_g_nmde4_d
DEFINE g_nmde4_d_t type_g_nmde4_d
DEFINE g_nmde4_d_o type_g_nmde4_d
DEFINE g_nmde4_d_mask_o   DYNAMIC ARRAY OF type_g_nmde4_d #轉換遮罩前資料
DEFINE g_nmde4_d_mask_n   DYNAMIC ARRAY OF type_g_nmde4_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_nmdeld LIKE nmde_t.nmdeld,
   b_nmdeld_desc LIKE type_t.chr80,
      b_nmde001 LIKE nmde_t.nmde001,
      b_nmde002 LIKE nmde_t.nmde002
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
 
{<section id="anmt820.main" >}
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
   CALL cl_ap_init("anm","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT nmdesite,'',nmdecomp,'','','',nmdeld,'',nmdedocdt,nmde017,nmde001,nmde002, 
       nmdedocno", 
                      " FROM nmde_t",
                      " WHERE nmdeent= ? AND nmdeld=? AND nmde001=? AND nmde002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt820_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.nmdesite,t0.nmdecomp,t0.nmdeld,t0.nmdedocdt,t0.nmde017,t0.nmde001, 
       t0.nmde002,t0.nmdedocno,t1.ooefl003 ,t2.ooefl003 ,t3.glaal002",
               " FROM nmde_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.nmdesite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.nmdecomp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent="||g_enterprise||" AND t3.glaalld=t0.nmdeld AND t3.glaal001='"||g_dlang||"' ",
 
               " WHERE t0.nmdeent = " ||g_enterprise|| " AND t0.nmdeld = ? AND t0.nmde001 = ? AND t0.nmde002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmt820_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmt820 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmt820_init()   
 
      #進入選單 Menu (="N")
      CALL anmt820_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmt820
      
   END IF 
   
   CLOSE anmt820_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE anmt820_tmp01;       #160727-00019#33 Mod  s_anmt820_nm_tmp--> anmt820_tmp01
   DROP TABLE anmt820_tmp02;       #160727-00019#33 Mod  s_anmt820_nm_group--> anmt820_tmp02
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmt820.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmt820_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success    LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
#   CALL cl_set_act_visible('modify,modify_detail',FALSE) #160326-00001#25 mark
   CALL cl_set_act_visible('insert,insert_detail',FALSE)
#   CALL cl_set_comp_visible('nmde106,nmde116,nmde126',FALSE)#160530-00003#1 add #160708-00016#1 mark
   CALL cl_set_combo_scc('nmde020','6013')     #160326-00001#25 add
   
   CALL s_pre_voucher_cre_tmp_table() RETURNING g_sub_success  #啟用分錄底稿用 #151013-00019#13
   CALL s_fin_continue_no_tmp()                                               #151013-00019#13
   #end add-point
   
   CALL anmt820_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="anmt820.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION anmt820_ui_dialog()
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
   DEFINE l_wc        STRING
   DEFINE l_glapstus  LIKE glap_t.glapstus
   DEFINE l_glaa121   LIKE glaa_t.glaa121
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_glaa015   LIKE glaa_t.glaa015
   DEFINE l_glaa019   LIKE glaa_t.glaa019
   DEFINE l_glbc009   LIKE glbc_t.glbc009
   DEFINE l_glbc012   LIKE glbc_t.glbc012
   DEFINE l_glbc014   LIKE glbc_t.glbc014
   DEFINE l_nmck113   LIKE nmck_t.nmck113
   DEFINE l_nmck123   LIKE nmck_t.nmck123
   DEFINE l_nmck133   LIKE nmck_t.nmck133
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_glap001   LIKE glap_t.glap001   #151001-00006#1
   DEFINE l_sys       LIKE type_t.chr2      #151013-00019#13
   DEFINE l_glca002   LIKE glca_t.glca002   #151013-00019#13
   DEFINE l_n         LIKE type_t.num10     #151125-00006#3
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
         INITIALIZE g_nmde_m.* TO NULL
         CALL g_nmde_d.clear()
         CALL g_nmde2_d.clear()
         CALL g_nmde3_d.clear()
         CALL g_nmde4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL anmt820_init()
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
               CALL anmt820_idx_chk()
               CALL anmt820_fetch('') # reload data
               LET g_detail_idx = 1
               CALL anmt820_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_nmde_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL anmt820_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL anmt820_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body.before_row"
               
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
               
               
            
 
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_nmde2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL anmt820_idx_chk()
               CALL anmt820_ui_detailshow()
               
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
         DISPLAY ARRAY g_nmde3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL anmt820_idx_chk()
               CALL anmt820_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body3.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 3
            
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         DISPLAY ARRAY g_nmde4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL anmt820_idx_chk()
               CALL anmt820_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body4.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 4
            
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps 
         
         BEFORE DIALOG
            #先填充browser資料
            CALL anmt820_browser_fill("")
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
               CALL anmt820_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL anmt820_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL anmt820_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL anmt820_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt820_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL anmt820_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt820_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL anmt820_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt820_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL anmt820_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt820_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL anmt820_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt820_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_nmde_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_nmde2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_nmde3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_nmde4_d)
                  LET g_export_id[4]   = "s_detail4"
 
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
               NEXT FIELD nmde004
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
               CALL anmt820_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL anmt820_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL anmt820_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL anmt820_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #151125-00006#3--s               
#               CALL anmt820_immediately_gen()   #160326-00001#25 mark          
#               CALL anmt820_ui_headershow()     #160326-00001#25 mark
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL anmt820_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #151125-00006#3--s               
#               CALL anmt820_immediately_gen() #160326-00001#25 mark
#               CALL anmt820_ui_headershow()   #160326-00001#25 mark
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pre
            LET g_action_choice="open_pre"
            IF cl_auth_chk_act("open_pre") THEN
               
               #add-point:ON ACTION open_pre name="menu.open_pre"
               SELECT nmde017 INTO g_nmde_m.nmde017 FROM nmde_t
                WHERE nmdeent = g_enterprise
                  AND nmdeld = g_nmde_m.nmdeld
                  AND nmde001 = g_nmde_m.nmde001
                  AND nmde002 = g_nmde_m.nmde002
                  AND nmde004 = g_nmde_d[l_ac].nmde004
                  
               IF NOT cl_null(g_nmde_m.nmdedocno) AND cl_null(g_nmde_m.nmde017) THEN #150729-00002#1 add是否已拋傳票條件
                  CALL s_transaction_begin()
                  CALL s_pre_voucher_ins('NM','N40',g_nmde_m.nmdeld,g_nmde_m.nmdedocno,g_today,'1')
                     RETURNING l_success
                  IF l_success THEN
                     CALL s_transaction_end('Y','0')
                  ELSE
                     CALL s_transaction_end('N','0')
                  END IF
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL anmt820_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION go_gen
            LET g_action_choice="go_gen"
            IF cl_auth_chk_act("go_gen") THEN
               
               #add-point:ON ACTION go_gen name="menu.go_gen"
               #傳票拋轉
               IF NOT cl_null(g_nmde_m.nmde017) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00198'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT DIALOG
               END IF
               SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019 
                 FROM glaa_t 
                WHERE glaaent = g_enterprise AND glaald = g_nmde_m.nmdeld AND glaa014 = 'Y'
               LET l_cnt = 0 
               SELECT COUNT(*) INTO l_cnt FROM glbc_t
                WHERE glbcent=g_enterprise AND glbcld=g_nmde_m.nmdeld
                  AND glbcdocno=g_nmde_m.nmdedocno AND glbc001=g_nmde_m.nmde001
                  AND glbc002=g_nmde_m.nmde002
                  
               SELECT SUM(glbc009),SUM(glbc012),SUM(glbc014)
                 INTO l_glbc009,l_glbc012,l_glbc014
                 FROM glbc_t
                WHERE glbcent=g_enterprise AND glbcld=g_nmde_m.nmdeld
                  AND glbcdocno=g_nmde_m.nmdedocno AND glbc001=g_nmde_m.nmde001
                  AND glbc002=g_nmde_m.nmde002
             
               SELECT SUM(nmde106),SUM(nmde116),SUM(nmde126) #160530-00003#4 mark #160708-00016#1 unmark
#               SELECT SUM(nmde105),SUM(nmde115),SUM(nmde125)  #160530-00003#4 add #160708-00016#1 mark
                 INTO l_nmck113,l_nmck123,l_nmck133
                 FROM nmde_t
                WHERE nmdeent = g_enterprise
                  AND nmdeld = g_nmde_m.nmdeld
                  AND nmde001 = g_nmde_m.nmde001
                  AND nmde002 = g_nmde_m.nmde002
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00221'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT DIALOG
               END IF 
               IF l_glbc009 <> l_nmck113 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00146'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT DIALOG
               END IF 
               
               IF l_glaa015='Y' AND l_glbc012 <> l_nmck123 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00147'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT DIALOG
               END IF

               IF l_glaa019='Y' AND l_glbc014 <> l_nmck133 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00148'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  EXIT DIALOG
               END IF 
               
#               CALL anmt820_for_gen()  #160326-00001#25 mark
               CALL anmt820_go_gen()
               
               SELECT nmde017 INTO g_nmde_m.nmde017 FROM nmde_t
                WHERE nmdeent = g_enterprise AND nmdeld = g_nmde_m.nmdeld
                  AND nmde001 = g_nmde_m.nmde001 AND nmde002 = g_nmde_m.nmde002
               CALL anmt820_show()
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL anmt820_insert()
               #add-point:ON ACTION insert name="menu.insert"
              #151125-00006#3--s               
               CALL anmt820_immediately_gen()              
               CALL anmt820_ui_headershow() 
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION anmt820_03
            LET g_action_choice="anmt820_03"
            IF cl_auth_chk_act("anmt820_03") THEN
               
               #add-point:ON ACTION anmt820_03 name="menu.anmt820_03"
#150930-00010#2--mark--str--
#               IF NOT cl_null(g_nmde_m.nmde017) THEN
#                  LET la_param.prog = 'aglt310'
#                  LET la_param.param[1] = g_nmde_m.nmdeld
#                  LET la_param.param[2] = g_nmde_m.nmde017
#                  LET ls_js = util.JSON.stringify(la_param)
#                  CALL cl_cmdrun(ls_js)
#                  EXIT DIALOG
#               END IF
#150930-00010#2--mark--end
               IF NOT cl_null(g_nmde_m.nmdedocno) THEN  #150930-00010#2 add
                  #151013-00019#13 add ------
                  SELECT (CASE WHEN glca002 = '2' THEN 'Y' ELSE 'N' END) INTO l_glca002
                    FROM glca_t
                   WHERE glcaent = g_enterprise
                     AND glcald  = g_nmde_m.nmdeld AND glca001 = 'NM'
                  IF l_glca002 = 'Y' THEN
                     LET l_sys = 'AC'
                  ELSE
                     LET l_sys = 'NM'
                  END IF
                  #151013-00019#13 add end---
                  SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise
                      AND glaald = g_nmde_m.nmdeld
                  IF l_glaa121 = 'Y' THEN
                    #CALL s_pre_voucher('NM','N40',g_nmde_m.nmdeld,g_nmde_m.nmdedocno,g_today)             #150707-00001#8
                    #CALL s_pre_voucher('NM','N40',g_nmde_m.nmdeld,g_nmde_m.nmdedocno,g_nmde_m.nmdedocdt)  #150707-00001#8 #151013-00019#13 mark
                     CALL s_pre_voucher(l_sys,'N40',g_nmde_m.nmdeld,g_nmde_m.nmdedocno,g_nmde_m.nmdedocdt) #151013-00019#13
                  ELSE
                     CALL s_transaction_begin()  #161212-00032#1 add  
                     CALL anmt820_for_gen() 
                     #CALL anmt820_03(g_nmde_m.nmdeld,g_nmde_m.nmde001,g_nmde_m.nmde002,g_wc)  #2014/12/31---mark---
                     #2014/12/31---add---
                     LET l_wc = "",g_nmde_m.nmde001 USING '<<<<'," AND nmde002=",g_nmde_m.nmde002
                     CALL axrt300_13('NM',g_nmde_m.nmdeld,l_wc,'anmt820')
                     #2014/12/31---add---
                  END IF 
               
                  CALL anmt820_b_fill(g_wc2) #單身填充
                  CALL anmt820_b_fill2('0') #單身填充
               END IF  #150930-00010#2 add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #151021-00009#1 151023 by sakura add(S)
               LET g_rep_wc = "nmdeent ="|| g_enterprise ||" ",
                         " AND nmdeld ='"|| g_nmde_m.nmdeld ||"'",
                         " AND nmde001 = '", g_nmde_m.nmde001, "' ",
                         " AND nmde002 = '", g_nmde_m.nmde002, "' "
               #151021-00009#1 151023 by sakura add(E)
               #END add-point
               &include "erp/anm/anmt820_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #151021-00009#1 151023 by sakura add(S)
               LET g_rep_wc = "nmdeent ="|| g_enterprise ||" ",
                         " AND nmdeld ='"|| g_nmde_m.nmdeld ||"'",
                         " AND nmde001 = '", g_nmde_m.nmde001, "' ",
                         " AND nmde002 = '", g_nmde_m.nmde002, "' "
               #151021-00009#1 151023 by sakura add(E)
               #END add-point
               &include "erp/anm/anmt820_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL anmt820_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               #151125-00006#3--s
              # CALL anmt820_immediately_conf()
               CALL anmt820_immediately_gen()
               SELECT COUNT(*) INTO l_n FROM nmde_t
                WHERE nmdeent = g_enterprise AND nmdeld = g_nmde_m.nmdeld AND nmdedocno = g_nmde_m.nmdedocno
                IF l_n > 0 THEN CALL anmt820_ui_headershow() END IF
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmt820_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reduction
            LET g_action_choice="reduction"
            IF cl_auth_chk_act("reduction") THEN
               
               #add-point:ON ACTION reduction name="menu.reduction"
               #無傳票 不可還原
               IF cl_null(g_nmde_m.nmde017) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00186'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               SELECT glapstus INTO l_glapstus
                 FROM glap_t
                WHERE glapent = g_enterprise
                  AND glapld = g_nmde_m.nmdeld
                  AND glapdocno = g_nmde_m.nmde017
               IF l_glapstus = 'Y' OR l_glapstus = 'S' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00076'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               CALL anmt820_reduction()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_cashflow
            LET g_action_choice="s_cashflow"
            IF cl_auth_chk_act("s_cashflow") THEN
               
               #add-point:ON ACTION s_cashflow name="menu.s_cashflow"
               IF NOT cl_null(g_nmde_m.nmdedocno) THEN
                                     #帳別        #匯款編號      #年度           #期別          #借貸別 #作業編號  #單身項次
                  CALL s_cashflow_nm(g_nmde_m.nmdeld,g_nmde_m.nmdedocno,g_nmde_m.nmde001,g_nmde_m.nmde002,'1',g_prog,'')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_nmde017
            LET g_action_choice="prog_nmde017"
            IF cl_auth_chk_act("prog_nmde017") THEN
               
               #add-point:ON ACTION prog_nmde017 name="menu.prog_nmde017"
               #151001-00006#1----add----str--
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL

               IF NOT cl_null(g_nmde_m.nmde017) THEN
                  SELECT glap001 INTO l_glap001 FROM glap_t WHERE glapent = g_enterprise
                     AND glapdocno = g_nmde_m.nmde017  AND glapld = g_nmde_m.nmdeld
                  CASE
                     WHEN l_glap001 = '1'
                        LET la_param.prog = "aglt310"
                     WHEN l_glap001 = '2'
                        LET la_param.prog = "aglt320"
                     WHEN l_glap001 = '3'
                        LET la_param.prog = "aglt330"
                     WHEN l_glap001 = '5'
                        LET la_param.prog = "aglt350"
                  END CASE
                  LET la_param.param[1] = g_nmde_m.nmdeld
                  LET la_param.param[2] = g_nmde_m.nmde017
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
 


               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL anmt820_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL anmt820_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL anmt820_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_nmde_m.nmdedocdt)
 
 
 
         
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
 
{<section id="anmt820.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION anmt820_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   LET g_wc = cl_replace_str(g_wc,"nmde001_i","nmde001")
   LET g_wc = cl_replace_str(g_wc,"nmde002_i","nmde002")
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="anmt820.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION anmt820_browser_fill(ps_page_action)
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
   DEFINE l_ld_str          STRING #160125-00005#8
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
   LET g_wc = cl_replace_str(g_wc,"nmde001_i","nmde001")
   LET g_wc = cl_replace_str(g_wc,"nmde002_i","nmde002")
   #160125-00005#8--add--str--
   #账套范围
   CALL s_axrt300_get_site(g_user,'','2')  RETURNING g_wc_cs_ld 
   IF NOT cl_null(g_wc_cs_ld) THEN   
      LET l_ld_str = cl_replace_str(g_wc_cs_ld,"glaald","nmdeld")
      IF cl_null(g_wc) THEN
         LET g_wc = l_ld_str
      ELSE
         LET g_wc = g_wc , " AND ",l_ld_str
      END IF
   END IF
   #160125-00005#8--add--end
   #end add-point    
 
   LET l_searchcol = "nmdeld,nmde001,nmde002"
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
      LET l_sub_sql = " SELECT DISTINCT nmdeld ",
                      ", nmde001 ",
                      ", nmde002 ",
 
                      " FROM nmde_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE nmdeent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("nmde_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT nmdeld ",
                      ", nmde001 ",
                      ", nmde002 ",
 
                      " FROM nmde_t ",
                      " ",
                      " ", 
 
 
                      " WHERE nmdeent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("nmde_t")
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
      INITIALIZE g_nmde_m.* TO NULL
      CALL g_nmde_d.clear()        
      CALL g_nmde2_d.clear() 
      CALL g_nmde3_d.clear() 
      CALL g_nmde4_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.nmdeld,t0.nmde001,t0.nmde002 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.nmdeld,t0.nmde001,t0.nmde002,t1.glaal002",
                " FROM nmde_t t0",
                #" ",
                " ",
 
 
 
                               " LEFT JOIN glaal_t t1 ON t1.glaalent="||g_enterprise||" AND t1.glaalld=t0.nmdeld AND t1.glaal001='"||g_dlang||"' ",
 
                " WHERE t0.nmdeent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("nmde_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"nmde_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_nmdeld,g_browser[g_cnt].b_nmde001,g_browser[g_cnt].b_nmde002, 
          g_browser[g_cnt].b_nmdeld_desc 
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
         CALL anmt820_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_nmdeld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_nmde_m.* TO NULL
      CALL g_nmde_d.clear()
      CALL g_nmde2_d.clear()
      CALL g_nmde3_d.clear()
      CALL g_nmde4_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL anmt820_fetch('')
   
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
 
{<section id="anmt820.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION anmt820_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_nmde_m.nmdeld = g_browser[g_current_idx].b_nmdeld   
   LET g_nmde_m.nmde001 = g_browser[g_current_idx].b_nmde001   
   LET g_nmde_m.nmde002 = g_browser[g_current_idx].b_nmde002   
 
   EXECUTE anmt820_master_referesh USING g_nmde_m.nmdeld,g_nmde_m.nmde001,g_nmde_m.nmde002 INTO g_nmde_m.nmdesite, 
       g_nmde_m.nmdecomp,g_nmde_m.nmdeld,g_nmde_m.nmdedocdt,g_nmde_m.nmde017,g_nmde_m.nmde001,g_nmde_m.nmde002, 
       g_nmde_m.nmdedocno,g_nmde_m.nmdesite_desc,g_nmde_m.nmdecomp_desc,g_nmde_m.nmdeld_desc
   CALL anmt820_show()
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION anmt820_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
#   CALL cl_set_act_visible('modify,modify_detail',FALSE) #160326-00001#25 mark
   CALL cl_set_act_visible('insert,insert_detail',FALSE)
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION anmt820_ui_browser_refresh()
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
      IF g_browser[l_i].b_nmdeld = g_nmde_m.nmdeld 
         AND g_browser[l_i].b_nmde001 = g_nmde_m.nmde001 
         AND g_browser[l_i].b_nmde002 = g_nmde_m.nmde002 
 
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
 
{<section id="anmt820.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmt820_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_site_str  STRING #160816-00012#3 add
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_nmde_m.* TO NULL
   CALL g_nmde_d.clear()
   CALL g_nmde2_d.clear()
   CALL g_nmde3_d.clear()
   CALL g_nmde4_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   #品类管理层级aoos010
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING g_ooaa002 #160326-00001#25 add
   LET g_site_str = NULL #160125-00005#8
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON nmdesite,nmdecomp,nmde001_i,nmde002_i,nmdeld,nmdedocdt,nmde017,nmde001, 
          nmde002,nmdedocno
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdesite
            #add-point:BEFORE FIELD nmdesite name="construct.b.nmdesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdesite
            
            #add-point:AFTER FIELD nmdesite name="construct.a.nmdesite"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str #160125-00005#8
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmdesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdesite
            #add-point:ON ACTION controlp INFIELD nmdesite name="construct.c.nmdesite"
            #帳務中心
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef201 = 'Y' " #150729-00002#1 add條件 #160816-00012#3 
            #CALL q_ooef001()                         #150729-00002#1 #161021-00050#10 mark
            CALL q_ooef001_46()                       #161021-00050#10
            DISPLAY g_qryparam.return1 TO nmdesite
            NEXT FIELD nmdesite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdecomp
            #add-point:BEFORE FIELD nmdecomp name="construct.b.nmdecomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdecomp
            
            #add-point:AFTER FIELD nmdecomp name="construct.a.nmdecomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmdecomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdecomp
            #add-point:ON ACTION controlp INFIELD nmdecomp name="construct.c.nmdecomp"
            #150707-00001#8--(s)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y' "
            #CALL q_ooef001()  #161021-00050#10 mark
            CALL q_ooef001_2() #161021-00050#10
            DISPLAY g_qryparam.return1 TO nmdecomp
            NEXT FIELD nmdecomp
            #150707-00001#8--(e)
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde001_i
            #add-point:BEFORE FIELD nmde001_i name="construct.b.nmde001_i"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde001_i
            
            #add-point:AFTER FIELD nmde001_i name="construct.a.nmde001_i"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmde001_i
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde001_i
            #add-point:ON ACTION controlp INFIELD nmde001_i name="construct.c.nmde001_i"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde002_i
            #add-point:BEFORE FIELD nmde002_i name="construct.b.nmde002_i"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde002_i
            
            #add-point:AFTER FIELD nmde002_i name="construct.a.nmde002_i"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmde002_i
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde002_i
            #add-point:ON ACTION controlp INFIELD nmde002_i name="construct.c.nmde002_i"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdeld
            #add-point:BEFORE FIELD nmdeld name="construct.b.nmdeld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdeld
            
            #add-point:AFTER FIELD nmdeld name="construct.a.nmdeld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmdeld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdeld
            #add-point:ON ACTION controlp INFIELD nmdeld name="construct.c.nmdeld"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160125-00005#8--add--str--
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #账套范围
            CALL s_axrt300_get_site(g_user,g_site_str,'2')  RETURNING g_wc_cs_ld 
            IF NOT cl_null(g_wc_cs_ld) THEN   
               LET g_qryparam.where = g_wc_cs_ld
            END IF
            #160125-00005#8--add--end
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmdeld  #顯示到畫面上
            NEXT FIELD nmdeld                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdedocdt
            #add-point:BEFORE FIELD nmdedocdt name="construct.b.nmdedocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdedocdt
            
            #add-point:AFTER FIELD nmdedocdt name="construct.a.nmdedocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmdedocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdedocdt
            #add-point:ON ACTION controlp INFIELD nmdedocdt name="construct.c.nmdedocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde017
            #add-point:BEFORE FIELD nmde017 name="construct.b.nmde017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde017
            
            #add-point:AFTER FIELD nmde017 name="construct.a.nmde017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmde017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde017
            #add-point:ON ACTION controlp INFIELD nmde017 name="construct.c.nmde017"
            #150707-00001#8--(s)
            #拋轉傳票號碼
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmde017()
            DISPLAY g_qryparam.return1 TO nmde017  #顯示到畫面上
            NEXT FIELD nmde017            
            #150707-00001#8--(e)
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde001
            #add-point:BEFORE FIELD nmde001 name="construct.b.nmde001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde001
            
            #add-point:AFTER FIELD nmde001 name="construct.a.nmde001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmde001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde001
            #add-point:ON ACTION controlp INFIELD nmde001 name="construct.c.nmde001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde002
            #add-point:BEFORE FIELD nmde002 name="construct.b.nmde002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde002
            
            #add-point:AFTER FIELD nmde002 name="construct.a.nmde002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmde002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde002
            #add-point:ON ACTION controlp INFIELD nmde002 name="construct.c.nmde002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdedocno
            #add-point:BEFORE FIELD nmdedocno name="construct.b.nmdedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdedocno
            
            #add-point:AFTER FIELD nmdedocno name="construct.a.nmdedocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmdedocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdedocno
            #add-point:ON ACTION controlp INFIELD nmdedocno name="construct.c.nmdedocno"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON nmde005,nmde004,nmde100,nmde101,nmde102,nmde103,nmde104,nmde105,nmde106, 
          nmde111,nmde113,nmde114,nmde115,nmde116,nmde121,nmde123,nmde124,nmde125,nmde126,nmde015,nmde015_desc, 
          nmde033,nmde006,nmde006_desc,nmde007,nmde007_desc,nmde008,nmde008_desc,nmde018,nmde018_desc, 
          nmde019,nmde019_desc,nmde009,nmde009_desc,nmde010,nmde010_desc,nmde020,nmde021,nmde021_desc, 
          nmde022,nmde022_desc,nmde011,nmde011_desc,nmde013,nmde013_desc,nmde014,nmde014_desc,nmde023, 
          nmde023_desc,nmde024,nmde024_desc,nmde025,nmde025_desc,nmde026,nmde026_desc,nmde027,nmde027_desc, 
          nmde028,nmde028_desc,nmde029,nmde029_desc,nmde030,nmde030_desc,nmde031,nmde031_desc,nmde032, 
          nmde032_desc
           FROM s_detail1[1].nmde005,s_detail1[1].nmde004,s_detail1[1].nmde100,s_detail1[1].nmde101, 
               s_detail1[1].nmde102,s_detail1[1].nmde103,s_detail1[1].nmde104,s_detail1[1].nmde105,s_detail1[1].nmde106, 
               s_detail2[1].nmde111,s_detail2[1].nmde113,s_detail2[1].nmde114,s_detail2[1].nmde115,s_detail2[1].nmde116, 
               s_detail3[1].nmde121,s_detail3[1].nmde123,s_detail3[1].nmde124,s_detail3[1].nmde125,s_detail3[1].nmde126, 
               s_detail4[1].nmde015,s_detail4[1].nmde015_desc,s_detail4[1].nmde033,s_detail4[1].nmde006, 
               s_detail4[1].nmde006_desc,s_detail4[1].nmde007,s_detail4[1].nmde007_desc,s_detail4[1].nmde008, 
               s_detail4[1].nmde008_desc,s_detail4[1].nmde018,s_detail4[1].nmde018_desc,s_detail4[1].nmde019, 
               s_detail4[1].nmde019_desc,s_detail4[1].nmde009,s_detail4[1].nmde009_desc,s_detail4[1].nmde010, 
               s_detail4[1].nmde010_desc,s_detail4[1].nmde020,s_detail4[1].nmde021,s_detail4[1].nmde021_desc, 
               s_detail4[1].nmde022,s_detail4[1].nmde022_desc,s_detail4[1].nmde011,s_detail4[1].nmde011_desc, 
               s_detail4[1].nmde013,s_detail4[1].nmde013_desc,s_detail4[1].nmde014,s_detail4[1].nmde014_desc, 
               s_detail4[1].nmde023,s_detail4[1].nmde023_desc,s_detail4[1].nmde024,s_detail4[1].nmde024_desc, 
               s_detail4[1].nmde025,s_detail4[1].nmde025_desc,s_detail4[1].nmde026,s_detail4[1].nmde026_desc, 
               s_detail4[1].nmde027,s_detail4[1].nmde027_desc,s_detail4[1].nmde028,s_detail4[1].nmde028_desc, 
               s_detail4[1].nmde029,s_detail4[1].nmde029_desc,s_detail4[1].nmde030,s_detail4[1].nmde030_desc, 
               s_detail4[1].nmde031,s_detail4[1].nmde031_desc,s_detail4[1].nmde032,s_detail4[1].nmde032_desc 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde005
            #add-point:BEFORE FIELD nmde005 name="construct.b.page1.nmde005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde005
            
            #add-point:AFTER FIELD nmde005 name="construct.a.page1.nmde005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmde005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde005
            #add-point:ON ACTION controlp INFIELD nmde005 name="construct.c.page1.nmde005"
            #150707-00001#8--(s)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_site_str #160816-00012#3
            LET g_qryparam.where = l_site_str CLIPPED                   #160816-00012#3
            LET g_qryparam.where = g_qryparam.where ," AND ooef206 = 'Y'" #161021-00050#10
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO nmde005
            NEXT FIELD nmde005
            #150707-00001#8--(e)
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde004
            #add-point:BEFORE FIELD nmde004 name="construct.b.page1.nmde004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde004
            
            #add-point:AFTER FIELD nmde004 name="construct.a.page1.nmde004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmde004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde004
            #add-point:ON ACTION controlp INFIELD nmde004 name="construct.c.page1.nmde004"
            #150729-00002#1-----s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmde004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde004  #顯示到畫面上
            NEXT FIELD nmde004                     #返回原欄位
            #150729-00002#1-----e
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde100
            #add-point:BEFORE FIELD nmde100 name="construct.b.page1.nmde100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde100
            
            #add-point:AFTER FIELD nmde100 name="construct.a.page1.nmde100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmde100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde100
            #add-point:ON ACTION controlp INFIELD nmde100 name="construct.c.page1.nmde100"
            #開窗c段
            #150715-00014#2-----s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde100  #顯示到畫面上
            NEXT FIELD nmde100                     #返回原欄位
            #150715-00014#2-----e
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde101
            #add-point:BEFORE FIELD nmde101 name="construct.b.page1.nmde101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde101
            
            #add-point:AFTER FIELD nmde101 name="construct.a.page1.nmde101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmde101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde101
            #add-point:ON ACTION controlp INFIELD nmde101 name="construct.c.page1.nmde101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde102
            #add-point:BEFORE FIELD nmde102 name="construct.b.page1.nmde102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde102
            
            #add-point:AFTER FIELD nmde102 name="construct.a.page1.nmde102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmde102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde102
            #add-point:ON ACTION controlp INFIELD nmde102 name="construct.c.page1.nmde102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde103
            #add-point:BEFORE FIELD nmde103 name="construct.b.page1.nmde103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde103
            
            #add-point:AFTER FIELD nmde103 name="construct.a.page1.nmde103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmde103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde103
            #add-point:ON ACTION controlp INFIELD nmde103 name="construct.c.page1.nmde103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde104
            #add-point:BEFORE FIELD nmde104 name="construct.b.page1.nmde104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde104
            
            #add-point:AFTER FIELD nmde104 name="construct.a.page1.nmde104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmde104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde104
            #add-point:ON ACTION controlp INFIELD nmde104 name="construct.c.page1.nmde104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde105
            #add-point:BEFORE FIELD nmde105 name="construct.b.page1.nmde105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde105
            
            #add-point:AFTER FIELD nmde105 name="construct.a.page1.nmde105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmde105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde105
            #add-point:ON ACTION controlp INFIELD nmde105 name="construct.c.page1.nmde105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde106
            #add-point:BEFORE FIELD nmde106 name="construct.b.page1.nmde106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde106
            
            #add-point:AFTER FIELD nmde106 name="construct.a.page1.nmde106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmde106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde106
            #add-point:ON ACTION controlp INFIELD nmde106 name="construct.c.page1.nmde106"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde111
            #add-point:BEFORE FIELD nmde111 name="construct.b.page2.nmde111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde111
            
            #add-point:AFTER FIELD nmde111 name="construct.a.page2.nmde111"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmde111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde111
            #add-point:ON ACTION controlp INFIELD nmde111 name="construct.c.page2.nmde111"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde113
            #add-point:BEFORE FIELD nmde113 name="construct.b.page2.nmde113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde113
            
            #add-point:AFTER FIELD nmde113 name="construct.a.page2.nmde113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmde113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde113
            #add-point:ON ACTION controlp INFIELD nmde113 name="construct.c.page2.nmde113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde114
            #add-point:BEFORE FIELD nmde114 name="construct.b.page2.nmde114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde114
            
            #add-point:AFTER FIELD nmde114 name="construct.a.page2.nmde114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmde114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde114
            #add-point:ON ACTION controlp INFIELD nmde114 name="construct.c.page2.nmde114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde115
            #add-point:BEFORE FIELD nmde115 name="construct.b.page2.nmde115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde115
            
            #add-point:AFTER FIELD nmde115 name="construct.a.page2.nmde115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmde115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde115
            #add-point:ON ACTION controlp INFIELD nmde115 name="construct.c.page2.nmde115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde116
            #add-point:BEFORE FIELD nmde116 name="construct.b.page2.nmde116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde116
            
            #add-point:AFTER FIELD nmde116 name="construct.a.page2.nmde116"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmde116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde116
            #add-point:ON ACTION controlp INFIELD nmde116 name="construct.c.page2.nmde116"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde121
            #add-point:BEFORE FIELD nmde121 name="construct.b.page3.nmde121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde121
            
            #add-point:AFTER FIELD nmde121 name="construct.a.page3.nmde121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmde121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde121
            #add-point:ON ACTION controlp INFIELD nmde121 name="construct.c.page3.nmde121"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde123
            #add-point:BEFORE FIELD nmde123 name="construct.b.page3.nmde123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde123
            
            #add-point:AFTER FIELD nmde123 name="construct.a.page3.nmde123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmde123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde123
            #add-point:ON ACTION controlp INFIELD nmde123 name="construct.c.page3.nmde123"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde124
            #add-point:BEFORE FIELD nmde124 name="construct.b.page3.nmde124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde124
            
            #add-point:AFTER FIELD nmde124 name="construct.a.page3.nmde124"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmde124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde124
            #add-point:ON ACTION controlp INFIELD nmde124 name="construct.c.page3.nmde124"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde125
            #add-point:BEFORE FIELD nmde125 name="construct.b.page3.nmde125"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde125
            
            #add-point:AFTER FIELD nmde125 name="construct.a.page3.nmde125"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmde125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde125
            #add-point:ON ACTION controlp INFIELD nmde125 name="construct.c.page3.nmde125"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde126
            #add-point:BEFORE FIELD nmde126 name="construct.b.page3.nmde126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde126
            
            #add-point:AFTER FIELD nmde126 name="construct.a.page3.nmde126"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmde126
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde126
            #add-point:ON ACTION controlp INFIELD nmde126 name="construct.c.page3.nmde126"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde015
            #add-point:BEFORE FIELD nmde015 name="construct.b.page4.nmde015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde015
            
            #add-point:AFTER FIELD nmde015 name="construct.a.page4.nmde015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde015
            #add-point:ON ACTION controlp INFIELD nmde015 name="construct.c.page4.nmde015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde015_desc
            #add-point:BEFORE FIELD nmde015_desc name="construct.b.page4.nmde015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde015_desc
            
            #add-point:AFTER FIELD nmde015_desc name="construct.a.page4.nmde015_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde015_desc
            #add-point:ON ACTION controlp INFIELD nmde015_desc name="construct.c.page4.nmde015_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde033
            #add-point:BEFORE FIELD nmde033 name="construct.b.page4.nmde033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde033
            
            #add-point:AFTER FIELD nmde033 name="construct.a.page4.nmde033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde033
            #add-point:ON ACTION controlp INFIELD nmde033 name="construct.c.page4.nmde033"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.nmde006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde006
            #add-point:ON ACTION controlp INFIELD nmde006 name="construct.c.page4.nmde006"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde006  #顯示到畫面上
            NEXT FIELD nmde006                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde006
            #add-point:BEFORE FIELD nmde006 name="construct.b.page4.nmde006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde006
            
            #add-point:AFTER FIELD nmde006 name="construct.a.page4.nmde006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde006_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde006_desc
            #add-point:ON ACTION controlp INFIELD nmde006_desc name="construct.c.page4.nmde006_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde006_desc  #顯示到畫面上
            NEXT FIELD nmde006_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde006_desc
            #add-point:BEFORE FIELD nmde006_desc name="construct.b.page4.nmde006_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde006_desc
            
            #add-point:AFTER FIELD nmde006_desc name="construct.a.page4.nmde006_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde007
            #add-point:ON ACTION controlp INFIELD nmde007 name="construct.c.page4.nmde007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde007  #顯示到畫面上
            NEXT FIELD nmde007                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde007
            #add-point:BEFORE FIELD nmde007 name="construct.b.page4.nmde007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde007
            
            #add-point:AFTER FIELD nmde007 name="construct.a.page4.nmde007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde007_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde007_desc
            #add-point:ON ACTION controlp INFIELD nmde007_desc name="construct.c.page4.nmde007_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde007_desc  #顯示到畫面上
            NEXT FIELD nmde007_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde007_desc
            #add-point:BEFORE FIELD nmde007_desc name="construct.b.page4.nmde007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde007_desc
            
            #add-point:AFTER FIELD nmde007_desc name="construct.a.page4.nmde007_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde008
            #add-point:ON ACTION controlp INFIELD nmde008 name="construct.c.page4.nmde008"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde008  #顯示到畫面上
            NEXT FIELD nmde008                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde008
            #add-point:BEFORE FIELD nmde008 name="construct.b.page4.nmde008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde008
            
            #add-point:AFTER FIELD nmde008 name="construct.a.page4.nmde008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde008_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde008_desc
            #add-point:ON ACTION controlp INFIELD nmde008_desc name="construct.c.page4.nmde008_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde008_desc  #顯示到畫面上
            NEXT FIELD nmde008_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde008_desc
            #add-point:BEFORE FIELD nmde008_desc name="construct.b.page4.nmde008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde008_desc
            
            #add-point:AFTER FIELD nmde008_desc name="construct.a.page4.nmde008_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde018
            #add-point:ON ACTION controlp INFIELD nmde018 name="construct.c.page4.nmde018"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            # CALL q_pmaa001()       #160913-00017#6  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#6  add      
            DISPLAY g_qryparam.return1 TO nmde018  #顯示到畫面上
            NEXT FIELD nmde018                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde018
            #add-point:BEFORE FIELD nmde018 name="construct.b.page4.nmde018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde018
            
            #add-point:AFTER FIELD nmde018 name="construct.a.page4.nmde018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde018_desc
            #add-point:ON ACTION controlp INFIELD nmde018_desc name="construct.c.page4.nmde018_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            # CALL q_pmaa001()       #160913-00017#6  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#6  add      
            DISPLAY g_qryparam.return1 TO nmde018_desc  #顯示到畫面上
            NEXT FIELD nmde018_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde018_desc
            #add-point:BEFORE FIELD nmde018_desc name="construct.b.page4.nmde018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde018_desc
            
            #add-point:AFTER FIELD nmde018_desc name="construct.a.page4.nmde018_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde019
            #add-point:ON ACTION controlp INFIELD nmde019 name="construct.c.page4.nmde019"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            # CALL q_pmaa001()       #160913-00017#6  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#6  add      
            DISPLAY g_qryparam.return1 TO nmde019  #顯示到畫面上
            NEXT FIELD nmde019                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde019
            #add-point:BEFORE FIELD nmde019 name="construct.b.page4.nmde019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde019
            
            #add-point:AFTER FIELD nmde019 name="construct.a.page4.nmde019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde019_desc
            #add-point:ON ACTION controlp INFIELD nmde019_desc name="construct.c.page4.nmde019_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
           # CALL q_pmaa001()       #160913-00017#6  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#6  add      
            DISPLAY g_qryparam.return1 TO nmde019_desc  #顯示到畫面上
            NEXT FIELD nmde019_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde019_desc
            #add-point:BEFORE FIELD nmde019_desc name="construct.b.page4.nmde019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde019_desc
            
            #add-point:AFTER FIELD nmde019_desc name="construct.a.page4.nmde019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde009
            #add-point:ON ACTION controlp INFIELD nmde009 name="construct.c.page4.nmde009"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde009  #顯示到畫面上
            NEXT FIELD nmde009                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde009
            #add-point:BEFORE FIELD nmde009 name="construct.b.page4.nmde009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde009
            
            #add-point:AFTER FIELD nmde009 name="construct.a.page4.nmde009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde009_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde009_desc
            #add-point:ON ACTION controlp INFIELD nmde009_desc name="construct.c.page4.nmde009_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde009_desc  #顯示到畫面上
            NEXT FIELD nmde009_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde009_desc
            #add-point:BEFORE FIELD nmde009_desc name="construct.b.page4.nmde009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde009_desc
            
            #add-point:AFTER FIELD nmde009_desc name="construct.a.page4.nmde009_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde010
            #add-point:ON ACTION controlp INFIELD nmde010 name="construct.c.page4.nmde010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde010  #顯示到畫面上
            NEXT FIELD nmde010                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde010
            #add-point:BEFORE FIELD nmde010 name="construct.b.page4.nmde010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde010
            
            #add-point:AFTER FIELD nmde010 name="construct.a.page4.nmde010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde010_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde010_desc
            #add-point:ON ACTION controlp INFIELD nmde010_desc name="construct.c.page4.nmde010_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtax004='",g_ooaa002,"'" #160326-00001#25 add
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde010_desc  #顯示到畫面上
            NEXT FIELD nmde010_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde010_desc
            #add-point:BEFORE FIELD nmde010_desc name="construct.b.page4.nmde010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde010_desc
            
            #add-point:AFTER FIELD nmde010_desc name="construct.a.page4.nmde010_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde020
            #add-point:BEFORE FIELD nmde020 name="construct.b.page4.nmde020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde020
            
            #add-point:AFTER FIELD nmde020 name="construct.a.page4.nmde020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde020
            #add-point:ON ACTION controlp INFIELD nmde020 name="construct.c.page4.nmde020"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.nmde021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde021
            #add-point:ON ACTION controlp INFIELD nmde021 name="construct.c.page4.nmde021"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde021  #顯示到畫面上
            NEXT FIELD nmde021                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde021
            #add-point:BEFORE FIELD nmde021 name="construct.b.page4.nmde021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde021
            
            #add-point:AFTER FIELD nmde021 name="construct.a.page4.nmde021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde021_desc
            #add-point:ON ACTION controlp INFIELD nmde021_desc name="construct.c.page4.nmde021_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde021_desc  #顯示到畫面上
            NEXT FIELD nmde021_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde021_desc
            #add-point:BEFORE FIELD nmde021_desc name="construct.b.page4.nmde021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde021_desc
            
            #add-point:AFTER FIELD nmde021_desc name="construct.a.page4.nmde021_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde022
            #add-point:ON ACTION controlp INFIELD nmde022 name="construct.c.page4.nmde022"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde022  #顯示到畫面上
            NEXT FIELD nmde022                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde022
            #add-point:BEFORE FIELD nmde022 name="construct.b.page4.nmde022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde022
            
            #add-point:AFTER FIELD nmde022 name="construct.a.page4.nmde022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde022_desc
            #add-point:ON ACTION controlp INFIELD nmde022_desc name="construct.c.page4.nmde022_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde022_desc  #顯示到畫面上
            NEXT FIELD nmde022_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde022_desc
            #add-point:BEFORE FIELD nmde022_desc name="construct.b.page4.nmde022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde022_desc
            
            #add-point:AFTER FIELD nmde022_desc name="construct.a.page4.nmde022_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde011
            #add-point:ON ACTION controlp INFIELD nmde011 name="construct.c.page4.nmde011"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde011  #顯示到畫面上
            NEXT FIELD nmde011                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde011
            #add-point:BEFORE FIELD nmde011 name="construct.b.page4.nmde011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde011
            
            #add-point:AFTER FIELD nmde011 name="construct.a.page4.nmde011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde011_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde011_desc
            #add-point:ON ACTION controlp INFIELD nmde011_desc name="construct.c.page4.nmde011_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde011_desc  #顯示到畫面上
            NEXT FIELD nmde011_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde011_desc
            #add-point:BEFORE FIELD nmde011_desc name="construct.b.page4.nmde011_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde011_desc
            
            #add-point:AFTER FIELD nmde011_desc name="construct.a.page4.nmde011_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde013
            #add-point:ON ACTION controlp INFIELD nmde013 name="construct.c.page4.nmde013"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde013  #顯示到畫面上
            NEXT FIELD nmde013                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde013
            #add-point:BEFORE FIELD nmde013 name="construct.b.page4.nmde013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde013
            
            #add-point:AFTER FIELD nmde013 name="construct.a.page4.nmde013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde013_desc
            #add-point:ON ACTION controlp INFIELD nmde013_desc name="construct.c.page4.nmde013_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde013_desc  #顯示到畫面上
            NEXT FIELD nmde013_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde013_desc
            #add-point:BEFORE FIELD nmde013_desc name="construct.b.page4.nmde013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde013_desc
            
            #add-point:AFTER FIELD nmde013_desc name="construct.a.page4.nmde013_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde014
            #add-point:ON ACTION controlp INFIELD nmde014 name="construct.c.page4.nmde014"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde014  #顯示到畫面上
            NEXT FIELD nmde014                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde014
            #add-point:BEFORE FIELD nmde014 name="construct.b.page4.nmde014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde014
            
            #add-point:AFTER FIELD nmde014 name="construct.a.page4.nmde014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde014_desc
            #add-point:ON ACTION controlp INFIELD nmde014_desc name="construct.c.page4.nmde014_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmde014_desc  #顯示到畫面上
            NEXT FIELD nmde014_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde014_desc
            #add-point:BEFORE FIELD nmde014_desc name="construct.b.page4.nmde014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde014_desc
            
            #add-point:AFTER FIELD nmde014_desc name="construct.a.page4.nmde014_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde023
            #add-point:BEFORE FIELD nmde023 name="construct.b.page4.nmde023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde023
            
            #add-point:AFTER FIELD nmde023 name="construct.a.page4.nmde023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde023
            #add-point:ON ACTION controlp INFIELD nmde023 name="construct.c.page4.nmde023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde023_desc
            #add-point:BEFORE FIELD nmde023_desc name="construct.b.page4.nmde023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde023_desc
            
            #add-point:AFTER FIELD nmde023_desc name="construct.a.page4.nmde023_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde023_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde023_desc
            #add-point:ON ACTION controlp INFIELD nmde023_desc name="construct.c.page4.nmde023_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde024
            #add-point:BEFORE FIELD nmde024 name="construct.b.page4.nmde024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde024
            
            #add-point:AFTER FIELD nmde024 name="construct.a.page4.nmde024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde024
            #add-point:ON ACTION controlp INFIELD nmde024 name="construct.c.page4.nmde024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde024_desc
            #add-point:BEFORE FIELD nmde024_desc name="construct.b.page4.nmde024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde024_desc
            
            #add-point:AFTER FIELD nmde024_desc name="construct.a.page4.nmde024_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde024_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde024_desc
            #add-point:ON ACTION controlp INFIELD nmde024_desc name="construct.c.page4.nmde024_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde025
            #add-point:BEFORE FIELD nmde025 name="construct.b.page4.nmde025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde025
            
            #add-point:AFTER FIELD nmde025 name="construct.a.page4.nmde025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde025
            #add-point:ON ACTION controlp INFIELD nmde025 name="construct.c.page4.nmde025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde025_desc
            #add-point:BEFORE FIELD nmde025_desc name="construct.b.page4.nmde025_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde025_desc
            
            #add-point:AFTER FIELD nmde025_desc name="construct.a.page4.nmde025_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde025_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde025_desc
            #add-point:ON ACTION controlp INFIELD nmde025_desc name="construct.c.page4.nmde025_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde026
            #add-point:BEFORE FIELD nmde026 name="construct.b.page4.nmde026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde026
            
            #add-point:AFTER FIELD nmde026 name="construct.a.page4.nmde026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde026
            #add-point:ON ACTION controlp INFIELD nmde026 name="construct.c.page4.nmde026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde026_desc
            #add-point:BEFORE FIELD nmde026_desc name="construct.b.page4.nmde026_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde026_desc
            
            #add-point:AFTER FIELD nmde026_desc name="construct.a.page4.nmde026_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde026_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde026_desc
            #add-point:ON ACTION controlp INFIELD nmde026_desc name="construct.c.page4.nmde026_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde027
            #add-point:BEFORE FIELD nmde027 name="construct.b.page4.nmde027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde027
            
            #add-point:AFTER FIELD nmde027 name="construct.a.page4.nmde027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde027
            #add-point:ON ACTION controlp INFIELD nmde027 name="construct.c.page4.nmde027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde027_desc
            #add-point:BEFORE FIELD nmde027_desc name="construct.b.page4.nmde027_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde027_desc
            
            #add-point:AFTER FIELD nmde027_desc name="construct.a.page4.nmde027_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde027_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde027_desc
            #add-point:ON ACTION controlp INFIELD nmde027_desc name="construct.c.page4.nmde027_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde028
            #add-point:BEFORE FIELD nmde028 name="construct.b.page4.nmde028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde028
            
            #add-point:AFTER FIELD nmde028 name="construct.a.page4.nmde028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde028
            #add-point:ON ACTION controlp INFIELD nmde028 name="construct.c.page4.nmde028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde028_desc
            #add-point:BEFORE FIELD nmde028_desc name="construct.b.page4.nmde028_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde028_desc
            
            #add-point:AFTER FIELD nmde028_desc name="construct.a.page4.nmde028_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde028_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde028_desc
            #add-point:ON ACTION controlp INFIELD nmde028_desc name="construct.c.page4.nmde028_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde029
            #add-point:BEFORE FIELD nmde029 name="construct.b.page4.nmde029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde029
            
            #add-point:AFTER FIELD nmde029 name="construct.a.page4.nmde029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde029
            #add-point:ON ACTION controlp INFIELD nmde029 name="construct.c.page4.nmde029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde029_desc
            #add-point:BEFORE FIELD nmde029_desc name="construct.b.page4.nmde029_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde029_desc
            
            #add-point:AFTER FIELD nmde029_desc name="construct.a.page4.nmde029_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde029_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde029_desc
            #add-point:ON ACTION controlp INFIELD nmde029_desc name="construct.c.page4.nmde029_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde030
            #add-point:BEFORE FIELD nmde030 name="construct.b.page4.nmde030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde030
            
            #add-point:AFTER FIELD nmde030 name="construct.a.page4.nmde030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde030
            #add-point:ON ACTION controlp INFIELD nmde030 name="construct.c.page4.nmde030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde030_desc
            #add-point:BEFORE FIELD nmde030_desc name="construct.b.page4.nmde030_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde030_desc
            
            #add-point:AFTER FIELD nmde030_desc name="construct.a.page4.nmde030_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde030_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde030_desc
            #add-point:ON ACTION controlp INFIELD nmde030_desc name="construct.c.page4.nmde030_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde031
            #add-point:BEFORE FIELD nmde031 name="construct.b.page4.nmde031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde031
            
            #add-point:AFTER FIELD nmde031 name="construct.a.page4.nmde031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde031
            #add-point:ON ACTION controlp INFIELD nmde031 name="construct.c.page4.nmde031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde031_desc
            #add-point:BEFORE FIELD nmde031_desc name="construct.b.page4.nmde031_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde031_desc
            
            #add-point:AFTER FIELD nmde031_desc name="construct.a.page4.nmde031_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde031_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde031_desc
            #add-point:ON ACTION controlp INFIELD nmde031_desc name="construct.c.page4.nmde031_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde032
            #add-point:BEFORE FIELD nmde032 name="construct.b.page4.nmde032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde032
            
            #add-point:AFTER FIELD nmde032 name="construct.a.page4.nmde032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde032
            #add-point:ON ACTION controlp INFIELD nmde032 name="construct.c.page4.nmde032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde032_desc
            #add-point:BEFORE FIELD nmde032_desc name="construct.b.page4.nmde032_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde032_desc
            
            #add-point:AFTER FIELD nmde032_desc name="construct.a.page4.nmde032_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.nmde032_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde032_desc
            #add-point:ON ACTION controlp INFIELD nmde032_desc name="construct.c.page4.nmde032_desc"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      
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
 
{<section id="anmt820.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION anmt820_filter()
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
      CONSTRUCT g_wc_filter ON nmdeld,nmde001,nmde002
                          FROM s_browse[1].b_nmdeld,s_browse[1].b_nmde001,s_browse[1].b_nmde002
 
         BEFORE CONSTRUCT
               DISPLAY anmt820_filter_parser('nmdeld') TO s_browse[1].b_nmdeld
            DISPLAY anmt820_filter_parser('nmde001') TO s_browse[1].b_nmde001
            DISPLAY anmt820_filter_parser('nmde002') TO s_browse[1].b_nmde002
      
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
 
      CALL anmt820_filter_show('nmdeld')
   CALL anmt820_filter_show('nmde001')
   CALL anmt820_filter_show('nmde002')
 
END FUNCTION
 
{</section>}
 
{<section id="anmt820.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION anmt820_filter_parser(ps_field)
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
 
{<section id="anmt820.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION anmt820_filter_show(ps_field)
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
   LET ls_condition = anmt820_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="anmt820.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION anmt820_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
   
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
   CALL g_nmde_d.clear()
   CALL g_nmde2_d.clear()
   CALL g_nmde3_d.clear()
   CALL g_nmde4_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL anmt820_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL anmt820_browser_fill(g_wc)
      CALL anmt820_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL anmt820_browser_fill("F")
   
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
      CALL anmt820_fetch("F") 
   END IF
   
   CALL anmt820_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION anmt820_fetch(p_flag)
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
   
   LET g_nmde_m.nmdeld = g_browser[g_current_idx].b_nmdeld
   LET g_nmde_m.nmde001 = g_browser[g_current_idx].b_nmde001
   LET g_nmde_m.nmde002 = g_browser[g_current_idx].b_nmde002
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE anmt820_master_referesh USING g_nmde_m.nmdeld,g_nmde_m.nmde001,g_nmde_m.nmde002 INTO g_nmde_m.nmdesite, 
       g_nmde_m.nmdecomp,g_nmde_m.nmdeld,g_nmde_m.nmdedocdt,g_nmde_m.nmde017,g_nmde_m.nmde001,g_nmde_m.nmde002, 
       g_nmde_m.nmdedocno,g_nmde_m.nmdesite_desc,g_nmde_m.nmdecomp_desc,g_nmde_m.nmdeld_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "nmde_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_nmde_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_nmde_m_mask_o.* =  g_nmde_m.*
   CALL anmt820_nmde_t_mask()
   LET g_nmde_m_mask_n.* =  g_nmde_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt820_set_act_visible()
   CALL anmt820_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_nmde_m_t.* = g_nmde_m.*
   LET g_nmde_m_o.* = g_nmde_m.*
   
   #重新顯示   
   CALL anmt820_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="anmt820.insert" >}
#+ 資料新增
PRIVATE FUNCTION anmt820_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_nmde_d.clear()
   CALL g_nmde2_d.clear()
   CALL g_nmde3_d.clear()
   CALL g_nmde4_d.clear()
 
 
   INITIALIZE g_nmde_m.* TO NULL             #DEFAULT 設定
   LET g_nmdeld_t = NULL
   LET g_nmde001_t = NULL
   LET g_nmde002_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL anmt820_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_nmde_m.* TO NULL
         INITIALIZE g_nmde_d TO NULL
         INITIALIZE g_nmde2_d TO NULL
         INITIALIZE g_nmde3_d TO NULL
         INITIALIZE g_nmde4_d TO NULL
 
         CALL anmt820_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_nmde_m.* = g_nmde_m_t.*
         CALL anmt820_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_nmde_d.clear()
      #CALL g_nmde2_d.clear()
      #CALL g_nmde3_d.clear()
      #CALL g_nmde4_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt820_set_act_visible()
   CALL anmt820_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_nmdeld_t = g_nmde_m.nmdeld
   LET g_nmde001_t = g_nmde_m.nmde001
   LET g_nmde002_t = g_nmde_m.nmde002
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmdeent = " ||g_enterprise|| " AND",
                      " nmdeld = '", g_nmde_m.nmdeld, "' "
                      ," AND nmde001 = '", g_nmde_m.nmde001, "' "
                      ," AND nmde002 = '", g_nmde_m.nmde002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt820_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL anmt820_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE anmt820_master_referesh USING g_nmde_m.nmdeld,g_nmde_m.nmde001,g_nmde_m.nmde002 INTO g_nmde_m.nmdesite, 
       g_nmde_m.nmdecomp,g_nmde_m.nmdeld,g_nmde_m.nmdedocdt,g_nmde_m.nmde017,g_nmde_m.nmde001,g_nmde_m.nmde002, 
       g_nmde_m.nmdedocno,g_nmde_m.nmdesite_desc,g_nmde_m.nmdecomp_desc,g_nmde_m.nmdeld_desc
   
   #遮罩相關處理
   LET g_nmde_m_mask_o.* =  g_nmde_m.*
   CALL anmt820_nmde_t_mask()
   LET g_nmde_m_mask_n.* =  g_nmde_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmde_m.nmdesite,g_nmde_m.nmdesite_desc,g_nmde_m.nmdecomp,g_nmde_m.nmdecomp_desc, 
       g_nmde_m.nmde001_i,g_nmde_m.nmde002_i,g_nmde_m.nmdeld,g_nmde_m.nmdeld_desc,g_nmde_m.nmdedocdt, 
       g_nmde_m.nmde017,g_nmde_m.nmde001,g_nmde_m.nmde002,g_nmde_m.nmdedocno
   
   #功能已完成,通報訊息中心
   CALL anmt820_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820.modify" >}
#+ 資料修改
PRIVATE FUNCTION anmt820_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE  l_success       LIKE type_t.num5 #160326-00001#25 add
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   #160326-00001#25--add--str--
   IF g_nmde_m.nmdeld IS NULL
   OR g_nmde_m.nmde001 IS NULL
   OR g_nmde_m.nmde002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   SELECT nmdecomp,nmdedocdt,nmde017 INTO g_nmde_m.nmdecomp,g_nmde_m.nmdedocdt,g_nmde_m.nmde017 #160326-00001#25 add nmde017
     FROM nmde_t
    WHERE nmdeent=g_enterprise AND nmdeld=g_nmde_m.nmdeld
      AND nmde001=g_nmde_m.nmde001 AND nmde002=g_nmde_m.nmde002
   #檢查當單據日期小於等於關帳日期時，不可異動單據
   CALL s_fin_date_close_chk('',g_nmde_m.nmdecomp,'ANM',g_nmde_m.nmdedocdt) RETURNING l_success
   IF l_success = FALSE THEN
      RETURN
   END IF
   
   #已抛转凭证不可删除
   IF NOT cl_null(g_nmde_m.nmde017) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "anm-00082" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   #160326-00001#25--add--end
   #end add-point
   
   IF g_nmde_m.nmdeld IS NULL
   OR g_nmde_m.nmde001 IS NULL
   OR g_nmde_m.nmde002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_nmdeld_t = g_nmde_m.nmdeld
   LET g_nmde001_t = g_nmde_m.nmde001
   LET g_nmde002_t = g_nmde_m.nmde002
 
   CALL s_transaction_begin()
   
   OPEN anmt820_cl USING g_enterprise,g_nmde_m.nmdeld,g_nmde_m.nmde001,g_nmde_m.nmde002
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt820_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE anmt820_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt820_master_referesh USING g_nmde_m.nmdeld,g_nmde_m.nmde001,g_nmde_m.nmde002 INTO g_nmde_m.nmdesite, 
       g_nmde_m.nmdecomp,g_nmde_m.nmdeld,g_nmde_m.nmdedocdt,g_nmde_m.nmde017,g_nmde_m.nmde001,g_nmde_m.nmde002, 
       g_nmde_m.nmdedocno,g_nmde_m.nmdesite_desc,g_nmde_m.nmdecomp_desc,g_nmde_m.nmdeld_desc
   
   #遮罩相關處理
   LET g_nmde_m_mask_o.* =  g_nmde_m.*
   CALL anmt820_nmde_t_mask()
   LET g_nmde_m_mask_n.* =  g_nmde_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL anmt820_show()
   WHILE TRUE
      LET g_nmdeld_t = g_nmde_m.nmdeld
      LET g_nmde001_t = g_nmde_m.nmde001
      LET g_nmde002_t = g_nmde_m.nmde002
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL anmt820_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_nmde_m.* = g_nmde_m_t.*
         CALL anmt820_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_nmde_m.nmdeld != g_nmdeld_t 
      OR g_nmde_m.nmde001 != g_nmde001_t 
      OR g_nmde_m.nmde002 != g_nmde002_t 
 
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
   CALL anmt820_set_act_visible()
   CALL anmt820_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " nmdeent = " ||g_enterprise|| " AND",
                      " nmdeld = '", g_nmde_m.nmdeld, "' "
                      ," AND nmde001 = '", g_nmde_m.nmde001, "' "
                      ," AND nmde002 = '", g_nmde_m.nmde002, "' "
 
   #填到對應位置
   CALL anmt820_browser_fill("")
 
   CALL anmt820_idx_chk()
 
   CLOSE anmt820_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmt820_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="anmt820.input" >}
#+ 資料輸入
PRIVATE FUNCTION anmt820_input(p_cmd)
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
   DEFINE l_glaa121              LIKE glaa_t.glaa121
   DEFINE l_success              LIKE type_t.num5
   #160326-00001#25--add--str--
   #161128-00061#2---modify----begin----------
   #DEFINE l_glad                 RECORD LIKE glad_t.* 
   DEFINE l_glad RECORD  #帳套科目管理設定檔
       gladent LIKE glad_t.gladent, #企業編號
       gladownid LIKE glad_t.gladownid, #資料所有者
       gladowndp LIKE glad_t.gladowndp, #資料所屬部門
       gladcrtid LIKE glad_t.gladcrtid, #資料建立者
       gladcrtdp LIKE glad_t.gladcrtdp, #資料建立部門
       gladcrtdt LIKE glad_t.gladcrtdt, #資料創建日
       gladmodid LIKE glad_t.gladmodid, #資料修改者
       gladmoddt LIKE glad_t.gladmoddt, #最近修改日
       gladstus LIKE glad_t.gladstus, #狀態碼
       gladld LIKE glad_t.gladld, #帳套
       glad001 LIKE glad_t.glad001, #會計科目編號
       glad002 LIKE glad_t.glad002, #是否按餘額類型產生分錄
       glad003 LIKE glad_t.glad003, #啟用傳票項次細項立沖
       glad004 LIKE glad_t.glad004, #傳票項次異動別
       glad005 LIKE glad_t.glad005, #是否啟用數量金額式
       glad006 LIKE glad_t.glad006, #借方現金變動碼
       glad007 LIKE glad_t.glad007, #啟用部門管理
       glad008 LIKE glad_t.glad008, #啟用利潤成本管理
       glad009 LIKE glad_t.glad009, #啟用區域管理
       glad010 LIKE glad_t.glad010, #啟用收付款客商管理
       glad011 LIKE glad_t.glad011, #啟用客群管理
       glad012 LIKE glad_t.glad012, #啟用產品類別管理
       glad013 LIKE glad_t.glad013, #啟用人員管理
       glad014 LIKE glad_t.glad014, #no use
       glad015 LIKE glad_t.glad015, #啟用專案管理
       glad016 LIKE glad_t.glad016, #啟用WBS管理
       glad017 LIKE glad_t.glad017, #啟用自由核算項一
       glad0171 LIKE glad_t.glad0171, #自由核算項一類型編號
       glad0172 LIKE glad_t.glad0172, #自由核算項一控制方式
       glad018 LIKE glad_t.glad018, #啟用自由核算項二
       glad0181 LIKE glad_t.glad0181, #自由核算項二類型編號
       glad0182 LIKE glad_t.glad0182, #自由核算項二控制方式
       glad019 LIKE glad_t.glad019, #啟用自由核算項三
       glad0191 LIKE glad_t.glad0191, #自由核算項三類型編號
       glad0192 LIKE glad_t.glad0192, #自由核算項三控制方式
       glad020 LIKE glad_t.glad020, #啟用自由核算項四
       glad0201 LIKE glad_t.glad0201, #自由核算項四類型編號
       glad0202 LIKE glad_t.glad0202, #自由核算項四控制方式
       glad021 LIKE glad_t.glad021, #啟用自由核算項五
       glad0211 LIKE glad_t.glad0211, #自由核算項五類型編號
       glad0212 LIKE glad_t.glad0212, #自由核算項五控制方式
       glad022 LIKE glad_t.glad022, #啟用自由核算項六
       glad0221 LIKE glad_t.glad0221, #自由核算項六類型編號
       glad0222 LIKE glad_t.glad0222, #自由核算項六控制方式
       glad023 LIKE glad_t.glad023, #啟用自由核算項七
       glad0231 LIKE glad_t.glad0231, #自由核算項七類型編號
       glad0232 LIKE glad_t.glad0232, #自由核算項七控制方式
       glad024 LIKE glad_t.glad024, #啟用自由核算項八
       glad0241 LIKE glad_t.glad0241, #自由核算項八類型編號
       glad0242 LIKE glad_t.glad0242, #自由核算項八控制方式
       glad025 LIKE glad_t.glad025, #啟用自由核算項九
       glad0251 LIKE glad_t.glad0251, #自由核算項九類型編號
       glad0252 LIKE glad_t.glad0252, #自由核算項九控制方式
       glad026 LIKE glad_t.glad026, #啟用自由核算項十
       glad0261 LIKE glad_t.glad0261, #自由核算項十類型編號
       glad0262 LIKE glad_t.glad0262, #自由核算項十控制方式
       glad027 LIKE glad_t.glad027, #啟用帳款客商管理
       glad030 LIKE glad_t.glad030, #是否進行預算管控
       glad031 LIKE glad_t.glad031, #啟用經營方式管理
       glad032 LIKE glad_t.glad032, #啟用渠道管理
       glad033 LIKE glad_t.glad033, #啟用品牌管理
       glad034 LIKE glad_t.glad034, #科目做多幣別管理
       glad035 LIKE glad_t.glad035, #是否是子系統科目
       glad036 LIKE glad_t.glad036  #貸方現金變動碼
       END RECORD

   #161128-00061#2---modify----end----------
   DEFINE l_glae002              LIKE glae_t.glae002
   DEFINE l_glae009              LIKE glae_t.glae009
   DEFINE l_errno                LIKE type_t.chr80
   #160326-00001#25--add--end
   #161221-00054#3 add s---
   DEFINE l_wc                   STRING
   DEFINE l_glak_sql             STRING
   #161221-00054#3 add e---    
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
   DISPLAY BY NAME g_nmde_m.nmdesite,g_nmde_m.nmdesite_desc,g_nmde_m.nmdecomp,g_nmde_m.nmdecomp_desc, 
       g_nmde_m.nmde001_i,g_nmde_m.nmde002_i,g_nmde_m.nmdeld,g_nmde_m.nmdeld_desc,g_nmde_m.nmdedocdt, 
       g_nmde_m.nmde017,g_nmde_m.nmde001,g_nmde_m.nmde002,g_nmde_m.nmdedocno
   
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
   LET g_forupd_sql = "SELECT nmde005,nmde004,nmde100,nmde101,nmde102,nmde103,nmde104,nmde105,nmde106, 
       nmde004,nmde005,nmde100,nmde111,nmde102,nmde113,nmde114,nmde115,nmde116,nmde004,nmde005,nmde100, 
       nmde121,nmde102,nmde123,nmde124,nmde125,nmde126,nmde004,nmde015,nmde033,nmde006,nmde007,nmde008, 
       nmde018,nmde019,nmde009,nmde010,nmde020,nmde021,nmde022,nmde011,nmde013,nmde014,nmde023,nmde024, 
       nmde025,nmde026,nmde027,nmde028,nmde029,nmde030,nmde031,nmde032 FROM nmde_t WHERE nmdeent=? AND  
       nmdeld=? AND nmde001=? AND nmde002=? AND nmde004=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt820_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL anmt820_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL anmt820_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_nmde_m.nmdesite,g_nmde_m.nmdecomp,g_nmde_m.nmde001_i,g_nmde_m.nmde002_i,g_nmde_m.nmdeld, 
       g_nmde_m.nmdedocdt,g_nmde_m.nmde017,g_nmde_m.nmde001,g_nmde_m.nmde002,g_nmde_m.nmdedocno
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   #品类管理层级aoos010
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING g_ooaa002 #160326-00001#25 add
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="anmt820.input.head" >}
   
      #單頭段
      INPUT BY NAME g_nmde_m.nmdesite,g_nmde_m.nmdecomp,g_nmde_m.nmde001_i,g_nmde_m.nmde002_i,g_nmde_m.nmdeld, 
          g_nmde_m.nmdedocdt,g_nmde_m.nmde017,g_nmde_m.nmde001,g_nmde_m.nmde002,g_nmde_m.nmdedocno 
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
         AFTER FIELD nmdesite
            
            #add-point:AFTER FIELD nmdesite name="input.a.nmdesite"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmde_m.nmdesite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmde_m.nmdesite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmde_m.nmdesite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdesite
            #add-point:BEFORE FIELD nmdesite name="input.b.nmdesite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdesite
            #add-point:ON CHANGE nmdesite name="input.g.nmdesite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdecomp
            
            #add-point:AFTER FIELD nmdecomp name="input.a.nmdecomp"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmde_m.nmdecomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmde_m.nmdecomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmde_m.nmdecomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdecomp
            #add-point:BEFORE FIELD nmdecomp name="input.b.nmdecomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdecomp
            #add-point:ON CHANGE nmdecomp name="input.g.nmdecomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde001_i
            #add-point:BEFORE FIELD nmde001_i name="input.b.nmde001_i"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde001_i
            
            #add-point:AFTER FIELD nmde001_i name="input.a.nmde001_i"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde001_i
            #add-point:ON CHANGE nmde001_i name="input.g.nmde001_i"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde002_i
            #add-point:BEFORE FIELD nmde002_i name="input.b.nmde002_i"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde002_i
            
            #add-point:AFTER FIELD nmde002_i name="input.a.nmde002_i"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde002_i
            #add-point:ON CHANGE nmde002_i name="input.g.nmde002_i"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdeld
            
            #add-point:AFTER FIELD nmdeld name="input.a.nmdeld"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmde_m.nmdeld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmde_m.nmdeld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmde_m.nmdeld_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_nmde_m.nmdeld) AND NOT cl_null(g_nmde_m.nmde001) AND NOT cl_null(g_nmde_m.nmde002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmde_m.nmdeld != g_nmdeld_t  OR g_nmde_m.nmde001 != g_nmde001_t  OR g_nmde_m.nmde002 != g_nmde002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmde_t WHERE "||"nmdeent = '" ||g_enterprise|| "' AND "||"nmdeld = '"||g_nmde_m.nmdeld ||"' AND "|| "nmde001 = '"||g_nmde_m.nmde001 ||"' AND "|| "nmde002 = '"||g_nmde_m.nmde002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdeld
            #add-point:BEFORE FIELD nmdeld name="input.b.nmdeld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdeld
            #add-point:ON CHANGE nmdeld name="input.g.nmdeld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdedocdt
            #add-point:BEFORE FIELD nmdedocdt name="input.b.nmdedocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdedocdt
            
            #add-point:AFTER FIELD nmdedocdt name="input.a.nmdedocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdedocdt
            #add-point:ON CHANGE nmdedocdt name="input.g.nmdedocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde017
            #add-point:BEFORE FIELD nmde017 name="input.b.nmde017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde017
            
            #add-point:AFTER FIELD nmde017 name="input.a.nmde017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde017
            #add-point:ON CHANGE nmde017 name="input.g.nmde017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde001
            #add-point:BEFORE FIELD nmde001 name="input.b.nmde001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde001
            
            #add-point:AFTER FIELD nmde001 name="input.a.nmde001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_nmde_m.nmdeld) AND NOT cl_null(g_nmde_m.nmde001) AND NOT cl_null(g_nmde_m.nmde002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmde_m.nmdeld != g_nmdeld_t  OR g_nmde_m.nmde001 != g_nmde001_t  OR g_nmde_m.nmde002 != g_nmde002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmde_t WHERE "||"nmdeent = '" ||g_enterprise|| "' AND "||"nmdeld = '"||g_nmde_m.nmdeld ||"' AND "|| "nmde001 = '"||g_nmde_m.nmde001 ||"' AND "|| "nmde002 = '"||g_nmde_m.nmde002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde001
            #add-point:ON CHANGE nmde001 name="input.g.nmde001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde002
            #add-point:BEFORE FIELD nmde002 name="input.b.nmde002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde002
            
            #add-point:AFTER FIELD nmde002 name="input.a.nmde002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_nmde_m.nmdeld) AND NOT cl_null(g_nmde_m.nmde001) AND NOT cl_null(g_nmde_m.nmde002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmde_m.nmdeld != g_nmdeld_t  OR g_nmde_m.nmde001 != g_nmde001_t  OR g_nmde_m.nmde002 != g_nmde002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmde_t WHERE "||"nmdeent = '" ||g_enterprise|| "' AND "||"nmdeld = '"||g_nmde_m.nmdeld ||"' AND "|| "nmde001 = '"||g_nmde_m.nmde001 ||"' AND "|| "nmde002 = '"||g_nmde_m.nmde002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde002
            #add-point:ON CHANGE nmde002 name="input.g.nmde002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdedocno
            #add-point:BEFORE FIELD nmdedocno name="input.b.nmdedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdedocno
            
            #add-point:AFTER FIELD nmdedocno name="input.a.nmdedocno"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdedocno
            #add-point:ON CHANGE nmdedocno name="input.g.nmdedocno"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.nmdesite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdesite
            #add-point:ON ACTION controlp INFIELD nmdesite name="input.c.nmdesite"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmdecomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdecomp
            #add-point:ON ACTION controlp INFIELD nmdecomp name="input.c.nmdecomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmde001_i
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde001_i
            #add-point:ON ACTION controlp INFIELD nmde001_i name="input.c.nmde001_i"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmde002_i
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde002_i
            #add-point:ON ACTION controlp INFIELD nmde002_i name="input.c.nmde002_i"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmdeld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdeld
            #add-point:ON ACTION controlp INFIELD nmdeld name="input.c.nmdeld"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmdedocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdedocdt
            #add-point:ON ACTION controlp INFIELD nmdedocdt name="input.c.nmdedocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmde017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde017
            #add-point:ON ACTION controlp INFIELD nmde017 name="input.c.nmde017"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmde001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde001
            #add-point:ON ACTION controlp INFIELD nmde001 name="input.c.nmde001"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmde002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde002
            #add-point:ON ACTION controlp INFIELD nmde002 name="input.c.nmde002"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmdedocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdedocno
            #add-point:ON ACTION controlp INFIELD nmdedocno name="input.c.nmdedocno"
            
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
            DISPLAY BY NAME g_nmde_m.nmdeld             
                            ,g_nmde_m.nmde001   
                            ,g_nmde_m.nmde002   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL anmt820_nmde_t_mask_restore('restore_mask_o')
            
               UPDATE nmde_t SET (nmdesite,nmdecomp,nmdeld,nmdedocdt,nmde017,nmde001,nmde002,nmdedocno) = (g_nmde_m.nmdesite, 
                   g_nmde_m.nmdecomp,g_nmde_m.nmdeld,g_nmde_m.nmdedocdt,g_nmde_m.nmde017,g_nmde_m.nmde001, 
                   g_nmde_m.nmde002,g_nmde_m.nmdedocno)
                WHERE nmdeent = g_enterprise AND nmdeld = g_nmdeld_t
                  AND nmde001 = g_nmde001_t
                  AND nmde002 = g_nmde002_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmde_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmde_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmde_m.nmdeld
               LET gs_keys_bak[1] = g_nmdeld_t
               LET gs_keys[2] = g_nmde_m.nmde001
               LET gs_keys_bak[2] = g_nmde001_t
               LET gs_keys[3] = g_nmde_m.nmde002
               LET gs_keys_bak[3] = g_nmde002_t
               LET gs_keys[4] = g_nmde_d[g_detail_idx].nmde004
               LET gs_keys_bak[4] = g_nmde_d_t.nmde004
               CALL anmt820_update_b('nmde_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_nmde_m_t)
                     #LET g_log2 = util.JSON.stringify(g_nmde_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL anmt820_nmde_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL anmt820_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_nmdeld_t = g_nmde_m.nmdeld
           LET g_nmde001_t = g_nmde_m.nmde001
           LET g_nmde002_t = g_nmde_m.nmde002
 
           
           IF g_nmde_d.getLength() = 0 THEN
              NEXT FIELD nmde004
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="anmt820.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_nmde_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_nmde_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL anmt820_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
            NEXT FIELD nmde033 #160326-00001#25 add
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
            CALL anmt820_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN anmt820_cl USING g_enterprise,g_nmde_m.nmdeld,g_nmde_m.nmde001,g_nmde_m.nmde002                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE anmt820_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN anmt820_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_nmde_d[l_ac].nmde004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_nmde_d_t.* = g_nmde_d[l_ac].*  #BACKUP
               LET g_nmde_d_o.* = g_nmde_d[l_ac].*  #BACKUP
               CALL anmt820_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL anmt820_set_no_entry_b(l_cmd)
               OPEN anmt820_bcl USING g_enterprise,g_nmde_m.nmdeld,
                                                g_nmde_m.nmde001,
                                                g_nmde_m.nmde002,
 
                                                g_nmde_d_t.nmde004
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN anmt820_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt820_bcl INTO g_nmde_d[l_ac].nmde005,g_nmde_d[l_ac].nmde004,g_nmde_d[l_ac].nmde100, 
                      g_nmde_d[l_ac].nmde101,g_nmde_d[l_ac].nmde102,g_nmde_d[l_ac].nmde103,g_nmde_d[l_ac].nmde104, 
                      g_nmde_d[l_ac].nmde105,g_nmde_d[l_ac].nmde106,g_nmde2_d[l_ac].nmde004,g_nmde2_d[l_ac].nmde005, 
                      g_nmde2_d[l_ac].nmde100,g_nmde2_d[l_ac].nmde111,g_nmde2_d[l_ac].nmde102,g_nmde2_d[l_ac].nmde113, 
                      g_nmde2_d[l_ac].nmde114,g_nmde2_d[l_ac].nmde115,g_nmde2_d[l_ac].nmde116,g_nmde3_d[l_ac].nmde004, 
                      g_nmde3_d[l_ac].nmde005,g_nmde3_d[l_ac].nmde100,g_nmde3_d[l_ac].nmde121,g_nmde3_d[l_ac].nmde102, 
                      g_nmde3_d[l_ac].nmde123,g_nmde3_d[l_ac].nmde124,g_nmde3_d[l_ac].nmde125,g_nmde3_d[l_ac].nmde126, 
                      g_nmde4_d[l_ac].nmde004,g_nmde4_d[l_ac].nmde015,g_nmde4_d[l_ac].nmde033,g_nmde4_d[l_ac].nmde006, 
                      g_nmde4_d[l_ac].nmde007,g_nmde4_d[l_ac].nmde008,g_nmde4_d[l_ac].nmde018,g_nmde4_d[l_ac].nmde019, 
                      g_nmde4_d[l_ac].nmde009,g_nmde4_d[l_ac].nmde010,g_nmde4_d[l_ac].nmde020,g_nmde4_d[l_ac].nmde021, 
                      g_nmde4_d[l_ac].nmde022,g_nmde4_d[l_ac].nmde011,g_nmde4_d[l_ac].nmde013,g_nmde4_d[l_ac].nmde014, 
                      g_nmde4_d[l_ac].nmde023,g_nmde4_d[l_ac].nmde024,g_nmde4_d[l_ac].nmde025,g_nmde4_d[l_ac].nmde026, 
                      g_nmde4_d[l_ac].nmde027,g_nmde4_d[l_ac].nmde028,g_nmde4_d[l_ac].nmde029,g_nmde4_d[l_ac].nmde030, 
                      g_nmde4_d[l_ac].nmde031,g_nmde4_d[l_ac].nmde032
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_nmde_d_t.nmde004,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmde_d_mask_o[l_ac].* =  g_nmde_d[l_ac].*
                  CALL anmt820_nmde_t_mask()
                  LET g_nmde_d_mask_n[l_ac].* =  g_nmde_d[l_ac].*
                  
                  CALL anmt820_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            #161221-00054#3 add s---
            LET l_wc = g_nmde4_d[l_ac].nmde015
            CALL s_fin_get_wc_str(l_wc) RETURNING l_wc            
            #161221-00054#3 add e---             
            #end add-point  
            
 
 
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_nmde_d_t.* TO NULL
            INITIALIZE g_nmde_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_nmde_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_nmde_d[l_ac].nmde102 = "0"
      LET g_nmde_d[l_ac].nmde103 = "0"
      LET g_nmde_d[l_ac].nmde104 = "0"
      LET g_nmde_d[l_ac].nmde105 = "0"
      LET g_nmde_d[l_ac].nmde106 = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_nmde_d_t.* = g_nmde_d[l_ac].*     #新輸入資料
            LET g_nmde_d_o.* = g_nmde_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt820_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL anmt820_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmde_d[li_reproduce_target].* = g_nmde_d[li_reproduce].*
               LET g_nmde2_d[li_reproduce_target].* = g_nmde2_d[li_reproduce].*
               LET g_nmde3_d[li_reproduce_target].* = g_nmde3_d[li_reproduce].*
               LET g_nmde4_d[li_reproduce_target].* = g_nmde4_d[li_reproduce].*
 
               LET g_nmde_d[g_nmde_d.getLength()].nmde004 = NULL
 
            END IF
            
 
 
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            
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
            SELECT COUNT(1) INTO l_count FROM nmde_t 
             WHERE nmdeent = g_enterprise AND nmdeld = g_nmde_m.nmdeld
               AND nmde001 = g_nmde_m.nmde001
               AND nmde002 = g_nmde_m.nmde002
 
               AND nmde004 = g_nmde_d[l_ac].nmde004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO nmde_t
                           (nmdeent,
                            nmdesite,nmdecomp,nmdeld,nmdedocdt,nmde017,nmde001,nmde002,nmdedocno,
                            nmde004
                            ,nmde005,nmde100,nmde101,nmde102,nmde103,nmde104,nmde105,nmde106,nmde005,nmde100,nmde111,nmde102,nmde113,nmde114,nmde115,nmde116,nmde005,nmde100,nmde121,nmde102,nmde123,nmde124,nmde125,nmde126,nmde015,nmde033,nmde006,nmde007,nmde008,nmde018,nmde019,nmde009,nmde010,nmde020,nmde021,nmde022,nmde011,nmde013,nmde014,nmde023,nmde024,nmde025,nmde026,nmde027,nmde028,nmde029,nmde030,nmde031,nmde032) 
                     VALUES(g_enterprise,
                            g_nmde_m.nmdesite,g_nmde_m.nmdecomp,g_nmde_m.nmdeld,g_nmde_m.nmdedocdt,g_nmde_m.nmde017,g_nmde_m.nmde001,g_nmde_m.nmde002,g_nmde_m.nmdedocno,
                            g_nmde_d[l_ac].nmde004
                            ,g_nmde_d[l_ac].nmde005,g_nmde_d[l_ac].nmde100,g_nmde_d[l_ac].nmde101,g_nmde_d[l_ac].nmde102, 
                                g_nmde_d[l_ac].nmde103,g_nmde_d[l_ac].nmde104,g_nmde_d[l_ac].nmde105, 
                                g_nmde_d[l_ac].nmde106,g_nmde_d[l_ac].nmde005,g_nmde_d[l_ac].nmde100, 
                                g_nmde2_d[l_ac].nmde111,g_nmde_d[l_ac].nmde102,g_nmde2_d[l_ac].nmde113, 
                                g_nmde2_d[l_ac].nmde114,g_nmde2_d[l_ac].nmde115,g_nmde2_d[l_ac].nmde116, 
                                g_nmde_d[l_ac].nmde005,g_nmde_d[l_ac].nmde100,g_nmde3_d[l_ac].nmde121, 
                                g_nmde_d[l_ac].nmde102,g_nmde3_d[l_ac].nmde123,g_nmde3_d[l_ac].nmde124, 
                                g_nmde3_d[l_ac].nmde125,g_nmde3_d[l_ac].nmde126,g_nmde4_d[l_ac].nmde015, 
                                g_nmde4_d[l_ac].nmde033,g_nmde4_d[l_ac].nmde006,g_nmde4_d[l_ac].nmde007, 
                                g_nmde4_d[l_ac].nmde008,g_nmde4_d[l_ac].nmde018,g_nmde4_d[l_ac].nmde019, 
                                g_nmde4_d[l_ac].nmde009,g_nmde4_d[l_ac].nmde010,g_nmde4_d[l_ac].nmde020, 
                                g_nmde4_d[l_ac].nmde021,g_nmde4_d[l_ac].nmde022,g_nmde4_d[l_ac].nmde011, 
                                g_nmde4_d[l_ac].nmde013,g_nmde4_d[l_ac].nmde014,g_nmde4_d[l_ac].nmde023, 
                                g_nmde4_d[l_ac].nmde024,g_nmde4_d[l_ac].nmde025,g_nmde4_d[l_ac].nmde026, 
                                g_nmde4_d[l_ac].nmde027,g_nmde4_d[l_ac].nmde028,g_nmde4_d[l_ac].nmde029, 
                                g_nmde4_d[l_ac].nmde030,g_nmde4_d[l_ac].nmde031,g_nmde4_d[l_ac].nmde032) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_nmde_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "nmde_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert"
               
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
               IF anmt820_before_delete() THEN 
                  
 
 
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_nmde_m.nmdeld
                  LET gs_keys[gs_keys.getLength()+1] = g_nmde_m.nmde001
                  LET gs_keys[gs_keys.getLength()+1] = g_nmde_m.nmde002
 
                  LET gs_keys[gs_keys.getLength()+1] = g_nmde_d_t.nmde004
 
 
                  #刪除下層單身
                  IF NOT anmt820_key_delete_b(gs_keys,'nmde_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE anmt820_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE anmt820_bcl
               LET l_count = g_nmde_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_nmde_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde005
            #add-point:BEFORE FIELD nmde005 name="input.b.page1.nmde005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde005
            
            #add-point:AFTER FIELD nmde005 name="input.a.page1.nmde005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde005
            #add-point:ON CHANGE nmde005 name="input.g.page1.nmde005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde004
            #add-point:BEFORE FIELD nmde004 name="input.b.page1.nmde004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde004
            
            #add-point:AFTER FIELD nmde004 name="input.a.page1.nmde004"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_nmde_m.nmdeld IS NOT NULL AND g_nmde_m.nmde001 IS NOT NULL AND g_nmde_m.nmde002 IS NOT NULL AND g_nmde_d[g_detail_idx].nmde004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmde_m.nmdeld != g_nmdeld_t OR g_nmde_m.nmde001 != g_nmde001_t OR g_nmde_m.nmde002 != g_nmde002_t OR g_nmde_d[g_detail_idx].nmde004 != g_nmde_d_t.nmde004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmde_t WHERE "||"nmdeent = '" ||g_enterprise|| "' AND "||"nmdeld = '"||g_nmde_m.nmdeld ||"' AND "|| "nmde001 = '"||g_nmde_m.nmde001 ||"' AND "|| "nmde002 = '"||g_nmde_m.nmde002 ||"' AND "|| "nmde004 = '"||g_nmde_d[g_detail_idx].nmde004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde004
            #add-point:ON CHANGE nmde004 name="input.g.page1.nmde004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde100
            #add-point:BEFORE FIELD nmde100 name="input.b.page1.nmde100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde100
            
            #add-point:AFTER FIELD nmde100 name="input.a.page1.nmde100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde100
            #add-point:ON CHANGE nmde100 name="input.g.page1.nmde100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde101
            #add-point:BEFORE FIELD nmde101 name="input.b.page1.nmde101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde101
            
            #add-point:AFTER FIELD nmde101 name="input.a.page1.nmde101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde101
            #add-point:ON CHANGE nmde101 name="input.g.page1.nmde101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde102
            #add-point:BEFORE FIELD nmde102 name="input.b.page1.nmde102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde102
            
            #add-point:AFTER FIELD nmde102 name="input.a.page1.nmde102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde102
            #add-point:ON CHANGE nmde102 name="input.g.page1.nmde102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde103
            #add-point:BEFORE FIELD nmde103 name="input.b.page1.nmde103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde103
            
            #add-point:AFTER FIELD nmde103 name="input.a.page1.nmde103"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde103
            #add-point:ON CHANGE nmde103 name="input.g.page1.nmde103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde104
            #add-point:BEFORE FIELD nmde104 name="input.b.page1.nmde104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde104
            
            #add-point:AFTER FIELD nmde104 name="input.a.page1.nmde104"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde104
            #add-point:ON CHANGE nmde104 name="input.g.page1.nmde104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde105
            #add-point:BEFORE FIELD nmde105 name="input.b.page1.nmde105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde105
            
            #add-point:AFTER FIELD nmde105 name="input.a.page1.nmde105"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde105
            #add-point:ON CHANGE nmde105 name="input.g.page1.nmde105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde106
            #add-point:BEFORE FIELD nmde106 name="input.b.page1.nmde106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde106
            
            #add-point:AFTER FIELD nmde106 name="input.a.page1.nmde106"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde106
            #add-point:ON CHANGE nmde106 name="input.g.page1.nmde106"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.nmde005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde005
            #add-point:ON ACTION controlp INFIELD nmde005 name="input.c.page1.nmde005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde004
            #add-point:ON ACTION controlp INFIELD nmde004 name="input.c.page1.nmde004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde100
            #add-point:ON ACTION controlp INFIELD nmde100 name="input.c.page1.nmde100"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde101
            #add-point:ON ACTION controlp INFIELD nmde101 name="input.c.page1.nmde101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde102
            #add-point:ON ACTION controlp INFIELD nmde102 name="input.c.page1.nmde102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde103
            #add-point:ON ACTION controlp INFIELD nmde103 name="input.c.page1.nmde103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde104
            #add-point:ON ACTION controlp INFIELD nmde104 name="input.c.page1.nmde104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde105
            #add-point:ON ACTION controlp INFIELD nmde105 name="input.c.page1.nmde105"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmde106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde106
            #add-point:ON ACTION controlp INFIELD nmde106 name="input.c.page1.nmde106"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_nmde_d[l_ac].* = g_nmde_d_t.*
               CLOSE anmt820_bcl
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
               LET g_errparam.extend = g_nmde_d[l_ac].nmde004 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_nmde_d[l_ac].* = g_nmde_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL anmt820_nmde_t_mask_restore('restore_mask_o')
         
               UPDATE nmde_t SET (nmdeld,nmde001,nmde002,nmde005,nmde004,nmde100,nmde101,nmde102,nmde103, 
                   nmde104,nmde105,nmde106,nmde111,nmde113,nmde114,nmde115,nmde116,nmde121,nmde123,nmde124, 
                   nmde125,nmde126,nmde015,nmde033,nmde006,nmde007,nmde008,nmde018,nmde019,nmde009,nmde010, 
                   nmde020,nmde021,nmde022,nmde011,nmde013,nmde014,nmde023,nmde024,nmde025,nmde026,nmde027, 
                   nmde028,nmde029,nmde030,nmde031,nmde032) = (g_nmde_m.nmdeld,g_nmde_m.nmde001,g_nmde_m.nmde002, 
                   g_nmde_d[l_ac].nmde005,g_nmde_d[l_ac].nmde004,g_nmde_d[l_ac].nmde100,g_nmde_d[l_ac].nmde101, 
                   g_nmde_d[l_ac].nmde102,g_nmde_d[l_ac].nmde103,g_nmde_d[l_ac].nmde104,g_nmde_d[l_ac].nmde105, 
                   g_nmde_d[l_ac].nmde106,g_nmde2_d[l_ac].nmde111,g_nmde2_d[l_ac].nmde113,g_nmde2_d[l_ac].nmde114, 
                   g_nmde2_d[l_ac].nmde115,g_nmde2_d[l_ac].nmde116,g_nmde3_d[l_ac].nmde121,g_nmde3_d[l_ac].nmde123, 
                   g_nmde3_d[l_ac].nmde124,g_nmde3_d[l_ac].nmde125,g_nmde3_d[l_ac].nmde126,g_nmde4_d[l_ac].nmde015, 
                   g_nmde4_d[l_ac].nmde033,g_nmde4_d[l_ac].nmde006,g_nmde4_d[l_ac].nmde007,g_nmde4_d[l_ac].nmde008, 
                   g_nmde4_d[l_ac].nmde018,g_nmde4_d[l_ac].nmde019,g_nmde4_d[l_ac].nmde009,g_nmde4_d[l_ac].nmde010, 
                   g_nmde4_d[l_ac].nmde020,g_nmde4_d[l_ac].nmde021,g_nmde4_d[l_ac].nmde022,g_nmde4_d[l_ac].nmde011, 
                   g_nmde4_d[l_ac].nmde013,g_nmde4_d[l_ac].nmde014,g_nmde4_d[l_ac].nmde023,g_nmde4_d[l_ac].nmde024, 
                   g_nmde4_d[l_ac].nmde025,g_nmde4_d[l_ac].nmde026,g_nmde4_d[l_ac].nmde027,g_nmde4_d[l_ac].nmde028, 
                   g_nmde4_d[l_ac].nmde029,g_nmde4_d[l_ac].nmde030,g_nmde4_d[l_ac].nmde031,g_nmde4_d[l_ac].nmde032) 
 
                WHERE nmdeent = g_enterprise AND nmdeld = g_nmde_m.nmdeld 
                 AND nmde001 = g_nmde_m.nmde001 
                 AND nmde002 = g_nmde_m.nmde002 
 
                 AND nmde004 = g_nmde_d_t.nmde004 #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmde_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "nmde_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmde_m.nmdeld
               LET gs_keys_bak[1] = g_nmdeld_t
               LET gs_keys[2] = g_nmde_m.nmde001
               LET gs_keys_bak[2] = g_nmde001_t
               LET gs_keys[3] = g_nmde_m.nmde002
               LET gs_keys_bak[3] = g_nmde002_t
               LET gs_keys[4] = g_nmde_d[g_detail_idx].nmde004
               LET gs_keys_bak[4] = g_nmde_d_t.nmde004
               CALL anmt820_update_b('nmde_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_nmde_m),util.JSON.stringify(g_nmde_d_t)
                     LET g_log2 = util.JSON.stringify(g_nmde_m),util.JSON.stringify(g_nmde_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL anmt820_nmde_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_nmde_m.nmdeld
               LET ls_keys[ls_keys.getLength()+1] = g_nmde_m.nmde001
               LET ls_keys[ls_keys.getLength()+1] = g_nmde_m.nmde002
 
               LET ls_keys[ls_keys.getLength()+1] = g_nmde_d_t.nmde004
 
               CALL anmt820_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE anmt820_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_nmde_d[l_ac].* = g_nmde_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE anmt820_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_nmde_d.getLength() = 0 THEN
               NEXT FIELD nmde004
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_nmde_d[li_reproduce_target].* = g_nmde_d[li_reproduce].*
               LET g_nmde2_d[li_reproduce_target].* = g_nmde2_d[li_reproduce].*
               LET g_nmde3_d[li_reproduce_target].* = g_nmde3_d[li_reproduce].*
               LET g_nmde4_d[li_reproduce_target].* = g_nmde4_d[li_reproduce].*
 
               LET g_nmde_d[li_reproduce_target].nmde004 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmde_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmde_d.getLength()+1
            END IF
            
      END INPUT
 
      INPUT ARRAY g_nmde2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = FALSE,
                   APPEND ROW = FALSE)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL anmt820_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 2
            #add-point:資料輸入前 name="input.body2.before_input"
            NEXT FIELD nmde033 #160326-00001#25 add
            #end add-point
 
         BEFORE ROW 
            #add-point:before row name="input.body2.before_row2"
            
            #end add-point
            LET l_cmd = ''
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()               #returns the current row
            IF l_ac > g_rec_b THEN              #不可超過最後一筆
               CALL fgl_set_arr_curr(g_rec_b)   #moves to a specific row         
            END IF
           
            LET l_lock_sw = 'N'                  #DEFAULT
            LET l_n = ARR_COUNT()                #the number of rows containing  
            
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt820_idx_chk()
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL anmt820_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body2.before_row.set_entry_b"
               
               #end add-point
               CALL anmt820_set_no_entry_b(l_cmd)
               LET g_nmde2_d_t.* = g_nmde2_d[l_ac].*   #BACKUP  #page1
               LET g_nmde2_d_o.* = g_nmde2_d[l_ac].*   #BACKUP  #page1
            END IF 
            
 
 
 
 
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD nmde004
 
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_nmde2_d_t.* TO NULL
            INITIALIZE g_nmde2_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_nmde2_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_nmde2_d[l_ac].nmde113 = "0"
      LET g_nmde2_d[l_ac].nmde114 = "0"
      LET g_nmde2_d[l_ac].nmde115 = "0"
      LET g_nmde2_d[l_ac].nmde116 = "0"
 
            
            #add-point:modify段before備份 name="input.body2.before_insert.before_bak"
            
            #end add-point
            LET g_nmde2_d_t.* = g_nmde2_d[l_ac].*     #新輸入資料
            LET g_nmde2_d_o.* = g_nmde2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt820_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body2.before_insert.set_entry_b"
            
            #end add-point
            CALL anmt820_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmde_d[li_reproduce_target].* = g_nmde_d[li_reproduce].*
               LET g_nmde2_d[li_reproduce_target].* = g_nmde2_d[li_reproduce].*
               LET g_nmde3_d[li_reproduce_target].* = g_nmde3_d[li_reproduce].*
               LET g_nmde4_d[li_reproduce_target].* = g_nmde4_d[li_reproduce].*
 
               LET g_nmde2_d[li_reproduce_target].nmde004 = NULL
            END IF
            
 
 
 
 
            #add-point:modify段before insert name="input.body2.before_insert"
            #161221-00054#3 add s---
            LET l_wc = g_nmde4_d[l_ac].nmde015
            CALL s_fin_get_wc_str(l_wc) RETURNING l_wc            
            #161221-00054#3 add e---   
            #end add-point
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
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
               IF anmt820_before_delete() THEN 
                  
 
 
 
 
  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_nmde_m.nmdeld
                  LET gs_keys[gs_keys.getLength()+1] = g_nmde_m.nmde001
                  LET gs_keys[gs_keys.getLength()+1] = g_nmde_m.nmde002
                  LET gs_keys[gs_keys.getLength()+1] = g_nmde_d_t.nmde004
 
                  #刪除下層單身
                  IF NOT anmt820_key_delete_b(gs_keys,'nmde_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE anmt820_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE anmt820_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_nmde2_d.getLength()
            END IF
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body2.after_delete"
               
               #end add-point
                              CALL anmt820_delete_b('nmde_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_nmde2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_nmde2_d[l_ac].* = g_nmde2_d_t.*
               CLOSE anmt820_bcl
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
               LET g_errparam.extend = g_nmde_d[l_ac].nmde004 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_nmde2_d[l_ac].* = g_nmde2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
                
               #add-point:單身修改前 name="modify.body2.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL anmt820_nmde_t_mask_restore('restore_mask_o')
                     
               UPDATE nmde_t SET (nmdeld,nmde001,nmde002,nmde005,nmde004,nmde100,nmde101,nmde102,nmde103, 
                   nmde104,nmde105,nmde106,nmde111,nmde113,nmde114,nmde115,nmde116,nmde121,nmde123,nmde124, 
                   nmde125,nmde126,nmde015,nmde033,nmde006,nmde007,nmde008,nmde018,nmde019,nmde009,nmde010, 
                   nmde020,nmde021,nmde022,nmde011,nmde013,nmde014,nmde023,nmde024,nmde025,nmde026,nmde027, 
                   nmde028,nmde029,nmde030,nmde031,nmde032) = (g_nmde_m.nmdeld,g_nmde_m.nmde001,g_nmde_m.nmde002, 
                   g_nmde_d[l_ac].nmde005,g_nmde_d[l_ac].nmde004,g_nmde_d[l_ac].nmde100,g_nmde_d[l_ac].nmde101, 
                   g_nmde_d[l_ac].nmde102,g_nmde_d[l_ac].nmde103,g_nmde_d[l_ac].nmde104,g_nmde_d[l_ac].nmde105, 
                   g_nmde_d[l_ac].nmde106,g_nmde2_d[l_ac].nmde111,g_nmde2_d[l_ac].nmde113,g_nmde2_d[l_ac].nmde114, 
                   g_nmde2_d[l_ac].nmde115,g_nmde2_d[l_ac].nmde116,g_nmde3_d[l_ac].nmde121,g_nmde3_d[l_ac].nmde123, 
                   g_nmde3_d[l_ac].nmde124,g_nmde3_d[l_ac].nmde125,g_nmde3_d[l_ac].nmde126,g_nmde4_d[l_ac].nmde015, 
                   g_nmde4_d[l_ac].nmde033,g_nmde4_d[l_ac].nmde006,g_nmde4_d[l_ac].nmde007,g_nmde4_d[l_ac].nmde008, 
                   g_nmde4_d[l_ac].nmde018,g_nmde4_d[l_ac].nmde019,g_nmde4_d[l_ac].nmde009,g_nmde4_d[l_ac].nmde010, 
                   g_nmde4_d[l_ac].nmde020,g_nmde4_d[l_ac].nmde021,g_nmde4_d[l_ac].nmde022,g_nmde4_d[l_ac].nmde011, 
                   g_nmde4_d[l_ac].nmde013,g_nmde4_d[l_ac].nmde014,g_nmde4_d[l_ac].nmde023,g_nmde4_d[l_ac].nmde024, 
                   g_nmde4_d[l_ac].nmde025,g_nmde4_d[l_ac].nmde026,g_nmde4_d[l_ac].nmde027,g_nmde4_d[l_ac].nmde028, 
                   g_nmde4_d[l_ac].nmde029,g_nmde4_d[l_ac].nmde030,g_nmde4_d[l_ac].nmde031,g_nmde4_d[l_ac].nmde032)  
                   #自訂欄位頁簽
                WHERE nmdeent = g_enterprise AND nmdeld = g_nmde_m.nmdeld
                 AND nmde001 = g_nmde_m.nmde001
                 AND nmde002 = g_nmde_m.nmde002
                 AND nmde004 = g_nmde2_d_t.nmde004 #項次 
               #add-point:單身修改中 name="modify.body2.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmde_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmde_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmde_m.nmdeld
               LET gs_keys_bak[1] = g_nmdeld_t
               LET gs_keys[2] = g_nmde_m.nmde001
               LET gs_keys_bak[2] = g_nmde001_t
               LET gs_keys[3] = g_nmde_m.nmde002
               LET gs_keys_bak[3] = g_nmde002_t
               LET gs_keys[4] = g_nmde2_d[g_detail_idx].nmde004
               LET gs_keys_bak[4] = g_nmde2_d_t.nmde004
               CALL anmt820_update_b('nmde_t',gs_keys,gs_keys_bak,"'2'")
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_nmde_m),util.JSON.stringify(g_nmde2_d_t)
                     LET g_log2 = util.JSON.stringify(g_nmde_m),util.JSON.stringify(g_nmde2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL anmt820_nmde_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="modify.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde111
            #add-point:BEFORE FIELD nmde111 name="input.b.page2.nmde111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde111
            
            #add-point:AFTER FIELD nmde111 name="input.a.page2.nmde111"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde111
            #add-point:ON CHANGE nmde111 name="input.g.page2.nmde111"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde113
            #add-point:BEFORE FIELD nmde113 name="input.b.page2.nmde113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde113
            
            #add-point:AFTER FIELD nmde113 name="input.a.page2.nmde113"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde113
            #add-point:ON CHANGE nmde113 name="input.g.page2.nmde113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde114
            #add-point:BEFORE FIELD nmde114 name="input.b.page2.nmde114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde114
            
            #add-point:AFTER FIELD nmde114 name="input.a.page2.nmde114"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde114
            #add-point:ON CHANGE nmde114 name="input.g.page2.nmde114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde115
            #add-point:BEFORE FIELD nmde115 name="input.b.page2.nmde115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde115
            
            #add-point:AFTER FIELD nmde115 name="input.a.page2.nmde115"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde115
            #add-point:ON CHANGE nmde115 name="input.g.page2.nmde115"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde116
            #add-point:BEFORE FIELD nmde116 name="input.b.page2.nmde116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde116
            
            #add-point:AFTER FIELD nmde116 name="input.a.page2.nmde116"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde116
            #add-point:ON CHANGE nmde116 name="input.g.page2.nmde116"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.nmde111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde111
            #add-point:ON ACTION controlp INFIELD nmde111 name="input.c.page2.nmde111"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmde113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde113
            #add-point:ON ACTION controlp INFIELD nmde113 name="input.c.page2.nmde113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmde114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde114
            #add-point:ON ACTION controlp INFIELD nmde114 name="input.c.page2.nmde114"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmde115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde115
            #add-point:ON ACTION controlp INFIELD nmde115 name="input.c.page2.nmde115"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmde116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde116
            #add-point:ON ACTION controlp INFIELD nmde116 name="input.c.page2.nmde116"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:input段after row name="input.body2.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_nmde2_d[l_ac].* = g_nmde2_d_t.*
               END IF
               CLOSE anmt820_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
 
            CLOSE anmt820_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point    
 
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_nmde_d[li_reproduce_target].* = g_nmde_d[li_reproduce].*
               LET g_nmde2_d[li_reproduce_target].* = g_nmde2_d[li_reproduce].*
               LET g_nmde3_d[li_reproduce_target].* = g_nmde3_d[li_reproduce].*
               LET g_nmde4_d[li_reproduce_target].* = g_nmde4_d[li_reproduce].*
 
               LET g_nmde2_d[li_reproduce_target].nmde004 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmde2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmde2_d.getLength()+1
            END IF
      END INPUT
      INPUT ARRAY g_nmde3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = FALSE,
                   APPEND ROW = FALSE)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL anmt820_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 3
            #add-point:資料輸入前 name="input.body3.before_input"
            NEXT FIELD nmde033 #160326-00001#25 add
            #end add-point
 
         BEFORE ROW 
            #add-point:before row name="input.body3.before_row2"
            #161221-00054#3 add s---
            LET l_wc = g_nmde4_d[l_ac].nmde015
            CALL s_fin_get_wc_str(l_wc) RETURNING l_wc            
            #161221-00054#3 add e---  
            #end add-point
            LET l_cmd = ''
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()               #returns the current row
            IF l_ac > g_rec_b THEN              #不可超過最後一筆
               CALL fgl_set_arr_curr(g_rec_b)   #moves to a specific row         
            END IF
           
            LET l_lock_sw = 'N'                  #DEFAULT
            LET l_n = ARR_COUNT()                #the number of rows containing  
            
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt820_idx_chk()
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL anmt820_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body3.before_row.set_entry_b"
               
               #end add-point
               CALL anmt820_set_no_entry_b(l_cmd)
               LET g_nmde3_d_t.* = g_nmde3_d[l_ac].*   #BACKUP  #page1
               LET g_nmde3_d_o.* = g_nmde3_d[l_ac].*   #BACKUP  #page1
            END IF 
            
 
 
 
 
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD nmde004
 
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_nmde3_d_t.* TO NULL
            INITIALIZE g_nmde3_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_nmde3_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_nmde3_d[l_ac].nmde123 = "0"
      LET g_nmde3_d[l_ac].nmde124 = "0"
      LET g_nmde3_d[l_ac].nmde125 = "0"
      LET g_nmde3_d[l_ac].nmde126 = "0"
 
            
            #add-point:modify段before備份 name="input.body3.before_insert.before_bak"
            
            #end add-point
            LET g_nmde3_d_t.* = g_nmde3_d[l_ac].*     #新輸入資料
            LET g_nmde3_d_o.* = g_nmde3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt820_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body3.before_insert.set_entry_b"
            
            #end add-point
            CALL anmt820_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmde_d[li_reproduce_target].* = g_nmde_d[li_reproduce].*
               LET g_nmde2_d[li_reproduce_target].* = g_nmde2_d[li_reproduce].*
               LET g_nmde3_d[li_reproduce_target].* = g_nmde3_d[li_reproduce].*
               LET g_nmde4_d[li_reproduce_target].* = g_nmde4_d[li_reproduce].*
 
               LET g_nmde3_d[li_reproduce_target].nmde004 = NULL
            END IF
            
 
 
 
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
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
               IF anmt820_before_delete() THEN 
                  
 
 
 
 
  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_nmde_m.nmdeld
                  LET gs_keys[gs_keys.getLength()+1] = g_nmde_m.nmde001
                  LET gs_keys[gs_keys.getLength()+1] = g_nmde_m.nmde002
                  LET gs_keys[gs_keys.getLength()+1] = g_nmde_d_t.nmde004
 
                  #刪除下層單身
                  IF NOT anmt820_key_delete_b(gs_keys,'nmde_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE anmt820_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE anmt820_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_nmde3_d.getLength()
            END IF
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body3.after_delete"
               
               #end add-point
                              CALL anmt820_delete_b('nmde_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_nmde3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_nmde3_d[l_ac].* = g_nmde3_d_t.*
               CLOSE anmt820_bcl
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
               LET g_errparam.extend = g_nmde_d[l_ac].nmde004 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_nmde3_d[l_ac].* = g_nmde3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
                
               #add-point:單身修改前 name="modify.body3.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL anmt820_nmde_t_mask_restore('restore_mask_o')
                     
               UPDATE nmde_t SET (nmdeld,nmde001,nmde002,nmde005,nmde004,nmde100,nmde101,nmde102,nmde103, 
                   nmde104,nmde105,nmde106,nmde111,nmde113,nmde114,nmde115,nmde116,nmde121,nmde123,nmde124, 
                   nmde125,nmde126,nmde015,nmde033,nmde006,nmde007,nmde008,nmde018,nmde019,nmde009,nmde010, 
                   nmde020,nmde021,nmde022,nmde011,nmde013,nmde014,nmde023,nmde024,nmde025,nmde026,nmde027, 
                   nmde028,nmde029,nmde030,nmde031,nmde032) = (g_nmde_m.nmdeld,g_nmde_m.nmde001,g_nmde_m.nmde002, 
                   g_nmde_d[l_ac].nmde005,g_nmde_d[l_ac].nmde004,g_nmde_d[l_ac].nmde100,g_nmde_d[l_ac].nmde101, 
                   g_nmde_d[l_ac].nmde102,g_nmde_d[l_ac].nmde103,g_nmde_d[l_ac].nmde104,g_nmde_d[l_ac].nmde105, 
                   g_nmde_d[l_ac].nmde106,g_nmde2_d[l_ac].nmde111,g_nmde2_d[l_ac].nmde113,g_nmde2_d[l_ac].nmde114, 
                   g_nmde2_d[l_ac].nmde115,g_nmde2_d[l_ac].nmde116,g_nmde3_d[l_ac].nmde121,g_nmde3_d[l_ac].nmde123, 
                   g_nmde3_d[l_ac].nmde124,g_nmde3_d[l_ac].nmde125,g_nmde3_d[l_ac].nmde126,g_nmde4_d[l_ac].nmde015, 
                   g_nmde4_d[l_ac].nmde033,g_nmde4_d[l_ac].nmde006,g_nmde4_d[l_ac].nmde007,g_nmde4_d[l_ac].nmde008, 
                   g_nmde4_d[l_ac].nmde018,g_nmde4_d[l_ac].nmde019,g_nmde4_d[l_ac].nmde009,g_nmde4_d[l_ac].nmde010, 
                   g_nmde4_d[l_ac].nmde020,g_nmde4_d[l_ac].nmde021,g_nmde4_d[l_ac].nmde022,g_nmde4_d[l_ac].nmde011, 
                   g_nmde4_d[l_ac].nmde013,g_nmde4_d[l_ac].nmde014,g_nmde4_d[l_ac].nmde023,g_nmde4_d[l_ac].nmde024, 
                   g_nmde4_d[l_ac].nmde025,g_nmde4_d[l_ac].nmde026,g_nmde4_d[l_ac].nmde027,g_nmde4_d[l_ac].nmde028, 
                   g_nmde4_d[l_ac].nmde029,g_nmde4_d[l_ac].nmde030,g_nmde4_d[l_ac].nmde031,g_nmde4_d[l_ac].nmde032)  
                   #自訂欄位頁簽
                WHERE nmdeent = g_enterprise AND nmdeld = g_nmde_m.nmdeld
                 AND nmde001 = g_nmde_m.nmde001
                 AND nmde002 = g_nmde_m.nmde002
                 AND nmde004 = g_nmde3_d_t.nmde004 #項次 
               #add-point:單身修改中 name="modify.body3.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmde_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmde_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmde_m.nmdeld
               LET gs_keys_bak[1] = g_nmdeld_t
               LET gs_keys[2] = g_nmde_m.nmde001
               LET gs_keys_bak[2] = g_nmde001_t
               LET gs_keys[3] = g_nmde_m.nmde002
               LET gs_keys_bak[3] = g_nmde002_t
               LET gs_keys[4] = g_nmde3_d[g_detail_idx].nmde004
               LET gs_keys_bak[4] = g_nmde3_d_t.nmde004
               CALL anmt820_update_b('nmde_t',gs_keys,gs_keys_bak,"'3'")
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_nmde_m),util.JSON.stringify(g_nmde3_d_t)
                     LET g_log2 = util.JSON.stringify(g_nmde_m),util.JSON.stringify(g_nmde3_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL anmt820_nmde_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="modify.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde121
            #add-point:BEFORE FIELD nmde121 name="input.b.page3.nmde121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde121
            
            #add-point:AFTER FIELD nmde121 name="input.a.page3.nmde121"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde121
            #add-point:ON CHANGE nmde121 name="input.g.page3.nmde121"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde123
            #add-point:BEFORE FIELD nmde123 name="input.b.page3.nmde123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde123
            
            #add-point:AFTER FIELD nmde123 name="input.a.page3.nmde123"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde123
            #add-point:ON CHANGE nmde123 name="input.g.page3.nmde123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde124
            #add-point:BEFORE FIELD nmde124 name="input.b.page3.nmde124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde124
            
            #add-point:AFTER FIELD nmde124 name="input.a.page3.nmde124"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde124
            #add-point:ON CHANGE nmde124 name="input.g.page3.nmde124"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde125
            #add-point:BEFORE FIELD nmde125 name="input.b.page3.nmde125"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde125
            
            #add-point:AFTER FIELD nmde125 name="input.a.page3.nmde125"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde125
            #add-point:ON CHANGE nmde125 name="input.g.page3.nmde125"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde126
            #add-point:BEFORE FIELD nmde126 name="input.b.page3.nmde126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde126
            
            #add-point:AFTER FIELD nmde126 name="input.a.page3.nmde126"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde126
            #add-point:ON CHANGE nmde126 name="input.g.page3.nmde126"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.nmde121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde121
            #add-point:ON ACTION controlp INFIELD nmde121 name="input.c.page3.nmde121"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.nmde123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde123
            #add-point:ON ACTION controlp INFIELD nmde123 name="input.c.page3.nmde123"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.nmde124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde124
            #add-point:ON ACTION controlp INFIELD nmde124 name="input.c.page3.nmde124"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.nmde125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde125
            #add-point:ON ACTION controlp INFIELD nmde125 name="input.c.page3.nmde125"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.nmde126
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde126
            #add-point:ON ACTION controlp INFIELD nmde126 name="input.c.page3.nmde126"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:input段after row name="input.body3.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_nmde3_d[l_ac].* = g_nmde3_d_t.*
               END IF
               CLOSE anmt820_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
 
            CLOSE anmt820_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point    
 
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_nmde_d[li_reproduce_target].* = g_nmde_d[li_reproduce].*
               LET g_nmde2_d[li_reproduce_target].* = g_nmde2_d[li_reproduce].*
               LET g_nmde3_d[li_reproduce_target].* = g_nmde3_d[li_reproduce].*
               LET g_nmde4_d[li_reproduce_target].* = g_nmde4_d[li_reproduce].*
 
               LET g_nmde3_d[li_reproduce_target].nmde004 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmde3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmde3_d.getLength()+1
            END IF
      END INPUT
      INPUT ARRAY g_nmde4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = l_allow_delete,
                   APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL anmt820_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 4
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
 
         BEFORE ROW 
            #add-point:before row name="input.body4.before_row2"
            
            #end add-point
            LET l_cmd = ''
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()               #returns the current row
            IF l_ac > g_rec_b THEN              #不可超過最後一筆
               CALL fgl_set_arr_curr(g_rec_b)   #moves to a specific row         
            END IF
           
            LET l_lock_sw = 'N'                  #DEFAULT
            LET l_n = ARR_COUNT()                #the number of rows containing  
            
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt820_idx_chk()
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL anmt820_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body4.before_row.set_entry_b"
               #160326-00001#25--add--str--
               OPEN anmt820_cl USING g_enterprise,g_nmde_m.nmdeld,g_nmde_m.nmde001,g_nmde_m.nmde002                          
               IF STATUS THEN
                  CLOSE anmt820_cl
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN anmt820_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  RETURN
               END IF
            
               OPEN anmt820_bcl USING g_enterprise,g_nmde_m.nmdeld,
                                                g_nmde_m.nmde001,
                                                g_nmde_m.nmde002,
 
                                                g_nmde_d[l_ac].nmde004
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN anmt820_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt820_bcl INTO g_nmde_d[l_ac].nmde005,g_nmde_d[l_ac].nmde004,g_nmde_d[l_ac].nmde100, 
                      g_nmde_d[l_ac].nmde101,g_nmde_d[l_ac].nmde102,g_nmde_d[l_ac].nmde103,g_nmde_d[l_ac].nmde104, 
                      g_nmde_d[l_ac].nmde105,g_nmde_d[l_ac].nmde106,g_nmde2_d[l_ac].nmde004,g_nmde2_d[l_ac].nmde005, 
                      g_nmde2_d[l_ac].nmde100,g_nmde2_d[l_ac].nmde111,g_nmde2_d[l_ac].nmde102,g_nmde2_d[l_ac].nmde113, 
                      g_nmde2_d[l_ac].nmde114,g_nmde2_d[l_ac].nmde115,g_nmde2_d[l_ac].nmde116,g_nmde3_d[l_ac].nmde004, 
                      g_nmde3_d[l_ac].nmde005,g_nmde3_d[l_ac].nmde100,g_nmde3_d[l_ac].nmde121,g_nmde3_d[l_ac].nmde102, 
                      g_nmde3_d[l_ac].nmde123,g_nmde3_d[l_ac].nmde124,g_nmde3_d[l_ac].nmde125,g_nmde3_d[l_ac].nmde126, 
                      g_nmde4_d[l_ac].nmde004,g_nmde4_d[l_ac].nmde015,g_nmde4_d[l_ac].nmde033,g_nmde4_d[l_ac].nmde006, 
                      g_nmde4_d[l_ac].nmde007,g_nmde4_d[l_ac].nmde008,g_nmde4_d[l_ac].nmde018,g_nmde4_d[l_ac].nmde019, 
                      g_nmde4_d[l_ac].nmde009,g_nmde4_d[l_ac].nmde010,g_nmde4_d[l_ac].nmde020,g_nmde4_d[l_ac].nmde021, 
                      g_nmde4_d[l_ac].nmde022,g_nmde4_d[l_ac].nmde011,g_nmde4_d[l_ac].nmde013,g_nmde4_d[l_ac].nmde014, 
                      g_nmde4_d[l_ac].nmde023,g_nmde4_d[l_ac].nmde024,g_nmde4_d[l_ac].nmde025,g_nmde4_d[l_ac].nmde026, 
                      g_nmde4_d[l_ac].nmde027,g_nmde4_d[l_ac].nmde028,g_nmde4_d[l_ac].nmde029,g_nmde4_d[l_ac].nmde030, 
                      g_nmde4_d[l_ac].nmde031,g_nmde4_d[l_ac].nmde032
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_nmde_d_t.nmde004,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
               END IF
               #银存科目
               LET g_nmde4_d[l_ac].nmde015_desc = s_desc_get_account_desc(g_nmde_m.nmdeld,g_nmde4_d[l_ac].nmde015)
               LET g_nmde4_d[l_ac].nmde015_desc = s_desc_show1(g_nmde4_d[l_ac].nmde015,g_nmde4_d[l_ac].nmde015_desc)
               #固定核算项
               #部门
               LET g_nmde4_d[l_ac].nmde006_desc = s_desc_get_department_desc(g_nmde4_d[l_ac].nmde006)
               LET g_nmde4_d[l_ac].nmde006_desc = s_desc_show1(g_nmde4_d[l_ac].nmde006,g_nmde4_d[l_ac].nmde006_desc)
               #利润成本中心
               LET g_nmde4_d[l_ac].nmde007_desc = s_desc_get_department_desc(g_nmde4_d[l_ac].nmde007)
               LET g_nmde4_d[l_ac].nmde007_desc = s_desc_show1(g_nmde4_d[l_ac].nmde007,g_nmde4_d[l_ac].nmde007_desc)
               #区域
               LET g_nmde4_d[l_ac].nmde008_desc = s_desc_get_acc_desc('287',g_nmde4_d[l_ac].nmde008)
               LET g_nmde4_d[l_ac].nmde008_desc = s_desc_show1(g_nmde4_d[l_ac].nmde008,g_nmde4_d[l_ac].nmde008_desc)
               #收付款客商
               LET g_nmde4_d[l_ac].nmde018_desc = s_desc_get_trading_partner_abbr_desc(g_nmde4_d[l_ac].nmde018_desc)
               LET g_nmde4_d[l_ac].nmde018_desc = s_desc_show1(g_nmde4_d[l_ac].nmde018,g_nmde4_d[l_ac].nmde018_desc)
               #账款客商
               LET g_nmde4_d[l_ac].nmde019_desc = s_desc_get_trading_partner_abbr_desc(g_nmde4_d[l_ac].nmde019_desc)
               LET g_nmde4_d[l_ac].nmde019_desc = s_desc_show1(g_nmde4_d[l_ac].nmde019,g_nmde4_d[l_ac].nmde019_desc)
               #客群
               LET g_nmde4_d[l_ac].nmde009_desc = s_desc_get_acc_desc('281',g_nmde4_d[l_ac].nmde009)
               LET g_nmde4_d[l_ac].nmde009_desc = s_desc_show1(g_nmde4_d[l_ac].nmde009,g_nmde4_d[l_ac].nmde009_desc)
               #产品类别
               LET g_nmde4_d[l_ac].nmde010_desc = s_desc_get_rtaxl003_desc(g_nmde4_d[l_ac].nmde010_desc)
               LET g_nmde4_d[l_ac].nmde010_desc = s_desc_show1(g_nmde4_d[l_ac].nmde010,g_nmde4_d[l_ac].nmde010_desc)
               #通路
               LET g_nmde4_d[l_ac].nmde021_desc = s_desc_get_oojdl003_desc(g_nmde4_d[l_ac].nmde021_desc)
               LET g_nmde4_d[l_ac].nmde021_desc = s_desc_show1(g_nmde4_d[l_ac].nmde021,g_nmde4_d[l_ac].nmde021_desc)
               #品牌
               LET g_nmde4_d[l_ac].nmde022_desc = s_desc_get_acc_desc('2002',g_nmde4_d[l_ac].nmde022)
               LET g_nmde4_d[l_ac].nmde022_desc = s_desc_show1(g_nmde4_d[l_ac].nmde022,g_nmde4_d[l_ac].nmde022_desc)
               #人员
               LET g_nmde4_d[l_ac].nmde011_desc = s_desc_get_person_desc(g_nmde4_d[l_ac].nmde011_desc)
               LET g_nmde4_d[l_ac].nmde011_desc = s_desc_show1(g_nmde4_d[l_ac].nmde011,g_nmde4_d[l_ac].nmde011_desc)
               #专案
               LET g_nmde4_d[l_ac].nmde013_desc = s_desc_get_project_desc(g_nmde4_d[l_ac].nmde013_desc)
               LET g_nmde4_d[l_ac].nmde013_desc = s_desc_show1(g_nmde4_d[l_ac].nmde013,g_nmde4_d[l_ac].nmde013_desc)
               #WBS
               LET g_nmde4_d[l_ac].nmde014_desc = s_desc_get_wbs_desc(g_nmde4_d[l_ac].nmde013,g_nmde4_d[l_ac].nmde014_desc)
               LET g_nmde4_d[l_ac].nmde014_desc = s_desc_show1(g_nmde4_d[l_ac].nmde014,g_nmde4_d[l_ac].nmde014_desc)
               #自由核算项
               SELECT * INTO l_glad.* FROM glad_t 
               WHERE gladent=g_enterprise  AND gladld=g_nmde_m.nmdeld AND glad001=g_nmde4_d[l_ac].nmde015
               #自由核算项一
               CALL s_voucher_free_account_desc(l_glad.glad0171,g_nmde4_d[l_ac].nmde023_desc) RETURNING g_nmde4_d[l_ac].nmde023_desc
               LET g_nmde4_d[l_ac].nmde023_desc = s_desc_show1(g_nmde4_d[l_ac].nmde023,g_nmde4_d[l_ac].nmde023_desc)
               #自由核算项二
               CALL s_voucher_free_account_desc(l_glad.glad0181,g_nmde4_d[l_ac].nmde024_desc) RETURNING g_nmde4_d[l_ac].nmde024_desc
               LET g_nmde4_d[l_ac].nmde024_desc = s_desc_show1(g_nmde4_d[l_ac].nmde024,g_nmde4_d[l_ac].nmde024_desc)
               #自由核算项三
               CALL s_voucher_free_account_desc(l_glad.glad0191,g_nmde4_d[l_ac].nmde025_desc) RETURNING g_nmde4_d[l_ac].nmde025_desc
               LET g_nmde4_d[l_ac].nmde025_desc = s_desc_show1(g_nmde4_d[l_ac].nmde025,g_nmde4_d[l_ac].nmde025_desc)
               #自由核算项四
               CALL s_voucher_free_account_desc(l_glad.glad0201,g_nmde4_d[l_ac].nmde026_desc) RETURNING g_nmde4_d[l_ac].nmde026_desc
               LET g_nmde4_d[l_ac].nmde026_desc = s_desc_show1(g_nmde4_d[l_ac].nmde026,g_nmde4_d[l_ac].nmde026_desc)
               #自由核算项五
               CALL s_voucher_free_account_desc(l_glad.glad0211,g_nmde4_d[l_ac].nmde027_desc) RETURNING g_nmde4_d[l_ac].nmde027_desc
               LET g_nmde4_d[l_ac].nmde027_desc = s_desc_show1(g_nmde4_d[l_ac].nmde027,g_nmde4_d[l_ac].nmde027_desc)
               #自由核算项六
               CALL s_voucher_free_account_desc(l_glad.glad0221,g_nmde4_d[l_ac].nmde028_desc) RETURNING g_nmde4_d[l_ac].nmde028_desc
               LET g_nmde4_d[l_ac].nmde028_desc = s_desc_show1(g_nmde4_d[l_ac].nmde028,g_nmde4_d[l_ac].nmde028_desc)
               #自由核算项七
               CALL s_voucher_free_account_desc(l_glad.glad0231,g_nmde4_d[l_ac].nmde029_desc) RETURNING g_nmde4_d[l_ac].nmde029_desc
               LET g_nmde4_d[l_ac].nmde029_desc = s_desc_show1(g_nmde4_d[l_ac].nmde029,g_nmde4_d[l_ac].nmde029_desc)
               #自由核算项八
               CALL s_voucher_free_account_desc(l_glad.glad0241,g_nmde4_d[l_ac].nmde030_desc) RETURNING g_nmde4_d[l_ac].nmde030_desc
               LET g_nmde4_d[l_ac].nmde030_desc = s_desc_show1(g_nmde4_d[l_ac].nmde030,g_nmde4_d[l_ac].nmde030_desc)
               #自由核算项九
               CALL s_voucher_free_account_desc(l_glad.glad0251,g_nmde4_d[l_ac].nmde031_desc) RETURNING g_nmde4_d[l_ac].nmde031_desc
               LET g_nmde4_d[l_ac].nmde031_desc = s_desc_show1(g_nmde4_d[l_ac].nmde031,g_nmde4_d[l_ac].nmde031_desc)
               #自由核算项十
               CALL s_voucher_free_account_desc(l_glad.glad0261,g_nmde4_d[l_ac].nmde032_desc) RETURNING g_nmde4_d[l_ac].nmde032_desc
               LET g_nmde4_d[l_ac].nmde032_desc = s_desc_show1(g_nmde4_d[l_ac].nmde032,g_nmde4_d[l_ac].nmde032_desc)
               
               #160326-00001#25--add--end
               
               #161221-00054#3 add s---
               LET l_wc = g_nmde4_d[l_ac].nmde015
               CALL s_fin_get_wc_str(l_wc) RETURNING l_wc            
               #161221-00054#3 add e---                 
               #end add-point
               CALL anmt820_set_no_entry_b(l_cmd)
               LET g_nmde4_d_t.* = g_nmde4_d[l_ac].*   #BACKUP  #page1
               LET g_nmde4_d_o.* = g_nmde4_d[l_ac].*   #BACKUP  #page1
            END IF 
            
 
 
 
 
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD nmde004
 
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_nmde4_d_t.* TO NULL
            INITIALIZE g_nmde4_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_nmde4_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
            
            
            #add-point:modify段before備份 name="input.body4.before_insert.before_bak"
            
            #end add-point
            LET g_nmde4_d_t.* = g_nmde4_d[l_ac].*     #新輸入資料
            LET g_nmde4_d_o.* = g_nmde4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt820_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body4.before_insert.set_entry_b"
            
            #end add-point
            CALL anmt820_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmde_d[li_reproduce_target].* = g_nmde_d[li_reproduce].*
               LET g_nmde2_d[li_reproduce_target].* = g_nmde2_d[li_reproduce].*
               LET g_nmde3_d[li_reproduce_target].* = g_nmde3_d[li_reproduce].*
               LET g_nmde4_d[li_reproduce_target].* = g_nmde4_d[li_reproduce].*
 
               LET g_nmde4_d[li_reproduce_target].nmde004 = NULL
            END IF
            
 
 
 
 
            #add-point:modify段before insert name="input.body4.before_insert"
            
            #end add-point
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
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
               IF anmt820_before_delete() THEN 
                  
 
 
 
 
  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_nmde_m.nmdeld
                  LET gs_keys[gs_keys.getLength()+1] = g_nmde_m.nmde001
                  LET gs_keys[gs_keys.getLength()+1] = g_nmde_m.nmde002
                  LET gs_keys[gs_keys.getLength()+1] = g_nmde_d_t.nmde004
 
                  #刪除下層單身
                  IF NOT anmt820_key_delete_b(gs_keys,'nmde_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE anmt820_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE anmt820_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_nmde4_d.getLength()
            END IF
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body4.after_delete"
               
               #end add-point
                              CALL anmt820_delete_b('nmde_t',gs_keys,"'4'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_nmde4_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_nmde4_d[l_ac].* = g_nmde4_d_t.*
               CLOSE anmt820_bcl
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
               LET g_errparam.extend = g_nmde_d[l_ac].nmde004 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_nmde4_d[l_ac].* = g_nmde4_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
                
               #add-point:單身修改前 name="modify.body4.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL anmt820_nmde_t_mask_restore('restore_mask_o')
                     
               UPDATE nmde_t SET (nmdeld,nmde001,nmde002,nmde005,nmde004,nmde100,nmde101,nmde102,nmde103, 
                   nmde104,nmde105,nmde106,nmde111,nmde113,nmde114,nmde115,nmde116,nmde121,nmde123,nmde124, 
                   nmde125,nmde126,nmde015,nmde033,nmde006,nmde007,nmde008,nmde018,nmde019,nmde009,nmde010, 
                   nmde020,nmde021,nmde022,nmde011,nmde013,nmde014,nmde023,nmde024,nmde025,nmde026,nmde027, 
                   nmde028,nmde029,nmde030,nmde031,nmde032) = (g_nmde_m.nmdeld,g_nmde_m.nmde001,g_nmde_m.nmde002, 
                   g_nmde_d[l_ac].nmde005,g_nmde_d[l_ac].nmde004,g_nmde_d[l_ac].nmde100,g_nmde_d[l_ac].nmde101, 
                   g_nmde_d[l_ac].nmde102,g_nmde_d[l_ac].nmde103,g_nmde_d[l_ac].nmde104,g_nmde_d[l_ac].nmde105, 
                   g_nmde_d[l_ac].nmde106,g_nmde2_d[l_ac].nmde111,g_nmde2_d[l_ac].nmde113,g_nmde2_d[l_ac].nmde114, 
                   g_nmde2_d[l_ac].nmde115,g_nmde2_d[l_ac].nmde116,g_nmde3_d[l_ac].nmde121,g_nmde3_d[l_ac].nmde123, 
                   g_nmde3_d[l_ac].nmde124,g_nmde3_d[l_ac].nmde125,g_nmde3_d[l_ac].nmde126,g_nmde4_d[l_ac].nmde015, 
                   g_nmde4_d[l_ac].nmde033,g_nmde4_d[l_ac].nmde006,g_nmde4_d[l_ac].nmde007,g_nmde4_d[l_ac].nmde008, 
                   g_nmde4_d[l_ac].nmde018,g_nmde4_d[l_ac].nmde019,g_nmde4_d[l_ac].nmde009,g_nmde4_d[l_ac].nmde010, 
                   g_nmde4_d[l_ac].nmde020,g_nmde4_d[l_ac].nmde021,g_nmde4_d[l_ac].nmde022,g_nmde4_d[l_ac].nmde011, 
                   g_nmde4_d[l_ac].nmde013,g_nmde4_d[l_ac].nmde014,g_nmde4_d[l_ac].nmde023,g_nmde4_d[l_ac].nmde024, 
                   g_nmde4_d[l_ac].nmde025,g_nmde4_d[l_ac].nmde026,g_nmde4_d[l_ac].nmde027,g_nmde4_d[l_ac].nmde028, 
                   g_nmde4_d[l_ac].nmde029,g_nmde4_d[l_ac].nmde030,g_nmde4_d[l_ac].nmde031,g_nmde4_d[l_ac].nmde032)  
                   #自訂欄位頁簽
                WHERE nmdeent = g_enterprise AND nmdeld = g_nmde_m.nmdeld
                 AND nmde001 = g_nmde_m.nmde001
                 AND nmde002 = g_nmde_m.nmde002
                 AND nmde004 = g_nmde4_d_t.nmde004 #項次 
               #add-point:單身修改中 name="modify.body4.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmde_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmde_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmde_m.nmdeld
               LET gs_keys_bak[1] = g_nmdeld_t
               LET gs_keys[2] = g_nmde_m.nmde001
               LET gs_keys_bak[2] = g_nmde001_t
               LET gs_keys[3] = g_nmde_m.nmde002
               LET gs_keys_bak[3] = g_nmde002_t
               LET gs_keys[4] = g_nmde4_d[g_detail_idx].nmde004
               LET gs_keys_bak[4] = g_nmde4_d_t.nmde004
               CALL anmt820_update_b('nmde_t',gs_keys,gs_keys_bak,"'4'")
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_nmde_m),util.JSON.stringify(g_nmde4_d_t)
                     LET g_log2 = util.JSON.stringify(g_nmde_m),util.JSON.stringify(g_nmde4_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL anmt820_nmde_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="modify.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde015
            
            #add-point:AFTER FIELD nmde015 name="input.a.page4.nmde015"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde015
            #add-point:BEFORE FIELD nmde015 name="input.b.page4.nmde015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde015
            #add-point:ON CHANGE nmde015 name="input.g.page4.nmde015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde015_desc
            #add-point:BEFORE FIELD nmde015_desc name="input.b.page4.nmde015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde015_desc
            
            #add-point:AFTER FIELD nmde015_desc name="input.a.page4.nmde015_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde015_desc
            #add-point:ON CHANGE nmde015_desc name="input.g.page4.nmde015_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde033
            #add-point:BEFORE FIELD nmde033 name="input.b.page4.nmde033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde033
            
            #add-point:AFTER FIELD nmde033 name="input.a.page4.nmde033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde033
            #add-point:ON CHANGE nmde033 name="input.g.page4.nmde033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde006
            #add-point:BEFORE FIELD nmde006 name="input.b.page4.nmde006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde006
            
            #add-point:AFTER FIELD nmde006 name="input.a.page4.nmde006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde006
            #add-point:ON CHANGE nmde006 name="input.g.page4.nmde006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde006_desc
            #add-point:BEFORE FIELD nmde006_desc name="input.b.page4.nmde006_desc"
            LET g_nmde4_d[l_ac].nmde006_desc = g_nmde4_d[l_ac].nmde006 #160326-00001#25 add
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde006_desc
            
            #add-point:AFTER FIELD nmde006_desc name="input.a.page4.nmde006_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde006_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde006_desc <> g_nmde4_d_t.nmde006 OR g_nmde4_d_t.nmde006 IS NULL)) THEN
                  CALL s_department_chk(g_nmde4_d[l_ac].nmde006_desc,g_nmde_m.nmdedocdt) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_nmde4_d[l_ac].nmde006 = g_nmde4_d_t.nmde006
                     LET g_nmde4_d[l_ac].nmde006_desc = g_nmde4_d_t.nmde006_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmde_m.nmdeld,'02',g_nmde4_d[l_ac].nmde015,g_nmde4_d[l_ac].nmde006_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmde4_d[l_ac].nmde006 = g_nmde4_d_t.nmde006
                     LET g_nmde4_d[l_ac].nmde006_desc = g_nmde4_d_t.nmde006_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                   
                  LET g_nmde4_d[l_ac].nmde006 = g_nmde4_d[l_ac].nmde006_desc
                  IF cl_null(g_nmde4_d[l_ac].nmde007) THEN 
                     SELECT ooeg004 INTO g_nmde4_d[l_ac].nmde007 FROM ooeg_t 
                      WHERE ooegent = g_enterprise AND ooeg001 = g_nmde4_d[l_ac].nmde006_desc
                     CALL s_desc_get_department_desc(g_nmde4_d[l_ac].nmde007) RETURNING g_nmde4_d[l_ac].nmde007_desc
                     LET g_nmde4_d[l_ac].nmde007_desc = s_desc_show1(g_nmde4_d[l_ac].nmde007,g_nmde4_d[l_ac].nmde007_desc)
                  END IF
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde006 = g_nmde4_d[l_ac].nmde006_desc
            END IF
            CALL s_desc_get_department_desc(g_nmde4_d[l_ac].nmde006_desc) RETURNING g_nmde4_d[l_ac].nmde006_desc
            LET g_nmde4_d[l_ac].nmde006_desc = s_desc_show1(g_nmde4_d[l_ac].nmde006,g_nmde4_d[l_ac].nmde006_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde006_desc
            #add-point:ON CHANGE nmde006_desc name="input.g.page4.nmde006_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde007
            #add-point:BEFORE FIELD nmde007 name="input.b.page4.nmde007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde007
            
            #add-point:AFTER FIELD nmde007 name="input.a.page4.nmde007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde007
            #add-point:ON CHANGE nmde007 name="input.g.page4.nmde007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde007_desc
            #add-point:BEFORE FIELD nmde007_desc name="input.b.page4.nmde007_desc"
            LET g_nmde4_d[l_ac].nmde007_desc = g_nmde4_d[l_ac].nmde007 #160326-00001#25 add
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde007_desc
            
            #add-point:AFTER FIELD nmde007_desc name="input.a.page4.nmde007_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde007_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde007_desc <> g_nmde4_d_t.nmde007 OR g_nmde4_d_t.nmde007 IS NULL)) THEN
                  CALL s_voucher_glaq019_chk(g_nmde4_d[l_ac].nmde007_desc,g_nmde_m.nmdedocdt)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmde4_d[l_ac].nmde007_desc
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi125'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmde4_d[l_ac].nmde007 = g_nmde4_d_t.nmde007
                     LET g_nmde4_d[l_ac].nmde007_desc = g_nmde4_d_t.nmde007_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmde_m.nmdeld,'03',g_nmde4_d[l_ac].nmde015,g_nmde4_d[l_ac].nmde007_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmde4_d[l_ac].nmde007 = g_nmde4_d_t.nmde007
                     LET g_nmde4_d[l_ac].nmde007_desc = g_nmde4_d_t.nmde007_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                     
                  LET g_nmde4_d[l_ac].nmde007 = g_nmde4_d[l_ac].nmde007_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde007 = g_nmde4_d[l_ac].nmde007_desc
            END IF
            CALL s_desc_get_department_desc(g_nmde4_d[l_ac].nmde007_desc) RETURNING g_nmde4_d[l_ac].nmde007_desc
            LET g_nmde4_d[l_ac].nmde007_desc = s_desc_show1(g_nmde4_d[l_ac].nmde007,g_nmde4_d[l_ac].nmde007_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde007_desc
            #add-point:ON CHANGE nmde007_desc name="input.g.page4.nmde007_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde008
            #add-point:BEFORE FIELD nmde008 name="input.b.page4.nmde008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde008
            
            #add-point:AFTER FIELD nmde008 name="input.a.page4.nmde008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde008
            #add-point:ON CHANGE nmde008 name="input.g.page4.nmde008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde008_desc
            #add-point:BEFORE FIELD nmde008_desc name="input.b.page4.nmde008_desc"
            LET g_nmde4_d[l_ac].nmde008_desc = g_nmde4_d[l_ac].nmde008 #160326-00001#25 add
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde008_desc
            
            #add-point:AFTER FIELD nmde008_desc name="input.a.page4.nmde008_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde008_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde008_desc <> g_nmde4_d_t.nmde008 OR g_nmde4_d_t.nmde008 IS NULL)) THEN
                  CALL s_azzi650_chk_exist('287',g_nmde4_d[l_ac].nmde008_desc) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_nmde4_d[l_ac].nmde008 = g_nmde4_d_t.nmde008
                     LET g_nmde4_d[l_ac].nmde008_desc = g_nmde4_d_t.nmde008_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmde_m.nmdeld,'04',g_nmde4_d[l_ac].nmde015,g_nmde4_d[l_ac].nmde008_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmde4_d[l_ac].nmde008 = g_nmde4_d_t.nmde008
                     LET g_nmde4_d[l_ac].nmde008_desc = g_nmde4_d_t.nmde008_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                  
                  LET g_nmde4_d[l_ac].nmde008 = g_nmde4_d[l_ac].nmde008_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde008 = g_nmde4_d[l_ac].nmde008_desc
            END IF
            CALL s_desc_get_acc_desc('287',g_nmde4_d[l_ac].nmde008_desc) RETURNING g_nmde4_d[l_ac].nmde008_desc
            LET g_nmde4_d[l_ac].nmde008_desc = s_desc_show1(g_nmde4_d[l_ac].nmde008,g_nmde4_d[l_ac].nmde008_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde008_desc
            #add-point:ON CHANGE nmde008_desc name="input.g.page4.nmde008_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde018
            #add-point:BEFORE FIELD nmde018 name="input.b.page4.nmde018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde018
            
            #add-point:AFTER FIELD nmde018 name="input.a.page4.nmde018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde018
            #add-point:ON CHANGE nmde018 name="input.g.page4.nmde018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde018_desc
            #add-point:BEFORE FIELD nmde018_desc name="input.b.page4.nmde018_desc"
            LET g_nmde4_d[l_ac].nmde018_desc = g_nmde4_d[l_ac].nmde018 #160326-00001#25 add
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde018_desc
            
            #add-point:AFTER FIELD nmde018_desc name="input.a.page4.nmde018_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde018_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde018_desc <> g_nmde4_d_t.nmde018 OR g_nmde4_d_t.nmde018 IS NULL)) THEN
                  CALL s_voucher_glaq021_chk(g_nmde4_d[l_ac].nmde018_desc)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmde4_d[l_ac].nmde018_desc
                     LET g_errparam.replace[1] = 'apmm100'
                     LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                     LET g_errparam.exeprog = 'apmm100'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmde4_d[l_ac].nmde018 = g_nmde4_d_t.nmde018
                     LET g_nmde4_d[l_ac].nmde018_desc = g_nmde4_d_t.nmde018_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmde_m.nmdeld,'05',g_nmde4_d[l_ac].nmde015,g_nmde4_d[l_ac].nmde018_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmde4_d[l_ac].nmde018 = g_nmde4_d_t.nmde018
                     LET g_nmde4_d[l_ac].nmde018_desc = g_nmde4_d_t.nmde018_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                   
                  LET g_nmde4_d[l_ac].nmde018 = g_nmde4_d[l_ac].nmde018_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde018 = g_nmde4_d[l_ac].nmde018_desc
            END IF
            CALL s_desc_get_trading_partner_abbr_desc(g_nmde4_d[l_ac].nmde018_desc) RETURNING g_nmde4_d[l_ac].nmde018_desc
            LET g_nmde4_d[l_ac].nmde018_desc = s_desc_show1(g_nmde4_d[l_ac].nmde018,g_nmde4_d[l_ac].nmde018_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde018_desc
            #add-point:ON CHANGE nmde018_desc name="input.g.page4.nmde018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde019
            #add-point:BEFORE FIELD nmde019 name="input.b.page4.nmde019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde019
            
            #add-point:AFTER FIELD nmde019 name="input.a.page4.nmde019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde019
            #add-point:ON CHANGE nmde019 name="input.g.page4.nmde019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde019_desc
            #add-point:BEFORE FIELD nmde019_desc name="input.b.page4.nmde019_desc"
            LET g_nmde4_d[l_ac].nmde019_desc = g_nmde4_d[l_ac].nmde019 #160326-00001#25 add
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde019_desc
            
            #add-point:AFTER FIELD nmde019_desc name="input.a.page4.nmde019_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde019_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde019_desc <> g_nmde4_d_t.nmde019 OR g_nmde4_d_t.nmde019 IS NULL)) THEN
                  CALL s_voucher_glaq021_chk(g_nmde4_d[l_ac].nmde019_desc)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmde4_d[l_ac].nmde019_desc
                     LET g_errparam.replace[1] = 'apmm100'
                     LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                     LET g_errparam.exeprog = 'apmm100'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmde4_d[l_ac].nmde019 = g_nmde4_d_t.nmde019
                     LET g_nmde4_d[l_ac].nmde019_desc = g_nmde4_d_t.nmde019_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmde_m.nmdeld,'06',g_nmde4_d[l_ac].nmde015,g_nmde4_d[l_ac].nmde019_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmde4_d[l_ac].nmde019 = g_nmde4_d_t.nmde019
                     LET g_nmde4_d[l_ac].nmde019_desc = g_nmde4_d_t.nmde019_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                    
                  LET g_nmde4_d[l_ac].nmde019 = g_nmde4_d[l_ac].nmde019_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde019 = g_nmde4_d[l_ac].nmde019_desc
            END IF
            CALL s_desc_get_trading_partner_abbr_desc(g_nmde4_d[l_ac].nmde019_desc) RETURNING g_nmde4_d[l_ac].nmde019_desc
            LET g_nmde4_d[l_ac].nmde019_desc = s_desc_show1(g_nmde4_d[l_ac].nmde019,g_nmde4_d[l_ac].nmde019_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde019_desc
            #add-point:ON CHANGE nmde019_desc name="input.g.page4.nmde019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde009
            #add-point:BEFORE FIELD nmde009 name="input.b.page4.nmde009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde009
            
            #add-point:AFTER FIELD nmde009 name="input.a.page4.nmde009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde009
            #add-point:ON CHANGE nmde009 name="input.g.page4.nmde009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde009_desc
            #add-point:BEFORE FIELD nmde009_desc name="input.b.page4.nmde009_desc"
            LET g_nmde4_d[l_ac].nmde009_desc = g_nmde4_d[l_ac].nmde009 #160326-00001#25 add
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde009_desc
            
            #add-point:AFTER FIELD nmde009_desc name="input.a.page4.nmde009_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde009_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde009_desc <> g_nmde4_d_t.nmde009 OR g_nmde4_d_t.nmde009 IS NULL)) THEN
                  CALL s_azzi650_chk_exist('281',g_nmde4_d[l_ac].nmde009_desc) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_nmde4_d[l_ac].nmde009 = g_nmde4_d_t.nmde009
                     LET g_nmde4_d[l_ac].nmde009_desc = g_nmde4_d_t.nmde009_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmde_m.nmdeld,'07',g_nmde4_d[l_ac].nmde015,g_nmde4_d[l_ac].nmde009_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmde4_d[l_ac].nmde009 = g_nmde4_d_t.nmde009
                     LET g_nmde4_d[l_ac].nmde009_desc = g_nmde4_d_t.nmde009_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                    
                  LET g_nmde4_d[l_ac].nmde009 = g_nmde4_d[l_ac].nmde009_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde009 = g_nmde4_d[l_ac].nmde009_desc
            END IF
            CALL s_desc_get_acc_desc('281',g_nmde4_d[l_ac].nmde009_desc) RETURNING g_nmde4_d[l_ac].nmde009_desc
            LET g_nmde4_d[l_ac].nmde009_desc = s_desc_show1(g_nmde4_d[l_ac].nmde009,g_nmde4_d[l_ac].nmde009_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde009_desc
            #add-point:ON CHANGE nmde009_desc name="input.g.page4.nmde009_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde010
            #add-point:BEFORE FIELD nmde010 name="input.b.page4.nmde010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde010
            
            #add-point:AFTER FIELD nmde010 name="input.a.page4.nmde010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde010
            #add-point:ON CHANGE nmde010 name="input.g.page4.nmde010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde010_desc
            #add-point:BEFORE FIELD nmde010_desc name="input.b.page4.nmde010_desc"
            LET g_nmde4_d[l_ac].nmde010_desc = g_nmde4_d[l_ac].nmde010 #160326-00001#25 add
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde010_desc
            
            #add-point:AFTER FIELD nmde010_desc name="input.a.page4.nmde010_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde010_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde010_desc <> g_nmde4_d_t.nmde010 OR g_nmde4_d_t.nmde010 IS NULL)) THEN
                  CALL s_voucher_glaq024_chk(g_nmde4_d[l_ac].nmde010_desc) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmde4_d[l_ac].nmde010_desc
                     LET g_errparam.replace[1] = 'arti202'
                     LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                     LET g_errparam.exeprog = 'arti202'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmde4_d[l_ac].nmde010 = g_nmde4_d_t.nmde010
                     LET g_nmde4_d[l_ac].nmde010_desc = g_nmde4_d_t.nmde010_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmde_m.nmdeld,'08',g_nmde4_d[l_ac].nmde015,g_nmde4_d[l_ac].nmde010_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmde4_d[l_ac].nmde010 = g_nmde4_d_t.nmde010
                     LET g_nmde4_d[l_ac].nmde010_desc = g_nmde4_d_t.nmde010_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                   
                  LET g_nmde4_d[l_ac].nmde010 = g_nmde4_d[l_ac].nmde010_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde010 = g_nmde4_d[l_ac].nmde010_desc
            END IF
            CALL s_desc_get_rtaxl003_desc(g_nmde4_d[l_ac].nmde010_desc) RETURNING g_nmde4_d[l_ac].nmde010_desc
            LET g_nmde4_d[l_ac].nmde010_desc = s_desc_show1(g_nmde4_d[l_ac].nmde010,g_nmde4_d[l_ac].nmde010_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde010_desc
            #add-point:ON CHANGE nmde010_desc name="input.g.page4.nmde010_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde020
            #add-point:BEFORE FIELD nmde020 name="input.b.page4.nmde020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde020
            
            #add-point:AFTER FIELD nmde020 name="input.a.page4.nmde020"
            #161221-00054#3 add s---
            IF NOT cl_null(g_nmde4_d[l_ac].nmde020) THEN 
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_nmde_m.nmdeld,'09',g_nmde4_d[l_ac].nmde015,g_nmde4_d[l_ac].nmde020) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_nmde4_d[l_ac].nmde020 = g_nmde4_d_t.nmde020
                  NEXT FIELD CURRENT
               END IF
            END IF      
            #161221-00054#3 add e--- 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde020
            #add-point:ON CHANGE nmde020 name="input.g.page4.nmde020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde021
            #add-point:BEFORE FIELD nmde021 name="input.b.page4.nmde021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde021
            
            #add-point:AFTER FIELD nmde021 name="input.a.page4.nmde021"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde021
            #add-point:ON CHANGE nmde021 name="input.g.page4.nmde021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde021_desc
            #add-point:BEFORE FIELD nmde021_desc name="input.b.page4.nmde021_desc"
            LET g_nmde4_d[l_ac].nmde021_desc = g_nmde4_d[l_ac].nmde021 #160326-00001#25 add
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde021_desc
            
            #add-point:AFTER FIELD nmde021_desc name="input.a.page4.nmde021_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde021_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde021_desc <> g_nmde4_d_t.nmde021 OR g_nmde4_d_t.nmde021 IS NULL)) THEN
                  CALL s_voucher_glaq052_chk(g_nmde4_d[l_ac].nmde021_desc) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmde4_d[l_ac].nmde021_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmde4_d[l_ac].nmde021 = g_nmde4_d_t.nmde021
                     LET g_nmde4_d[l_ac].nmde021_desc = g_nmde4_d_t.nmde021_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmde_m.nmdeld,'10',g_nmde4_d[l_ac].nmde015,g_nmde4_d[l_ac].nmde021_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmde4_d[l_ac].nmde021 = g_nmde4_d_t.nmde021
                     LET g_nmde4_d[l_ac].nmde021_desc = g_nmde4_d_t.nmde021_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                    
                  LET g_nmde4_d[l_ac].nmde021 = g_nmde4_d[l_ac].nmde021_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde021 = g_nmde4_d[l_ac].nmde021_desc
            END IF
            CALL s_desc_get_oojdl003_desc(g_nmde4_d[l_ac].nmde021_desc) RETURNING g_nmde4_d[l_ac].nmde021_desc
            LET g_nmde4_d[l_ac].nmde021_desc = s_desc_show1(g_nmde4_d[l_ac].nmde021,g_nmde4_d[l_ac].nmde021_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde021_desc
            #add-point:ON CHANGE nmde021_desc name="input.g.page4.nmde021_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde022
            #add-point:BEFORE FIELD nmde022 name="input.b.page4.nmde022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde022
            
            #add-point:AFTER FIELD nmde022 name="input.a.page4.nmde022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde022
            #add-point:ON CHANGE nmde022 name="input.g.page4.nmde022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde022_desc
            #add-point:BEFORE FIELD nmde022_desc name="input.b.page4.nmde022_desc"
            LET g_nmde4_d[l_ac].nmde022_desc = g_nmde4_d[l_ac].nmde022 #160326-00001#25 add
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde022_desc
            
            #add-point:AFTER FIELD nmde022_desc name="input.a.page4.nmde022_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde022_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde022_desc <> g_nmde4_d_t.nmde022 OR g_nmde4_d_t.nmde022 IS NULL)) THEN
                  CALL s_azzi650_chk_exist('2002',g_nmde4_d[l_ac].nmde022_desc) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_nmde4_d[l_ac].nmde022 = g_nmde4_d_t.nmde022
                     LET g_nmde4_d[l_ac].nmde022_desc = g_nmde4_d_t.nmde022_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmde_m.nmdeld,'11',g_nmde4_d[l_ac].nmde015,g_nmde4_d[l_ac].nmde022_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmde4_d[l_ac].nmde022 = g_nmde4_d_t.nmde022
                     LET g_nmde4_d[l_ac].nmde022_desc = g_nmde4_d_t.nmde022_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                    
                  LET g_nmde4_d[l_ac].nmde022 = g_nmde4_d[l_ac].nmde022_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde022 = g_nmde4_d[l_ac].nmde022_desc
            END IF
            CALL s_desc_get_acc_desc('2002',g_nmde4_d[l_ac].nmde022_desc) RETURNING g_nmde4_d[l_ac].nmde022_desc
            LET g_nmde4_d[l_ac].nmde022_desc = s_desc_show1(g_nmde4_d[l_ac].nmde022,g_nmde4_d[l_ac].nmde022_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde022_desc
            #add-point:ON CHANGE nmde022_desc name="input.g.page4.nmde022_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde011
            #add-point:BEFORE FIELD nmde011 name="input.b.page4.nmde011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde011
            
            #add-point:AFTER FIELD nmde011 name="input.a.page4.nmde011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde011
            #add-point:ON CHANGE nmde011 name="input.g.page4.nmde011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde011_desc
            #add-point:BEFORE FIELD nmde011_desc name="input.b.page4.nmde011_desc"
            LET g_nmde4_d[l_ac].nmde011_desc = g_nmde4_d[l_ac].nmde011 #160326-00001#25 add
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde011_desc
            
            #add-point:AFTER FIELD nmde011_desc name="input.a.page4.nmde011_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde011_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde011_desc <> g_nmde4_d_t.nmde011 OR g_nmde4_d_t.nmde011 IS NULL)) THEN
                  CALL s_employee_chk(g_nmde4_d[l_ac].nmde011_desc) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_nmde4_d[l_ac].nmde011 = g_nmde4_d_t.nmde011
                     LET g_nmde4_d[l_ac].nmde011_desc = g_nmde4_d_t.nmde011_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmde_m.nmdeld,'12',g_nmde4_d[l_ac].nmde015,g_nmde4_d[l_ac].nmde011_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmde4_d[l_ac].nmde011 = g_nmde4_d_t.nmde011
                     LET g_nmde4_d[l_ac].nmde011_desc = g_nmde4_d_t.nmde011_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                       
                  LET g_nmde4_d[l_ac].nmde011 = g_nmde4_d[l_ac].nmde011_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde011 = g_nmde4_d[l_ac].nmde011_desc
            END IF
            CALL s_desc_get_person_desc(g_nmde4_d[l_ac].nmde011_desc) RETURNING g_nmde4_d[l_ac].nmde011_desc
            LET g_nmde4_d[l_ac].nmde011_desc = s_desc_show1(g_nmde4_d[l_ac].nmde011,g_nmde4_d[l_ac].nmde011_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde011_desc
            #add-point:ON CHANGE nmde011_desc name="input.g.page4.nmde011_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde013
            #add-point:BEFORE FIELD nmde013 name="input.b.page4.nmde013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde013
            
            #add-point:AFTER FIELD nmde013 name="input.a.page4.nmde013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde013
            #add-point:ON CHANGE nmde013 name="input.g.page4.nmde013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde013_desc
            #add-point:BEFORE FIELD nmde013_desc name="input.b.page4.nmde013_desc"
            LET g_nmde4_d[l_ac].nmde013_desc = g_nmde4_d[l_ac].nmde013 #160326-00001#25 add
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde013_desc
            
            #add-point:AFTER FIELD nmde013_desc name="input.a.page4.nmde013_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde013_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde013_desc <> g_nmde4_d_t.nmde013 OR g_nmde4_d_t.nmde013 IS NULL)) THEN
                  CALL s_aap_project_chk(g_nmde4_d[l_ac].nmde013_desc) RETURNING l_success,g_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmde4_d[l_ac].nmde013_desc
                     LET g_errparam.replace[1] = 'apjm200'
                     LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                     LET g_errparam.exeprog = 'apjm200'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmde4_d[l_ac].nmde013 = g_nmde4_d_t.nmde013
                     LET g_nmde4_d[l_ac].nmde013_desc = g_nmde4_d_t.nmde013_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmde_m.nmdeld,'13',g_nmde4_d[l_ac].nmde015,g_nmde4_d[l_ac].nmde013_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmde4_d[l_ac].nmde013 = g_nmde4_d_t.nmde013
                     LET g_nmde4_d[l_ac].nmde013_desc = g_nmde4_d_t.nmde013_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                    
                  LET g_nmde4_d[l_ac].nmde013 = g_nmde4_d[l_ac].nmde013_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde013 = g_nmde4_d[l_ac].nmde013_desc
            END IF
            CALL s_desc_get_project_desc(g_nmde4_d[l_ac].nmde013_desc) RETURNING g_nmde4_d[l_ac].nmde013_desc
            LET g_nmde4_d[l_ac].nmde013_desc = s_desc_show1(g_nmde4_d[l_ac].nmde013,g_nmde4_d[l_ac].nmde013_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde013_desc
            #add-point:ON CHANGE nmde013_desc name="input.g.page4.nmde013_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde014
            #add-point:BEFORE FIELD nmde014 name="input.b.page4.nmde014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde014
            
            #add-point:AFTER FIELD nmde014 name="input.a.page4.nmde014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde014
            #add-point:ON CHANGE nmde014 name="input.g.page4.nmde014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde014_desc
            #add-point:BEFORE FIELD nmde014_desc name="input.b.page4.nmde014_desc"
            LET g_nmde4_d[l_ac].nmde014_desc = g_nmde4_d[l_ac].nmde014 #160326-00001#25 add
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde014_desc
            
            #add-point:AFTER FIELD nmde014_desc name="input.a.page4.nmde014_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde014_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde014_desc <> g_nmde4_d_t.nmde014 OR g_nmde4_d_t.nmde014 IS NULL)) THEN
                  CALL s_voucher_glaq028_chk(g_nmde4_d[l_ac].nmde013,g_nmde4_d[l_ac].nmde014_desc)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmde4_d[l_ac].nmde014_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmde4_d[l_ac].nmde014 = g_nmde4_d_t.nmde014
                     LET g_nmde4_d[l_ac].nmde014_desc = g_nmde4_d_t.nmde014_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add s---
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_nmde_m.nmdeld,'14',g_nmde4_d[l_ac].nmde015,g_nmde4_d[l_ac].nmde014_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmde4_d[l_ac].nmde014 = g_nmde4_d_t.nmde014
                     LET g_nmde4_d[l_ac].nmde014_desc = g_nmde4_d_t.nmde014_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#3 add e---                   
                  LET g_nmde4_d[l_ac].nmde014 = g_nmde4_d[l_ac].nmde014_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde014 = g_nmde4_d[l_ac].nmde014_desc
            END IF
            CALL s_desc_get_wbs_desc(g_nmde4_d[l_ac].nmde013,g_nmde4_d[l_ac].nmde014_desc) RETURNING g_nmde4_d[l_ac].nmde014_desc
            LET g_nmde4_d[l_ac].nmde014_desc = s_desc_show1(g_nmde4_d[l_ac].nmde014,g_nmde4_d[l_ac].nmde014_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde014_desc
            #add-point:ON CHANGE nmde014_desc name="input.g.page4.nmde014_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde023
            #add-point:BEFORE FIELD nmde023 name="input.b.page4.nmde023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde023
            
            #add-point:AFTER FIELD nmde023 name="input.a.page4.nmde023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde023
            #add-point:ON CHANGE nmde023 name="input.g.page4.nmde023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde023_desc
            #add-point:BEFORE FIELD nmde023_desc name="input.b.page4.nmde023_desc"
            #160326-00001#25--add--str--
            LET g_nmde4_d[l_ac].nmde023_desc = g_nmde4_d[l_ac].nmde023 
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET l_glae002 = ''
            LET l_glae009 = ''
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad.glad0171
             IF l_glae002 = '1' THEN
                SELECT glae009 INTO l_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0171
             END IF 
             IF l_glae002 = '2' THEN
                LET l_glae009 = 'q_glaf002'
             END IF 
             
             IF l_glae002 = '3' THEN
                LET l_glae009 = ''
             END IF
             #160326-00001#25--add--end
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde023_desc
            
            #add-point:AFTER FIELD nmde023_desc name="input.a.page4.nmde023_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde023_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde023_desc <> g_nmde4_d_t.nmde023 OR g_nmde4_d_t.nmde023 IS NULL)) THEN
                  CALL s_voucher_free_account_chk(l_glad.glad0171,g_nmde4_d[l_ac].nmde023_desc,l_glad.glad0172) RETURNING l_errno
                  IF NOT cl_null(l_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_nmde4_d[l_ac].nmde023_desc
                     LET g_errparam.replace[1] = 'agli041'
                     LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                     LET g_errparam.exeprog = 'agli041'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmde4_d[l_ac].nmde023 = g_nmde4_d_t.nmde023
                     LET g_nmde4_d[l_ac].nmde023_desc = g_nmde4_d_t.nmde023_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_nmde4_d[l_ac].nmde023 = g_nmde4_d[l_ac].nmde023_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde023 = g_nmde4_d[l_ac].nmde023_desc
            END IF
            CALL s_voucher_free_account_desc(l_glad.glad0171,g_nmde4_d[l_ac].nmde023_desc) RETURNING g_nmde4_d[l_ac].nmde023_desc
            LET g_nmde4_d[l_ac].nmde023_desc = s_desc_show1(g_nmde4_d[l_ac].nmde023,g_nmde4_d[l_ac].nmde023_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde023_desc
            #add-point:ON CHANGE nmde023_desc name="input.g.page4.nmde023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde024
            #add-point:BEFORE FIELD nmde024 name="input.b.page4.nmde024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde024
            
            #add-point:AFTER FIELD nmde024 name="input.a.page4.nmde024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde024
            #add-point:ON CHANGE nmde024 name="input.g.page4.nmde024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde024_desc
            #add-point:BEFORE FIELD nmde024_desc name="input.b.page4.nmde024_desc"
            #160326-00001#25--add--str--
            LET g_nmde4_d[l_ac].nmde024_desc = g_nmde4_d[l_ac].nmde024 
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET l_glae002 = ''
            LET l_glae009 = ''
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad.glad0181
             IF l_glae002 = '1' THEN
                SELECT glae009 INTO l_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0171
             END IF 
             IF l_glae002 = '2' THEN
                LET l_glae009 = 'q_glaf002'
             END IF 
             
             IF l_glae002 = '3' THEN
                LET l_glae009 = ''
             END IF
             #160326-00001#25--add--end
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde024_desc
            
            #add-point:AFTER FIELD nmde024_desc name="input.a.page4.nmde024_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde024_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde024_desc <> g_nmde4_d_t.nmde024 OR g_nmde4_d_t.nmde024 IS NULL)) THEN
                  CALL s_voucher_free_account_chk(l_glad.glad0181,g_nmde4_d[l_ac].nmde024_desc,l_glad.glad0182) RETURNING l_errno
                  IF NOT cl_null(l_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_nmde4_d[l_ac].nmde024_desc
                     LET g_errparam.replace[1] = 'agli041'
                     LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                     LET g_errparam.exeprog = 'agli041'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmde4_d[l_ac].nmde024 = g_nmde4_d_t.nmde024
                     LET g_nmde4_d[l_ac].nmde024_desc = g_nmde4_d_t.nmde024_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_nmde4_d[l_ac].nmde024 = g_nmde4_d[l_ac].nmde024_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde024 = g_nmde4_d[l_ac].nmde024_desc
            END IF
            CALL s_voucher_free_account_desc(l_glad.glad0181,g_nmde4_d[l_ac].nmde024_desc) RETURNING g_nmde4_d[l_ac].nmde024_desc
            LET g_nmde4_d[l_ac].nmde024_desc = s_desc_show1(g_nmde4_d[l_ac].nmde024,g_nmde4_d[l_ac].nmde024_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde024_desc
            #add-point:ON CHANGE nmde024_desc name="input.g.page4.nmde024_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde025
            #add-point:BEFORE FIELD nmde025 name="input.b.page4.nmde025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde025
            
            #add-point:AFTER FIELD nmde025 name="input.a.page4.nmde025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde025
            #add-point:ON CHANGE nmde025 name="input.g.page4.nmde025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde025_desc
            #add-point:BEFORE FIELD nmde025_desc name="input.b.page4.nmde025_desc"
            #160326-00001#25--add--str--
            LET g_nmde4_d[l_ac].nmde025_desc = g_nmde4_d[l_ac].nmde025 
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET l_glae002 = ''
            LET l_glae009 = ''
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad.glad0191
             IF l_glae002 = '1' THEN
                SELECT glae009 INTO l_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0171
             END IF 
             IF l_glae002 = '2' THEN
                LET l_glae009 = 'q_glaf002'
             END IF 
             
             IF l_glae002 = '3' THEN
                LET l_glae009 = ''
             END IF
             #160326-00001#25--add--end
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde025_desc
            
            #add-point:AFTER FIELD nmde025_desc name="input.a.page4.nmde025_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde025_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde025_desc <> g_nmde4_d_t.nmde025 OR g_nmde4_d_t.nmde025 IS NULL)) THEN
                  CALL s_voucher_free_account_chk(l_glad.glad0191,g_nmde4_d[l_ac].nmde025_desc,l_glad.glad0192) RETURNING l_errno
                  IF NOT cl_null(l_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_nmde4_d[l_ac].nmde025_desc
                     LET g_errparam.replace[1] = 'agli041'
                     LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                     LET g_errparam.exeprog = 'agli041'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmde4_d[l_ac].nmde025 = g_nmde4_d_t.nmde025
                     LET g_nmde4_d[l_ac].nmde025_desc = g_nmde4_d_t.nmde025_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_nmde4_d[l_ac].nmde025 = g_nmde4_d[l_ac].nmde025_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde025 = g_nmde4_d[l_ac].nmde025_desc
            END IF
            CALL s_voucher_free_account_desc(l_glad.glad0191,g_nmde4_d[l_ac].nmde025_desc) RETURNING g_nmde4_d[l_ac].nmde025_desc
            LET g_nmde4_d[l_ac].nmde025_desc = s_desc_show1(g_nmde4_d[l_ac].nmde025,g_nmde4_d[l_ac].nmde025_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde025_desc
            #add-point:ON CHANGE nmde025_desc name="input.g.page4.nmde025_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde026
            #add-point:BEFORE FIELD nmde026 name="input.b.page4.nmde026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde026
            
            #add-point:AFTER FIELD nmde026 name="input.a.page4.nmde026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde026
            #add-point:ON CHANGE nmde026 name="input.g.page4.nmde026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde026_desc
            #add-point:BEFORE FIELD nmde026_desc name="input.b.page4.nmde026_desc"
            #160326-00001#25--add--str--
            LET g_nmde4_d[l_ac].nmde026_desc = g_nmde4_d[l_ac].nmde026 
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET l_glae002 = ''
            LET l_glae009 = ''
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad.glad0201
             IF l_glae002 = '1' THEN
                SELECT glae009 INTO l_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0171
             END IF 
             IF l_glae002 = '2' THEN
                LET l_glae009 = 'q_glaf002'
             END IF 
             
             IF l_glae002 = '3' THEN
                LET l_glae009 = ''
             END IF
             #160326-00001#25--add--end
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde026_desc
            
            #add-point:AFTER FIELD nmde026_desc name="input.a.page4.nmde026_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde026_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde026_desc <> g_nmde4_d_t.nmde026 OR g_nmde4_d_t.nmde026 IS NULL)) THEN
                  CALL s_voucher_free_account_chk(l_glad.glad0201,g_nmde4_d[l_ac].nmde026_desc,l_glad.glad0202) RETURNING l_errno
                  IF NOT cl_null(l_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_nmde4_d[l_ac].nmde026_desc
                     LET g_errparam.replace[1] = 'agli041'
                     LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                     LET g_errparam.exeprog = 'agli041'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmde4_d[l_ac].nmde026 = g_nmde4_d_t.nmde026
                     LET g_nmde4_d[l_ac].nmde026_desc = g_nmde4_d_t.nmde026_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_nmde4_d[l_ac].nmde026 = g_nmde4_d[l_ac].nmde026_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde026 = g_nmde4_d[l_ac].nmde026_desc
            END IF
            CALL s_voucher_free_account_desc(l_glad.glad0201,g_nmde4_d[l_ac].nmde026_desc) RETURNING g_nmde4_d[l_ac].nmde026_desc
            LET g_nmde4_d[l_ac].nmde026_desc = s_desc_show1(g_nmde4_d[l_ac].nmde026,g_nmde4_d[l_ac].nmde026_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde026_desc
            #add-point:ON CHANGE nmde026_desc name="input.g.page4.nmde026_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde027
            #add-point:BEFORE FIELD nmde027 name="input.b.page4.nmde027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde027
            
            #add-point:AFTER FIELD nmde027 name="input.a.page4.nmde027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde027
            #add-point:ON CHANGE nmde027 name="input.g.page4.nmde027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde027_desc
            #add-point:BEFORE FIELD nmde027_desc name="input.b.page4.nmde027_desc"
            #160326-00001#25--add--str--
            LET g_nmde4_d[l_ac].nmde027_desc = g_nmde4_d[l_ac].nmde027 
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET l_glae002 = ''
            LET l_glae009 = ''
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad.glad0211
             IF l_glae002 = '1' THEN
                SELECT glae009 INTO l_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0171
             END IF 
             IF l_glae002 = '2' THEN
                LET l_glae009 = 'q_glaf002'
             END IF 
             
             IF l_glae002 = '3' THEN
                LET l_glae009 = ''
             END IF
             #160326-00001#25--add--end
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde027_desc
            
            #add-point:AFTER FIELD nmde027_desc name="input.a.page4.nmde027_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde027_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde027_desc <> g_nmde4_d_t.nmde027 OR g_nmde4_d_t.nmde027 IS NULL)) THEN
                  CALL s_voucher_free_account_chk(l_glad.glad0211,g_nmde4_d[l_ac].nmde027_desc,l_glad.glad0212) RETURNING l_errno
                  IF NOT cl_null(l_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_nmde4_d[l_ac].nmde027_desc
                     LET g_errparam.replace[1] = 'agli041'
                     LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                     LET g_errparam.exeprog = 'agli041'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmde4_d[l_ac].nmde027 = g_nmde4_d_t.nmde027
                     LET g_nmde4_d[l_ac].nmde027_desc = g_nmde4_d_t.nmde027_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_nmde4_d[l_ac].nmde027 = g_nmde4_d[l_ac].nmde027_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde027 = g_nmde4_d[l_ac].nmde027_desc
            END IF
            CALL s_voucher_free_account_desc(l_glad.glad0211,g_nmde4_d[l_ac].nmde027_desc) RETURNING g_nmde4_d[l_ac].nmde027_desc
            LET g_nmde4_d[l_ac].nmde027_desc = s_desc_show1(g_nmde4_d[l_ac].nmde027,g_nmde4_d[l_ac].nmde027_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde027_desc
            #add-point:ON CHANGE nmde027_desc name="input.g.page4.nmde027_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde028
            #add-point:BEFORE FIELD nmde028 name="input.b.page4.nmde028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde028
            
            #add-point:AFTER FIELD nmde028 name="input.a.page4.nmde028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde028
            #add-point:ON CHANGE nmde028 name="input.g.page4.nmde028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde028_desc
            #add-point:BEFORE FIELD nmde028_desc name="input.b.page4.nmde028_desc"
            #160326-00001#25--add--str--
            LET g_nmde4_d[l_ac].nmde028_desc = g_nmde4_d[l_ac].nmde028 
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET l_glae002 = ''
            LET l_glae009 = ''
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad.glad0221
             IF l_glae002 = '1' THEN
                SELECT glae009 INTO l_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0171
             END IF 
             IF l_glae002 = '2' THEN
                LET l_glae009 = 'q_glaf002'
             END IF 
             
             IF l_glae002 = '3' THEN
                LET l_glae009 = ''
             END IF
             #160326-00001#25--add--end
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde028_desc
            
            #add-point:AFTER FIELD nmde028_desc name="input.a.page4.nmde028_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde028_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde028_desc <> g_nmde4_d_t.nmde028 OR g_nmde4_d_t.nmde028 IS NULL)) THEN
                  CALL s_voucher_free_account_chk(l_glad.glad0221,g_nmde4_d[l_ac].nmde028_desc,l_glad.glad0222) RETURNING l_errno
                  IF NOT cl_null(l_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_nmde4_d[l_ac].nmde028_desc
                     LET g_errparam.replace[1] = 'agli041'
                     LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                     LET g_errparam.exeprog = 'agli041'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmde4_d[l_ac].nmde028 = g_nmde4_d_t.nmde028
                     LET g_nmde4_d[l_ac].nmde028_desc = g_nmde4_d_t.nmde028_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_nmde4_d[l_ac].nmde028 = g_nmde4_d[l_ac].nmde028_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde028 = g_nmde4_d[l_ac].nmde028_desc
            END IF
            CALL s_voucher_free_account_desc(l_glad.glad0221,g_nmde4_d[l_ac].nmde028_desc) RETURNING g_nmde4_d[l_ac].nmde028_desc
            LET g_nmde4_d[l_ac].nmde028_desc = s_desc_show1(g_nmde4_d[l_ac].nmde028,g_nmde4_d[l_ac].nmde028_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde028_desc
            #add-point:ON CHANGE nmde028_desc name="input.g.page4.nmde028_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde029
            #add-point:BEFORE FIELD nmde029 name="input.b.page4.nmde029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde029
            
            #add-point:AFTER FIELD nmde029 name="input.a.page4.nmde029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde029
            #add-point:ON CHANGE nmde029 name="input.g.page4.nmde029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde029_desc
            #add-point:BEFORE FIELD nmde029_desc name="input.b.page4.nmde029_desc"
            #160326-00001#25--add--str--
            LET g_nmde4_d[l_ac].nmde029_desc = g_nmde4_d[l_ac].nmde029 
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET l_glae002 = ''
            LET l_glae009 = ''
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad.glad0231
             IF l_glae002 = '1' THEN
                SELECT glae009 INTO l_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0171
             END IF 
             IF l_glae002 = '2' THEN
                LET l_glae009 = 'q_glaf002'
             END IF 
             
             IF l_glae002 = '3' THEN
                LET l_glae009 = ''
             END IF
             #160326-00001#25--add--end
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde029_desc
            
            #add-point:AFTER FIELD nmde029_desc name="input.a.page4.nmde029_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde029_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde029_desc <> g_nmde4_d_t.nmde029 OR g_nmde4_d_t.nmde029 IS NULL)) THEN
                  CALL s_voucher_free_account_chk(l_glad.glad0231,g_nmde4_d[l_ac].nmde029_desc,l_glad.glad0232) RETURNING l_errno
                  IF NOT cl_null(l_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_nmde4_d[l_ac].nmde029_desc
                     LET g_errparam.replace[1] = 'agli041'
                     LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                     LET g_errparam.exeprog = 'agli041'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmde4_d[l_ac].nmde029 = g_nmde4_d_t.nmde029
                     LET g_nmde4_d[l_ac].nmde029_desc = g_nmde4_d_t.nmde029_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_nmde4_d[l_ac].nmde029 = g_nmde4_d[l_ac].nmde029_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde029 = g_nmde4_d[l_ac].nmde029_desc
            END IF
            CALL s_voucher_free_account_desc(l_glad.glad0231,g_nmde4_d[l_ac].nmde029_desc) RETURNING g_nmde4_d[l_ac].nmde029_desc
            LET g_nmde4_d[l_ac].nmde029_desc = s_desc_show1(g_nmde4_d[l_ac].nmde029,g_nmde4_d[l_ac].nmde029_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde029_desc
            #add-point:ON CHANGE nmde029_desc name="input.g.page4.nmde029_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde030
            #add-point:BEFORE FIELD nmde030 name="input.b.page4.nmde030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde030
            
            #add-point:AFTER FIELD nmde030 name="input.a.page4.nmde030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde030
            #add-point:ON CHANGE nmde030 name="input.g.page4.nmde030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde030_desc
            #add-point:BEFORE FIELD nmde030_desc name="input.b.page4.nmde030_desc"
            #160326-00001#25--add--str--
            LET g_nmde4_d[l_ac].nmde030_desc = g_nmde4_d[l_ac].nmde030 
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET l_glae002 = ''
            LET l_glae009 = ''
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad.glad0241
             IF l_glae002 = '1' THEN
                SELECT glae009 INTO l_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0171
             END IF 
             IF l_glae002 = '2' THEN
                LET l_glae009 = 'q_glaf002'
             END IF 
             
             IF l_glae002 = '3' THEN
                LET l_glae009 = ''
             END IF
             #160326-00001#25--add--end
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde030_desc
            
            #add-point:AFTER FIELD nmde030_desc name="input.a.page4.nmde030_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde030_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde030_desc <> g_nmde4_d_t.nmde030 OR g_nmde4_d_t.nmde030 IS NULL)) THEN
                  CALL s_voucher_free_account_chk(l_glad.glad0241,g_nmde4_d[l_ac].nmde030_desc,l_glad.glad0242) RETURNING l_errno
                  IF NOT cl_null(l_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_nmde4_d[l_ac].nmde030_desc
                     LET g_errparam.replace[1] = 'agli041'
                     LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                     LET g_errparam.exeprog = 'agli041'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmde4_d[l_ac].nmde030 = g_nmde4_d_t.nmde030
                     LET g_nmde4_d[l_ac].nmde030_desc = g_nmde4_d_t.nmde030_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_nmde4_d[l_ac].nmde030 = g_nmde4_d[l_ac].nmde030_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde030 = g_nmde4_d[l_ac].nmde030_desc
            END IF
            CALL s_voucher_free_account_desc(l_glad.glad0241,g_nmde4_d[l_ac].nmde030_desc) RETURNING g_nmde4_d[l_ac].nmde030_desc
            LET g_nmde4_d[l_ac].nmde030_desc = s_desc_show1(g_nmde4_d[l_ac].nmde030,g_nmde4_d[l_ac].nmde030_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde030_desc
            #add-point:ON CHANGE nmde030_desc name="input.g.page4.nmde030_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde031
            #add-point:BEFORE FIELD nmde031 name="input.b.page4.nmde031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde031
            
            #add-point:AFTER FIELD nmde031 name="input.a.page4.nmde031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde031
            #add-point:ON CHANGE nmde031 name="input.g.page4.nmde031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde031_desc
            #add-point:BEFORE FIELD nmde031_desc name="input.b.page4.nmde031_desc"
            #160326-00001#25--add--str--
            LET g_nmde4_d[l_ac].nmde031_desc = g_nmde4_d[l_ac].nmde031 
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET l_glae002 = ''
            LET l_glae009 = ''
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad.glad0251
             IF l_glae002 = '1' THEN
                SELECT glae009 INTO l_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0171
             END IF 
             IF l_glae002 = '2' THEN
                LET l_glae009 = 'q_glaf002'
             END IF 
             
             IF l_glae002 = '3' THEN
                LET l_glae009 = ''
             END IF
             #160326-00001#25--add--end
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde031_desc
            
            #add-point:AFTER FIELD nmde031_desc name="input.a.page4.nmde031_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde031_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde031_desc <> g_nmde4_d_t.nmde031 OR g_nmde4_d_t.nmde031 IS NULL)) THEN
                  CALL s_voucher_free_account_chk(l_glad.glad0251,g_nmde4_d[l_ac].nmde031_desc,l_glad.glad0252) RETURNING l_errno
                  IF NOT cl_null(l_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_nmde4_d[l_ac].nmde031_desc
                     LET g_errparam.replace[1] = 'agli041'
                     LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                     LET g_errparam.exeprog = 'agli041'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmde4_d[l_ac].nmde031 = g_nmde4_d_t.nmde031
                     LET g_nmde4_d[l_ac].nmde031_desc = g_nmde4_d_t.nmde031_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_nmde4_d[l_ac].nmde031 = g_nmde4_d[l_ac].nmde031_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde031 = g_nmde4_d[l_ac].nmde031_desc
            END IF
            CALL s_voucher_free_account_desc(l_glad.glad0251,g_nmde4_d[l_ac].nmde031_desc) RETURNING g_nmde4_d[l_ac].nmde031_desc
            LET g_nmde4_d[l_ac].nmde031_desc = s_desc_show1(g_nmde4_d[l_ac].nmde031,g_nmde4_d[l_ac].nmde031_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde031_desc
            #add-point:ON CHANGE nmde031_desc name="input.g.page4.nmde031_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde032
            #add-point:BEFORE FIELD nmde032 name="input.b.page4.nmde032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde032
            
            #add-point:AFTER FIELD nmde032 name="input.a.page4.nmde032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde032
            #add-point:ON CHANGE nmde032 name="input.g.page4.nmde032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde032_desc
            #add-point:BEFORE FIELD nmde032_desc name="input.b.page4.nmde032_desc"
            #160326-00001#25--add--str--
            LET g_nmde4_d[l_ac].nmde032_desc = g_nmde4_d[l_ac].nmde032 
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET l_glae002 = ''
            LET l_glae009 = ''
            SELECT glae002 INTO l_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = l_glad.glad0261
             IF l_glae002 = '1' THEN
                SELECT glae009 INTO l_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0171
             END IF 
             IF l_glae002 = '2' THEN
                LET l_glae009 = 'q_glaf002'
             END IF 
             
             IF l_glae002 = '3' THEN
                LET l_glae009 = ''
             END IF
             #160326-00001#25--add--end
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde032_desc
            
            #add-point:AFTER FIELD nmde032_desc name="input.a.page4.nmde032_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde032_desc) THEN
               IF l_cmd='a' OR (l_cmd='u' AND (g_nmde4_d[l_ac].nmde032_desc <> g_nmde4_d_t.nmde032 OR g_nmde4_d_t.nmde032 IS NULL)) THEN
                  CALL s_voucher_free_account_chk(l_glad.glad0261,g_nmde4_d[l_ac].nmde032_desc,l_glad.glad0262) RETURNING l_errno
                  IF NOT cl_null(l_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_nmde4_d[l_ac].nmde032_desc
                     LET g_errparam.replace[1] = 'agli041'
                     LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                     LET g_errparam.exeprog = 'agli041'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmde4_d[l_ac].nmde032 = g_nmde4_d_t.nmde032
                     LET g_nmde4_d[l_ac].nmde032_desc = g_nmde4_d_t.nmde032_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_nmde4_d[l_ac].nmde032 = g_nmde4_d[l_ac].nmde032_desc
               END IF
            ELSE
               LET g_nmde4_d[l_ac].nmde032 = g_nmde4_d[l_ac].nmde032_desc
            END IF
            CALL s_voucher_free_account_desc(l_glad.glad0261,g_nmde4_d[l_ac].nmde032_desc) RETURNING g_nmde4_d[l_ac].nmde032_desc
            LET g_nmde4_d[l_ac].nmde032_desc = s_desc_show1(g_nmde4_d[l_ac].nmde032,g_nmde4_d[l_ac].nmde032_desc)
            #160326-00001#25--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde032_desc
            #add-point:ON CHANGE nmde032_desc name="input.g.page4.nmde032_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.nmde015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde015
            #add-point:ON ACTION controlp INFIELD nmde015 name="input.c.page4.nmde015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde015_desc
            #add-point:ON ACTION controlp INFIELD nmde015_desc name="input.c.page4.nmde015_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde033
            #add-point:ON ACTION controlp INFIELD nmde033 name="input.c.page4.nmde033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde006
            #add-point:ON ACTION controlp INFIELD nmde006 name="input.c.page4.nmde006"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.arg1=g_nmde_m.nmdedocdt #160326-00001#25 add
 
            CALL q_ooeg001_4()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde006 = g_qryparam.return1              

            DISPLAY g_nmde4_d[l_ac].nmde006 TO nmde006              #

            NEXT FIELD nmde006                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde006_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde006_desc
            #add-point:ON ACTION controlp INFIELD nmde006_desc name="input.c.page4.nmde006_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde006_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.arg1=g_nmde_m.nmdedocdt #160326-00001#25 add
            #161221-00054#3 add s---
            CALL s_voucher_get_glak_sql(g_nmde_m.nmdeld, '02',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---             
            CALL q_ooeg001_4()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde006_desc = g_qryparam.return1
            LET g_nmde4_d[l_ac].nmde006 = g_nmde4_d[l_ac].nmde006_desc #160326-00001#25 add

            DISPLAY g_nmde4_d[l_ac].nmde006_desc TO nmde006_desc              #

            NEXT FIELD nmde006_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde007
            #add-point:ON ACTION controlp INFIELD nmde007 name="input.c.page4.nmde007"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.where = " ooeg003 IN ('1','2','3')" #160326-00001#25 add
             
            CALL q_ooeg001_4()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde007 = g_qryparam.return1              

            DISPLAY g_nmde4_d[l_ac].nmde007 TO nmde007              #

            NEXT FIELD nmde007                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde007_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde007_desc
            #add-point:ON ACTION controlp INFIELD nmde007_desc name="input.c.page4.nmde007_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde007_desc             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #s #161221-00054#3 mark
            LET g_qryparam.arg1  = g_today #161221-00054#3 add 
            LET g_qryparam.where = " ooeg003 IN ('1','2','3')" #160326-00001#25 add
            #161221-00054#3 add s---
            CALL s_voucher_get_glak_sql(g_nmde_m.nmdeld, '03',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#3 add e---             
            CALL q_ooeg001_4()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde007_desc = g_qryparam.return1              
            LET g_nmde4_d[l_ac].nmde007 = g_nmde4_d[l_ac].nmde007_desc #160326-00001#25 add
            DISPLAY g_nmde4_d[l_ac].nmde007_desc TO nmde007_desc              #

            NEXT FIELD nmde007_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde008
            #add-point:ON ACTION controlp INFIELD nmde008 name="input.c.page4.nmde008"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde008             #給予default值
            LET g_qryparam.default2 = "" #g_nmde4_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_oocq002_287()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde008 = g_qryparam.return1              
            #LET g_nmde4_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_nmde4_d[l_ac].nmde008 TO nmde008              #
            #DISPLAY g_nmde4_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD nmde008                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde008_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde008_desc
            #add-point:ON ACTION controlp INFIELD nmde008_desc name="input.c.page4.nmde008_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde008_desc             #給予default值
            LET g_qryparam.default2 = "" #g_nmde4_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

            #161221-00054#3 add s---
            CALL s_voucher_get_glak_sql(g_nmde_m.nmdeld, '04',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---   
            CALL q_oocq002_287()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde008_desc = g_qryparam.return1  
            LET g_nmde4_d[l_ac].nmde008 = g_nmde4_d[l_ac].nmde008_desc #160326-00001#25 add
            #LET g_nmde4_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_nmde4_d[l_ac].nmde008_desc TO nmde008_desc              #
            #DISPLAY g_nmde4_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD nmde008_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde018
            #add-point:ON ACTION controlp INFIELD nmde018 name="input.c.page4.nmde018"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde018             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
           # CALL q_pmaa001()       #160913-00017#6  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#6  add      
 
            LET g_nmde4_d[l_ac].nmde018 = g_qryparam.return1              

            DISPLAY g_nmde4_d[l_ac].nmde018 TO nmde018              #

            NEXT FIELD nmde018                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde018_desc
            #add-point:ON ACTION controlp INFIELD nmde018_desc name="input.c.page4.nmde018_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde018_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            #161221-00054#3 add s---
            CALL s_voucher_get_glak_sql(g_nmde_m.nmdeld, '05',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---   
            # CALL q_pmaa001()       #160913-00017#6  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#6  add      
 
            LET g_nmde4_d[l_ac].nmde018_desc = g_qryparam.return1              
            LET g_nmde4_d[l_ac].nmde018 = g_nmde4_d[l_ac].nmde018_desc #160326-00001#25 add
            DISPLAY g_nmde4_d[l_ac].nmde018_desc TO nmde018_desc              #

            NEXT FIELD nmde018_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde019
            #add-point:ON ACTION controlp INFIELD nmde019 name="input.c.page4.nmde019"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde019             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

  
            # CALL q_pmaa001()       #160913-00017#6  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#6  add      
 
            LET g_nmde4_d[l_ac].nmde019 = g_qryparam.return1              
            
            DISPLAY g_nmde4_d[l_ac].nmde019 TO nmde019              #

            NEXT FIELD nmde019                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde019_desc
            #add-point:ON ACTION controlp INFIELD nmde019_desc name="input.c.page4.nmde019_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde019_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            #161221-00054#3 add s---
            CALL s_voucher_get_glak_sql(g_nmde_m.nmdeld, '06',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---    
            # CALL q_pmaa001()       #160913-00017#6  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#6  add      
 
            LET g_nmde4_d[l_ac].nmde019_desc = g_qryparam.return1              
            LET g_nmde4_d[l_ac].nmde019 = g_nmde4_d[l_ac].nmde019_desc #160326-00001#25 add
            DISPLAY g_nmde4_d[l_ac].nmde019_desc TO nmde019_desc              #

            NEXT FIELD nmde019_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde009
            #add-point:ON ACTION controlp INFIELD nmde009 name="input.c.page4.nmde009"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde009             #給予default值
            LET g_qryparam.default2 = "" #g_nmde4_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_281()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde009 = g_qryparam.return1              
            #LET g_nmde4_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_nmde4_d[l_ac].nmde009 TO nmde009              #
            #DISPLAY g_nmde4_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD nmde009                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde009_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde009_desc
            #add-point:ON ACTION controlp INFIELD nmde009_desc name="input.c.page4.nmde009_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde009_desc             #給予default值
            LET g_qryparam.default2 = "" #g_nmde4_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

            #161221-00054#3 add s---
            CALL s_voucher_get_glak_sql(g_nmde_m.nmdeld, '07',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---    
            CALL q_oocq002_281()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde009_desc = g_qryparam.return1 
            LET g_nmde4_d[l_ac].nmde009 = g_nmde4_d[l_ac].nmde009_desc #160326-00001#25 add
            #LET g_nmde4_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_nmde4_d[l_ac].nmde009_desc TO nmde009_desc              #
            #DISPLAY g_nmde4_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD nmde009_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde010
            #add-point:ON ACTION controlp INFIELD nmde010 name="input.c.page4.nmde010"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.where = " rtax004='",g_ooaa002,"'" #160326-00001#25 add
            CALL q_rtax001()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde010 = g_qryparam.return1              

            DISPLAY g_nmde4_d[l_ac].nmde010 TO nmde010              #

            NEXT FIELD nmde010                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde010_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde010_desc
            #add-point:ON ACTION controlp INFIELD nmde010_desc name="input.c.page4.nmde010_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde010_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.where = " rtax004='",g_ooaa002,"'" #160326-00001#25 add
            #161221-00054#3 add s---
            CALL s_voucher_get_glak_sql(g_nmde_m.nmdeld, '08',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#3 add e---               
            CALL q_rtax001()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde010_desc = g_qryparam.return1              
            LET g_nmde4_d[l_ac].nmde010 = g_nmde4_d[l_ac].nmde010_desc #160326-00001#25 add
            DISPLAY g_nmde4_d[l_ac].nmde010_desc TO nmde010_desc              #

            NEXT FIELD nmde010_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde020
            #add-point:ON ACTION controlp INFIELD nmde020 name="input.c.page4.nmde020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde021
            #add-point:ON ACTION controlp INFIELD nmde021 name="input.c.page4.nmde021"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
 
            LET g_qryparam.where = " oojdstus='Y' " #160326-00001#25 add
            CALL q_oojd001_2()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde021 = g_qryparam.return1              
            
            DISPLAY g_nmde4_d[l_ac].nmde021 TO nmde021              #

            NEXT FIELD nmde021                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde021_desc
            #add-point:ON ACTION controlp INFIELD nmde021_desc name="input.c.page4.nmde021_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde021_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.where = " oojdstus='Y' " #160326-00001#25 add
            #161221-00054#3 add s---
            CALL s_voucher_get_glak_sql(g_nmde_m.nmdeld, '10',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#3 add e---              
            CALL q_oojd001_2()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde021_desc = g_qryparam.return1              
            LET g_nmde4_d[l_ac].nmde021 = g_nmde4_d[l_ac].nmde021_desc #160326-00001#25 add
            DISPLAY g_nmde4_d[l_ac].nmde021_desc TO nmde021_desc              #

            NEXT FIELD nmde021_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde022
            #add-point:ON ACTION controlp INFIELD nmde022 name="input.c.page4.nmde022"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde022             #給予default值
            LET g_qryparam.default2 = "" #g_nmde4_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_2002()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde022 = g_qryparam.return1              
            #LET g_nmde4_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_nmde4_d[l_ac].nmde022 TO nmde022              #
            #DISPLAY g_nmde4_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD nmde022                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde022_desc
            #add-point:ON ACTION controlp INFIELD nmde022_desc name="input.c.page4.nmde022_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde022_desc             #給予default值
            LET g_qryparam.default2 = "" #g_nmde4_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s

            #161221-00054#3 add s---
            CALL s_voucher_get_glak_sql(g_nmde_m.nmdeld, '11',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---   
            CALL q_oocq002_2002()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde022_desc = g_qryparam.return1              
            LET g_nmde4_d[l_ac].nmde022 = g_nmde4_d[l_ac].nmde022_desc #160326-00001#25 add
            #LET g_nmde4_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_nmde4_d[l_ac].nmde022_desc TO nmde022_desc              #
            #DISPLAY g_nmde4_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD nmde022_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde011
            #add-point:ON ACTION controlp INFIELD nmde011 name="input.c.page4.nmde011"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooag001_8()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde011 = g_qryparam.return1              

            DISPLAY g_nmde4_d[l_ac].nmde011 TO nmde011              #

            NEXT FIELD nmde011                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde011_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde011_desc
            #add-point:ON ACTION controlp INFIELD nmde011_desc name="input.c.page4.nmde011_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde011_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            #161221-00054#3 add s---
            CALL s_voucher_get_glak_sql(g_nmde_m.nmdeld, '12',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---   
            CALL q_ooag001_8()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde011_desc = g_qryparam.return1              
             LET g_nmde4_d[l_ac].nmde011 = g_nmde4_d[l_ac].nmde011_desc #160326-00001#25 add
            DISPLAY g_nmde4_d[l_ac].nmde011_desc TO nmde011_desc              #

            NEXT FIELD nmde011_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde013
            #add-point:ON ACTION controlp INFIELD nmde013 name="input.c.page4.nmde013"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_pjba001()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde013 = g_qryparam.return1              

            DISPLAY g_nmde4_d[l_ac].nmde013 TO nmde013              #

            NEXT FIELD nmde013                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde013_desc
            #add-point:ON ACTION controlp INFIELD nmde013_desc name="input.c.page4.nmde013_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde013_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            #161221-00054#3 add s---
            CALL s_voucher_get_glak_sql(g_nmde_m.nmdeld, '13',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#3 add e---   
            CALL q_pjba001()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde013_desc = g_qryparam.return1              
            LET g_nmde4_d[l_ac].nmde013 = g_nmde4_d[l_ac].nmde013_desc #160326-00001#25 add
            DISPLAY g_nmde4_d[l_ac].nmde013_desc TO nmde013_desc              #

            NEXT FIELD nmde013_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde014
            #add-point:ON ACTION controlp INFIELD nmde014 name="input.c.page4.nmde014"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde013) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_nmde4_d[l_ac].nmde013,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            #160326-00001#25--add--end
            CALL q_pjbb002()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde014 = g_qryparam.return1              

            DISPLAY g_nmde4_d[l_ac].nmde014 TO nmde014              #

            NEXT FIELD nmde014                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde014_desc
            #add-point:ON ACTION controlp INFIELD nmde014_desc name="input.c.page4.nmde014_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde014_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            #160326-00001#25--add--str--
            IF NOT cl_null(g_nmde4_d[l_ac].nmde013) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_nmde4_d[l_ac].nmde013,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            #160326-00001#25--add--end
            #161221-00054#3 add s---
            CALL s_voucher_get_glak_sql(g_nmde_m.nmdeld, '14',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#3 add e---              
            CALL q_pjbb002()                                #呼叫開窗
 
            LET g_nmde4_d[l_ac].nmde014_desc = g_qryparam.return1              
            LET g_nmde4_d[l_ac].nmde014 = g_nmde4_d[l_ac].nmde014_desc #160326-00001#25 add
            DISPLAY g_nmde4_d[l_ac].nmde014_desc TO nmde014_desc              #

            NEXT FIELD nmde014_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde023
            #add-point:ON ACTION controlp INFIELD nmde023 name="input.c.page4.nmde023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde023_desc
            #add-point:ON ACTION controlp INFIELD nmde023_desc name="input.c.page4.nmde023_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde023_desc #給予default值
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               
               #給予arg
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0171,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009)                                #呼叫開窗
    
               LET g_nmde4_d[l_ac].nmde023_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_nmde4_d[l_ac].nmde023 = g_nmde4_d[l_ac].nmde023_desc
               DISPLAY g_nmde4_d[l_ac].nmde023_desc TO nmde023_desc
               NEXT FIELD nmde023                          #返回原欄位
            END IF 
            #160326-00001#25--add--end
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde024
            #add-point:ON ACTION controlp INFIELD nmde024 name="input.c.page4.nmde024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde024_desc
            #add-point:ON ACTION controlp INFIELD nmde024_desc name="input.c.page4.nmde024_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde024_desc #給予default值
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               
               #給予arg
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0181,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009)                                #呼叫開窗
    
               LET g_nmde4_d[l_ac].nmde024_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_nmde4_d[l_ac].nmde024 = g_nmde4_d[l_ac].nmde024_desc
               DISPLAY g_nmde4_d[l_ac].nmde024_desc TO nmde024_desc
               NEXT FIELD nmde024                          #返回原欄位
            END IF 
            #160326-00001#25--add--end
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde025
            #add-point:ON ACTION controlp INFIELD nmde025 name="input.c.page4.nmde025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde025_desc
            #add-point:ON ACTION controlp INFIELD nmde025_desc name="input.c.page4.nmde025_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde025_desc #給予default值
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               
               #給予arg
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0191,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009)                                #呼叫開窗
    
               LET g_nmde4_d[l_ac].nmde025_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_nmde4_d[l_ac].nmde025 = g_nmde4_d[l_ac].nmde025_desc
               DISPLAY g_nmde4_d[l_ac].nmde025_desc TO nmde025_desc
               NEXT FIELD nmde025                          #返回原欄位
            END IF 
            #160326-00001#25--add--end
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde026
            #add-point:ON ACTION controlp INFIELD nmde026 name="input.c.page4.nmde026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde026_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde026_desc
            #add-point:ON ACTION controlp INFIELD nmde026_desc name="input.c.page4.nmde026_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde026_desc #給予default值
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               
               #給予arg
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0201,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009)                                #呼叫開窗
    
               LET g_nmde4_d[l_ac].nmde026_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_nmde4_d[l_ac].nmde026 = g_nmde4_d[l_ac].nmde026_desc
               DISPLAY g_nmde4_d[l_ac].nmde026_desc TO nmde026_desc
               NEXT FIELD nmde026                          #返回原欄位
            END IF 
            #160326-00001#25--add--end
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde027
            #add-point:ON ACTION controlp INFIELD nmde027 name="input.c.page4.nmde027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde027_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde027_desc
            #add-point:ON ACTION controlp INFIELD nmde027_desc name="input.c.page4.nmde027_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde027_desc #給予default值
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               
               #給予arg
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0211,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009)                                #呼叫開窗
    
               LET g_nmde4_d[l_ac].nmde027_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_nmde4_d[l_ac].nmde027 = g_nmde4_d[l_ac].nmde027_desc
               DISPLAY g_nmde4_d[l_ac].nmde027_desc TO nmde027_desc
               NEXT FIELD nmde027                          #返回原欄位
            END IF 
            #160326-00001#25--add--end
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde028
            #add-point:ON ACTION controlp INFIELD nmde028 name="input.c.page4.nmde028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde028_desc
            #add-point:ON ACTION controlp INFIELD nmde028_desc name="input.c.page4.nmde028_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde028_desc #給予default值
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               
               #給予arg
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0221,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009)                                #呼叫開窗
    
               LET g_nmde4_d[l_ac].nmde028_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_nmde4_d[l_ac].nmde028 = g_nmde4_d[l_ac].nmde028_desc
               DISPLAY g_nmde4_d[l_ac].nmde028_desc TO nmde028_desc
               NEXT FIELD nmde028                          #返回原欄位
            END IF 
            #160326-00001#25--add--end
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde029
            #add-point:ON ACTION controlp INFIELD nmde029 name="input.c.page4.nmde029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde029_desc
            #add-point:ON ACTION controlp INFIELD nmde029_desc name="input.c.page4.nmde029_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde029_desc #給予default值
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               
               #給予arg
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0231,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009)                                #呼叫開窗
    
               LET g_nmde4_d[l_ac].nmde029_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_nmde4_d[l_ac].nmde029 = g_nmde4_d[l_ac].nmde029_desc
               DISPLAY g_nmde4_d[l_ac].nmde029_desc TO nmde029_desc
               NEXT FIELD nmde029                          #返回原欄位
            END IF 
            #160326-00001#25--add--end
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde030
            #add-point:ON ACTION controlp INFIELD nmde030 name="input.c.page4.nmde030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde030_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde030_desc
            #add-point:ON ACTION controlp INFIELD nmde030_desc name="input.c.page4.nmde030_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde030_desc #給予default值
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               
               #給予arg
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0241,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009)                                #呼叫開窗
    
               LET g_nmde4_d[l_ac].nmde030_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_nmde4_d[l_ac].nmde030 = g_nmde4_d[l_ac].nmde030_desc
               DISPLAY g_nmde4_d[l_ac].nmde030_desc TO nmde030_desc
               NEXT FIELD nmde030                          #返回原欄位
            END IF 
            #160326-00001#25--add--end
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde031
            #add-point:ON ACTION controlp INFIELD nmde031 name="input.c.page4.nmde031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde031_desc
            #add-point:ON ACTION controlp INFIELD nmde031_desc name="input.c.page4.nmde031_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde031_desc #給予default值
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               
               #給予arg
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0251,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009)                                #呼叫開窗
    
               LET g_nmde4_d[l_ac].nmde031_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_nmde4_d[l_ac].nmde031 = g_nmde4_d[l_ac].nmde031_desc
               DISPLAY g_nmde4_d[l_ac].nmde031_desc TO nmde031_desc
               NEXT FIELD nmde031                          #返回原欄位
            END IF 
            #160326-00001#25--add--end
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde032
            #add-point:ON ACTION controlp INFIELD nmde032 name="input.c.page4.nmde032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.nmde032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde032_desc
            #add-point:ON ACTION controlp INFIELD nmde032_desc name="input.c.page4.nmde032_desc"
            #160326-00001#25--add--str--
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_nmde4_d[l_ac].nmde032_desc #給予default值
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               
               #給予arg
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",l_glad.glad0261,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009)                                #呼叫開窗
    
               LET g_nmde4_d[l_ac].nmde032_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_nmde4_d[l_ac].nmde032 = g_nmde4_d[l_ac].nmde032_desc
               DISPLAY g_nmde4_d[l_ac].nmde032_desc TO nmde032_desc
               NEXT FIELD nmde032                          #返回原欄位
            END IF 
            #160326-00001#25--add--end
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:input段after row name="input.body4.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_nmde4_d[l_ac].* = g_nmde4_d_t.*
               END IF
               CLOSE anmt820_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
 
            CLOSE anmt820_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"
            
            #end add-point    
 
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_nmde_d[li_reproduce_target].* = g_nmde_d[li_reproduce].*
               LET g_nmde2_d[li_reproduce_target].* = g_nmde2_d[li_reproduce].*
               LET g_nmde3_d[li_reproduce_target].* = g_nmde3_d[li_reproduce].*
               LET g_nmde4_d[li_reproduce_target].* = g_nmde4_d[li_reproduce].*
 
               LET g_nmde4_d[li_reproduce_target].nmde004 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmde4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmde4_d.getLength()+1
            END IF
      END INPUT
 
      
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
         CALL DIALOG.setCurrentRow("s_detail3",g_detail_idx)
         CALL DIALOG.setCurrentRow("s_detail4",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD nmdeld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD nmde005
               WHEN "s_detail2"
                  NEXT FIELD nmde004_2
               WHEN "s_detail3"
                  NEXT FIELD nmde004_3
               WHEN "s_detail4"
                  NEXT FIELD nmde004_4
 
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
   CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
   CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
 
 
   
   #add-point:input段after_input name="input.after_input"
   IF NOT INT_FLAG THEN
      SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise
         AND glaald = g_nmde_m.nmdeld
      IF l_glaa121 = 'Y' THEN
         CALL s_transaction_begin()
         CALL s_pre_voucher_ins('NM','N40',g_nmde_m.nmdeld,g_nmde_m.nmdedocno,g_today,'1') RETURNING l_success
         IF NOT l_success THEN
            CALL s_transaction_end('N',0)
         END IF
      END IF
   END IF
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION anmt820_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_glaa121     LIKE glaa_t.glaa121
   DEFINE l_glaa015     LIKE glaa_t.glaa015 #160326-00001#25 add
   DEFINE l_glaa019     LIKE glaa_t.glaa015 #160326-00001#25 add
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
#   CALL cl_set_act_visible('modify,modify_detail',FALSE) #160326-00001#25 mark
   CALL cl_set_act_visible('insert,insert_detail',FALSE)
   
   #160326-00001#25--add--str--
   SELECT glaa015,glaa019,glaa121
     INTO l_glaa015,l_glaa019,l_glaa121
     FROM glaa_t
    WHERE glaaent=g_enterprise AND glaald=g_nmde_m.nmdeld
   #本位币二
   IF l_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible('page_3',TRUE)
   ELSE
      CALL cl_set_comp_visible('page_3',FALSE)
   END IF
   #本位币三
   IF l_glaa019 = 'Y' THEN
      CALL cl_set_comp_visible('page_4',TRUE)
   ELSE
      CALL cl_set_comp_visible('page_4',FALSE)
   END IF   
   #160326-00001#25--add--end
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL anmt820_b_fill(g_wc2) #第一階單身填充
      CALL anmt820_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL anmt820_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_nmde_m.nmdesite,g_nmde_m.nmdesite_desc,g_nmde_m.nmdecomp,g_nmde_m.nmdecomp_desc, 
       g_nmde_m.nmde001_i,g_nmde_m.nmde002_i,g_nmde_m.nmdeld,g_nmde_m.nmdeld_desc,g_nmde_m.nmdedocdt, 
       g_nmde_m.nmde017,g_nmde_m.nmde001,g_nmde_m.nmde002,g_nmde_m.nmdedocno
 
   CALL anmt820_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
#   SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise #160326-00001#25 mark
#      AND glaald = g_nmde_m.nmdeld #160326-00001#25 mark
   IF l_glaa121 = 'Y' THEN
      CALL cl_set_toolbaritem_visible('open_pre',TRUE)
   ELSE
      CALL cl_set_toolbaritem_visible('open_pre',FALSE)
   END IF
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION anmt820_ref_show()
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
   #150707-00001#8--mark--(s)
   #SELECT glaacomp INTO g_nmde_m.nmdecomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_nmde_m.nmdeld
   #DISPLAY BY NAME g_nmde_m.nmdecomp
   #150707-00001#8--mark--(e)
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmde_m.nmdecomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmde_m.nmdecomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmde_m.nmdecomp_desc
   
   LET g_nmde_m.nmde001_i = g_nmde_m.nmde001
   LET g_nmde_m.nmde002_i = g_nmde_m.nmde002
   DISPLAY g_nmde_m.nmde001_i TO nmde001_i
   DISPLAY g_nmde_m.nmde002_i TO nmde002_i 
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_nmde_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_nmde2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_nmde3_d.getLength()
      #add-point:ref_show段d3_reference name="ref_show.body3.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_nmde4_d.getLength()
      #add-point:ref_show段d4_reference name="ref_show.body4.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="anmt820.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION anmt820_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE nmde_t.nmdeld 
   DEFINE l_oldno     LIKE nmde_t.nmdeld 
   DEFINE l_newno02     LIKE nmde_t.nmde001 
   DEFINE l_oldno02     LIKE nmde_t.nmde001 
   DEFINE l_newno03     LIKE nmde_t.nmde002 
   DEFINE l_oldno03     LIKE nmde_t.nmde002 
 
   DEFINE l_master    RECORD LIKE nmde_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE nmde_t.* #此變數樣板目前無使用
 
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
 
   IF g_nmde_m.nmdeld IS NULL
      OR g_nmde_m.nmde001 IS NULL
      OR g_nmde_m.nmde002 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_nmdeld_t = g_nmde_m.nmdeld
   LET g_nmde001_t = g_nmde_m.nmde001
   LET g_nmde002_t = g_nmde_m.nmde002
 
   
   LET g_nmde_m.nmdeld = ""
   LET g_nmde_m.nmde001 = ""
   LET g_nmde_m.nmde002 = ""
 
   LET g_master_insert = FALSE
   CALL anmt820_set_entry('a')
   CALL anmt820_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_nmde_m.nmde017 = ''     #160726-00020#16
   #end add-point
   
   #清空key欄位的desc
      LET g_nmde_m.nmdeld_desc = ''
   DISPLAY BY NAME g_nmde_m.nmdeld_desc
 
   
   CALL anmt820_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_nmde_m.* TO NULL
      INITIALIZE g_nmde_d TO NULL
      INITIALIZE g_nmde2_d TO NULL
      INITIALIZE g_nmde3_d TO NULL
      INITIALIZE g_nmde4_d TO NULL
 
      CALL anmt820_show()
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
   CALL anmt820_set_act_visible()
   CALL anmt820_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_nmdeld_t = g_nmde_m.nmdeld
   LET g_nmde001_t = g_nmde_m.nmde001
   LET g_nmde002_t = g_nmde_m.nmde002
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmdeent = " ||g_enterprise|| " AND",
                      " nmdeld = '", g_nmde_m.nmdeld, "' "
                      ," AND nmde001 = '", g_nmde_m.nmde001, "' "
                      ," AND nmde002 = '", g_nmde_m.nmde002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt820_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL anmt820_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL anmt820_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION anmt820_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE nmde_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE anmt820_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM nmde_t
    WHERE nmdeent = g_enterprise AND nmdeld = g_nmdeld_t
    AND nmde001 = g_nmde001_t
    AND nmde002 = g_nmde002_t
 
       INTO TEMP anmt820_detail
   
   #將key修正為調整後   
   UPDATE anmt820_detail 
      #更新key欄位
      SET nmdeld = g_nmde_m.nmdeld
          , nmde001 = g_nmde_m.nmde001
          , nmde002 = g_nmde_m.nmde002
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO nmde_t SELECT * FROM anmt820_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE anmt820_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_nmdeld_t = g_nmde_m.nmdeld
   LET g_nmde001_t = g_nmde_m.nmde001
   LET g_nmde002_t = g_nmde_m.nmde002
 
   
   DROP TABLE anmt820_detail
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820.delete" >}
#+ 資料刪除
PRIVATE FUNCTION anmt820_delete()
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_glaa121       LIKE glaa_t.glaa121  
   DEFINE  l_success       LIKE type_t.num5   
   DEFINE  l_nmbcdocno     LIKE nmbc_t.nmbcdocno #160513-00008#3
   DEFINE  l_sys           LIKE type_t.chr10     #160530-00003#4 add
   DEFINE  l_glca002       LIKE glca_t.glca002   #160530-00003#4 add
   DEFINE  l_cnt           LIKE type_t.num5      #160326-00001#25 add
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   #150813-00015#20--add--str--
   IF g_nmde_m.nmdeld IS NULL
   OR g_nmde_m.nmde001 IS NULL
   OR g_nmde_m.nmde002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   SELECT nmdecomp,nmdedocdt,nmde017 INTO g_nmde_m.nmdecomp,g_nmde_m.nmdedocdt,g_nmde_m.nmde017 #160326-00001#25 add nmde017
     FROM nmde_t
    WHERE nmdeent=g_enterprise AND nmdeld=g_nmde_m.nmdeld
      AND nmde001=g_nmde_m.nmde001 AND nmde002=g_nmde_m.nmde002
   #檢查當單據日期小於等於關帳日期時，不可異動單據
   CALL s_fin_date_close_chk('',g_nmde_m.nmdecomp,'ANM',g_nmde_m.nmdedocdt) RETURNING l_success
   IF l_success = FALSE THEN
      RETURN
   END IF
   #150813-00015#20--add--end
   #160326-00001#25--add--str--
   #已抛转凭证不可删除
   IF NOT cl_null(g_nmde_m.nmde017) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "anm-00082" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   #当存在大于改期别的调汇资料，该笔资料不可删除
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM nmde_t
    WHERE nmdeent=g_enterprise AND nmdeld=g_nmde_m.nmdeld
      AND (nmde001>g_nmde_m.nmde001 OR (nmde001=g_nmde_m.nmde001 AND nmde002>g_nmde_m.nmde002))
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "anm-00404" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   #160326-00001#25--add--end
   #end add-point
   
   IF g_nmde_m.nmdeld IS NULL
   OR g_nmde_m.nmde001 IS NULL
   OR g_nmde_m.nmde002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN anmt820_cl USING g_enterprise,g_nmde_m.nmdeld,g_nmde_m.nmde001,g_nmde_m.nmde002
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt820_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE anmt820_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt820_master_referesh USING g_nmde_m.nmdeld,g_nmde_m.nmde001,g_nmde_m.nmde002 INTO g_nmde_m.nmdesite, 
       g_nmde_m.nmdecomp,g_nmde_m.nmdeld,g_nmde_m.nmdedocdt,g_nmde_m.nmde017,g_nmde_m.nmde001,g_nmde_m.nmde002, 
       g_nmde_m.nmdedocno,g_nmde_m.nmdesite_desc,g_nmde_m.nmdecomp_desc,g_nmde_m.nmdeld_desc
   
   #遮罩相關處理
   LET g_nmde_m_mask_o.* =  g_nmde_m.*
   CALL anmt820_nmde_t_mask()
   LET g_nmde_m_mask_n.* =  g_nmde_m.*
   
   CALL anmt820_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL anmt820_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM nmde_t WHERE nmdeent = g_enterprise AND nmdeld = g_nmde_m.nmdeld
                                                               AND nmde001 = g_nmde_m.nmde001
                                                               AND nmde002 = g_nmde_m.nmde002
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      DELETE FROM glbc_t
       WHERE glbcent = g_enterprise
         AND glbcld  = g_nmde_m.nmdeld
         AND glbcdocno = g_nmde_m.nmdedocno
         AND glbc001 = g_nmde_m.nmde001
         AND glbc002 = g_nmde_m.nmde002
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmde_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"
       SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise
          AND glaald = g_nmde_m.nmdeld
       IF l_glaa121 = 'Y' THEN
          #160530-00003#4--add--str--
          SELECT (CASE WHEN glca002 = '2' THEN 'Y' ELSE 'N' END) INTO l_glca002
            FROM glca_t
           WHERE glcaent = g_enterprise
             AND glcald  = g_nmde_m.nmdeld AND glca001 = 'NM'
          IF l_glca002 = 'Y' THEN
             LET l_sys = 'AC'
          ELSE
             LET l_sys = 'NM'
          END IF
          CALL s_pre_voucher_del(l_sys,'N40',g_nmde_m.nmdeld,g_nmde_m.nmdedocno) RETURNING l_success
          #160530-00003#4--add--end
#          CALL s_pre_voucher_del('NM','N40',g_nmde_m.nmdeld,g_nmde_m.nmdedocno) RETURNING l_success #160530-00003#4 mark

          IF l_success = FALSE THEN
             CALL s_transaction_end('N','0')
             RETURN
          END IF
       END IF
       
      #160513-00008#3--add--str--
      #同步删除nmbc_t
      LET l_nmbcdocno="NM",g_nmde_m.nmde001 USING "&&&&",g_nmde_m.nmde002 USING "&&","%"
      DELETE FROM nmbc_t 
       WHERE nmbcent = g_enterprise AND nmbccomp = g_nmde_m.nmdecomp
         AND nmbcdocno LIKE l_nmbcdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbc_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')      
      END IF
      #160513-00008#3--add--end
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE anmt820_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_nmde_d.clear() 
      CALL g_nmde2_d.clear()       
      CALL g_nmde3_d.clear()       
      CALL g_nmde4_d.clear()       
 
     
      CALL anmt820_ui_browser_refresh()  
      #CALL anmt820_ui_headershow()  
      #CALL anmt820_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL anmt820_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL anmt820_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE anmt820_cl
 
   #功能已完成,通報訊息中心
   CALL anmt820_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="anmt820.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmt820_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   #160326-00001#25--add--str--
   #多語言SQL
   DEFINE l_get_sql   RECORD
          nmde006     STRING,  #部门
          nmde007     STRING,  #责任中心
          nmde008     STRING,  #区域
          nmde009     STRING,  #客群
          nmde010     STRING,  #产品类别
          nmde011     STRING,  #人员
          nmde013     STRING,  #专案代号
          nmde014     STRING,  #WBS编号
          nmde015     STRING,  #銀存科目
          nmde018     STRING,  #收付款客商
          nmde019     STRING,  #帳款客商
          nmde021     STRING,  #渠道
          nmde022     STRING   #品牌
                      END RECORD  
   #161128-00061#2---modify----begin----------
   #DEFINE l_glad                 RECORD LIKE glad_t.* 
   DEFINE l_glad RECORD  #帳套科目管理設定檔
       gladent LIKE glad_t.gladent, #企業編號
       gladownid LIKE glad_t.gladownid, #資料所有者
       gladowndp LIKE glad_t.gladowndp, #資料所屬部門
       gladcrtid LIKE glad_t.gladcrtid, #資料建立者
       gladcrtdp LIKE glad_t.gladcrtdp, #資料建立部門
       gladcrtdt LIKE glad_t.gladcrtdt, #資料創建日
       gladmodid LIKE glad_t.gladmodid, #資料修改者
       gladmoddt LIKE glad_t.gladmoddt, #最近修改日
       gladstus LIKE glad_t.gladstus, #狀態碼
       gladld LIKE glad_t.gladld, #帳套
       glad001 LIKE glad_t.glad001, #會計科目編號
       glad002 LIKE glad_t.glad002, #是否按餘額類型產生分錄
       glad003 LIKE glad_t.glad003, #啟用傳票項次細項立沖
       glad004 LIKE glad_t.glad004, #傳票項次異動別
       glad005 LIKE glad_t.glad005, #是否啟用數量金額式
       glad006 LIKE glad_t.glad006, #借方現金變動碼
       glad007 LIKE glad_t.glad007, #啟用部門管理
       glad008 LIKE glad_t.glad008, #啟用利潤成本管理
       glad009 LIKE glad_t.glad009, #啟用區域管理
       glad010 LIKE glad_t.glad010, #啟用收付款客商管理
       glad011 LIKE glad_t.glad011, #啟用客群管理
       glad012 LIKE glad_t.glad012, #啟用產品類別管理
       glad013 LIKE glad_t.glad013, #啟用人員管理
       glad014 LIKE glad_t.glad014, #no use
       glad015 LIKE glad_t.glad015, #啟用專案管理
       glad016 LIKE glad_t.glad016, #啟用WBS管理
       glad017 LIKE glad_t.glad017, #啟用自由核算項一
       glad0171 LIKE glad_t.glad0171, #自由核算項一類型編號
       glad0172 LIKE glad_t.glad0172, #自由核算項一控制方式
       glad018 LIKE glad_t.glad018, #啟用自由核算項二
       glad0181 LIKE glad_t.glad0181, #自由核算項二類型編號
       glad0182 LIKE glad_t.glad0182, #自由核算項二控制方式
       glad019 LIKE glad_t.glad019, #啟用自由核算項三
       glad0191 LIKE glad_t.glad0191, #自由核算項三類型編號
       glad0192 LIKE glad_t.glad0192, #自由核算項三控制方式
       glad020 LIKE glad_t.glad020, #啟用自由核算項四
       glad0201 LIKE glad_t.glad0201, #自由核算項四類型編號
       glad0202 LIKE glad_t.glad0202, #自由核算項四控制方式
       glad021 LIKE glad_t.glad021, #啟用自由核算項五
       glad0211 LIKE glad_t.glad0211, #自由核算項五類型編號
       glad0212 LIKE glad_t.glad0212, #自由核算項五控制方式
       glad022 LIKE glad_t.glad022, #啟用自由核算項六
       glad0221 LIKE glad_t.glad0221, #自由核算項六類型編號
       glad0222 LIKE glad_t.glad0222, #自由核算項六控制方式
       glad023 LIKE glad_t.glad023, #啟用自由核算項七
       glad0231 LIKE glad_t.glad0231, #自由核算項七類型編號
       glad0232 LIKE glad_t.glad0232, #自由核算項七控制方式
       glad024 LIKE glad_t.glad024, #啟用自由核算項八
       glad0241 LIKE glad_t.glad0241, #自由核算項八類型編號
       glad0242 LIKE glad_t.glad0242, #自由核算項八控制方式
       glad025 LIKE glad_t.glad025, #啟用自由核算項九
       glad0251 LIKE glad_t.glad0251, #自由核算項九類型編號
       glad0252 LIKE glad_t.glad0252, #自由核算項九控制方式
       glad026 LIKE glad_t.glad026, #啟用自由核算項十
       glad0261 LIKE glad_t.glad0261, #自由核算項十類型編號
       glad0262 LIKE glad_t.glad0262, #自由核算項十控制方式
       glad027 LIKE glad_t.glad027, #啟用帳款客商管理
       glad030 LIKE glad_t.glad030, #是否進行預算管控
       glad031 LIKE glad_t.glad031, #啟用經營方式管理
       glad032 LIKE glad_t.glad032, #啟用渠道管理
       glad033 LIKE glad_t.glad033, #啟用品牌管理
       glad034 LIKE glad_t.glad034, #科目做多幣別管理
       glad035 LIKE glad_t.glad035, #是否是子系統科目
       glad036 LIKE glad_t.glad036  #貸方現金變動碼
       END RECORD

   #161128-00061#2---modify----end----------
   #160326-00001#25--add--end                      
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_nmde_d.clear()
   CALL g_nmde2_d.clear()
   CALL g_nmde3_d.clear()
   CALL g_nmde4_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT nmde005,nmde004,nmde100,nmde101,nmde102,nmde103,nmde104,nmde105,nmde106, 
       nmde004,nmde005,nmde100,nmde111,nmde102,nmde113,nmde114,nmde115,nmde116,nmde004,nmde005,nmde100, 
       nmde121,nmde102,nmde123,nmde124,nmde125,nmde126,nmde004,nmde015,nmde033,nmde006,nmde007,nmde008, 
       nmde018,nmde019,nmde009,nmde010,nmde020,nmde021,nmde022,nmde011,nmde013,nmde014,nmde023,nmde024, 
       nmde025,nmde026,nmde027,nmde028,nmde029,nmde030,nmde031,nmde032 FROM nmde_t",   
               "",
               
               
               " WHERE nmdeent= ? AND nmdeld=? AND nmde001=? AND nmde002=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("nmde_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #160326-00001#25--add--str--
   INITIALIZE l_get_sql.* TO NULL
   
   #部門 nmde006
   CALL s_fin_get_department_sql('ta7','nmdeent','nmde006') RETURNING l_get_sql.nmde006
   #責任中心 nmde007
   CALL s_fin_get_department_sql('ta8','nmdeent','nmde007') RETURNING l_get_sql.nmde007
   #區域 nmde008
   CALL s_fin_get_acc_sql('ta9','nmdeent','287','nmde008') RETURNING l_get_sql.nmde008
   #客群 nmde009
   CALL s_fin_get_acc_sql('ta10','nmdeent','281','nmde009') RETURNING l_get_sql.nmde009
   #產品類別 nmde010
   CALL s_fin_get_rtaxl003_sql('ta11','nmdeent','nmde010') RETURNING l_get_sql.nmde010
   #人員 nmde011
   CALL s_fin_get_person_sql('ta6','nmdeent','nmde011') RETURNING l_get_sql.nmde011
   #專案代號  nmde013
   CALL s_fin_get_project_sql('ta12','nmdeent','nmde013') RETURNING l_get_sql.nmde013
   #WBS編號   nmde014
   CALL s_fin_get_wbs_sql('ta13','nmdeent','nmde013','nmde014') RETURNING l_get_sql.nmde014
   #收付款客商
   LET l_get_sql.nmde018 = "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent = '",g_enterprise,"' AND pmaal001 = nmde018 AND pmaal002 = '",g_dlang,"')"
   #帳款客商
   LET l_get_sql.nmde019 = "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent = '",g_enterprise,"' AND pmaal001 = nmde019 AND pmaal002 = '",g_dlang,"')"
   #渠道 nmde021
   CALL s_fin_get_oojdl003_sql('ta14','nmdeent','nmde021') RETURNING l_get_sql.nmde021
   #品牌 nmde022
   CALL s_fin_get_acc_sql('ta15','nmdeent','2002','nmde022') RETURNING l_get_sql.nmde022 
   #銀存科目
   CALL s_fin_get_account_sql('ta2','ta3','nmdeent','nmdeld','nmde015') RETURNING l_get_sql.nmde015
   
   #b_fill 重寫
   LET g_sql = "SELECT DISTINCT nmde005,nmde004,nmde100,nmde101,nmde102,nmde103,nmde104,nmde105,nmde106,", 
               "       nmde004,nmde005,nmde100,nmde111,nmde102,nmde113,nmde114,nmde115,nmde116,nmde004,nmde005,nmde100,", 
               "       nmde121,nmde102,nmde123,nmde124,nmde125,nmde126,",
               "       nmde004,nmde015,",l_get_sql.nmde015,",nmde033,nmde006,",l_get_sql.nmde006,",",
               "       nmde007,",l_get_sql.nmde007,",nmde008,",l_get_sql.nmde008,",nmde018,",l_get_sql.nmde018,",",
               "       nmde019,",l_get_sql.nmde019,",nmde009,",l_get_sql.nmde009,",nmde010,",l_get_sql.nmde010,",",
               "       nmde020,nmde021,",l_get_sql.nmde021,",nmde022,",l_get_sql.nmde022,",nmde011,",l_get_sql.nmde011,",",
               "       nmde013,",l_get_sql.nmde013,",nmde014,",l_get_sql.nmde014,",",
               "       nmde023,nmde024,nmde025,nmde026,nmde027,", 
               "       nmde028,nmde029,nmde030,nmde031,nmde032 ",   
               "FROM nmde_t",
               " WHERE nmdeent= ? AND nmdeld=? AND nmde001=? AND nmde002=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("nmde_t")
   END IF
   
   #判斷是否填充
   IF anmt820_fill_chk(1) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = g_sql, " ORDER BY nmde_t.nmde004"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE anmt820_pb1 FROM g_sql
         DECLARE b_fill_cs1 CURSOR FOR anmt820_pb1
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs1 USING g_enterprise,g_nmde_m.nmdeld,g_nmde_m.nmde001,g_nmde_m.nmde002
                                               
      FOREACH b_fill_cs1 INTO g_nmde_d[l_ac].nmde005,g_nmde_d[l_ac].nmde004,g_nmde_d[l_ac].nmde100,g_nmde_d[l_ac].nmde101, 
          g_nmde_d[l_ac].nmde102,g_nmde_d[l_ac].nmde103,g_nmde_d[l_ac].nmde104,g_nmde_d[l_ac].nmde105, 
          g_nmde_d[l_ac].nmde106,g_nmde2_d[l_ac].nmde004,g_nmde2_d[l_ac].nmde005,g_nmde2_d[l_ac].nmde100, 
          g_nmde2_d[l_ac].nmde111,g_nmde2_d[l_ac].nmde102,g_nmde2_d[l_ac].nmde113,g_nmde2_d[l_ac].nmde114, 
          g_nmde2_d[l_ac].nmde115,g_nmde2_d[l_ac].nmde116,g_nmde3_d[l_ac].nmde004,g_nmde3_d[l_ac].nmde005, 
          g_nmde3_d[l_ac].nmde100,g_nmde3_d[l_ac].nmde121,g_nmde3_d[l_ac].nmde102,g_nmde3_d[l_ac].nmde123, 
          g_nmde3_d[l_ac].nmde124,g_nmde3_d[l_ac].nmde125,g_nmde3_d[l_ac].nmde126,
          g_nmde4_d[l_ac].nmde004,g_nmde4_d[l_ac].nmde015,g_nmde4_d[l_ac].nmde015_desc,g_nmde4_d[l_ac].nmde033, 
          g_nmde4_d[l_ac].nmde006,g_nmde4_d[l_ac].nmde006_desc,g_nmde4_d[l_ac].nmde007,g_nmde4_d[l_ac].nmde007_desc,
          g_nmde4_d[l_ac].nmde008,g_nmde4_d[l_ac].nmde008_desc,g_nmde4_d[l_ac].nmde018,g_nmde4_d[l_ac].nmde018_desc, 
          g_nmde4_d[l_ac].nmde019,g_nmde4_d[l_ac].nmde019_desc,g_nmde4_d[l_ac].nmde009,g_nmde4_d[l_ac].nmde009_desc,
          g_nmde4_d[l_ac].nmde010,g_nmde4_d[l_ac].nmde010_desc,g_nmde4_d[l_ac].nmde020,
          g_nmde4_d[l_ac].nmde021,g_nmde4_d[l_ac].nmde021_desc,g_nmde4_d[l_ac].nmde022,g_nmde4_d[l_ac].nmde022_desc,
          g_nmde4_d[l_ac].nmde011,g_nmde4_d[l_ac].nmde011_desc, 
          g_nmde4_d[l_ac].nmde013,g_nmde4_d[l_ac].nmde013_desc,g_nmde4_d[l_ac].nmde014,g_nmde4_d[l_ac].nmde014_desc,
          g_nmde4_d[l_ac].nmde023,g_nmde4_d[l_ac].nmde024,g_nmde4_d[l_ac].nmde025,g_nmde4_d[l_ac].nmde026,g_nmde4_d[l_ac].nmde027,
          g_nmde4_d[l_ac].nmde028,g_nmde4_d[l_ac].nmde029,g_nmde4_d[l_ac].nmde030,g_nmde4_d[l_ac].nmde031,g_nmde4_d[l_ac].nmde032 

                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
           
         #銀存科目
         LET g_nmde4_d[l_ac].nmde015_desc = s_desc_show1(g_nmde4_d[l_ac].nmde015,g_nmde4_d[l_ac].nmde015_desc)
         #固定核算項
         LET g_nmde4_d[l_ac].nmde006_desc = s_desc_show1(g_nmde4_d[l_ac].nmde006,g_nmde4_d[l_ac].nmde006_desc)
         LET g_nmde4_d[l_ac].nmde007_desc = s_desc_show1(g_nmde4_d[l_ac].nmde007,g_nmde4_d[l_ac].nmde007_desc)
         LET g_nmde4_d[l_ac].nmde008_desc = s_desc_show1(g_nmde4_d[l_ac].nmde008,g_nmde4_d[l_ac].nmde008_desc)
         LET g_nmde4_d[l_ac].nmde009_desc = s_desc_show1(g_nmde4_d[l_ac].nmde009,g_nmde4_d[l_ac].nmde009_desc)
         LET g_nmde4_d[l_ac].nmde010_desc = s_desc_show1(g_nmde4_d[l_ac].nmde010,g_nmde4_d[l_ac].nmde010_desc)
         LET g_nmde4_d[l_ac].nmde011_desc = s_desc_show1(g_nmde4_d[l_ac].nmde011,g_nmde4_d[l_ac].nmde011_desc)
         LET g_nmde4_d[l_ac].nmde013_desc = s_desc_show1(g_nmde4_d[l_ac].nmde013,g_nmde4_d[l_ac].nmde013_desc)
         LET g_nmde4_d[l_ac].nmde014_desc = s_desc_show1(g_nmde4_d[l_ac].nmde014,g_nmde4_d[l_ac].nmde014_desc)
         LET g_nmde4_d[l_ac].nmde018_desc = s_desc_show1(g_nmde4_d[l_ac].nmde018,g_nmde4_d[l_ac].nmde018_desc)
         LET g_nmde4_d[l_ac].nmde019_desc = s_desc_show1(g_nmde4_d[l_ac].nmde019,g_nmde4_d[l_ac].nmde019_desc)
         LET g_nmde4_d[l_ac].nmde021_desc = s_desc_show1(g_nmde4_d[l_ac].nmde021,g_nmde4_d[l_ac].nmde021_desc)
         LET g_nmde4_d[l_ac].nmde022_desc = s_desc_show1(g_nmde4_d[l_ac].nmde022,g_nmde4_d[l_ac].nmde022_desc)
         #自由核算項
         INITIALIZE l_glad.* TO NULL
         IF NOT cl_null(g_nmde4_d[l_ac].nmde015) THEN
            #161128-00061#2---modify----begin----------
            #SELECT * INTO l_glad.* FROM glad_t
            SELECT gladent,gladownid,gladowndp,gladcrtid,gladcrtdp,gladcrtdt,gladmodid,gladmoddt,gladstus,
                   gladld,glad001,glad002,glad003,glad004,glad005,glad006,glad007,glad008,glad009,glad010,
                   glad011,glad012,glad013,glad014,glad015,glad016,glad017,glad0171,glad0172,glad018,glad0181,
                   glad0182,glad019,glad0191,glad0192,glad020,glad0201,glad0202,glad021,glad0211,glad0212,glad022,
                   glad0221,glad0222,glad023,glad0231,glad0232,glad024,glad0241,glad0242,glad025,glad0251,glad0252,
                   glad026,glad0261,glad0262,glad027,glad030,glad031,glad032,glad033,glad034,glad035,glad036
                   INTO l_glad.* FROM glad_t
            #161128-00061#2---modify----end----------
            WHERE gladent=g_enterprise AND gladld=g_nmde_m.nmdeld AND glad001=g_nmde4_d[l_ac].nmde015
         END IF
         IF NOT cl_null(g_nmde4_d[l_ac].nmde023) THEN
            CALL s_voucher_free_account_desc(l_glad.glad0171,g_nmde4_d[l_ac].nmde023) RETURNING g_nmde4_d[l_ac].nmde023_desc
            LET g_nmde4_d[l_ac].nmde023_desc = s_desc_show1(g_nmde4_d[l_ac].nmde023,g_nmde4_d[l_ac].nmde023_desc)
         END IF
         
         IF NOT cl_null(g_nmde4_d[l_ac].nmde024) THEN
            CALL s_voucher_free_account_desc(l_glad.glad0181,g_nmde4_d[l_ac].nmde024) RETURNING g_nmde4_d[l_ac].nmde024_desc
            LET g_nmde4_d[l_ac].nmde024_desc = s_desc_show1(g_nmde4_d[l_ac].nmde024,g_nmde4_d[l_ac].nmde024_desc)
         END IF
         
         IF NOT cl_null(g_nmde4_d[l_ac].nmde025) THEN
            CALL s_voucher_free_account_desc(l_glad.glad0191,g_nmde4_d[l_ac].nmde025) RETURNING g_nmde4_d[l_ac].nmde025_desc
            LET g_nmde4_d[l_ac].nmde025_desc = s_desc_show1(g_nmde4_d[l_ac].nmde025,g_nmde4_d[l_ac].nmde025_desc)
         END IF
         
         IF NOT cl_null(g_nmde4_d[l_ac].nmde026) THEN
            CALL s_voucher_free_account_desc(l_glad.glad0201,g_nmde4_d[l_ac].nmde026) RETURNING g_nmde4_d[l_ac].nmde026_desc
            LET g_nmde4_d[l_ac].nmde026_desc = s_desc_show1(g_nmde4_d[l_ac].nmde026,g_nmde4_d[l_ac].nmde026_desc)
         END IF
         
         IF NOT cl_null(g_nmde4_d[l_ac].nmde027) THEN
            CALL s_voucher_free_account_desc(l_glad.glad0211,g_nmde4_d[l_ac].nmde027) RETURNING g_nmde4_d[l_ac].nmde027_desc
            LET g_nmde4_d[l_ac].nmde027_desc = s_desc_show1(g_nmde4_d[l_ac].nmde027,g_nmde4_d[l_ac].nmde027_desc)
         END IF
         
         IF NOT cl_null(g_nmde4_d[l_ac].nmde028) THEN
            CALL s_voucher_free_account_desc(l_glad.glad0221,g_nmde4_d[l_ac].nmde028) RETURNING g_nmde4_d[l_ac].nmde028_desc
            LET g_nmde4_d[l_ac].nmde028_desc = s_desc_show1(g_nmde4_d[l_ac].nmde028,g_nmde4_d[l_ac].nmde028_desc)
         END IF
         
         IF NOT cl_null(g_nmde4_d[l_ac].nmde029) THEN
            CALL s_voucher_free_account_desc(l_glad.glad0231,g_nmde4_d[l_ac].nmde029) RETURNING g_nmde4_d[l_ac].nmde029_desc
            LET g_nmde4_d[l_ac].nmde029_desc = s_desc_show1(g_nmde4_d[l_ac].nmde029,g_nmde4_d[l_ac].nmde029_desc)
         END IF
         
         IF NOT cl_null(g_nmde4_d[l_ac].nmde030) THEN
            CALL s_voucher_free_account_desc(l_glad.glad0241,g_nmde4_d[l_ac].nmde030) RETURNING g_nmde4_d[l_ac].nmde030_desc
            LET g_nmde4_d[l_ac].nmde030_desc = s_desc_show1(g_nmde4_d[l_ac].nmde030,g_nmde4_d[l_ac].nmde030_desc)
         END IF
         
         IF NOT cl_null(g_nmde4_d[l_ac].nmde031) THEN
            CALL s_voucher_free_account_desc(l_glad.glad0251,g_nmde4_d[l_ac].nmde031) RETURNING g_nmde4_d[l_ac].nmde031_desc
            LET g_nmde4_d[l_ac].nmde031_desc = s_desc_show1(g_nmde4_d[l_ac].nmde031,g_nmde4_d[l_ac].nmde031_desc)
         END IF
         
         IF NOT cl_null(g_nmde4_d[l_ac].nmde032) THEN
            CALL s_voucher_free_account_desc(l_glad.glad0261,g_nmde4_d[l_ac].nmde032) RETURNING g_nmde4_d[l_ac].nmde032_desc
            LET g_nmde4_d[l_ac].nmde032_desc = s_desc_show1(g_nmde4_d[l_ac].nmde032,g_nmde4_d[l_ac].nmde032_desc)
         END IF
         
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
 
            CALL g_nmde_d.deleteElement(g_nmde_d.getLength())
      CALL g_nmde2_d.deleteElement(g_nmde2_d.getLength())
      CALL g_nmde3_d.deleteElement(g_nmde3_d.getLength())
      CALL g_nmde4_d.deleteElement(g_nmde4_d.getLength())
 
      
   END IF
   #b_fill 重寫
   IF 1<>1 THEN
   #160326-00001#25--add--end
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF anmt820_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY nmde_t.nmde004"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE anmt820_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR anmt820_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_nmde_m.nmdeld,g_nmde_m.nmde001,g_nmde_m.nmde002   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_nmde_m.nmdeld,g_nmde_m.nmde001,g_nmde_m.nmde002 INTO g_nmde_d[l_ac].nmde005, 
          g_nmde_d[l_ac].nmde004,g_nmde_d[l_ac].nmde100,g_nmde_d[l_ac].nmde101,g_nmde_d[l_ac].nmde102, 
          g_nmde_d[l_ac].nmde103,g_nmde_d[l_ac].nmde104,g_nmde_d[l_ac].nmde105,g_nmde_d[l_ac].nmde106, 
          g_nmde2_d[l_ac].nmde004,g_nmde2_d[l_ac].nmde005,g_nmde2_d[l_ac].nmde100,g_nmde2_d[l_ac].nmde111, 
          g_nmde2_d[l_ac].nmde102,g_nmde2_d[l_ac].nmde113,g_nmde2_d[l_ac].nmde114,g_nmde2_d[l_ac].nmde115, 
          g_nmde2_d[l_ac].nmde116,g_nmde3_d[l_ac].nmde004,g_nmde3_d[l_ac].nmde005,g_nmde3_d[l_ac].nmde100, 
          g_nmde3_d[l_ac].nmde121,g_nmde3_d[l_ac].nmde102,g_nmde3_d[l_ac].nmde123,g_nmde3_d[l_ac].nmde124, 
          g_nmde3_d[l_ac].nmde125,g_nmde3_d[l_ac].nmde126,g_nmde4_d[l_ac].nmde004,g_nmde4_d[l_ac].nmde015, 
          g_nmde4_d[l_ac].nmde033,g_nmde4_d[l_ac].nmde006,g_nmde4_d[l_ac].nmde007,g_nmde4_d[l_ac].nmde008, 
          g_nmde4_d[l_ac].nmde018,g_nmde4_d[l_ac].nmde019,g_nmde4_d[l_ac].nmde009,g_nmde4_d[l_ac].nmde010, 
          g_nmde4_d[l_ac].nmde020,g_nmde4_d[l_ac].nmde021,g_nmde4_d[l_ac].nmde022,g_nmde4_d[l_ac].nmde011, 
          g_nmde4_d[l_ac].nmde013,g_nmde4_d[l_ac].nmde014,g_nmde4_d[l_ac].nmde023,g_nmde4_d[l_ac].nmde024, 
          g_nmde4_d[l_ac].nmde025,g_nmde4_d[l_ac].nmde026,g_nmde4_d[l_ac].nmde027,g_nmde4_d[l_ac].nmde028, 
          g_nmde4_d[l_ac].nmde029,g_nmde4_d[l_ac].nmde030,g_nmde4_d[l_ac].nmde031,g_nmde4_d[l_ac].nmde032  
            #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
         #end add-point
      
         #帶出公用欄位reference值
         
         
         
         
         
 
        
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
 
            CALL g_nmde_d.deleteElement(g_nmde_d.getLength())
      CALL g_nmde2_d.deleteElement(g_nmde2_d.getLength())
      CALL g_nmde3_d.deleteElement(g_nmde3_d.getLength())
      CALL g_nmde4_d.deleteElement(g_nmde4_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   END IF #160326-00001#25 add b_fill 重寫
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_nmde_d.getLength()
      LET g_nmde_d_mask_o[l_ac].* =  g_nmde_d[l_ac].*
      CALL anmt820_nmde_t_mask()
      LET g_nmde_d_mask_n[l_ac].* =  g_nmde_d[l_ac].*
   END FOR
   
   LET g_nmde2_d_mask_o.* =  g_nmde2_d.*
   FOR l_ac = 1 TO g_nmde2_d.getLength()
      LET g_nmde2_d_mask_o[l_ac].* =  g_nmde2_d[l_ac].*
      CALL anmt820_nmde_t_mask()
      LET g_nmde2_d_mask_n[l_ac].* =  g_nmde2_d[l_ac].*
   END FOR
   LET g_nmde3_d_mask_o.* =  g_nmde3_d.*
   FOR l_ac = 1 TO g_nmde3_d.getLength()
      LET g_nmde3_d_mask_o[l_ac].* =  g_nmde3_d[l_ac].*
      CALL anmt820_nmde_t_mask()
      LET g_nmde3_d_mask_n[l_ac].* =  g_nmde3_d[l_ac].*
   END FOR
   LET g_nmde4_d_mask_o.* =  g_nmde4_d.*
   FOR l_ac = 1 TO g_nmde4_d.getLength()
      LET g_nmde4_d_mask_o[l_ac].* =  g_nmde4_d[l_ac].*
      CALL anmt820_nmde_t_mask()
      LET g_nmde4_d_mask_n[l_ac].* =  g_nmde4_d[l_ac].*
   END FOR
 
 
   FREE anmt820_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION anmt820_idx_chk()
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
      IF g_detail_idx > g_nmde_d.getLength() THEN
         LET g_detail_idx = g_nmde_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_nmde_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmde_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_nmde2_d.getLength() THEN
         LET g_detail_idx = g_nmde2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_nmde2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmde2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_nmde3_d.getLength() THEN
         LET g_detail_idx = g_nmde3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_nmde3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmde3_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_nmde4_d.getLength() THEN
         LET g_detail_idx = g_nmde4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_nmde4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmde4_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmt820_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_nmde_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION anmt820_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM nmde_t
    WHERE nmdeent = g_enterprise AND nmdeld = g_nmde_m.nmdeld AND
                              nmde001 = g_nmde_m.nmde001 AND
                              nmde002 = g_nmde_m.nmde002 AND
 
          nmde004 = g_nmde_d_t.nmde004
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "nmde_t:",SQLERRMESSAGE 
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
 
{<section id="anmt820.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION anmt820_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="anmt820.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION anmt820_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="anmt820.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION anmt820_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="anmt820.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION anmt820_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_nmde_d[l_ac].nmde004 = g_nmde_d_t.nmde004 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION anmt820_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="anmt820.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION anmt820_lock_b(ps_table,ps_page)
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
   #CALL anmt820_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="anmt820.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION anmt820_unlock_b(ps_table,ps_page)
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
 
{<section id="anmt820.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION anmt820_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("nmdeld,nmde001,nmde002",TRUE)
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
 
{<section id="anmt820.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION anmt820_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("nmdeld,nmde001,nmde002",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt820.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION anmt820_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION anmt820_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION anmt820_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt820.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION anmt820_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt820.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION anmt820_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt820.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION anmt820_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt820.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION anmt820_default_search()
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
      LET ls_wc = ls_wc, " nmdeld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " nmde001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " nmde002 = '", g_argv[03], "' AND "
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
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="anmt820.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION anmt820_fill_chk(ps_idx)
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
 
{<section id="anmt820.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION anmt820_modify_detail_chk(ps_record)
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
         LET ls_return = "nmde005"
      WHEN "s_detail2"
         LET ls_return = "nmde004_2"
      WHEN "s_detail3"
         LET ls_return = "nmde004_3"
      WHEN "s_detail4"
         LET ls_return = "nmde004_4"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="anmt820.mask_functions" >}
&include "erp/anm/anmt820_mask.4gl"
 
{</section>}
 
{<section id="anmt820.state_change" >}
    
 
{</section>}
 
{<section id="anmt820.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION anmt820_set_pk_array()
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
   LET g_pk_array[1].values = g_nmde_m.nmdeld
   LET g_pk_array[1].column = 'nmdeld'
   LET g_pk_array[2].values = g_nmde_m.nmde001
   LET g_pk_array[2].column = 'nmde001'
   LET g_pk_array[3].values = g_nmde_m.nmde002
   LET g_pk_array[3].column = 'nmde002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt820.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION anmt820_msgcentre_notify(lc_state)
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
   CALL anmt820_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_nmde_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt820.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 預設
# Memo...........:
# Usage..........: CALL anmt820_default()
# Input parameter:  
# Date & Author..: 2014/8/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt820_default()
   #年度、期別
   LET g_nmde_m.nmde001 =  YEAR(g_today)
   LET g_nmde_m.nmde002 = MONTH(g_today)
   DISPLAY BY NAME g_nmde_m.nmde001,g_nmde_m.nmde002
   
   #帳務中心
 #  SELECT DISTINCT xrah002 INTO g_nmde_m.nmdesite FROM xrah_t  
 #   WHERE xrah004 IN (SELECT ooag004 FROM ooag_t WHERE ooag001 = g_user AND ooagstus = 'Y')
 #     AND xrah007 ='Y' AND xrahstus ='Y' AND xrah001 = '3'
 #  ORDER BY xrah002
    CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING g_sub_success,g_nmde_m.nmdesite,g_errno
    DISPLAY BY NAME g_nmde_m.nmdesite
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt820_for_gen()
# Input parameter:  
# Date & Author..: 2014/8/19 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt820_for_gen()
   DEFINE l_sql         STRING
   DEFINE l_wc          STRING
   DEFINE l_nmde004     LIKE nmde_t.nmde004
   DEFINE l_success     LIKE type_t.chr1

   #IF g_chk_gen = 'Y' THEN RETURN END IF
#   CALL s_transaction_begin()   #160326-00001#25 mark
   IF cl_null(g_wc) THEN LET g_wc = " 1=1" END IF

   LET l_sql = "SELECT DISTINCT nmde004 FROM nmde_t WHERE nmdeent = '",g_enterprise,"'",
               "   AND nmdeld  = '",g_nmde_m.nmdeld,"'",
               "   AND nmde001 = '",g_nmde_m.nmde001,"'",
               "   AND nmde002 = '",g_nmde_m.nmde002,"'",
               "   AND ",g_wc
   PREPARE anmt820_03_prep FROM l_sql
   DECLARE anmt820_03_curs CURSOR FOR anmt820_03_prep

   LET g_wc = ""
   LET l_nmde004 = ""

   FOREACH anmt820_03_curs INTO l_nmde004
      IF cl_null(l_wc) THEN
         LET l_wc = "nmde004 IN ('",l_nmde004,"'"
      ELSE
         LET l_wc = l_wc,",'",l_nmde004,"'"
      END IF
   END FOREACH
   LET l_wc = l_wc,")"

   CALL s_anmt820_gen_nm(g_nmde_m.nmdeld,'',g_nmde_m.nmde001,g_nmde_m.nmde002,'',1,l_wc,'Y') RETURNING l_success

   #LET g_chk_gen = 'Y'
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
PRIVATE FUNCTION anmt820_go_gen()
   DEFINE sr         RECORD
             glapdocno     LIKE glap_t.glapdocno,
             glapdocdt     LIKE glap_t.glapdocdt
                     END RECORD
   DEFINE l_s        LIKE type_t.chr1
   DEFINE l_glaa024  LIKE glaa_t.glaa024
   DEFINE r_success  LIKE type_t.chr1
   DEFINE r_start_no LIKE glap_t.glapdocno
   DEFINE r_end_no   LIKE glap_t.glapdocno
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_glaa121  LIKE glaa_t.glaa121
   DEFINE l_wc       STRING 
   DEFINE l_chr      LIKE type_t.chr1           #151013-00016#4
   DEFINE l_prog     LIKE gzza_t.gzza001        #151013-00016#4
   DEFINE l_sys      LIKE type_t.chr10          #160530-00003#4 add
   DEFINE l_glca002  LIKE glca_t.glca002   #160530-00003#4 add
   
   SELECT glaa024,glaa121 INTO l_glaa024,l_glaa121 FROM glaa_t  #160530-00003#4 add l_glaa121
    WHERE glaaent = g_enterprise
      AND glaald = g_nmde_m.nmdeld
   
   #160530-00003#4--add--str--
   #先检核分录是否正确，如果正确继续抛转凭证，否则，报错
   CALL cl_err_collect_init()
   LET l_success=TRUE
   SELECT (CASE WHEN glca002 = '2' THEN 'Y' ELSE 'N' END) INTO l_glca002
     FROM glca_t
    WHERE glcaent = g_enterprise
      AND glcald  = g_nmde_m.nmdeld AND glca001 = 'NM'
   IF l_glca002 = 'Y' THEN
      LET l_sys = 'AC'
      LET l_prog = 'aglt350'
   ELSE
      LET l_sys = 'NM'
      LET l_prog = 'aglt310'
   END IF
   IF l_glaa121 = 'Y' THEN
      CALL s_chk_voucher(l_sys,'N40',g_nmde_m.nmdeld,g_nmde_m.nmdedocno) RETURNING l_success
   ELSE
      CALL anmt820_for_gen() #160326-00001#25 add
      #按科目设置进行UPDATE,若有做不管理的字段,UPDATE至' '
#      CALL s_anmt820_gen_nm_1_upd_tmp(g_nmde_m.nmdeld)  RETURNING l_success  #160326-00001#25 mark 在产生凭证时处理
      IF l_success= TRUE THEN
         #分录检核
         CALL s_anmt820_tmp_chk(g_nmde_m.nmdeld,g_nmde_m.nmdedocno) RETURNING l_success
      END IF
   END IF
   CALL cl_err_collect_show()
   IF l_success = FALSE THEN
      RETURN
   END IF
   #160530-00003#4--add--end
               
   OPEN WINDOW w_anmt820_03_s01 WITH FORM cl_ap_formpath("anm",'anmt820_03_s01')

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
     
         INPUT BY NAME sr.glapdocno,sr.glapdocdt ATTRIBUTE(WITHOUT DEFAULTS)

            BEFORE INPUT
               #LET sr.glapdocdt = g_today            #160628-00013#1 
               LET sr.glapdocdt = g_nmde_m.nmdedocdt  #160628-00013#1 
               DISPLAY BY NAME sr.glapdocdt
               
            AFTER FIELD glapdocno
               IF NOT cl_null(sr.glapdocno) THEN 
                  #151013-00016#4 mark str---
                  #INITIALIZE g_chkparam.* TO NULL
                  #LET g_chkparam.arg1 = l_glaa024
                  #LET g_chkparam.arg2 = sr.glapdocno
                  ##160318-00025#39  2016/04/22  by pengxin  add(S)
                  #LET g_errshow = TRUE #是否開窗 
                  #LET g_chkparam.err_str[1] = "agl-00189:sub-01302|aooi200|",cl_get_progname("aooi200",g_lang,"2"),"|:EXEPROGaooi200"
                  ##160318-00025#39  2016/04/22  by pengxin  add(E)
                  #IF NOT cl_chk_exist("v_ooba002_07") THEN
                  #151013-00016#4 mark end---
                  #151013-00016#4 add str---
                  #160530-00003#4--mark--str--
#                  LET l_chr = 'N'  #不迴轉
#                  #重評價
#                  SELECT (CASE WHEN glca002 = '2' THEN 'Y' ELSE 'N' END) INTO l_chr
#                    FROM glca_t
#                   WHERE glcaent = g_enterprise
#                     AND glcald  = g_nmde_m.nmdeld AND glca001 = 'NM'
#                  IF l_chr = 'Y' THEN
#                     LET l_prog = 'aglt350'
#                  ELSE
#                     LET l_prog = 'aglt310'
#                  END IF
                  #160530-00003#4--mark--end
                  IF NOT s_aooi200_fin_chk_docno(g_nmde_m.nmdeld,'','',sr.glapdocno,sr.glapdocdt,l_prog) THEN
                  #151013-00016#4 add end---
                    #檢查失敗時後續處理
                    LET sr.glapdocno = ''
                    NEXT FIELD CURRENT
                  END IF
               END IF 

            AFTER FIELD glapdocdt

            ON ACTION controlp INFIELD glapdocno
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = sr.glapdocno
               LET g_qryparam.arg1 = l_glaa024
               #LET g_qryparam.arg2 = 'aglt310'        #151013-00016#4 mark
               #CALL q_ooba002_3()          #呼叫開窗   #151013-00016#4 mark
               #151013-00016#4 add str---
               #160530-00003#4--mark--str--
#               #重評價
#               SELECT (CASE WHEN glca002 = '2' THEN 'Y' ELSE 'N' END) INTO l_chr
#                 FROM glca_t
#                WHERE glcaent = g_enterprise
#                  AND glcald  = g_nmde_m.nmdeld AND glca001 = 'NM'
#               IF l_chr = 'Y' THEN
#                  LET g_qryparam.arg2 = 'aglt350'
#               ELSE
#                  LET g_qryparam.arg2 = 'aglt310'
#               END IF
               #160530-00003#4--mark--end
               LET g_qryparam.arg2 = l_prog #160530-00003#4 add
               CALL q_ooba002_1()
               #151013-00016#4 add end---
               LET sr.glapdocno = g_qryparam.return1
               DISPLAY sr.glapdocno TO glapdocno
               NEXT FIELD glapdocno

         END INPUT

         ON ACTION accept
            ACCEPT DIALOG

         ON ACTION cancel
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG

      END DIALOG

   IF INT_FLAG = 0 THEN
      #151013-00019#13 mark ------
      #CALL s_anmt820_gen_nm_1_ins_glap(sr.glapdocno,sr.glapdocdt,g_nmde_m.nmdeld,'1')
      #     RETURNING r_success,r_start_no,r_end_no
      #151013-00019#13 mark end---
      #151013-00019#13 add ------
      #160530-00003#4--add--str--d
      CALL s_transaction_begin()   #160326-00001#25 add
      #不启用分录底稿
      IF l_glaa121 <> 'Y' THEN
         #插入凭证单头
         #CALL s_anmt820_gen_nm_1_ins_glap(sr.glapdocno,sr.glapdocdt,g_nmde_m.nmdeld,'1') #170118-00030#1 mark
         CALL s_anmt820_gen_nm_1_ins_glap(sr.glapdocno,sr.glapdocdt,g_nmde_m.nmdeld,'5')  #170118-00030#1 add
            RETURNING r_success,r_start_no,r_end_no
      ELSE
      #启用分录底稿
         IF l_prog = 'aglt350' THEN
            LET g_prog = 'aglt350'
         END IF
      #160530-00003#4--add--end
         LET l_wc =" glgbdocno = '",g_nmde_m.nmdedocno,"' "
#         CALL s_pre_voucher_ins_glap('NM','N40',g_nmde_m.nmdeld,sr.glapdocdt,sr.glapdocno,'1',l_wc) #160530-00003#4 mark
         #CALL s_pre_voucher_ins_glap(l_sys,'N40',g_nmde_m.nmdeld,sr.glapdocdt,sr.glapdocno,'1',l_wc) #170118-00030#1 mark
         CALL s_pre_voucher_ins_glap(l_sys,'N40',g_nmde_m.nmdeld,sr.glapdocdt,sr.glapdocno,'5',l_wc)  #170118-00030#1 add
              RETURNING r_success,r_start_no,r_end_no
         #151013-00019#13 add end---
         LET g_prog = 'anmt820' #160530-00003#4 add
      END IF #160530-00003#4 add
      
      IF r_success = TRUE AND NOT cl_null(r_start_no) THEN
         UPDATE nmde_t SET nmde017=r_start_no
          WHERE nmdeent = g_enterprise AND nmdeld = g_nmde_m.nmdeld
            AND nmde001 = g_nmde_m.nmde001 AND nmde002 = g_nmde_m.nmde002
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "update nmde_t"
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
         END IF
#160530-00003#4--mark--str--
#         SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise
#            AND glaald = g_nmde_m.nmdeld
#160530-00003#4--mark--end
         IF l_glaa121 = 'Y' THEN
            LET l_wc = "glgadocno = '",g_nmde_m.nmdedocno,"'"
           #CALL s_pre_voucher_upd('NM','N40',g_nmde_m.nmdeld,'',r_start_no,g_today,l_wc) RETURNING l_success  #150707-00001#8 mark
#            CALL s_pre_voucher_upd('NM','N40',g_nmde_m.nmdeld,'',r_start_no,sr.glapdocdt,l_wc) RETURNING l_success  #150707-00001#8 #160530-00003#4 mark
            CALL s_pre_voucher_upd(l_sys,'N40',g_nmde_m.nmdeld,'',r_start_no,sr.glapdocdt,l_wc) RETURNING l_success #160530-00003#4 add
            IF l_success = FALSE THEN
               LET r_success = FALSE
            END IF
         END IF 
      END IF
      IF NOT r_success THEN
         CALL s_transaction_end('N','1')
         CALL cl_ask_confirm('axr-00120') RETURNING l_s
      ELSE
         DISPLAY r_start_no,r_end_no TO b_xrca038,e_xrca038
         CALL s_transaction_end('Y','1')
         CALL cl_ask_confirm('axr-00119') RETURNING l_s
      END IF
   ELSE
      LET INT_FLAG = FALSE
   END IF

   CLOSE WINDOW w_anmt820_03_s01
END FUNCTION

################################################################################
# Descriptions...: 傳票還原
# Memo...........:
# Usage..........: CALL anmt820_reduction()
#                  
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt820_reduction()
DEFINE l_glapdocdt      LIKE glap_t.glapdocdt    #150707-00001#8
DEFINE l_chr            LIKE type_t.chr1         #151013-00016#4
DEFINE l_sys            LIKE type_t.chr10        #160530-00003#4 add
DEFINE l_glca002        LIKE glca_t.glca002      #160530-00003#4 add
DEFINE l_scom0002       LIKE type_t.chr10        #170103-00019#15 add
DEFINE l_success        LIKE type_t.num5         #170103-00019#15 add

   #开启事务
   CALL s_transaction_begin()
   #错误信息汇总初始化
   #CALL cl_showmsg_init()
   CALL cl_err_collect_init()
   LET g_success = 'Y'  #160530-00003#4 add
   
   #150707-00001#8--(s)
   SELECT glapdocdt INTO l_glapdocdt
     FROM glap_t
    WHERE glapent = g_enterprise
      AND glapld = g_nmde_m.nmdeld
      AND glapdocno = g_nmde_m.nmde017
   #150707-00001#8--(e)
   
   #170103-00019#15--add--str--
   CALL cl_get_para(g_enterprise,g_nmde_m.nmdecomp,'S-COM-0002') RETURNING l_scom0002 
   #更新相关的细项立冲账资料
   LET l_success = TRUE
   CALL s_pre_voucher_delete_glax(g_nmde_m.nmdeld,g_nmde_m.nmde017,'',l_scom0002) RETURNING l_success
   IF l_success = FALSE THEN
      LET g_success = 'N' 
   END IF
   
   IF l_scom0002 = 'Y' THEN
   #凭证作废处理
      UPDATE glap_t SET glapstus = 'X'
       WHERE glapent = g_enterprise
         AND glapld = g_nmde_m.nmdeld
         AND glapdocno = g_nmde_m.nmde017
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'UPDATE glap_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
      END IF
   ELSE
   #170103-00019#15--add--end
      #刪除單頭
      DELETE FROM glap_t
       WHERE glapent = g_enterprise
         AND glapld = g_nmde_m.nmdeld
         AND glapdocno = g_nmde_m.nmde017
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'DELETE glap_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
      END IF
   
      #刪除單身
      DELETE FROM glaq_t
       WHERE glaqent = g_enterprise
         AND glaqld = g_nmde_m.nmdeld
         AND glaqdocno = g_nmde_m.nmde017
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'DELETE glaq_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
      END IF
   
   #160326-00001#25--add--str--
#170103-00019#15--mark--str--
#将这段逻辑移到下面
#   #删除对应现金变动码
#   DELETE FROM glbc_t
#    WHERE glbcent = g_enterprise
#      AND glbcld  = g_nmde_m.nmdeld
#      AND glbcdocno = g_nmde_m.nmde017
#   IF SQLCA.SQLCODE THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.SQLCODE
#      LET g_errparam.extend = 'DELETE glbc_t'
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      LET g_success = 'N'
#   END IF
#170103-00019#15--mark--end   
   #160326-00001#25--add--end
   
      #150707-00001#8--(s)
     #LET g_prog = 'aglt310'   #151013-00016#4 mark
      #151013-00016#4 add str---
      LET l_chr = 'N'  #不迴轉
      #重評價
      SELECT (CASE WHEN glca002 = '2' THEN 'Y' ELSE 'N' END) INTO l_chr
        FROM glca_t
       WHERE glcaent = g_enterprise
         AND glcald  = g_nmde_m.nmdeld AND glca001 = 'NM'
      IF l_chr = 'Y' THEN
         LET g_prog = 'aglt350'
      ELSE
         LET g_prog = 'aglt310'
      END IF
      #151013-00016#4 add end---
      IF NOT s_aooi200_fin_del_docno(g_nmde_m.nmdeld,g_nmde_m.nmde017,l_glapdocdt) THEN
         LET g_success = 'N'
      END IF
      LET g_prog = 'anmt820'
      #150707-00001#8--(e) 
   END IF #170103-00019#15 add
   
   #170103-00019#15--add--str--
   #删除对应现金变动码
   DELETE FROM glbc_t
    WHERE glbcent = g_enterprise
      AND glbcld  = g_nmde_m.nmdeld
      AND glbcdocno = g_nmde_m.nmde017
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = 'DELETE glbc_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
   END IF 
   #170103-00019#15--add--end
   
   IF g_success = 'Y' THEN #160530-00003#4 add
      #更新單據這邊傳票號碼要給空
      UPDATE nmde_t SET nmde017 = NULL
       WHERE nmdeent = g_enterprise
         AND nmdeld = g_nmde_m.nmdeld
         AND nmde001 = g_nmde_m.nmde001
         AND nmde002 = g_nmde_m.nmde002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'update nmde_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
      ELSE
         LET  g_nmde_m.nmde017 = NULL
      END IF
      
      #160530-00003#4--add--str--
      SELECT (CASE WHEN glca002 = '2' THEN 'Y' ELSE 'N' END) INTO l_glca002
        FROM glca_t
       WHERE glcaent = g_enterprise
         AND glcald  = g_nmde_m.nmdeld AND glca001 = 'NM'
      IF l_glca002 = 'Y' THEN
         LET l_sys = 'AC'
      ELSE
         LET l_sys = 'NM'
      END IF
      #160530-00003#4--add--end
      
      #141202-00061#17
      UPDATE glga_t SET glga007 = ''
       WHERE glgaent = g_enterprise AND glgald = g_nmde_m.nmdeld
#         AND glgadocno=g_nmde_m.nmdedocno AND glga100 = 'NM' AND glga101 = 'N40' #160530-00003#4 mark
         AND glgadocno=g_nmde_m.nmdedocno AND glga100 = l_sys AND glga101 = 'N40' #160530-00003#4 add
      #141202-00061#17
   END IF #160530-00003#4 add
   
   CALL cl_err_collect_show() #160513-00008#3 add
   IF g_success = 'N' THEN
      CALL s_transaction_end('N',1)
#      CALL cl_err_collect_show() #160513-00008#3 mark
   ELSE
      CALL s_transaction_end('Y',1)
   END IF

   DISPLAY BY NAME g_nmde_m.nmde017
END FUNCTION

################################################################################
# Descriptions...: 编辑后立即抛转
# Memo...........:
# Usage..........: CALL anmt820_immediately_gen()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/12/08 By 07166
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt820_immediately_gen()
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0032        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_glap001         LIKE glap_t.glap001
   DEFINE la_param          RECORD
          prog              STRING,
          param             DYNAMIC ARRAY OF STRING
                            END RECORD
   DEFINE ls_js             STRING
   DEFINE l_glaa024         LIKE glaa_t.glaa024
   DEFINE l_ooac004         LIKE ooac_t.ooac004
   #161128-00061#2---modify----begin----------
   #DEFINE l_nmde            RECORD LIKE nmde_t.*
   DEFINE l_nmde RECORD  #銀行重評價檔
       nmdeent LIKE nmde_t.nmdeent, #企業編號
       nmdecomp LIKE nmde_t.nmdecomp, #法人
       nmdeld LIKE nmde_t.nmdeld, #帳套
       nmdesite LIKE nmde_t.nmdesite, #帳務中心
       nmde001 LIKE nmde_t.nmde001, #年度
       nmde002 LIKE nmde_t.nmde002, #期別
       nmde003 LIKE nmde_t.nmde003, #來源模組
       nmde004 LIKE nmde_t.nmde004, #銀行帳戶
       nmde005 LIKE nmde_t.nmde005, #開戶組織
       nmde006 LIKE nmde_t.nmde006, #部門
       nmde007 LIKE nmde_t.nmde007, #責任中心
       nmde008 LIKE nmde_t.nmde008, #區域
       nmde009 LIKE nmde_t.nmde009, #客群
       nmde010 LIKE nmde_t.nmde010, #產品類別
       nmde011 LIKE nmde_t.nmde011, #人員
       nmde012 LIKE nmde_t.nmde012, #預算編號
       nmde013 LIKE nmde_t.nmde013, #專案編號
       nmde014 LIKE nmde_t.nmde014, #WBS編號
       nmde015 LIKE nmde_t.nmde015, #會計科目
       nmde017 LIKE nmde_t.nmde017, #傳票號碼
       nmde100 LIKE nmde_t.nmde100, #幣別
       nmde101 LIKE nmde_t.nmde101, #重評價匯率
       nmde102 LIKE nmde_t.nmde102, #本期原幣未沖金額
       nmde103 LIKE nmde_t.nmde103, #本期本幣未沖金額
       nmde104 LIKE nmde_t.nmde104, #本期重評價後本幣金額
       nmde105 LIKE nmde_t.nmde105, #本期匯差金額
       nmde106 LIKE nmde_t.nmde106, #本期匯差傳票提列金額
       nmde111 LIKE nmde_t.nmde111, #本位幣二重評價匯率
       nmde113 LIKE nmde_t.nmde113, #本期本位幣二未沖金額
       nmde114 LIKE nmde_t.nmde114, #本期本位幣二重評價後金額
       nmde115 LIKE nmde_t.nmde115, #本期本位幣二匯差金額
       nmde116 LIKE nmde_t.nmde116, #本期本位幣二匯差傳票提列提列金額
       nmde121 LIKE nmde_t.nmde121, #本位幣三重評價匯率
       nmde123 LIKE nmde_t.nmde123, #本期本位幣三未沖金額
       nmde124 LIKE nmde_t.nmde124, #本期本位幣三重評價後金額
       nmde125 LIKE nmde_t.nmde125, #本期本位幣三匯差金額
       nmde126 LIKE nmde_t.nmde126, #本期本位幣三匯差傳票提列提列金額
       nmdedocno LIKE nmde_t.nmdedocno, #單據編號
       nmdedocdt LIKE nmde_t.nmdedocdt, #單據日期
       nmde018 LIKE nmde_t.nmde018, #收付款客商
       nmde019 LIKE nmde_t.nmde019, #帳款客商
       nmde020 LIKE nmde_t.nmde020, #經營方式
       nmde021 LIKE nmde_t.nmde021, #通路
       nmde022 LIKE nmde_t.nmde022, #品牌
       nmde023 LIKE nmde_t.nmde023, #自由核算項一
       nmde024 LIKE nmde_t.nmde024, #自由核算項二
       nmde025 LIKE nmde_t.nmde025, #自由核算項三
       nmde026 LIKE nmde_t.nmde026, #自由核算項四
       nmde027 LIKE nmde_t.nmde027, #自由核算項五
       nmde028 LIKE nmde_t.nmde028, #自由核算項六
       nmde029 LIKE nmde_t.nmde029, #自由核算項七
       nmde030 LIKE nmde_t.nmde030, #自由核算項八
       nmde031 LIKE nmde_t.nmde031, #自由核算項九
       nmde032 LIKE nmde_t.nmde032, #自由核算項十
       nmde033 LIKE nmde_t.nmde033  #摘要
       END RECORD

   #161128-00061#2---modify----end----------
   DEFINE l_glaa015   LIKE glaa_t.glaa015
   DEFINE l_glaa019   LIKE glaa_t.glaa019
   DEFINE l_glbc009   LIKE glbc_t.glbc009
   DEFINE l_glbc012   LIKE glbc_t.glbc012
   DEFINE l_glbc014   LIKE glbc_t.glbc014
   DEFINE l_nmck113   LIKE nmck_t.nmck113
   DEFINE l_nmck123   LIKE nmck_t.nmck123
   DEFINE l_nmck133   LIKE nmck_t.nmck133
   DEFINE l_cnt       LIKE type_t.num5 
   DEFINE l_dfin0030        LIKE type_t.chr1 
   DEFINE l_gl_slip         LIKE ooba_t.ooba002      #總帳單別   
   
   IF cl_null(g_nmde_m.nmdeld)    THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmde_m.nmdecomp)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmde_m.nmdedocno) THEN RETURN END IF   #無資料直接返回不做處理
  

#  SELECT * INTO l_nmde.* 
#    FROM nmde_t 
#   WHERE nmdeent = g_enterprise 
#     AND nmde004 = g_nmde_m.nmde004 
#     AND nmdeld = g_nmde_m.nmdeld 
#     AND nmde001 = g_nmde_m.nmde001
#     AND nmde002 = g_nmde_m.nmde002
#
#  IF NOT cl_null(l_nmde.nmde017)  THEN RETURN END IF #传票号码已经存在返回不做处理

   IF NOT cl_ask_confirm('aap-00404') THEN RETURN END IF  #询问是否直接抛转凭证

  #取得單別
   CALL s_aooi200_fin_get_slip(g_nmde_m.nmdedocno) RETURNING l_success,l_slip
  #取得單別設置的"是否直接抛转凭证"參數
   CALL s_fin_get_doc_para(g_nmde_m.nmdeld,g_nmde_m.nmdecomp,l_slip,'D-FIN-0032') RETURNING l_dfin0032

   IF cl_null(l_dfin0032) OR l_dfin0032 MATCHES '[Nn]' THEN #參數值為空或為N則不做直接抛转凭证邏輯
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00406' #未设置直接抛转凭证
      LET g_errparam.extend = l_slip
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN 
   END IF 

   #是否产生分录传票
   CALL s_fin_get_doc_para(g_nmde_m.nmdeld,g_nmde_m.nmdecomp,l_slip,'D-FIN-0030') RETURNING l_dfin0030
   IF l_dfin0030 <> 'Y'  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00054' #此账款单设置为不需产生凭证!!
      LET g_errparam.extend = l_slip
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN 
   END IF
   
   
   SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019 
     FROM glaa_t 
    WHERE glaaent = g_enterprise AND glaald = g_nmde_m.nmdeld AND glaa014 = 'Y'
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM glbc_t
    WHERE glbcent=g_enterprise AND glbcld=g_nmde_m.nmdeld
      AND glbcdocno=g_nmde_m.nmdedocno AND glbc001=g_nmde_m.nmde001
      AND glbc002=g_nmde_m.nmde002
      
   SELECT SUM(glbc009),SUM(glbc012),SUM(glbc014)
     INTO l_glbc009,l_glbc012,l_glbc014
     FROM glbc_t
    WHERE glbcent=g_enterprise AND glbcld=g_nmde_m.nmdeld
      AND glbcdocno=g_nmde_m.nmdedocno AND glbc001=g_nmde_m.nmde001
      AND glbc002=g_nmde_m.nmde002
  
   SELECT SUM(nmde106),SUM(nmde116),SUM(nmde126) #160530-00003#4 mark #160708-00016#1 unmark
#   SELECT SUM(nmde105),SUM(nmde115),SUM(nmde125)  #160530-00003#4 add #160708-00016#1 mark
     INTO l_nmck113,l_nmck123,l_nmck133
     FROM nmde_t
    WHERE nmdeent = g_enterprise
      AND nmdeld = g_nmde_m.nmdeld
      AND nmde001 = g_nmde_m.nmde001
      AND nmde002 = g_nmde_m.nmde002
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00221'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF 
   IF l_glbc009 <> l_nmck113 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00146'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF 
   
   IF l_glaa015='Y' AND l_glbc012 <> l_nmck123 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00147'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   IF l_glaa019='Y' AND l_glbc014 <> l_nmck133 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00148'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF 
   
   #取得傳票單別(D-FIN-2002:產生之總帳傳票單別)
   LET l_gl_slip = ''
   CALL s_fin_get_doc_para(g_nmde_m.nmdeld,g_nmde_m.nmdecomp,l_slip,'D-FIN-2002') RETURNING l_gl_slip
   
   CALL anmt820_for_gen()
   
   IF l_gl_slip = '' THEN
      CALL anmt820_go_gen()
     ELSE 
      CALL anmt820_go_gen2(l_gl_slip)
   END IF
   
   SELECT nmde017 INTO g_nmde_m.nmde017 FROM nmde_t
    WHERE nmdeent = g_enterprise AND nmdeld = g_nmde_m.nmdeld
      AND nmde001 = g_nmde_m.nmde001 AND nmde002 = g_nmde_m.nmde002
   CALL anmt820_show() 
 
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
PRIVATE FUNCTION anmt820_go_gen2(p_lip)
   DEFINE sr         RECORD
             glapdocno     LIKE glap_t.glapdocno,
             glapdocdt     LIKE glap_t.glapdocdt
                     END RECORD
   DEFINE l_s        LIKE type_t.chr1
   DEFINE l_glaa024  LIKE glaa_t.glaa024
   DEFINE r_success  LIKE type_t.chr1
   DEFINE r_start_no LIKE glap_t.glapdocno
   DEFINE r_end_no   LIKE glap_t.glapdocno
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_glaa121  LIKE glaa_t.glaa121
   DEFINE l_wc       STRING 
   DEFINE l_chr      LIKE type_t.chr1           
   DEFINE l_prog     LIKE gzza_t.gzza001        
   DEFINE p_lip      LIKE ooba_t.ooba002
   DEFINE l_sys      LIKE type_t.chr10        #160530-00003#4 add
   DEFINE l_glca002  LIKE glca_t.glca002   #160530-00003#4 add
   
   SELECT glaa024 INTO l_glaa024 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_nmde_m.nmdeld
      
      LET sr.glapdocno = p_lip 
      LET sr.glapdocdt = g_today
      DISPLAY BY NAME sr.glapdocdt
      DISPLAY BY NAME sr.glapdocno
      
      #160530-00003#4--add--str--
      SELECT (CASE WHEN glca002 = '2' THEN 'Y' ELSE 'N' END) INTO l_glca002
        FROM glca_t
       WHERE glcaent = g_enterprise
         AND glcald  = g_nmde_m.nmdeld AND glca001 = 'NM'
      IF l_glca002 = 'Y' THEN
         LET l_sys = 'AC'
      ELSE
         LET l_sys = 'NM'
      END IF
      #160530-00003#4--add--end
      
      LET l_wc =" glgbdocno = '",g_nmde_m.nmdedocno,"' "
#         CALL s_pre_voucher_ins_glap('NM','N40',g_nmde_m.nmdeld,sr.glapdocdt,sr.glapdocno,'1',l_wc) #160530-00003#4 mark 
      #CALL s_pre_voucher_ins_glap(l_sys,'N40',g_nmde_m.nmdeld,sr.glapdocdt,sr.glapdocno,'1',l_wc) #160530-00003#4 add #170118-00030#1 mark
      CALL s_pre_voucher_ins_glap(l_sys,'N40',g_nmde_m.nmdeld,sr.glapdocdt,sr.glapdocno,'5',l_wc) #170118-00030#1 add
              RETURNING r_success,r_start_no,r_end_no
         #151013-00019#13 add end---
         IF r_success = TRUE AND NOT cl_null(r_start_no) THEN
            UPDATE nmde_t SET nmde017=r_start_no
             WHERE nmdeent = g_enterprise AND nmdeld = g_nmde_m.nmdeld
               AND nmde001 = g_nmde_m.nmde001 AND nmde002 = g_nmde_m.nmde002
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "update nmde_t"
               LET g_errparam.code   = SQLCA.SQLCODE
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET r_success = FALSE
            END IF
            SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise
               AND glaald = g_nmde_m.nmdeld
            IF l_glaa121 = 'Y' THEN
               LET l_wc = "glgadocno = '",g_nmde_m.nmdedocno,"'"
              #CALL s_pre_voucher_upd('NM','N40',g_nmde_m.nmdeld,'',r_start_no,g_today,l_wc) RETURNING l_success  #150707-00001#8 mark
#               CALL s_pre_voucher_upd('NM','N40',g_nmde_m.nmdeld,'',r_start_no,sr.glapdocdt,l_wc) RETURNING l_success  #150707-00001#8 #160530-00003#4 mark
               CALL s_pre_voucher_upd(l_sys,'N40',g_nmde_m.nmdeld,'',r_start_no,sr.glapdocdt,l_wc) RETURNING l_success  #160530-00003#4 add
               IF l_success = FALSE THEN
                  LET r_success = FALSE
               END IF
            END IF
         END IF
         IF NOT r_success THEN
            CALL s_transaction_end('N','1')
            CALL cl_ask_confirm('axr-00120') RETURNING l_s
         ELSE
            DISPLAY r_start_no,r_end_no TO b_xrca038,e_xrca038
            CALL s_transaction_end('Y','1')
            CALL cl_ask_confirm('axr-00119') RETURNING l_s
         END IF   
END FUNCTION

 
{</section>}
 
