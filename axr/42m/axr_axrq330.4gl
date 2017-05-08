#該程式已解開Section, 不再透過樣板產出!
{<section id="axrq330.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:15(2015-12-03 17:58:09), PR版次:0019(2016-12-02 09:29:48)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000263
#+ Filename...: axrq330
#+ Description: 應收帳款查詢作業
#+ Creator....: 01727(2014-06-24 16:20:27)
#+ Modifier...: 02599 -SD/PR- 02481
 
{</section>}
 
{<section id="axrq330.global" >}
#應用 q04 樣板自動產生(Version:28)
#add-point:填寫註解說明 name="global.memo"
#150331-00006#6 2015/09/09 By 01727 原單身"沖銷明細"的顯示，是依帳款單目前所在單號顯示該帳款單的沖銷記錄； 
#                                   變更修改：
#                                   "沖銷明細"直接取 "帳款明細"內相關的沖銷單數據，即
#                                   。依’帳款明細’資料，取得該範圍內帳款單LIST，取已沖銷的沖銷資料
#                                   。資料篩選：
#                                   　１。沖銷明細檔(xrce_t) 
#                                         WHERE　(xrce003 IN (xrcadocno list 帳款明細))
#                                              AND { WHEN xrce001='axrt300' THEN xrcedocno=xrcadocno AND xrcastus='Y' 	#判斷直接沖銷,且須為有效單據
#                                   	WHEN xrce001='axrt400' THEN xrcedocno=xrdadocno AND xrdastus='Y'}
#                                               # 。金額之呈現，依據沖銷之[正負項xrce015](C/D)作正負數值合計
#                                               #D：負數 #	C：正數(-1)
#                                      ２。沖暫估明細(xrcf_t)  WHERE xrcf008 IN (xrcadocno list帳款明細)
#                                             AND xrcfdocno=xrcadocno AND xrcastus='Y' #判斷須為有效單據
#                                   　３。應付沖銷明細檔(apce_t) WHERE 　(apce003 IN (xrcadocno list帳款明細) )
#                                             AND xrce001='aapt420' THEN apcedocno=apdadocno AND apdastus='Y'
#                                   1. 第一頁箋"帳款單據",若單據性質為2*/02/04者, 要改為負數呈現
#                                   2. 第三頁箋"沖銷明細",一次顯示所有沖銷記錄, 借貸別判斷正負數值顯示 
#                                      借(D)則為負值呈現, 底下的合計值才會正確
#                                      沖銷暫估xrcf_t, 若是沖銷原立暫估單性質為02/04者, 則以負數值呈現
#151013-00019#3   2015/10/16  By Reanna   取來源資料沒有增加ENT
#150401-00001#36  2015/11/10  By Belle    axrq330 排除未確認及作廢單者
#151130-00015#1   2015/12/03  By 02599    INPUT段增加單據狀態篩選條件
#151217-00017#1   2015/12/17  By 01727    axrq330预收款未抓到axrt400产生的溢收待抵金额
#151231-00010#7   2016/02/23  By yangtt   增加控制組/若單頭沒有帳套條件的開窗,都限制取目前所在據點對應的法人串 pmabsite/若input 條件有帳套就以帳套對應法人串 pmabsite
#160505-00007#22  2016/05/30  By 02599    程式优化
#160727-00019#6   2016/07/28  By 08734    axrq330_xrca_tmp ——> axrq330_tmp01
#160727-00019#6   2016/07/28  By 08734    axrq330_print_tmp ——> axrq330_tmp02
#160729-00024#1   2016/08/04  By 01727    新增按钮需要灰掉
#160807-00012#1   2016/08/08  By 01727    查询出资料后，每点一次确定按钮，金额就会变多
#160731-00372#1   2016/08/16  By 07900    客户开窗不要开供应商
#160811-00009#2   2016/08/17  By 01531    账务中心/法人/账套权限控管
#160826-00009#1   2016/08/26  By 01727    問題描述：N/P之類的錄不進去
#                                         mark 掉ON ACTION next/previous/fist/last/jump可解
#160817-00054#1   2016/09/22 By 01727     1.axrq330, 增加 anmt540 己收款, 但未沖銷的資料明細
#                                         2.增加列印功能, 列印單頭的資料內容即可。
#160913-00017#9   2016/09/22 By 07900     AXR模组调整交易客商开窗
#161021-00050#4   2016/10/24 By 08729     處理組織開窗
#161111-00049#1   2016/11/12 By 01727    控制组权限修改
#161128-00061#4   2016/12/02 by 02481    标准程式定义采用宣告模式,弃用.*写法
#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_master        RECORD
       g_xrca004 LIKE type_t.chr10, 
   g_xrca100 LIKE type_t.chr10, 
   g_type1 LIKE type_t.chr500, 
   amt LIKE type_t.chr500
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       sel LIKE type_t.chr1, 
   type LIKE type_t.chr500, 
   type_desc LIKE type_t.chr500, 
   xrca004 LIKE type_t.chr500, 
   xrca004_desc LIKE type_t.chr500, 
   xrca100 LIKE xrca_t.xrca100, 
   xrcc108 LIKE xrcc_t.xrcc108, 
   amount21 LIKE type_t.num20_6, 
   amount26 LIKE type_t.num20_6, 
   amount12 LIKE type_t.num20_6, 
   amount19 LIKE type_t.num20_6, 
   amount22 LIKE type_t.num20_6, 
   amount29 LIKE type_t.num20_6, 
   amount01 LIKE type_t.num20_6, 
   amount03 LIKE type_t.num20_6, 
   lbl_amt LIKE type_t.num20_6, 
   xrcc109 LIKE xrcc_t.xrcc109, 
   xrcc118 LIKE xrcc_t.xrcc118, 
   xrcc119 LIKE xrcc_t.xrcc119
       END RECORD
PRIVATE TYPE type_g_detail2 RECORD
       xrcasite LIKE xrca_t.xrcasite, 
   xrca001 LIKE xrca_t.xrca001, 
   xrca007 LIKE type_t.chr500, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrca018 LIKE xrca_t.xrca018, 
   xrca103 LIKE xrca_t.xrca103, 
   xrca108 LIKE xrca_t.xrca108, 
   xrca118 LIKE xrca_t.xrca118
       END RECORD
 
PRIVATE TYPE type_g_detail3 RECORD
       isatseq LIKE isat_t.isatseq, 
   isaf002 LIKE isaf_t.isaf002, 
   isat001 LIKE isat_t.isat001, 
   isat003 LIKE isat_t.isat003, 
   isat004 LIKE isat_t.isat004, 
   isat007 LIKE isat_t.isat007, 
   isat023 LIKE isat_t.isat023, 
   isat103 LIKE isat_t.isat103, 
   isat104 LIKE isat_t.isat104, 
   isat105 LIKE isat_t.isat105, 
   isat101 LIKE isat_t.isat101, 
   isat113 LIKE isat_t.isat113, 
   isat114 LIKE isat_t.isat114, 
   isat115 LIKE isat_t.isat115, 
   isatdocno LIKE isat_t.isatdocno, 
   isat014 LIKE isat_t.isat014
       END RECORD
 
PRIVATE TYPE type_g_detail4 RECORD
       xrce001 LIKE xrce_t.xrce001, 
   xrce001_desc LIKE type_t.chr500, 
   xrcedocno LIKE xrce_t.xrcedocno, 
   xrce002 LIKE xrce_t.xrce002, 
   xrce024 LIKE xrce_t.xrce024, 
   xrce100 LIKE xrce_t.xrce100, 
   xrce109 LIKE xrce_t.xrce109, 
   xrce119 LIKE xrce_t.xrce119, 
   xrce003 LIKE xrce_t.xrce003, 
   xrce010 LIKE xrce_t.xrce010, 
   xrce014 LIKE xrce_t.xrce014
       END RECORD
 
#160817-00054#1 Add  ---(S)---
PRIVATE TYPE type_g_detail5 RECORD
       nmbadocno LIKE nmba_t.nmbadocno,
       nmbadocdt LIKE nmba_t.nmbadocdt,
       nmbb004   LIKE nmbb_t.nmbb004,
       nmbb005   LIKE nmbb_t.nmbb005,
       nmbb006   LIKE nmbb_t.nmbb006,
       nmbb007   LIKE nmbb_t.nmbb007,
       nmbb008   LIKE nmbb_t.nmbb008,
       nmbb009   LIKE nmbb_t.nmbb009,
       amount1   LIKE nmbb_t.nmbb013,
       amount2   LIKE nmbb_t.nmbb013
       END RECORD
 
DEFINE g_detail5     DYNAMIC ARRAY OF type_g_detail5
DEFINE g_detail5_t   type_g_detail5
#160817-00054#1 Add  ---(E)---
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE  type_g_xrca_m RECORD
      xrcald             LIKE xrca_t.xrcald,
      xrcald_desc        LIKE glaal_t.glaal002,
      xrcacomp           LIKE type_t.chr200,
      xrcasite           LIKE xrca_t.xrcasite,
      xrcasite_desc      LIKE ooefl_t.ooefl003,
      g_type             LIKE type_t.chr1,
      b_rule             LIKE type_t.chr1,
      stus               LIKE type_t.chr1    #151130-00015#1
                            END RECORD
DEFINE g_xrca_m             type_g_xrca_m
#161128-00061#4-----modify--begin----------
#DEFINE g_glaa              RECORD LIKE glaa_t.* 
DEFINE g_glaa  RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企業編號
       glaaownid LIKE glaa_t.glaaownid, #資料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #資料所屬部門
       glaacrtid LIKE glaa_t.glaacrtid, #資料建立者
       glaacrtdp LIKE glaa_t.glaacrtdp, #資料建立部門
       glaacrtdt LIKE glaa_t.glaacrtdt, #資料創建日
       glaamodid LIKE glaa_t.glaamodid, #資料修改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近修改日
       glaastus LIKE glaa_t.glaastus, #狀態碼
       glaald LIKE glaa_t.glaald, #帳套編號
       glaacomp LIKE glaa_t.glaacomp, #歸屬法人
       glaa001 LIKE glaa_t.glaa001, #使用幣別
       glaa002 LIKE glaa_t.glaa002, #匯率參照表號
       glaa003 LIKE glaa_t.glaa003, #會計週期參照表號
       glaa004 LIKE glaa_t.glaa004, #會計科目參照表號
       glaa005 LIKE glaa_t.glaa005, #現金變動參照表號
       glaa006 LIKE glaa_t.glaa006, #月結方式
       glaa007 LIKE glaa_t.glaa007, #年結方式
       glaa008 LIKE glaa_t.glaa008, #平行記帳否
       glaa009 LIKE glaa_t.glaa009, #傳票登入方式
       glaa010 LIKE glaa_t.glaa010, #現行年度
       glaa011 LIKE glaa_t.glaa011, #現行期別
       glaa012 LIKE glaa_t.glaa012, #最後過帳日期
       glaa013 LIKE glaa_t.glaa013, #關帳日期
       glaa014 LIKE glaa_t.glaa014, #主帳套
       glaa015 LIKE glaa_t.glaa015, #啟用本位幣二
       glaa016 LIKE glaa_t.glaa016, #本位幣二
       glaa017 LIKE glaa_t.glaa017, #本位幣二換算基準
       glaa018 LIKE glaa_t.glaa018, #本位幣二匯率採用
       glaa019 LIKE glaa_t.glaa019, #啟用本位幣三
       glaa020 LIKE glaa_t.glaa020, #本位幣三
       glaa021 LIKE glaa_t.glaa021, #本位幣三換算基準
       glaa022 LIKE glaa_t.glaa022, #本位幣三匯率採用
       glaa023 LIKE glaa_t.glaa023, #次帳套帳務產生時機
       glaa024 LIKE glaa_t.glaa024, #單據別參照表號
       glaa025 LIKE glaa_t.glaa025, #本位幣一匯率採用
       glaa026 LIKE glaa_t.glaa026, #幣別參照表號
       glaa100 LIKE glaa_t.glaa100, #傳票輸入時自動按缺號產生
       glaa101 LIKE glaa_t.glaa101, #傳票總號輸入時機
       glaa102 LIKE glaa_t.glaa102, #傳票成立時,借貸不平衡的處理方式
       glaa103 LIKE glaa_t.glaa103, #未列印的傳票可否進行過帳
       glaa111 LIKE glaa_t.glaa111, #應計調整單別
       glaa112 LIKE glaa_t.glaa112, #期末結轉單別
       glaa113 LIKE glaa_t.glaa113, #年底結轉單別
       glaa120 LIKE glaa_t.glaa120, #成本計算類型
       glaa121 LIKE glaa_t.glaa121, #子模組啟用分錄底稿
       glaa122 LIKE glaa_t.glaa122, #總帳可維護資金異動明細
       glaa027 LIKE glaa_t.glaa027, #單據據點編號
       glaa130 LIKE glaa_t.glaa130, #合併帳套否
       glaa131 LIKE glaa_t.glaa131, #分層合併
       glaa132 LIKE glaa_t.glaa132, #平均匯率計算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司匯入餘額類型
       glaa134 LIKE glaa_t.glaa134, #合併科目轉換依據異動碼設定值
       glaa135 LIKE glaa_t.glaa135, #現流表間接法群組參照表號
       glaa136 LIKE glaa_t.glaa136, #應收帳款核銷限定己立帳傳票
       glaa137 LIKE glaa_t.glaa137, #應付帳款核銷限定已立帳傳票
       glaa138 LIKE glaa_t.glaa138, #合併報表編制期別
       glaa139 LIKE glaa_t.glaa139, #遞延收入(負債)管理產生否
       glaa140 LIKE glaa_t.glaa140, #無原出貨單的遞延負債減項者,是否仍立遞延收入管理?
       glaa123 LIKE glaa_t.glaa123, #應收帳款核銷可維護資金異動明細
       glaa124 LIKE glaa_t.glaa124, #應付帳款核銷可維護資金異動明細
       glaa028 LIKE glaa_t.glaa028  #匯率來源
       END RECORD
#161128-00061#4-----modify--end----------
DEFINE g_xrcadocno_str   STRING   #150331-00006#6   Add
DEFINE g_sql_ctrl        STRING                #151231-00010#7
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master            type_g_master
DEFINE g_master_t          type_g_master
 
   
 
DEFINE g_detail            DYNAMIC ARRAY OF type_g_detail
DEFINE g_detail_t          type_g_detail
DEFINE g_detail2     DYNAMIC ARRAY OF type_g_detail2
DEFINE g_detail2_t   type_g_detail2
 
DEFINE g_detail3     DYNAMIC ARRAY OF type_g_detail3
DEFINE g_detail3_t   type_g_detail3
 
DEFINE g_detail4     DYNAMIC ARRAY OF type_g_detail4
DEFINE g_detail4_t   type_g_detail4
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_cnt_sql             STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num10             #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_msg                 STRING
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_row_count           LIKE type_t.num10
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
DEFINE g_master_row_move     LIKE type_t.chr1              #是否為單頭筆數更動
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrq330.main" >}
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
   CALL cl_ap_init("axr","")
 
   #add-point:作業初始化 name="main.init"
   #151231-00010#7(S)
   LET g_sql_ctrl = NULL
  #CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl   #161111-00049#1 Mark
   #151231-00010#7(E)
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq330_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrq330_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq330_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrq330 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrq330_init()   
 
      #進入選單 Menu (="N")
      CALL axrq330_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrq330
      
   END IF 
   
   CLOSE axrq330_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE axrq330_tmp01;  #160505-00007#22 add         #160727-00019#6  2016/07/28  By 08734    axrq330_xrca_tmp ——> axrq330_tmp01
   DROP TABLE axrq330_tmp02; #160505-00007#22 add       #160727-00019#6  2016/07/28  By 08734    axrq330_print_tmp ——> axrq330_tmp02
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrq330.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axrq330_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_master_row_move = "Y"
   
      CALL cl_set_combo_scc('b_xrca001','8302') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('xrca_t.xrca001','8302')
   CALL cl_set_combo_scc_part('xrca_t.xrcastus','13','N,X,Y,A,D,R,W')
   CALL cl_set_combo_scc('b_xrce001','8329') 
   CALL cl_set_combo_scc('b_xrce002','8306') 
   CALL cl_set_combo_scc('b_isat014','9716')
   CALL cl_set_combo_scc('stus','9962')      #151130-00015#1 add
   CALL axrq330_create_tmp()  #160505-00007#22 add
   CALL s_fin_create_account_center_tmp()  #160505-00007#22 add
   CALL cl_set_act_visible("insert",FALSE) 
   #end add-point
 
   CALL axrq330_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axrq330.default_search" >}
PRIVATE FUNCTION axrq330_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   LET g_wc = " 1=1"
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq330.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrq330_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"

   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old    STRING
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_success      LIKE type_t.chr1
   DEFINE l_glaacomp     LIKE glaa_t.glaacomp
   #end add-point
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"

   #end add-point
 
   CLEAR FORM  
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET g_current_row_tot = 0
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_master_row_move = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"

   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL axrq330_cs()
   END IF
 
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         INITIALIZE g_master.* TO NULL
         CALL g_detail.clear()
         CALL g_detail2.clear()
 
         CALL g_detail3.clear()
 
         CALL g_detail4.clear()
         CALL g_detail5.clear()     #160817-00054#1 Add
 
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_master_row_move = "Y"
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL axrq330_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrcald,g_xrca_m.xrcald_desc,g_xrca_m.xrcacomp,g_xrca_m.g_type,g_xrca_m.b_rule
                      ,g_xrca_m.stus  #151130-00015#1 add
            BEFORE INPUT
               CALL axrq330_def()

            AFTER FIELD xrcasite
               IF NOT cl_null(g_xrca_m.xrcasite) THEN
                  CALL s_fin_account_center_with_ld_chk(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xrca_m.xrcasite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_xrca_m.xrcasite = ''
                     CALL s_axrt300_xrca_ref('xrcasite',g_xrca_m.xrcasite,'','') RETURNING l_success,g_xrca_m.xrcasite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_axrt300_xrca_ref('xrcasite',g_xrca_m.xrcasite,'','') RETURNING l_success,g_xrca_m.xrcasite_desc
               DISPLAY BY NAME g_xrca_m.xrcasite_desc

            AFTER FIELD xrcald
               IF NOT cl_null(g_xrca_m.xrcald) THEN
                  CALL s_fin_account_center_with_ld_chk(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xrca_m.xrcald
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_xrca_m.xrcald = ''
                     CALL s_axrt300_xrca_ref('xrcald',g_xrca_m.xrcald,'','') RETURNING l_success,g_xrca_m.xrcald_desc
                     #161128-00061#4-----modify--begin----------
                     #SELECT * INTO g_glaa.* 
                      SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                             glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                             glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                             glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                             glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                             glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
                     #161128-00061#4----modify--end----------
                     FROM FROM glaa_t
                      WHERE glaaent = g_enterprise
                        AND glaald  = g_xrca_m.xrcald
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_axrt300_xrca_ref('xrcald',g_xrca_m.xrcald,'','') RETURNING l_success,g_xrca_m.xrcald_desc
               DISPLAY BY NAME g_xrca_m.xrcald_desc
               #161128-00061#4-----modify--begin----------
               #SELECT * INTO g_glaa.* 
                SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                       glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                       glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                       glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                       glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                       glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
               #161128-00061#4----modify--end----------
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
                  SELECT glaacomp INTO g_xrca_m.xrcacomp FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_xrca_m.xrcald
                  #161111-00049#1 Add  ---(S)---
                   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_glaa.glaacomp) RETURNING g_sub_success,g_sql_ctrl
                  #161111-00049#1 Add  ---(E)---
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_xrca_m.xrcacomp
                  CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_xrca_m.xrcacomp = g_xrca_m.xrcacomp,'(', g_rtn_fields[1] , ')'
                  DISPLAY BY NAME g_xrca_m.xrcacomp

            ON ACTION controlp INFIELD xrcasite
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00009#2 
              
               #給予arg
              
               #CALL q_ooef001()                         #呼叫開窗    #161021-00050#4 mark
               LET g_qryparam.where = " ooefstus = 'Y' "             #161021-00050#4 add
               CALL q_ooef001_46()                                   #161021-00050#4 add
               LET g_xrca_m.xrcasite = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL s_axrt300_xrca_ref('xrcasite',g_xrca_m.xrcasite,'','') RETURNING l_success,g_xrca_m.xrcasite_desc
               DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc

            ON ACTION controlp INFIELD xrcald
               CALL s_fin_create_account_center_tmp()   
               #取得帳務組織下所屬成員
               CALL s_fin_account_center_sons_query('3',g_xrca_m.xrcasite,g_today,'1')
               #取得帳務組織下所屬成員之帳別   
               CALL s_fin_account_center_comp_str() RETURNING ls_wc
               #將取回的字串轉換為SQL條件
               CALL axrq330_get_ooef001_wc(ls_wc) RETURNING ls_wc  
             
               #開窗i段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
             
               LET g_qryparam.default1 = g_xrca_m.xrcald             #給予default值
               LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""
             
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               CALL  q_authorised_ld()                                  #呼叫開窗
               LET g_xrca_m.xrcald = g_qryparam.return1       #將開窗取得的值回傳到變數
               CALL s_axrt300_xrca_ref('xrcasite',g_xrca_m.xrcasite,'','') RETURNING l_success,g_xrca_m.xrcasite_desc
               #161128-00061#4-----modify--begin----------
               #SELECT * INTO g_glaa.* 
                SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                       glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                       glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                       glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                       glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                       glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
               #161128-00061#4----modify--end----------
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
               DISPLAY g_xrca_m.xrcald TO xrcald              #顯示到畫面上
               #161128-00061#4-----modify--begin----------
               #SELECT * INTO g_glaa.* 
                SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                       glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                       glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                       glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                       glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                       glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
               #161128-00061#4----modify--end----------
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
               SELECT glaacomp INTO g_xrca_m.xrcacomp FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaald  = g_xrca_m.xrcald
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_xrca_m.xrcacomp
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_xrca_m.xrcacomp = g_xrca_m.xrcacomp,'(', g_rtn_fields[1] , ')'
               DISPLAY BY NAME g_xrca_m.xrcacomp
               NEXT FIELD xrcald                              #返回原欄位

         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON xrca004,xrcadocdt,xrca001,xrca007 #,xrcastus #151130-00015#1 mark xrcastus

            ON ACTION controlp INFIELD xrca004
               #開窗c段
			       INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			       LET g_qryparam.reqry = FALSE
			       #151231-00010#7--(S)
               LET g_qryparam.where = " pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_xrca_m.xrcald,"')) AND (pmaa002='2' OR pmaa002='3')" #160731-00372#1   2016/08/16  By 07900 add AND (pmaa002='2' OR pmaa002='3') 
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where ," AND pmaa001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
               END IF
               #151231-00010#7--(E)
               # CALL q_pmaa001()   #160913-00017#9  mark                  #呼叫開窗
               #160913-00017#9--ADD(S)--
               LET g_qryparam.arg1="('2','3')"
               CALL q_pmaa001_1()
               #160913-00017#9--ADD(E)--        
               DISPLAY g_qryparam.return1 TO xrca004   #顯示到畫面上
               NEXT FIELD xrca004                      #返回原欄位

            ON ACTION controlp INFIELD xrca007
               #開窗c段
			       INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			       LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = "3111"   #161111-00049#1 Add
               CALL q_oocq002()                        #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrca007   #顯示到畫面上
               NEXT FIELD xrca007                      #返回原欄位

         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axrq330_detail_action_trans()
               LET g_master_idx = l_ac
               CALL axrq330_b_fill2()
 
               #add-point:input段before row name="input.body.before_row"

               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail2 TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               CALL axrq330_b_fill3()
               CALL axrq330_b_fill4()
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail3 TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 3
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body3.before_row"

               #end add-point
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail4 TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 4
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body4.before_row"

               #end add-point
 
            #自訂ACTION(detail_show,page_4)
            
 
            #add-point:page4自定義行為 name="ui_dialog.body4.action"

            #end add-point
 
         END DISPLAY
 
         #160817-00054#1 Add  ---(S)---
         DISPLAY ARRAY g_detail5 TO s_detail5.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 5
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail5")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
         END DISPLAY
         #160817-00054#1 Add  ---(E)---
 
         #add-point:ui_dialog段define name="ui_dialog.more_displayarray"

         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL axrq330_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL axrq330_b_fill()
            IF cl_null(g_xrca_m.g_type) THEN LET g_xrca_m.g_type = '0' END IF
            IF cl_null(g_xrca_m.b_rule) THEN LET g_xrca_m.b_rule = '0' END IF
            DISPLAY BY NAME g_xrca_m.g_type
            #151130-00015#1--add--str--
            IF cl_null(g_xrca_m.stus) THEN LET g_xrca_m.stus = '2' END IF
            DISPLAY BY NAME g_xrca_m.stus
            #151130-00015#1--add--end
            NEXT FIELD xrcasite
            #end add-point
            NEXT FIELD xrcadocno
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"

            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
   
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"

            #end add-point
 
            CALL axrq330_cs()
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"

            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_detail)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_detail2)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_detail3)
               LET g_export_id[3]   = "s_detail3"
 
               LET g_export_node[4] = base.typeInfo.create(g_detail4)
               LET g_export_id[4]   = "s_detail4"
               #160817-00054#1 Add  ---(S)---
               LET g_export_node[5] = base.typeInfo.create(g_detail5)
               LET g_export_id[5]   = "s_detail5"
               #160817-00054#1 Add  ---(E)---
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"

               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION datarefresh   # 重新整理
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axrq330_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         ON ACTION datainfo   #串查至主維護程式
            #add-point:ON ACTION datainfo name="ui_dialog.datainfo"

            #end add-point
            CALL axrq330_maintain_prog()
 
        #160826-00009#1 Mark ---(S)---
        #ON ACTION first   # 第一筆
        #   #為避免按上下筆影響效能，所以有作一些處理
        #   LET lc_action_choice_old = g_action_choice
        #   LET g_action_choice = "fetch"
        #   CALL axrq330_fetch('F')
        #   LET g_action_choice = lc_action_choice_old
        #
        #ON ACTION previous   # 上一筆
        #   #為避免按上下筆影響效能，所以有作一些處理
        #   LET lc_action_choice_old = g_action_choice
        #   LET g_action_choice = "fetch"
        #   CALL axrq330_fetch('P')
        #   LET g_action_choice = lc_action_choice_old
        #
        #ON ACTION jump   # 跳至第幾筆
        #   #為避免按上下筆影響效能，所以有作一些處理
        #   LET lc_action_choice_old = g_action_choice
        #   LET g_action_choice = "fetch"
        #   CALL axrq330_fetch('/')
        #   LET g_action_choice = lc_action_choice_old
        #
        #ON ACTION next   # 下一筆
        #   #為避免按上下筆影響效能，所以有作一些處理
        #   LET lc_action_choice_old = g_action_choice
        #   LET g_action_choice = "fetch"
        #   CALL axrq330_fetch('N')
        #   LET g_action_choice = lc_action_choice_old
        #
        #ON ACTION last   # 最後一筆
        #   #為避免按上下筆影響效能，所以有作一些處理
        #   LET lc_action_choice_old = g_action_choice
        #   LET g_action_choice = "fetch"
        #   CALL axrq330_fetch('L')
        #   LET g_action_choice = lc_action_choice_old
        #160826-00009#1 Mark ---(E)---
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL axrq330_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL axrq330_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL axrq330_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL axrq330_b_fill()
 
         
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail.getLength()
               LET g_detail[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail.getLength()
               LET g_detail[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"

            #end add-point
 
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"

               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
#               CALL axrq330_x01('1=1','axrq330_print_tmp',g_xrca_m.g_type,g_xrca_m.b_rule) #160505-00007#22 mark
               CALL axrq330_output() #160505-00007#22 add
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axrt3
            LET g_action_choice="open_axrt3"
            IF cl_auth_chk_act("open_axrt3") THEN
               
               #add-point:ON ACTION open_axrt3 name="menu.open_axrt3"
               CALL axrq330_open()
               CONTINUE DIALOG
               #END add-point
               
               
            END IF
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"

         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"

            #end add-point 
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         INITIALIZE g_xrca_m.* TO NULL
         CALL axrq330_def()
         IF cl_null(g_xrca_m.g_type) THEN LET g_xrca_m.g_type = '0' END IF
         IF cl_null(g_xrca_m.b_rule) THEN LET g_xrca_m.b_rule = '0' END IF
         IF cl_null(g_xrca_m.stus) THEN LET g_xrca_m.stus = '0' END IF     #151130-00015#1 add
         #end add-point 
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axrq330.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION axrq330_cs()
   #add-point:cs段define-客製 name="cs.define_customerization"
   
   #end add-point
   #add-point:cs段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_gzzd005         LIKE gzzd_t.gzzd005
   #end add-point
 
   #add-point:FUNCTION前置處理 name="cs.before_function"
   #160505-00007#22--add--str--
   IF NOT cl_null(g_xrca_m.g_type) THEN
      IF g_xrca_m.g_type = '0' THEN
         CALL cl_set_comp_visible('b_type_desc',FALSE)
      ELSE
         CALL cl_set_comp_visible('b_type_desc',TRUE)
      END IF
      CASE
         WHEN g_xrca_m.g_type = '1'
            SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'group1' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
         WHEN g_xrca_m.g_type = '2'
            SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'group2' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
         WHEN g_xrca_m.g_type = '3'
            SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'group3' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
         WHEN g_xrca_m.g_type = '4'
            SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'group4' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
      END CASE
      CALL cl_set_comp_att_text('b_type',l_gzzd005)
      CALL cl_set_comp_att_text('b_type_desc',l_gzzd005)
      LET g_xg_fieldname[5] = l_gzzd005
   END IF

   DELETE FROM axrq330_tmp01   #160807-00012#1 Add
   DELETE FROM axrq330_tmp02   #160807-00012#1 Add

   CALL axrq330_b_fill()
   RETURN
   #160505-00007#22--add--end
   #end add-point
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF g_wc2 = " 1=1" THEN
      #add-point:cs段單頭sql組成(未下單身條件) name="cs.sql_define_1"
 
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件) name="cs.sql_define_2"
      
      #end add-point
   END IF
 
   PREPARE axrq330_pre FROM g_sql
   DECLARE axrq330_curs SCROLL CURSOR WITH HOLD FOR axrq330_pre
   OPEN axrq330_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
#160505-00007#22--mark--str--
#移至上面,不执行定义axrq330_curs
#   IF NOT cl_null(g_xrca_m.g_type) THEN
#      IF g_xrca_m.g_type = '0' THEN
#         CALL cl_set_comp_visible('b_type_desc',FALSE)
#      ELSE
#         CALL cl_set_comp_visible('b_type_desc',TRUE)
#      END IF
#      CASE
#         WHEN g_xrca_m.g_type = '1'
#            SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'group1' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
#         WHEN g_xrca_m.g_type = '2'
#            SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'group2' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
#         WHEN g_xrca_m.g_type = '3'
#            SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'group3' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
#         WHEN g_xrca_m.g_type = '4'
#            SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'group4' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
#      END CASE
#      CALL cl_set_comp_att_text('b_type',l_gzzd005)
#      CALL cl_set_comp_att_text('b_type_desc',l_gzzd005)
#      LET g_xg_fieldname[5] = l_gzzd005
#   END IF
#
#   CALL axrq330_b_fill()
#   RETURN
#160505-00007#22--mark--end
   #end add-point
   PREPARE axrq330_precount FROM g_cnt_sql
   EXECUTE axrq330_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL axrq330_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="axrq330.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION axrq330_fetch(p_flag)
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:3)
   #add-point:fetch段CURSOR移動 name="fetch.cursor_action"
   RETURN
   #end add-point
 
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO g_xrca004,g_xrca100,g_type1,amt
      CALL g_detail.clear()
      CALL g_detail2.clear()
 
      CALL g_detail3.clear()
 
      CALL g_detail4.clear()
 
 
      #add-point:陣列清空 name="fetch.array_clear"
      
      #end add-point
      DISPLAY '' TO FORMONLY.h_index
      DISPLAY '' TO FORMONLY.h_count
      DISPLAY '' TO FORMONLY.idx
      DISPLAY '' TO FORMONLY.cnt
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = '-100' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   ELSE
      CASE p_flag
         WHEN 'F' LET g_current_idx = 1
         WHEN 'P' LET g_current_idx = g_current_idx - 1
         WHEN 'N' LET g_current_idx = g_current_idx + 1
         WHEN 'L' LET g_current_idx = g_row_count
         WHEN '/' LET g_current_idx = g_jump
      END CASE
      DISPLAY g_current_idx TO FORMONLY.h_index
      DISPLAY g_row_count TO FORMONLY.h_count
      CALL cl_navigator_setting( g_current_idx, g_row_count )
   END IF
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL axrq330_show()
 
END FUNCTION
 
{</section>}
 
{<section id="axrq330.show" >}
PRIVATE FUNCTION axrq330_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO g_xrca004,g_xrca100,g_type1,amt
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL axrq330_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="axrq330.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrq330_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE ls_wc1          STRING
   DEFINE ls_wc2          STRING
   DEFINE l_xrca108       LIKE xrca_t.xrca108
   DEFINE l_xrcasite_desc LIKE type_t.chr500
   DEFINE l_xrcald_desc   LIKE type_t.chr500
   DEFINE l_g_type        LIKE type_t.chr500
   DEFINE l_b_rule        LIKE type_t.chr500
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005
   DEFINE l_stus_wc       STRING   #151130-00015#1 add
   DEFINE l_desc_sql          STRING   #160505-00007#22 add
   DEFINE l_xrca004_desc_sql  STRING   #160505-00007#22 add
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
    
   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:3)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql name="b_fill.sql"
#160505-00007#22--mark--str--
#当执行打印操作时，再将资料插入打印临时表中
#   #2015/5/28--XG
#   LET l_xrcasite_desc = ''
#   LET l_xrcald_desc = ''
#   LET l_g_type = ''
#   LET l_b_rule = ''
#   LET l_xrcasite_desc = g_xrca_m.xrcasite," ",g_xrca_m.xrcasite_desc
#   LET l_xrcald_desc = g_xrca_m.xrcald," ",g_xrca_m.xrcald_desc,"   ",g_xrca_m.xrcacomp
#   CASE
#      WHEN g_xrca_m.g_type = '0'
#         SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'cbo_type_0' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
#      WHEN g_xrca_m.g_type = '1'
#         SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'cbo_type_1' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
#      WHEN g_xrca_m.g_type = '2'
#         SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'cbo_type_2' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
#      WHEN g_xrca_m.g_type = '3'
#         SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'cbo_type_3' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
#      WHEN g_xrca_m.g_type = '4'
#         SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'cbo_type_4' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
#   END CASE
#   LET l_g_type = l_gzzd005
#   CASE
#      WHEN g_xrca_m.b_rule = '0'
#         SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'cbo_rule_0' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
#      WHEN g_xrca_m.b_rule = '1'
#         SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'cbo_rule_1' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
#      WHEN g_xrca_m.b_rule = '2'
#         SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'cbo_rule_2' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
#   END CASE
#   LET l_b_rule = l_gzzd005
#   #2015/5/28--XG
#160505-00007#22--mark--end
   #160505-00007#22--add--str--
   IF cl_null(g_xrca_m.g_type) THEN
      RETURN
   END IF
   #160505-00007#22--add--end
   
   CALL axrq330_get_data()
#   DELETE FROM axrq330_print_tmp #160505-00007#22 mark
   
   CASE
      WHEN g_xrca_m.g_type = '0'   #帳款客戶
         LET ls_wc = "xrca004"
      WHEN g_xrca_m.g_type = '1'   #業務部門
         LET ls_wc = "xrca015"
      WHEN g_xrca_m.g_type = '2'   #業務人員
         LET ls_wc = "xrca014"
      WHEN g_xrca_m.g_type = '3'   #帳款類型
         LET ls_wc = "xrca007"
      WHEN g_xrca_m.g_type = '4'   #立帳期別
         LET ls_wc = "TO_CHAR(xrcadocdt,'YYYYMM')"
   END CASE
   
   #160505-00007#22--add--str--
   CASE
      WHEN g_xrca_m.g_type = '0'   #帳款客戶
         LET l_desc_sql="(SELECT pmaal001||'('||pmaal003||')' FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=cnt AND pmaal002='"||g_dlang||"') type_desc "
      WHEN g_xrca_m.g_type = '1'   #業務部門
         LET l_desc_sql="(SELECT ooefl001||'('||ooefl003||')' FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=cnt AND ooefl002='"||g_dlang||"') type_desc "
      WHEN g_xrca_m.g_type = '2'   #業務人員
         LET l_desc_sql="(SELECT ooag001||'('||ooag011||')' FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=cnt) type_desc "
      WHEN g_xrca_m.g_type = '3'   #帳款類型
         LET l_desc_sql="(SELECT oocql002||'('||oocql004||')' FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3111' AND oocql002=cnt AND oocql003='"||g_dlang||"') type_desc "
      WHEN g_xrca_m.g_type = '4'   #立帳期別
         LET l_desc_sql="cnt type_desc "
   END CASE
   LET l_xrca004_desc_sql="(SELECT pmaal001||'('||pmaal003||')' FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=xrca004 AND pmaal002='"||g_dlang||"') xrca004_desc "
   #160505-00007#22--add--end
   
#   LET g_sql = "SELECT 'N',cnt,'',xrca004,'',xrca100,0,SUM(sum_21),0,SUM(sum_12),SUM(sum_19),SUM(sum_22),  ",  #160505-00007#22 mark   
   LET g_sql = "SELECT 'N',cnt,",l_desc_sql,",xrca004,",l_xrca004_desc_sql,",",                                      #160505-00007#22 add
               "       xrca100,0,SUM(sum_21),0,SUM(sum_12),SUM(sum_19),SUM(sum_22),                          ", #160505-00007#22 add
               "       SUM(sum_29),SUM(sum_01),SUM(sum_02),SUM(xrcc109),SUM(xrcc108 - xrcc109),              ",
               "       SUM(xrcc118),SUM(xrcc118 - xrcc119) FROM (                                            ",
               "     SELECT ",ls_wc," cnt,xrca004,xrca100,0 sum_21,0 sum_26,SUM (xrcc108) sum_12, 0 sum_19,  ",
               "           0 sum_22,0 sum_29,0 sum_01,0 sum_02,SUM (xrcc109) xrcc109,SUM (xrcc108) *  1 xrcc108,  ",
               "            SUM (xrcc118) *  1 xrcc118,SUM (xrcc119) xrcc119                                 ",
               "       FROM axrq330_tmp01, xrcc_t                                                         ",    #160727-00019#6  2016/07/28  By 08734    axrq330_xrca_tmp ——> axrq330_tmp01
               "      WHERE     xrcaent = xrccent      AND xrcadocno = xrccdocno                             ",
               "            AND xrcald = xrccld        AND xrca001 IN ('12', '17')                           ",
               "      GROUP BY ",ls_wc,", xrca004, xrca100                                                   ",
               "      UNION                                                                                  ",
               "     SELECT ",ls_wc," cnt,xrca004,xrca100,0 sum_21,0 sum_26,0 sum_12, 0 sum_19,  ",
               "           0 sum_22,0 sum_29,0 sum_01,0 sum_02,SUM (xrcc109) xrcc109,SUM (xrcc108) *  1 xrcc108,  ",
               "            SUM (xrcc118) *  1 xrcc118,SUM (xrcc119) xrcc119                                 ",
               "       FROM axrq330_tmp01, xrcc_t                                                         ",   #160727-00019#6  2016/07/28  By 08734    axrq330_xrca_tmp ——> axrq330_tmp01
               "      WHERE     xrcaent = xrccent      AND xrcadocno = xrccdocno                             ",
               "            AND xrcald = xrccld        AND xrca001 = '11'                           ",
               "      GROUP BY ",ls_wc,", xrca004, xrca100                                                   ",
               "      UNION                                                                                  ",
               "     SELECT ",ls_wc," cnt,xrca004,xrca100,0 sum_21,0 sum_26,0 sum_12, 0 sum_19,  ",
               "           0 sum_22,0 sum_29,0 sum_01,0 sum_02,SUM (xrcc109) * -1 xrcc109,SUM (xrcc108) *  -1 xrcc108,  ",
               "            SUM (xrcc118) *  -1 xrcc118,SUM (xrcc119) * -1 xrcc119                                 ",
               "       FROM axrq330_tmp01, xrcc_t                                                         ",  #160727-00019#6  2016/07/28  By 08734    axrq330_xrca_tmp ——> axrq330_tmp01
               "      WHERE     xrcaent = xrccent      AND xrcadocno = xrccdocno                             ",
               "            AND xrcald = xrccld        AND xrca001 = '21'                           ",
               "      GROUP BY ",ls_wc,", xrca004, xrca100                                                   ",
               "      UNION                                                                                  ",
               "     SELECT ",ls_wc," cnt,xrca004,xrca100,0 sum_21,0 sum_26,0 sum_12, SUM (xrcc108) sum_19,  ",
               "           0 sum_22,0 sum_29,0 sum_01,0 sum_02,SUM (xrcc109) xrcc109,SUM (xrcc108) xrcc108,  ",
               "            SUM (xrcc118) *  1 xrcc118,SUM (xrcc119) xrcc119                                 ",
               "       FROM axrq330_tmp01, xrcc_t                                                         ",   #160727-00019#6  2016/07/28  By 08734    axrq330_xrca_tmp ——> axrq330_tmp01
               "      WHERE     xrcaent = xrccent      AND xrcadocno = xrccdocno                             ",
               "            AND xrcald = xrccld        AND xrca001 IN ('19')                                 ",
               "      GROUP BY ",ls_wc,", xrca004, xrca100                                                   ",
               "      UNION                                                                                  ",
               "     SELECT ",ls_wc," cnt,xrca004,xrca100,0 sum_21,0 sum_26,0 sum_12,0 sum_19,SUM (xrcc108)  ",
               "           sum_22,0 sum_29,0 sum_01,0 sum_02,SUM (xrcc109) * -1 xrcc109,SUM (xrcc108) *  -1 xrcc108,    ",
               "            SUM (xrcc118) * -1 xrcc118,SUM (xrcc119) * -1 xrcc119                                 ",
               "       FROM axrq330_tmp01, xrcc_t                                                         ",   #160727-00019#6  2016/07/28  By 08734    axrq330_xrca_tmp ——> axrq330_tmp01
               "      WHERE     xrcaent = xrccent      AND xrcadocno = xrccdocno                             ",
               "            AND xrcald = xrccld        AND xrca001 IN ('22')                                 ",
               "      GROUP BY ",ls_wc,", xrca004, xrca100                                                   ",
               "      UNION                                                                                  ",
               "     SELECT ",ls_wc," cnt,xrca004,xrca100,0 sum_21,0 sum_26,0 sum_12,0 sum_19,0 sum_22,      ",
               "          SUM (xrcc108) sum_29,0 sum_01,0 sum_02,SUM (xrcc109) * -1 xrcc109,SUM (xrcc108) *  -1 xrcc108,",
               "            SUM (xrcc118) * -1 xrcc118,SUM (xrcc119) * -1 xrcc119                                 ",
               "       FROM axrq330_tmp01, xrcc_t                                                         ",   #160727-00019#6  2016/07/28  By 08734    axrq330_xrca_tmp ——> axrq330_tmp01
               "      WHERE     xrcaent = xrccent      AND xrcadocno = xrccdocno                             ",
               "            AND xrcald = xrccld        AND xrca001 IN ('29')                                 ",
               "      GROUP BY ",ls_wc,", xrca004, xrca100                                                   ",
               "      UNION                                                                                  ",
               "     SELECT ",ls_wc," cnt,xrca004,xrca100,0 sum_21,0 sum_26,0 sum_12,0 sum_19,0 sum_22,      ",
               "          0 sum_29,SUM (xrcc108) sum_01,0 sum_02,SUM (xrcc109) xrcc109,SUM (xrcc108) *  1 xrcc108,",
               "            SUM (xrcc118) *  1 xrcc118,SUM (xrcc119) xrcc119                                 ",
               "       FROM axrq330_tmp01, xrcc_t                                                         ",  #160727-00019#6  2016/07/28  By 08734    axrq330_xrca_tmp ——> axrq330_tmp01
               "      WHERE     xrcaent = xrccent      AND xrcadocno = xrccdocno                             ",
               "            AND xrcald = xrccld        AND xrca001 IN ('01','03')                            ",
               "      GROUP BY ",ls_wc,", xrca004, xrca100                                                   ",
               "      UNION                                                                                  ",
               "     SELECT ",ls_wc," cnt,xrca004,xrca100,0 sum_21,0 sum_26,0 sum_12,0 sum_19,0 sum_22,      ",
               "          0 sum_29,0 sum_01,SUM (xrcc108) sum_02,SUM (xrcc109) * -1 xrcc109,SUM (xrcc108) *  -1 xrcc108,",
               "            SUM (xrcc118) * -1 xrcc118,SUM (xrcc119) * -1 xrcc119                                 ",
               "       FROM axrq330_tmp01, xrcc_t                                                         ",   #160727-00019#6  2016/07/28  By 08734    axrq330_xrca_tmp ——> axrq330_tmp01
               "      WHERE     xrcaent = xrccent      AND xrcadocno = xrccdocno                             ",
               "            AND xrcald = xrccld        AND xrca001 IN ('02','04')                            ",
               "      GROUP BY ",ls_wc,", xrca004, xrca100                                                   ",
               "      UNION                                                                                  ",
               "     SELECT ",ls_wc," cnt,xrca004,xrca100,0 sum_21,0 sum_26,0 sum_12,0 sum_19,0 sum_22,      ",
               "          0 sum_29,0 sum_01,0 sum_02,0 xrcc109,0 xrcc108,",
               "            0 xrcc118,0 xrcc119                                 ",
               "       FROM axrq330_tmp01, xrcc_t                                                         ",   #160727-00019#6  2016/07/28  By 08734    axrq330_xrca_tmp ——> axrq330_tmp01
               "      WHERE     xrcaent = xrccent      AND xrcadocno = xrccdocno                             ",
               "            AND xrcald = xrccld        AND xrca001 IN ('24')                            ",
               "      GROUP BY ",ls_wc,", xrca004, xrca100                                                   ",
               "      )                                                                                      ",
               " GROUP BY cnt,xrca004,xrca100                                                                ",
               " ORDER BY xrca004,xrca100,cnt                                                                "
   PREPARE axrq330_prep FROM g_sql
   DECLARE axrq330_fill1_curs CURSOR FOR axrq330_prep

   #151130-00015#1--add--str--
   CASE g_xrca_m.stus
      WHEN '1'
         LET l_stus_wc=" xrcastus = 'N' "
      WHEN '2'
         LET l_stus_wc=" xrcastus = 'Y' "   
      WHEN '3'
         LET l_stus_wc=" xrcastus IN ('N','Y') "
   END CASE
   #151130-00015#1--add--end
   
   LET g_sql = "SELECT SUM(tot) FROM (                                                      ",
               "  SELECT CASE                                                               ",
               "            WHEN SUM (CASE WHEN xrcc108 IS NULL THEN 0 ELSE xrcc108 END     ",
               "                    - CASE WHEN xrcc109 IS NULL THEN 0 ELSE xrcc109 END) > 0",
               "            THEN    SUM (CASE WHEN xrcc108 IS NULL THEN 0 ELSE xrcc108 END  ",
               "                       - CASE WHEN xrcc109 IS NULL THEN 0 ELSE xrcc109 END) ",
               "            ELSE    SUM (CASE WHEN amt IS NULL THEN 0 ELSE amt END) * -1    ",
               "         END tot                                                            ",
               "    FROM xrcc_t,xrca_t LEFT JOIN                                            ",
               "            (  SELECT xrcaent ent,xrcadocno docno,xrcald ld,                ",
               "                      SUM (xrcc108 - xrcc109) amt                           ",
               "                 FROM xrca_t, xrcc_t                                        ",
               "                WHERE     xrcaent = '",g_enterprise,"'                      ",
               "                      AND xrca001 = ?                                       ",
               "                      AND xrcaent = xrccent                                 ",
               "                      AND xrca004 = ?                                       ",
               "                      AND xrca100 = ?                                       ",
               "                      AND xrcadocno IN (SELECT xrcadocno FROM axrq330_tmp01)",   #160727-00019#6  2016/07/28  By 08734    axrq330_xrca_tmp ——> axrq330_tmp01
               "                      AND ",ls_wc," = ?                                     ",
               "                      AND xrcadocno = xrccdocno                             ",
               "                      AND xrccld = xrcald                                   ",
               "                      AND ",l_stus_wc,                                        #151130-00015#1 add
               "             GROUP BY xrcaent, xrcadocno, xrcald) b                         ",
               "         ON ent = xrcaent AND ld = xrcald AND docno = xrca019               ",
               "   WHERE     xrccent = xrcaent                                              ",
               "         AND xrccdocno = xrcadocno                                          ",
               "         AND xrccld = xrcald                                                ",
               "         AND xrcadocno IN (SELECT xrcadocno FROM axrq330_tmp01)          ",     #160727-00019#6  2016/07/28  By 08734    axrq330_xrca_tmp ——> axrq330_tmp01
               "         AND xrca001 = ?                                                    ",
               "         AND xrca004 = ?                                                    ",
               "         AND xrca100 = ?                                                    ",
               "         AND ",ls_wc," = ?                                                  ",
               "         AND xrcaent = '",g_enterprise,"'                                   ",
               "         AND ",l_stus_wc,                                                     #151130-00015#1 add
               "GROUP BY xrcadocno)                                                         "
   PREPARE axrq330_other_prep FROM g_sql

   LET g_sql = "SELECT SUM(xrcc108 - xrcc109)* -1 FROM xrca_t,xrcc_t WHERE xrccent = xrcaent",
               "   AND xrcadocno = xrccdocno                                                ",
               "   AND xrcald = xrccld                                                      ",
               "   AND xrcadocno IN (SELECT xrcadocno FROM axrq330_tmp01)                ",    #160727-00019#6  2016/07/28  By 08734    axrq330_xrca_tmp ——> axrq330_tmp01
               "   AND ",ls_wc," = ?                                                        ",
               "   AND xrca001 = '24'                                                       ",
               "   AND ",l_stus_wc,                                                            #151130-00015#1 add
               "   AND xrca004 = ?                                                          ",
               "   AND xrca100 = ?                                                          "
   PREPARE axrq330_26_prep FROM g_sql

   #end add-point
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   LET l_ac = 1

   FOREACH axrq330_fill1_curs INTO g_detail[l_ac].*
      LET g_detail[l_ac].amount21 = 0
      LET g_detail[l_ac].amount26 = 0

     #預收款
      #訂金預收
      LET l_xrca108 = 0
      EXECUTE axrq330_other_prep USING '21',g_detail[l_ac].xrca004,g_detail[l_ac].xrca100,g_detail[l_ac].type,
                                       '11',g_detail[l_ac].xrca004,g_detail[l_ac].xrca100,g_detail[l_ac].type
                                  INTO l_xrca108
      IF cl_null(l_xrca108) THEN LET l_xrca108 = 0 END IF
      LET g_detail[l_ac].amount21 = g_detail[l_ac].amount21 + l_xrca108
      #預收應收
      LET l_xrca108 = 0
      EXECUTE axrq330_other_prep USING '23',g_detail[l_ac].xrca004,g_detail[l_ac].xrca100,g_detail[l_ac].type,
                                       '15',g_detail[l_ac].xrca004,g_detail[l_ac].xrca100,g_detail[l_ac].type
                                  INTO l_xrca108
      IF cl_null(l_xrca108) THEN LET l_xrca108 = 0 END IF
      LET g_detail[l_ac].amount21 = g_detail[l_ac].amount21 + l_xrca108
      #押金應收
      LET l_xrca108 = 0
      EXECUTE axrq330_other_prep USING '25',g_detail[l_ac].xrca004,g_detail[l_ac].xrca100,g_detail[l_ac].type,
                                       '16',g_detail[l_ac].xrca004,g_detail[l_ac].xrca100,g_detail[l_ac].type
                                  INTO l_xrca108
      IF cl_null(l_xrca108) THEN LET l_xrca108 = 0 END IF
      LET g_detail[l_ac].amount21 = g_detail[l_ac].amount21 + l_xrca108
      #溢收待抵
      LET l_xrca108 = 0
     #EXECUTE axrq330_other_prep USING g_detail[l_ac].type,g_detail[l_ac].xrca004,g_detail[l_ac].xrca100 INTO l_xrca108   #151217-00017#1 Mark
      EXECUTE axrq330_26_prep    USING g_detail[l_ac].type,g_detail[l_ac].xrca004,g_detail[l_ac].xrca100 INTO l_xrca108   #151217-00017#1 Add
      IF cl_null(l_xrca108) THEN LET l_xrca108 = 0 END IF
      LET g_detail[l_ac].amount21 = g_detail[l_ac].amount21 + l_xrca108

     #代收款
      LET l_xrca108 = 0
      EXECUTE axrq330_other_prep USING '26',g_detail[l_ac].xrca004,g_detail[l_ac].xrca100,g_detail[l_ac].type,
                                       '13',g_detail[l_ac].xrca004,g_detail[l_ac].xrca100,g_detail[l_ac].type
                                  INTO l_xrca108
      IF cl_null(l_xrca108) THEN LET l_xrca108 = 0 END IF
      LET g_detail[l_ac].amount26 = g_detail[l_ac].amount26 + l_xrca108

      LET g_detail[l_ac].xrcc108 = g_detail[l_ac].amount21 * -1 + g_detail[l_ac].amount26 * -1 + g_detail[l_ac].amount12 *  1
                                 + g_detail[l_ac].amount19 *  1 + g_detail[l_ac].amount22 * -1 + g_detail[l_ac].amount29 * -1
                                 + g_detail[l_ac].amount01 *  1 + g_detail[l_ac].amount03 * -1
#160505-00007#22--mark--str--      
#      INITIALIZE g_ref_fields TO NULL
#      INITIALIZE g_rtn_fields TO NULL
#      LET g_ref_fields[1] = g_detail[l_ac].type
#      CASE
#         WHEN g_xrca_m.g_type = '0'   #帳款客戶
#            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#         WHEN g_xrca_m.g_type = '1'   #業務部門
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#         WHEN g_xrca_m.g_type = '2'   #業務人員
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#         WHEN g_xrca_m.g_type = '3'   #帳款類型
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3111' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#      END CASE
#      IF g_xrca_m.g_type != '4' THEN
#         LET g_rtn_fields[1] = '(', g_rtn_fields[1] , ')'
#      END IF
#      LET g_detail[l_ac].type_desc = g_detail[l_ac].type,g_rtn_fields[1]
    
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_detail[l_ac].xrca004
#      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_detail[l_ac].xrca004_desc = g_detail[l_ac].xrca004,'(', g_rtn_fields[1] , ')'
      
#      #2015/5/28--XG
#      INSERT INTO axrq330_print_tmp VALUES(l_xrcasite_desc,l_xrcald_desc,l_g_type,l_b_rule,
#            g_detail[l_ac].type_desc,g_detail[l_ac].xrca004_desc,g_detail[l_ac].xrca100,g_detail[l_ac].xrcc108,
#            g_detail[l_ac].amount21,g_detail[l_ac].amount26,g_detail[l_ac].amount12,g_detail[l_ac].amount19,
#            g_detail[l_ac].amount22,g_detail[l_ac].amount29,g_detail[l_ac].amount01,g_detail[l_ac].amount03,
#            g_detail[l_ac].lbl_amt,g_detail[l_ac].xrcc109,g_detail[l_ac].xrcc118,g_detail[l_ac].xrcc119)
#      #2015/5/28--XG
#160505-00007#22--mark--end
      LET l_ac = l_ac + 1
   END FOREACH
   #end add-point
 
   CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrq330_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrq330_detail_action_trans()
 
   CALL axrq330_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axrq330.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrq330_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE ls_wc           STRING
   DEFINE l_ooef019       LIKE ooef_t.ooef019
   DEFINE l_xrca007_sql   STRING    #160505-00007#22 add
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = 1
 
   #單身組成
   #應用 qs11 樣板自動產生(Version:3)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
   #add-point:sql組成 name="b_fill2.fill"

   IF g_detail_idx = 0 THEN RETURN END IF

   CALL g_detail2.clear()
   CALL g_detail4.clear()
   LET g_xrcadocno_str = NULL   #150331-00006#6 Add

   CASE
      WHEN g_xrca_m.g_type = '0'   #帳款客戶
         LET ls_wc = " xrca004 = '",g_detail[g_detail_idx].type,"'"
      WHEN g_xrca_m.g_type = '1'   #業務部門
         LET ls_wc = " xrca015 = '",g_detail[g_detail_idx].type,"'"
      WHEN g_xrca_m.g_type = '2'   #業務人員
         LET ls_wc = " xrca014 = '",g_detail[g_detail_idx].type,"'"
      WHEN g_xrca_m.g_type = '3'   #帳款類型
         LET ls_wc = " xrca007 = '",g_detail[g_detail_idx].type,"'"
      WHEN g_xrca_m.g_type = '4'   #立帳期別
         LET ls_wc = " TO_CHAR(xrcadocdt,'YYYYMM') = '",g_detail[g_detail_idx].type,"'"
   END CASE
   #160505-00007#22--add--str--
   LET l_xrca007_sql="(SELECT oocql002||'('||oocql004||')' FROM oocql_t ",
                     "  WHERE oocqlent='"||g_enterprise||"' AND oocql001='3111' AND oocql002=xrca007 AND oocql003='"||g_dlang||"') xrca007 " 
   #160505-00007#22--add--end
   #160505-00007#22--mod--str--
#   LET g_sql = "SELECT xrcasite,xrca001,xrca007,xrcadocno,xrca018,xrca108,SUM(xrcc108 - xrcc109),",
#               "       SUM(xrcc118 - xrcc119 + xrcc113) FROM xrca_t,xrcc_t                ",
   LET g_sql = "SELECT xrcasite,xrca001,",l_xrca007_sql,",xrcadocno,xrca018,",
               "       CASE WHEN substr(xrca001,1,1)=2 OR xrca001='02' OR xrca001='04' THEN xrca108*-1 ELSE xrca108 END,",
               "       CASE WHEN substr(xrca001,1,1)=2 OR xrca001='02' OR xrca001='04' THEN nvl(SUM(xrcc108 - xrcc109),0) * -1 ELSE nvl(SUM(xrcc108 - xrcc109),0) END,",
               "       CASE WHEN substr(xrca001,1,1)=2 OR xrca001='02' OR xrca001='04' THEN nvl(SUM(xrcc118 - xrcc119 + xrcc113),0) * -1 ELSE nvl(SUM(xrcc118 - xrcc119 + xrcc113),0) END ",
               "  FROM xrca_t,xrcc_t ",
   #160505-00007#22--mod--end
               " WHERE xrcaent = xrccent AND xrcaent = '",g_enterprise,"'  ",
               "   AND xrcadocno = xrccdocno                                                     ",
               "   AND xrcald = xrccld AND xrcald  = '",g_xrca_m.xrcald,"'                       ",
               "   AND xrca004 = '",g_detail[g_detail_idx].xrca004,"'                            ",
               "   AND xrca100 = '",g_detail[g_detail_idx].xrca100,"'                            ",
               "   AND ",ls_wc,
               "   AND xrcadocno IN (SELECT xrcadocno FROM axrq330_tmp01)                     ",    #160727-00019#6  2016/07/28  By 08734    axrq330_xrca_tmp ——> axrq330_tmp01
               " GROUP BY xrcasite,xrca001,xrca007,xrcadocno,xrca018,xrca108                     ",
               " ORDER BY xrcasite,xrca001,xrca007,xrcadocno,xrca018,xrca108                     "
   PREPARE axrq330_ar_prep FROM g_sql
   DECLARE axrq330_ar_curs CURSOR FOR axrq330_ar_prep

   LET l_ac = 1
   FOREACH axrq330_ar_curs INTO g_detail2[l_ac].*

     #150331-00006#6 Add  ---(S)---
      IF l_ac = 1 THEN
         LET g_xrcadocno_str = "'",g_detail2[l_ac].xrcadocno,"'"
      ELSE
         LET g_xrcadocno_str = g_xrcadocno_str,",'",g_detail2[l_ac].xrcadocno,"'"
      END IF
     #150331-00006#6 Add  ---(E)---
#160505-00007#22--mark--str--
#      IF g_detail2[l_ac].xrca001[1,1] = '2' OR g_detail2[l_ac].xrca001 = '02' OR g_detail2[l_ac].xrca001 = '04' THEN
#         LET g_detail2[l_ac].xrca103 = g_detail2[l_ac].xrca103 * -1
#         LET g_detail2[l_ac].xrca108 = g_detail2[l_ac].xrca108 * -1
#         LET g_detail2[l_ac].xrca118 = g_detail2[l_ac].xrca118 * -1
#      END IF

#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_detail2[l_ac].xrca007
#      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3111' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_detail2[l_ac].xrca007 = g_detail2[l_ac].xrca007,'(', g_rtn_fields[1] , ')'

#      IF cl_null(g_detail2[l_ac].xrca108) THEN
#         LET g_detail2[l_ac].xrca108 = 0
#      END IF
#
#      IF cl_null(g_detail2[l_ac].xrca118) THEN
#         LET g_detail2[l_ac].xrca118 = 0
#      END IF
#160505-00007#22--mark--end
      LET l_ac = l_ac + 1
   END FOREACH

   LET g_xrcadocno_str = " IN (",g_xrcadocno_str,")"   #150331-00006#6 Add

   CALL g_detail2.deleteElement(g_detail2.getLength())

   #end add-point
 
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   CALL axrq330_b_fill3()
   CALL axrq330_b_fill4()
   CALL axrq330_b_fill5()   #160817-00054#1 Add
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq330.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrq330_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
 
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_detail[l_ac].xrca004
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_detail[l_ac].xrca004_desc = g_detail[l_ac].xrca004,'(', g_rtn_fields[1] , ')'
            DISPLAY BY NAME g_detail[l_ac].xrca004_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'4'",1) > 0 THEN
      #帶出公用欄位reference值page4
      
 
      #add-point:show段單身reference name="detail_show.body4.reference"
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq330.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION axrq330_maintain_prog()
   #add-point:maintain_prog段define-客製 name="maintain_prog.define_customerization"
   
   #end add-point
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   DEFINE ls_j       LIKE type_t.num5
   #add-point:maintain_prog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="maintain_prog.define"
   
   #end add-point
 
 
   #add-point:maintain_prog段開始前 name="maintain_prog.before"
   
   #end add-point
 
   LET la_param.prog = ""
 
 
 
   IF NOT cl_null(la_param.prog) THEN
      LET ls_js = util.JSON.stringify(la_param)
      CALL cl_cmdrun_wait(ls_js)
   END IF
 
   #add-point:maintain_prog段結束前 name="maintain_prog.after"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrq330.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrq330_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.idx
   DISPLAY g_tot_cnt TO FORMONLY.cnt
 
   #顯示單身頁面的起始與結束筆數
   LET g_page_start_num = g_pagestart
   LET g_page_end_num = g_pagestart + g_num_in_page - 1
   DISPLAY g_page_start_num TO FORMONLY.p_start
   DISPLAY g_page_end_num TO FORMONLY.p_end
 
   #目前不支援跳頁功能
   LET g_page_act_list = "detail_first,detail_previous,'',detail_next,detail_last"
   CALL cl_navigator_detail_page_setting(g_page_act_list,g_current_row_tot,g_pagestart,g_num_in_page,g_tot_cnt)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq330.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrq330_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_master_row_move = "Y" THEN
      LET g_detail_idx = 1
      LET li_redirect = TRUE
   ELSE
      IF g_curr_diag IS NOT NULL THEN
         CASE
            WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
               LET g_detail_idx = 1
               IF g_detail.getLength() THEN
                  LET li_redirect = TRUE
               END IF
            WHEN g_curr_diag.getCurrentRow("s_detail1") > g_detail.getLength() AND g_detail.getLength() > 0
               LET g_detail_idx = g_detail.getLength()
               LET li_redirect = TRUE
            WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
               IF g_detail_idx > g_detail.getLength() THEN
                  LET g_detail_idx = g_detail.getLength()
               END IF
               LET li_redirect = TRUE
         END CASE
      END IF
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axrq330.mask_functions" >}
 &include "erp/axr/axrq330_mask.4gl"
 
{</section>}
 
{<section id="axrq330.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL axrq330_create_tmp()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/11/25 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq330_create_tmp()

   DROP TABLE axrq330_tmp01;   #160727-00019#6  2016/07/28  By 08734    axrq330_xrca_tmp ——> axrq330_tmp01
   CREATE TEMP TABLE axrq330_tmp01 (  #160727-00019#6  2016/07/28  By 08734    axrq330_xrca_tmp ——> axrq330_tmp01
      xrcaent        SMALLINT,
      xrcadocno      VARCHAR(20),
      xrcald         VARCHAR(5),
      xrcadocdt      DATE,
      xrca001        VARCHAR(10),
      xrca100        VARCHAR(10),
      xrca004        VARCHAR(10),
      xrca015        VARCHAR(10),
      xrca014        VARCHAR(20),
      xrca007        VARCHAR(10),
      mm             INTEGER
   );

   DROP TABLE axrq330_tmp02;      #160727-00019#6  2016/07/28  By 08734    axrq330_print_tmp ——> axrq330_tmp02
   CREATE TEMP TABLE axrq330_tmp02 (       #160727-00019#6  2016/07/28  By 08734    axrq330_print_tmp ——> axrq330_tmp02
      xrcasite_desc  VARCHAR(500),
      xrcald_desc  VARCHAR(500),
      g_type  VARCHAR(500),
      b_rule  VARCHAR(500),
      type_desc  VARCHAR(500),
      xrca004_desc  VARCHAR(500), 
      xrca100  VARCHAR(10), 
      xrcc108  DECIMAL(20,6), 
      amount21  DECIMAL(20,6), 
      amount26  DECIMAL(20,6), 
      amount12  DECIMAL(20,6), 
      amount19  DECIMAL(20,6), 
      amount22  DECIMAL(20,6), 
      amount29  DECIMAL(20,6), 
      amount01  DECIMAL(20,6), 
      amount03  DECIMAL(20,6), 
      lbl_amt  DECIMAL(20,6), 
      xrcc109  DECIMAL(20,6), 
      xrcc118  DECIMAL(20,6), 
      xrcc119  DECIMAL(20,6)
   )
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
PRIVATE FUNCTION axrq330_open()
   DEFINE la_param  RECORD
             prog      STRING,
             param     DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING

   IF g_detail_idx2 < 1 THEN RETURN END IF

   CASE
      WHEN g_detail2[g_detail_idx2].xrca001 = '12'
         LET la_param.prog = "axrt300"
      WHEN g_detail2[g_detail_idx2].xrca001 = '11' OR g_detail2[g_detail_idx2].xrca001 = '21'
         LET la_param.prog = "axrt310"
      WHEN g_detail2[g_detail_idx2].xrca001 = '01' OR g_detail2[g_detail_idx2].xrca001 = '02'
         LET la_param.prog = "axrt320"
      WHEN g_detail2[g_detail_idx2].xrca001 = '19' OR g_detail2[g_detail_idx2].xrca001 = '29'
         LET la_param.prog = "axrt330"
   END CASE
   LET la_param.param[1] = g_xrca_m.xrcald
   LET la_param.param[2] = g_detail2[g_detail_idx2].xrcadocno
   LET ls_js = util.JSON.stringify(la_param)
   CALL cl_cmdrun(ls_js)

END FUNCTION
################################################################################
# Descriptions...: sub產生的數據集轉換
# Memo...........: DSCNJ,DSCTP,DSCTC --> ('DSCNJ','DSCTP','DSCTC')
# Usage..........: CALL axrp132_get_ooef001_wc(p_wc)
#                  RETURNING r_wc
# Input parameter: p_wc           sub产生的数据集
# Return code....: r_wc           SQ可用的数据集
# Date & Author..: 2014/10/17 By zhangweib
# Modify.........:
########################################
PRIVATE FUNCTION axrq330_get_ooef001_wc(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF      
   END WHILE   
   LET r_wc = "('",l_str,"')"
   
   RETURN r_wc

END FUNCTION

################################################################################
# Descriptions...: 取得符合條件的資料存入臨時表
# Memo...........:
# Usage..........: CALL axrq330_get_data()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/11/25 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq330_get_data()
   DEFINE l_sql         STRING
   DEFINE l_wc          STRING
   DEFINE ls_wc         STRING
   DEFINE l_xrcaent     LIKE xrca_t.xrcaent
   DEFINE l_xrcadocno   LIKE xrca_t.xrcadocno
   DEFINE l_xrcadocdt   LIKE xrca_t.xrcadocdt
   DEFINE l_xrca001     LIKE xrca_t.xrca001
   DEFINE l_xrca100     LIKE xrca_t.xrca100
   DEFINE l_xrca004     LIKE xrca_t.xrca004
   DEFINE l_xrca015     LIKE xrca_t.xrca015
   DEFINE l_xrca014     LIKE xrca_t.xrca014
   DEFINE l_xrca007     LIKE xrca_t.xrca007
   DEFINE l_mm          LIKE type_t.num10
   DEFINE l_amt         LIKE xrca_t.xrca103
   DEFINE l_stus_wc     STRING   #151130-00015#1 add
   
#   CALL axrq330_create_tmp() #160505-00007#22 mark

   #151231-00010#7--(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_wc = g_wc," AND xrca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#7--(E)
   
   LET l_wc = " "
   IF NOT cl_null(g_xrca_m.b_rule) THEN
      CASE
         WHEN g_xrca_m.b_rule = '1'
            LET l_wc = " HAVING SUM(xrcc108 - xrcc109) > 0"
         WHEN g_xrca_m.b_rule = '2'
            LET l_wc = " HAVING SUM(xrcc108 - xrcc109) = 0"
      END CASE
   END IF

#   CALL s_fin_create_account_center_tmp()   #160505-00007#22 mark
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_xrca_m.xrcasite,g_today,'1')
   #取得帳務組織下所屬成員之帳別   
   CALL s_fin_account_center_comp_str() RETURNING ls_wc
   #將取回的字串轉換為SQL條件
   CALL axrq330_get_ooef001_wc(ls_wc) RETURNING ls_wc  

   #151130-00015#1--add--str--
   CASE g_xrca_m.stus
      WHEN '1'
         LET l_stus_wc=" xrcastus = 'N' "
      WHEN '2'
         LET l_stus_wc=" xrcastus = 'Y' "   
      WHEN '3'
         LET l_stus_wc=" xrcastus IN ('N','Y') "
   END CASE
   #151130-00015#1--add--end
   
   LET l_sql = "SELECT xrcaent,xrcadocno,xrcadocdt,xrca001,xrca100,xrca004,xrca015,xrca014,xrca007,   ",
               "       TO_CHAR(xrcadocdt,'YYYYMM'),SUM(xrcc108 - xrcc109) FROM xrca_t,xrcc_t",
               " WHERE xrcaent = xrccent",
              #"   AND xrccdocno = xrccdocno AND xrcald = xrccld",   #151217-00017#1   Mark
               "   AND xrcadocno = xrccdocno AND xrcald = xrccld",   #151217-00017#1   Add
               "   AND xrcaent = ",g_enterprise,    #151013-00019#3
               "   AND xrcald = '",g_xrca_m.xrcald,"' AND xrcasite IN ",ls_wc,
#               "   AND xrcastus NOT IN ('N','X')",    #150401-00001#36 #151130-00015#1 mark
               "   AND ",l_stus_wc,   #151130-00015#1 add
               "   AND ",g_wc CLIPPED,
               " GROUP BY xrcaent,xrcadocno,xrcadocdt,xrca001,xrca100,xrca004,xrca015,xrca014,xrca007,",
               "          TO_CHAR(xrcadocdt,'YYYYMM') ",l_wc CLIPPED
   PREPARE axrq330_xrca_prep FROM l_sql
   DECLARE axrq330_xrca_curs CURSOR FOR axrq330_xrca_prep

   FOREACH axrq330_xrca_curs INTO l_xrcaent,l_xrcadocno,l_xrcadocdt,l_xrca001,l_xrca100,l_xrca004,
                                  l_xrca015,l_xrca014,l_xrca007,l_mm,l_amt
      INSERT INTO axrq330_tmp01 VALUES (l_xrcaent,l_xrcadocno,g_xrca_m.xrcald,l_xrcadocdt,l_xrca001,   #160727-00019#6  2016/07/28  By 08734    axrq330_xrca_tmp ——> axrq330_tmp01
                                           l_xrca100,l_xrca004,l_xrca015,l_xrca014,l_xrca007,l_mm)
   END FOREACH

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
PRIVATE FUNCTION axrq330_def()
   DEFINE l_sql         STRING
   DEFINE l_xrcasite    LIKE xrca_t.xrcasite
   DEFINE l_xrcacomp    LIKE xrca_t.xrcacomp
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_ooefl003    LIKE ooefl_t.ooefl003

   IF cl_null(g_xrca_m.xrcasite) OR cl_null(g_xrca_m.xrcald) THEN
      #帳務中心
      #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_xrca_m.xrcasite,g_errno
      #該帳務中心與帳別無法勾稽到,以登入人員g_user取得預設帳別/法人
      CALL s_fin_orga_get_comp_ld(g_xrca_m.xrcasite) RETURNING l_success,g_errno,l_xrcacomp,g_xrca_m.xrcald   

      #若取不出資料,則不預設帳別
      IF NOT l_success THEN
         LET g_xrca_m.xrcald   = ''
      END IF

      CALL s_axrt300_xrca_ref('xrcald',g_xrca_m.xrcald,'','') RETURNING l_success,g_xrca_m.xrcald_desc
      #161128-00061#4-----modify--begin----------
      #SELECT * INTO g_glaa.* 
       SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
              glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
              glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
              glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
              glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
              glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
      #161128-00061#4----modify--end----------
      FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
      CALL s_axrt300_xrca_ref('xrcasite',g_xrca_m.xrcasite,'','') RETURNING l_success,g_xrca_m.xrcasite_desc
      DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrcald,g_xrca_m.xrcald_desc
   END IF

   #161128-00061#4-----modify--begin----------
   #SELECT * INTO g_glaa.* 
    SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
           glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
           glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
           glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
           glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
           glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
   #161128-00061#4----modify--end----------
   FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
   SELECT glaacomp INTO g_xrca_m.xrcacomp FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xrca_m.xrcald
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrca_m.xrcacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xrca_m.xrcacomp = g_xrca_m.xrcacomp,'(', g_rtn_fields[1] , ')'
   DISPLAY BY NAME g_xrca_m.xrcacomp

  #161111-00049#1 Add  ---(S)---
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_glaa.glaacomp) RETURNING g_sub_success,g_sql_ctrl
  #161111-00049#1 Add  ---(E)---

END FUNCTION

################################################################################
# Descriptions...: 單身陣列填充3
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
PRIVATE FUNCTION axrq330_b_fill3()
   DEFINE ls_wc         STRING
   DEFINE l_wc          STRING
   DEFINE l_s           LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_isafdocno   LIKE isaf_t.isafdocno

   IF g_detail_idx2 = 0 THEN RETURN END IF

   CALL g_detail3.clear()

   CALL s_axrt300_sel_ld(g_xrca_m.xrcald) RETURNING l_success,l_s   #獲取帳套主/次
   
   CASE l_s
      WHEN '1'
         LET ls_wc = " isaf035 = '",g_detail2[g_detail_idx2].xrcadocno,"'"
      WHEN '2'
         LET ls_wc = " isaf048 = '",g_detail2[g_detail_idx2].xrcadocno,"'"
      WHEN '3'
         LET ls_wc = " isaf049 = '",g_detail2[g_detail_idx2].xrcadocno,"'"
   END CASE
   
   #应收单据获取开票单号
   LET g_sql = " SELECT isafdocno FROM isaf_t ",
               "  WHERE isafent = '",g_enterprise,"' AND isafcomp = '",g_glaa.glaacomp,"'",
               "    AND ",ls_wc CLIPPED,
               "    AND isafstus = 'Y' "
   PREPARE axrq330_isaf_prep FROM g_sql
   DECLARE axrq330_isaf_curs CURSOR FOR axrq330_isaf_prep

   LET l_wc = ""
   FOREACH axrq330_isaf_curs INTO l_isafdocno
      IF cl_null(l_wc) THEN
         LET l_wc = l_wc,"'",l_isafdocno,"'"
      ELSE
         LET l_wc = l_wc,",'",l_isafdocno,"'"
      END IF
   END FOREACH

   IF cl_null(l_wc) THEN
      RETURN
   ELSE
      LET l_wc = "(",l_wc,")"
   END IF

   LET g_sql = "SELECT isatseq,isaf002,isat001,isat003,isat004,isat007,isat023,isat103,  ",
               "       isat104,isat105,isat101,isat113,isat114,isat115,isatdocno,isat014 ",
               "  FROM isaf_t,isat_t                                                     ",
               "  WHERE isatent = isafent AND isatcomp = isafcomp                        ",
               "    AND isatdocno = isafdocno  AND isatent = '",g_enterprise,"'          ",
               "    AND isatcomp = '",g_glaa.glaacomp,"'",
               "    AND isatdocno IN ",l_wc
   PREPARE axrq330_as_prep FROM g_sql
   DECLARE axrq330_as_curs CURSOR FOR axrq330_as_prep

   LET l_ac = 1
   FOREACH axrq330_as_curs INTO g_detail3[l_ac].*

     #INITIALIZE g_ref_fields TO NULL
     #LET g_ref_fields[1] = l_ooef019
     #LET g_ref_fields[2] = g_detail3[l_ac].isaf008
     #CALL ap_ref_array2(g_ref_fields,"SELECT isacl004 FROM isacl_t WHERE isaclent='"||g_enterprise||"' AND isacl001=? AND isacl002 = ? AND isacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
     #LET g_detail3[l_ac].isaf008 = g_detail3[l_ac].isaf008,'(', g_rtn_fields[1] ,')'

      LET l_ac = l_ac + 1
   END FOREACH

   CALL g_detail3.deleteElement(g_detail3.getLength())

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
PRIVATE FUNCTION axrq330_b_fill4()
   DEFINE l_xrce001_desc_sql   STRING    #160505-00007#22 add
   
   IF g_detail_idx2 = 0 THEN RETURN END IF

   CALL g_detail4.clear()

   LET l_xrce001_desc_sql = "(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '8329' AND gzcbl002 = xrce001 AND gzcbl003 ='",g_lang,"') xrce001_desc " #160505-00007#22 add
   #160505-00007#22--mod--str--
#   LET g_sql = "SELECT xrce001,'',xrcedocno,xrce002,xrce024,xrce100,xrce109 * CASE WHEN xrce015 = 'D' THEN -1 ELSE 1 END,xrce119 * CASE WHEN xrce015 = 'D' THEN -1 ELSE 1 END,xrce003,xrce010,xrce014",
   LET g_sql = "SELECT xrce001,",l_xrce001_desc_sql,",xrcedocno,xrce002,xrce024,xrce100,",
               "       xrce109 * CASE WHEN xrce015 = 'D' THEN -1 ELSE 1 END,xrce119 * CASE WHEN xrce015 = 'D' THEN -1 ELSE 1 END,",
               "       xrce003,xrce010,xrce014",
   #160505-00007#22--mod--end
               "  FROM xrce_t",
               " WHERE xrceent = '",g_enterprise,"'",
               "   AND xrceld  = '",g_xrca_m.xrcald,"'",
              #"   AND xrce003 = '",g_detail2[g_detail_idx2].xrcadocno,"'",   #150331-00006#6 Mark
               "   AND xrce003    ",g_xrcadocno_str,                          #150331-00006#6 Add
               " UNION ",
               "SELECT xrcf001,'',xrcfdocno,xrcf002,xrcb002,'',SUM(xrcf105 * CASE WHEN xrca001 = '02' OR xrca001 = '04' THEN -1 ELSE 1 END),SUM(xrcf115 * CASE WHEN xrca001 = '02' OR xrca001 = '04' THEN -1 ELSE 1 END),xrcf008,'',''",
               "  FROM xrcb_t,xrcf_t,xrca_t",
               " WHERE xrcbent = xrcfent AND xrcbent = '",g_enterprise,"'",
               "   AND xrcaent = xrcbent AND xrcald = xrcbld AND xrcadocno = xrcbdocno",
               "   AND xrcfld  = xrcbld AND xrcf008 = xrcbdocno AND xrcfseq = xrcbseq",
               "   AND xrcbld  = '",g_xrca_m.xrcald,"'",
              #"   AND xrcf008 = '",g_detail2[g_detail_idx2].xrcadocno,"'",   #150331-00006#6 Mark
               "   AND xrcf008    ",g_xrcadocno_str,                          #150331-00006#6 Add
               " GROUP BY xrcf001,xrcfdocno,xrcf002,xrcb002,xrcf008,xrca001",
               " UNION ",
               "SELECT apce001,'',apcedocno,apce002,apce024,apce100,apce109 * CASE WHEN apce015 = 'D' THEN -1 ELSE 1 END,apce119 * CASE WHEN apce015 = 'D' THEN -1 ELSE 1 END,apce003,apce010,apce014",
               "  FROM apce_t",
               " WHERE apceent = '",g_enterprise,"'",
               "   AND apceld  = '",g_xrca_m.xrcald,"'",
              #"   AND apce003 = '",g_detail2[g_detail_idx2].xrcadocno,"'"   #150331-00006#6 Mark
               "   AND apce003    ",g_xrcadocno_str                          #150331-00006#6 Add
   PREPARE axrq330_ce_prep FROM g_sql
   DECLARE axrq330_ce_curs CURSOR FOR axrq330_ce_prep

   LET l_ac = 1
   FOREACH axrq330_ce_curs INTO g_detail4[l_ac].*
#160505-00007#22--mark--str--
#      SELECT gzcbl004 INTO g_detail4[l_ac].xrce001_desc FROM gzcbl_t
#       WHERE gzcbl001 = '8329' AND gzcbl002 = g_detail4[l_ac].xrce001 AND gzcbl003 = g_lang
#160505-00007#22--mark--end
      LET l_ac = l_ac + 1
   END FOREACH

   CALL g_detail4.deleteElement(g_detail4.getLength())

END FUNCTION

################################################################################
# Descriptions...: 抓取收款资料
# Memo...........:
# Usage..........: CALL axrq330_b_fill5()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/09/22 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq330_b_fill5()
   DEFINE ls_wc         STRING
   DEFINE l_wc          STRING
   DEFINE l_s           LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5

   IF g_detail_idx2 = 0 THEN RETURN END IF

   CALL g_detail3.clear()

   CALL s_axrt300_sel_ld(g_xrca_m.xrcald) RETURNING l_success,l_s   #獲取帳套主/次

   LET g_sql = "SELECT nmbadocno,nmbadocdt,nmbb004,nmbb005,SUM(nmbb006),SUM(nmbb007),",
               "       SUM(nmbb008),SUM(nmbb009),SUM(nmbb006-nmbb008),SUM(nmbb007-nmbb009)",
               "  FROM nmba_t,nmbb_t",
               " WHERE nmbaent = nmbbent",
               "   AND nmbadocno = nmbbdocno",
               "   AND nmbacomp = nmbbcomp ",
               "   AND nmbb026 = '",g_detail[g_detail_idx].xrca004,"'",
               "   AND nmbb004 = '",g_detail[g_detail_idx].xrca100,"'",
               "   AND nmbastus <> 'X'",
               " GROUP BY nmbadocno,nmbadocdt,nmbb004,nmbb005"
   PREPARE axrq330_nmba_prep FROM g_sql
   DECLARE axrq330_nmba_curs CURSOR FOR axrq330_nmba_prep

   LET l_ac = 1
   FOREACH axrq330_nmba_curs INTO g_detail5[l_ac].*

      LET l_ac = l_ac + 1
   END FOREACH

   CALL g_detail5.deleteElement(g_detail5.getLength())

END FUNCTION

################################################################################
# Descriptions...: 打印
# Memo...........: #160505-00007#22 add
# Usage..........: CALL axrq330_output()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/05/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq330_output()
   DEFINE l_xrcasite_desc LIKE type_t.chr500
   DEFINE l_xrcald_desc   LIKE type_t.chr500
   DEFINE l_g_type        LIKE type_t.chr500
   DEFINE l_b_rule        LIKE type_t.chr500
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005
   DEFINE l_i,l_count     LIKE type_t.num5
   
   DELETE FROM axrq330_tmp02         #160727-00019#6  2016/07/28  By 08734    axrq330_print_tmp ——> axrq330_tmp02
   LET l_xrcasite_desc = ''
   LET l_xrcald_desc = ''
   LET l_g_type = ''
   LET l_b_rule = ''
   LET l_xrcasite_desc = g_xrca_m.xrcasite," ",g_xrca_m.xrcasite_desc
   LET l_xrcald_desc = g_xrca_m.xrcald," ",g_xrca_m.xrcald_desc,"   ",g_xrca_m.xrcacomp
   CASE
      WHEN g_xrca_m.g_type = '0'
         SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'cbo_type_0' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
      WHEN g_xrca_m.g_type = '1'
         SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'cbo_type_1' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
      WHEN g_xrca_m.g_type = '2'
         SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'cbo_type_2' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
      WHEN g_xrca_m.g_type = '3'
         SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'cbo_type_3' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
      WHEN g_xrca_m.g_type = '4'
         SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'cbo_type_4' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
   END CASE
   LET l_g_type = l_gzzd005
   CASE
      WHEN g_xrca_m.b_rule = '0'
         SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'cbo_rule_0' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
      WHEN g_xrca_m.b_rule = '1'
         SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'cbo_rule_1' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
      WHEN g_xrca_m.b_rule = '2'
         SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd003 = 'cbo_rule_2' AND gzzd002 = g_lang AND gzzd001 = 'axrq330'
   END CASE
   LET l_b_rule = l_gzzd005
   
   LET l_count=g_detail.getLength()
   FOR l_i=1 TO l_count
      INSERT INTO axrq330_tmp02 VALUES(l_xrcasite_desc,l_xrcald_desc,l_g_type,l_b_rule,        #160727-00019#6  2016/07/28  By 08734    axrq330_print_tmp ——> axrq330_tmp02
            g_detail[l_i].type_desc,g_detail[l_i].xrca004_desc,g_detail[l_i].xrca100,g_detail[l_i].xrcc108,
            g_detail[l_i].amount21,g_detail[l_i].amount26,g_detail[l_i].amount12,g_detail[l_i].amount19,
            g_detail[l_i].amount22,g_detail[l_i].amount29,g_detail[l_i].amount01,g_detail[l_i].amount03,
            g_detail[l_i].lbl_amt,g_detail[l_i].xrcc109,g_detail[l_i].xrcc118,g_detail[l_i].xrcc119)
   END FOR
   CALL axrq330_x01('1=1','axrq330_tmp02',g_xrca_m.g_type,g_xrca_m.b_rule)       #160727-00019#6  2016/07/28  By 08734    axrq330_print_tmp ——> axrq330_tmp02
END FUNCTION

 
{</section>}
 
