#該程式未解開Section, 採用最新樣板產出!
{<section id="axrt460.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0021(2014-11-28 12:37:35), PR版次:0021(2017-01-20 17:20:29)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000128
#+ Filename...: axrt460
#+ Description: 集團收款核銷單維護作業
#+ Creator....: 02599(2014-09-19 23:05:34)
#+ Modifier...: 02599 -SD/PR- 08729
 
{</section>}
 
{<section id="axrt460.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#141226-00016#2                By 01727   單據日期欄輸入後檢查關帳日期 -->帳務中心所屬法人據點的aoos020中的應收關帳日期
#151125-00001#4   2015/11/30   By 06948   增加作廢時詢問「是否作廢」
#151125-00006#1   2015/12/03   by 06862   新增/修改/複製單據后立即審核，立即拋轉傳票
#151130-00015#2   2015/12/22   BY Xiaozg  根据是否可以更改單據日期 設定開放單據日期修改
#160318-00005#46  160401       by pengxin 修正azzi920重复定义之错误讯息
#160322-00025#29  2016/04/27   By 01531   nmbcorga赋值
#160318-00025#25  2016/04/27   BY 07900   校验代码重复错误讯息的修改
#160125-00005#9   2016/08/02 By 01727    查詢時加上帳套人員權限條件過濾
#160727-00019#37   16/08/12 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_ar_tmp ——> s_vr_tmp04
#160727-00019#37   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_ar_group ——> s_vr_tmp05
#160811-00009#3   2016/08/15   By 01531   账务中心/法人/账套权限控管
#160818-00011#1   2016/08/18   By 02599   1.收款資訊的營運據點限定為單頭帳套對應的法人,营运据点不可录入，默认=单头法人
#                                         2.沖應收單時, 不限定帳務中心一定跟單頭帳務中心相同
#                                         3.確認時檢查 aoos010 依參數,E-FIN-002 為　N 時則只產生到 axrt400 且狀態為 N 
#160905-00002#5   2016/09/05   By 08729   處理SQL條件多一項ENT
#160913-00017#10  2016/09/22   By 07900   AXR模组调整交易客商开窗
#161017-00011#2   2016/10/19   By 02599   增加控制组权限控管
#161006-00005#39  2016/10/27   By 08171   账务中心开窗需调整为q_ooef001_46,新增时where条件限定ooefstus=Y.查询时不限定;
#                                         来源组织开窗增加where條件 ooef201 = 'Y';
#                                         法人开窗调整为q_ooef001_2,要注意原本where条件中的权限设置要保留
#161111-00049#9  2016/11/28 By 01727       控制组权限修改
#161128-00061#5  2016/12/05 by 02481      标准程式定义采用宣告模式,弃用.*写法
#161026-00010#2  2017/01/04 By 01531      改狀態條件抓取已复核狀態的资料
#161104-00046#6  2017/01/11 By 06821      單別預設值;資料依照單別user dept權限過濾單號
#170119-00024#7  2017/01/20 By 08729      新舊值處理  
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
PRIVATE type type_g_xrfa_m        RECORD
       xrfasite LIKE xrfa_t.xrfasite, 
   xrfasite_desc LIKE type_t.chr80, 
   xrfa001 LIKE xrfa_t.xrfa001, 
   xrfa001_desc LIKE type_t.chr80, 
   xrfald LIKE xrfa_t.xrfald, 
   xrfald_desc LIKE type_t.chr80, 
   xrfacomp LIKE xrfa_t.xrfacomp, 
   xrfadocno LIKE xrfa_t.xrfadocno, 
   xrfadocdt LIKE xrfa_t.xrfadocdt, 
   xrfa002 LIKE xrfa_t.xrfa002, 
   xrfa002_desc LIKE type_t.chr80, 
   xrfastus LIKE xrfa_t.xrfastus, 
   xrfaownid LIKE xrfa_t.xrfaownid, 
   xrfaownid_desc LIKE type_t.chr80, 
   xrfaowndp LIKE xrfa_t.xrfaowndp, 
   xrfaowndp_desc LIKE type_t.chr80, 
   xrfacrtid LIKE xrfa_t.xrfacrtid, 
   xrfacrtid_desc LIKE type_t.chr80, 
   xrfacrtdp LIKE xrfa_t.xrfacrtdp, 
   xrfacrtdp_desc LIKE type_t.chr80, 
   xrfacrtdt LIKE xrfa_t.xrfacrtdt, 
   xrfamodid LIKE xrfa_t.xrfamodid, 
   xrfamodid_desc LIKE type_t.chr80, 
   xrfamoddt LIKE xrfa_t.xrfamoddt, 
   xrfacnfid LIKE xrfa_t.xrfacnfid, 
   xrfacnfid_desc LIKE type_t.chr80, 
   xrfacnfdt LIKE xrfa_t.xrfacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xrfb_d        RECORD
       xrfbseq LIKE xrfb_t.xrfbseq, 
   xrfb001 LIKE xrfb_t.xrfb001, 
   xrfb001_desc LIKE type_t.chr500, 
   xrfbld LIKE xrfb_t.xrfbld, 
   xrfb007 LIKE xrfb_t.xrfb007, 
   xrfb006 LIKE xrfb_t.xrfb006, 
   xrfb004 LIKE xrfb_t.xrfb004, 
   xrfb002 LIKE xrfb_t.xrfb002, 
   xrfb003 LIKE xrfb_t.xrfb003, 
   xrfb100 LIKE xrfb_t.xrfb100, 
   xrfb101 LIKE xrfb_t.xrfb101, 
   xrfb103 LIKE xrfb_t.xrfb103, 
   xrfb104 LIKE xrfb_t.xrfb104, 
   xrfb005 LIKE xrfb_t.xrfb005, 
   xrfb005_desc LIKE type_t.chr500, 
   xrfb201 LIKE type_t.num26_10, 
   xrfb204 LIKE xrfb_t.xrfb204
       END RECORD
PRIVATE TYPE type_g_xrfb2_d RECORD
       xrfcseq LIKE xrfc_t.xrfcseq, 
   xrfc001 LIKE xrfc_t.xrfc001, 
   xrfc001_desc LIKE type_t.chr500, 
   xrfc002 LIKE xrfc_t.xrfc002, 
   xrfc006 LIKE xrfc_t.xrfc006, 
   xrfc013 LIKE xrfc_t.xrfc013, 
   xrfc003 LIKE xrfc_t.xrfc003, 
   xrfc004 LIKE xrfc_t.xrfc004, 
   xrfc005 LIKE xrfc_t.xrfc005, 
   xrfc011 LIKE xrfc_t.xrfc011, 
   xrfc100 LIKE xrfc_t.xrfc100, 
   xrfc101 LIKE xrfc_t.xrfc101, 
   xrfc103 LIKE xrfc_t.xrfc103, 
   xrfc104 LIKE xrfc_t.xrfc104, 
   xrfc201 LIKE xrfc_t.xrfc201, 
   xrfc204 LIKE xrfc_t.xrfc204
       END RECORD
PRIVATE TYPE type_g_xrfb3_d RECORD
       xrfcseq LIKE xrfc_t.xrfcseq, 
   xrfc012 LIKE xrfc_t.xrfc012, 
   xrfc012_desc LIKE type_t.chr500, 
   xrfc007 LIKE xrfc_t.xrfc007, 
   xrfc007_desc LIKE type_t.chr500, 
   xrfc008 LIKE xrfc_t.xrfc008, 
   xrfc009 LIKE xrfc_t.xrfc009, 
   xrfc009_desc LIKE type_t.chr500, 
   xrfc010 LIKE xrfc_t.xrfc010, 
   xrfc010_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_xrfadocno LIKE xrfa_t.xrfadocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#161128-00061#5-----modify--begin----------
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
#161128-00061#5-----modify--end----------
DEFINE g_bookno              LIKE glaa_t.glaald
DEFINE g_site_str       STRING                #160125-00005#9 Add
DEFINE g_sql_ctrl       STRING #161017-00011#2 add
#161104-00046#6 --s add
DEFINE g_user_dept_wc   STRING     
DEFINE g_user_dept_wc_q STRING     
DEFINE g_user_slip_wc   STRING  
DEFINE g_ar_slip         LIKE ooba_t.ooba002 
#161104-00046#6 --e add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_xrfa_m          type_g_xrfa_m
DEFINE g_xrfa_m_t        type_g_xrfa_m
DEFINE g_xrfa_m_o        type_g_xrfa_m
DEFINE g_xrfa_m_mask_o   type_g_xrfa_m #轉換遮罩前資料
DEFINE g_xrfa_m_mask_n   type_g_xrfa_m #轉換遮罩後資料
 
   DEFINE g_xrfadocno_t LIKE xrfa_t.xrfadocno
 
 
DEFINE g_xrfb_d          DYNAMIC ARRAY OF type_g_xrfb_d
DEFINE g_xrfb_d_t        type_g_xrfb_d
DEFINE g_xrfb_d_o        type_g_xrfb_d
DEFINE g_xrfb_d_mask_o   DYNAMIC ARRAY OF type_g_xrfb_d #轉換遮罩前資料
DEFINE g_xrfb_d_mask_n   DYNAMIC ARRAY OF type_g_xrfb_d #轉換遮罩後資料
DEFINE g_xrfb2_d          DYNAMIC ARRAY OF type_g_xrfb2_d
DEFINE g_xrfb2_d_t        type_g_xrfb2_d
DEFINE g_xrfb2_d_o        type_g_xrfb2_d
DEFINE g_xrfb2_d_mask_o   DYNAMIC ARRAY OF type_g_xrfb2_d #轉換遮罩前資料
DEFINE g_xrfb2_d_mask_n   DYNAMIC ARRAY OF type_g_xrfb2_d #轉換遮罩後資料
DEFINE g_xrfb3_d          DYNAMIC ARRAY OF type_g_xrfb3_d
DEFINE g_xrfb3_d_t        type_g_xrfb3_d
DEFINE g_xrfb3_d_o        type_g_xrfb3_d
DEFINE g_xrfb3_d_mask_o   DYNAMIC ARRAY OF type_g_xrfb3_d #轉換遮罩前資料
DEFINE g_xrfb3_d_mask_n   DYNAMIC ARRAY OF type_g_xrfb3_d #轉換遮罩後資料
 
 
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
DEFINE g_wc3            STRING  #2015/11/06 add
#end add-point
 
{</section>}
 
{<section id="axrt460.main" >}
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
   #161104-00046#6 --s add
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_xrfa_m','','','','','','')RETURNING g_sub_success
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('','xrfald','xrfaent','xrfadocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#6 --e add   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xrfasite,'',xrfa001,'',xrfald,'',xrfacomp,xrfadocno,xrfadocdt,xrfa002, 
       '',xrfastus,xrfaownid,'',xrfaowndp,'',xrfacrtid,'',xrfacrtdp,'',xrfacrtdt,xrfamodid,'',xrfamoddt, 
       xrfacnfid,'',xrfacnfdt", 
                      " FROM xrfa_t",
                      " WHERE xrfaent= ? AND xrfadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrt460_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xrfasite,t0.xrfa001,t0.xrfald,t0.xrfacomp,t0.xrfadocno,t0.xrfadocdt, 
       t0.xrfa002,t0.xrfastus,t0.xrfaownid,t0.xrfaowndp,t0.xrfacrtid,t0.xrfacrtdp,t0.xrfacrtdt,t0.xrfamodid, 
       t0.xrfamoddt,t0.xrfacnfid,t0.xrfacnfdt,t1.ooefl003 ,t2.ooag011 ,t3.glaal002 ,t4.pmaal004 ,t5.ooag011 , 
       t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooag011",
               " FROM xrfa_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xrfasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.xrfa001  ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent="||g_enterprise||" AND t3.glaalld=t0.xrfald AND t3.glaal001='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent="||g_enterprise||" AND t4.pmaal001=t0.xrfa002 AND t4.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.xrfaownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.xrfaowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.xrfacrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.xrfacrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.xrfamodid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.xrfacnfid  ",
 
               " WHERE t0.xrfaent = " ||g_enterprise|| " AND t0.xrfadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrt460_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrt460 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrt460_init()   
 
      #進入選單 Menu (="N")
      CALL axrt460_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrt460
      
   END IF 
   
   CLOSE axrt460_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE s_vr_tmp04;  #160727-00019#37   16/08/12 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_ar_tmp ——> s_vr_tmp04
   DROP TABLE s_vr_tmp05;  #160727-00019#37   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_ar_group ——> s_vr_tmp05
   DROP TABLE s_voucher_glbc;
   DROP TABLE s_axrt300_tmp;
   DROP TABLE s_fin_tmp1
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrt460.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axrt460_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE r_success       LIKE type_t.num5
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('xrfastus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2','3',","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_voucher_cre_ar_tmp_table() RETURNING r_success
   CALL s_axrt300_create_tmp()
   CALL axrt460_set_scc()
   CALL s_fin_create_account_center_tmp()
   
   CALL cl_set_comp_entry('xrfb001_desc',FALSE) #160818-00011#1 add
   #161017-00011#2--add--str--
   LET g_sql_ctrl = NULL
  #CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl   #161111-00049#9 Mark
  #161111-00049#9 Add  ---(S)---
   SELECT ooef017 INTO g_xrfa_m.xrfacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_xrfa_m.xrfacomp) RETURNING g_sub_success,g_sql_ctrl
  #161111-00049#9 Add  ---(E)---
   #161017-00011#2--add--end
   #end add-point
   
   #初始化搜尋條件
   CALL axrt460_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axrt460.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axrt460_ui_dialog()
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
   #151125-00006#1 add ---s 
   DEFINE l_cn              LIKE type_t.num5
   #151125-00006#1 add ---e
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
            CALL axrt460_insert()
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
         INITIALIZE g_xrfa_m.* TO NULL
         CALL g_xrfb_d.clear()
         CALL g_xrfb2_d.clear()
         CALL g_xrfb3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axrt460_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_xrfb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axrt460_idx_chk()
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
               CALL axrt460_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_xrfb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axrt460_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2','3',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2','3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL axrt460_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_xrfb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axrt460_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL axrt460_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL axrt460_browser_fill("")
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
               CALL axrt460_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axrt460_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL axrt460_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL axrt460_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL axrt460_set_act_visible()   
            CALL axrt460_set_act_no_visible()
            IF NOT (g_xrfa_m.xrfadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " xrfaent = " ||g_enterprise|| " AND",
                                  " xrfadocno = '", g_xrfa_m.xrfadocno, "' "
 
               #填到對應位置
               CALL axrt460_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "xrfa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xrfb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xrfc_t" 
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
               CALL axrt460_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "xrfa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xrfb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xrfc_t" 
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
                  CALL axrt460_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL axrt460_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axrt460_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt460_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axrt460_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt460_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axrt460_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt460_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axrt460_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt460_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axrt460_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt460_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_xrfb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xrfb2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_xrfb3_d)
                  LET g_export_id[3]   = "s_detail3"
 
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
               CALL axrt460_modify()
               #add-point:ON ACTION modify name="menu.modify"
               CALL axrt460_ui_headershow()   #151125-00006#1--add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axrt460_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               CALL axrt460_ui_headershow()   #151125-00006#1--add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axrt460_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axrt460_insert()
               #add-point:ON ACTION insert name="menu.insert"
               #add 151125-00006#1 --s
               LET l_cn = 0 
               SELECT COUNT(*) INTO l_cn FROM xrfa_t 
               #WHERE xrfald  = g_xrfa_m.xrfald AND  xrfacomp = g_xrfa_m.xrfacomp AND xrfadocno = g_xrfa_m.xrfadocno #160905-00002#5 mark
               WHERE xrfaent = g_enterprise AND xrfald  = g_xrfa_m.xrfald AND  xrfacomp = g_xrfa_m.xrfacomp AND xrfadocno = g_xrfa_m.xrfadocno #160905-00002#5
               IF l_cn > 0 THEN
                  CALL axrt460_ui_headershow()
               END IF
               #add 151125-00006#1 --e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/axr/axrt460_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/axr/axrt460_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axrt460_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               #add 151125-00006#1 --s
               LET l_cn = 0 
               SELECT COUNT(*) INTO l_cn FROM xrfa_t 
               #WHERE xrfald  = g_xrfa_m.xrfald AND  xrfacomp = g_xrfa_m.xrfacomp AND xrfadocno = g_xrfa_m.xrfadocno #160905-00002#5 mark
               WHERE xrfaent = g_enterprise AND xrfald  = g_xrfa_m.xrfald AND  xrfacomp = g_xrfa_m.xrfacomp AND xrfadocno = g_xrfa_m.xrfadocno #160905-00002#5
               IF l_cn > 0 THEN
                  CALL axrt460_ui_headershow()
               END IF
               #add 151125-00006#1 --e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION axrt460_01
            LET g_action_choice="axrt460_01"
            IF cl_auth_chk_act("axrt460_01") THEN
               
               #add-point:ON ACTION axrt460_01 name="menu.axrt460_01"
               CALL axrt460_diff()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axrt460_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axrt460_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axrt460_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axrt460_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_xrfa_m.xrfadocdt)
 
 
 
         
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
 
{<section id="axrt460.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axrt460_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_ld_str          STRING    #160125-00005#9 Add
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
  #160125-00005#9 Add  ---(S)---
   #CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str  #160811-00009#3
   CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str           #160811-00009#3
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","xrfald")
   LET l_wc = l_wc," AND ",l_ld_str
  #160125-00005#9 Add  ---(E)---
  
   #161017-00011#2--add--str--
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET l_wc = l_wc," AND EXISTS (SELECT 1 FROM pmaa_t ",
                      "              WHERE pmaaent = ",g_enterprise,
                      "                AND ",g_sql_ctrl,
                      "                AND pmaaent = xrfaent ",
                      "                AND pmaa001 = xrfa002 )"
   END IF
   #161017-00011#2--add--end
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT xrfadocno ",
                      " FROM xrfa_t ",
                      " ",
                      " LEFT JOIN xrfb_t ON xrfbent = xrfaent AND xrfadocno = xrfbdocno ", "  ",
                      #add-point:browser_fill段sql(xrfb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN xrfc_t ON xrfcent = xrfaent AND xrfadocno = xrfcdocno", "  ",
                      #add-point:browser_fill段sql(xrfc_t1) name="browser_fill.cnt.join.xrfc_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE xrfaent = " ||g_enterprise|| " AND xrfbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xrfa_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xrfadocno ",
                      " FROM xrfa_t ", 
                      "  ",
                      "  ",
                      " WHERE xrfaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xrfa_t")
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
      INITIALIZE g_xrfa_m.* TO NULL
      CALL g_xrfb_d.clear()        
      CALL g_xrfb2_d.clear() 
      CALL g_xrfb3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xrfadocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xrfastus,t0.xrfadocno ",
                  " FROM xrfa_t t0",
                  "  ",
                  "  LEFT JOIN xrfb_t ON xrfbent = xrfaent AND xrfadocno = xrfbdocno ", "  ", 
                  #add-point:browser_fill段sql(xrfb_t1) name="browser_fill.join.xrfb_t1"
                  
                  #end add-point
                  "  LEFT JOIN xrfc_t ON xrfcent = xrfaent AND xrfadocno = xrfcdocno", "  ", 
                  #add-point:browser_fill段sql(xrfc_t1) name="browser_fill.join.xrfc_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                  
                  " WHERE t0.xrfaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("xrfa_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xrfastus,t0.xrfadocno ",
                  " FROM xrfa_t t0",
                  "  ",
                  
                  " WHERE t0.xrfaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("xrfa_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY xrfadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"xrfa_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xrfadocno
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
   
   IF cl_null(g_browser[g_cnt].b_xrfadocno) THEN
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
   IF g_action_choice="statechange" THEN
      IF g_xrfa_m.xrfastus <> 'N' THEN
         CALL cl_set_act_visible('modify,modify_detail,delete',FALSE)
      ELSE
         CALL cl_set_act_visible('modify,modify_detail,delete',TRUE)
      END IF
   END IF
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="axrt460.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axrt460_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xrfa_m.xrfadocno = g_browser[g_current_idx].b_xrfadocno   
 
   EXECUTE axrt460_master_referesh USING g_xrfa_m.xrfadocno INTO g_xrfa_m.xrfasite,g_xrfa_m.xrfa001, 
       g_xrfa_m.xrfald,g_xrfa_m.xrfacomp,g_xrfa_m.xrfadocno,g_xrfa_m.xrfadocdt,g_xrfa_m.xrfa002,g_xrfa_m.xrfastus, 
       g_xrfa_m.xrfaownid,g_xrfa_m.xrfaowndp,g_xrfa_m.xrfacrtid,g_xrfa_m.xrfacrtdp,g_xrfa_m.xrfacrtdt, 
       g_xrfa_m.xrfamodid,g_xrfa_m.xrfamoddt,g_xrfa_m.xrfacnfid,g_xrfa_m.xrfacnfdt,g_xrfa_m.xrfasite_desc, 
       g_xrfa_m.xrfa001_desc,g_xrfa_m.xrfald_desc,g_xrfa_m.xrfa002_desc,g_xrfa_m.xrfaownid_desc,g_xrfa_m.xrfaowndp_desc, 
       g_xrfa_m.xrfacrtid_desc,g_xrfa_m.xrfacrtdp_desc,g_xrfa_m.xrfamodid_desc,g_xrfa_m.xrfacnfid_desc 
 
   
   CALL axrt460_xrfa_t_mask()
   CALL axrt460_show()
      
END FUNCTION
 
{</section>}
 
{<section id="axrt460.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axrt460_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrt460.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axrt460_ui_browser_refresh()
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
      IF g_browser[l_i].b_xrfadocno = g_xrfa_m.xrfadocno 
 
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
 
{<section id="axrt460.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrt460_construct()
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
   DEFINE l_ld_str      STRING                #160125-00005#9 Add
   DEFINE l_ooef017     LIKE ooef_t.ooef017   #161111-00049#9 Add
   DEFINE l_glaa004     LIKE glaa_t.glaa004   #161111-00049#9 Add
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   #161111-00049#9 Add  ---(S)---
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   #161111-00049#9 Add  ---(E)---
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_xrfa_m.* TO NULL
   CALL g_xrfb_d.clear()        
   CALL g_xrfb2_d.clear() 
   CALL g_xrfb3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   LET g_site_str = NULL   #160125-00005#9 Add
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xrfasite,xrfa001,xrfald,xrfacomp,xrfadocno,xrfadocdt,xrfa002,xrfastus, 
          xrfaownid,xrfaowndp,xrfacrtid,xrfacrtdp,xrfacrtdt,xrfamodid,xrfamoddt,xrfacnfid,xrfacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xrfacrtdt>>----
         AFTER FIELD xrfacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xrfamoddt>>----
         AFTER FIELD xrfamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xrfacnfdt>>----
         AFTER FIELD xrfacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xrfapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.xrfasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfasite
            #add-point:ON ACTION controlp INFIELD xrfasite name="construct.c.xrfasite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "     ooef201 = 'Y' ",
                                   " AND ooef001 IN (SELECT DISTINCT ooed002 FROM ooed_t",
                                   "                  WHERE ooedent=",g_enterprise," AND ooed001='3'",
                                   "                    AND ooed006<='",g_today,"'",
                                   "                    AND (ooed007>='",g_today,"' OR ooed007 IS NULL)",
                                   "                 )"
            #CALL q_ooef001()                           #呼叫開窗 #161006-00005#39 mark
            CALL q_ooef001_46()                                  #161006-00005#39 add
            DISPLAY g_qryparam.return1 TO xrfasite  #顯示到畫面上
            NEXT FIELD xrfasite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfasite
            #add-point:BEFORE FIELD xrfasite name="construct.b.xrfasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfasite
            
            #add-point:AFTER FIELD xrfasite name="construct.a.xrfasite"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str   #160125-00005#9 Add
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrfa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfa001
            #add-point:ON ACTION controlp INFIELD xrfa001 name="construct.c.xrfa001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfa001  #顯示到畫面上
            NEXT FIELD xrfa001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfa001
            #add-point:BEFORE FIELD xrfa001 name="construct.b.xrfa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfa001
            
            #add-point:AFTER FIELD xrfa001 name="construct.a.xrfa001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrfald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfald
            #add-point:ON ACTION controlp INFIELD xrfald name="construct.c.xrfald"
            #此段落由子樣板a08產生
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str   #160125-00005#9 Add
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') " #160811-00009#3  mark
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
			   #LET g_qryparam.where = l_ld_str CLIPPED   #160125-00005#9 Add                    #160811-00009#3  mark
			   LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa008 = 'Y' OR glaa014 = 'Y') "  #160811-00009#3  add
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfald  #顯示到畫面上
            NEXT FIELD xrfald                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfald
            #add-point:BEFORE FIELD xrfald name="construct.b.xrfald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfald
            
            #add-point:AFTER FIELD xrfald name="construct.a.xrfald"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrfacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfacomp
            #add-point:ON ACTION controlp INFIELD xrfacomp name="construct.c.xrfacomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗
            CALL q_ooef001_2() 
            DISPLAY g_qryparam.return1 TO xrfacomp  #顯示到畫面上
            NEXT FIELD xrfacomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfacomp
            #add-point:BEFORE FIELD xrfacomp name="construct.b.xrfacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfacomp
            
            #add-point:AFTER FIELD xrfacomp name="construct.a.xrfacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrfadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfadocno
            #add-point:ON ACTION controlp INFIELD xrfadocno name="construct.c.xrfadocno"
            CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str                    #161111-00049#9 Add
            CALL cl_replace_str(l_ld_str,'glaald','xrfald') RETURNING l_ld_str           #161111-00049#9 Add
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161017-00011#2--add--str--
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = "  EXISTS (SELECT 1 FROM pmaa_t ",
                                      "           WHERE pmaaent = ",g_enterprise,
                                      "             AND ",g_sql_ctrl,
                                      "             AND pmaaent = xrfaent ",
                                      "             AND pmaa001 = xrfa002 )"
            END IF
            #161017-00011#2--add--end
            LET g_qryparam.where = g_qryparam.where," AND ",l_ld_str CLIPPED             #161111-00049#9 Add
            #161104-00046#6 --s add
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#6 --e add             
            CALL q_xrfadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfadocno  #顯示到畫面上
            NEXT FIELD xrfadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfadocno
            #add-point:BEFORE FIELD xrfadocno name="construct.b.xrfadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfadocno
            
            #add-point:AFTER FIELD xrfadocno name="construct.a.xrfadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfadocdt
            #add-point:BEFORE FIELD xrfadocdt name="construct.b.xrfadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfadocdt
            
            #add-point:AFTER FIELD xrfadocdt name="construct.a.xrfadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrfadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfadocdt
            #add-point:ON ACTION controlp INFIELD xrfadocdt name="construct.c.xrfadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrfa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfa002
            #add-point:ON ACTION controlp INFIELD xrfa002 name="construct.c.xrfa002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
           # LET g_qryparam.where = " pmaa002 IN ('2','3')"   #160913-00017#10  mark       
             # CALL q_pmaa001()   #160913-00017#10  mark                  #呼叫開窗
            #160913-00017#10--ADD(S)--
            LET g_qryparam.arg1="('2','3')"
            #161017-00011#2--add--str--
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #161017-00011#2--add--end
            CALL q_pmaa001_1()
            #160913-00017#10--ADD(E)-                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfa002  #顯示到畫面上
            NEXT FIELD xrfa002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfa002
            #add-point:BEFORE FIELD xrfa002 name="construct.b.xrfa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfa002
            
            #add-point:AFTER FIELD xrfa002 name="construct.a.xrfa002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfastus
            #add-point:BEFORE FIELD xrfastus name="construct.b.xrfastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfastus
            
            #add-point:AFTER FIELD xrfastus name="construct.a.xrfastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrfastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfastus
            #add-point:ON ACTION controlp INFIELD xrfastus name="construct.c.xrfastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrfaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfaownid
            #add-point:ON ACTION controlp INFIELD xrfaownid name="construct.c.xrfaownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfaownid  #顯示到畫面上
            NEXT FIELD xrfaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfaownid
            #add-point:BEFORE FIELD xrfaownid name="construct.b.xrfaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfaownid
            
            #add-point:AFTER FIELD xrfaownid name="construct.a.xrfaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrfaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfaowndp
            #add-point:ON ACTION controlp INFIELD xrfaowndp name="construct.c.xrfaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfaowndp  #顯示到畫面上
            NEXT FIELD xrfaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfaowndp
            #add-point:BEFORE FIELD xrfaowndp name="construct.b.xrfaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfaowndp
            
            #add-point:AFTER FIELD xrfaowndp name="construct.a.xrfaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrfacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfacrtid
            #add-point:ON ACTION controlp INFIELD xrfacrtid name="construct.c.xrfacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfacrtid  #顯示到畫面上
            NEXT FIELD xrfacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfacrtid
            #add-point:BEFORE FIELD xrfacrtid name="construct.b.xrfacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfacrtid
            
            #add-point:AFTER FIELD xrfacrtid name="construct.a.xrfacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrfacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfacrtdp
            #add-point:ON ACTION controlp INFIELD xrfacrtdp name="construct.c.xrfacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfacrtdp  #顯示到畫面上
            NEXT FIELD xrfacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfacrtdp
            #add-point:BEFORE FIELD xrfacrtdp name="construct.b.xrfacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfacrtdp
            
            #add-point:AFTER FIELD xrfacrtdp name="construct.a.xrfacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfacrtdt
            #add-point:BEFORE FIELD xrfacrtdt name="construct.b.xrfacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrfamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfamodid
            #add-point:ON ACTION controlp INFIELD xrfamodid name="construct.c.xrfamodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfamodid  #顯示到畫面上
            NEXT FIELD xrfamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfamodid
            #add-point:BEFORE FIELD xrfamodid name="construct.b.xrfamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfamodid
            
            #add-point:AFTER FIELD xrfamodid name="construct.a.xrfamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfamoddt
            #add-point:BEFORE FIELD xrfamoddt name="construct.b.xrfamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrfacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfacnfid
            #add-point:ON ACTION controlp INFIELD xrfacnfid name="construct.c.xrfacnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfacnfid  #顯示到畫面上
            NEXT FIELD xrfacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfacnfid
            #add-point:BEFORE FIELD xrfacnfid name="construct.b.xrfacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfacnfid
            
            #add-point:AFTER FIELD xrfacnfid name="construct.a.xrfacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfacnfdt
            #add-point:BEFORE FIELD xrfacnfdt name="construct.b.xrfacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON xrfbseq,xrfb001,xrfb001_desc,xrfbld,xrfb007,xrfb006,xrfb004,xrfb002, 
          xrfb003,xrfb100,xrfb101,xrfb103,xrfb104,xrfb005,xrfb005_desc,xrfb201,xrfb204
           FROM s_detail1[1].xrfbseq,s_detail1[1].xrfb001,s_detail1[1].xrfb001_desc,s_detail1[1].xrfbld, 
               s_detail1[1].xrfb007,s_detail1[1].xrfb006,s_detail1[1].xrfb004,s_detail1[1].xrfb002,s_detail1[1].xrfb003, 
               s_detail1[1].xrfb100,s_detail1[1].xrfb101,s_detail1[1].xrfb103,s_detail1[1].xrfb104,s_detail1[1].xrfb005, 
               s_detail1[1].xrfb005_desc,s_detail1[1].xrfb201,s_detail1[1].xrfb204
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfbseq
            #add-point:BEFORE FIELD xrfbseq name="construct.b.page1.xrfbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfbseq
            
            #add-point:AFTER FIELD xrfbseq name="construct.a.page1.xrfbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrfbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfbseq
            #add-point:ON ACTION controlp INFIELD xrfbseq name="construct.c.page1.xrfbseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xrfb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb001
            #add-point:ON ACTION controlp INFIELD xrfb001 name="construct.c.page1.xrfb001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfb001  #顯示到畫面上
            NEXT FIELD xrfb001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb001
            #add-point:BEFORE FIELD xrfb001 name="construct.b.page1.xrfb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb001
            
            #add-point:AFTER FIELD xrfb001 name="construct.a.page1.xrfb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrfb001_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb001_desc
            #add-point:ON ACTION controlp INFIELD xrfb001_desc name="construct.c.page1.xrfb001_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef201 = 'Y' " #161006-00005#39 add
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfb001_desc  #顯示到畫面上
            NEXT FIELD xrfb001_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb001_desc
            #add-point:BEFORE FIELD xrfb001_desc name="construct.b.page1.xrfb001_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb001_desc
            
            #add-point:AFTER FIELD xrfb001_desc name="construct.a.page1.xrfb001_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfbld
            #add-point:BEFORE FIELD xrfbld name="construct.b.page1.xrfbld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfbld
            
            #add-point:AFTER FIELD xrfbld name="construct.a.page1.xrfbld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrfbld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfbld
            #add-point:ON ACTION controlp INFIELD xrfbld name="construct.c.page1.xrfbld"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb007
            #add-point:BEFORE FIELD xrfb007 name="construct.b.page1.xrfb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb007
            
            #add-point:AFTER FIELD xrfb007 name="construct.a.page1.xrfb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrfb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb007
            #add-point:ON ACTION controlp INFIELD xrfb007 name="construct.c.page1.xrfb007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb006
            #add-point:BEFORE FIELD xrfb006 name="construct.b.page1.xrfb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb006
            
            #add-point:AFTER FIELD xrfb006 name="construct.a.page1.xrfb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrfb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb006
            #add-point:ON ACTION controlp INFIELD xrfb006 name="construct.c.page1.xrfb006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xrfb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb004
            #add-point:ON ACTION controlp INFIELD xrfb004 name="construct.c.page1.xrfb004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooie001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfb004  #顯示到畫面上
            NEXT FIELD xrfb004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb004
            #add-point:BEFORE FIELD xrfb004 name="construct.b.page1.xrfb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb004
            
            #add-point:AFTER FIELD xrfb004 name="construct.a.page1.xrfb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrfb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb002
            #add-point:ON ACTION controlp INFIELD xrfb002 name="construct.c.page1.xrfb002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xrfb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfb002  #顯示到畫面上
            NEXT FIELD xrfb002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb002
            #add-point:BEFORE FIELD xrfb002 name="construct.b.page1.xrfb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb002
            
            #add-point:AFTER FIELD xrfb002 name="construct.a.page1.xrfb002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb003
            #add-point:BEFORE FIELD xrfb003 name="construct.b.page1.xrfb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb003
            
            #add-point:AFTER FIELD xrfb003 name="construct.a.page1.xrfb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrfb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb003
            #add-point:ON ACTION controlp INFIELD xrfb003 name="construct.c.page1.xrfb003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xrfb100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb100
            #add-point:ON ACTION controlp INFIELD xrfb100 name="construct.c.page1.xrfb100"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfb100  #顯示到畫面上
            NEXT FIELD xrfb100                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb100
            #add-point:BEFORE FIELD xrfb100 name="construct.b.page1.xrfb100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb100
            
            #add-point:AFTER FIELD xrfb100 name="construct.a.page1.xrfb100"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb101
            #add-point:BEFORE FIELD xrfb101 name="construct.b.page1.xrfb101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb101
            
            #add-point:AFTER FIELD xrfb101 name="construct.a.page1.xrfb101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrfb101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb101
            #add-point:ON ACTION controlp INFIELD xrfb101 name="construct.c.page1.xrfb101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb103
            #add-point:BEFORE FIELD xrfb103 name="construct.b.page1.xrfb103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb103
            
            #add-point:AFTER FIELD xrfb103 name="construct.a.page1.xrfb103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrfb103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb103
            #add-point:ON ACTION controlp INFIELD xrfb103 name="construct.c.page1.xrfb103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb104
            #add-point:BEFORE FIELD xrfb104 name="construct.b.page1.xrfb104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb104
            
            #add-point:AFTER FIELD xrfb104 name="construct.a.page1.xrfb104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrfb104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb104
            #add-point:ON ACTION controlp INFIELD xrfb104 name="construct.c.page1.xrfb104"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xrfb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb005
            #add-point:ON ACTION controlp INFIELD xrfb005 name="construct.c.page1.xrfb005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfb005  #顯示到畫面上
            NEXT FIELD xrfb005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb005
            #add-point:BEFORE FIELD xrfb005 name="construct.b.page1.xrfb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb005
            
            #add-point:AFTER FIELD xrfb005 name="construct.a.page1.xrfb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrfb005_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb005_desc
            #add-point:ON ACTION controlp INFIELD xrfb005_desc name="construct.c.page1.xrfb005_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfb005_desc  #顯示到畫面上
            NEXT FIELD xrfb005_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb005_desc
            #add-point:BEFORE FIELD xrfb005_desc name="construct.b.page1.xrfb005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb005_desc
            
            #add-point:AFTER FIELD xrfb005_desc name="construct.a.page1.xrfb005_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb201
            #add-point:BEFORE FIELD xrfb201 name="construct.b.page1.xrfb201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb201
            
            #add-point:AFTER FIELD xrfb201 name="construct.a.page1.xrfb201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrfb201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb201
            #add-point:ON ACTION controlp INFIELD xrfb201 name="construct.c.page1.xrfb201"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb204
            #add-point:BEFORE FIELD xrfb204 name="construct.b.page1.xrfb204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb204
            
            #add-point:AFTER FIELD xrfb204 name="construct.a.page1.xrfb204"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrfb204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb204
            #add-point:ON ACTION controlp INFIELD xrfb204 name="construct.c.page1.xrfb204"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON xrfcseq,xrfc001,xrfc001_desc,xrfc002,xrfc006,xrfc013,xrfc003,xrfc004, 
          xrfc005,xrfc011,xrfc100,xrfc101,xrfc103,xrfc104,xrfc201,xrfc204,xrfc012,xrfc012_desc,xrfc007, 
          xrfc007_desc,xrfc008,xrfc009,xrfc009_desc,xrfc010,xrfc010_desc
           FROM s_detail2[1].xrfcseq,s_detail2[1].xrfc001,s_detail2[1].xrfc001_desc,s_detail2[1].xrfc002, 
               s_detail2[1].xrfc006,s_detail2[1].xrfc013,s_detail2[1].xrfc003,s_detail2[1].xrfc004,s_detail2[1].xrfc005, 
               s_detail2[1].xrfc011,s_detail2[1].xrfc100,s_detail2[1].xrfc101,s_detail2[1].xrfc103,s_detail2[1].xrfc104, 
               s_detail2[1].xrfc201,s_detail2[1].xrfc204,s_detail3[1].xrfc012,s_detail3[1].xrfc012_desc, 
               s_detail3[1].xrfc007,s_detail3[1].xrfc007_desc,s_detail3[1].xrfc008,s_detail3[1].xrfc009, 
               s_detail3[1].xrfc009_desc,s_detail3[1].xrfc010,s_detail3[1].xrfc010_desc
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfcseq
            #add-point:BEFORE FIELD xrfcseq name="construct.b.page2.xrfcseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfcseq
            
            #add-point:AFTER FIELD xrfcseq name="construct.a.page2.xrfcseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrfcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfcseq
            #add-point:ON ACTION controlp INFIELD xrfcseq name="construct.c.page2.xrfcseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xrfc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc001
            #add-point:ON ACTION controlp INFIELD xrfc001 name="construct.c.page2.xrfc001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfc001  #顯示到畫面上
            NEXT FIELD xrfc001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc001
            #add-point:BEFORE FIELD xrfc001 name="construct.b.page2.xrfc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc001
            
            #add-point:AFTER FIELD xrfc001 name="construct.a.page2.xrfc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrfc001_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc001_desc
            #add-point:ON ACTION controlp INFIELD xrfc001_desc name="construct.c.page2.xrfc001_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_2()                           #呼叫開窗    #161006-00005#39 q_ooef001 > q_ooef001_2
            DISPLAY g_qryparam.return1 TO xrfc001_desc  #顯示到畫面上
            NEXT FIELD xrfc001_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc001_desc
            #add-point:BEFORE FIELD xrfc001_desc name="construct.b.page2.xrfc001_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc001_desc
            
            #add-point:AFTER FIELD xrfc001_desc name="construct.a.page2.xrfc001_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrfc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc002
            #add-point:ON ACTION controlp INFIELD xrfc002 name="construct.c.page2.xrfc002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfc002  #顯示到畫面上
            NEXT FIELD xrfc002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc002
            #add-point:BEFORE FIELD xrfc002 name="construct.b.page2.xrfc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc002
            
            #add-point:AFTER FIELD xrfc002 name="construct.a.page2.xrfc002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc006
            #add-point:BEFORE FIELD xrfc006 name="construct.b.page2.xrfc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc006
            
            #add-point:AFTER FIELD xrfc006 name="construct.a.page2.xrfc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrfc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc006
            #add-point:ON ACTION controlp INFIELD xrfc006 name="construct.c.page2.xrfc006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc013
            #add-point:BEFORE FIELD xrfc013 name="construct.b.page2.xrfc013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc013
            
            #add-point:AFTER FIELD xrfc013 name="construct.a.page2.xrfc013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrfc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc013
            #add-point:ON ACTION controlp INFIELD xrfc013 name="construct.c.page2.xrfc013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xrfc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc003
            #add-point:ON ACTION controlp INFIELD xrfc003 name="construct.c.page2.xrfc003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xrfc003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfc003  #顯示到畫面上
            NEXT FIELD xrfc003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc003
            #add-point:BEFORE FIELD xrfc003 name="construct.b.page2.xrfc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc003
            
            #add-point:AFTER FIELD xrfc003 name="construct.a.page2.xrfc003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc004
            #add-point:BEFORE FIELD xrfc004 name="construct.b.page2.xrfc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc004
            
            #add-point:AFTER FIELD xrfc004 name="construct.a.page2.xrfc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrfc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc004
            #add-point:ON ACTION controlp INFIELD xrfc004 name="construct.c.page2.xrfc004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc005
            #add-point:BEFORE FIELD xrfc005 name="construct.b.page2.xrfc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc005
            
            #add-point:AFTER FIELD xrfc005 name="construct.a.page2.xrfc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrfc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc005
            #add-point:ON ACTION controlp INFIELD xrfc005 name="construct.c.page2.xrfc005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc011
            #add-point:BEFORE FIELD xrfc011 name="construct.b.page2.xrfc011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc011
            
            #add-point:AFTER FIELD xrfc011 name="construct.a.page2.xrfc011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrfc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc011
            #add-point:ON ACTION controlp INFIELD xrfc011 name="construct.c.page2.xrfc011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xrfc100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc100
            #add-point:ON ACTION controlp INFIELD xrfc100 name="construct.c.page2.xrfc100"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfc100  #顯示到畫面上
            NEXT FIELD xrfc100                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc100
            #add-point:BEFORE FIELD xrfc100 name="construct.b.page2.xrfc100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc100
            
            #add-point:AFTER FIELD xrfc100 name="construct.a.page2.xrfc100"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc101
            #add-point:BEFORE FIELD xrfc101 name="construct.b.page2.xrfc101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc101
            
            #add-point:AFTER FIELD xrfc101 name="construct.a.page2.xrfc101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrfc101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc101
            #add-point:ON ACTION controlp INFIELD xrfc101 name="construct.c.page2.xrfc101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc103
            #add-point:BEFORE FIELD xrfc103 name="construct.b.page2.xrfc103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc103
            
            #add-point:AFTER FIELD xrfc103 name="construct.a.page2.xrfc103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrfc103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc103
            #add-point:ON ACTION controlp INFIELD xrfc103 name="construct.c.page2.xrfc103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc104
            #add-point:BEFORE FIELD xrfc104 name="construct.b.page2.xrfc104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc104
            
            #add-point:AFTER FIELD xrfc104 name="construct.a.page2.xrfc104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrfc104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc104
            #add-point:ON ACTION controlp INFIELD xrfc104 name="construct.c.page2.xrfc104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc201
            #add-point:BEFORE FIELD xrfc201 name="construct.b.page2.xrfc201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc201
            
            #add-point:AFTER FIELD xrfc201 name="construct.a.page2.xrfc201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrfc201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc201
            #add-point:ON ACTION controlp INFIELD xrfc201 name="construct.c.page2.xrfc201"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc204
            #add-point:BEFORE FIELD xrfc204 name="construct.b.page2.xrfc204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc204
            
            #add-point:AFTER FIELD xrfc204 name="construct.a.page2.xrfc204"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrfc204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc204
            #add-point:ON ACTION controlp INFIELD xrfc204 name="construct.c.page2.xrfc204"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.xrfc012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc012
            #add-point:ON ACTION controlp INFIELD xrfc012 name="construct.c.page3.xrfc012"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3111"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfc012  #顯示到畫面上
            NEXT FIELD xrfc012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc012
            #add-point:BEFORE FIELD xrfc012 name="construct.b.page3.xrfc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc012
            
            #add-point:AFTER FIELD xrfc012 name="construct.a.page3.xrfc012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc012_desc
            #add-point:BEFORE FIELD xrfc012_desc name="construct.b.page3.xrfc012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc012_desc
            
            #add-point:AFTER FIELD xrfc012_desc name="construct.a.page3.xrfc012_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrfc012_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc012_desc
            #add-point:ON ACTION controlp INFIELD xrfc012_desc name="construct.c.page3.xrfc012_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.xrfc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc007
            #add-point:ON ACTION controlp INFIELD xrfc007 name="construct.c.page3.xrfc007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooib001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfc007  #顯示到畫面上
            NEXT FIELD xrfc007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc007
            #add-point:BEFORE FIELD xrfc007 name="construct.b.page3.xrfc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc007
            
            #add-point:AFTER FIELD xrfc007 name="construct.a.page3.xrfc007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc007_desc
            #add-point:BEFORE FIELD xrfc007_desc name="construct.b.page3.xrfc007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc007_desc
            
            #add-point:AFTER FIELD xrfc007_desc name="construct.a.page3.xrfc007_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrfc007_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc007_desc
            #add-point:ON ACTION controlp INFIELD xrfc007_desc name="construct.c.page3.xrfc007_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.xrfc008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc008
            #add-point:ON ACTION controlp INFIELD xrfc008 name="construct.c.page3.xrfc008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfc008  #顯示到畫面上
            NEXT FIELD xrfc008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc008
            #add-point:BEFORE FIELD xrfc008 name="construct.b.page3.xrfc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc008
            
            #add-point:AFTER FIELD xrfc008 name="construct.a.page3.xrfc008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrfc009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc009
            #add-point:ON ACTION controlp INFIELD xrfc009 name="construct.c.page3.xrfc009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmas002_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfc009  #顯示到畫面上
            NEXT FIELD xrfc009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc009
            #add-point:BEFORE FIELD xrfc009 name="construct.b.page3.xrfc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc009
            
            #add-point:AFTER FIELD xrfc009 name="construct.a.page3.xrfc009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc009_desc
            #add-point:BEFORE FIELD xrfc009_desc name="construct.b.page3.xrfc009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc009_desc
            
            #add-point:AFTER FIELD xrfc009_desc name="construct.a.page3.xrfc009_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrfc009_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc009_desc
            #add-point:ON ACTION controlp INFIELD xrfc009_desc name="construct.c.page3.xrfc009_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.xrfc010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc010
            #add-point:ON ACTION controlp INFIELD xrfc010 name="construct.c.page3.xrfc010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfc010  #顯示到畫面上
            NEXT FIELD xrfc010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc010
            #add-point:BEFORE FIELD xrfc010 name="construct.b.page3.xrfc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc010
            
            #add-point:AFTER FIELD xrfc010 name="construct.a.page3.xrfc010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrfc010_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc010_desc
            #add-point:ON ACTION controlp INFIELD xrfc010_desc name="construct.c.page3.xrfc010_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrfc010_desc  #顯示到畫面上
            NEXT FIELD xrfc010_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc010_desc
            #add-point:BEFORE FIELD xrfc010_desc name="construct.b.page3.xrfc010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc010_desc
            
            #add-point:AFTER FIELD xrfc010_desc name="construct.a.page3.xrfc010_desc"
            
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
                  WHEN la_wc[li_idx].tableid = "xrfa_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xrfb_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xrfc_t" 
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
   #161104-00046#6 --s add
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#6 --e add 
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axrt460.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axrt460_query()
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
   CALL g_xrfb_d.clear()
   CALL g_xrfb2_d.clear()
   CALL g_xrfb3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL axrt460_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axrt460_browser_fill("")
      CALL axrt460_fetch("")
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
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL axrt460_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL axrt460_fetch("F") 
      #顯示單身筆數
      CALL axrt460_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axrt460.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axrt460_fetch(p_flag)
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
   
   LET g_xrfa_m.xrfadocno = g_browser[g_current_idx].b_xrfadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axrt460_master_referesh USING g_xrfa_m.xrfadocno INTO g_xrfa_m.xrfasite,g_xrfa_m.xrfa001, 
       g_xrfa_m.xrfald,g_xrfa_m.xrfacomp,g_xrfa_m.xrfadocno,g_xrfa_m.xrfadocdt,g_xrfa_m.xrfa002,g_xrfa_m.xrfastus, 
       g_xrfa_m.xrfaownid,g_xrfa_m.xrfaowndp,g_xrfa_m.xrfacrtid,g_xrfa_m.xrfacrtdp,g_xrfa_m.xrfacrtdt, 
       g_xrfa_m.xrfamodid,g_xrfa_m.xrfamoddt,g_xrfa_m.xrfacnfid,g_xrfa_m.xrfacnfdt,g_xrfa_m.xrfasite_desc, 
       g_xrfa_m.xrfa001_desc,g_xrfa_m.xrfald_desc,g_xrfa_m.xrfa002_desc,g_xrfa_m.xrfaownid_desc,g_xrfa_m.xrfaowndp_desc, 
       g_xrfa_m.xrfacrtid_desc,g_xrfa_m.xrfacrtdp_desc,g_xrfa_m.xrfamodid_desc,g_xrfa_m.xrfacnfid_desc 
 
   
   #遮罩相關處理
   LET g_xrfa_m_mask_o.* =  g_xrfa_m.*
   CALL axrt460_xrfa_t_mask()
   LET g_xrfa_m_mask_n.* =  g_xrfa_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axrt460_set_act_visible()   
   CALL axrt460_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_xrfa_m_t.* = g_xrfa_m.*
   LET g_xrfa_m_o.* = g_xrfa_m.*
   
   LET g_data_owner = g_xrfa_m.xrfaownid      
   LET g_data_dept  = g_xrfa_m.xrfaowndp
   
   #重新顯示   
   CALL axrt460_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="axrt460.insert" >}
#+ 資料新增
PRIVATE FUNCTION axrt460_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xrfb_d.clear()   
   CALL g_xrfb2_d.clear()  
   CALL g_xrfb3_d.clear()  
 
 
   INITIALIZE g_xrfa_m.* TO NULL             #DEFAULT 設定
   
   LET g_xrfadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xrfa_m.xrfaownid = g_user
      LET g_xrfa_m.xrfaowndp = g_dept
      LET g_xrfa_m.xrfacrtid = g_user
      LET g_xrfa_m.xrfacrtdp = g_dept 
      LET g_xrfa_m.xrfacrtdt = cl_get_current()
      LET g_xrfa_m.xrfamodid = g_user
      LET g_xrfa_m.xrfamoddt = cl_get_current()
      LET g_xrfa_m.xrfastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      CALL axrt460_insert_default()
      LET g_xrfa_m_t.* = g_xrfa_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_xrfa_m_t.* = g_xrfa_m.*
      LET g_xrfa_m_o.* = g_xrfa_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xrfa_m.xrfastus 
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
 
 
 
    
      CALL axrt460_input("a")
      
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
         INITIALIZE g_xrfa_m.* TO NULL
         INITIALIZE g_xrfb_d TO NULL
         INITIALIZE g_xrfb2_d TO NULL
         INITIALIZE g_xrfb3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL axrt460_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_xrfb_d.clear()
      #CALL g_xrfb2_d.clear()
      #CALL g_xrfb3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axrt460_set_act_visible()   
   CALL axrt460_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xrfadocno_t = g_xrfa_m.xrfadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xrfaent = " ||g_enterprise|| " AND",
                      " xrfadocno = '", g_xrfa_m.xrfadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axrt460_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE axrt460_cl
   
   CALL axrt460_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axrt460_master_referesh USING g_xrfa_m.xrfadocno INTO g_xrfa_m.xrfasite,g_xrfa_m.xrfa001, 
       g_xrfa_m.xrfald,g_xrfa_m.xrfacomp,g_xrfa_m.xrfadocno,g_xrfa_m.xrfadocdt,g_xrfa_m.xrfa002,g_xrfa_m.xrfastus, 
       g_xrfa_m.xrfaownid,g_xrfa_m.xrfaowndp,g_xrfa_m.xrfacrtid,g_xrfa_m.xrfacrtdp,g_xrfa_m.xrfacrtdt, 
       g_xrfa_m.xrfamodid,g_xrfa_m.xrfamoddt,g_xrfa_m.xrfacnfid,g_xrfa_m.xrfacnfdt,g_xrfa_m.xrfasite_desc, 
       g_xrfa_m.xrfa001_desc,g_xrfa_m.xrfald_desc,g_xrfa_m.xrfa002_desc,g_xrfa_m.xrfaownid_desc,g_xrfa_m.xrfaowndp_desc, 
       g_xrfa_m.xrfacrtid_desc,g_xrfa_m.xrfacrtdp_desc,g_xrfa_m.xrfamodid_desc,g_xrfa_m.xrfacnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_xrfa_m_mask_o.* =  g_xrfa_m.*
   CALL axrt460_xrfa_t_mask()
   LET g_xrfa_m_mask_n.* =  g_xrfa_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xrfa_m.xrfasite,g_xrfa_m.xrfasite_desc,g_xrfa_m.xrfa001,g_xrfa_m.xrfa001_desc,g_xrfa_m.xrfald, 
       g_xrfa_m.xrfald_desc,g_xrfa_m.xrfacomp,g_xrfa_m.xrfadocno,g_xrfa_m.xrfadocdt,g_xrfa_m.xrfa002, 
       g_xrfa_m.xrfa002_desc,g_xrfa_m.xrfastus,g_xrfa_m.xrfaownid,g_xrfa_m.xrfaownid_desc,g_xrfa_m.xrfaowndp, 
       g_xrfa_m.xrfaowndp_desc,g_xrfa_m.xrfacrtid,g_xrfa_m.xrfacrtid_desc,g_xrfa_m.xrfacrtdp,g_xrfa_m.xrfacrtdp_desc, 
       g_xrfa_m.xrfacrtdt,g_xrfa_m.xrfamodid,g_xrfa_m.xrfamodid_desc,g_xrfa_m.xrfamoddt,g_xrfa_m.xrfacnfid, 
       g_xrfa_m.xrfacnfid_desc,g_xrfa_m.xrfacnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_xrfa_m.xrfaownid      
   LET g_data_dept  = g_xrfa_m.xrfaowndp
   
   #功能已完成,通報訊息中心
   CALL axrt460_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axrt460.modify" >}
#+ 資料修改
PRIVATE FUNCTION axrt460_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE l_success    LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_xrfa_m_t.* = g_xrfa_m.*
   LET g_xrfa_m_o.* = g_xrfa_m.*
   
   IF g_xrfa_m.xrfadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_xrfadocno_t = g_xrfa_m.xrfadocno
 
   CALL s_transaction_begin()
   
   OPEN axrt460_cl USING g_enterprise,g_xrfa_m.xrfadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axrt460_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axrt460_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axrt460_master_referesh USING g_xrfa_m.xrfadocno INTO g_xrfa_m.xrfasite,g_xrfa_m.xrfa001, 
       g_xrfa_m.xrfald,g_xrfa_m.xrfacomp,g_xrfa_m.xrfadocno,g_xrfa_m.xrfadocdt,g_xrfa_m.xrfa002,g_xrfa_m.xrfastus, 
       g_xrfa_m.xrfaownid,g_xrfa_m.xrfaowndp,g_xrfa_m.xrfacrtid,g_xrfa_m.xrfacrtdp,g_xrfa_m.xrfacrtdt, 
       g_xrfa_m.xrfamodid,g_xrfa_m.xrfamoddt,g_xrfa_m.xrfacnfid,g_xrfa_m.xrfacnfdt,g_xrfa_m.xrfasite_desc, 
       g_xrfa_m.xrfa001_desc,g_xrfa_m.xrfald_desc,g_xrfa_m.xrfa002_desc,g_xrfa_m.xrfaownid_desc,g_xrfa_m.xrfaowndp_desc, 
       g_xrfa_m.xrfacrtid_desc,g_xrfa_m.xrfacrtdp_desc,g_xrfa_m.xrfamodid_desc,g_xrfa_m.xrfacnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT axrt460_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xrfa_m_mask_o.* =  g_xrfa_m.*
   CALL axrt460_xrfa_t_mask()
   LET g_xrfa_m_mask_n.* =  g_xrfa_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
 
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL axrt460_show()
   #add-point:modify段show之後 name="modify.after_show"
   #141226-00016#2 By 01727 Add ---(S)---
   CALL s_axrt300_date_chk(g_xrfa_m.xrfasite,g_xrfa_m.xrfadocdt) RETURNING l_success
   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "axr-00300"
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
      RETURN
   END IF
   #141226-00016#2 By 01727 Add ---(S)---
   #20150309--add--str--
   IF g_xrfa_m.xrfastus <> 'N' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00313'
      LET g_errparam.extend = g_xrfa_m.xrfadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #20150309--add--end--
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_xrfadocno_t = g_xrfa_m.xrfadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_xrfa_m.xrfamodid = g_user 
LET g_xrfa_m.xrfamoddt = cl_get_current()
LET g_xrfa_m.xrfamodid_desc = cl_get_username(g_xrfa_m.xrfamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL axrt460_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE xrfa_t SET (xrfamodid,xrfamoddt) = (g_xrfa_m.xrfamodid,g_xrfa_m.xrfamoddt)
          WHERE xrfaent = g_enterprise AND xrfadocno = g_xrfadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_xrfa_m.* = g_xrfa_m_t.*
            CALL axrt460_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_xrfa_m.xrfadocno != g_xrfa_m_t.xrfadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE xrfb_t SET xrfbdocno = g_xrfa_m.xrfadocno
 
          WHERE xrfbent = g_enterprise AND xrfbdocno = g_xrfa_m_t.xrfadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xrfb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrfb_t:",SQLERRMESSAGE 
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
         
         UPDATE xrfc_t
            SET xrfcdocno = g_xrfa_m.xrfadocno
 
          WHERE xrfcent = g_enterprise AND
                xrfcdocno = g_xrfadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xrfc_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrfc_t:",SQLERRMESSAGE 
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
   CALL axrt460_set_act_visible()   
   CALL axrt460_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xrfaent = " ||g_enterprise|| " AND",
                      " xrfadocno = '", g_xrfa_m.xrfadocno, "' "
 
   #填到對應位置
   CALL axrt460_browser_fill("")
 
   CLOSE axrt460_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axrt460_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="axrt460.input" >}
#+ 資料輸入
PRIVATE FUNCTION axrt460_input(p_cmd)
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
   DEFINE  l_pmaa004             LIKE pmaa_t.pmaa004
   DEFINE  ls_wc                 STRING
   DEFINE  l_ooag003             LIKE ooag_t.ooag003
   DEFINE  l_nmbb006             LIKE nmbb_t.nmbb006
   DEFINE  l_nmbb007             LIKE nmbb_t.nmbb007
   DEFINE  l_nmbb008             LIKE nmbb_t.nmbb008
   DEFINE  l_nmbb009             LIKE nmbb_t.nmbb009
   DEFINE  l_nmbb020             LIKE nmbb_t.nmbb020
   DEFINE  l_nmbb021             LIKE nmbb_t.nmbb021
   DEFINE  l_nmbb023             LIKE nmbb_t.nmbb023
   DEFINE  l_nmbb024             LIKE nmbb_t.nmbb024
   DEFINE  l_xrcc108             LIKE xrcc_t.xrcc108
   DEFINE  l_xrcc109             LIKE xrcc_t.xrcc109
   DEFINE  l_xrcc118             LIKE xrcc_t.xrcc118
   DEFINE  l_xrcc119             LIKE xrcc_t.xrcc119
   DEFINE  l_xrcc113             LIKE xrcc_t.xrcc113
   DEFINE  l_s                   LIKE type_t.num5
   DEFINE  l_amt                 LIKE xrcc_t.xrcc108
   DEFINE  l_amt1                LIKE xrcc_t.xrcc108
   DEFINE  l_xrfc104             LIKE xrfc_t.xrfc104
   DEFINE  l_center              LIKE xrfc_t.xrfc001
   DEFINE  l_ooef019             LIKE ooef_t.ooef019
   DEFINE  l_sql                 STRING 
   DEFINE  l_xrde109             LIKE xrde_t.xrde109
   DEFINE  l_xrde119             LIKE xrde_t.xrde119
   DEFINE  l_xrde109_1           LIKE xrde_t.xrde109
   DEFINE  l_xrde119_1           LIKE xrde_t.xrde119
   DEFINE  l_apcc108             LIKE apcc_t.apcc108
   DEFINE  l_apcc118             LIKE apcc_t.apcc118
   DEFINE  l_xrce109             LIKE xrce_t.xrce109
   DEFINE  l_xrce119             LIKE xrce_t.xrce119
   DEFINE  l_rate1               LIKE xrfb_t.xrfb201
   DEFINE  l_rate2               LIKE xrfb_t.xrfb201
   DEFINE  ls_js                 STRING
   DEFINE  lc_param              RECORD
             type                LIKE type_t.chr1,
             apca004             LIKE apca_t.apca004
                              END RECORD
   DEFINE  l_xrfb_flag           LIKE type_t.chr1
   DEFINE  l_xrfc_flag           LIKE type_t.chr1
   DEFINE  l_flag                LIKE type_t.chr1
   DEFINE  l_gzcb002             LIKE gzcb_t.gzcb002
   DEFINE  l_str                 STRING
   #151125-00006#1-add-s
   DEFINE  l_ooba002             LIKE ooba_t.ooba002
   DEFINE  l_dfin0031            LIKE type_t.chr1
   DEFINE  l_dfin0032            LIKE type_t.chr1
   #151125-00006#1-add-e
   DEFINE l_flag1                LIKE type_t.num5      #161104-00046#6 add
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
   DISPLAY BY NAME g_xrfa_m.xrfasite,g_xrfa_m.xrfasite_desc,g_xrfa_m.xrfa001,g_xrfa_m.xrfa001_desc,g_xrfa_m.xrfald, 
       g_xrfa_m.xrfald_desc,g_xrfa_m.xrfacomp,g_xrfa_m.xrfadocno,g_xrfa_m.xrfadocdt,g_xrfa_m.xrfa002, 
       g_xrfa_m.xrfa002_desc,g_xrfa_m.xrfastus,g_xrfa_m.xrfaownid,g_xrfa_m.xrfaownid_desc,g_xrfa_m.xrfaowndp, 
       g_xrfa_m.xrfaowndp_desc,g_xrfa_m.xrfacrtid,g_xrfa_m.xrfacrtid_desc,g_xrfa_m.xrfacrtdp,g_xrfa_m.xrfacrtdp_desc, 
       g_xrfa_m.xrfacrtdt,g_xrfa_m.xrfamodid,g_xrfa_m.xrfamodid_desc,g_xrfa_m.xrfamoddt,g_xrfa_m.xrfacnfid, 
       g_xrfa_m.xrfacnfid_desc,g_xrfa_m.xrfacnfdt
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT xrfbseq,xrfb001,xrfbld,xrfb007,xrfb006,xrfb004,xrfb002,xrfb003,xrfb100, 
       xrfb101,xrfb103,xrfb104,xrfb005,xrfb201,xrfb204 FROM xrfb_t WHERE xrfbent=? AND xrfbdocno=? AND  
       xrfbseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrt460_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT xrfcseq,xrfc001,xrfc002,xrfc006,xrfc013,xrfc003,xrfc004,xrfc005,xrfc011, 
       xrfc100,xrfc101,xrfc103,xrfc104,xrfc201,xrfc204,xrfcseq,xrfc012,xrfc007,xrfc008,xrfc009,xrfc010  
       FROM xrfc_t WHERE xrfcent=? AND xrfcdocno=? AND xrfcseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrt460_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axrt460_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axrt460_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_xrfa_m.xrfasite,g_xrfa_m.xrfa001,g_xrfa_m.xrfald,g_xrfa_m.xrfacomp,g_xrfa_m.xrfadocno, 
       g_xrfa_m.xrfadocdt,g_xrfa_m.xrfa002,g_xrfa_m.xrfastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET l_xrfb_flag = 'N'
   LET l_xrfc_flag = 'N'
   LET g_errshow = 1
   
WHILE TRUE
   LET l_flag = 'N'
   IF l_xrfb_flag = 'Y' THEN 
      CALL s_transaction_begin()
   END IF
   IF l_xrfc_flag = 'Y' THEN 
      CALL s_transaction_begin()
   END IF
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axrt460.input.head" >}
      #單頭段
      INPUT BY NAME g_xrfa_m.xrfasite,g_xrfa_m.xrfa001,g_xrfa_m.xrfald,g_xrfa_m.xrfacomp,g_xrfa_m.xrfadocno, 
          g_xrfa_m.xrfadocdt,g_xrfa_m.xrfa002,g_xrfa_m.xrfastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN axrt460_cl USING g_enterprise,g_xrfa_m.xrfadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axrt460_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axrt460_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL axrt460_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            IF l_xrfb_flag = 'Y' THEN 
               LET l_xrfb_flag = 'N'
               NEXT FIELD xrfbseq
            END IF
            IF l_xrfc_flag = 'Y' THEN 
               LET l_xrfc_flag = 'N'
               NEXT FIELD xrfcseq
            END IF
            #end add-point
            CALL axrt460_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfasite
            
            #add-point:AFTER FIELD xrfasite name="input.a.xrfasite"
            CALL axrt460_ref('xrfasite')
            IF NOT cl_null(g_xrfa_m.xrfasite) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfa_m.xrfasite != g_xrfa_m_t.xrfasite OR g_xrfa_m_t.xrfasite IS NULL )) THEN #170119-00024#7 mark
               IF g_xrfa_m.xrfasite != g_xrfa_m_o.xrfasite OR cl_null(g_xrfa_m_o.xrfasite ) THEN #170119-00024#7 add
                  #取得帳務組織下所屬成員
                  CALL s_fin_account_center_sons_query('3',g_xrfa_m.xrfasite,g_xrfa_m.xrfadocdt,'1')
                  CALL s_fin_account_center_with_ld_chk(g_xrfa_m.xrfasite,g_xrfa_m.xrfald,g_user,'3','N','',g_xrfa_m.xrfadocdt) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xrfa_m.xrfasite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_xrfa_m.xrfasite = g_xrfa_m_t.xrfasite #170119-00024#7 mark
                     LET g_xrfa_m.xrfasite = g_xrfa_m_o.xrfasite #170119-00024#7 add
                     CALL axrt460_ref('xrfasite')
                     NEXT FIELD CURRENT
                  END IF
                  LET l_cnt=0
                  SELECT COUNT(*) INTO l_cnt FROM ooed_t 
                   WHERE ooedent=g_enterprise AND ooed002=g_xrfa_m.xrfasite
                     AND ooed006<=g_xrfa_m.xrfadocdt
                     AND (ooed007 IS NULL OR ooed007 >= g_xrfa_m.xrfadocdt)
                     AND ooed002 <> 'ALL'
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00352'
                     LET g_errparam.extend = g_xrfa_m.xrfasite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_xrfa_m.xrfasite = g_xrfa_m_t.xrfasite #170119-00024#7 mark
                     LET g_xrfa_m.xrfasite = g_xrfa_m_o.xrfasite #170119-00024#7 add
                     CALL axrt460_ref('xrfasite')
                     NEXT FIELD CURRENT
                  END IF
                  #141226-00016#2 By 01727 Add ---(S)---
                  CALL s_axrt300_date_chk(g_xrfa_m.xrfasite,g_xrfa_m.xrfadocdt) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "axr-00299"
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err() 
                     #LET g_xrfa_m.xrfasite = g_xrfa_m_t.xrfasite #170119-00024#7 mark
                     #LET g_xrfa_m.xrfald = g_xrfa_m_t.xrfald     #170119-00024#7 mark
                     LET g_xrfa_m.xrfasite = g_xrfa_m_o.xrfasite #170119-00024#7 add
                     LET g_xrfa_m.xrfald = g_xrfa_m_o.xrfald     #170119-00024#7 add
                     NEXT FIELD CURRENT
                  END IF
                  #141226-00016#2 By 01727 Add ---(E)---
               END IF
            END IF
            LET g_xrfa_m_o.* = g_xrfa_m.* #170119-00024#7
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfasite
            #add-point:BEFORE FIELD xrfasite name="input.b.xrfasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfasite
            #add-point:ON CHANGE xrfasite name="input.g.xrfasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfa001
            
            #add-point:AFTER FIELD xrfa001 name="input.a.xrfa001"
            CALL axrt460_ref('xrfa001')
            IF NOT cl_null(g_xrfa_m.xrfa001) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfa_m.xrfa001 != g_xrfa_m_t.xrfa001 OR g_xrfa_m_t.xrfa001 IS NULL )) THEN #170119-00024#7 mark
               IF g_xrfa_m.xrfa001 != g_xrfa_m_o.xrfa001 OR cl_null(g_xrfa_m_o.xrfa001) THEN #170119-00024#7 add
                  #資料存在性、有效性檢查
                  CALL s_employee_chk(g_xrfa_m.xrfa001) RETURNING l_success
                  IF NOT l_success THEN
                     #LET g_xrfa_m.xrfa001 = g_xrfa_m_t.xrfa001 #170119-00024#7 mark
                     LET g_xrfa_m.xrfa001 = g_xrfa_m_o.xrfa001 #170119-00024#7 add
                     CALL axrt460_ref('xrfa001')
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF cl_null(g_xrfa_m.xrfa001) AND cl_null(g_xrfa_m.xrfald) THEN
               LET g_xrfa_m.xrfa001 = g_user
            END IF
            CALL axrt460_ref('xrfa001')
            LET g_xrfa_m_o.* = g_xrfa_m.* #170119-00024#7 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfa001
            #add-point:BEFORE FIELD xrfa001 name="input.b.xrfa001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfa001
            #add-point:ON CHANGE xrfa001 name="input.g.xrfa001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfald
            
            #add-point:AFTER FIELD xrfald name="input.a.xrfald"
            CALL axrt460_ref('xrfald')
            #此段落由子樣板a05產生
            
            IF NOT cl_null(g_xrfa_m.xrfald) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfa_m.xrfald != g_xrfa_m_t.xrfald OR g_xrfa_m_t.xrfald IS NULL )) THEN #170119-00024#7 mark
               IF g_xrfa_m.xrfald != g_xrfa_m_o.xrfald OR cl_null(g_xrfa_m_o.xrfald) THEN #170119-00024#7 add
                  #取得帳務組織下所屬成員
                  CALL s_fin_account_center_sons_query('3',g_xrfa_m.xrfasite,g_xrfa_m.xrfadocdt,'1')
                  CALL s_fin_account_center_with_ld_chk(g_xrfa_m.xrfasite,g_xrfa_m.xrfald,g_user,'3','N','',g_xrfa_m.xrfadocdt) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xrfa_m.xrfald
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_xrfa_m.xrfald = g_xrfa_m_t.xrfald #170119-00024#7 mark
                     LET g_xrfa_m.xrfald = g_xrfa_m_o.xrfald #170119-00024#7 add
                     CALL axrt460_ref('xrfald')
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            SELECT glaacomp,glaa001,glaa024,glaa025
              INTO g_glaa.glaacomp,g_glaa.glaa001,g_glaa.glaa024,g_glaa.glaa025 
              FROM glaa_t 
             WHERE glaaent=g_enterprise AND glaald=g_xrfa_m.xrfald
            LET g_xrfa_m.xrfacomp=g_glaa.glaacomp
           #161111-00049#9 Add  ---(S)---
            CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_glaa.glaacomp) RETURNING g_sub_success,g_sql_ctrl
           #161111-00049#9 Add  ---(E)---
           LET g_xrfa_m_o.* = g_xrfa_m.* #170119-00024#7 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfald
            #add-point:BEFORE FIELD xrfald name="input.b.xrfald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfald
            #add-point:ON CHANGE xrfald name="input.g.xrfald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfacomp
            #add-point:BEFORE FIELD xrfacomp name="input.b.xrfacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfacomp
            
            #add-point:AFTER FIELD xrfacomp name="input.a.xrfacomp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfacomp
            #add-point:ON CHANGE xrfacomp name="input.g.xrfacomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfadocno
            #add-point:BEFORE FIELD xrfadocno name="input.b.xrfadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfadocno
            
            #add-point:AFTER FIELD xrfadocno name="input.a.xrfadocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xrfa_m.xrfadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xrfa_m.xrfadocno != g_xrfadocno_t  )) THEN  
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrfa_t WHERE "||"xrfaent = '" ||g_enterprise|| "' AND "||"xrfadocno = '"||g_xrfa_m.xrfadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_xrfa_m.xrfadocno) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfa_m.xrfadocno != g_xrfa_m_t.xrfadocno OR g_xrfa_m_t.xrfadocno IS NULL )) THEN #170119-00024#7 mark
               IF g_xrfa_m.xrfadocno != g_xrfa_m_o.xrfadocno OR cl_null(g_xrfa_m_o.xrfadocno)THEN #170119-00024#7 add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_glaa.glaa024
                  LET g_chkparam.arg2 = g_xrfa_m.xrfadocno
                  IF NOT cl_chk_exist("v_oobx001_1") THEN
                     #LET g_xrfa_m.xrfadocno = '' #170119-00024#7  mark
                     LET g_xrfa_m.xrfadocno = g_xrfa_m_o.xrfadocno #170119-00024#7 add
                     NEXT FIELD CURRENT
                  END IF
                  #161104-00046#6 --s add
                  CALL s_control_chk_doc('1',g_xrfa_m.xrfadocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag1
                  IF g_sub_success AND l_flag1 THEN             
                  ELSE
                     #LET g_xrfa_m.xrfadocno = '' #170119-00024#7  mark
                     LET g_xrfa_m.xrfadocno = g_xrfa_m_o.xrfadocno #170119-00024#7 add
                     NEXT FIELD CURRENT      
                  END IF
                  CALL s_aooi200_fin_get_slip(g_xrfa_m.xrfadocno) RETURNING g_sub_success,g_ar_slip
                  #刪除單別預設temptable
                  DELETE FROM s_aooi200def1
                  #以目前畫面資訊新增temp資料   #請勿調整.*
                  INSERT INTO s_aooi200def1 VALUES(g_xrfa_m.*)
                  #依單別預設取用資訊
                  CALL s_aooi200def_get('','',g_xrfa_m.xrfasite,'2',g_ar_slip,'','',g_xrfa_m.xrfald)
                  #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
                  SELECT * INTO g_xrfa_m.* FROM s_aooi200def1               
                  #161104-00046#6 --e add                   
               END IF
            END IF
            LET g_xrfa_m_o.* = g_xrfa_m.* #170119-00024#7 add

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfadocno
            #add-point:ON CHANGE xrfadocno name="input.g.xrfadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfadocdt
            #add-point:BEFORE FIELD xrfadocdt name="input.b.xrfadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfadocdt
            
            #add-point:AFTER FIELD xrfadocdt name="input.a.xrfadocdt"
            #141226-00016#2 By 01727 Add  ---(S)---
            IF NOT cl_null(g_xrfa_m.xrfadocdt) THEN
               IF g_xrfa_m.xrfadocdt != g_xrfa_m_o.xrfadocdt OR cl_null(g_xrfa_m_o.xrfadocdt) THEN #170119-00024#7 add
                  CALL s_axrt300_date_chk(g_xrfa_m.xrfasite,g_xrfa_m.xrfadocdt) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "axr-00299"
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     #LET g_xrfa_m.xrfadocdt = g_xrfa_m_t.xrfadocdt  #170119-00024#7 mark
                     LET g_xrfa_m.xrfadocdt = g_xrfa_m_o.xrfadocdt #170119-00024#7 add
                     NEXT FIELD CURRENT 
                  END IF
               END IF  #170119-00024#7 add  
            END IF
            #141226-00016#2 By 01727 Add  ---(S)---
            LET g_xrfa_m_o.* = g_xrfa_m.* #170119-00024#7 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfadocdt
            #add-point:ON CHANGE xrfadocdt name="input.g.xrfadocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfa002
            
            #add-point:AFTER FIELD xrfa002 name="input.a.xrfa002"
            CALL axrt460_ref('xrfa002')
            IF NOT cl_null(g_xrfa_m.xrfa002) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfa_m.xrfa002 != g_xrfa_m_t.xrfa002 OR g_xrfa_m_t.xrfa002 IS NULL )) THEN #170119-00024#7 mark
               IF g_xrfa_m.xrfa002 != g_xrfa_m_o.xrfa002 OR cl_null(g_xrfa_m_o.xrfa002) THEN #170119-00024#7 add
                  #資料存在性、有效性檢查
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrfa_m.xrfa002
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"
                  #160318-00025#25  by 07900 --add-end
                  IF NOT cl_chk_exist("v_pmaa001_7") THEN
                     #LET g_xrfa_m.xrfa002 = g_xrfa_m_t.xrfa002  #170119-00024#7 mark
                     LET g_xrfa_m.xrfa002 = g_xrfa_m_o.xrfa002 #170119-00024#7 add
                     CALL axrt460_ref('xrfa002')
                     NEXT FIELD CURRENT
                  ELSE
                     SELECT pmaa004 INTO l_pmaa004 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_xrfa_m.xrfa002
                     IF l_pmaa004 = '2' THEN  #一次性交易對象
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'axr-00189'
                        LET g_errparam.extend = g_xrfa_m.xrfa002
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                        #LET g_xrfa_m.xrfa002 = g_xrfa_m_t.xrfa002 #170119-00024#7 mark
                        LET g_xrfa_m.xrfa002 = g_xrfa_m_o.xrfa002 #170119-00024#7 add
                        CALL axrt460_ref('xrfa002')
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #161017-00011#2--add--str--
                  IF NOT s_control_check_customer(g_xrfa_m.xrfa002,'2',g_site,g_user,g_dept,'') THEN
                     #LET g_xrfa_m.xrfa002 = g_xrfa_m_t.xrfa002 #170119-00024#7 mark
                     LET g_xrfa_m.xrfa002 = g_xrfa_m_o.xrfa002 #170119-00024#7 add
                     CALL axrt460_ref('xrfa002')
                     NEXT FIELD CURRENT
		    	      END IF
		    	      #161017-00011#2--add--end
               END IF
            END IF
            LET g_xrfa_m_o.* = g_xrfa_m.* #170119-00024#7 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfa002
            #add-point:BEFORE FIELD xrfa002 name="input.b.xrfa002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfa002
            #add-point:ON CHANGE xrfa002 name="input.g.xrfa002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfastus
            #add-point:BEFORE FIELD xrfastus name="input.b.xrfastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfastus
            
            #add-point:AFTER FIELD xrfastus name="input.a.xrfastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfastus
            #add-point:ON CHANGE xrfastus name="input.g.xrfastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xrfasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfasite
            #add-point:ON ACTION controlp INFIELD xrfasite name="input.c.xrfasite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfa_m.xrfasite             #給予default值
            LET g_qryparam.default2 = "" #g_xrfa_m.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #
            IF cl_null(g_xrfa_m.xrfadocdt) THEN
               LET g_xrfa_m.xrfadocdt=g_today 
            END IF
            LET g_qryparam.where = "     ooef201 = 'Y' ",
                                   " AND ooefstus = 'Y' ", #161006-00005#39  add
                                   " AND ooef001 IN (SELECT DISTINCT ooed002 FROM ooed_t",
                                   "                  WHERE ooedent=",g_enterprise," AND ooed001='3'",
                                   "                    AND ooed006<='",g_xrfa_m.xrfadocdt,"'",
                                   "                    AND (ooed007>='",g_xrfa_m.xrfadocdt,"' OR ooed007 IS NULL)",
                                   "                 )"
            
            #CALL q_ooef001()                                #呼叫開窗 #161006-00005#39  mark
            CALL q_ooef001_46()                                       #161006-00005#39  add
            LET g_xrfa_m.xrfasite = g_qryparam.return1              
            #LET g_xrfa_m.ooefl003 = g_qryparam.return2 
            DISPLAY g_xrfa_m.xrfasite TO xrfasite              #
            #DISPLAY g_xrfa_m.ooefl003 TO ooefl003 #說明(簡稱)
            CALL axrt460_ref('xrfasite')
            NEXT FIELD xrfasite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xrfa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfa001
            #add-point:ON ACTION controlp INFIELD xrfa001 name="input.c.xrfa001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfa_m.xrfa001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_xrfa_m.xrfa001 = g_qryparam.return1              

            DISPLAY g_xrfa_m.xrfa001 TO xrfa001              #
            CALL axrt460_ref('xrfa001')
            NEXT FIELD xrfa001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xrfald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfald
            #add-point:ON ACTION controlp INFIELD xrfald name="input.c.xrfald"
               
            #取得帳務組織下所屬成員
            CALL s_fin_account_center_sons_query('3',g_xrfa_m.xrfasite,g_xrfa_m.xrfadocdt,'1')
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING ls_wc
            #將取回的字串轉換為SQL條件
            CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfa_m.xrfald             #給予default值
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""
            #給予arg
            SELECT ooag003 INTO l_ooag003 FROM ooag_t WHERE ooagent = g_enterprise
               AND ooag001 = g_xrfa_m.xrfa001
            LET g_qryparam.arg1 = g_xrfa_m.xrfa001
            LET g_qryparam.arg2 = l_ooag003
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xrfa_m.xrfald = g_qryparam.return1              

            DISPLAY g_xrfa_m.xrfald TO xrfald              #
            CALL axrt460_ref('xrfald')
            NEXT FIELD xrfald                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xrfacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfacomp
            #add-point:ON ACTION controlp INFIELD xrfacomp name="input.c.xrfacomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrfadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfadocno
            #add-point:ON ACTION controlp INFIELD xrfadocno name="input.c.xrfadocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfa_m.xrfadocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_glaa.glaa024
            #LET g_qryparam.arg2 = "axrt460"     #160705-00042#6 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#6 160711 by sakura add
            #161104-00046#6 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF
            #161104-00046#6 --e add            
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_xrfa_m.xrfadocno = g_qryparam.return1              

            DISPLAY g_xrfa_m.xrfadocno TO xrfadocno              #

            NEXT FIELD xrfadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xrfadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfadocdt
            #add-point:ON ACTION controlp INFIELD xrfadocdt name="input.c.xrfadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrfa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfa002
            #add-point:ON ACTION controlp INFIELD xrfa002 name="input.c.xrfa002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfa_m.xrfa002             #給予default值
           # LET g_qryparam.where = " pmaa002 IN ('2','3')"    #160913-00017#10  mark  
            # CALL q_pmaa001()   #160913-00017#10  mark                  #呼叫開窗
            #160913-00017#10--ADD(S)--
            LET g_qryparam.arg1="('2','3')"
            #161017-00011#2--add--str--
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #161017-00011#2--add--end
            CALL q_pmaa001_1()
            #160913-00017#10--ADD(E)-  

            LET g_xrfa_m.xrfa002 = g_qryparam.return1              

            DISPLAY g_xrfa_m.xrfa002 TO xrfa002              #
            CALL axrt460_ref('xrfa002')
            NEXT FIELD xrfa002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xrfastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfastus
            #add-point:ON ACTION controlp INFIELD xrfastus name="input.c.xrfastus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xrfa_m.xrfadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #单据编号
               CALL s_aooi200_fin_gen_docno(g_xrfa_m.xrfald,'','',g_xrfa_m.xrfadocno,g_xrfa_m.xrfadocdt,g_prog)
               RETURNING l_success,g_xrfa_m.xrfadocno
               IF l_success  = 0  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_xrfa_m.xrfadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD xrfadocno
               END IF 
               DISPLAY BY NAME g_xrfa_m.xrfadocno
               #end add-point
               
               INSERT INTO xrfa_t (xrfaent,xrfasite,xrfa001,xrfald,xrfacomp,xrfadocno,xrfadocdt,xrfa002, 
                   xrfastus,xrfaownid,xrfaowndp,xrfacrtid,xrfacrtdp,xrfacrtdt,xrfamodid,xrfamoddt,xrfacnfid, 
                   xrfacnfdt)
               VALUES (g_enterprise,g_xrfa_m.xrfasite,g_xrfa_m.xrfa001,g_xrfa_m.xrfald,g_xrfa_m.xrfacomp, 
                   g_xrfa_m.xrfadocno,g_xrfa_m.xrfadocdt,g_xrfa_m.xrfa002,g_xrfa_m.xrfastus,g_xrfa_m.xrfaownid, 
                   g_xrfa_m.xrfaowndp,g_xrfa_m.xrfacrtid,g_xrfa_m.xrfacrtdp,g_xrfa_m.xrfacrtdt,g_xrfa_m.xrfamodid, 
                   g_xrfa_m.xrfamoddt,g_xrfa_m.xrfacnfid,g_xrfa_m.xrfacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_xrfa_m:",SQLERRMESSAGE 
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
                  CALL axrt460_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL axrt460_b_fill()
                  CALL axrt460_b_fill2('0')
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
               CALL axrt460_xrfa_t_mask_restore('restore_mask_o')
               
               UPDATE xrfa_t SET (xrfasite,xrfa001,xrfald,xrfacomp,xrfadocno,xrfadocdt,xrfa002,xrfastus, 
                   xrfaownid,xrfaowndp,xrfacrtid,xrfacrtdp,xrfacrtdt,xrfamodid,xrfamoddt,xrfacnfid,xrfacnfdt) = (g_xrfa_m.xrfasite, 
                   g_xrfa_m.xrfa001,g_xrfa_m.xrfald,g_xrfa_m.xrfacomp,g_xrfa_m.xrfadocno,g_xrfa_m.xrfadocdt, 
                   g_xrfa_m.xrfa002,g_xrfa_m.xrfastus,g_xrfa_m.xrfaownid,g_xrfa_m.xrfaowndp,g_xrfa_m.xrfacrtid, 
                   g_xrfa_m.xrfacrtdp,g_xrfa_m.xrfacrtdt,g_xrfa_m.xrfamodid,g_xrfa_m.xrfamoddt,g_xrfa_m.xrfacnfid, 
                   g_xrfa_m.xrfacnfdt)
                WHERE xrfaent = g_enterprise AND xrfadocno = g_xrfadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xrfa_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL axrt460_xrfa_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_xrfa_m_t)
               LET g_log2 = util.JSON.stringify(g_xrfa_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_xrfadocno_t = g_xrfa_m.xrfadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="axrt460.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_xrfb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xrfb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axrt460_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_xrfb_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
 
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            LET g_aw = 's_detail2'
            LET l_xrfc_flag = 'N'
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
            OPEN axrt460_cl USING g_enterprise,g_xrfa_m.xrfadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axrt460_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axrt460_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xrfb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xrfb_d[l_ac].xrfbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xrfb_d_t.* = g_xrfb_d[l_ac].*  #BACKUP
               LET g_xrfb_d_o.* = g_xrfb_d[l_ac].*  #BACKUP
               CALL axrt460_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL axrt460_set_no_entry_b(l_cmd)
               IF NOT axrt460_lock_b("xrfb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axrt460_bcl INTO g_xrfb_d[l_ac].xrfbseq,g_xrfb_d[l_ac].xrfb001,g_xrfb_d[l_ac].xrfbld, 
                      g_xrfb_d[l_ac].xrfb007,g_xrfb_d[l_ac].xrfb006,g_xrfb_d[l_ac].xrfb004,g_xrfb_d[l_ac].xrfb002, 
                      g_xrfb_d[l_ac].xrfb003,g_xrfb_d[l_ac].xrfb100,g_xrfb_d[l_ac].xrfb101,g_xrfb_d[l_ac].xrfb103, 
                      g_xrfb_d[l_ac].xrfb104,g_xrfb_d[l_ac].xrfb005,g_xrfb_d[l_ac].xrfb201,g_xrfb_d[l_ac].xrfb204 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xrfb_d_t.xrfbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xrfb_d_mask_o[l_ac].* =  g_xrfb_d[l_ac].*
                  CALL axrt460_xrfb_t_mask()
                  LET g_xrfb_d_mask_n[l_ac].* =  g_xrfb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axrt460_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            IF g_xrfb_d[l_ac].xrfb006 = '10' AND g_xrfb_d[l_ac].xrfb004 <> '90'THEN
               CALL cl_set_comp_required('xrfb002,xrfb003',TRUE)
            ELSE
               CALL cl_set_comp_required('xrfb002,xrfb003',FALSE)
            END IF
            
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
            INITIALIZE g_xrfb_d[l_ac].* TO NULL 
            INITIALIZE g_xrfb_d_t.* TO NULL 
            INITIALIZE g_xrfb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_xrfb_d[l_ac].xrfb103 = "0"
            LET g_xrfb_d[l_ac].xrfb104 = "0"
            LET g_xrfb_d[l_ac].xrfb204 = "0"
            #end add-point
            LET g_xrfb_d_t.* = g_xrfb_d[l_ac].*     #新輸入資料
            LET g_xrfb_d_o.* = g_xrfb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axrt460_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL axrt460_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xrfb_d[li_reproduce_target].* = g_xrfb_d[li_reproduce].*
 
               LET g_xrfb_d[li_reproduce_target].xrfbseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            IF cl_null(g_xrfb_d[l_ac].xrfbseq) THEN 
               SELECT MAX(xrfbseq) INTO g_xrfb_d[l_ac].xrfbseq
                 FROM xrfb_t
                WHERE xrfbent = g_enterprise 
                  AND xrfbdocno = g_xrfa_m.xrfadocno
               IF cl_null(g_xrfb_d[l_ac].xrfbseq) THEN 
                  LET g_xrfb_d[l_ac].xrfbseq = 1
               ELSE
                  LET g_xrfb_d[l_ac].xrfbseq = g_xrfb_d[l_ac].xrfbseq +1               
               END IF
            END IF
            LET g_xrfb_d[l_ac].xrfb001=g_xrfa_m.xrfacomp
            LET g_xrfb_d[l_ac].xrfb001_desc=g_xrfb_d[l_ac].xrfb001
            CALL axrt460_ref('xrfb001')
            LET g_xrfb_d[l_ac].xrfbld=g_xrfa_m.xrfald
            
            LET g_xrfb_d[l_ac].xrfb006='10'
            LET g_xrfb_d[l_ac].xrfb004='90'
            LET g_xrfb_d[l_ac].xrfb007='D' #借方 #160818-00011#1 add
            CALL cl_set_comp_required('xrfb002,xrfb003',FALSE)
            
            SELECT glaa001 INTO g_xrfb_d[l_ac].xrfb100 FROM glaa_t 
            WHERE glaaent=g_enterprise AND glaald=g_xrfb_d[l_ac].xrfbld
            LET g_xrfb_d[l_ac].xrfb101=1
            
#            CALL cl_set_comp_entry("xrfb001_desc",TRUE) #160818-00011#1 mark
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
            SELECT COUNT(1) INTO l_count FROM xrfb_t 
             WHERE xrfbent = g_enterprise AND xrfbdocno = g_xrfa_m.xrfadocno
 
               AND xrfbseq = g_xrfb_d[l_ac].xrfbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrfa_m.xrfadocno
               LET gs_keys[2] = g_xrfb_d[g_detail_idx].xrfbseq
               CALL axrt460_insert_b('xrfb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_xrfb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrfb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axrt460_b_fill()
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
               LET gs_keys[01] = g_xrfa_m.xrfadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_xrfb_d_t.xrfbseq
 
            
               #刪除同層單身
               IF NOT axrt460_delete_b('xrfb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axrt460_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axrt460_key_delete_b(gs_keys,'xrfb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axrt460_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE axrt460_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_xrfb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xrfb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfbseq
            #add-point:BEFORE FIELD xrfbseq name="input.b.page1.xrfbseq"
            IF cl_null(g_xrfb_d[l_ac].xrfbseq) THEN 
               SELECT MAX(xrfbseq) INTO g_xrfb_d[l_ac].xrfbseq
                 FROM xrfb_t
                WHERE xrfbent = g_enterprise 
                  AND xrfbdocno = g_xrfa_m.xrfadocno
               IF cl_null(g_xrfb_d[l_ac].xrfbseq) THEN 
                  LET g_xrfb_d[l_ac].xrfbseq = 1
               ELSE
                  LET g_xrfb_d[l_ac].xrfbseq = g_xrfb_d[l_ac].xrfbseq +1               
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfbseq
            
            #add-point:AFTER FIELD xrfbseq name="input.a.page1.xrfbseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xrfa_m.xrfadocno IS NOT NULL  AND g_xrfb_d[g_detail_idx].xrfbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xrfa_m.xrfadocno != g_xrfadocno_t OR g_xrfb_d[g_detail_idx].xrfbseq != g_xrfb_d_t.xrfbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrfb_t WHERE "||"xrfbent = '" ||g_enterprise|| "' AND "||"xrfbdocno = '"||g_xrfa_m.xrfadocno||"' AND "|| "xrfbseq = '"||g_xrfb_d[g_detail_idx].xrfbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfbseq
            #add-point:ON CHANGE xrfbseq name="input.g.page1.xrfbseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb001
            #add-point:BEFORE FIELD xrfb001 name="input.b.page1.xrfb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb001
            
            #add-point:AFTER FIELD xrfb001 name="input.a.page1.xrfb001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb001
            #add-point:ON CHANGE xrfb001 name="input.g.page1.xrfb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb001_desc
            #add-point:BEFORE FIELD xrfb001_desc name="input.b.page1.xrfb001_desc"
            LET g_xrfb_d[l_ac].xrfb001_desc=g_xrfb_d[l_ac].xrfb001
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb001_desc
            
            #add-point:AFTER FIELD xrfb001_desc name="input.a.page1.xrfb001_desc"
            IF NOT cl_null(g_xrfb_d[l_ac].xrfb001_desc) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfb_d[l_ac].xrfb001_desc != g_xrfb_d_t.xrfb001 OR g_xrfb_d_t.xrfb001 IS NULL )) THEN
                  IF NOT ap_chk_isExist(g_xrfb_d[l_ac].xrfb001_desc,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ?   ",'aoo-00090',1) THEN 
                     LET g_xrfb_d[l_ac].xrfb001_desc = g_xrfb_d_t.xrfb001_desc
                     NEXT FIELD CURRENT
                  END IF
#                  IF NOT ap_chk_isExist(g_xrfb_d[l_ac].xrfb001_desc,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ?  AND ooefstus ='Y' ",'aoo-00091',1) THEN   #160318-00005#54  mark
                  IF NOT ap_chk_isExist(g_xrfb_d[l_ac].xrfb001_desc,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ?  AND ooefstus ='Y' ",'sub-01302','aooi100') THEN    #160318-00005#54  add
                     LET g_xrfb_d[l_ac].xrfb001_desc = g_xrfb_d_t.xrfb001_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_isExist(g_xrfb_d[l_ac].xrfb001_desc,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ?  AND ooefstus ='Y' AND ooef003 = 'Y'",'aap-00011',1) THEN 
                     LET g_xrfb_d[l_ac].xrfb001_desc = g_xrfb_d_t.xrfb001_desc
                     NEXT FIELD CURRENT
                  END IF 
                  
                  #判斷輸入的法人是否在單頭帳務中心下
                  LET l_sql = " SELECT DISTINCT ooed002 FROM ooed_t ",
                              "  WHERE ooedent = ",g_enterprise," ",
                              "    AND ooed001 = '3' ",
                              "    AND ooed004 = '",g_xrfb_d[l_ac].xrfb001_desc,"' ",
                              "    AND ooed006 <= '",g_xrfa_m.xrfadocdt,"' ",
                              "    AND (ooed007 IS NULL OR ooed007 >= '",g_xrfa_m.xrfadocdt,"') ",
                              "    AND ooed002 <> 'ALL' "
                  PREPARE axrt460_sel_ooed_pr1 FROM l_sql
                  DECLARE axrt460_sel_ooed_cs1 CURSOR FOR axrt460_sel_ooed_pr1
                  LET l_success = FALSE
                  FOREACH axrt460_sel_ooed_cs1 INTO l_center
                     IF l_center = g_xrfa_m.xrfasite THEN
                        LET l_success = TRUE
                        EXIT FOREACH
                     END IF
                  END FOREACH
                  IF l_success=FALSE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xrfb_d[l_ac].xrfb001_desc
                     LET g_errparam.code   = 'axr-00194' 
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                     LET g_xrfb_d[l_ac].xrfb001_desc = g_xrfb_d_t.xrfb001_desc
                     NEXT FIELD CURRENT
                  END IF
                  #輸入法人=單頭法人時，默認帶出帳套=單頭帳套，反之，抓取該法人主張套
                  IF g_xrfb_d[l_ac].xrfb001_desc = g_xrfa_m.xrfacomp THEN
                     LET g_xrfb_d[l_ac].xrfbld = g_xrfa_m.xrfald
                  ELSE
                     SELECT glaald INTO g_xrfb_d[l_ac].xrfbld FROM glaa_t
                      WHERE glaaent=g_enterprise AND glaacomp=g_xrfb_d[l_ac].xrfb001_desc AND glaa014='Y'
                  END IF
                  SELECT glaa001 INTO g_xrfb_d[l_ac].xrfb100 FROM glaa_t 
                  WHERE glaaent=g_enterprise AND glaald=g_xrfb_d[l_ac].xrfbld
                  LET g_xrfb_d[l_ac].xrfb101=1
                  DISPLAY BY NAME g_xrfb_d[l_ac].xrfb100,g_xrfb_d[l_ac].xrfb101
               END IF
            END IF
            LET g_xrfb_d[l_ac].xrfb001=g_xrfb_d[l_ac].xrfb001_desc
            CALL axrt460_ref('xrfb001')
            
            #当来源组织不等于单头法人时，类型不等于10 收款
            IF g_xrfb_d[l_ac].xrfb001 <> g_xrfa_m.xrfacomp THEN
               IF g_xrfb_d[l_ac].xrfb006 = '10' THEN
                  LET g_xrfb_d[l_ac].xrfb006 = ''
                  LET g_xrfb_d[l_ac].xrfb004 = ''
                  LET g_xrfb_d[l_ac].xrfb002 = ''
                  LET g_xrfb_d[l_ac].xrfb003 = ''
                  LET g_xrfb_d[l_ac].xrfb100 = ''
                  LET g_xrfb_d[l_ac].xrfb101 = ''
                  LET g_xrfb_d[l_ac].xrfb103 = 0
                  LET g_xrfb_d[l_ac].xrfb104 = 0
                  LET g_xrfb_d[l_ac].xrfb201 = ''
                  LET g_xrfb_d[l_ac].xrfb204 = 0
                  CALL cl_set_comp_entry('xrfb001_desc,xrfb100,xrfb101',TRUE)
                  CALL cl_set_comp_entry('xrfb004,xrfb002,xrfb003',FALSE)
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb001_desc
            #add-point:ON CHANGE xrfb001_desc name="input.g.page1.xrfb001_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfbld
            #add-point:BEFORE FIELD xrfbld name="input.b.page1.xrfbld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfbld
            
            #add-point:AFTER FIELD xrfbld name="input.a.page1.xrfbld"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfbld
            #add-point:ON CHANGE xrfbld name="input.g.page1.xrfbld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb007
            #add-point:BEFORE FIELD xrfb007 name="input.b.page1.xrfb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb007
            
            #add-point:AFTER FIELD xrfb007 name="input.a.page1.xrfb007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb007
            #add-point:ON CHANGE xrfb007 name="input.g.page1.xrfb007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb006
            #add-point:BEFORE FIELD xrfb006 name="input.b.page1.xrfb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb006
            
            #add-point:AFTER FIELD xrfb006 name="input.a.page1.xrfb006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb006
            #add-point:ON CHANGE xrfb006 name="input.g.page1.xrfb006"
            IF NOT cl_null(g_xrfb_d[l_ac].xrfb006) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfb_d[l_ac].xrfb006 != g_xrfb_d_t.xrfb006 OR g_xrfb_d_t.xrfb006 IS NULL )) THEN 
                  IF g_xrfb_d[l_ac].xrfb006='10' THEN
                     IF g_xrfb_d[l_ac].xrfb001 <> g_xrfa_m.xrfacomp THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = g_xrfb_d[l_ac].xrfb006 
                        LET g_errparam.code   = "axr-00353" 
                        LET g_errparam.popup  = FALSE 
                        CALL cl_err()
                        LET g_xrfb_d[l_ac].xrfb006 = g_xrfb_d_t.xrfb006
                        NEXT FIELD CURRENT
                     END IF
                     LET g_xrfb_d[l_ac].xrfb001=g_xrfa_m.xrfacomp
                     LET g_xrfb_d[l_ac].xrfb001_desc=g_xrfb_d[l_ac].xrfb001
                     CALL axrt460_ref('xrfb001')
                     LET g_xrfb_d[l_ac].xrfbld=g_xrfa_m.xrfald
                     CALL cl_set_comp_entry('xrfb001_desc,xrfb100,xrfb101',FALSE)
                     CALL cl_set_comp_entry('xrfb004,xrfb002,xrfb003',TRUE)
                     LET g_xrfb_d[l_ac].xrfb004='90'
                  ELSE
#                     CALL cl_set_comp_entry('xrfb001_desc,xrfb100,xrfb101',TRUE) #160818-00011#1 mark
                     CALL cl_set_comp_entry('xrfb100,xrfb101',TRUE) #160818-00011#1 add
                     CALL cl_set_comp_entry('xrfb004,xrfb002,xrfb003',FALSE)
                     LET g_xrfb_d[l_ac].xrfb004=''
                     LET g_xrfb_d[l_ac].xrfb002=''
                     LET g_xrfb_d[l_ac].xrfb003=''
                     SELECT glaa001 INTO g_xrfb_d[l_ac].xrfb100 FROM glaa_t 
                      WHERE glaaent=g_enterprise AND glaald=g_xrfb_d[l_ac].xrfbld
                     LET g_xrfb_d[l_ac].xrfb101=1
                     LET g_xrfb_d[l_ac].xrfb103=0
                     LET g_xrfb_d[l_ac].xrfb104=0
                     LET g_xrfb_d[l_ac].xrfb201=1
                     LET g_xrfb_d[l_ac].xrfb204=0
                  END IF
                  IF g_xrfb_d[l_ac].xrfb004 = '90' THEN 
                     CALL cl_set_comp_required('xrfb002,xrfb003',FALSE)
                  ELSE
                     CALL cl_set_comp_required('xrfb002,xrfb003',TRUE)
                  END IF
                  SELECT gzcb003 INTO g_xrfb_d[l_ac].xrfb007 FROM gzcb_t WHERE gzcb001='8306' AND gzcb002=g_xrfb_d[l_ac].xrfb006
               END IF
            ELSE
#                CALL cl_set_comp_entry('xrfb001_desc',TRUE) #160818-00011#1 mark
                CALL cl_set_comp_required('xrfb002,xrfb003',FALSE)
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb004
            #add-point:BEFORE FIELD xrfb004 name="input.b.page1.xrfb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb004
            
            #add-point:AFTER FIELD xrfb004 name="input.a.page1.xrfb004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb004
            #add-point:ON CHANGE xrfb004 name="input.g.page1.xrfb004"
            IF g_xrfb_d[l_ac].xrfb004 = '90' THEN 
               CALL cl_set_comp_required('xrfb002,xrfb003',FALSE)
            ELSE
               CALL cl_set_comp_required('xrfb002,xrfb003',TRUE)
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb002
            #add-point:BEFORE FIELD xrfb002 name="input.b.page1.xrfb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb002
            
            #add-point:AFTER FIELD xrfb002 name="input.a.page1.xrfb002"
            IF NOT cl_null(g_xrfb_d[l_ac].xrfb002) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfb_d[l_ac].xrfb002 != g_xrfb_d_t.xrfb002 OR g_xrfb_d_t.xrfb002 IS NULL )) THEN
                  CALL axrt460_xrfb002_chk() 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xrfb_d[l_ac].xrfb002 
                     LET g_errparam.code   = g_errno 
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                     LET g_xrfb_d[l_ac].xrfb002 = g_xrfb_d_t.xrfb002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb002
            #add-point:ON CHANGE xrfb002 name="input.g.page1.xrfb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb003
            #add-point:BEFORE FIELD xrfb003 name="input.b.page1.xrfb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb003
            
            #add-point:AFTER FIELD xrfb003 name="input.a.page1.xrfb003"
            IF NOT cl_null(g_xrfb_d[l_ac].xrfb003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfb_d[l_ac].xrfb003 != g_xrfb_d_t.xrfb003 OR g_xrfb_d_t.xrfb003 IS NULL )) THEN
                  CALL axrt460_xrfb002_chk() 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = g_errno 
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                     LET g_xrfb_d[l_ac].xrfb003 = g_xrfb_d_t.xrfb003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb003
            #add-point:ON CHANGE xrfb003 name="input.g.page1.xrfb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb100
            #add-point:BEFORE FIELD xrfb100 name="input.b.page1.xrfb100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb100
            
            #add-point:AFTER FIELD xrfb100 name="input.a.page1.xrfb100"
            IF NOT cl_null(g_xrfb_d[l_ac].xrfb100) THEN 
               IF g_xrfb_d[l_ac].xrfb100 != g_xrfb_d_o.xrfb100 OR cl_null(g_xrfb_d[l_ac].xrfb100) THEN #170119-00024#7 add
                  #應用 a19 樣板自動產生(Version:2)
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xrfb_d[l_ac].xrfb100
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
                  #160318-00025#25  by 07900 --add-end    
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooai001") THEN
                     #檢查成功時後續處理
                     LET lc_param.type    = '1'
                     LET lc_param.apca004 = g_xrfa_m.xrfa002
                     LET ls_js = util.JSON.stringify(lc_param)
                     LET g_xrfb_d[l_ac].xrfb101 = '' #170119-00024#7 add
                     CALL s_fin_get_curr_rate(g_xrfb_d[l_ac].xrfb001,g_xrfb_d[l_ac].xrfbld,g_xrfa_m.xrfadocdt,g_xrfb_d[l_ac].xrfb100,ls_js)
                          RETURNING g_xrfb_d[l_ac].xrfb101,l_rate1,l_rate2
                     IF NOT cl_null(g_xrfb_d[l_ac].xrfb103) THEN
                        LET g_xrfb_d[l_ac].xrfb104 = '' #170119-00024#7 add
                        LET g_xrfb_d[l_ac].xrfb104 = g_xrfb_d[l_ac].xrfb103 * g_xrfb_d[l_ac].xrfb101
                        CALL s_curr_round_ld('1',g_xrfb_d[l_ac].xrfb001,g_xrfb_d[l_ac].xrfbld,g_xrfb_d[l_ac].xrfb104,2) 
                        RETURNING g_sub_success,g_errno,g_xrfb_d[l_ac].xrfb104
                        DISPLAY BY NAME g_xrfb_d[l_ac].xrfb104
                        #对应代收方币别汇率
                        LET lc_param.type    = '1'
                        LET lc_param.apca004 = g_xrfa_m.xrfa002
                        LET ls_js = util.JSON.stringify(lc_param)
                        LET g_xrfb_d[l_ac].xrfb201 = '' #170119-00024#7 add
                        CALL s_fin_get_curr_rate(g_xrfa_m.xrfacomp,g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,g_xrfb_d[l_ac].xrfb100,ls_js)
                        RETURNING g_xrfb_d[l_ac].xrfb201,l_rate1,l_rate2
                        DISPLAY BY NAME g_xrfb_d[l_ac].xrfb201
                        #換算代收方本幣
                        LET g_xrfb_d[l_ac].xrfb204 = '' #170119-00024#7 add
                        LET g_xrfb_d[l_ac].xrfb204 =g_xrfb_d[l_ac].xrfb103 * g_xrfb_d[l_ac].xrfb201
                        CALL s_curr_round_ld('1',g_xrfa_m.xrfald,g_glaa.glaa001,g_xrfb_d[l_ac].xrfb204,2) 
                        RETURNING g_sub_success,g_errno,g_xrfb_d[l_ac].xrfb204
                        DISPLAY BY NAME g_xrfb_d[l_ac].xrfb204
                     END IF
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_xrfb_d[l_ac].xrfb100 = g_xrfb_d_t.xrfb100 #170119-00024#7 mark
                     #LET g_xrfb_d[l_ac].xrfb101 = g_xrfb_d_t.xrfb101 #170119-00024#7 mark
                     LET g_xrfb_d[l_ac].xrfb100 = g_xrfb_d_o.xrfb100 #170119-00024#7 add
                     LET g_xrfb_d[l_ac].xrfb101 = g_xrfb_d_o.xrfb101 #170119-00024#7 add
                     NEXT FIELD CURRENT
                  END IF
               END IF　#170119-00024#7 add

            END IF 
            LET g_xrfb_d_o.* = g_xrfb_d[l_ac].* #170119-00024#7 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb100
            #add-point:ON CHANGE xrfb100 name="input.g.page1.xrfb100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb101
            #add-point:BEFORE FIELD xrfb101 name="input.b.page1.xrfb101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb101
            
            #add-point:AFTER FIELD xrfb101 name="input.a.page1.xrfb101"
            IF NOT cl_null(g_xrfb_d[l_ac].xrfb101) THEN 
               LET g_xrfb_d[l_ac].xrfb104 = '' #170119-00024#7 add
               LET g_xrfb_d[l_ac].xrfb104 = g_xrfb_d[l_ac].xrfb103 * g_xrfb_d[l_ac].xrfb101
               CALL s_curr_round_ld('1',g_xrfb_d[l_ac].xrfb001,g_xrfb_d[l_ac].xrfbld,g_xrfb_d[l_ac].xrfb104,2) 
               RETURNING g_sub_success,g_errno,g_xrfb_d[l_ac].xrfb104
               DISPLAY BY NAME g_xrfb_d[l_ac].xrfb104
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb101
            #add-point:ON CHANGE xrfb101 name="input.g.page1.xrfb101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb103
            #add-point:BEFORE FIELD xrfb103 name="input.b.page1.xrfb103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb103
            
            #add-point:AFTER FIELD xrfb103 name="input.a.page1.xrfb103"
            IF NOT cl_null(g_xrfb_d[l_ac].xrfb103) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfb_d[l_ac].xrfb103 != g_xrfb_d_t.xrfb103 OR g_xrfb_d_t.xrfb103 IS NULL )) THEN
                  IF NOT cl_null(g_xrfb_d[l_ac].xrfb002) AND NOT cl_null(g_xrfb_d[l_ac].xrfb002) THEN
                     SELECT nmbb006,nmbb007,nmbb008,nmbb009,nmbb020,nmbb021,nmbb023,nmbb024
                       INTO l_nmbb006,l_nmbb007,l_nmbb008,l_nmbb009,l_nmbb020,l_nmbb021,l_nmbb023,l_nmbb024
                       FROM nmbb_t
                      WHERE nmbbent=g_enterprise 
                        AND nmbbdocno=g_xrfb_d[l_ac].xrfb002 
                        AND nmbbseq=g_xrfb_d[l_ac].xrfb003
                     IF cl_null(l_nmbb006) THEN LET l_nmbb006=0  END IF
                     IF cl_null(l_nmbb008) THEN LET l_nmbb008=0  END IF
                     IF cl_null(l_nmbb020) THEN LET l_nmbb020=0  END IF
                     IF cl_null(l_nmbb023) THEN LET l_nmbb023=0  END IF
                     IF cl_null(l_nmbb007) THEN LET l_nmbb007=0  END IF
                     IF cl_null(l_nmbb009) THEN LET l_nmbb009=0  END IF
                     IF cl_null(l_nmbb021) THEN LET l_nmbb021=0  END IF
                     IF cl_null(l_nmbb024) THEN LET l_nmbb024=0  END IF
                     CALL s_axrt300_sel_ld(g_xrfa_m.xrfald) RETURNING l_success,l_s
                     CASE
                        WHEN l_s=1 
                           LET l_amt = l_nmbb006 - l_nmbb008
                           LET l_amt1= l_nmbb007 - l_nmbb009
                        WHEN l_s=2 
                           LET l_amt = l_nmbb006 - l_nmbb020
                           LET l_amt1= l_nmbb007 - l_nmbb021
                        WHEN l_s=3 
                           LET l_amt = l_nmbb006 - l_nmbb023
                           LET l_amt1= l_nmbb007 - l_nmbb024
                     END CASE
                     
                     #抓取預冲未確認金額
                     LET l_xrde109 = 0   LET l_xrde119 = 0
                     SELECT SUM(xrde109),SUM(xrde119) 
                       INTO l_xrde109,l_xrde119 
                       FROM xrde_t,xrda_t
                      WHERE xrdaent   = g_enterprise
                        AND xrdald    = xrdeld
                        AND xrdadocno = xrdedocno
                        AND xrde003   = g_xrfb_d[l_ac].xrfb002
                        AND xrde004   = g_xrfb_d[l_ac].xrfb003
                        AND xrdastus  = 'N'
                     IF cl_null(l_xrde109) THEN LET l_xrde109 = 0 END IF
                     IF cl_null(l_xrde119) THEN LET l_xrde119 = 0 END IF
      
                     #抓取直接沖帳未確認金額
                     LET l_xrde109_1 = 0   LET l_xrde119_1 = 0
                     SELECT SUM(xrde109),SUM(xrde119) 
                       INTO l_xrde109_1,l_xrde119_1
                       FROM xrde_t,xrca_t
                      WHERE xrcaent   = g_enterprise
                        AND xrcaent   = xrdeent
                        AND xrcald    = xrdeld
                        AND xrcadocno = xrdedocno
                        AND xrde003   = g_xrfb_d[l_ac].xrfb002
                        AND xrde004   = g_xrfb_d[l_ac].xrfb003
                        AND xrcastus  = 'N'
                     IF cl_null(l_xrde109_1) THEN LET l_xrde109_1 = 0 END IF
                     IF cl_null(l_xrde119_1) THEN LET l_xrde119_1 = 0 END IF
                 
                     LET l_amt = l_amt - l_xrde109 - l_xrde109_1
                     LET l_amt1= l_amt1- l_xrde119 - l_xrde119_1
                     
                     IF l_amt < g_xrfb_d[l_ac].xrfb103 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = '' 
                        LET g_errparam.code   = 'axr-00192' 
                        LET g_errparam.popup  = FALSE 
                        CALL cl_err()
                        LET g_xrfb_d[l_ac].xrfb103 = g_xrfb_d_t.xrfb103
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET g_xrfb_d[l_ac].xrfb104=g_xrfb_d[l_ac].xrfb103 * g_xrfb_d[l_ac].xrfb101
                  IF l_amt1 < g_xrfb_d[l_ac].xrfb104 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = 'axr-00193' 
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                     LET g_xrfb_d[l_ac].xrfb103 = g_xrfb_d_t.xrfb103
                     LET g_xrfb_d[l_ac].xrfb104 = g_xrfb_d_t.xrfb104
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_curr_round_ld('1',g_xrfb_d[l_ac].xrfb001,g_xrfb_d[l_ac].xrfbld,g_xrfb_d[l_ac].xrfb104,2) 
                  RETURNING g_sub_success,g_errno,g_xrfb_d[l_ac].xrfb104
                  DISPLAY BY NAME g_xrfb_d[l_ac].xrfb104
                  IF cl_null(g_xrfb_d[l_ac].xrfb201) THEN
                     #對應代收方幣別匯率
#                     CALL s_aooi160_get_exrate('2',g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,g_xrfb_d[l_ac].xrfb100,g_glaa.glaa001,0,g_glaa.glaa025)
#                     RETURNING g_xrfb_d[l_ac].xrfb201
                     LET lc_param.type    = '1'
                     LET lc_param.apca004 = g_xrfa_m.xrfa002
                     LET ls_js = util.JSON.stringify(lc_param)
                     CALL s_fin_get_curr_rate(g_xrfa_m.xrfacomp,g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,g_xrfb_d[l_ac].xrfb100,ls_js)
                     RETURNING g_xrfb_d[l_ac].xrfb201,l_rate1,l_rate2
                     DISPLAY BY NAME g_xrfb_d[l_ac].xrfb201
                  END IF
                  #換算代收方本幣
                  LET g_xrfb_d[l_ac].xrfb204 =g_xrfb_d[l_ac].xrfb103 * g_xrfb_d[l_ac].xrfb201
                  CALL s_curr_round_ld('1',g_xrfa_m.xrfald,g_glaa.glaa001,g_xrfb_d[l_ac].xrfb204,2) 
                  RETURNING g_sub_success,g_errno,g_xrfb_d[l_ac].xrfb204
                  DISPLAY BY NAME g_xrfb_d[l_ac].xrfb204
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb103
            #add-point:ON CHANGE xrfb103 name="input.g.page1.xrfb103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb104
            #add-point:BEFORE FIELD xrfb104 name="input.b.page1.xrfb104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb104
            
            #add-point:AFTER FIELD xrfb104 name="input.a.page1.xrfb104"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb104
            #add-point:ON CHANGE xrfb104 name="input.g.page1.xrfb104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb005
            #add-point:BEFORE FIELD xrfb005 name="input.b.page1.xrfb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb005
            
            #add-point:AFTER FIELD xrfb005 name="input.a.page1.xrfb005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb005
            #add-point:ON CHANGE xrfb005 name="input.g.page1.xrfb005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb005_desc
            #add-point:BEFORE FIELD xrfb005_desc name="input.b.page1.xrfb005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb005_desc
            
            #add-point:AFTER FIELD xrfb005_desc name="input.a.page1.xrfb005_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb005_desc
            #add-point:ON CHANGE xrfb005_desc name="input.g.page1.xrfb005_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb201
            #add-point:BEFORE FIELD xrfb201 name="input.b.page1.xrfb201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb201
            
            #add-point:AFTER FIELD xrfb201 name="input.a.page1.xrfb201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb201
            #add-point:ON CHANGE xrfb201 name="input.g.page1.xrfb201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfb204
            #add-point:BEFORE FIELD xrfb204 name="input.b.page1.xrfb204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfb204
            
            #add-point:AFTER FIELD xrfb204 name="input.a.page1.xrfb204"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfb204
            #add-point:ON CHANGE xrfb204 name="input.g.page1.xrfb204"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xrfbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfbseq
            #add-point:ON ACTION controlp INFIELD xrfbseq name="input.c.page1.xrfbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb001
            #add-point:ON ACTION controlp INFIELD xrfb001 name="input.c.page1.xrfb001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb_d[l_ac].xrfb001             #給予default值
            LET g_qryparam.default2 = "" #g_xrfb_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #
            #LET g_qryparam.where = " ooef003='Y' "                  #161006-00005#39 mark
            LET g_qryparam.where = " ooef003='Y' AND ooef201 = 'Y' " #161006-00005#39 add
            CALL q_ooef001()                                #呼叫開窗

            LET g_xrfb_d[l_ac].xrfb001 = g_qryparam.return1              
            #LET g_xrfb_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_xrfb_d[l_ac].xrfb001 TO xrfb001              #
            #DISPLAY g_xrfb_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD xrfb001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb001_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb001_desc
            #add-point:ON ACTION controlp INFIELD xrfb001_desc name="input.c.page1.xrfb001_desc"
            #取得帳務組織下所屬成員
            CALL s_fin_account_center_sons_query('3',g_xrfa_m.xrfasite,g_xrfa_m.xrfadocdt,'1')
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING ls_wc
            #將取回的字串轉換為SQL條件
            CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb_d[l_ac].xrfb001             #給予default值
            LET g_qryparam.default2 = "" #g_xrfb_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " ooef003='Y' AND ooef017 IN ",ls_wc
            
            CALL q_ooef001()                                #呼叫開窗 

            LET g_xrfb_d[l_ac].xrfb001_desc = g_qryparam.return1              
            #LET g_xrfb_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_xrfb_d[l_ac].xrfb001_desc TO xrfb001_desc              #
            #DISPLAY g_xrfb_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            LET g_xrfb_d[l_ac].xrfb001=g_xrfb_d[l_ac].xrfb001_desc
            CALL axrt460_ref('xrfb001')
            NEXT FIELD xrfb001_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfbld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfbld
            #add-point:ON ACTION controlp INFIELD xrfbld name="input.c.page1.xrfbld"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb007
            #add-point:ON ACTION controlp INFIELD xrfb007 name="input.c.page1.xrfb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb006
            #add-point:ON ACTION controlp INFIELD xrfb006 name="input.c.page1.xrfb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb004
            #add-point:ON ACTION controlp INFIELD xrfb004 name="input.c.page1.xrfb004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb_d[l_ac].xrfb004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooie001()                                #呼叫開窗

            LET g_xrfb_d[l_ac].xrfb004 = g_qryparam.return1              

            DISPLAY g_xrfb_d[l_ac].xrfb004 TO xrfb004              #

            NEXT FIELD xrfb004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb002
            #add-point:ON ACTION controlp INFIELD xrfb002 name="input.c.page1.xrfb002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'      #2015/11/06 mod 'i'-->'c'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default2 = g_xrfb_d[l_ac].xrfb002             #給予default值
            LET g_qryparam.default3 = g_xrfb_d[l_ac].xrfb003             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_xrfa_m.xrfasite   #帳務中心
            LET g_qryparam.arg2 = g_xrfa_m.xrfa002    #核銷客戶
            LET g_qryparam.arg3 = g_xrfa_m.xrfa002    #收款客戶
            LET g_qryparam.arg4 = g_xrfa_m.xrfacomp   #來源組織
            LET g_qryparam.arg5 = g_xrfa_m.xrfald     #帳套
            
            IF g_xrfb_d[l_ac].xrfb006 = '10' THEN
#               #10現金類型 #20銀行電匯款 #票據
#               LET g_qryparam.where= " nmbadocdt <= '",g_xrfa_m.xrfadocdt,"'",
#                                     " AND (nmbb029 IN ('10','20') OR ( nmbb029 = '30' AND nmbb042 NOT IN('5','6','7','9'))) "
               LET g_qryparam.where= "     nmbadocdt <= '",g_xrfa_m.xrfadocdt,"'",
                                     " AND nmbb029 = '",g_xrfb_d[l_ac].xrfb004,"'"
               IF g_xrfb_d[l_ac].xrfb004 = '30' THEN   #票據類型
                  LET g_qryparam.where = g_qryparam.where, " AND nmbb042 <> '5' ",
                                                           " AND nmbb042 <> '6' ",
                                                           " AND nmbb042 <> '7' ",
                                                           " AND nmbb042 <> '9' "
               END IF
               CALL axrt400_07()                         #銀存收支資料沖帳挑選(子作業)
               IF NOT cl_null(g_qryparam.return1) THEN
                  CALL axrt460_ins_xrfb()
                  LET l_xrfb_flag = 'Y' 
                  LET l_flag = 'Y'
                  LET g_aw = 's_detail1'
                  EXIT DIALOG
               END IF
            END IF
            
#            LET g_xrfb_d[l_ac].xrfb002 = g_qryparam.return2              
#            LET g_xrfb_d[l_ac].xrfb003 = g_qryparam.return3
#            CALL axrt460_xrfb002_chk()
#            IF NOT cl_null(g_errno) THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = g_xrfb_d[l_ac].xrfb002 
#               LET g_errparam.code   = g_errno 
#               LET g_errparam.popup  = FALSE 
#               CALL cl_err()
#               LET g_xrfb_d[l_ac].xrfb002 = g_xrfb_d_t.xrfb002
#               LET g_xrfb_d[l_ac].xrfb003 = g_xrfb_d_t.xrfb003
#            END IF
#            DISPLAY g_xrfb_d[l_ac].xrfb002 TO xrfb002              #
#            DISPLAY g_xrfb_d[l_ac].xrfb003 TO xrfb003
            
            NEXT FIELD xrfb002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb003
            #add-point:ON ACTION controlp INFIELD xrfb003 name="input.c.page1.xrfb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb100
            #add-point:ON ACTION controlp INFIELD xrfb100 name="input.c.page1.xrfb100"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb_d[l_ac].xrfb100             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_aooi001_1()                                #呼叫開窗

            LET g_xrfb_d[l_ac].xrfb100 = g_qryparam.return1              

            DISPLAY g_xrfb_d[l_ac].xrfb100 TO xrfb100              #

            NEXT FIELD xrfb100                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb101
            #add-point:ON ACTION controlp INFIELD xrfb101 name="input.c.page1.xrfb101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb103
            #add-point:ON ACTION controlp INFIELD xrfb103 name="input.c.page1.xrfb103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb104
            #add-point:ON ACTION controlp INFIELD xrfb104 name="input.c.page1.xrfb104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb005
            #add-point:ON ACTION controlp INFIELD xrfb005 name="input.c.page1.xrfb005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb_d[l_ac].xrfb005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_nmaj001()                                #呼叫開窗

            LET g_xrfb_d[l_ac].xrfb005 = g_qryparam.return1              

            DISPLAY g_xrfb_d[l_ac].xrfb005 TO xrfb005              #

            NEXT FIELD xrfb005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb005_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb005_desc
            #add-point:ON ACTION controlp INFIELD xrfb005_desc name="input.c.page1.xrfb005_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb_d[l_ac].xrfb005_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_nmaj001()                                #呼叫開窗

            LET g_xrfb_d[l_ac].xrfb005_desc = g_qryparam.return1              

            DISPLAY g_xrfb_d[l_ac].xrfb005_desc TO xrfb005_desc              #

            NEXT FIELD xrfb005_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb201
            #add-point:ON ACTION controlp INFIELD xrfb201 name="input.c.page1.xrfb201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrfb204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfb204
            #add-point:ON ACTION controlp INFIELD xrfb204 name="input.c.page1.xrfb204"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xrfb_d[l_ac].* = g_xrfb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axrt460_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xrfb_d[l_ac].xrfbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xrfb_d[l_ac].* = g_xrfb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL axrt460_xrfb_t_mask_restore('restore_mask_o')
      
               UPDATE xrfb_t SET (xrfbdocno,xrfbseq,xrfb001,xrfbld,xrfb007,xrfb006,xrfb004,xrfb002,xrfb003, 
                   xrfb100,xrfb101,xrfb103,xrfb104,xrfb005,xrfb201,xrfb204) = (g_xrfa_m.xrfadocno,g_xrfb_d[l_ac].xrfbseq, 
                   g_xrfb_d[l_ac].xrfb001,g_xrfb_d[l_ac].xrfbld,g_xrfb_d[l_ac].xrfb007,g_xrfb_d[l_ac].xrfb006, 
                   g_xrfb_d[l_ac].xrfb004,g_xrfb_d[l_ac].xrfb002,g_xrfb_d[l_ac].xrfb003,g_xrfb_d[l_ac].xrfb100, 
                   g_xrfb_d[l_ac].xrfb101,g_xrfb_d[l_ac].xrfb103,g_xrfb_d[l_ac].xrfb104,g_xrfb_d[l_ac].xrfb005, 
                   g_xrfb_d[l_ac].xrfb201,g_xrfb_d[l_ac].xrfb204)
                WHERE xrfbent = g_enterprise AND xrfbdocno = g_xrfa_m.xrfadocno 
 
                  AND xrfbseq = g_xrfb_d_t.xrfbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xrfb_d[l_ac].* = g_xrfb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrfb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xrfb_d[l_ac].* = g_xrfb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrfb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrfa_m.xrfadocno
               LET gs_keys_bak[1] = g_xrfadocno_t
               LET gs_keys[2] = g_xrfb_d[g_detail_idx].xrfbseq
               LET gs_keys_bak[2] = g_xrfb_d_t.xrfbseq
               CALL axrt460_update_b('xrfb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL axrt460_xrfb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_xrfb_d[g_detail_idx].xrfbseq = g_xrfb_d_t.xrfbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_xrfa_m.xrfadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xrfb_d_t.xrfbseq
 
                  CALL axrt460_key_update_b(gs_keys,'xrfb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xrfa_m),util.JSON.stringify(g_xrfb_d_t)
               LET g_log2 = util.JSON.stringify(g_xrfa_m),util.JSON.stringify(g_xrfb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL axrt460_unlock_b("xrfb_t","'1'")
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
               LET g_xrfb_d[li_reproduce_target].* = g_xrfb_d[li_reproduce].*
 
               LET g_xrfb_d[li_reproduce_target].xrfbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xrfb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xrfb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_xrfb2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xrfb2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axrt460_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2','3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xrfb2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xrfb2_d[l_ac].* TO NULL 
            INITIALIZE g_xrfb2_d_t.* TO NULL 
            INITIALIZE g_xrfb2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_xrfb2_d[l_ac].xrfc103 = "0"
      LET g_xrfb2_d[l_ac].xrfc104 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            LET g_xrfb2_d[l_ac].xrfc204 = "0"
            #end add-point
            LET g_xrfb2_d_t.* = g_xrfb2_d[l_ac].*     #新輸入資料
            LET g_xrfb2_d_o.* = g_xrfb2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axrt460_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL axrt460_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xrfb2_d[li_reproduce_target].* = g_xrfb2_d[li_reproduce].*
               LET g_xrfb3_d[li_reproduce_target].* = g_xrfb3_d[li_reproduce].*
 
               LET g_xrfb2_d[li_reproduce_target].xrfcseq = NULL
            END IF
            
 
 
            #add-point:modify段before insert name="input.body2.before_insert"
            IF cl_null(g_xrfb2_d[l_ac].xrfcseq) THEN 
               SELECT MAX(xrfcseq) INTO g_xrfb2_d[l_ac].xrfcseq
                 FROM xrfc_t
                WHERE xrfcent = g_enterprise 
                  AND xrfcdocno = g_xrfa_m.xrfadocno
               IF cl_null(g_xrfb2_d[l_ac].xrfcseq) THEN 
                  LET g_xrfb2_d[l_ac].xrfcseq = 1
               ELSE
                  LET g_xrfb2_d[l_ac].xrfcseq = g_xrfb2_d[l_ac].xrfcseq +1               
               END IF
            END IF
            LET g_xrfb2_d[l_ac].xrfc001=g_xrfa_m.xrfacomp
            CALL axrt460_ref('xrfc001')
            LET g_xrfb2_d[l_ac].xrfc002=g_xrfa_m.xrfald
            LET g_xrfb2_d[l_ac].xrfc006='30'
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body2.before_row2"
            LET g_aw = 's_detail2'
            LET l_xrfb_flag = 'N' 
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
            OPEN axrt460_cl USING g_enterprise,g_xrfa_m.xrfadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axrt460_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axrt460_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xrfb2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xrfb2_d[l_ac].xrfcseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xrfb2_d_t.* = g_xrfb2_d[l_ac].*  #BACKUP
               LET g_xrfb2_d_o.* = g_xrfb2_d[l_ac].*  #BACKUP
               CALL axrt460_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL axrt460_set_no_entry_b(l_cmd)
               IF NOT axrt460_lock_b("xrfc_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axrt460_bcl2 INTO g_xrfb2_d[l_ac].xrfcseq,g_xrfb2_d[l_ac].xrfc001,g_xrfb2_d[l_ac].xrfc002, 
                      g_xrfb2_d[l_ac].xrfc006,g_xrfb2_d[l_ac].xrfc013,g_xrfb2_d[l_ac].xrfc003,g_xrfb2_d[l_ac].xrfc004, 
                      g_xrfb2_d[l_ac].xrfc005,g_xrfb2_d[l_ac].xrfc011,g_xrfb2_d[l_ac].xrfc100,g_xrfb2_d[l_ac].xrfc101, 
                      g_xrfb2_d[l_ac].xrfc103,g_xrfb2_d[l_ac].xrfc104,g_xrfb2_d[l_ac].xrfc201,g_xrfb2_d[l_ac].xrfc204, 
                      g_xrfb3_d[l_ac].xrfcseq,g_xrfb3_d[l_ac].xrfc012,g_xrfb3_d[l_ac].xrfc007,g_xrfb3_d[l_ac].xrfc008, 
                      g_xrfb3_d[l_ac].xrfc009,g_xrfb3_d[l_ac].xrfc010
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xrfb2_d_mask_o[l_ac].* =  g_xrfb2_d[l_ac].*
                  CALL axrt460_xrfc_t_mask()
                  LET g_xrfb2_d_mask_n[l_ac].* =  g_xrfb2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axrt460_show()
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
               LET gs_keys[01] = g_xrfa_m.xrfadocno
               LET gs_keys[gs_keys.getLength()+1] = g_xrfb2_d_t.xrfcseq
            
               #刪除同層單身
               IF NOT axrt460_delete_b('xrfc_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axrt460_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axrt460_key_delete_b(gs_keys,'xrfc_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axrt460_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE axrt460_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_xrfb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xrfb2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM xrfc_t 
             WHERE xrfcent = g_enterprise AND xrfcdocno = g_xrfa_m.xrfadocno
               AND xrfcseq = g_xrfb2_d[l_ac].xrfcseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               IF cl_null(g_xrfb3_d[l_ac].xrfc012) AND cl_null(g_xrfb3_d[l_ac].xrfc007) AND
                  cl_null(g_xrfb3_d[l_ac].xrfc008) AND cl_null(g_xrfb3_d[l_ac].xrfc009) AND
                  cl_null(g_xrfb3_d[l_ac].xrfc010) THEN
                  SELECT apaf017,apaf018,apaf019,apaf012,apaf015 
                    INTO g_xrfb3_d[l_ac].xrfc012,g_xrfb3_d[l_ac].xrfc007,g_xrfb3_d[l_ac].xrfc008,
                         g_xrfb3_d[l_ac].xrfc009,g_xrfb3_d[l_ac].xrfc010
                    FROM apaf_t
                   WHERE apafent=g_enterprise AND apaf001='1' AND apaf011=g_xrfb2_d[l_ac].xrfc001
                   CALL axrt460_ref('xrfc012')
                   CALL axrt460_ref('xrfc007')
                   CALL axrt460_ref('xrfc009')
                   CALL axrt460_ref('xrfc010')
               END IF
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrfa_m.xrfadocno
               LET gs_keys[2] = g_xrfb2_d[g_detail_idx].xrfcseq
               CALL axrt460_insert_b('xrfc_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xrfb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xrfc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axrt460_b_fill()
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
               LET g_xrfb2_d[l_ac].* = g_xrfb2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axrt460_bcl2
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
               LET g_xrfb2_d[l_ac].* = g_xrfb2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL axrt460_xrfc_t_mask_restore('restore_mask_o')
                              
               UPDATE xrfc_t SET (xrfcdocno,xrfcseq,xrfc001,xrfc002,xrfc006,xrfc013,xrfc003,xrfc004, 
                   xrfc005,xrfc011,xrfc100,xrfc101,xrfc103,xrfc104,xrfc201,xrfc204,xrfc012,xrfc007,xrfc008, 
                   xrfc009,xrfc010) = (g_xrfa_m.xrfadocno,g_xrfb2_d[l_ac].xrfcseq,g_xrfb2_d[l_ac].xrfc001, 
                   g_xrfb2_d[l_ac].xrfc002,g_xrfb2_d[l_ac].xrfc006,g_xrfb2_d[l_ac].xrfc013,g_xrfb2_d[l_ac].xrfc003, 
                   g_xrfb2_d[l_ac].xrfc004,g_xrfb2_d[l_ac].xrfc005,g_xrfb2_d[l_ac].xrfc011,g_xrfb2_d[l_ac].xrfc100, 
                   g_xrfb2_d[l_ac].xrfc101,g_xrfb2_d[l_ac].xrfc103,g_xrfb2_d[l_ac].xrfc104,g_xrfb2_d[l_ac].xrfc201, 
                   g_xrfb2_d[l_ac].xrfc204,g_xrfb3_d[l_ac].xrfc012,g_xrfb3_d[l_ac].xrfc007,g_xrfb3_d[l_ac].xrfc008, 
                   g_xrfb3_d[l_ac].xrfc009,g_xrfb3_d[l_ac].xrfc010) #自訂欄位頁簽
                WHERE xrfcent = g_enterprise AND xrfcdocno = g_xrfa_m.xrfadocno
                  AND xrfcseq = g_xrfb2_d_t.xrfcseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xrfb2_d[l_ac].* = g_xrfb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrfc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xrfb2_d[l_ac].* = g_xrfb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrfc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrfa_m.xrfadocno
               LET gs_keys_bak[1] = g_xrfadocno_t
               LET gs_keys[2] = g_xrfb2_d[g_detail_idx].xrfcseq
               LET gs_keys_bak[2] = g_xrfb2_d_t.xrfcseq
               CALL axrt460_update_b('xrfc_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axrt460_xrfc_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xrfb2_d[g_detail_idx].xrfcseq = g_xrfb2_d_t.xrfcseq 
                  ) THEN
                  LET gs_keys[01] = g_xrfa_m.xrfadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xrfb2_d_t.xrfcseq
                  CALL axrt460_key_update_b(gs_keys,'xrfc_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xrfa_m),util.JSON.stringify(g_xrfb2_d_t)
               LET g_log2 = util.JSON.stringify(g_xrfa_m),util.JSON.stringify(g_xrfb2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfcseq
            #add-point:BEFORE FIELD xrfcseq name="input.b.page2.xrfcseq"
            IF cl_null(g_xrfb2_d[l_ac].xrfcseq) THEN 
               SELECT MAX(xrfcseq) INTO g_xrfb2_d[l_ac].xrfcseq
                 FROM xrfc_t
                WHERE xrfcent = g_enterprise 
                  AND xrfcdocno = g_xrfa_m.xrfadocno
               IF cl_null(g_xrfb2_d[l_ac].xrfcseq) THEN 
                  LET g_xrfb2_d[l_ac].xrfcseq = 1
               ELSE
                  LET g_xrfb2_d[l_ac].xrfcseq = g_xrfb2_d[l_ac].xrfcseq +1               
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfcseq
            
            #add-point:AFTER FIELD xrfcseq name="input.a.page2.xrfcseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xrfa_m.xrfadocno IS NOT NULL AND g_xrfb2_d[g_detail_idx].xrfcseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xrfa_m.xrfadocno != g_xrfadocno_t  OR g_xrfb2_d[g_detail_idx].xrfcseq != g_xrfb2_d_t.xrfcseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrfc_t WHERE "||"xrfcent = '" ||g_enterprise|| "' AND "||"xrfcdocno = '"||g_xrfa_m.xrfadocno ||"' AND "|| "xrfcseq = '"||g_xrfb2_d[g_detail_idx].xrfcseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfcseq
            #add-point:ON CHANGE xrfcseq name="input.g.page2.xrfcseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc001
            #add-point:BEFORE FIELD xrfc001 name="input.b.page2.xrfc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc001
            
            #add-point:AFTER FIELD xrfc001 name="input.a.page2.xrfc001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc001
            #add-point:ON CHANGE xrfc001 name="input.g.page2.xrfc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc001_desc
            #add-point:BEFORE FIELD xrfc001_desc name="input.b.page2.xrfc001_desc"
            LET g_xrfb2_d[l_ac].xrfc001_desc=g_xrfb2_d[l_ac].xrfc001
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc001_desc
            
            #add-point:AFTER FIELD xrfc001_desc name="input.a.page2.xrfc001_desc"
            IF NOT cl_null(g_xrfb2_d[l_ac].xrfc001_desc) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfb2_d[l_ac].xrfc001_desc != g_xrfb2_d_t.xrfc001 OR g_xrfb2_d_t.xrfc001 IS NULL )) THEN
                  IF NOT ap_chk_isExist(g_xrfb2_d[l_ac].xrfc001_desc,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ?   ",'aoo-00090',1) THEN 
                     LET g_xrfb2_d[l_ac].xrfc001_desc = g_xrfb2_d_t.xrfc001_desc
                     NEXT FIELD CURRENT
                  END IF
#                  IF NOT ap_chk_isExist(g_xrfb2_d[l_ac].xrfc001_desc,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ?  AND ooefstus ='Y' ",'aoo-00091',1) THEN      #160318-00005#54  mark
                  IF NOT ap_chk_isExist(g_xrfb2_d[l_ac].xrfc001_desc,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ?  AND ooefstus ='Y' ",'sub-01302','aooi100') THEN    #160318-00005#54  add
                     LET g_xrfb2_d[l_ac].xrfc001_desc = g_xrfb2_d_t.xrfc001_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_isExist(g_xrfb2_d[l_ac].xrfc001_desc,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ?  AND ooefstus ='Y' AND ooef003 = 'Y'",'aap-00011',1) THEN 
                     LET g_xrfb2_d[l_ac].xrfc001_desc = g_xrfb2_d_t.xrfc001_desc
                     NEXT FIELD CURRENT
                  END IF 
                  #判斷輸入的法人是否在單頭帳務中心下
                  LET l_sql = " SELECT DISTINCT ooed002 FROM ooed_t ",
                              "  WHERE ooedent = ",g_enterprise," ",
                              "    AND ooed001 = '3' ",
                              "    AND ooed004 = '",g_xrfb2_d[l_ac].xrfc001_desc,"' ",
                              "    AND ooed006 <= '",g_xrfa_m.xrfadocdt,"' ",
                              "    AND (ooed007 IS NULL OR ooed007 >= '",g_xrfa_m.xrfadocdt,"') ",
                              "    AND ooed002 <> 'ALL' "
                  PREPARE axrt460_sel_ooed_pr FROM l_sql
                  DECLARE axrt460_sel_ooed_cs CURSOR FOR axrt460_sel_ooed_pr
                  LET l_success = FALSE
                  FOREACH axrt460_sel_ooed_cs INTO l_center
                     IF l_center = g_xrfa_m.xrfasite THEN
                        LET l_success = TRUE
                        EXIT FOREACH
                     END IF
                  END FOREACH
                  IF l_success=FALSE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xrfb2_d[l_ac].xrfc001_desc 
                     LET g_errparam.code   = 'axr-00194' 
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                     LET g_xrfb2_d[l_ac].xrfc001_desc = g_xrfb2_d_t.xrfc001_desc
                     NEXT FIELD CURRENT
                  END IF
                  #輸入法人=單頭法人時，默認帶出帳套=單頭帳套，反之，抓取該法人主張套
                  IF g_xrfb2_d[l_ac].xrfc001_desc = g_xrfa_m.xrfacomp THEN
                     LET g_xrfb2_d[l_ac].xrfc002 = g_xrfa_m.xrfald
                   ELSE
                      SELECT glaald INTO g_xrfb2_d[l_ac].xrfc002 FROM glaa_t
                       WHERE glaaent = g_enterprise AND glaacomp = g_xrfb2_d[l_ac].xrfc001_desc AND glaa014 = 'Y'
                  END IF
                  #判斷相同法人下不可輸入不同帳套
                  IF NOT cl_null(g_xrfb2_d[l_ac].xrfc002) THEN
                     SELECT COUNT(*) INTO l_cnt FROM xrfc_t 
                     WHERE xrfcent=g_enterprise AND xrfcdocno=g_xrfa_m.xrfadocno
                     AND xrfc001=g_xrfb2_d[l_ac].xrfc001_desc AND xrfc002<>g_xrfb2_d[l_ac].xrfc002
                     IF l_cnt>0 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = g_xrfb2_d[l_ac].xrfc001_desc 
                        LET g_errparam.code   = 'axr-00201' 
                        LET g_errparam.popup  = FALSE 
                        CALL cl_err()
                        LET g_xrfb2_d[l_ac].xrfc001_desc = g_xrfb2_d_t.xrfc001_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  IF cl_null(g_xrfb3_d[l_ac].xrfc012) AND cl_null(g_xrfb3_d[l_ac].xrfc007) AND
                     cl_null(g_xrfb3_d[l_ac].xrfc008) AND cl_null(g_xrfb3_d[l_ac].xrfc009) AND
                     cl_null(g_xrfb3_d[l_ac].xrfc010) THEN
                     SELECT apaf017,apaf018,apaf019,apaf012,apaf015 
                       INTO g_xrfb3_d[l_ac].xrfc012,g_xrfb3_d[l_ac].xrfc007,g_xrfb3_d[l_ac].xrfc008,
                            g_xrfb3_d[l_ac].xrfc009,g_xrfb3_d[l_ac].xrfc010
                       FROM apaf_t
                      WHERE apafent=g_enterprise AND apaf001='1' AND apaf011=g_xrfb2_d[l_ac].xrfc001_desc
                      CALL axrt460_ref('xrfc012')
                      CALL axrt460_ref('xrfc007')
                      CALL axrt460_ref('xrfc009')
                      CALL axrt460_ref('xrfc010')
                  END IF
               END IF
            END IF
            LET g_xrfb2_d[l_ac].xrfc001=g_xrfb2_d[l_ac].xrfc001_desc
            CALL axrt460_ref('xrfc001')
            #判斷已輸入的帳套是否在當前輸入的法人下
            IF NOT cl_null(g_xrfb2_d[l_ac].xrfc002) THEN 
               SELECT COUNT(*) INTO l_cnt FROM glaa_t
                WHERE glaaent=g_enterprise 
                  AND glaald=g_xrfb2_d[l_ac].xrfc002
                  AND glaacomp=g_xrfb2_d[l_ac].xrfc001
               IF l_cnt=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00189'
                  LET g_errparam.extend = g_xrfb2_d[l_ac].xrfc002
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                 
                  NEXT FIELD xrfc002
               END IF
            END IF
            DISPLAY BY NAME g_xrfb2_d[l_ac].xrfc002
            #2015/10/30--by--02599--add--str--
            #輸入法人=單頭法人時，默認帶出帳套=單頭帳套且帳套不可進入修改,不同法人時則仍可輸入帳套欄
            IF g_xrfb2_d[l_ac].xrfc001 = g_xrfa_m.xrfacomp THEN
               CALL cl_set_comp_entry("xrfc002",FALSE) 
            ELSE
               CALL cl_set_comp_entry("xrfc002",TRUE) 
            END IF
            #2015/10/30--by--02599--add--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc001_desc
            #add-point:ON CHANGE xrfc001_desc name="input.g.page2.xrfc001_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc002
            #add-point:BEFORE FIELD xrfc002 name="input.b.page2.xrfc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc002
            
            #add-point:AFTER FIELD xrfc002 name="input.a.page2.xrfc002"
            IF NOT cl_null(g_xrfb2_d[l_ac].xrfc002) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfb2_d[l_ac].xrfc002 != g_xrfb2_d_t.xrfc002 OR g_xrfb2_d_t.xrfc002 IS NULL )) THEN
                  #取得帳務組織下所屬成員
                  CALL s_fin_account_center_sons_query('3',g_xrfa_m.xrfasite,g_xrfa_m.xrfadocdt,'1')
                  CALL s_fin_account_center_with_ld_chk(g_xrfa_m.xrfasite,g_xrfb2_d[l_ac].xrfc002,g_user,'3','N','',g_xrfa_m.xrfadocdt) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xrfb2_d[l_ac].xrfc002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_xrfb2_d[l_ac].xrfc002 = g_xrfb2_d_t.xrfc002
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_xrfb2_d[l_ac].xrfc001) THEN 
                     #判断該帳套是否在法人下
                     SELECT COUNT(*) INTO l_cnt FROM glaa_t
                      WHERE glaaent=g_enterprise 
                        AND glaald=g_xrfb2_d[l_ac].xrfc002
                        AND glaacomp=g_xrfb2_d[l_ac].xrfc001
                     IF l_cnt=0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'afa-00189'
                        LET g_errparam.extend = g_xrfb2_d[l_ac].xrfc002
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_xrfb2_d[l_ac].xrfc002 = g_xrfb2_d_t.xrfc002
                        NEXT FIELD CURRENT
                     END IF
                     #判斷相同法人下不可輸入不同帳套
                     SELECT COUNT(*) INTO l_cnt FROM xrfc_t 
                     WHERE xrfcent=g_enterprise AND xrfcdocno=g_xrfa_m.xrfadocno
                     AND xrfc001=g_xrfb2_d[l_ac].xrfc001 AND xrfc002<>g_xrfb2_d[l_ac].xrfc002
                     IF l_cnt>0 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = g_xrfb2_d[l_ac].xrfc002
                        LET g_errparam.code   = 'axr-00201' 
                        LET g_errparam.popup  = FALSE 
                        CALL cl_err()
                        LET g_xrfb2_d[l_ac].xrfc002 = g_xrfb2_d_t.xrfc002
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc002
            #add-point:ON CHANGE xrfc002 name="input.g.page2.xrfc002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc006
            #add-point:BEFORE FIELD xrfc006 name="input.b.page2.xrfc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc006
            
            #add-point:AFTER FIELD xrfc006 name="input.a.page2.xrfc006"
            IF NOT cl_null(g_xrfb2_d[l_ac].xrfc006) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfb2_d[l_ac].xrfc006 != g_xrfb2_d_t.xrfc006 OR g_xrfb2_d_t.xrfc006 IS NULL )) THEN
                  SELECT gzcb003 INTO g_xrfb2_d[l_ac].xrfc013 FROM gzcb_t WHERE gzcb001='8306' AND gzcb002=g_xrfb2_d[l_ac].xrfc006
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc006
            #add-point:ON CHANGE xrfc006 name="input.g.page2.xrfc006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc013
            #add-point:BEFORE FIELD xrfc013 name="input.b.page2.xrfc013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc013
            
            #add-point:AFTER FIELD xrfc013 name="input.a.page2.xrfc013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc013
            #add-point:ON CHANGE xrfc013 name="input.g.page2.xrfc013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc003
            #add-point:BEFORE FIELD xrfc003 name="input.b.page2.xrfc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc003
            
            #add-point:AFTER FIELD xrfc003 name="input.a.page2.xrfc003"
            IF NOT cl_null(g_xrfb2_d[l_ac].xrfc003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfb2_d[l_ac].xrfc003 != g_xrfb2_d_t.xrfc003 OR g_xrfb2_d_t.xrfc003 IS NULL )) THEN
                  CALL axrt460_xrfc003_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xrfb2_d[l_ac].xrfc003
                     #160318-00005#54 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aprm201'
                           LET g_errparam.replace[2] = cl_get_progname('aprm201',g_lang,"2")
                           LET g_errparam.exeprog = 'aprm201'
                     END CASE
                     #160318-00005#54 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xrfb2_d[l_ac].xrfc003 = g_xrfb2_d_t.xrfc003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc003
            #add-point:ON CHANGE xrfc003 name="input.g.page2.xrfc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc004
            #add-point:BEFORE FIELD xrfc004 name="input.b.page2.xrfc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc004
            
            #add-point:AFTER FIELD xrfc004 name="input.a.page2.xrfc004"
            IF NOT cl_null(g_xrfb2_d[l_ac].xrfc004) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfb2_d[l_ac].xrfc004 != g_xrfb2_d_t.xrfc004 OR g_xrfb2_d_t.xrfc004 IS NULL )) THEN
                  CALL axrt460_xrfc003_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xrfb2_d[l_ac].xrfc004
                     #160318-00005#54 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aprm201'
                           LET g_errparam.replace[2] = cl_get_progname('aprm201',g_lang,"2")
                           LET g_errparam.exeprog = 'aprm201'
                     END CASE
                     #160318-00005#54 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xrfb2_d[l_ac].xrfc004 = g_xrfb2_d_t.xrfc004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc004
            #add-point:ON CHANGE xrfc004 name="input.g.page2.xrfc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc005
            #add-point:BEFORE FIELD xrfc005 name="input.b.page2.xrfc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc005
            
            #add-point:AFTER FIELD xrfc005 name="input.a.page2.xrfc005"
            IF NOT cl_null(g_xrfb2_d[l_ac].xrfc005) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfb2_d[l_ac].xrfc005 != g_xrfb2_d_t.xrfc005 OR g_xrfb2_d_t.xrfc005 IS NULL )) THEN
                  CALL axrt460_xrfc003_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xrfb2_d[l_ac].xrfc005
                     #160318-00005#54 --s add
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aprm201'
                           LET g_errparam.replace[2] = cl_get_progname('aprm201',g_lang,"2")
                           LET g_errparam.exeprog = 'aprm201'
                     END CASE
                     #160318-00005#54 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xrfb2_d[l_ac].xrfc005 = g_xrfb2_d_t.xrfc005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc005
            #add-point:ON CHANGE xrfc005 name="input.g.page2.xrfc005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc011
            #add-point:BEFORE FIELD xrfc011 name="input.b.page2.xrfc011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc011
            
            #add-point:AFTER FIELD xrfc011 name="input.a.page2.xrfc011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc011
            #add-point:ON CHANGE xrfc011 name="input.g.page2.xrfc011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc100
            #add-point:BEFORE FIELD xrfc100 name="input.b.page2.xrfc100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc100
            
            #add-point:AFTER FIELD xrfc100 name="input.a.page2.xrfc100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc100
            #add-point:ON CHANGE xrfc100 name="input.g.page2.xrfc100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc101
            #add-point:BEFORE FIELD xrfc101 name="input.b.page2.xrfc101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc101
            
            #add-point:AFTER FIELD xrfc101 name="input.a.page2.xrfc101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc101
            #add-point:ON CHANGE xrfc101 name="input.g.page2.xrfc101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc103
            #add-point:BEFORE FIELD xrfc103 name="input.b.page2.xrfc103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc103
            
            #add-point:AFTER FIELD xrfc103 name="input.a.page2.xrfc103"
            IF NOT cl_null(g_xrfb2_d[l_ac].xrfc103) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfb2_d[l_ac].xrfc103 != g_xrfb2_d_t.xrfc103 OR g_xrfb2_d_t.xrfc103 IS NULL )) THEN
                  IF NOT cl_null(g_xrfb2_d[l_ac].xrfc003) AND NOT cl_null(g_xrfb2_d[l_ac].xrfc004)
                     AND NOT cl_null(g_xrfb2_d[l_ac].xrfc005) THEN
                     IF g_xrfb2_d[l_ac].xrfc006 = '30' OR g_xrfb2_d[l_ac].xrfc006 = '31' OR g_xrfb2_d[l_ac].xrfc006 = '32' THEN
                        SELECT xrcc108,xrcc109,xrcc118,xrcc119,xrcc113 
                          INTO l_xrcc108,l_xrcc109,l_xrcc118,l_xrcc119,l_xrcc113
                          FROM xrcc_t
                         WHERE xrccent=g_enterprise  AND xrccld=g_xrfb2_d[l_ac].xrfc002 
                           AND  xrccdocno=g_xrfb2_d[l_ac].xrfc003
                           AND xrccseq=g_xrfb2_d[l_ac].xrfc004 
                           AND xrcc001=g_xrfb2_d[l_ac].xrfc005
                        IF cl_null(l_xrcc108) THEN LET l_xrcc108=0 END IF
                        IF cl_null(l_xrcc109) THEN LET l_xrcc109=0 END IF
                        IF cl_null(l_xrcc118) THEN LET l_xrcc118=0 END IF
                        IF cl_null(l_xrcc119) THEN LET l_xrcc119=0 END IF
                        IF cl_null(l_xrcc113) THEN LET l_xrcc113=0 END IF
                        LET l_amt=l_xrcc108-l_xrcc109
                        LET l_amt1=l_xrcc118-l_xrcc119+l_xrcc113
                     END IF
                     
                     IF g_xrfb2_d[l_ac].xrfc006 = '40' OR g_xrfb2_d[l_ac].xrfc006 = '41' OR g_xrfb2_d[l_ac].xrfc006 = '42' THEN
                        SELECT SUM(apcc108 - apcc109),SUM(apcc118 - apcc119 + apcc113) 
                          INTO l_apcc108,l_apcc118
                          FROM apcc_t
                         WHERE apccent = g_enterprise
                           AND apccld = g_xrfa_m.xrfald
                           AND apccdocno = g_xrfb2_d[l_ac].xrfc003
                           AND apccseq = g_xrfb2_d[l_ac].xrfc004
                           AND apcc001 = g_xrfb2_d[l_ac].xrfc005
                        
                        IF cl_null(l_apcc108) THEN LET l_apcc108 = 0 END IF
                        IF cl_null(l_apcc118) THEN LET l_apcc118 = 0 END IF
                        LET l_amt = l_apcc108
                        LET l_amt1= l_apcc118
                     END IF
                     #抓取預冲未確認金額
                     SELECT SUM(xrce109),SUM(xrce119) 
                       INTO l_xrce109,l_xrce119
                       FROM xrce_t,xrda_t
                      WHERE xrdaent   = g_enterprise
                        AND xrdald    = xrceld
                        AND xrdadocno = xrcedocno
                        AND xrce003   = g_xrfb2_d[l_ac].xrfc003
                        AND xrce004   = g_xrfb2_d[l_ac].xrfc004
                        AND xrce005   = g_xrfb2_d[l_ac].xrfc005
                        AND xrdastus  = 'N'
                        
                     IF cl_null(l_xrce109) THEN LET l_xrce109 = 0 END IF
                     IF cl_null(l_xrce119) THEN LET l_xrce119 = 0 END IF
                     LET l_amt = l_amt - l_xrce109
                     LET l_amt1= l_amt1- l_xrce119
                     
                     LET l_xrfc104=g_xrfb2_d[l_ac].xrfc103 * g_xrfb2_d[l_ac].xrfc101
                     IF g_xrfb2_d[l_ac].xrfc103 > l_amt OR l_xrfc104 > l_amt1 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'axr-00054'
                        LET g_errparam.extend = g_xrfb2_d[l_ac].xrfc103
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_xrfb2_d[l_ac].xrfc103 = g_xrfb2_d_t.xrfc103
                        NEXT FIELD CURRENT
                     END IF
                     LET g_xrfb2_d[l_ac].xrfc104 = l_xrfc104
                     DISPLAY BY NAME g_xrfb2_d[l_ac].xrfc104
                  END IF
                  IF cl_null(g_xrfb2_d[l_ac].xrfc201) THEN
                     #對應被代收方幣別匯率
#                     CALL s_aooi160_get_exrate('2',g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,g_xrfb2_d[l_ac].xrfc100,g_glaa.glaa001,0,g_glaa.glaa025) 
#                     RETURNING g_xrfb2_d[l_ac].xrfc201
                     LET lc_param.type    = '1'
                     LET lc_param.apca004 = g_xrfa_m.xrfa002
                     LET ls_js = util.JSON.stringify(lc_param)
                     CALL s_fin_get_curr_rate(g_xrfa_m.xrfacomp,g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,g_xrfb2_d[l_ac].xrfc100,ls_js)
                     RETURNING g_xrfb2_d[l_ac].xrfc201,l_rate1,l_rate2
                     DISPLAY BY NAME g_xrfb2_d[l_ac].xrfc201
                  END IF
                  #換算被代收方本幣
                  LET g_xrfb2_d[l_ac].xrfc204 = g_xrfb2_d[l_ac].xrfc103 * g_xrfb2_d[l_ac].xrfc201
                  CALL s_curr_round_ld('1',g_xrfa_m.xrfald,g_glaa.glaa001,g_xrfb2_d[l_ac].xrfc204,2) 
                  RETURNING g_sub_success,g_errno,g_xrfb2_d[l_ac].xrfc204
                  DISPLAY BY NAME g_xrfb2_d[l_ac].xrfc204
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc103
            #add-point:ON CHANGE xrfc103 name="input.g.page2.xrfc103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc104
            #add-point:BEFORE FIELD xrfc104 name="input.b.page2.xrfc104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc104
            
            #add-point:AFTER FIELD xrfc104 name="input.a.page2.xrfc104"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc104
            #add-point:ON CHANGE xrfc104 name="input.g.page2.xrfc104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc201
            #add-point:BEFORE FIELD xrfc201 name="input.b.page2.xrfc201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc201
            
            #add-point:AFTER FIELD xrfc201 name="input.a.page2.xrfc201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc201
            #add-point:ON CHANGE xrfc201 name="input.g.page2.xrfc201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc204
            #add-point:BEFORE FIELD xrfc204 name="input.b.page2.xrfc204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc204
            
            #add-point:AFTER FIELD xrfc204 name="input.a.page2.xrfc204"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc204
            #add-point:ON CHANGE xrfc204 name="input.g.page2.xrfc204"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.xrfcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfcseq
            #add-point:ON ACTION controlp INFIELD xrfcseq name="input.c.page2.xrfcseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrfc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc001
            #add-point:ON ACTION controlp INFIELD xrfc001 name="input.c.page2.xrfc001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb2_d[l_ac].xrfc001             #給予default值
            LET g_qryparam.default2 = "" #g_xrfb2_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_xrfb2_d[l_ac].xrfc001 = g_qryparam.return1              
            #LET g_xrfb2_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_xrfb2_d[l_ac].xrfc001 TO xrfc001              #
            #DISPLAY g_xrfb2_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD xrfc001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.xrfc001_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc001_desc
            #add-point:ON ACTION controlp INFIELD xrfc001_desc name="input.c.page2.xrfc001_desc"
            #取得帳務組織下所屬成員
            CALL s_fin_account_center_sons_query('3',g_xrfa_m.xrfasite,g_xrfa_m.xrfadocdt,'1')
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING ls_wc
            #將取回的字串轉換為SQL條件
            CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb2_d[l_ac].xrfc001            #給予default值
            LET g_qryparam.default2 = "" #g_xrfb2_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " ooef003='Y' AND ooef017 IN ",ls_wc
            
            CALL q_ooef001_2()                                #呼叫開窗   #161006-00005#39    #q_ooef001>q_ooef001_2

            LET g_xrfb2_d[l_ac].xrfc001_desc = g_qryparam.return1              
            #LET g_xrfb2_d[l_ac].ooefl003 = g_qryparam.return2 
            LET g_xrfb2_d[l_ac].xrfc001 = g_xrfb2_d[l_ac].xrfc001_desc
            CALL axrt460_ref('xrfc001')
            DISPLAY g_xrfb2_d[l_ac].xrfc001_desc TO xrfc001_desc              #
            #DISPLAY g_xrfb2_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD xrfc001_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.xrfc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc002
            #add-point:ON ACTION controlp INFIELD xrfc002 name="input.c.page2.xrfc002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb2_d[l_ac].xrfc002             #給予default值
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') "
            IF NOT cl_null(g_xrfb2_d[l_ac].xrfc001) THEN
               LET g_qryparam.where = g_qryparam.where," AND glaacomp = '",g_xrfb2_d[l_ac].xrfc001,"'"
            ELSE
               #取得帳務組織下所屬成員
               CALL s_fin_account_center_sons_query('3',g_xrfa_m.xrfasite,g_xrfa_m.xrfadocdt,'1')
               #取得帳務組織下所屬成員之帳別   
               CALL s_fin_account_center_comp_str() RETURNING ls_wc
               #將取回的字串轉換為SQL條件
               CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc
               LET g_qryparam.where = g_qryparam.where," AND glaacomp IN ",ls_wc
            END IF
            #給予arg
            LET g_qryparam.arg1 = g_user #
            LET g_qryparam.arg2 = g_dept #
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xrfb2_d[l_ac].xrfc002 = g_qryparam.return1              

            DISPLAY g_xrfb2_d[l_ac].xrfc002 TO xrfc002              #

            NEXT FIELD xrfc002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.xrfc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc006
            #add-point:ON ACTION controlp INFIELD xrfc006 name="input.c.page2.xrfc006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrfc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc013
            #add-point:ON ACTION controlp INFIELD xrfc013 name="input.c.page2.xrfc013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrfc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc003
            #add-point:ON ACTION controlp INFIELD xrfc003 name="input.c.page2.xrfc003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'      #2015/11/06 mod 'i'-->'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default2 = g_xrfb2_d[l_ac].xrfc005   #給予default值
            LET g_qryparam.default3 = g_xrfb2_d[l_ac].xrfc003
            LET g_qryparam.default4 = g_xrfb2_d[l_ac].xrfc004
            
            #2015/11/06--add--str--
            CALL axrt460_glaa_get(g_xrfb2_d[l_ac].xrfc002)
            CASE g_xrfb2_d[l_ac].xrfc006[1,1] 
               WHEN '3'
                  LET g_wc3 = cl_replace_str(g_wc3,'apca','xrca')
               WHEN '4'
                  LET g_wc3 = cl_replace_str(g_wc3,'xrca','apca')
            END CASE
            #2015/11/06--add--end
            
            #給予arg
            LET g_qryparam.arg1 = g_xrfa_m.xrfa002
            IF NOT cl_null(g_xrfb2_d[l_ac].xrfc002) THEN
               LET g_qryparam.arg2 = g_xrfb2_d[l_ac].xrfc002
            ELSE
               LET g_qryparam.arg2 = g_xrfa_m.xrfald
            END IF
#            LET g_qryparam.arg3 = g_xrfa_m.xrfasite #160818-00011#1 mark
            #呼叫開窗
            CASE
               WHEN g_xrfb2_d[l_ac].xrfc006 = '30'           #應收單 
                  LET g_qryparam.where = "  xrcadocdt <= '",g_xrfa_m.xrfadocdt,"'",
                                         "  AND SUBSTR(xrca001,1,1) = '1' ",
                                         g_wc3  #2015/11/06 add
                  IF NOT cl_null(g_xrfb2_d[l_ac].xrfc001) THEN
                     LET g_qryparam.where = g_qryparam.where," AND xrcacomp = '",g_xrfb2_d[l_ac].xrfc001,"' "
                  END IF
                  
               WHEN g_xrfb2_d[l_ac].xrfc006 = '31'           #銀行電匯款                  
                  LET g_qryparam.where= "xrcadocdt <= '",g_xrfa_m.xrfadocdt,"'",
                                        "  AND SUBSTR(xrca001,1,1) = '2' ",
                                        "  AND xrca001 <> '25'",
                                        g_wc3  #2015/11/06 add
                  IF NOT cl_null(g_xrfb2_d[l_ac].xrfc001) THEN
                     LET g_qryparam.where = g_qryparam.where," AND xrcacomp = '",g_xrfb2_d[l_ac].xrfc001,"' "
                  END IF
                  
               WHEN g_xrfb2_d[l_ac].xrfc006 = '32'           #已收押金沖銷
                  LET g_qryparam.where= "xrcadocdt <= '",g_xrfa_m.xrfadocdt,"'",
                                        "  AND xrca001 = '25'",
                                        g_wc3  #2015/11/06 add
                  IF NOT cl_null(g_xrfb2_d[l_ac].xrfc001) THEN
                     LET g_qryparam.where = g_qryparam.where," AND xrcacomp = '",g_xrfb2_d[l_ac].xrfc001,"' "
                  END IF
                  
                  
               WHEN g_xrfb2_d[l_ac].xrfc006 = '40'           #應付單沖銷
                  LET g_qryparam.where= "     apcadocdt <= '",g_xrfa_m.xrfadocdt,"'",
                                        " AND SUBSTR(apca001,1,1) = '1' ",
                                        g_wc3  #2015/11/06 add
                  IF NOT cl_null(g_xrfb2_d[l_ac].xrfc001) THEN
                     LET g_qryparam.where = g_qryparam.where," AND apcacomp = '",g_xrfb2_d[l_ac].xrfc001,"' "
                  END IF
                  
               WHEN g_xrfb2_d[l_ac].xrfc006 = '41'           #應付待抵單沖銷
                  LET g_qryparam.where= "     apcadocdt <= '",g_xrfa_m.xrfadocdt,"'",
                                        " AND SUBSTR(apca001,1,1) = '2' ",
                                        " AND apca001 <> '25'",
                                        g_wc3  #2015/11/06 add
                  IF NOT cl_null(g_xrfb2_d[l_ac].xrfc001) THEN
                     LET g_qryparam.where = g_qryparam.where," AND apcacomp = '",g_xrfb2_d[l_ac].xrfc001,"' "
                  END IF
                  
               WHEN g_xrfb2_d[l_ac].xrfc006 = '42'           #已付押金沖銷
                  LET g_qryparam.where= "     apcadocdt <= '",g_xrfa_m.xrfadocdt,"'",
                                        " AND apca001 = '25'",
                                        g_wc3  #2015/11/06 add
                  IF NOT cl_null(g_xrfb2_d[l_ac].xrfc001) THEN
                     LET g_qryparam.where = g_qryparam.where," AND apcacomp = '",g_xrfb2_d[l_ac].xrfc001,"' "
                  END IF
                                          
            END CASE
            
            IF g_xrfb2_d[l_ac].xrfc006 = '30' OR g_xrfb2_d[l_ac].xrfc006 = '31' OR g_xrfb2_d[l_ac].xrfc006 = '32' THEN
               CALL axrt400_04()                         #銀存收支資料沖帳挑選(子作業)
               IF NOT cl_null(g_qryparam.return1) THEN
                  CALL axrt460_ins_xrfc_04()
                  LET l_xrfc_flag = 'Y' 
                  LET l_flag = 'Y'
                  LET g_aw = 's_detail2'
                  EXIT DIALOG
               END IF
            END IF
            
            IF g_xrfb2_d[l_ac].xrfc006 = '40' OR g_xrfb2_d[l_ac].xrfc006 = '41' OR g_xrfb2_d[l_ac].xrfc006 = '42' THEN
               CALL axrt400_12()         #銀存收支資料沖帳挑選(子作業)
               IF NOT cl_null(g_qryparam.return1) THEN
                  CALL axrt460_ins_xrfc_12()
                  LET l_xrfc_flag = 'Y' 
                  LET l_flag = 'Y'
                  LET g_aw = 's_detail2'
                  EXIT DIALOG
               END IF
            END IF
           
#            LET g_xrfb2_d[l_ac].xrfc003 = g_qryparam.return3  #單號           
#            LET g_xrfb2_d[l_ac].xrfc004 = g_qryparam.return4  #項次
#            LET g_xrfb2_d[l_ac].xrfc005 = g_qryparam.return2  #期別 
#            CALL axrt460_xrfc003_chk()
#            IF NOT cl_null(g_errno) THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = g_errno
#               LET g_errparam.extend = g_xrfb2_d[l_ac].xrfc003
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               
#               LET g_xrfb2_d[l_ac].xrfc003 = g_xrfb2_d_t.xrfc003
#               LET g_xrfb2_d[l_ac].xrfc004 = g_xrfb2_d_t.xrfc004
#               LET g_xrfb2_d[l_ac].xrfc005 = g_xrfb2_d_t.xrfc005
#            END IF
#            DISPLAY g_xrfb2_d[l_ac].xrfc003 TO xrfc003 
#            DISPLAY g_xrfb2_d[l_ac].xrfc004 TO xrfc004 
#            DISPLAY g_xrfb2_d[l_ac].xrfc005 TO xrfc005
            NEXT FIELD xrfc003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.xrfc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc004
            #add-point:ON ACTION controlp INFIELD xrfc004 name="input.c.page2.xrfc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrfc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc005
            #add-point:ON ACTION controlp INFIELD xrfc005 name="input.c.page2.xrfc005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrfc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc011
            #add-point:ON ACTION controlp INFIELD xrfc011 name="input.c.page2.xrfc011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrfc100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc100
            #add-point:ON ACTION controlp INFIELD xrfc100 name="input.c.page2.xrfc100"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb2_d[l_ac].xrfc100             #給予default值
            LET g_qryparam.default2 = "" #g_xrfb2_d[l_ac].ooail003 #說明
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooai001_1()                                #呼叫開窗

            LET g_xrfb2_d[l_ac].xrfc100 = g_qryparam.return1              
            #LET g_xrfb2_d[l_ac].ooail003 = g_qryparam.return2 
            DISPLAY g_xrfb2_d[l_ac].xrfc100 TO xrfc100              #
            #DISPLAY g_xrfb2_d[l_ac].ooail003 TO ooail003 #說明
            NEXT FIELD xrfc100                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.xrfc101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc101
            #add-point:ON ACTION controlp INFIELD xrfc101 name="input.c.page2.xrfc101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrfc103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc103
            #add-point:ON ACTION controlp INFIELD xrfc103 name="input.c.page2.xrfc103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrfc104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc104
            #add-point:ON ACTION controlp INFIELD xrfc104 name="input.c.page2.xrfc104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrfc201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc201
            #add-point:ON ACTION controlp INFIELD xrfc201 name="input.c.page2.xrfc201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrfc204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc204
            #add-point:ON ACTION controlp INFIELD xrfc204 name="input.c.page2.xrfc204"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xrfb2_d[l_ac].* = g_xrfb2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axrt460_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axrt460_unlock_b("xrfc_t","'2'")
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
               LET g_xrfb2_d[li_reproduce_target].* = g_xrfb2_d[li_reproduce].*
               LET g_xrfb3_d[li_reproduce_target].* = g_xrfb3_d[li_reproduce].*
 
               LET g_xrfb2_d[li_reproduce_target].xrfcseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xrfb2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xrfb2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_xrfb3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            
            CALL axrt460_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xrfb3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xrfb3_d[l_ac].* TO NULL 
            INITIALIZE g_xrfb3_d_t.* TO NULL 
            INITIALIZE g_xrfb3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_xrfb3_d_t.* = g_xrfb3_d[l_ac].*     #新輸入資料
            LET g_xrfb3_d_o.* = g_xrfb3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axrt460_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL axrt460_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xrfb2_d[li_reproduce_target].* = g_xrfb2_d[li_reproduce].*
               LET g_xrfb3_d[li_reproduce_target].* = g_xrfb3_d[li_reproduce].*
 
               LET g_xrfb3_d[li_reproduce_target].xrfcseq = NULL
            END IF
            
 
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[3] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN axrt460_cl USING g_enterprise,g_xrfa_m.xrfadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axrt460_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axrt460_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xrfb3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xrfb3_d[l_ac].xrfcseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xrfb3_d_t.* = g_xrfb3_d[l_ac].*  #BACKUP
               LET g_xrfb3_d_o.* = g_xrfb3_d[l_ac].*  #BACKUP
               CALL axrt460_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL axrt460_set_no_entry_b(l_cmd)
               IF NOT axrt460_lock_b("xrfc_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axrt460_bcl2 INTO g_xrfb2_d[l_ac].xrfcseq,g_xrfb2_d[l_ac].xrfc001,g_xrfb2_d[l_ac].xrfc002, 
                      g_xrfb2_d[l_ac].xrfc006,g_xrfb2_d[l_ac].xrfc013,g_xrfb2_d[l_ac].xrfc003,g_xrfb2_d[l_ac].xrfc004, 
                      g_xrfb2_d[l_ac].xrfc005,g_xrfb2_d[l_ac].xrfc011,g_xrfb2_d[l_ac].xrfc100,g_xrfb2_d[l_ac].xrfc101, 
                      g_xrfb2_d[l_ac].xrfc103,g_xrfb2_d[l_ac].xrfc104,g_xrfb2_d[l_ac].xrfc201,g_xrfb2_d[l_ac].xrfc204, 
                      g_xrfb3_d[l_ac].xrfcseq,g_xrfb3_d[l_ac].xrfc012,g_xrfb3_d[l_ac].xrfc007,g_xrfb3_d[l_ac].xrfc008, 
                      g_xrfb3_d[l_ac].xrfc009,g_xrfb3_d[l_ac].xrfc010
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xrfb3_d_mask_o[l_ac].* =  g_xrfb3_d[l_ac].*
                  CALL axrt460_xrfc_t_mask()
                  LET g_xrfb3_d_mask_n[l_ac].* =  g_xrfb3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axrt460_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
            IF cl_null(g_xrfb3_d[l_ac].xrfc012) AND cl_null(g_xrfb3_d[l_ac].xrfc007) AND
               cl_null(g_xrfb3_d[l_ac].xrfc008) AND cl_null(g_xrfb3_d[l_ac].xrfc009) AND
               cl_null(g_xrfb3_d[l_ac].xrfc010) THEN
               SELECT apaf017,apaf018,apaf019,apaf012,apaf015 
                 INTO g_xrfb3_d[l_ac].xrfc012,g_xrfb3_d[l_ac].xrfc007,g_xrfb3_d[l_ac].xrfc008,
                      g_xrfb3_d[l_ac].xrfc009,g_xrfb3_d[l_ac].xrfc010
                 FROM apaf_t
                WHERE apafent=g_enterprise AND apaf001='1' AND apaf011=g_xrfb2_d[l_ac].xrfc001
                CALL axrt460_ref('xrfc009')
                CALL axrt460_ref('xrfc010')
            END IF
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
            #其他table進行lock
            
 
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
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
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xrfa_m.xrfadocno
               LET gs_keys[gs_keys.getLength()+1] = g_xrfb3_d_t.xrfcseq
            
               #刪除同層單身
               IF NOT axrt460_delete_b('xrfc_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axrt460_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axrt460_key_delete_b(gs_keys,'xrfc_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axrt460_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE axrt460_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_xrfb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xrfb3_d.getLength() + 1) THEN
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
               
            #add-point:單身3新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xrfc_t 
             WHERE xrfcent = g_enterprise AND xrfcdocno = g_xrfa_m.xrfadocno
               AND xrfcseq = g_xrfb3_d[l_ac].xrfcseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrfa_m.xrfadocno
               LET gs_keys[2] = g_xrfb3_d[g_detail_idx].xrfcseq
               CALL axrt460_insert_b('xrfc_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xrfb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xrfc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axrt460_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xrfb3_d[l_ac].* = g_xrfb3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axrt460_bcl2
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
               LET g_xrfb3_d[l_ac].* = g_xrfb3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL axrt460_xrfc_t_mask_restore('restore_mask_o')
                              
               UPDATE xrfc_t SET (xrfcdocno,xrfcseq,xrfc001,xrfc002,xrfc006,xrfc013,xrfc003,xrfc004, 
                   xrfc005,xrfc011,xrfc100,xrfc101,xrfc103,xrfc104,xrfc201,xrfc204,xrfc012,xrfc007,xrfc008, 
                   xrfc009,xrfc010) = (g_xrfa_m.xrfadocno,g_xrfb2_d[l_ac].xrfcseq,g_xrfb2_d[l_ac].xrfc001, 
                   g_xrfb2_d[l_ac].xrfc002,g_xrfb2_d[l_ac].xrfc006,g_xrfb2_d[l_ac].xrfc013,g_xrfb2_d[l_ac].xrfc003, 
                   g_xrfb2_d[l_ac].xrfc004,g_xrfb2_d[l_ac].xrfc005,g_xrfb2_d[l_ac].xrfc011,g_xrfb2_d[l_ac].xrfc100, 
                   g_xrfb2_d[l_ac].xrfc101,g_xrfb2_d[l_ac].xrfc103,g_xrfb2_d[l_ac].xrfc104,g_xrfb2_d[l_ac].xrfc201, 
                   g_xrfb2_d[l_ac].xrfc204,g_xrfb3_d[l_ac].xrfc012,g_xrfb3_d[l_ac].xrfc007,g_xrfb3_d[l_ac].xrfc008, 
                   g_xrfb3_d[l_ac].xrfc009,g_xrfb3_d[l_ac].xrfc010) #自訂欄位頁簽
                WHERE xrfcent = g_enterprise AND xrfcdocno = g_xrfa_m.xrfadocno
                  AND xrfcseq = g_xrfb3_d_t.xrfcseq #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xrfb3_d[l_ac].* = g_xrfb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrfc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xrfb3_d[l_ac].* = g_xrfb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrfc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrfa_m.xrfadocno
               LET gs_keys_bak[1] = g_xrfadocno_t
               LET gs_keys[2] = g_xrfb3_d[g_detail_idx].xrfcseq
               LET gs_keys_bak[2] = g_xrfb3_d_t.xrfcseq
               CALL axrt460_update_b('xrfc_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axrt460_xrfc_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xrfb3_d[g_detail_idx].xrfcseq = g_xrfb3_d_t.xrfcseq 
                  ) THEN
                  LET gs_keys[01] = g_xrfa_m.xrfadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xrfb3_d_t.xrfcseq
                  CALL axrt460_key_update_b(gs_keys,'xrfc_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xrfa_m),util.JSON.stringify(g_xrfb3_d_t)
               LET g_log2 = util.JSON.stringify(g_xrfa_m),util.JSON.stringify(g_xrfb3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc012
            
            #add-point:AFTER FIELD xrfc012 name="input.a.page3.xrfc012"
            IF NOT cl_null(g_xrfb3_d[l_ac].xrfc012) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfb3_d[l_ac].xrfc012 != g_xrfb3_d_t.xrfc012 OR g_xrfb3_d_t.xrfc012 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrfb3_d[l_ac].xrfc012
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00200:sub-01302|axri012|",cl_get_progname("axri012",g_lang,"2"),"|:EXEPROGaxri012"
                  #160318-00025#25  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_oocq002_3111") THEN
                     LET g_xrfb3_d[l_ac].xrfc012 = g_xrfb3_d_t.xrfc012
                     CALL axrt460_ref('xrfc012')
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL axrt460_ref('xrfc012')
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc012
            #add-point:BEFORE FIELD xrfc012 name="input.b.page3.xrfc012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc012
            #add-point:ON CHANGE xrfc012 name="input.g.page3.xrfc012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc012_desc
            #add-point:BEFORE FIELD xrfc012_desc name="input.b.page3.xrfc012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc012_desc
            
            #add-point:AFTER FIELD xrfc012_desc name="input.a.page3.xrfc012_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc012_desc
            #add-point:ON CHANGE xrfc012_desc name="input.g.page3.xrfc012_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc007
            
            #add-point:AFTER FIELD xrfc007 name="input.a.page3.xrfc007"
            IF NOT cl_null(g_xrfb3_d[l_ac].xrfc007) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfb3_d[l_ac].xrfc007 != g_xrfb3_d_t.xrfc007 OR g_xrfb3_d_t.xrfc007 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrfb3_d[l_ac].xrfc007
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="apm-00184:sub-01302|aooi716|",cl_get_progname("aooi716",g_lang,"2"),"|:EXEPROGaooi716"
                  #160318-00025#25  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooib002_1") THEN
                     LET g_xrfb3_d[l_ac].xrfc007 = g_xrfb3_d_t.xrfc007
                     CALL axrt460_ref('xrfc007')
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL axrt460_ref('xrfc007')
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc007
            #add-point:BEFORE FIELD xrfc007 name="input.b.page3.xrfc007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc007
            #add-point:ON CHANGE xrfc007 name="input.g.page3.xrfc007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc007_desc
            #add-point:BEFORE FIELD xrfc007_desc name="input.b.page3.xrfc007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc007_desc
            
            #add-point:AFTER FIELD xrfc007_desc name="input.a.page3.xrfc007_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc007_desc
            #add-point:ON CHANGE xrfc007_desc name="input.g.page3.xrfc007_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc008
            #add-point:BEFORE FIELD xrfc008 name="input.b.page3.xrfc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc008
            
            #add-point:AFTER FIELD xrfc008 name="input.a.page3.xrfc008"
            IF NOT cl_null(g_xrfb3_d[l_ac].xrfc008) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfb3_d[l_ac].xrfc008 != g_xrfb3_d_t.xrfc008 OR g_xrfb3_d_t.xrfc008 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrfb2_d[l_ac].xrfc001
                  LET g_chkparam.arg2 = g_xrfb3_d[l_ac].xrfc008
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
                  #160318-00025#25  by 07900 --add-end
                  IF NOT cl_chk_exist("v_oodb002") THEN
                     LET g_xrfb3_d[l_ac].xrfc008 = g_xrfb3_d_t.xrfc008
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc008
            #add-point:ON CHANGE xrfc008 name="input.g.page3.xrfc008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc009
            
            #add-point:AFTER FIELD xrfc009 name="input.a.page3.xrfc009"
            IF NOT cl_null(g_xrfb3_d[l_ac].xrfc009) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfb3_d[l_ac].xrfc009 != g_xrfb3_d_t.xrfc009 OR g_xrfb3_d_t.xrfc009 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrfb3_d[l_ac].xrfc009
                  LET g_chkparam.arg2 = g_xrfb2_d[l_ac].xrfc001 #法人
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi120",g_lang,"2"),"|:EXEPROGanmi120"
                  #160318-00025#25  by 07900 --add-end
                  IF NOT cl_chk_exist("v_nmas002_1") THEN
                     LET g_xrfb3_d[l_ac].xrfc009 = g_xrfb3_d_t.xrfc009
                     CALL axrt460_ref('xrfc009')
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL axrt460_ref('xrfc009')
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc009
            #add-point:BEFORE FIELD xrfc009 name="input.b.page3.xrfc009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc009
            #add-point:ON CHANGE xrfc009 name="input.g.page3.xrfc009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc009_desc
            #add-point:BEFORE FIELD xrfc009_desc name="input.b.page3.xrfc009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc009_desc
            
            #add-point:AFTER FIELD xrfc009_desc name="input.a.page3.xrfc009_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc009_desc
            #add-point:ON CHANGE xrfc009_desc name="input.g.page3.xrfc009_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc010
            #add-point:BEFORE FIELD xrfc010 name="input.b.page3.xrfc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc010
            
            #add-point:AFTER FIELD xrfc010 name="input.a.page3.xrfc010"
            IF NOT cl_null(g_xrfb3_d[l_ac].xrfc010) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfb3_d[l_ac].xrfc010 != g_xrfb3_d_t.xrfc010 OR g_xrfb3_d_t.xrfc010 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrfb3_d[l_ac].xrfc010
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aap-00002:sub-01302|aapi010|",cl_get_progname("aapi010",g_lang,"2"),"|:EXEPROGaapi010"
                  #160318-00025#25  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_nmaj001") THEN
                     LET g_xrfb3_d[l_ac].xrfc010 = g_xrfb3_d_t.xrfc010
                     CALL axrt460_ref('xrfc010')
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL axrt460_ref('xrfc010')
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc010
            #add-point:ON CHANGE xrfc010 name="input.g.page3.xrfc010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrfc010_desc
            #add-point:BEFORE FIELD xrfc010_desc name="input.b.page3.xrfc010_desc"
            LET g_xrfb3_d[l_ac].xrfc010_desc = g_xrfb3_d[l_ac].xrfc010
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrfc010_desc
            
            #add-point:AFTER FIELD xrfc010_desc name="input.a.page3.xrfc010_desc"
            IF NOT cl_null(g_xrfb3_d[l_ac].xrfc010_desc) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrfb3_d[l_ac].xrfc010_desc != g_xrfb3_d_t.xrfc010 OR g_xrfb3_d_t.xrfc010 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrfb3_d[l_ac].xrfc010_desc
                  #160318-00025#25  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aap-00002:sub-01302|aapi010|",cl_get_progname("aapi010",g_lang,"2"),"|:EXEPROGaapi010"
                  #160318-00025#25  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_nmaj001") THEN
                     LET g_xrfb3_d[l_ac].xrfc010_desc = g_xrfb3_d_t.xrfc010_desc
                     CALL axrt460_ref('xrfc010')
                     NEXT FIELD CURRENT
                  ELSE
                     LET g_xrfb3_d[l_ac].xrfc010 = g_xrfb3_d[l_ac].xrfc010_desc
                  END IF
               END IF
            END IF
            CALL axrt460_ref('xrfc010')
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrfc010_desc
            #add-point:ON CHANGE xrfc010_desc name="input.g.page3.xrfc010_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.xrfc012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc012
            #add-point:ON ACTION controlp INFIELD xrfc012 name="input.c.page3.xrfc012"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb3_d[l_ac].xrfc012             #給予default值
            LET g_qryparam.default2 = "" #g_xrfb3_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "3111"

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_xrfb3_d[l_ac].xrfc012 = g_qryparam.return1              
            #LET g_xrfb3_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_xrfb3_d[l_ac].xrfc012 TO xrfc012              #
            #DISPLAY g_xrfb3_d[l_ac].oocq002 TO oocq002 #應用分類碼
            CALL axrt460_ref('xrfa012')
            NEXT FIELD xrfc012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.xrfc012_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc012_desc
            #add-point:ON ACTION controlp INFIELD xrfc012_desc name="input.c.page3.xrfc012_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrfc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc007
            #add-point:ON ACTION controlp INFIELD xrfc007 name="input.c.page3.xrfc007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb3_d[l_ac].xrfc007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooib001_1()                                #呼叫開窗

            LET g_xrfb3_d[l_ac].xrfc007 = g_qryparam.return1              

            DISPLAY g_xrfb3_d[l_ac].xrfc007 TO xrfc007              #
            CALL axrt460_ref('xrfc007')
            NEXT FIELD xrfc007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.xrfc007_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc007_desc
            #add-point:ON ACTION controlp INFIELD xrfc007_desc name="input.c.page3.xrfc007_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrfc008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc008
            #add-point:ON ACTION controlp INFIELD xrfc008 name="input.c.page3.xrfc008"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb3_d[l_ac].xrfc008             #給予default值
            LET g_qryparam.default2 = "" #g_xrfb3_d[l_ac].oodb002 #稅別代碼
            LET g_qryparam.default3 = "" #g_xrfb3_d[l_ac].oodb005 #含稅否
            LET g_qryparam.default4 = "" #g_xrfb3_d[l_ac].oodb006 #稅率
            
            IF NOT cl_null(g_xrfb2_d[l_ac].xrfc001) THEN
               SELECT ooef019 INTO l_ooef019 FROM ooef_t
                WHERE ooefent = g_enterprise
                 AND ooef001 = g_xrfb2_d[l_ac].xrfc001
            ELSE
               SELECT ooef019 INTO l_ooef019 FROM ooef_t
                WHERE ooefent = g_enterprise
                 AND ooef001 = g_xrfa_m.xrfacomp
            END IF
            LET g_qryparam.arg1 = l_ooef019         #稅區
            LET g_qryparam.where = " oodb008 ='2' " #課稅別=1:零稅

            
            CALL q_oodb002_5()                                #呼叫開窗

            LET g_xrfb3_d[l_ac].xrfc008 = g_qryparam.return1              
            #LET g_xrfb3_d[l_ac].oodb002 = g_qryparam.return2 
            #LET g_xrfb3_d[l_ac].oodb005 = g_qryparam.return3 
            #LET g_xrfb3_d[l_ac].oodb006 = g_qryparam.return4 
            DISPLAY g_xrfb3_d[l_ac].xrfc008 TO xrfc008              #
            #DISPLAY g_xrfb3_d[l_ac].oodb002 TO oodb002 #稅別代碼
            #DISPLAY g_xrfb3_d[l_ac].oodb005 TO oodb005 #含稅否
            #DISPLAY g_xrfb3_d[l_ac].oodb006 TO oodb006 #稅率
            NEXT FIELD xrfc008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.xrfc009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc009
            #add-point:ON ACTION controlp INFIELD xrfc009 name="input.c.page3.xrfc009"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb3_d[l_ac].xrfc009             #給予default值
            LET g_qryparam.default2 = "" #g_xrfb3_d[l_ac].nmas002 #交易帳戶編碼
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_nmas002_6()                                #呼叫開窗

            LET g_xrfb3_d[l_ac].xrfc009 = g_qryparam.return1              
            #LET g_xrfb3_d[l_ac].nmas002 = g_qryparam.return2 
            DISPLAY g_xrfb3_d[l_ac].xrfc009 TO xrfc009              #
            #DISPLAY g_xrfb3_d[l_ac].nmas002 TO nmas002 #交易帳戶編碼
            CALL axrt460_ref('xrfc009')
            NEXT FIELD xrfc009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.xrfc009_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc009_desc
            #add-point:ON ACTION controlp INFIELD xrfc009_desc name="input.c.page3.xrfc009_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrfc010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc010
            #add-point:ON ACTION controlp INFIELD xrfc010 name="input.c.page3.xrfc010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb3_d[l_ac].xrfc010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_nmaj001()                                #呼叫開窗

            LET g_xrfb3_d[l_ac].xrfc010 = g_qryparam.return1              

            DISPLAY g_xrfb3_d[l_ac].xrfc010 TO xrfc010              #

            NEXT FIELD xrfc010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.xrfc010_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrfc010_desc
            #add-point:ON ACTION controlp INFIELD xrfc010_desc name="input.c.page3.xrfc010_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrfb3_d[l_ac].xrfc010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_nmaj001()                                #呼叫開窗

            LET g_xrfb3_d[l_ac].xrfc010_desc = g_qryparam.return1              
            LET g_xrfb3_d[l_ac].xrfc010 = g_xrfb3_d[l_ac].xrfc010_desc
            CALL axrt460_ref('xrfc010')
            DISPLAY g_xrfb3_d[l_ac].xrfc010_desc TO xrfc010_desc              #

            NEXT FIELD xrfc010_desc                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xrfb3_d[l_ac].* = g_xrfb3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axrt460_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axrt460_unlock_b("xrfc_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xrfb2_d[li_reproduce_target].* = g_xrfb2_d[li_reproduce].*
               LET g_xrfb3_d[li_reproduce_target].* = g_xrfb3_d[li_reproduce].*
 
               LET g_xrfb3_d[li_reproduce_target].xrfcseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xrfb3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xrfb3_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="axrt460.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2','3',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD xrfadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xrfbseq
               WHEN "s_detail2"
                  NEXT FIELD xrfcseq
               WHEN "s_detail3"
                  NEXT FIELD xrfcseq_3
 
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
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
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
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   IF l_flag = 'Y' THEN
      CONTINUE WHILE
   ELSE
      #151125-00006#1--add--s
      IF NOT INT_FLAG THEN 
      
         CALL s_aooi200_fin_get_slip(g_xrfa_m.xrfadocno) RETURNING l_success,l_ooba002
         CALL s_fin_get_doc_para(g_xrfa_m.xrfald,g_xrfa_m.xrfacomp,l_ooba002,'D-FIN-0031') RETURNING l_dfin0031
         CALL s_fin_get_doc_para(g_xrfa_m.xrfald,g_xrfa_m.xrfacomp,l_ooba002,'D-FIN-0032') RETURNING l_dfin0032
         
         IF NOT cl_null(l_dfin0031) AND l_dfin0031 MATCHES '[Yy]' THEN 
            IF cl_ask_confirm('aap-00403') THEN
               CALL axrt460_immediately_conf() RETURNING l_success
            END IF 
         END IF
         
      END IF
      #151125-00006#1--add--e 
      EXIT WHILE
   END IF
   
END WHILE
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="axrt460.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axrt460_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   IF g_xrfa_m.xrfastus <> 'N' THEN
      CALL cl_set_act_visible('modify,modify_detail,delete',FALSE)
   ELSE
      CALL cl_set_act_visible('modify,modify_detail,delete',TRUE)
   END IF
   SELECT glaacomp,glaa001,glaa024,glaa025
   INTO g_glaa.glaacomp,g_glaa.glaa001,g_glaa.glaa024,g_glaa.glaa025
   FROM glaa_t 
   WHERE glaaent=g_enterprise AND glaald=g_xrfa_m.xrfald
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL axrt460_b_fill() #單身填充
      CALL axrt460_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axrt460_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_xrfa_m_mask_o.* =  g_xrfa_m.*
   CALL axrt460_xrfa_t_mask()
   LET g_xrfa_m_mask_n.* =  g_xrfa_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xrfa_m.xrfasite,g_xrfa_m.xrfasite_desc,g_xrfa_m.xrfa001,g_xrfa_m.xrfa001_desc,g_xrfa_m.xrfald, 
       g_xrfa_m.xrfald_desc,g_xrfa_m.xrfacomp,g_xrfa_m.xrfadocno,g_xrfa_m.xrfadocdt,g_xrfa_m.xrfa002, 
       g_xrfa_m.xrfa002_desc,g_xrfa_m.xrfastus,g_xrfa_m.xrfaownid,g_xrfa_m.xrfaownid_desc,g_xrfa_m.xrfaowndp, 
       g_xrfa_m.xrfaowndp_desc,g_xrfa_m.xrfacrtid,g_xrfa_m.xrfacrtid_desc,g_xrfa_m.xrfacrtdp,g_xrfa_m.xrfacrtdp_desc, 
       g_xrfa_m.xrfacrtdt,g_xrfa_m.xrfamodid,g_xrfa_m.xrfamodid_desc,g_xrfa_m.xrfamoddt,g_xrfa_m.xrfacnfid, 
       g_xrfa_m.xrfacnfid_desc,g_xrfa_m.xrfacnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xrfa_m.xrfastus 
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
   FOR l_ac = 1 TO g_xrfb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xrfb2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_xrfb3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL axrt460_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrt460.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION axrt460_detail_show()
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
 
{<section id="axrt460.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axrt460_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE xrfa_t.xrfadocno 
   DEFINE l_oldno     LIKE xrfa_t.xrfadocno 
 
   DEFINE l_master    RECORD LIKE xrfa_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xrfb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE xrfc_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_xrfa_m.xrfadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_xrfadocno_t = g_xrfa_m.xrfadocno
 
    
   LET g_xrfa_m.xrfadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xrfa_m.xrfaownid = g_user
      LET g_xrfa_m.xrfaowndp = g_dept
      LET g_xrfa_m.xrfacrtid = g_user
      LET g_xrfa_m.xrfacrtdp = g_dept 
      LET g_xrfa_m.xrfacrtdt = cl_get_current()
      LET g_xrfa_m.xrfamodid = g_user
      LET g_xrfa_m.xrfamoddt = cl_get_current()
      LET g_xrfa_m.xrfastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xrfa_m.xrfastus 
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
   
   
   CALL axrt460_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_xrfa_m.* TO NULL
      INITIALIZE g_xrfb_d TO NULL
      INITIALIZE g_xrfb2_d TO NULL
      INITIALIZE g_xrfb3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL axrt460_show()
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
   CALL axrt460_set_act_visible()   
   CALL axrt460_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xrfadocno_t = g_xrfa_m.xrfadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xrfaent = " ||g_enterprise|| " AND",
                      " xrfadocno = '", g_xrfa_m.xrfadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axrt460_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL axrt460_idx_chk()
   
   LET g_data_owner = g_xrfa_m.xrfaownid      
   LET g_data_dept  = g_xrfa_m.xrfaowndp
   
   #功能已完成,通報訊息中心
   CALL axrt460_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="axrt460.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axrt460_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xrfb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE xrfc_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axrt460_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xrfb_t
    WHERE xrfbent = g_enterprise AND xrfbdocno = g_xrfadocno_t
 
    INTO TEMP axrt460_detail
 
   #將key修正為調整後   
   UPDATE axrt460_detail 
      #更新key欄位
      SET xrfbdocno = g_xrfa_m.xrfadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO xrfb_t SELECT * FROM axrt460_detail
   
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
   DROP TABLE axrt460_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xrfc_t 
    WHERE xrfcent = g_enterprise AND xrfcdocno = g_xrfadocno_t
 
    INTO TEMP axrt460_detail
 
   #將key修正為調整後   
   UPDATE axrt460_detail SET xrfcdocno = g_xrfa_m.xrfadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO xrfc_t SELECT * FROM axrt460_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axrt460_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xrfadocno_t = g_xrfa_m.xrfadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="axrt460.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axrt460_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_success       LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_xrfa_m.xrfadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN axrt460_cl USING g_enterprise,g_xrfa_m.xrfadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axrt460_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axrt460_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axrt460_master_referesh USING g_xrfa_m.xrfadocno INTO g_xrfa_m.xrfasite,g_xrfa_m.xrfa001, 
       g_xrfa_m.xrfald,g_xrfa_m.xrfacomp,g_xrfa_m.xrfadocno,g_xrfa_m.xrfadocdt,g_xrfa_m.xrfa002,g_xrfa_m.xrfastus, 
       g_xrfa_m.xrfaownid,g_xrfa_m.xrfaowndp,g_xrfa_m.xrfacrtid,g_xrfa_m.xrfacrtdp,g_xrfa_m.xrfacrtdt, 
       g_xrfa_m.xrfamodid,g_xrfa_m.xrfamoddt,g_xrfa_m.xrfacnfid,g_xrfa_m.xrfacnfdt,g_xrfa_m.xrfasite_desc, 
       g_xrfa_m.xrfa001_desc,g_xrfa_m.xrfald_desc,g_xrfa_m.xrfa002_desc,g_xrfa_m.xrfaownid_desc,g_xrfa_m.xrfaowndp_desc, 
       g_xrfa_m.xrfacrtid_desc,g_xrfa_m.xrfacrtdp_desc,g_xrfa_m.xrfamodid_desc,g_xrfa_m.xrfacnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT axrt460_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xrfa_m_mask_o.* =  g_xrfa_m.*
   CALL axrt460_xrfa_t_mask()
   LET g_xrfa_m_mask_n.* =  g_xrfa_m.*
   
   CALL axrt460_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   #141226-00016#2 By 01727 Add ---(S)---
   CALL s_axrt300_date_chk(g_xrfa_m.xrfasite,g_xrfa_m.xrfadocdt) RETURNING l_success
   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "axr-00300"
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
      RETURN
   END IF
   #141226-00016#2 By 01727 Add ---(S)---
   #20150309--add--str--
   IF g_xrfa_m.xrfastus <> 'N' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00313'
      LET g_errparam.extend = g_xrfa_m.xrfadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #20150309--add--end--
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axrt460_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_xrfadocno_t = g_xrfa_m.xrfadocno
 
 
      DELETE FROM xrfa_t
       WHERE xrfaent = g_enterprise AND xrfadocno = g_xrfa_m.xrfadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xrfa_m.xrfadocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM xrfb_t
       WHERE xrfbent = g_enterprise AND xrfbdocno = g_xrfa_m.xrfadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrfb_t:",SQLERRMESSAGE 
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
      DELETE FROM xrfc_t
       WHERE xrfcent = g_enterprise AND
             xrfcdocno = g_xrfa_m.xrfadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrfc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      #刪除單號
      IF NOT s_aooi200_fin_del_docno(g_xrfa_m.xrfald,g_xrfa_m.xrfadocno,g_xrfa_m.xrfadocdt) THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      END IF
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_xrfa_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE axrt460_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_xrfb_d.clear() 
      CALL g_xrfb2_d.clear()       
      CALL g_xrfb3_d.clear()       
 
     
      CALL axrt460_ui_browser_refresh()  
      #CALL axrt460_ui_headershow()  
      #CALL axrt460_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL axrt460_browser_fill("")
         CALL axrt460_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE axrt460_cl
 
   #功能已完成,通報訊息中心
   CALL axrt460_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axrt460.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrt460_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_xrfb_d.clear()
   CALL g_xrfb2_d.clear()
   CALL g_xrfb3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF axrt460_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xrfbseq,xrfb001,xrfbld,xrfb007,xrfb006,xrfb004,xrfb002,xrfb003, 
             xrfb100,xrfb101,xrfb103,xrfb104,xrfb005,xrfb201,xrfb204  FROM xrfb_t",   
                     " INNER JOIN xrfa_t ON xrfaent = " ||g_enterprise|| " AND xrfadocno = xrfbdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE xrfbent=? AND xrfbdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xrfb_t.xrfbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axrt460_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axrt460_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xrfa_m.xrfadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xrfa_m.xrfadocno INTO g_xrfb_d[l_ac].xrfbseq,g_xrfb_d[l_ac].xrfb001, 
          g_xrfb_d[l_ac].xrfbld,g_xrfb_d[l_ac].xrfb007,g_xrfb_d[l_ac].xrfb006,g_xrfb_d[l_ac].xrfb004, 
          g_xrfb_d[l_ac].xrfb002,g_xrfb_d[l_ac].xrfb003,g_xrfb_d[l_ac].xrfb100,g_xrfb_d[l_ac].xrfb101, 
          g_xrfb_d[l_ac].xrfb103,g_xrfb_d[l_ac].xrfb104,g_xrfb_d[l_ac].xrfb005,g_xrfb_d[l_ac].xrfb201, 
          g_xrfb_d[l_ac].xrfb204   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL axrt460_ref('xrfb001')
         CALL axrt460_ref('xrfb005')
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
   IF axrt460_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xrfcseq,xrfc001,xrfc002,xrfc006,xrfc013,xrfc003,xrfc004,xrfc005, 
             xrfc011,xrfc100,xrfc101,xrfc103,xrfc104,xrfc201,xrfc204,xrfcseq,xrfc012,xrfc007,xrfc008, 
             xrfc009,xrfc010  FROM xrfc_t",   
                     " INNER JOIN  xrfa_t ON xrfaent = " ||g_enterprise|| " AND xrfadocno = xrfcdocno ",
 
                     "",
                     
                     
                     " WHERE xrfcent=? AND xrfcdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xrfc_t.xrfcseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axrt460_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR axrt460_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_xrfa_m.xrfadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_xrfa_m.xrfadocno INTO g_xrfb2_d[l_ac].xrfcseq,g_xrfb2_d[l_ac].xrfc001, 
          g_xrfb2_d[l_ac].xrfc002,g_xrfb2_d[l_ac].xrfc006,g_xrfb2_d[l_ac].xrfc013,g_xrfb2_d[l_ac].xrfc003, 
          g_xrfb2_d[l_ac].xrfc004,g_xrfb2_d[l_ac].xrfc005,g_xrfb2_d[l_ac].xrfc011,g_xrfb2_d[l_ac].xrfc100, 
          g_xrfb2_d[l_ac].xrfc101,g_xrfb2_d[l_ac].xrfc103,g_xrfb2_d[l_ac].xrfc104,g_xrfb2_d[l_ac].xrfc201, 
          g_xrfb2_d[l_ac].xrfc204,g_xrfb3_d[l_ac].xrfcseq,g_xrfb3_d[l_ac].xrfc012,g_xrfb3_d[l_ac].xrfc007, 
          g_xrfb3_d[l_ac].xrfc008,g_xrfb3_d[l_ac].xrfc009,g_xrfb3_d[l_ac].xrfc010   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         CALL axrt460_ref('xrfc001')
         CALL axrt460_ref('xrfc012')
         CALL axrt460_ref('xrfc007')
         CALL axrt460_ref('xrfc009')
         CALL axrt460_ref('xrfc010')
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
   
   CALL g_xrfb_d.deleteElement(g_xrfb_d.getLength())
   CALL g_xrfb2_d.deleteElement(g_xrfb2_d.getLength())
   CALL g_xrfb3_d.deleteElement(g_xrfb3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axrt460_pb
   FREE axrt460_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_xrfb_d.getLength()
      LET g_xrfb_d_mask_o[l_ac].* =  g_xrfb_d[l_ac].*
      CALL axrt460_xrfb_t_mask()
      LET g_xrfb_d_mask_n[l_ac].* =  g_xrfb_d[l_ac].*
   END FOR
   
   LET g_xrfb2_d_mask_o.* =  g_xrfb2_d.*
   FOR l_ac = 1 TO g_xrfb2_d.getLength()
      LET g_xrfb2_d_mask_o[l_ac].* =  g_xrfb2_d[l_ac].*
      CALL axrt460_xrfc_t_mask()
      LET g_xrfb2_d_mask_n[l_ac].* =  g_xrfb2_d[l_ac].*
   END FOR
   LET g_xrfb3_d_mask_o.* =  g_xrfb3_d.*
   FOR l_ac = 1 TO g_xrfb3_d.getLength()
      LET g_xrfb3_d_mask_o[l_ac].* =  g_xrfb3_d[l_ac].*
      CALL axrt460_xrfc_t_mask()
      LET g_xrfb3_d_mask_n[l_ac].* =  g_xrfb3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="axrt460.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axrt460_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM xrfb_t
       WHERE xrfbent = g_enterprise AND
         xrfbdocno = ps_keys_bak[1] AND xrfbseq = ps_keys_bak[2]
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
         CALL g_xrfb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2','3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM xrfc_t
       WHERE xrfcent = g_enterprise AND
             xrfcdocno = ps_keys_bak[1] AND xrfcseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrfc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_xrfb2_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_xrfb3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axrt460.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axrt460_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO xrfb_t
                  (xrfbent,
                   xrfbdocno,
                   xrfbseq
                   ,xrfb001,xrfbld,xrfb007,xrfb006,xrfb004,xrfb002,xrfb003,xrfb100,xrfb101,xrfb103,xrfb104,xrfb005,xrfb201,xrfb204) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_xrfb_d[g_detail_idx].xrfb001,g_xrfb_d[g_detail_idx].xrfbld,g_xrfb_d[g_detail_idx].xrfb007, 
                       g_xrfb_d[g_detail_idx].xrfb006,g_xrfb_d[g_detail_idx].xrfb004,g_xrfb_d[g_detail_idx].xrfb002, 
                       g_xrfb_d[g_detail_idx].xrfb003,g_xrfb_d[g_detail_idx].xrfb100,g_xrfb_d[g_detail_idx].xrfb101, 
                       g_xrfb_d[g_detail_idx].xrfb103,g_xrfb_d[g_detail_idx].xrfb104,g_xrfb_d[g_detail_idx].xrfb005, 
                       g_xrfb_d[g_detail_idx].xrfb201,g_xrfb_d[g_detail_idx].xrfb204)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrfb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xrfb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2','3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO xrfc_t
                  (xrfcent,
                   xrfcdocno,
                   xrfcseq
                   ,xrfc001,xrfc002,xrfc006,xrfc013,xrfc003,xrfc004,xrfc005,xrfc011,xrfc100,xrfc101,xrfc103,xrfc104,xrfc201,xrfc204,xrfc012,xrfc007,xrfc008,xrfc009,xrfc010) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_xrfb2_d[g_detail_idx].xrfc001,g_xrfb2_d[g_detail_idx].xrfc002,g_xrfb2_d[g_detail_idx].xrfc006, 
                       g_xrfb2_d[g_detail_idx].xrfc013,g_xrfb2_d[g_detail_idx].xrfc003,g_xrfb2_d[g_detail_idx].xrfc004, 
                       g_xrfb2_d[g_detail_idx].xrfc005,g_xrfb2_d[g_detail_idx].xrfc011,g_xrfb2_d[g_detail_idx].xrfc100, 
                       g_xrfb2_d[g_detail_idx].xrfc101,g_xrfb2_d[g_detail_idx].xrfc103,g_xrfb2_d[g_detail_idx].xrfc104, 
                       g_xrfb2_d[g_detail_idx].xrfc201,g_xrfb2_d[g_detail_idx].xrfc204,g_xrfb3_d[g_detail_idx].xrfc012, 
                       g_xrfb3_d[g_detail_idx].xrfc007,g_xrfb3_d[g_detail_idx].xrfc008,g_xrfb3_d[g_detail_idx].xrfc009, 
                       g_xrfb3_d[g_detail_idx].xrfc010)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrfc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_xrfb2_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_xrfb3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      IF ps_page <> "'3'" THEN
         CALL g_xrfb3_d.deleteElement(li_idx)
      END IF
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="axrt460.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axrt460_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xrfb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL axrt460_xrfb_t_mask_restore('restore_mask_o')
               
      UPDATE xrfb_t 
         SET (xrfbdocno,
              xrfbseq
              ,xrfb001,xrfbld,xrfb007,xrfb006,xrfb004,xrfb002,xrfb003,xrfb100,xrfb101,xrfb103,xrfb104,xrfb005,xrfb201,xrfb204) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_xrfb_d[g_detail_idx].xrfb001,g_xrfb_d[g_detail_idx].xrfbld,g_xrfb_d[g_detail_idx].xrfb007, 
                  g_xrfb_d[g_detail_idx].xrfb006,g_xrfb_d[g_detail_idx].xrfb004,g_xrfb_d[g_detail_idx].xrfb002, 
                  g_xrfb_d[g_detail_idx].xrfb003,g_xrfb_d[g_detail_idx].xrfb100,g_xrfb_d[g_detail_idx].xrfb101, 
                  g_xrfb_d[g_detail_idx].xrfb103,g_xrfb_d[g_detail_idx].xrfb104,g_xrfb_d[g_detail_idx].xrfb005, 
                  g_xrfb_d[g_detail_idx].xrfb201,g_xrfb_d[g_detail_idx].xrfb204) 
         WHERE xrfbent = g_enterprise AND xrfbdocno = ps_keys_bak[1] AND xrfbseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrfb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrfb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axrt460_xrfb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2','3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xrfc_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL axrt460_xrfc_t_mask_restore('restore_mask_o')
               
      UPDATE xrfc_t 
         SET (xrfcdocno,
              xrfcseq
              ,xrfc001,xrfc002,xrfc006,xrfc013,xrfc003,xrfc004,xrfc005,xrfc011,xrfc100,xrfc101,xrfc103,xrfc104,xrfc201,xrfc204,xrfc012,xrfc007,xrfc008,xrfc009,xrfc010) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_xrfb2_d[g_detail_idx].xrfc001,g_xrfb2_d[g_detail_idx].xrfc002,g_xrfb2_d[g_detail_idx].xrfc006, 
                  g_xrfb2_d[g_detail_idx].xrfc013,g_xrfb2_d[g_detail_idx].xrfc003,g_xrfb2_d[g_detail_idx].xrfc004, 
                  g_xrfb2_d[g_detail_idx].xrfc005,g_xrfb2_d[g_detail_idx].xrfc011,g_xrfb2_d[g_detail_idx].xrfc100, 
                  g_xrfb2_d[g_detail_idx].xrfc101,g_xrfb2_d[g_detail_idx].xrfc103,g_xrfb2_d[g_detail_idx].xrfc104, 
                  g_xrfb2_d[g_detail_idx].xrfc201,g_xrfb2_d[g_detail_idx].xrfc204,g_xrfb3_d[g_detail_idx].xrfc012, 
                  g_xrfb3_d[g_detail_idx].xrfc007,g_xrfb3_d[g_detail_idx].xrfc008,g_xrfb3_d[g_detail_idx].xrfc009, 
                  g_xrfb3_d[g_detail_idx].xrfc010) 
         WHERE xrfcent = g_enterprise AND xrfcdocno = ps_keys_bak[1] AND xrfcseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrfc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrfc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axrt460_xrfc_t_mask_restore('restore_mask_n')
 
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
 
{<section id="axrt460.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION axrt460_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="axrt460.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axrt460_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axrt460.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axrt460_lock_b(ps_table,ps_page)
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
   #CALL axrt460_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "xrfb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN axrt460_bcl USING g_enterprise,
                                       g_xrfa_m.xrfadocno,g_xrfb_d[g_detail_idx].xrfbseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axrt460_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2','3',"
   #僅鎖定自身table
   LET ls_group = "xrfc_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axrt460_bcl2 USING g_enterprise,
                                             g_xrfa_m.xrfadocno,g_xrfb2_d[g_detail_idx].xrfcseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axrt460_bcl2:",SQLERRMESSAGE 
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
 
{<section id="axrt460.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axrt460_unlock_b(ps_table,ps_page)
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
      CLOSE axrt460_bcl
   END IF
   
   LET ls_group = "'2','3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axrt460_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axrt460.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axrt460_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("xrfadocno,xrfald",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xrfadocno",TRUE)
      CALL cl_set_comp_entry("xrfadocdt",TRUE)
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
 
{<section id="axrt460.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axrt460_set_no_entry(p_cmd)
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
      CALL cl_set_comp_entry("xrfadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("xrfadocno,xrfald",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("xrfadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #151130-00015#2 -begin -add by XZG 20151222
      IF NOT cl_null(g_xrfa_m.xrfadocno) THEN  
            #获取单别
            CALL s_aooi200_fin_get_slip(g_xrfa_m.xrfadocno) RETURNING l_success,l_slip
            #是否可改日期
            CALL s_fin_get_doc_para(g_xrfa_m.xrfald,g_xrfa_m.xrfacomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
            IF l_dfin0033 = "N"  THEN 
               CALL cl_set_comp_entry("xrfadocdt",FALSE)
            ELSE 
               CALL cl_set_comp_entry("xrfadocdt",TRUE)
            END IF          
         END IF 
      #151130-00015#2  -end
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axrt460.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axrt460_set_entry_b(p_cmd)
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
   IF g_xrfb_d[l_ac].xrfb006='10' THEN
      CALL cl_set_comp_entry('xrfb004,xrfb002,xrfb003',TRUE)
      IF g_xrfb_d[l_ac].xrfb004='90' THEN
#         CALL cl_set_comp_entry('xrfb001_desc,xrfb100,xrfb101',TRUE) #160818-00011#1 mark
         CALL cl_set_comp_entry('xrfb100,xrfb101',TRUE) #160818-00011#1 add
         CALL cl_set_comp_required('xrfb002,xrfb003',FALSE)
      ELSE
         CALL cl_set_comp_entry('xrfb001_desc,xrfb100,xrfb101',FALSE)
         CALL cl_set_comp_required('xrfb002,xrfb003',TRUE)
      END IF
      
   ELSE
#       CALL cl_set_comp_entry('xrfb001_desc,xrfb100,xrfb101',TRUE) #160818-00011#1 mark
       CALL cl_set_comp_entry('xrfb100,xrfb101',TRUE) #160818-00011#1 add
       CALL cl_set_comp_required('xrfb002,xrfb003',FALSE)
   END IF
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="axrt460.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axrt460_set_no_entry_b(p_cmd)
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
 
{<section id="axrt460.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axrt460_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axrt460.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axrt460_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_xrfa_m.xrfastus <> 'N' THEN
      CALL cl_set_act_visible('modify,modify_detail,delete',FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axrt460.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axrt460_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axrt460.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axrt460_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axrt460.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axrt460_default_search()
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
      LET ls_wc = ls_wc, " xrfadocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "xrfa_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xrfb_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xrfc_t" 
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
 
{<section id="axrt460.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION axrt460_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_title      LIKE gzzd_t.gzzd005
   DEFINE l_success    LIKE type_t.num5
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_efin5001   LIKE type_t.chr1
   DEFINE l_ooba002    LIKE ooba_t.ooba002
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   #160818-00011#1--add--str--
   #在比较日期之前要重新抓取资料
   IF g_xrfa_m.xrfadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   SELECT xrfasite,xrfadocdt INTO g_xrfa_m.xrfasite,g_xrfa_m.xrfadocdt FROM xrfa_t
    WHERE xrfaent=g_enterprise AND xrfadoco=g_xrfa_m.xrfadocno
   #160818-00011#1--add--end
   #141226-00016#2 By 01727 Add ---(S)---
   CALL s_axrt300_date_chk(g_xrfa_m.xrfasite,g_xrfa_m.xrfadocdt) RETURNING l_success
   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "axr-00300"
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
      RETURN
   END IF
   #141226-00016#2 By 01727 Add ---(S)---
   CALL axrt460_ui_headershow()
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_xrfa_m.xrfadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN axrt460_cl USING g_enterprise,g_xrfa_m.xrfadocno
   IF STATUS THEN
      CLOSE axrt460_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axrt460_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE axrt460_master_referesh USING g_xrfa_m.xrfadocno INTO g_xrfa_m.xrfasite,g_xrfa_m.xrfa001, 
       g_xrfa_m.xrfald,g_xrfa_m.xrfacomp,g_xrfa_m.xrfadocno,g_xrfa_m.xrfadocdt,g_xrfa_m.xrfa002,g_xrfa_m.xrfastus, 
       g_xrfa_m.xrfaownid,g_xrfa_m.xrfaowndp,g_xrfa_m.xrfacrtid,g_xrfa_m.xrfacrtdp,g_xrfa_m.xrfacrtdt, 
       g_xrfa_m.xrfamodid,g_xrfa_m.xrfamoddt,g_xrfa_m.xrfacnfid,g_xrfa_m.xrfacnfdt,g_xrfa_m.xrfasite_desc, 
       g_xrfa_m.xrfa001_desc,g_xrfa_m.xrfald_desc,g_xrfa_m.xrfa002_desc,g_xrfa_m.xrfaownid_desc,g_xrfa_m.xrfaowndp_desc, 
       g_xrfa_m.xrfacrtid_desc,g_xrfa_m.xrfacrtdp_desc,g_xrfa_m.xrfamodid_desc,g_xrfa_m.xrfacnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT axrt460_action_chk() THEN
      CLOSE axrt460_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xrfa_m.xrfasite,g_xrfa_m.xrfasite_desc,g_xrfa_m.xrfa001,g_xrfa_m.xrfa001_desc,g_xrfa_m.xrfald, 
       g_xrfa_m.xrfald_desc,g_xrfa_m.xrfacomp,g_xrfa_m.xrfadocno,g_xrfa_m.xrfadocdt,g_xrfa_m.xrfa002, 
       g_xrfa_m.xrfa002_desc,g_xrfa_m.xrfastus,g_xrfa_m.xrfaownid,g_xrfa_m.xrfaownid_desc,g_xrfa_m.xrfaowndp, 
       g_xrfa_m.xrfaowndp_desc,g_xrfa_m.xrfacrtid,g_xrfa_m.xrfacrtid_desc,g_xrfa_m.xrfacrtdp,g_xrfa_m.xrfacrtdp_desc, 
       g_xrfa_m.xrfacrtdt,g_xrfa_m.xrfamodid,g_xrfa_m.xrfamodid_desc,g_xrfa_m.xrfamoddt,g_xrfa_m.xrfacnfid, 
       g_xrfa_m.xrfacnfid_desc,g_xrfa_m.xrfacnfdt
 
   CASE g_xrfa_m.xrfastus
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
         CASE g_xrfa_m.xrfastus
            
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
      CALL cl_err_collect_init()
      LET l_success=TRUE
      CALL s_transaction_begin()
      SELECT gzzd005 INTO l_title FROM gzzd_t WHERE gzzd001 = 'axrt460' AND gzzd002 = g_lang AND gzzd003 = 'lbl_xrfadocno'
      LET g_coll_title[1] = l_title
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT axrt460_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE axrt460_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT axrt460_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE axrt460_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            CALL axrt460_unconfirm_chk() RETURNING l_success
            IF l_success=TRUE THEN
               CALL axrt460_unconfirm_upd() RETURNING l_success
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            #150602-00057#2 by 02291 add
            CALL s_aooi200_fin_get_slip(g_xrfa_m.xrfadocno) RETURNING l_success,l_ooba002
            CALL s_fin_chk_E5001(g_xrfa_m.xrfald,g_xrfa_m.xrfacomp,l_ooba002) RETURNING l_efin5001
            IF l_efin5001 = 'N' THEN
               IF g_xrfa_m.xrfacrtid = g_user THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00346'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')
                  CLOSE axrt460_cl
                  RETURN
               END IF
            END IF 
            #150602-00057#2 by 02291 add
            CALL axrt460_confirm_chk() RETURNING l_success
            IF l_success=TRUE THEN
               CALL axrt460_confirm_upd() RETURNING l_success
            END IF
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
      g_xrfa_m.xrfastus = lc_state OR cl_null(lc_state) THEN
      CLOSE axrt460_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #151125-00001#4 --- add start ---
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0') 
         RETURN
      END IF
   END IF
   #151125-00001#4 --- add end   ---
   CALL cl_err_collect_show() #160818-00011#1 add
   IF l_success = FALSE  THEN
#      CALL cl_err_collect_show() #160818-00011#1 mark
      CALL s_transaction_end('N','0') 
      RETURN   
   ELSE
      CALL s_transaction_end('Y','0')   
   END IF 
   #end add-point
   
   LET g_xrfa_m.xrfamodid = g_user
   LET g_xrfa_m.xrfamoddt = cl_get_current()
   LET g_xrfa_m.xrfastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE xrfa_t 
      SET (xrfastus,xrfamodid,xrfamoddt) 
        = (g_xrfa_m.xrfastus,g_xrfa_m.xrfamodid,g_xrfa_m.xrfamoddt)     
    WHERE xrfaent = g_enterprise AND xrfadocno = g_xrfa_m.xrfadocno
 
    
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
      EXECUTE axrt460_master_referesh USING g_xrfa_m.xrfadocno INTO g_xrfa_m.xrfasite,g_xrfa_m.xrfa001, 
          g_xrfa_m.xrfald,g_xrfa_m.xrfacomp,g_xrfa_m.xrfadocno,g_xrfa_m.xrfadocdt,g_xrfa_m.xrfa002,g_xrfa_m.xrfastus, 
          g_xrfa_m.xrfaownid,g_xrfa_m.xrfaowndp,g_xrfa_m.xrfacrtid,g_xrfa_m.xrfacrtdp,g_xrfa_m.xrfacrtdt, 
          g_xrfa_m.xrfamodid,g_xrfa_m.xrfamoddt,g_xrfa_m.xrfacnfid,g_xrfa_m.xrfacnfdt,g_xrfa_m.xrfasite_desc, 
          g_xrfa_m.xrfa001_desc,g_xrfa_m.xrfald_desc,g_xrfa_m.xrfa002_desc,g_xrfa_m.xrfaownid_desc,g_xrfa_m.xrfaowndp_desc, 
          g_xrfa_m.xrfacrtid_desc,g_xrfa_m.xrfacrtdp_desc,g_xrfa_m.xrfamodid_desc,g_xrfa_m.xrfacnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_xrfa_m.xrfasite,g_xrfa_m.xrfasite_desc,g_xrfa_m.xrfa001,g_xrfa_m.xrfa001_desc, 
          g_xrfa_m.xrfald,g_xrfa_m.xrfald_desc,g_xrfa_m.xrfacomp,g_xrfa_m.xrfadocno,g_xrfa_m.xrfadocdt, 
          g_xrfa_m.xrfa002,g_xrfa_m.xrfa002_desc,g_xrfa_m.xrfastus,g_xrfa_m.xrfaownid,g_xrfa_m.xrfaownid_desc, 
          g_xrfa_m.xrfaowndp,g_xrfa_m.xrfaowndp_desc,g_xrfa_m.xrfacrtid,g_xrfa_m.xrfacrtid_desc,g_xrfa_m.xrfacrtdp, 
          g_xrfa_m.xrfacrtdp_desc,g_xrfa_m.xrfacrtdt,g_xrfa_m.xrfamodid,g_xrfa_m.xrfamodid_desc,g_xrfa_m.xrfamoddt, 
          g_xrfa_m.xrfacnfid,g_xrfa_m.xrfacnfid_desc,g_xrfa_m.xrfacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE axrt460_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axrt460_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrt460.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axrt460_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xrfb_d.getLength() THEN
         LET g_detail_idx = g_xrfb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xrfb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xrfb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xrfb2_d.getLength() THEN
         LET g_detail_idx = g_xrfb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xrfb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xrfb2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_xrfb3_d.getLength() THEN
         LET g_detail_idx = g_xrfb3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xrfb3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xrfb3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axrt460.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrt460_b_fill2(pi_idx)
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
   
   CALL axrt460_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="axrt460.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axrt460_fill_chk(ps_idx)
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
 
{<section id="axrt460.status_show" >}
PRIVATE FUNCTION axrt460_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrt460.mask_functions" >}
&include "erp/axr/axrt460_mask.4gl"
 
{</section>}
 
{<section id="axrt460.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION axrt460_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL axrt460_show()
   CALL axrt460_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_xrfa_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_xrfb_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_xrfb2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_xrfb3_d))
 
 
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
   #CALL axrt460_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL axrt460_ui_headershow()
   CALL axrt460_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION axrt460_draw_out()
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
   CALL axrt460_ui_headershow()  
   CALL axrt460_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="axrt460.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axrt460_set_pk_array()
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
   LET g_pk_array[1].values = g_xrfa_m.xrfadocno
   LET g_pk_array[1].column = 'xrfadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrt460.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="axrt460.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axrt460_msgcentre_notify(lc_state)
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
   CALL axrt460_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xrfa_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrt460.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION axrt460_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axrt460.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 設置收款類型和帳款類型的scc碼
# Memo...........:
# Usage..........: CALL axrt460_set_scc()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt460_set_scc()
   DEFINE l_sql        STRING
   DEFINE l_str        STRING
   DEFINE l_gzcb002    LIKE gzcb_t.gzcb002
   
   #收款類型
   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8306' AND gzcb004 = '1' AND gzcb005 IS NOT NULL"
   PREPARE axrt460_xrfb006_prep FROM l_sql
   DECLARE axrt460_xrfb006_curs CURSOR FOR axrt460_xrfb006_prep
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH axrt460_xrfb006_curs INTO l_gzcb002
      IF cl_null(l_str) THEN 
         LET l_str = l_gzcb002 
         CONTINUE FOREACH 
      END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH
   CALL cl_set_combo_scc_part('xrfb006','8306',l_str)
   #收款類型
   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8306' AND gzcb004 = '2' "
   PREPARE axrt460_xrfc006_prep FROM l_sql
   DECLARE axrt460_xrfc006_curs CURSOR FOR axrt460_xrfc006_prep
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH axrt460_xrfc006_curs INTO l_gzcb002
      IF cl_null(l_str) THEN 
         LET l_str = l_gzcb002 
         CONTINUE FOREACH 
      END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH
   CALL cl_set_combo_scc_part('xrfc006','8306',l_str)
   
   #收款類型
   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8310' AND gzcb002 <> 'ZZ'"
   PREPARE axrt460_xrfb004_prep FROM l_sql
   DECLARE axrt460_xrfb004_curs CURSOR FOR axrt460_xrfb004_prep
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH axrt460_xrfb004_curs INTO l_gzcb002
      IF cl_null(l_str) THEN 
         LET l_str = l_gzcb002 
         CONTINUE FOREACH 
      END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH
   CALL cl_set_combo_scc_part('xrfb004','8310',l_str)
END FUNCTION

################################################################################
# Descriptions...: 新增預設值
# Memo...........:
# Usage..........: CALL axrt460_insert_default()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt460_insert_default()
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_ooef017       LIKE ooef_t.ooef017
   DEFINE l_site          LIKE ooef_t.ooef001
   DEFINE l_cnt           LIKE type_t.num5
   
   #單據日期
   LET g_xrfa_m.xrfadocdt=g_today
   #帳務中心
   #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
   CALL s_fin_get_account_center('',g_user,'3',g_xrfa_m.xrfadocdt) RETURNING l_success,l_site,g_errno
   #判断该营运据点是否为账务中心，如果不是，抓取该营运据点的所属账务中心
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM ooed_t
   WHERE ooedent=g_enterprise AND ooed001 = '3'
      AND ooed002=l_site
      AND ooed006<=g_xrfa_m.xrfadocdt
      AND (ooed007 IS NULL OR ooed007 >= g_xrfa_m.xrfadocdt)
   IF l_cnt=0 THEN
      SELECT ooed002 INTO g_xrfa_m.xrfasite FROM ooed_t
       WHERE ooedent=g_enterprise AND ooed001 = '3'
         AND ooed004=l_site
         AND ooed006<=g_xrfa_m.xrfadocdt
         AND (ooed007 IS NULL OR ooed007 >= g_xrfa_m.xrfadocdt)
         AND ooed002 <> 'ALL'
       ORDER BY ooed003 DESC
   ELSE
      LET g_xrfa_m.xrfasite=l_site
   END IF
   
   CALL axrt460_ref('xrfasite')

    SELECT ooef017 INTO l_ooef017 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_xrfa_m.xrfasite
      
   SELECT glaald INTO g_xrfa_m.xrfald FROM glaa_t
    WHERE glaaent = g_enterprise AND glaacomp = l_ooef017
      AND glaa014 = 'Y'
   IF NOT cl_null(g_xrfa_m.xrfald) THEN
      #取得帳務組織下所屬成員
      CALL s_fin_account_center_sons_query('3',g_xrfa_m.xrfasite,g_xrfa_m.xrfadocdt,'1')
      CALL s_fin_account_center_with_ld_chk(g_xrfa_m.xrfasite,g_xrfa_m.xrfald,g_user,'3','N','',g_xrfa_m.xrfadocdt) RETURNING l_success,g_errno
   END IF      
   #若取不出資料,則不預設帳別
   IF NOT l_success THEN
      LET g_xrfa_m.xrfald = ''
      LET g_xrfa_m.xrfacomp = ''
   END IF 
   IF NOT cl_null(g_xrfa_m.xrfald) THEN
      CALL axrt460_ref('xrfald') 
      SELECT glaacomp,glaa001,glaa024,glaa025
      INTO g_glaa.glaacomp,g_glaa.glaa001,g_glaa.glaa024,g_glaa.glaa025
      FROM glaa_t 
      WHERE glaaent=g_enterprise AND glaald=g_xrfa_m.xrfald
      LET g_xrfa_m.xrfacomp=g_glaa.glaacomp
   END IF
   #帳務人員
   LET g_xrfa_m.xrfa001 = g_user  
   CALL axrt460_ref('xrfa001')   
END FUNCTION

################################################################################
# Descriptions...: 說明欄位抓取
# Memo...........:
# Usage..........: CALL axrt460_ref(p_field)
# Input parameter: p_field        欄位
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt460_ref(p_field)
   DEFINE p_field       LIKE type_t.chr10
   
   CASE p_field
      WHEN 'xrfasite'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrfa_m.xrfasite
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrfa_m.xrfasite_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xrfa_m.xrfasite_desc
      WHEN 'xrfald'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrfa_m.xrfald
         CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrfa_m.xrfald_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xrfa_m.xrfald_desc
      WHEN 'xrfa001'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrfa_m.xrfa001
         CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
         LET g_xrfa_m.xrfa001_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xrfa_m.xrfa001_desc
      WHEN 'xrfa002'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrfa_m.xrfa002
         CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrfa_m.xrfa002_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xrfa_m.xrfa002_desc
      WHEN 'xrfb001'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrfb_d[l_ac].xrfb001
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrfb_d[l_ac].xrfb001_desc = g_xrfb_d[l_ac].xrfb001,'', g_rtn_fields[1] , ''
#         DISPLAY BY NAME g_xrfb_d[l_ac].xrfb001_desc
      WHEN 'xrfb005'
         CALL s_desc_get_nmajl003_desc(g_xrfb_d[l_ac].xrfb005) RETURNING g_xrfb_d[l_ac].xrfb005_desc
         LET g_xrfb_d[l_ac].xrfb005_desc = g_xrfb_d[l_ac].xrfb005,g_xrfb_d[l_ac].xrfb005_desc
#         DISPLAY BY NAME g_xrfb_d[l_ac].xrfb005_desc
      WHEN 'xrfc001'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xrfb2_d[l_ac].xrfc001
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xrfb2_d[l_ac].xrfc001_desc = g_xrfb2_d[l_ac].xrfc001,'', g_rtn_fields[1] , ''
#         DISPLAY BY NAME g_xrfb2_d[l_ac].xrfc001_desc
      WHEN 'xrfc009'
         CALL s_desc_get_nmas002_desc(g_xrfb3_d[l_ac].xrfc009) RETURNING g_xrfb3_d[l_ac].xrfc009_desc
         DISPLAY BY NAME g_xrfb3_d[l_ac].xrfc009_desc
      WHEN 'xrfc010'
         CALL s_desc_get_nmajl003_desc(g_xrfb3_d[l_ac].xrfc010) RETURNING g_xrfb3_d[l_ac].xrfc010_desc
         LET g_xrfb3_d[l_ac].xrfc010_desc=g_xrfb3_d[l_ac].xrfc010,g_xrfb3_d[l_ac].xrfc010_desc
         DISPLAY BY NAME g_xrfb3_d[l_ac].xrfc010_desc
      WHEN 'xrfc012'
         CALL s_desc_get_acc_desc('3111',g_xrfb3_d[l_ac].xrfc012) RETURNING g_xrfb3_d[l_ac].xrfc012_desc
         DISPLAY BY NAME g_xrfb3_d[l_ac].xrfc012_desc
      WHEN 'xrfc007'
         CALL s_desc_get_ooib002_desc(g_xrfb3_d[l_ac].xrfc007) RETURNING g_xrfb3_d[l_ac].xrfc007_desc
         DISPLAY BY NAME g_xrfb3_d[l_ac].xrfc007_desc
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 繳款單號檢查
# Memo...........:
# Usage..........: CALL axrt460_xrfb002_chk()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt460_xrfb002_chk()
   DEFINE l_nmbastus       LIKE nmba_t.nmbastus
   DEFINE l_nmbbcomp       LIKE nmbb_t.nmbbcomp
   DEFINE l_nmbb006        LIKE nmbb_t.nmbb006
   DEFINE l_nmbb007        LIKE nmbb_t.nmbb007
   DEFINE l_nmbb008        LIKE nmbb_t.nmbb008
   DEFINE l_nmbb009        LIKE nmbb_t.nmbb009
   DEFINE l_nmbb020        LIKE nmbb_t.nmbb020
   DEFINE l_nmbb021        LIKE nmbb_t.nmbb021
   DEFINE l_nmbb023        LIKE nmbb_t.nmbb023
   DEFINE l_nmbb024        LIKE nmbb_t.nmbb024
   DEFINE l_nmbb004        LIKE nmbb_t.nmbb004
   DEFINE l_nmbb005        LIKE nmbb_t.nmbb005
   DEFINE l_nmbb002        LIKE nmbb_t.nmbb002
   DEFINE l_nmbb026        LIKE nmbb_t.nmbb026
   DEFINE l_nmbb029        LIKE nmbb_t.nmbb029
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_s              LIKE type_t.num5
   DEFINE l_amt            LIKE nmbb_t.nmbb057
   DEFINE l_amt1           LIKE nmbb_t.nmbb057
   DEFINE l_pmaa069        LIKE pmaa_t.pmaa069
   DEFINE l_xrde109        LIKE xrde_t.xrde109
   DEFINE l_xrde119        LIKE xrde_t.xrde119
   DEFINE l_xrde109_1      LIKE xrde_t.xrde109
   DEFINE l_xrde119_1      LIKE xrde_t.xrde119
   DEFINE l_nmba009        LIKE nmba_t.nmba009
   DEFINE l_rate1          LIKE xrfb_t.xrfb201
   DEFINE l_rate2          LIKE xrfb_t.xrfb201
   DEFINE ls_js            STRING
   DEFINE lc_param         RECORD
            type           LIKE type_t.chr1,
            apca004        LIKE apca_t.apca004
                       END RECORD
   DEFINE l_xrfb103        LIKE xrfb_t.xrfb103
   DEFINE l_xrfb104        LIKE xrfb_t.xrfb104
   
   LET g_errno=''
   IF g_xrfb_d[l_ac].xrfb006 = '10' THEN
      IF g_xrfb_d[l_ac].xrfb004 MATCHES '[123456]0' THEN
         IF NOT cl_null(g_xrfb_d[l_ac].xrfb002) AND NOT cl_null(g_xrfb_d[l_ac].xrfb003) THEN 
            SELECT nmba009,nmbastus,nmbbcomp,nmbb006,nmbb008,nmbb020,nmbb023,
                   nmbb007,nmbb009,nmbb021,nmbb024,
                   nmbb029,nmbb004,nmbb005,nmbb002,nmbb026
              INTO l_nmba009,l_nmbastus,l_nmbbcomp,l_nmbb006,l_nmbb008,l_nmbb020,l_nmbb023,
                   l_nmbb007,l_nmbb009,l_nmbb021,l_nmbb024,
                   l_nmbb029,l_nmbb004,l_nmbb005,l_nmbb002,l_nmbb026
              FROM nmba_t,nmbb_t
             WHERE nmbaent=nmbbent AND nmbacomp=nmbbcomp 
               AND nmbadocno=nmbbdocno AND nmbbent=g_enterprise
               AND nmbbcomp=g_xrfb_d[l_ac].xrfb001
               AND nmbbdocno=g_xrfb_d[l_ac].xrfb002 
               AND nmbbseq=g_xrfb_d[l_ac].xrfb003
         ELSE
            IF NOT cl_null(g_xrfb_d[l_ac].xrfb002) THEN
               SELECT nmba009,nmbastus,nmbacomp
                 INTO l_nmba009,l_nmbastus,l_nmbbcomp
                 FROM nmba_t
                WHERE nmbaent=g_enterprise AND nmbacomp=g_xrfb_d[l_ac].xrfb001
                  AND nmbadocno=g_xrfb_d[l_ac].xrfb002
            END IF
         END IF
         #判斷單據是否審核
         IF cl_null(l_nmba009) THEN
#            LET g_errno='axr-00053'   #160318-00005#54  mark
            LET g_errno='ain-00265'    #160318-00005#54  add
            RETURN
         END IF
         
         #IF NOT (l_nmbastus='Y' OR l_nmbastus='V') THEN  #161026-00010#2 mark
         IF l_nmbastus <> 'V' THEN                        #161026-00010#2 add
            LET g_errno='ais-00080'
            RETURN
         END IF
         
         LET l_amt=0
         LET l_amt1=0
         IF NOT cl_null(g_xrfb_d[l_ac].xrfb003) THEN
            #判断缴款单款别是否等于录入款别
            IF cl_null(l_nmbb029) OR l_nmbb029 <> g_xrfb_d[l_ac].xrfb004 THEN
               LET g_errno='axr-00274'
               RETURN
            END IF         
            
            IF l_nmbbcomp <> g_xrfb_d[l_ac].xrfb001 THEN
               LET g_errno='axr-00191'
               RETURN
            END IF
            
            #對象合理性判斷
            IF NOT cl_null(l_nmbb026) AND l_nmbb026 <> g_xrfa_m.xrfa002 THEN
               SELECT pmaa069 INTO l_pmaa069 FROM pmaa_t
                WHERE pmaaent = g_enterprise
                  AND pmaa001 = l_nmbb026
               IF l_pmaa069 = 'N' OR cl_null(l_pmaa069) THEN
                  LET g_errno = 'axr-00070'   #該交易單據非帳款核銷客戶!
                  RETURN
               END IF
            END IF
         
            IF cl_null(l_nmbb006) THEN LET l_nmbb006=0  END IF
            IF cl_null(l_nmbb008) THEN LET l_nmbb008=0  END IF
            IF cl_null(l_nmbb020) THEN LET l_nmbb020=0  END IF
            IF cl_null(l_nmbb023) THEN LET l_nmbb023=0  END IF
            IF cl_null(l_nmbb007) THEN LET l_nmbb007=0  END IF
            IF cl_null(l_nmbb009) THEN LET l_nmbb009=0  END IF
            IF cl_null(l_nmbb021) THEN LET l_nmbb021=0  END IF
            IF cl_null(l_nmbb024) THEN LET l_nmbb024=0  END IF
            CALL s_axrt300_sel_ld(g_xrfa_m.xrfald) RETURNING l_success,l_s
            CASE
               WHEN l_s=1 
                  LET l_amt = l_nmbb006 - l_nmbb008
                  LET l_amt1= l_nmbb007 - l_nmbb009
               WHEN l_s=2 
                  LET l_amt = l_nmbb006 - l_nmbb020
                  LET l_amt1= l_nmbb007 - l_nmbb021
               WHEN l_s=3 
                  LET l_amt = l_nmbb006 - l_nmbb023
                  LET l_amt1= l_nmbb007 - l_nmbb024
            END CASE
            
            #抓取預冲未確認金額
            LET l_xrde109 = 0   LET l_xrde119 = 0
            SELECT SUM(xrde109),SUM(xrde119) 
              INTO l_xrde109,l_xrde119 
              FROM xrde_t,xrda_t
             WHERE xrdaent   = g_enterprise
               AND xrdald    = xrdeld
               AND xrdadocno = xrdedocno
               AND xrde003   = g_xrfb_d[l_ac].xrfb002
               AND xrde004   = g_xrfb_d[l_ac].xrfb003
               AND xrdastus  = 'N'
            IF cl_null(l_xrde109) THEN LET l_xrde109 = 0 END IF
            IF cl_null(l_xrde119) THEN LET l_xrde119 = 0 END IF
         
            #抓取直接沖帳未確認金額
            LET l_xrde109_1 = 0   LET l_xrde119_1 = 0
            SELECT SUM(xrde109),SUM(xrde119) 
              INTO l_xrde109_1,l_xrde119_1
              FROM xrde_t,xrca_t
             WHERE xrcaent   = g_enterprise
               AND xrcaent   = xrdeent
               AND xrcald    = xrdeld
               AND xrcadocno = xrdedocno
               AND xrde003   = g_xrfb_d[l_ac].xrfb002
               AND xrde004   = g_xrfb_d[l_ac].xrfb003
               AND xrcastus  = 'N'
            IF cl_null(l_xrde109_1) THEN LET l_xrde109_1 = 0 END IF
            IF cl_null(l_xrde119_1) THEN LET l_xrde119_1 = 0 END IF

            #抓取axrt460集团代收款中未审核金额
            LET l_xrfb103=0     LET l_xrfb104=0
            SELECT SUM(xrfb103),SUM(xrfb104) 
              INTO l_xrfb103,l_xrfb104 
              FROM xrfa_t,xrfb_t
             WHERE xrfaent=xrfbent AND xrfadocno=xrfbdocno
               AND xrfaent=g_enterprise 
               AND xrfb002=g_xrfb_d[l_ac].xrfb002
               AND xrfb003=g_xrfb_d[l_ac].xrfb003
               AND xrfastus='N'
            IF cl_null(l_xrfb103) THEN LET l_xrfb103=0 END IF
            IF cl_null(l_xrfb104) THEN LET l_xrfb104=0 END IF
            
            LET l_amt = l_amt - l_xrde109 - l_xrde109_1 - l_xrfb103
            LET l_amt1= l_amt1- l_xrde119 - l_xrde119_1 - l_xrfb104
            
            IF l_amt <=0 OR l_amt1 <=0 THEN
               LET g_errno='axr-00058'
               RETURN
            END IF
         END IF
      END IF
      IF cl_null(g_errno) AND NOT cl_null(g_xrfb_d[l_ac].xrfb002) 
         AND NOT cl_null(g_xrfb_d[l_ac].xrfb003) THEN
         #款別
         LET g_xrfb_d[l_ac].xrfb004=l_nmbb029 
         LET g_xrfb_d[l_ac].xrfb100=l_nmbb004
         LET g_xrfb_d[l_ac].xrfb101=l_nmbb005
         LET g_xrfb_d[l_ac].xrfb103=l_amt
         LET g_xrfb_d[l_ac].xrfb104=l_amt1
         LET g_xrfb_d[l_ac].xrfb005=l_nmbb002
         CALL axrt460_ref('xrfb005') 
         #對應代收方幣別匯率
#         CALL s_aooi160_get_exrate('2',g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,g_xrfb_d[l_ac].xrfb100,g_glaa.glaa001,0,g_glaa.glaa025)
#         RETURNING g_xrfb_d[l_ac].xrfb201
         LET lc_param.type    = '1'
         LET lc_param.apca004 = g_xrfa_m.xrfa002
         LET ls_js = util.JSON.stringify(lc_param)
         CALL s_fin_get_curr_rate(g_xrfa_m.xrfacomp,g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,g_xrfb_d[l_ac].xrfb100,ls_js)
         RETURNING g_xrfb_d[l_ac].xrfb201,l_rate1,l_rate2
         #換算代收方本幣
         LET g_xrfb_d[l_ac].xrfb204=g_xrfb_d[l_ac].xrfb103 * g_xrfb_d[l_ac].xrfb201
         CALL s_curr_round_ld('1',g_xrfa_m.xrfald,g_glaa.glaa001,g_xrfb_d[l_ac].xrfb204,2) 
                  RETURNING g_sub_success,g_errno,g_xrfb_d[l_ac].xrfb204
         DISPLAY BY NAME g_xrfb_d[l_ac].xrfb004,g_xrfb_d[l_ac].xrfb100,g_xrfb_d[l_ac].xrfb101,
                         g_xrfb_d[l_ac].xrfb103,g_xrfb_d[l_ac].xrfb104,g_xrfb_d[l_ac].xrfb005,
                         g_xrfb_d[l_ac].xrfb201,g_xrfb_d[l_ac].xrfb204
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 應收帳款單檢查
# Memo...........:
# Usage..........: CALL axrt460_xrfc003_chk()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt460_xrfc003_chk()
   DEFINE l_xrcacomp         LIKE xrca_t.xrcacomp
   DEFINE l_xrcald           LIKE xrca_t.xrcald
   DEFINE l_xrcastus         LIKE xrca_t.xrcastus
   DEFINE l_xrca001          LIKE xrca_t.xrca001
   DEFINE l_xrca004          LIKE xrca_t.xrca004
   DEFINE l_xrcc003          LIKE xrcc_t.xrcc003
   DEFINE l_xrcc108          LIKE xrcc_t.xrcc108
   DEFINE l_xrcc118          LIKE xrcc_t.xrcc118
   DEFINE l_xrcc100          LIKE xrcc_t.xrcc100
   DEFINE l_xrcc101          LIKE xrcc_t.xrcc101
   DEFINE l_apcc108          LIKE apcc_t.apcc108
   DEFINE l_apcc118          LIKE apcc_t.apcc118
   DEFINE l_apcc128          LIKE apcc_t.apcc128
   DEFINE l_apcc138          LIKE apcc_t.apcc138
   DEFINE l_xrce109          LIKE xrce_t.xrce109
   DEFINE l_xrce119          LIKE xrce_t.xrce119
   DEFINE l_xrcasite         LIKE xrca_t.xrcasite
   DEFINE l_apca001          LIKE apca_t.apca001
   DEFINE l_cnt3             LIKE type_t.num5
   DEFINE l_rate1            LIKE xrfb_t.xrfb201
   DEFINE l_rate2            LIKE xrfb_t.xrfb201
   DEFINE ls_js              STRING
   DEFINE lc_param           RECORD
            type             LIKE type_t.chr1,
            apca004          LIKE apca_t.apca004
                         END RECORD
   DEFINE l_xrfc103          LIKE xrfc_t.xrfc103
   DEFINE l_xrfc104          LIKE xrfc_t.xrfc104
   
   LET g_errno=' '
   IF g_xrfb2_d[l_ac].xrfc006 = '30' OR g_xrfb2_d[l_ac].xrfc006 = '31' OR g_xrfb2_d[l_ac].xrfc006 = '32' THEN
      IF NOT cl_null(g_xrfb2_d[l_ac].xrfc003) THEN
         SELECT xrcasite,xrcacomp,xrcald,xrcastus,xrca001,xrca004
           INTO l_xrcasite,l_xrcacomp,l_xrcald,l_xrcastus,l_xrca001,l_xrca004
           FROM xrca_t
          WHERE xrcaent=g_enterprise 
            AND xrcadocno=g_xrfb2_d[l_ac].xrfc003
      
         IF SQLCA.sqlcode=100 THEN
            LET g_errno='axr-00197'
            RETURN
         END IF
         IF l_xrcastus <> 'Y' THEN
#            LET g_errno='apr-00059'   #160318-00005#54  mark
            LET g_errno='sub-01302'    #160318-00005#54  add
            RETURN
         END IF
         #160818-00011#1--mark--str--
#         IF l_xrcasite <> g_xrfa_m.xrfasite THEN
#            LET g_errno='axr-00277'
#            RETURN
#         END IF
         #160818-00011#1--mark--end
         IF (NOT cl_null(g_xrfb2_d[l_ac].xrfc001) AND g_xrfb2_d[l_ac].xrfc001 <> l_xrcacomp)
            OR (NOT cl_null(g_xrfb2_d[l_ac].xrfc002) AND g_xrfb2_d[l_ac].xrfc002 <> l_xrcald)
            THEN
            LET g_errno='axr-00198'
            RETURN
         END IF
         #2015/10/30--by--02599--add--str--
         IF g_xrfa_m.xrfa002 <> l_xrca004 THEN
            LET l_cnt3 = NULL
            SELECT COUNT(*) INTO l_cnt3 FROM pmac_t
             WHERE pmacent = g_enterprise
               AND pmac001 = g_xrfa_m.xrfa002
               AND pmac002 = l_xrca004
               AND pmacstus = 'Y'
            IF cl_null(l_cnt3)THEN LET l_cnt3 = 0 END IF       
            IF l_cnt3 = 0 THEN
               LET g_errno = 'aap-00370'
               RETURN    
            END IF   
         END IF 
         #2015/10/30--by--02599--add--end
         IF cl_null(g_xrfb2_d[l_ac].xrfc006) THEN
            IF g_xrfb2_d[l_ac].xrfc006='30' AND l_xrca001[1,1] <> '1' THEN
               LET g_errno='axr-00199'
               RETURN
            END IF
            IF g_xrfb2_d[l_ac].xrfc006='31' AND l_xrca001[1,1] <> '2' THEN
               LET g_errno='axr-00200'
               RETURN
            END IF
         END IF
         IF NOT cl_null(g_xrfb2_d[l_ac].xrfc004) AND NOT cl_null(g_xrfb2_d[l_ac].xrfc005) THEN
            SELECT xrcc003,xrcc108-xrcc109,xrcc118-xrcc119+xrcc113,xrcc100,xrcc101 
              INTO l_xrcc003,l_xrcc108,l_xrcc118,l_xrcc100,l_xrcc101 
              FROM xrcc_t
             WHERE xrccent=g_enterprise  AND xrccld=g_xrfb2_d[l_ac].xrfc002 
               AND  xrccdocno=g_xrfb2_d[l_ac].xrfc003
               AND xrccseq=g_xrfb2_d[l_ac].xrfc004 
               AND xrcc001=g_xrfb2_d[l_ac].xrfc005
            IF cl_null(l_xrcc108) THEN LET l_xrcc108=0 END IF
            IF cl_null(l_xrcc118) THEN LET l_xrcc118=0 END IF
            
            #抓取預冲未確認金額
            SELECT SUM(xrce109),SUM(xrce119) 
              INTO l_xrce109,l_xrce119
              FROM xrce_t,xrda_t
             WHERE xrdaent   = g_enterprise
               AND xrdald    = xrceld
               AND xrdadocno = xrcedocno
               AND xrce003   = g_xrfb2_d[l_ac].xrfc003
               AND xrce004   = g_xrfb2_d[l_ac].xrfc004
               AND xrce005   = g_xrfb2_d[l_ac].xrfc005
               AND xrdastus  = 'N'
               
            IF cl_null(l_xrce109) THEN LET l_xrce109 = 0 END IF
            IF cl_null(l_xrce119) THEN LET l_xrce119 = 0 END IF
            
            #抓取axrt460集团代收付未审核金额
            LET l_xrfc103=0     LET l_xrfc104=0
            SELECT xrfc103,xrfc104
              INTO l_xrfc103,l_xrfc104
              FROM xrfc_t,xrfa_t
             WHERE xrfaent=xrfcent AND xrfadocno=xrfcdocno
               AND xrfaent=g_enterprise
               AND xrfc003=g_xrfb2_d[l_ac].xrfc003
               AND xrfc004=g_xrfb2_d[l_ac].xrfc004
               AND xrfc005=g_xrfb2_d[l_ac].xrfc004
               AND xrfastus='N'
            IF cl_null(l_xrfc103) THEN LET l_xrfc103=0 END IF
            IF cl_null(l_xrfc104) THEN LET l_xrfc104=0 END IF
                          
            LET l_xrcc108 = l_xrcc108 - l_xrce109 - l_xrfc103
            LET l_xrcc118 = l_xrcc118 - l_xrce119 - l_xrfc104
            #未沖金額=0
            IF l_xrcc108 <= 0 OR l_xrcc118 <= 0 THEN
               LET g_errno='axr-00054'
               RETURN
            END IF
         END IF      
      END IF
      IF cl_null(g_errno) THEN
         IF NOT cl_null(g_xrfb2_d[l_ac].xrfc003) AND NOT cl_null(g_xrfb2_d[l_ac].xrfc004) AND 
            NOT cl_null(g_xrfb2_d[l_ac].xrfc005) THEN
            LET g_xrfb2_d[l_ac].xrfc100=l_xrcc100
            LET g_xrfb2_d[l_ac].xrfc101=l_xrcc101
            LET g_xrfb2_d[l_ac].xrfc011=l_xrcc003
            LET g_xrfb2_d[l_ac].xrfc103=l_xrcc108
            LET g_xrfb2_d[l_ac].xrfc104=l_xrcc118
            #對應被代收方幣別匯率
#            CALL s_aooi160_get_exrate('2',g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,g_xrfb2_d[l_ac].xrfc100,g_glaa.glaa001,0,g_glaa.glaa025) 
#            RETURNING g_xrfb2_d[l_ac].xrfc201
            LET lc_param.type    = '1'
            LET lc_param.apca004 = g_xrfa_m.xrfa002
            LET ls_js = util.JSON.stringify(lc_param)
            CALL s_fin_get_curr_rate(g_xrfa_m.xrfacomp,g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,g_xrfb2_d[l_ac].xrfc100,ls_js)
            RETURNING g_xrfb2_d[l_ac].xrfc201,l_rate1,l_rate2
            #換算被代收方本幣
            LET g_xrfb2_d[l_ac].xrfc204 = g_xrfb2_d[l_ac].xrfc103 * g_xrfb2_d[l_ac].xrfc201
            CALL s_curr_round_ld('1',g_xrfa_m.xrfald,g_glaa.glaa001,g_xrfb2_d[l_ac].xrfc204,2) 
                  RETURNING g_sub_success,g_errno,g_xrfb2_d[l_ac].xrfc204
            DISPLAY BY NAME g_xrfb2_d[l_ac].xrfc100,g_xrfb2_d[l_ac].xrfc101,g_xrfb2_d[l_ac].xrfc011,
                            g_xrfb2_d[l_ac].xrfc103,g_xrfb2_d[l_ac].xrfc104,g_xrfb2_d[l_ac].xrfc201,
                            g_xrfb2_d[l_ac].xrfc204
         END IF
      END IF
   END IF
   
   IF g_xrfb2_d[l_ac].xrfc006 = '40' OR g_xrfb2_d[l_ac].xrfc006 = '41' OR g_xrfb2_d[l_ac].xrfc006 = '42' THEN       
      #檢查資料1:存在性;2.可沖金額大於0
      IF NOT cl_null(g_xrfb2_d[l_ac].xrfc003) THEN
         SELECT apcastus,apcald,apcacomp,apca004,apca001
           INTO l_xrcastus,l_xrcald,l_xrcacomp,l_xrca004,l_apca001
           FROM apca_t,apcc_t
          WHERE apcaent = g_enterprise
            AND apcaent = apccent
            AND apcadocno = apccdocno
            AND apcald = apccld
            AND apccdocno = g_xrfb2_d[l_ac].xrfc003
         IF SQLCA.sqlcode=100 THEN
            LET g_errno='axr-00197'
            RETURN
         END IF
         IF l_xrcastus <> 'Y' THEN
#            LET g_errno='apr-00059'   #160318-00005#54  mark
            LET g_errno='sub-01302'    #160318-00005#54  add
            RETURN
         END IF
         IF (NOT cl_null(g_xrfb2_d[l_ac].xrfc001) AND g_xrfb2_d[l_ac].xrfc001 <> l_xrcacomp)
            OR (NOT cl_null(g_xrfb2_d[l_ac].xrfc002) AND g_xrfb2_d[l_ac].xrfc002 <> l_xrcald)
            THEN
            LET g_errno='axr-00198'
            RETURN
         END IF
         #2015/10/30--by--02599--add--str--
         IF l_apca001 = '15' THEN   #員工報支
            IF g_xrfa_m.xrfa002 <> l_xrca004 THEN
               LET g_errno = 'aap-00370'
               RETURN 
            END IF
         ELSE
            IF g_xrfa_m.xrfa002 <> l_xrca004 THEN
               LET l_cnt3 = NULL
               SELECT COUNT(*) INTO l_cnt3 FROM pmac_t
                WHERE pmacent = g_enterprise
                  AND pmac001 = g_xrfa_m.xrfa002
                  AND pmac002 = l_xrca004
                  AND pmacstus = 'Y'
               IF cl_null(l_cnt3)THEN LET l_cnt3 = 0 END IF       
               IF l_cnt3 = 0 THEN
                  LET g_errno = 'aap-00370'
                  RETURN 
               END IF   
            END IF
         END IF
         #2015/10/30--by--02599--add--end
         
         IF NOT cl_null(g_xrfb2_d[l_ac].xrfc004) AND NOT cl_null(g_xrfb2_d[l_ac].xrfc005) THEN
            SELECT SUM(apcc108 - apcc109),SUM(apcc118 - apcc119 + apcc113),SUM(apcc128 - apcc129 + apcc123),SUM(apcc138 - apcc139 + apcc133) 
              INTO l_apcc108,l_apcc118,l_apcc128,l_apcc138
              FROM apcc_t
             WHERE apccent = g_enterprise
               AND apccld = g_xrfa_m.xrfald
               AND apccdocno = g_xrfb2_d[l_ac].xrfc003
               AND apccseq = g_xrfb2_d[l_ac].xrfc004
               AND apcc001 = g_xrfb2_d[l_ac].xrfc005
            
            IF cl_null(l_apcc108) THEN LET l_apcc108 = 0 END IF
            IF cl_null(l_apcc118) THEN LET l_apcc118 = 0 END IF
            IF cl_null(l_apcc128) THEN LET l_apcc128 = 0 END IF
            IF cl_null(l_apcc138) THEN LET l_apcc138 = 0 END IF
            
            #抓取預冲未確認金額
            SELECT SUM(xrce109),SUM(xrce119) 
              INTO l_xrce109,l_xrce119
              FROM xrce_t,xrda_t
             WHERE xrdaent   = g_enterprise
               AND xrdald    = xrceld
               AND xrdadocno = xrcedocno
               AND xrce003   = g_xrfb2_d[l_ac].xrfc003
               AND xrce004   = g_xrfb2_d[l_ac].xrfc004
               AND xrce005   = g_xrfb2_d[l_ac].xrfc005
               AND xrdastus  = 'N'
               
            IF cl_null(l_xrce109) THEN LET l_xrce109 = 0 END IF
            IF cl_null(l_xrce119) THEN LET l_xrce119 = 0 END IF
            
            #抓取axrt460集团代收付未审核金额
            LET l_xrfc103=0     LET l_xrfc104=0
            SELECT xrfc103,xrfc104
              INTO l_xrfc103,l_xrfc104
              FROM xrfc_t,xrfa_t
             WHERE xrfaent=xrfcent AND xrfadocno=xrfcdocno
               AND xrfaent=g_enterprise
               AND xrfc003=g_xrfb2_d[l_ac].xrfc003
               AND xrfc004=g_xrfb2_d[l_ac].xrfc004
               AND xrfc005=g_xrfb2_d[l_ac].xrfc004
               AND xrfastus='N'
            IF cl_null(l_xrfc103) THEN LET l_xrfc103=0 END IF
            IF cl_null(l_xrfc104) THEN LET l_xrfc104=0 END IF
            
            LET l_apcc108 = l_apcc108 - l_xrce109 - l_xrfc103
            LET l_apcc118 = l_apcc118 - l_xrce119 - l_xrfc104
            IF l_apcc108 <= 0 OR l_apcc118 <= 0 THEN
               LET g_errno = 'axr-00058'   
               RETURN
            END IF
         END IF
         IF cl_null(g_errno) THEN
            IF NOT cl_null(g_xrfb2_d[l_ac].xrfc003) AND NOT cl_null(g_xrfb2_d[l_ac].xrfc004) AND 
               NOT cl_null(g_xrfb2_d[l_ac].xrfc005) THEN
               SELECT DISTINCT apcc100,apcc101,apcc003
                 INTO l_xrcc100,l_xrcc101,l_xrcc003
              FROM apcc_t
             WHERE apccent = g_enterprise
               AND apccld = g_xrfa_m.xrfald
               AND apccdocno = g_xrfb2_d[l_ac].xrfc003
               AND apccseq = g_xrfb2_d[l_ac].xrfc004
               AND apcc001 = g_xrfb2_d[l_ac].xrfc005
               
               LET g_xrfb2_d[l_ac].xrfc100=l_xrcc100
               LET g_xrfb2_d[l_ac].xrfc101=l_xrcc101
               LET g_xrfb2_d[l_ac].xrfc011=l_xrcc003
               LET g_xrfb2_d[l_ac].xrfc103=l_apcc108
               LET g_xrfb2_d[l_ac].xrfc104=l_apcc118
               #對應被代收方幣別匯率
#               CALL s_aooi160_get_exrate('2',g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,g_xrfb2_d[l_ac].xrfc100,g_glaa.glaa001,0,g_glaa.glaa025) 
#               RETURNING g_xrfb2_d[l_ac].xrfc201
               LET lc_param.type    = '1'
               LET lc_param.apca004 = g_xrfa_m.xrfa002
               LET ls_js = util.JSON.stringify(lc_param)
               CALL s_fin_get_curr_rate(g_xrfa_m.xrfacomp,g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,g_xrfb2_d[l_ac].xrfc100,ls_js)
               RETURNING g_xrfb2_d[l_ac].xrfc201,l_rate1,l_rate2
               #換算被代收方本幣
               LET g_xrfb2_d[l_ac].xrfc204 = g_xrfb2_d[l_ac].xrfc103 * g_xrfb2_d[l_ac].xrfc201
               CALL s_curr_round_ld('1',g_xrfa_m.xrfald,g_glaa.glaa001,g_xrfb2_d[l_ac].xrfc204,2) 
                  RETURNING g_sub_success,g_errno,g_xrfb2_d[l_ac].xrfc204
               DISPLAY BY NAME g_xrfb2_d[l_ac].xrfc100,g_xrfb2_d[l_ac].xrfc101,g_xrfb2_d[l_ac].xrfc011,
                               g_xrfb2_d[l_ac].xrfc103,g_xrfb2_d[l_ac].xrfc104,g_xrfb2_d[l_ac].xrfc201,
                               g_xrfb2_d[l_ac].xrfc204
            END IF
         END IF
      END IF
   END IF
   #160818-00011#1--add--str--
   CALL s_aapt420_exist_chk(g_xrfb2_d[l_ac].xrfc006,g_xrfa_m.xrfald,g_xrfb2_d[l_ac].xrfc003,g_xrfb2_d[l_ac].xrfc004,g_xrfb2_d[l_ac].xrfc005,g_xrfa_m.xrfa002,'')
    RETURNING g_sub_success,g_errno
   #160818-00011#1--add--end
END FUNCTION

################################################################################
# Descriptions...: 審核檢查
# Memo...........:
# Usage..........: CALL axrt460_confirm_chk()
#                  RETURNING r_success
# Return code....: r_success   返回檢查結果
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt460_confirm_chk()
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_cnt1       LIKE type_t.num5
   DEFINE l_cnt2       LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_xrfb001    LIKE xrfb_t.xrfb001
   DEFINE l_xrfb002    LIKE xrfb_t.xrfb002
   DEFINE l_xrfb003    LIKE xrfb_t.xrfb003
   DEFINE l_xrfb007    LIKE xrfb_t.xrfb007
   DEFINE l_xrfb204    LIKE xrfb_t.xrfb204
   DEFINE l_xrfb101    LIKE xrfb_t.xrfb101
   DEFINE l_xrfb103    LIKE xrfb_t.xrfb103
   DEFINE l_xrfb104    LIKE xrfb_t.xrfb104
   DEFINE l_xrfc001    LIKE xrfc_t.xrfc001
   DEFINE l_xrfc002    LIKE xrfc_t.xrfc002
   DEFINE l_xrfc003    LIKE xrfc_t.xrfc003
   DEFINE l_xrfc004    LIKE xrfc_t.xrfc004
   DEFINE l_xrfc005    LIKE xrfc_t.xrfc005
   DEFINE l_xrfc006    LIKE xrfc_t.xrfc006
   DEFINE l_xrfc013    LIKE xrfc_t.xrfc013
   DEFINE l_xrfc204    LIKE xrfc_t.xrfc204
   DEFINE l_xrfc101    LIKE xrfc_t.xrfc101
   DEFINE l_xrfc103    LIKE xrfc_t.xrfc103
   DEFINE l_xrfc104    LIKE xrfc_t.xrfc104
   DEFINE l_amt        LIKE xrfb_t.xrfb103
   DEFINE l_amt1       LIKE xrfb_t.xrfb103
   DEFINE l_sum        LIKE xrfb_t.xrfb103
   DEFINE l_sum1       LIKE xrfb_t.xrfb103
   DEFINE l_nmbb006    LIKE nmbb_t.nmbb006
   DEFINE l_nmbb008    LIKE nmbb_t.nmbb008
   DEFINE l_nmbb020    LIKE nmbb_t.nmbb020
   DEFINE l_nmbb023    LIKE nmbb_t.nmbb023
   DEFINE l_nmbb007    LIKE nmbb_t.nmbb007
   DEFINE l_nmbb009    LIKE nmbb_t.nmbb009
   DEFINE l_nmbb021    LIKE nmbb_t.nmbb021
   DEFINE l_nmbb024    LIKE nmbb_t.nmbb024
   DEFINE l_xrcc108    LIKE xrcc_t.xrcc108
   DEFINE l_xrcc109    LIKE xrcc_t.xrcc109
   DEFINE l_xrcc118    LIKE xrcc_t.xrcc118
   DEFINE l_xrcc119    LIKE xrcc_t.xrcc119
   DEFINE l_xrcc113    LIKE xrcc_t.xrcc113
   DEFINE l_s          LIKE type_t.num5
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_flag       LIKE type_t.chr1
   DEFINE l_apaf013    LIKE apaf_t.apaf013
   DEFINE l_xrde109    LIKE xrde_t.xrde109
   DEFINE l_xrde119    LIKE xrde_t.xrde119
   DEFINE l_xrde109_1  LIKE xrde_t.xrde109
   DEFINE l_xrde119_1  LIKE xrde_t.xrde119
   DEFINE l_apcc108    LIKE apcc_t.apcc108
   DEFINE l_apcc118    LIKE apcc_t.apcc118
   DEFINE l_xrce109    LIKE xrce_t.xrce109
   DEFINE l_xrce119    LIKE xrce_t.xrce119
   DEFINE l_para_data  LIKE type_t.chr1
   DEFINE l_xrfc009    LIKE xrfc_t.xrfc009
   
   LET r_success=TRUE
   
   #(1)單據是否存在
   IF cl_null(g_xrfa_m.xrfadocno) THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "std-00003"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   #(2)狀態欄位是否為N未審核
   IF g_xrfa_m.xrfastus <> 'N' THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = g_xrfa_m.xrfadocno
      LET g_errparam.code   = "afa-00024"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   #(3)單身是否有資料
   SELECT COUNT(*) INTO l_cnt1 FROM xrfb_t 
   WHERE xrfbent=g_enterprise AND xrfbdocno=g_xrfa_m.xrfadocno
   SELECT COUNT(*) INTO l_cnt2 FROM xrfc_t
   WHERE xrfcent=g_enterprise  AND xrfcdocno=g_xrfa_m.xrfadocno
   IF l_cnt1=0 OR l_cnt2=0 THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = g_xrfa_m.xrfadocno
      LET g_errparam.code   = "axm-00261"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   #(4)判斷單頭法人是否維護集團代收資料
   #單據別
   SELECT apaf013 INTO l_apaf013 FROM apaf_t 
   WHERE apafent=g_enterprise AND apaf001='1' AND apaf011=g_xrfa_m.xrfacomp
   IF SQLCA.sqlcode=100 THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = g_xrfa_m.xrfacomp
      LET g_errparam.code   = "axr-00246"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   ELSE
      IF cl_null(l_apaf013) THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = g_xrfa_m.xrfacomp
         LET g_errparam.code   = 'axr-00208'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      END IF 
   END IF
   
   #(5)單身金額是否小於等於可沖金額
   #(6)收款單身金額是否等於帳款單身金額
   #收款資訊
   LET l_sql="SELECT xrfb001,xrfb002,xrfb003,xrfb007,xrfb103,xrfb104,xrfb204 FROM xrfb_t ",
             " WHERE xrfbent=",g_enterprise,
             "   AND xrfbdocno='",g_xrfa_m.xrfadocno,"' "
   PREPARE axrt460_conf_chk_pr FROM l_sql
   DECLARE axrt460_conf_chk_cs CURSOR FOR axrt460_conf_chk_pr
   
   CALL s_axrt300_sel_ld(g_xrfa_m.xrfald) RETURNING l_success,l_s
   LET l_sum=0  #借方總金額
   LET l_sum1=0 #貸方總金額
   
   FOREACH axrt460_conf_chk_cs INTO l_xrfb001,l_xrfb002,l_xrfb003,l_xrfb007,l_xrfb103,l_xrfb104,l_xrfb204
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      LET l_amt = 0
      LET l_amt1= 0
      IF NOT cl_null(l_xrfb002) AND NOT cl_null(l_xrfb003) THEN
         LET l_nmbb006 = 0
         LET l_nmbb008 = 0
         LET l_nmbb020 = 0
         LET l_nmbb023 = 0
         LET l_nmbb007 = 0
         LET l_nmbb009 = 0
         LET l_nmbb021 = 0
         LET l_nmbb024 = 0
         SELECT nmbb006,nmbb008,nmbb020,nmbb023,
                nmbb007,nmbb009,nmbb021,nmbb024
           INTO l_nmbb006,l_nmbb008,l_nmbb020,l_nmbb023,
                l_nmbb007,l_nmbb009,l_nmbb021,l_nmbb024
           FROM nmbb_t
          WHERE nmbbent=g_enterprise AND nmbbcomp=l_xrfb001
            AND nmbbdocno=l_xrfb002 AND nmbbseq=l_xrfb003
         IF cl_null(l_nmbb006) THEN LET l_nmbb006=0  END IF
         IF cl_null(l_nmbb008) THEN LET l_nmbb008=0  END IF
         IF cl_null(l_nmbb020) THEN LET l_nmbb020=0  END IF
         IF cl_null(l_nmbb023) THEN LET l_nmbb023=0  END IF
         IF cl_null(l_nmbb007) THEN LET l_nmbb007=0  END IF
         IF cl_null(l_nmbb009) THEN LET l_nmbb009=0  END IF
         IF cl_null(l_nmbb021) THEN LET l_nmbb021=0  END IF
         IF cl_null(l_nmbb024) THEN LET l_nmbb024=0  END IF
         CASE
            WHEN l_s=1 
               LET l_amt = l_nmbb006 - l_nmbb008
               LET l_amt1= l_nmbb007 - l_nmbb009
            WHEN l_s=2 
               LET l_amt = l_nmbb006 - l_nmbb020
               LET l_amt1= l_nmbb007 - l_nmbb021
            WHEN l_s=3 
               LET l_amt = l_nmbb006 - l_nmbb023
               LET l_amt1= l_nmbb007 - l_nmbb024
         END CASE
         
         #抓取預冲未確認金額
         LET l_xrde109 = 0   LET l_xrde119 = 0
         SELECT SUM(xrde109),SUM(xrde119) 
           INTO l_xrde109,l_xrde119 
           FROM xrde_t,xrda_t
          WHERE xrdaent   = g_enterprise
            AND xrdald    = xrdeld
            AND xrdadocno = xrdedocno
            AND xrde003   = l_xrfb002
            AND xrde004   = l_xrfb003
            AND xrdastus  = 'N'
         IF cl_null(l_xrde109) THEN LET l_xrde109 = 0 END IF
         IF cl_null(l_xrde119) THEN LET l_xrde119 = 0 END IF
      
         #抓取直接沖帳未確認金額
         LET l_xrde109_1 = 0   LET l_xrde119_1 = 0
         SELECT SUM(xrde109),SUM(xrde119) 
           INTO l_xrde109_1,l_xrde119_1
           FROM xrde_t,xrca_t
          WHERE xrcaent   = g_enterprise
            AND xrcaent   = xrdeent
            AND xrcald    = xrdeld
            AND xrcadocno = xrdedocno
            AND xrde003   = l_xrfb002
            AND xrde004   = l_xrfb003
            AND xrcastus  = 'N'
         IF cl_null(l_xrde109_1) THEN LET l_xrde109_1 = 0 END IF
         IF cl_null(l_xrde119_1) THEN LET l_xrde119_1 = 0 END IF
                 
         LET l_amt = l_amt - l_xrde109 - l_xrde109_1
         LET l_amt1= l_amt1- l_xrde119 - l_xrde119_1
         
         IF l_xrfb103 > l_amt  THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_xrfb002
            LET g_errparam.code   = "axr-00192"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         END IF
         IF l_xrfb104 > l_amt1 THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_xrfb002
            LET g_errparam.code   = "axr-00193"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         END IF
      END IF
      #對應單頭幣別金額
      IF cl_null(l_xrfb204) THEN LET l_xrfb204=0 END IF
      IF l_xrfb007='D' THEN #借方
         LET l_sum=l_sum+l_xrfb204
      ELSE #貸方
         LET l_sum1=l_sum1+l_xrfb204
      END IF
   END FOREACH
   
   #是否采用內部銀行帳戶處理
   CALL cl_get_para(g_enterprise,"","E-FIN-0001") RETURNING l_para_data
   
   #帳款資訊
   LET l_sql="SELECT xrfc001,xrfc002,xrfc003,xrfc004,xrfc005,xrfc006,xrfc009,xrfc013,xrfc103,xrfc104,xrfc204 FROM xrfc_t ",
             " WHERE xrfcent=",g_enterprise,
             "   AND xrfcdocno='",g_xrfa_m.xrfadocno,"' "
   PREPARE axrt460_conf_chk_pr1 FROM l_sql
   DECLARE axrt460_conf_chk_cs1 CURSOR FOR axrt460_conf_chk_pr1
   
   FOREACH axrt460_conf_chk_cs1 INTO l_xrfc001,l_xrfc002,l_xrfc003,l_xrfc004,l_xrfc005,l_xrfc006,
                                     l_xrfc009,l_xrfc013,l_xrfc103,l_xrfc104,l_xrfc204
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      #(4)判斷單頭法人是否維護集團代收資料
      #單據別
      LET l_apaf013 = ''
      SELECT apaf013 INTO l_apaf013 FROM apaf_t 
      WHERE apafent=g_enterprise AND apaf001='1' AND apaf011=l_xrfc001
      IF SQLCA.sqlcode=100 THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_xrfc001
         LET g_errparam.code   = "axr-00246"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      ELSE
         IF cl_null(l_apaf013) THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_xrfc001
            LET g_errparam.code   = 'axr-00208'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         END IF 
      END IF
      #金額比較
      LET l_amt = 0
      LET l_amt1= 0
      IF l_xrfc006 = '30' OR l_xrfc006 = '31' OR l_xrfc006 = '32' THEN
         LET l_xrcc108 = 0  
         LET l_xrcc109 = 0   
         LET l_xrcc118 = 0  
         LET l_xrcc119 = 0  
         LET l_xrcc113 = 0
         SELECT xrcc108,xrcc109,xrcc118,xrcc119,xrcc113
           INTO l_xrcc108,l_xrcc109,l_xrcc118,l_xrcc119,l_xrcc113
           FROM xrcc_t
          WHERE xrccent=g_enterprise  AND xrccld=l_xrfc002 
            AND xrccdocno=l_xrfc003
            AND xrccseq=l_xrfc004 
            AND xrcc001=l_xrfc005
         IF cl_null(l_xrcc108) THEN LET l_xrcc108=0 END IF
         IF cl_null(l_xrcc109) THEN LET l_xrcc109=0 END IF
         IF cl_null(l_xrcc118) THEN LET l_xrcc118=0 END IF
         IF cl_null(l_xrcc119) THEN LET l_xrcc119=0 END IF
         IF cl_null(l_xrcc113) THEN LET l_xrcc113=0 END IF
         LET l_amt=l_xrcc108-l_xrcc109 
         LET l_amt1=l_xrcc118-l_xrcc119+l_xrcc113 
      
         #抓取預冲未確認金額
         LET l_xrce109 = 0
         LET l_xrce119 = 0
         SELECT SUM(xrce109),SUM(xrce119) 
           INTO l_xrce109,l_xrce119
           FROM xrce_t,xrda_t
          WHERE xrdaent   = g_enterprise
            AND xrdald    = xrceld
            AND xrdadocno = xrcedocno
            AND xrce003   = l_xrfc003
            AND xrce004   = l_xrfc004
            AND xrce005   = l_xrfc005
            AND xrdastus  = 'N'
            
         IF cl_null(l_xrce109) THEN LET l_xrce109 = 0 END IF
         IF cl_null(l_xrce119) THEN LET l_xrce119 = 0 END IF
         LET l_amt = l_amt - l_xrce109
         LET l_amt1= l_amt1- l_xrce119
      END IF
      
      IF l_xrfc006 = '40' OR l_xrfc006 = '41' OR l_xrfc006 = '42' THEN
         LET l_apcc108 = 0
         LET l_apcc118 = 0     
         SELECT SUM(apcc108 - apcc109),SUM(apcc118 - apcc119 + apcc113) 
           INTO l_apcc108,l_apcc118
           FROM apcc_t
          WHERE apccent = g_enterprise
            AND apccld = g_xrfa_m.xrfald
            AND apccdocno = l_xrfc003
            AND apccseq = l_xrfc004
            AND apcc001 = l_xrfc005
         
         IF cl_null(l_apcc108) THEN LET l_apcc108 = 0 END IF
         IF cl_null(l_apcc118) THEN LET l_apcc118 = 0 END IF
         
         #抓取預冲未確認金額
         LET l_xrce109 = 0
         LET l_xrce119 = 0
         SELECT SUM(xrce109),SUM(xrce119) 
           INTO l_xrce109,l_xrce119
           FROM xrce_t,xrda_t
          WHERE xrdaent   = g_enterprise
            AND xrdald    = xrceld
            AND xrdadocno = xrcedocno
            AND xrce003   = l_xrfc003
            AND xrce004   = l_xrfc004
            AND xrce005   = l_xrfc005
            AND xrdastus  = 'N'
            
         IF cl_null(l_xrce109) THEN LET l_xrce109 = 0 END IF
         IF cl_null(l_xrce119) THEN LET l_xrce119 = 0 END IF
         LET l_amt = l_apcc108 - l_xrce109
         LET l_amt1= l_apcc118 - l_xrce119 
      END IF
      
      IF l_xrfc103 > l_amt OR l_xrfc104 > l_amt1 THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_xrfc003
         LET g_errparam.code   = "axr-00058"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      END IF
      #對應單頭幣別金額
      IF cl_null(l_xrfc204) THEN LET l_xrfc204=0 END IF
      IF l_xrfc013='D' THEN #借方
         LET l_sum=l_sum + l_xrfc204
      ELSE #貸方
         LET l_sum1=l_sum1 + l_xrfc204
      END IF
      #当该法人不等于单头法人时须判断是否要维护内部银行账号,如果需要维护，怎判断内部银行账户是否有值
      #內部銀行帳戶處理
      IF l_para_data='Y' THEN
         IF l_xrfc001 <> g_xrfa_m.xrfacomp THEN
            IF cl_null(l_xrfc009) THEN
               LET r_success = FALSE
               INITIALIZE g_errparam TO NULL
#               LET g_errparam.extend = l_xrfc003 #160818-00011#1 mark
               LET g_errparam.extend = l_xrfc001  #160818-00011#1 add
               LET g_errparam.code   = "axr-00294"
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
         END IF
      END IF
   END FOREACH
   IF l_sum <> l_sum1 THEN
      IF l_sum > l_sum1 THEN 
         LET l_flag='1' #收款>帳款
         LET l_amt=l_sum - l_sum1
      ELSE
         LET l_flag='2' #收款<帳款
         LET l_amt=l_sum1 - l_sum
      END IF
      
      CALL axrt460_01(g_xrfa_m.xrfadocno,l_flag,l_amt) RETURNING l_success
      IF l_success=FALSE THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = g_xrfa_m.xrfadocno
         LET g_errparam.code   = "axr-00205"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      ELSE
         CALL axrt460_b_fill()
      END IF
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 审核更新对应帐款资料，以及更新单据状态
# Memo...........:
# Usage..........: CALL axrt460_confirm_upd()
#                  RETURNING r_success
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt460_confirm_upd()
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_today          LIKE xrfa_t.xrfadocdt
   DEFINE l_sql            STRING
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_para_data      LIKE type_t.chr1
   DEFINE l_xrdald         LIKE xrda_t.xrdald
   DEFINE l_xrdadocno      LIKE xrda_t.xrdadocno
   DEFINE l_xrde119        LIKE xrde_t.xrde119
   DEFINE l_xrde129        LIKE xrde_t.xrde129
   DEFINE l_xrde139        LIKE xrde_t.xrde139
   DEFINE l_xrce119        LIKE xrce_t.xrce119
   DEFINE l_xrce129        LIKE xrce_t.xrce129
   DEFINE l_xrce139        LIKE xrce_t.xrce139
   DEFINE l_xrdasite       LIKE xrda_t.xrdasite
   DEFINE l_xrdacomp       LIKE xrda_t.xrdacomp
   DEFINE l_xrda003        LIKE xrda_t.xrda003
   DEFINE l_xrda004        LIKE xrda_t.xrda004
   DEFINE l_xrdadocdt      LIKE xrda_t.xrdadocdt
   DEFINE l_amt            LIKE xrde_t.xrde119
   DEFINE l_glaa015        LIKE glaa_t.glaa015
   DEFINE l_glaa019        LIKE glaa_t.glaa019
   DEFINE l_glaa121        LIKE glaa_t.glaa121
   DEFINE l_wc             STRING
   DEFINE l_xrdacnfdt      LIKE xrda_t.xrdacnfdt #160818-00011#1 add
   
   LET r_success=TRUE
   #检查:应在事物中的
   IF NOT s_transaction_chk('Y','0') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #160818-00011#1--add--str--
   #集团代收是否产生其他应收单和待抵单
   CALL cl_get_para(g_enterprise,"","E-FIN-0002") RETURNING l_para_data 
   #当E-FIN-0002=N 时，只产生axrt400的单据资料，产生资料过程中错误不报错
   IF l_para_data='N' THEN
      CALL cl_err_collect_show()
      CALL cl_err_collect_init()
   END IF
   #160818-00011#1--add--end
   
   #(1)產生axrt400沖帳資料
   CALL axrt460_gen_axrt400() RETURNING l_success
   IF l_para_data='Y' THEN #160818-00011#1 add #当E-FIN-0002=Y 时，才记录产生axrt400时的报错信息
      IF l_success = FALSE THEN
         LET r_success = l_success
      END IF
   END IF #160818-00011#1 add
   
   #(2)審核axrt400資料
   #160818-00011#1--mod--str--
#   IF r_success = TRUE THEN
   #当E-FIN-0002=Y 时，才可以审核
   IF r_success = TRUE AND l_para_data='Y' THEN
   #160818-00011#1--mod--end
      LET l_sql = "SELECT xrdald,xrdadocno FROM xrda_t ",
                  " WHERE xrdaent = ",g_enterprise," AND xrda010 = '",g_xrfa_m.xrfadocno,"'"
      PREPARE axrt460_conf_axrt400_pr FROM l_sql
      DECLARE axrt460_conf_axrt400_cs CURSOR FOR axrt460_conf_axrt400_pr
      FOREACH axrt460_conf_axrt400_cs INTO l_xrdald,l_xrdadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         #審核產生的axrt400沖帳資料
         CALL s_axrt400_confirm(l_xrdald,l_xrdadocno) RETURNING g_errno
         IF g_errno = 'V' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_xrdadocno
            LET g_errparam.code   = 'axr-00292'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CONTINUE FOREACH
         END IF
         
         #當金額存在差異時調用axrt400_09產生差異資料
         IF g_errno = 'S' THEN
            #抓取收款金額
            SELECT SUM(xrde119 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END),SUM(xrde129 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END),SUM(xrde139 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END)
              INTO l_xrde119,l_xrde129,l_xrde139
              FROM xrde_t,gzcb_t
             WHERE xrdeent   = g_enterprise
               AND xrdeld    = l_xrdald
               AND xrdedocno = l_xrdadocno
               AND xrde002   = gzcb002
               AND gzcb001   = '8306'
               AND gzcb004   = '1'
            IF cl_null(l_xrde119) THEN LET l_xrde119 = 0 END IF
            IF cl_null(l_xrde129) THEN LET l_xrde129 = 0 END IF
            IF cl_null(l_xrde139) THEN LET l_xrde139 = 0 END IF
            
            #抓取帳款金額
            SELECT SUM(xrce119 * CASE WHEN gzcb003 = 'C' THEN 1 ELSE -1 END),SUM(xrce129 * CASE WHEN gzcb003 = 'C' THEN 1 ELSE -1 END),SUM(xrce139 * CASE WHEN gzcb003 = 'C' THEN 1 ELSE -1 END)
              INTO l_xrce119,l_xrce129,l_xrce139
              FROM xrce_t,gzcb_t
             WHERE xrceent   = g_enterprise
               AND xrceld    = l_xrdald
               AND xrcedocno = l_xrdadocno
               AND xrce002   = gzcb002
               AND gzcb001   = '8306'
               AND gzcb004   = '2'
            IF cl_null(l_xrce119) THEN LET l_xrce119 = 0 END IF
            IF cl_null(l_xrce129) THEN LET l_xrce129 = 0 END IF
            IF cl_null(l_xrce139) THEN LET l_xrce139 = 0 END IF
            
            SELECT glaa015,glaa019,glaa121 INTO l_glaa015,l_glaa019,l_glaa121 FROM glaa_t
            WHERE glaaent=g_enterprise AND glaald=l_xrdald
            #若存在差異金額,則CALL axrt400_09() 選擇差異處理,然後返回
            LET l_amt = l_xrde119 - l_xrce119
            IF l_amt = 0 AND l_glaa015 = 'Y' AND l_xrde129 - l_xrde129 <> 0 THEN
               LET l_amt = l_xrde129 - l_xrde129 
            END IF
            IF l_amt = 0 AND l_glaa019 = 'Y' AND l_xrde139 - l_xrce139 <> 0 THEN
               LET l_amt = l_xrde139 - l_xrce139
            END IF
            LET g_prog='axrt460'
            IF l_amt <> 0 THEN
               SELECT xrdasite,xrdacomp,xrda003,xrda004,xrdadocdt
                 INTO l_xrdasite,l_xrdacomp,l_xrda003,l_xrda004,l_xrdadocdt
                 FROM xrda_t
                WHERE xrdaent=g_enterprise AND xrdald=l_xrdald AND xrdadocno=l_xrdadocno
               IF l_amt > 0 THEN
                  CALL axrt400_09('1',l_xrdasite,l_xrdacomp,l_xrda003,l_xrda004,l_xrdadocno,l_xrdadocdt,l_xrdald,l_amt)
               ELSE
                  LET l_amt = l_amt * -1
                  CALL axrt400_09('2',l_xrdasite,l_xrdacomp,l_xrda003,l_xrda004,l_xrdadocno,l_xrdadocdt,l_xrdald,l_amt)
               END IF
            END IF
            #重新產生分錄底稿
            IF l_glaa121 = 'Y' THEN 
               #先刪除底稿
               CALL s_pre_voucher_del('AR','R20',l_xrdald,l_xrdadocno) RETURNING l_success
               IF l_success = FALSE THEN 
                  LET r_success = FALSE
               END IF
               CALL s_pre_voucher_ins('AR','R20',l_xrdald,l_xrdadocno,l_xrdadocdt,'2') RETURNING l_success
               
               IF l_success = TRUE THEN 
                  LET l_wc = "glgadocno = '",l_xrdadocno,"'"
                  CALL s_pre_voucher_upd('AR','R20',l_xrdald,'Y','','',l_wc) RETURNING l_success
               END IF
            END IF
            #差異處理完后，重新執行審核操作
            LET g_errno = NULL
            #審核產生的axrt400沖帳資料
            CALL s_axrt400_confirm(l_xrdald,l_xrdadocno) RETURNING g_errno
            IF g_errno = 'V' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = l_xrdadocno
               LET g_errparam.code   = 'axr-00292'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               CONTINUE FOREACH
            END IF
            IF g_errno = 'S' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = l_xrdadocno
               LET g_errparam.code   = 'aap-00189'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
         END IF
         IF g_errno <> 'Y' THEN
            LET r_success = FALSE
         END IF
         
         #160818-00011#1--add--str--
         #更新axrt400单头状态为审核
         IF r_success = TRUE THEN
            LET l_xrdacnfdt = cl_get_current()
            UPDATE xrda_t SET xrdastus = 'Y',
                              xrdacnfid= g_user,
                              xrdacnfdt= l_xrdacnfdt
             WHERE xrdaent = g_enterprise AND xrdald = l_xrdald AND xrdadocno = l_xrdadocno
            IF SQLCA.sqlcode THEN
               LET r_success = FALSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'sub-00034'
               LET g_errparam.extend = l_xrdadocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
            END IF
         END IF
         #160818-00011#1--add--end
      END FOREACH
   END IF
   
   #160818-00011#1--add--str--
   #当E-FIN-0002=N 时，只产生axrt400的单据资料，产生资料过程中错误不报错
   IF l_para_data='N' THEN
      CALL cl_err_collect_init()   
   END IF
   #160818-00011#1--add--end
   
   #(3)內部銀行帳戶處理
   CALL cl_get_para(g_enterprise,"","E-FIN-0001") RETURNING l_para_data
   IF l_para_data='Y' THEN
      CALL axrt460_ins_nmbc() RETURNING l_success
      IF l_success = FALSE THEN
         LET r_success = l_success
      END IF
   END IF
   
   #(4)更新狀態欄位
   LET l_today  = cl_get_current()
   #检查完毕，更新狀態碼=已確認,確認人=登入user,確認日期=g_today
   UPDATE xrfa_t SET xrfastus = 'Y',
                     xrfacnfid = g_user,
                     xrfacnfdt = l_today
               WHERE xrfaent = g_enterprise
                 AND xrfadocno = g_xrfa_m.xrfadocno
                 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "upd xrfa_t"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF  
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取消審核檢查
# Memo...........:
# Usage..........: CALL axrt460_unconfirm_chk()
#                  RETURNING r_success
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt460_unconfirm_chk()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_cnt          LIKE type_t.num5
   
   LET r_success=TRUE
   
   #(1)狀態欄位是否為Y審核
   IF g_xrfa_m.xrfastus <> 'Y' THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = g_xrfa_m.xrfadocno
      LET g_errparam.code   = "anm-00056"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取消審核更新
# Memo...........:
# Usage..........: CALL axrt460_unconfirm_upd()
#                  RETURNING r_success
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt460_unconfirm_upd()
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_xrdald     LIKE xrda_t.xrdald
   DEFINE l_xrdadocno  LIKE xrda_t.xrdadocno
   DEFINE l_xrdadocdt  LIKE xrda_t.xrdadocdt
   DEFINE l_para_data  LIKE type_t.chr1
   DEFINE l_glaa121    LIKE glaa_t.glaa121
   DEFINE l_xrdastus   LIKE xrda_t.xrdastus #160818-00011#1 add

   LET r_success=TRUE
   
   SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrfa_m.xrfald
   
   #(1)axrt400沖帳資料會寫
   LET l_sql = "SELECT xrdald,xrdadocno,xrdadocdt,xrdastus FROM xrda_t ",  #160818-00011#1 add xrdastus
               " WHERE xrdaent = ",g_enterprise," AND xrda010 = '",g_xrfa_m.xrfadocno,"'"
   PREPARE axrt460_unconf_axrt400_pr FROM l_sql
   DECLARE axrt460_unconf_axrt400_cs CURSOR FOR axrt460_unconf_axrt400_pr
   FOREACH axrt460_unconf_axrt400_cs INTO l_xrdald,l_xrdadocno,l_xrdadocdt,l_xrdastus #160818-00011#1 add l_xrdastus
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      #当axrt400的单据已经审核，就要先做审核操作，然后在删除axrt400单据；如果没有审核，只要执行删除就可以了
      IF l_xrdastus = 'Y' THEN #160818-00011#1 add
         #取消審核產生的axrt400沖帳資料
         CALL s_axrt400_unconfirm(l_xrdald,l_xrdadocno) RETURNING g_errno
         IF g_errno <> 'Y' THEN
            LET r_success = FALSE
         END IF
      END IF #160818-00011#1 add
      
      #(2)删除產生的axrt400沖帳資料
      DELETE FROM xrde_t WHERE xrdeent=g_enterprise AND xrdedocno=l_xrdadocno
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "del xrde_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      DELETE FROM xrce_t WHERE xrceent=g_enterprise AND xrcedocno=l_xrdadocno
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "del xrce_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      
      IF l_glaa121 = 'Y' THEN
         CALL s_pre_voucher_del('AR','R20',l_xrdald,l_xrdadocno) RETURNING l_success
         
         IF l_success = FALSE THEN 
            LET r_success = FALSE
         END IF
      END IF
      
      DELETE FROM xrda_t WHERE xrdaent=g_enterprise AND xrdadocno=l_xrdadocno
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "del xrda_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      #刪除單號
      LET g_prog='axrt400'
      IF NOT s_aooi200_fin_del_docno(l_xrdald,l_xrdadocno,l_xrdadocdt) THEN
         LET r_success = FALSE
      END IF
      LET g_prog='axrt460'
   END FOREACH

   
   
   #(3)內部銀行帳戶處理
   CALL cl_get_para(g_enterprise,"","E-FIN-0001") RETURNING l_para_data
   IF l_para_data='Y' THEN
      DELETE FROM nmbc_t WHERE nmbcent=g_enterprise AND nmbcdocno=g_xrfa_m.xrfadocno
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "del nmbc_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END IF
   
   #(4)更新狀態欄位
   UPDATE xrfa_t SET xrfastus = 'N',
                     xrfacnfid = '',
                     xrfacnfdt = ''
               WHERE xrfaent = g_enterprise
                 AND xrfadocno = g_xrfa_m.xrfadocno
                 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "upd xrfa_t"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF  
   RETURN r_success
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
PRIVATE FUNCTION axrt460_diff()
   DEFINE l_sql        STRING
   DEFINE l_xrfb007    LIKE xrfb_t.xrfb007
   DEFINE l_xrfb204    LIKE xrfb_t.xrfb204
   DEFINE l_xrfb101    LIKE xrfb_t.xrfb101
   DEFINE l_xrfb103    LIKE xrfb_t.xrfb103
   DEFINE l_xrfc013    LIKE xrfc_t.xrfc013
   DEFINE l_xrfc204    LIKE xrfc_t.xrfc204
   DEFINE l_xrfc101    LIKE xrfc_t.xrfc101
   DEFINE l_xrfc103    LIKE xrfc_t.xrfc103
   DEFINE l_amt        LIKE xrfb_t.xrfb103
   DEFINE l_sum        LIKE xrfb_t.xrfb103
   DEFINE l_sum1       LIKE xrfb_t.xrfb103
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_flag       LIKE type_t.chr1
   
   IF cl_null(g_xrfa_m.xrfadocno) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
  
   IF g_xrfa_m.xrfastus <> 'N' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xrfa_m.xrfadocno 
      LET g_errparam.code   = "axr-00206" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #收款資訊
   LET l_sql="SELECT xrfb007,xrfb103,xrfb204 FROM xrfb_t ",
             " WHERE xrfbent=",g_enterprise,
             "   AND xrfbdocno='",g_xrfa_m.xrfadocno,"' "
   PREPARE axrt460_diff_chk_pr FROM l_sql
   DECLARE axrt460_diff_chk_cs CURSOR FOR axrt460_diff_chk_pr
   
   LET l_sum=0  #借方總金額
   LET l_sum1=0 #貸方總金額
   
   FOREACH axrt460_diff_chk_cs INTO l_xrfb007,l_xrfb103,l_xrfb204
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
     
      IF cl_null(l_xrfb204) THEN LET l_xrfb204=0 END IF
      IF l_xrfb007='D' THEN #借方
         LET l_sum=l_sum+l_xrfb204
      ELSE #貸方
         LET l_sum1=l_sum1+l_xrfb204
      END IF
   END FOREACH
   
   #帳款資訊
   LET l_sql="SELECT xrfc013,xrfc103,xrfc204 FROM xrfc_t ",
             " WHERE xrfcent=",g_enterprise,
             "   AND xrfcdocno='",g_xrfa_m.xrfadocno,"' "
   PREPARE axrt460_diff_chk_pr1 FROM l_sql
   DECLARE axrt460_diff_chk_cs1 CURSOR FOR axrt460_diff_chk_pr1
   
   FOREACH axrt460_diff_chk_cs1 INTO l_xrfc013,l_xrfc103,l_xrfc204
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
     
      IF cl_null(l_xrfc204) THEN LET l_xrfc204=0 END IF
      IF l_xrfc013='D' THEN #借方
         LET l_sum=l_sum + l_xrfc204
      ELSE #貸方
         LET l_sum1=l_sum1 + l_xrfc204
      END IF
   END FOREACH
   IF l_sum <> l_sum1 THEN
      IF l_sum > l_sum1 THEN 
         LET l_flag='1' #收款>帳款
         LET l_amt=l_sum - l_sum1
      ELSE
         LET l_flag='2' #收款<帳款
         LET l_amt=l_sum1 - l_sum
      END IF
      
      CALL axrt460_01(g_xrfa_m.xrfadocno,l_flag,l_amt) RETURNING l_success
      IF l_success=FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = g_xrfa_m.xrfadocno
         LET g_errparam.code   = "axr-00205"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      ELSE
         CALL axrt460_b_fill()
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = g_xrfa_m.xrfadocno
      LET g_errparam.code   = 'axr-00175'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 产生axrt400沖帳資料
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
PRIVATE FUNCTION axrt460_gen_axrt400()
  #161128-00061#5---modify----begin------------- 
   DEFINE l_xrda RECORD  #收款核銷單單頭檔
       xrdaent LIKE xrda_t.xrdaent, #企业代码
       xrdacomp LIKE xrda_t.xrdacomp, #所屬法人
       xrdald LIKE xrda_t.xrdald, #帳套別
       xrdadocno LIKE xrda_t.xrdadocno, #沖帳單號
       xrdadocdt LIKE xrda_t.xrdadocdt, #沖帳日期
       xrdasite LIKE xrda_t.xrdasite, #帳務組織
       xrda001 LIKE xrda_t.xrda001, #帳款單性質
       xrda003 LIKE xrda_t.xrda003, #帳務人員
       xrda004 LIKE xrda_t.xrda004, #帳款核銷客戶
       xrda005 LIKE xrda_t.xrda005, #收款客戶
       xrda006 LIKE xrda_t.xrda006, #一次性對象識別碼
       xrda007 LIKE xrda_t.xrda007, #產生方式
       xrda008 LIKE xrda_t.xrda008, #來源參考單號
       xrda009 LIKE xrda_t.xrda009, #沖帳批序號
       xrda010 LIKE xrda_t.xrda010, #集團代收付單號
       xrda011 LIKE xrda_t.xrda011, #差異處理
       xrda012 LIKE xrda_t.xrda012, #退款類型
       xrda013 LIKE xrda_t.xrda013, #分錄底稿是否可重新產生
       xrda014 LIKE xrda_t.xrda014, #拋轉傳票號碼
       xrda015 LIKE xrda_t.xrda015, #作廢理由碼
       xrda016 LIKE xrda_t.xrda016, #列印次數
       xrda017 LIKE xrda_t.xrda017, #MEMO備註
       xrdastus LIKE xrda_t.xrdastus, #確認否
       xrdaownid LIKE xrda_t.xrdaownid, #資料所有者
       xrdaowndp LIKE xrda_t.xrdaowndp, #資料所屬部門
       xrdacrtid LIKE xrda_t.xrdacrtid, #資料建立者
       xrdacrtdp LIKE xrda_t.xrdacrtdp, #資料建立部門
       xrdacrtdt LIKE xrda_t.xrdacrtdt, #資料創建日
       xrdamodid LIKE xrda_t.xrdamodid, #資料修改者
       xrdamoddt LIKE xrda_t.xrdamoddt, #最近修改日
       xrda103 LIKE xrda_t.xrda103, #原幣借方金額合計
       xrda104 LIKE xrda_t.xrda104, #原幣貸方金額合計
       xrda113 LIKE xrda_t.xrda113, #本幣借方金額合計
       xrda114 LIKE xrda_t.xrda114, #本幣貸方金額合計
       xrda123 LIKE xrda_t.xrda123, #本位幣二借方金額合計
       xrda124 LIKE xrda_t.xrda124, #本位幣二貸方金額合計
       xrda133 LIKE xrda_t.xrda133, #本位幣三借方金額合計
       xrda134 LIKE xrda_t.xrda134, #本位幣三貸方金額合計
       xrdacnfid LIKE xrda_t.xrdacnfid, #資料確認這
       xrdacnfdt LIKE xrda_t.xrdacnfdt, #資料確認日
       xrdapstid LIKE xrda_t.xrdapstid, #資料過帳者
       xrdapstdt LIKE xrda_t.xrdapstdt, #資料過帳日
       xrda018 LIKE xrda_t.xrda018  #來源類型(流通)
       END RECORD
   DEFINE l_xrce RECORD  #應收沖銷明細檔
       xrceent LIKE xrce_t.xrceent, #企業編號
       xrcecomp LIKE xrce_t.xrcecomp, #法人
       xrceld LIKE xrce_t.xrceld, #帳套
       xrcedocno LIKE xrce_t.xrcedocno, #沖銷單單號
       xrceseq LIKE xrce_t.xrceseq, #項次
       xrcelegl LIKE xrce_t.xrcelegl, #no use
       xrcesite LIKE xrce_t.xrcesite, #帳務中心
       xrceorga LIKE xrce_t.xrceorga, #帳務歸屬組織
       xrce001 LIKE xrce_t.xrce001, #來源作業
       xrce002 LIKE xrce_t.xrce002, #沖銷類型
       xrce003 LIKE xrce_t.xrce003, #沖銷帳款單單號
       xrce004 LIKE xrce_t.xrce004, #沖銷帳款單項次
       xrce005 LIKE xrce_t.xrce005, #沖銷帳款單帳期
       xrce006 LIKE xrce_t.xrce006, #no use
       xrce007 LIKE xrce_t.xrce007, #no use
       xrce008 LIKE xrce_t.xrce008, #no use
       xrce009 LIKE xrce_t.xrce009, #no use
       xrce010 LIKE xrce_t.xrce010, #摘要說明
       xrce011 LIKE xrce_t.xrce011, #no use
       xrce012 LIKE xrce_t.xrce012, #no use
       xrce013 LIKE xrce_t.xrce013, #no use
       xrce014 LIKE xrce_t.xrce014, #no use
       xrce015 LIKE xrce_t.xrce015, #沖銷加減項
       xrce016 LIKE xrce_t.xrce016, #沖銷科目
       xrce017 LIKE xrce_t.xrce017, #業務人員
       xrce018 LIKE xrce_t.xrce018, #業務部門
       xrce019 LIKE xrce_t.xrce019, #責任中心
       xrce020 LIKE xrce_t.xrce020, #產品類別
       xrce021 LIKE xrce_t.xrce021, #no use
       xrce022 LIKE xrce_t.xrce022, #專案編號
       xrce023 LIKE xrce_t.xrce023, #WBS編號
       xrce024 LIKE xrce_t.xrce024, #第二參考單號
       xrce025 LIKE xrce_t.xrce025, #第二參考單號項次
       xrce026 LIKE xrce_t.xrce026, #no use
       xrce027 LIKE xrce_t.xrce027, #應稅折抵否
       xrce028 LIKE xrce_t.xrce028, #產生方式
       xrce029 LIKE xrce_t.xrce029, #傳票號碼
       xrce030 LIKE xrce_t.xrce030, #傳票項次
       xrce035 LIKE xrce_t.xrce035, #區域
       xrce036 LIKE xrce_t.xrce036, #客戶分類
       xrce037 LIKE xrce_t.xrce037, #no use
       xrce038 LIKE xrce_t.xrce038, #對象
       xrce039 LIKE xrce_t.xrce039, #經營方式
       xrce040 LIKE xrce_t.xrce040, #通路
       xrce041 LIKE xrce_t.xrce041, #品牌
       xrce042 LIKE xrce_t.xrce042, #自由核算項一
       xrce043 LIKE xrce_t.xrce043, #自由核算項二
       xrce044 LIKE xrce_t.xrce044, #自由核算項三
       xrce045 LIKE xrce_t.xrce045, #自由核算項四
       xrce046 LIKE xrce_t.xrce046, #自由核算項五
       xrce047 LIKE xrce_t.xrce047, #自由核算項六
       xrce048 LIKE xrce_t.xrce048, #自由核算項七
       xrce049 LIKE xrce_t.xrce049, #自由核算項八
       xrce050 LIKE xrce_t.xrce050, #自由核算項九
       xrce051 LIKE xrce_t.xrce051, #自由核算項十
       xrce053 LIKE xrce_t.xrce053, #發票編號
       xrce054 LIKE xrce_t.xrce054, #發票號碼
       xrce100 LIKE xrce_t.xrce100, #幣別
       xrce101 LIKE xrce_t.xrce101, #匯率
       xrce104 LIKE xrce_t.xrce104, #原幣應稅折抵稅額
       xrce109 LIKE xrce_t.xrce109, #原幣沖帳金額
       xrce114 LIKE xrce_t.xrce114, #本幣應稅折抵稅額
       xrce119 LIKE xrce_t.xrce119, #本幣沖帳金額
       xrce120 LIKE xrce_t.xrce120, #本位幣二幣別
       xrce121 LIKE xrce_t.xrce121, #本位幣二匯率
       xrce124 LIKE xrce_t.xrce124, #本位幣二應稅折抵稅額
       xrce129 LIKE xrce_t.xrce129, #本位幣二沖帳金額
       xrce130 LIKE xrce_t.xrce130, #本位幣二幣別
       xrce131 LIKE xrce_t.xrce131, #本位幣三匯率
       xrce134 LIKE xrce_t.xrce134, #本位幣三應稅折抵稅額
       xrce139 LIKE xrce_t.xrce139, #本位幣三沖帳金額
       xrce055 LIKE xrce_t.xrce055, #費用編號
       xrce056 LIKE xrce_t.xrce056, #方向
       xrce057 LIKE xrce_t.xrce057, #預收待抵單號
       xrce058 LIKE xrce_t.xrce058, #應付單號
       xrce103 LIKE xrce_t.xrce103, #未稅原幣沖銷額
       xrce113 LIKE xrce_t.xrce113, #未稅本幣沖銷額
       xrce123 LIKE xrce_t.xrce123, #本位幣二未稅沖銷額
       xrce133 LIKE xrce_t.xrce133, #本位幣三未稅沖銷額
       xrce059 LIKE xrce_t.xrce059  #預收單號
       END RECORD
  DEFINE l_xrde RECORD  #收款及差異處理明細檔
       xrdeent LIKE xrde_t.xrdeent, #企業編號
       xrdecomp LIKE xrde_t.xrdecomp, #法人
       xrdeld LIKE xrde_t.xrdeld, #帳套
       xrdedocno LIKE xrde_t.xrdedocno, #沖銷單單號
       xrdeseq LIKE xrde_t.xrdeseq, #項次
       xrdesite LIKE xrde_t.xrdesite, #帳務中心
       xrdeorga LIKE xrde_t.xrdeorga, #帳務歸屬組織
       xrde001 LIKE xrde_t.xrde001, #來源作業
       xrde002 LIKE xrde_t.xrde002, #沖銷帳款類型
       xrde003 LIKE xrde_t.xrde003, #來源單號
       xrde004 LIKE xrde_t.xrde004, #來源單項次
       xrde006 LIKE xrde_t.xrde006, #款別編號
       xrde007 LIKE xrde_t.xrde007, #款別編號
       xrde008 LIKE xrde_t.xrde008, #帳戶/票券號碼
       xrde010 LIKE xrde_t.xrde010, #摘要
       xrde011 LIKE xrde_t.xrde011, #銀行存提碼
       xrde012 LIKE xrde_t.xrde012, #現金變動碼
       xrde013 LIKE xrde_t.xrde013, #轉入客商碼
       xrde014 LIKE xrde_t.xrde014, #轉入帳款單編號
       xrde015 LIKE xrde_t.xrde015, #沖銷加減項
       xrde016 LIKE xrde_t.xrde016, #沖銷會科
       xrde017 LIKE xrde_t.xrde017, #業務人員
       xrde018 LIKE xrde_t.xrde018, #業務部門
       xrde019 LIKE xrde_t.xrde019, #責任中心
       xrde020 LIKE xrde_t.xrde020, #產品類別
       xrde022 LIKE xrde_t.xrde022, #專案編號
       xrde023 LIKE xrde_t.xrde023, #WBS編號
       xrde028 LIKE xrde_t.xrde028, #產生方式
       xrde029 LIKE xrde_t.xrde029, #傳票號碼
       xrde030 LIKE xrde_t.xrde030, #傳票項次
       xrde035 LIKE xrde_t.xrde035, #區域
       xrde036 LIKE xrde_t.xrde036, #客群
       xrde038 LIKE xrde_t.xrde038, #對象
       xrde039 LIKE xrde_t.xrde039, #經營方式
       xrde040 LIKE xrde_t.xrde040, #通路
       xrde041 LIKE xrde_t.xrde041, #品牌
       xrde042 LIKE xrde_t.xrde042, #自由核算項一
       xrde043 LIKE xrde_t.xrde043, #自由核算項二
       xrde044 LIKE xrde_t.xrde044, #自由核算項三
       xrde045 LIKE xrde_t.xrde045, #自由核算項四
       xrde046 LIKE xrde_t.xrde046, #自由核算項五
       xrde047 LIKE xrde_t.xrde047, #自由核算項六
       xrde048 LIKE xrde_t.xrde048, #自由核算項七
       xrde049 LIKE xrde_t.xrde049, #自由核算項八
       xrde050 LIKE xrde_t.xrde050, #自由核算項九
       xrde051 LIKE xrde_t.xrde051, #自由核算項十
       xrde100 LIKE xrde_t.xrde100, #幣別
       xrde101 LIKE xrde_t.xrde101, #匯率
       xrde109 LIKE xrde_t.xrde109, #原幣沖帳金額
       xrde119 LIKE xrde_t.xrde119, #本幣沖帳金額
       xrde120 LIKE xrde_t.xrde120, #本位幣二幣別
       xrde121 LIKE xrde_t.xrde121, #本位幣二匯率
       xrde129 LIKE xrde_t.xrde129, #本位幣二沖帳金額
       xrde130 LIKE xrde_t.xrde130, #本位幣三幣別
       xrde131 LIKE xrde_t.xrde131, #本位幣三匯率
       xrde139 LIKE xrde_t.xrde139, #本位幣三沖帳金額
       xrde032 LIKE xrde_t.xrde032, #收款日期
       xrde108 LIKE xrde_t.xrde108, #原幣手續費
       xrde118 LIKE xrde_t.xrde118  #本幣手續費
       END RECORD
   DEFINE l_xrfb RECORD  #集團收款核銷單收款明細檔
       xrfbent LIKE xrfb_t.xrfbent, #企業編碼
       xrfbdocno LIKE xrfb_t.xrfbdocno, #集團代收單號
       xrfbld LIKE xrfb_t.xrfbld, #帳套
       xrfbseq LIKE xrfb_t.xrfbseq, #項次
       xrfb001 LIKE xrfb_t.xrfb001, #來源組織
       xrfb002 LIKE xrfb_t.xrfb002, #繳款單號
       xrfb003 LIKE xrfb_t.xrfb003, #繳款單項次
       xrfb004 LIKE xrfb_t.xrfb004, #款別
       xrfb005 LIKE xrfb_t.xrfb005, #銀行存提碼
       xrfb006 LIKE xrfb_t.xrfb006, #類型
       xrfb007 LIKE xrfb_t.xrfb007, #借貸別
       xrfb100 LIKE xrfb_t.xrfb100, #收款幣別
       xrfb101 LIKE xrfb_t.xrfb101, #匯率
       xrfb103 LIKE xrfb_t.xrfb103, #收款原幣金額
       xrfb104 LIKE xrfb_t.xrfb104, #收款本幣金額
       xrfb201 LIKE xrfb_t.xrfb201, #對應代收方當日匯率
       xrfb204 LIKE xrfb_t.xrfb204  #對應代收方本幣金額
       END RECORD
   DEFINE l_xrfc RECORD  #集團收款核銷單帳款明細檔
       xrfcent LIKE xrfc_t.xrfcent, #企業編碼
       xrfcdocno LIKE xrfc_t.xrfcdocno, #集團代收單號
       xrfcseq LIKE xrfc_t.xrfcseq, #項次
       xrfc001 LIKE xrfc_t.xrfc001, #帳款法人組織
       xrfc002 LIKE xrfc_t.xrfc002, #帳款所屬帳套
       xrfc003 LIKE xrfc_t.xrfc003, #應收單號
       xrfc004 LIKE xrfc_t.xrfc004, #應收單項次
       xrfc005 LIKE xrfc_t.xrfc005, #多帳期序號
       xrfc006 LIKE xrfc_t.xrfc006, #類型
       xrfc007 LIKE xrfc_t.xrfc007, #收款條件
       xrfc008 LIKE xrfc_t.xrfc008, #稅別
       xrfc009 LIKE xrfc_t.xrfc009, #內部銀行帳戶編碼
       xrfc010 LIKE xrfc_t.xrfc010, #內部銀行存提碼
       xrfc011 LIKE xrfc_t.xrfc011, #應收款日
       xrfc012 LIKE xrfc_t.xrfc012, #帳款類別
       xrfc013 LIKE xrfc_t.xrfc013, #借貸別
       xrfc100 LIKE xrfc_t.xrfc100, #幣別
       xrfc101 LIKE xrfc_t.xrfc101, #匯率
       xrfc103 LIKE xrfc_t.xrfc103, #原幣沖帳金額
       xrfc104 LIKE xrfc_t.xrfc104, #本幣沖帳金額
       xrfc201 LIKE xrfc_t.xrfc201, #對應代收方當日匯率
       xrfc204 LIKE xrfc_t.xrfc204  #對應代收方本金額
       END RECORD
  # DEFINE l_xrda          RECORD LIKE xrda_t.*
  # DEFINE l_xrce          RECORD LIKE xrce_t.*
  # DEFINE l_xrde          RECORD LIKE xrde_t.*
  # DEFINE l_xrfb          RECORD LIKE xrfb_t.*
  # DEFINE l_xrfc          RECORD LIKE xrfc_t.*
  #161128-00061#5---modify----begin------------- 
   DEFINE l_apaf013       LIKE apaf_t.apaf013
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_sql           STRING
   DEFINE l_seq           LIKE xrde_t.xrdeseq
   DEFINE l_para_data     LIKE type_t.chr1  
   DEFINE l_para_data1    LIKE type_t.chr1  #160818-00011#1 add E-FIN-0001
   DEFINE l_wc            STRING
   DEFINE l_glaa001       LIKE glaa_t.glaa001
   DEFINE l_glaa025       LIKE glaa_t.glaa025
   DEFINE l_rate1         LIKE xrfb_t.xrfb201
   DEFINE l_rate2         LIKE xrfb_t.xrfb201
   DEFINE ls_js           STRING
   DEFINE lc_param        RECORD
            type          LIKE type_t.chr1,
            apca004       LIKE apca_t.apca004
                      END RECORD
   
   LET r_success=TRUE
   
   SELECT glaacomp,glaa001,glaa024,glaa025,glaa121
   INTO g_glaa.glaacomp,g_glaa.glaa001,g_glaa.glaa024,g_glaa.glaa025,g_glaa.glaa121
   FROM glaa_t 
   WHERE glaaent=g_enterprise AND glaald=g_xrfa_m.xrfald
   
   #(1).代收款方之沖銷單
   #(1.1) 單頭(INSERT xrda_t)
   INITIALIZE l_xrda.* TO NULL
   LET l_xrda.xrdaent = g_enterprise
   LET l_xrda.xrdacomp = g_xrfa_m.xrfacomp
   LET l_xrda.xrdald = g_xrfa_m.xrfald
   #單據別
   SELECT apaf013 INTO l_apaf013 FROM apaf_t 
   WHERE apafent=g_enterprise AND apaf001='1' AND apaf011=l_xrda.xrdacomp
   IF cl_null(l_apaf013) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = l_xrda.xrdacomp
      LET g_errparam.code   = 'axr-00208'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #單據日期
   LET l_xrda.xrdadocdt = g_xrfa_m.xrfadocdt
   #單據編號
   CALL s_aooi200_fin_gen_docno(l_xrda.xrdald,'','',l_apaf013,l_xrda.xrdadocdt,'axrt400')
   RETURNING l_success,l_xrda.xrdadocno
   IF l_success  = 0  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = l_apaf013
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   LET l_xrda.xrdasite = g_xrfa_m.xrfasite 
   LET l_xrda.xrda001 = '41' #帳款單性質
   LET l_xrda.xrda003 = g_xrfa_m.xrfa001 #帳務人員
   LET l_xrda.xrda004 = g_xrfa_m.xrfa002 #帳款核銷客戶
   LET l_xrda.xrda005 = g_xrfa_m.xrfa002 #收款客戶
   LET l_xrda.xrda007 = '1' #產生方式
   LET l_xrda.xrda008 = g_xrfa_m.xrfadocno #來源參考單號
   LET l_xrda.xrda010 = g_xrfa_m.xrfadocno #集團代收付單號 
   #是否抛傳票
   CALL cl_get_doc_para(g_enterprise,l_xrda.xrdacomp,l_apaf013,'D-FIN-0030') RETURNING l_xrda.xrda013 
#   LET l_xrda.xrdastus = 'Y' #160818-00011#1 mark
   LET l_xrda.xrdastus = 'N'  #160818-00011#1 add
   LET l_xrda.xrdaownid = g_user
   LET l_xrda.xrdaowndp = g_dept
   LET l_xrda.xrdacrtid = g_user
   LET l_xrda.xrdacrtdp = g_dept 
   LET l_xrda.xrdacrtdt = cl_get_current()
   #161128-00061#5---modify----begin------------- 
   #INSERT INTO xrda_t VALUES (l_xrda.*)
   INSERT INTO xrda_t (xrdaent,xrdacomp,xrdald,xrdadocno,xrdadocdt,xrdasite,xrda001,xrda003,xrda004,xrda005,
                       xrda006,xrda007,xrda008,xrda009,xrda010,xrda011,xrda012,xrda013,xrda014,xrda015,xrda016,
                       xrda017,xrdastus,xrdaownid,xrdaowndp,xrdacrtid,xrdacrtdp,xrdacrtdt,xrdamodid,xrdamoddt,
                       xrda103,xrda104,xrda113,xrda114,xrda123,xrda124,xrda133,xrda134,xrdacnfid,xrdacnfdt,xrdapstid,
                       xrdapstdt,xrda018)
    VALUES (l_xrda.xrdaent,l_xrda.xrdacomp,l_xrda.xrdald,l_xrda.xrdadocno,l_xrda.xrdadocdt,l_xrda.xrdasite,l_xrda.xrda001,l_xrda.xrda003,l_xrda.xrda004,l_xrda.xrda005,
            l_xrda.xrda006,l_xrda.xrda007,l_xrda.xrda008,l_xrda.xrda009,l_xrda.xrda010,l_xrda.xrda011,l_xrda.xrda012,l_xrda.xrda013,l_xrda.xrda014,l_xrda.xrda015,l_xrda.xrda016,
            l_xrda.xrda017,l_xrda.xrdastus,l_xrda.xrdaownid,l_xrda.xrdaowndp,l_xrda.xrdacrtid,l_xrda.xrdacrtdp,l_xrda.xrdacrtdt,l_xrda.xrdamodid,l_xrda.xrdamoddt,
            l_xrda.xrda103,l_xrda.xrda104,l_xrda.xrda113,l_xrda.xrda114,l_xrda.xrda123,l_xrda.xrda124,l_xrda.xrda133,l_xrda.xrda134,l_xrda.xrdacnfid,l_xrda.xrdacnfdt,l_xrda.xrdapstid,
            l_xrda.xrdapstdt,l_xrda.xrda018)
   #161128-00061#5---modify----end------------- 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins xrda_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   #(1.2) 收款及差异处理明细(insert xrde_t)
   #等於單頭法人的資料(select xrfb_t)
   LET l_sql=" SELECT xrfbseq,xrfb001,xrfb002,xrfb003,xrfb004,xrfb005,xrfb006,xrfb007,xrfb100,xrfb101,xrfb103,xrfb104 ",
             "   FROM xrfb_t ",
             "  WHERE xrfbent=",g_enterprise," AND xrfbdocno='",g_xrfa_m.xrfadocno,"'",
             "    AND xrfb001='",g_xrfa_m.xrfacomp,"' ",
             "  ORDER BY xrfbseq "
   PREPARE axrt460_sel_xrfb_pr FROM l_sql
   DECLARE axrt460_sel_xrfb_cs CURSOR FOR axrt460_sel_xrfb_pr
   
   LET l_seq=1
   FOREACH axrt460_sel_xrfb_cs INTO l_xrfb.xrfbseq,l_xrfb.xrfb001,l_xrfb.xrfb002,l_xrfb.xrfb003,l_xrfb.xrfb004,
                                    l_xrfb.xrfb005,l_xrfb.xrfb006,l_xrfb.xrfb007,l_xrfb.xrfb100,l_xrfb.xrfb101,
                                    l_xrfb.xrfb103,l_xrfb.xrfb104
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      INITIALIZE l_xrde.* TO NULL
      LET l_xrde.xrdeent = l_xrda.xrdaent
      LET l_xrde.xrdecomp = l_xrda.xrdacomp
      LET l_xrde.xrdeld = l_xrda.xrdald
      LET l_xrde.xrdedocno = l_xrda.xrdadocno
      LET l_xrde.xrdeseq = l_seq
      LET l_xrde.xrdesite = l_xrda.xrdasite
      LET l_xrde.xrdeorga = l_xrfb.xrfb001 #帳務歸屬組織
      LET l_xrde.xrde001 = 'axrt460' #來源作業
      LET l_xrde.xrde002 = l_xrfb.xrfb006 #沖銷帳款類型
      LET l_xrde.xrde003 = l_xrfb.xrfb002 #來源單號
      LET l_xrde.xrde004 = l_xrfb.xrfb003 #來源單號項次
      LET l_xrde.xrde006 = l_xrfb.xrfb004 #款別代碼
      IF l_xrde.xrde002 ='10' THEN
         #帳戶/票券號碼  #現金變動碼    
         IF l_xrde.xrde006 = '10' OR l_xrde.xrde006='20' THEN 
            SELECT nmbb003,nmbb010 INTO l_xrde.xrde008,l_xrde.xrde012 FROM nmbb_t 
             WHERE nmbbent=g_enterprise AND nmbbcomp=l_xrde.xrdeorga 
               AND nmbbdocno = l_xrde.xrde003 AND nmbbseq = l_xrde.xrde004
         ELSE              
            SELECT nmbb030,nmbb010 INTO l_xrde.xrde008,l_xrde.xrde012 FROM nmbb_t 
             WHERE nmbbent=g_enterprise AND nmbbcomp=l_xrde.xrdeorga 
               AND nmbbdocno = l_xrde.xrde003 AND nmbbseq = l_xrde.xrde004
        END IF  
      END IF    

      #轉入客商碼
      IF l_xrde.xrde002 = '20' THEN 
         #依xrcf 產生待抵對象:被代收方
         SELECT ooef024 INTO l_xrde.xrde013 FROM ooef_t 
         WHERE ooefent=g_enterprise AND ooef001 = l_xrfb.xrfb001 
      END IF
      #轉入帳款單編號
      IF l_xrde.xrde002 = '20' THEN
         SELECT apaf021 INTO l_xrde.xrde014 FROM apaf_t 
          WHERE apafent = g_enterprise AND apaf001 = '1' 
            AND apaf011 = l_xrfb.xrfb001
      END IF
      
      #沖銷加減項
      SELECT gzcb003 INTO l_xrde.xrde015 FROM gzcb_t WHERE gzcb001='8306' AND gzcb002=l_xrde.xrde002
      
      #沖銷會科
      IF l_xrde.xrde002 ='10' THEN
         LET l_xrde.xrde011 = l_xrfb.xrfb005 #銀行存提碼
         CALL axrt460_get_glab005(l_xrde.xrdeorga,l_xrde.xrdeld,l_xrde.xrde002,l_xrde.xrde003,l_xrde.xrde004) RETURNING l_xrde.xrde016
#         IF cl_null(l_xrde.xrde016) THEN #160818-00011#1 mark
         IF cl_null(l_xrde.xrde016) AND l_xrfb.xrfb004 <> '90' THEN #160818-00011#1 add 当款别=90时，科目到axrt400中录入
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "axr-00351"
            LET g_errparam.extend = l_xrde.xrde003
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
         END IF
      ELSE
         CALL s_subject_get(l_xrde.xrde002,l_xrde.xrdeld,l_xrde.xrdecomp,l_xrda.xrda004) RETURNING l_success,l_xrde.xrde016,l_xrde.xrde011       
         IF cl_null(l_xrde.xrde016) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "axr-00351"
            LET g_errparam.extend = l_xrda.xrda004
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
         END IF
      END IF
      
      LET l_xrde.xrde100 = l_xrfb.xrfb100 #幣別
      LET l_xrde.xrde101 = l_xrfb.xrfb101 #匯率
      LET l_xrde.xrde109 = l_xrfb.xrfb103 #原幣金額
      LET l_xrde.xrde119 = l_xrfb.xrfb104 #本幣金額
      #161128-00061#5---modify----begin------------- 
      #INSERT INTO xrde_t VALUES (l_xrde.*)
      INSERT INTO xrde_t (xrdeent,xrdecomp,xrdeld,xrdedocno,xrdeseq,xrdesite,xrdeorga,xrde001,xrde002,xrde003,
                          xrde004,xrde006,xrde007,xrde008,xrde010,xrde011,xrde012,xrde013,xrde014,xrde015,
                          xrde016,xrde017,xrde018,xrde019,xrde020,xrde022,xrde023,xrde028,xrde029,xrde030,
                          xrde035,xrde036,xrde038,xrde039,xrde040,xrde041,xrde042,xrde043,xrde044,xrde045,
                          xrde046,xrde047,xrde048,xrde049,xrde050,xrde051,xrde100,xrde101,xrde109,xrde119,
                          xrde120,xrde121,xrde129,xrde130,xrde131,xrde139,xrde032,xrde108,xrde118)
       VALUES (l_xrde.xrdeent,l_xrde.xrdecomp,l_xrde.xrdeld,l_xrde.xrdedocno,l_xrde.xrdeseq,l_xrde.xrdesite,l_xrde.xrdeorga,l_xrde.xrde001,l_xrde.xrde002,l_xrde.xrde003,
               l_xrde.xrde004,l_xrde.xrde006,l_xrde.xrde007,l_xrde.xrde008,l_xrde.xrde010,l_xrde.xrde011,l_xrde.xrde012,l_xrde.xrde013,l_xrde.xrde014,l_xrde.xrde015,
               l_xrde.xrde016,l_xrde.xrde017,l_xrde.xrde018,l_xrde.xrde019,l_xrde.xrde020,l_xrde.xrde022,l_xrde.xrde023,l_xrde.xrde028,l_xrde.xrde029,l_xrde.xrde030,
               l_xrde.xrde035,l_xrde.xrde036,l_xrde.xrde038,l_xrde.xrde039,l_xrde.xrde040,l_xrde.xrde041,l_xrde.xrde042,l_xrde.xrde043,l_xrde.xrde044,l_xrde.xrde045,
               l_xrde.xrde046,l_xrde.xrde047,l_xrde.xrde048,l_xrde.xrde049,l_xrde.xrde050,l_xrde.xrde051,l_xrde.xrde100,l_xrde.xrde101,l_xrde.xrde109,l_xrde.xrde119,
               l_xrde.xrde120,l_xrde.xrde121,l_xrde.xrde129,l_xrde.xrde130,l_xrde.xrde131,l_xrde.xrde139,l_xrde.xrde032,l_xrde.xrde108,l_xrde.xrde118)
      #161128-00061#5---modify----end------------- 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins xrde_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      LET l_seq=l_seq+1
   END FOREACH
   
   #(1.3) 產生對被代收方之溢收款轉代抵單或者其他費用單(insert xrde_t)
   #按照法人匯總，抓取不等於單頭法人資料(select xrfc_t)
   LET l_sql="SELECT xrfc001,xrfc100,xrfc101,SUM(xrfc103),SUM(xrfc104) ",
             "  FROM xrfc_t ",
             " WHERE xrfcent = ",g_enterprise," AND xrfcdocno = '",g_xrfa_m.xrfadocno,"'",
             "   AND xrfc001 <> '",g_xrfa_m.xrfacomp,"' ",
             " GROUP BY xrfc001,xrfc100,xrfc101",
             " ORDER BY xrfc001,xrfc100,xrfc101"
   PREPARE axrt460_sel_xrfc_pr FROM l_sql
   DECLARE axrt460_sel_xrfc_cs CURSOR FOR axrt460_sel_xrfc_pr
   
   #集團代收是否產生其他應收單和待抵單參數（aoos010）
   CALL cl_get_para(g_enterprise,"","E-FIN-0002") RETURNING l_para_data
   #集团代收是否产生其他应收单和待抵单
   CALL cl_get_para(g_enterprise,"","E-FIN-0001") RETURNING l_para_data1 #160818-00011#1 add  
   
   FOREACH axrt460_sel_xrfc_cs INTO l_xrfc.xrfc001,l_xrfc.xrfc100,l_xrfc.xrfc101,l_xrfc.xrfc103,l_xrfc.xrfc104
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      INITIALIZE l_xrde.* TO NULL
      LET l_xrde.xrdeent = l_xrda.xrdaent
      LET l_xrde.xrdecomp = l_xrda.xrdacomp
      LET l_xrde.xrdeld = l_xrda.xrdald
      LET l_xrde.xrdedocno = l_xrda.xrdadocno
      LET l_xrde.xrdeseq = l_seq
      LET l_xrde.xrdesite = l_xrda.xrdasite
      LET l_xrde.xrdeorga = l_xrda.xrdacomp #帳務歸屬組織
      LET l_xrde.xrde001 = 'axrt460' #來源作業
      #類型
      IF l_para_data = 'Y' THEN
         LET l_xrde.xrde002 = '20' #溢收款轉代抵單
      ELSE
#         LET l_xrde.xrde002 = '91' #其他費用 #160818-00011#1 mark
         #160818-00011#1--add--str--
         IF l_para_data1 = 'Y' THEN
            LET l_xrde.xrde002 = '92' #内部银行-
         ELSE
            LET l_xrde.xrde002 = '20' # 轉第三方應收單
         END IF
         #160818-00011#1--add--end
      END IF
      
      IF l_xrde.xrde002 = '20' THEN 
         #依xrcf 產生待抵對象:被代收方
         #轉入客商碼
         SELECT ooef024 INTO l_xrde.xrde013 FROM ooef_t 
         WHERE ooefent=g_enterprise AND ooef001 = l_xrfc.xrfc001 
         #轉入帳款單編號
         SELECT apaf021 INTO l_xrde.xrde014 FROM apaf_t 
          WHERE apafent = g_enterprise AND apaf001 = '1' 
            AND apaf011 = l_xrfc.xrfc001
      END IF
      
      #沖銷加減項
      SELECT gzcb003 INTO l_xrde.xrde015 FROM gzcb_t WHERE gzcb001='8306' AND gzcb002=l_xrde.xrde002
      #沖銷會科
      CALL s_subject_get(l_xrde.xrde002,l_xrde.xrdeld,l_xrde.xrdecomp,l_xrda.xrda004) RETURNING l_success,l_xrde.xrde016,l_xrde.xrde011 
      IF cl_null(l_xrde.xrde016) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "axr-00351"
         LET g_errparam.extend = l_xrda.xrda004
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      #類型為20溢收款轉代抵單時重新抓取匯率
      IF l_xrde.xrde002 = '20' THEN
         #幣別
         LET l_xrde.xrde100 = l_xrfc.xrfc100
         #重取匯率
#         CALL s_aooi160_get_exrate('2',g_xrfa_m.xrfald,g_today,l_xrfc.xrfc100,g_glaa.glaa001,0,g_glaa.glaa025) 
#         RETURNING l_xrde.xrde101
         LET lc_param.type    = '1'
         LET lc_param.apca004 = g_xrfa_m.xrfa002
         LET ls_js = util.JSON.stringify(lc_param)
         CALL s_fin_get_curr_rate(g_xrfa_m.xrfacomp,g_xrfa_m.xrfald,g_today,l_xrfc.xrfc100,ls_js)
         RETURNING l_xrde.xrde101,l_rate1,l_rate2
         #原幣金額
         LET l_xrde.xrde109 = l_xrfc.xrfc103
         #本幣金額
         LET l_xrde.xrde119 = l_xrfc.xrfc103 * l_xrde.xrde101
         CALL s_curr_round_ld('1',g_xrfa_m.xrfald,g_glaa.glaa001,l_xrde.xrde119,2) 
                  RETURNING g_sub_success,g_errno,l_xrde.xrde119
      ELSE
         LET l_xrde.xrde100 = l_xrfc.xrfc100 #幣別
         LET l_xrde.xrde101 = l_xrfc.xrfc101 #匯率
         LET l_xrde.xrde109 = l_xrfc.xrfc103 #原幣金額
         LET l_xrde.xrde119 = l_xrfc.xrfc104 #本幣金額
      END IF
      #161128-00061#5---modify----begin------------- 
      #INSERT INTO xrde_t VALUES (l_xrde.*)
      INSERT INTO xrde_t (xrdeent,xrdecomp,xrdeld,xrdedocno,xrdeseq,xrdesite,xrdeorga,xrde001,xrde002,xrde003,
                          xrde004,xrde006,xrde007,xrde008,xrde010,xrde011,xrde012,xrde013,xrde014,xrde015,
                          xrde016,xrde017,xrde018,xrde019,xrde020,xrde022,xrde023,xrde028,xrde029,xrde030,
                          xrde035,xrde036,xrde038,xrde039,xrde040,xrde041,xrde042,xrde043,xrde044,xrde045,
                          xrde046,xrde047,xrde048,xrde049,xrde050,xrde051,xrde100,xrde101,xrde109,xrde119,
                          xrde120,xrde121,xrde129,xrde130,xrde131,xrde139,xrde032,xrde108,xrde118)
       VALUES (l_xrde.xrdeent,l_xrde.xrdecomp,l_xrde.xrdeld,l_xrde.xrdedocno,l_xrde.xrdeseq,l_xrde.xrdesite,l_xrde.xrdeorga,l_xrde.xrde001,l_xrde.xrde002,l_xrde.xrde003,
               l_xrde.xrde004,l_xrde.xrde006,l_xrde.xrde007,l_xrde.xrde008,l_xrde.xrde010,l_xrde.xrde011,l_xrde.xrde012,l_xrde.xrde013,l_xrde.xrde014,l_xrde.xrde015,
               l_xrde.xrde016,l_xrde.xrde017,l_xrde.xrde018,l_xrde.xrde019,l_xrde.xrde020,l_xrde.xrde022,l_xrde.xrde023,l_xrde.xrde028,l_xrde.xrde029,l_xrde.xrde030,
               l_xrde.xrde035,l_xrde.xrde036,l_xrde.xrde038,l_xrde.xrde039,l_xrde.xrde040,l_xrde.xrde041,l_xrde.xrde042,l_xrde.xrde043,l_xrde.xrde044,l_xrde.xrde045,
               l_xrde.xrde046,l_xrde.xrde047,l_xrde.xrde048,l_xrde.xrde049,l_xrde.xrde050,l_xrde.xrde051,l_xrde.xrde100,l_xrde.xrde101,l_xrde.xrde109,l_xrde.xrde119,
               l_xrde.xrde120,l_xrde.xrde121,l_xrde.xrde129,l_xrde.xrde130,l_xrde.xrde131,l_xrde.xrde139,l_xrde.xrde032,l_xrde.xrde108,l_xrde.xrde118)
      #161128-00061#5---modify----end------------- 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins xrde_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      LET l_seq=l_seq+1
   END FOREACH
   
   #(1.4) 帳款明細(insert xrce_t)
   #抓取等於單頭法人的帳款資料(select xrfc_t)
   LET l_sql="SELECT xrfcseq,xrfc001,xrfc002,xrfc003,xrfc004,xrfc005,xrfc006,xrfc013,xrfc100,xrfc101,xrfc103,xrfc104 ",
             "  FROM xrfc_t ",
             " WHERE xrfcent = ",g_enterprise," AND xrfcdocno = '",g_xrfa_m.xrfadocno,"'",
             "   AND xrfc001 = '",g_xrfa_m.xrfacomp,"' ",
             " ORDER BY xrfcseq "
   PREPARE axrt460_sel_xrfc_pr2 FROM l_sql
   DECLARE axrt460_sel_xrfc_cs2 CURSOR FOR axrt460_sel_xrfc_pr2
   LET l_seq=1
   #參數 S-FIN-1002  #應收沖帳參數
   CALL cl_get_para(g_enterprise,g_xrfa_m.xrfacomp,'S-FIN-1002') RETURNING l_para_data
   
   FOREACH axrt460_sel_xrfc_cs2 INTO l_xrfc.xrfcseq,l_xrfc.xrfc001,l_xrfc.xrfc002,l_xrfc.xrfc003,l_xrfc.xrfc004,
                                     l_xrfc.xrfc005,l_xrfc.xrfc006,l_xrfc.xrfc013,l_xrfc.xrfc100,l_xrfc.xrfc101,
                                     l_xrfc.xrfc103,l_xrfc.xrfc104
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      INITIALIZE l_xrce.* TO NULL
      LET l_xrce.xrceent = l_xrda.xrdaent
      LET l_xrce.xrcecomp = l_xrda.xrdacomp
      LET l_xrce.xrceld = l_xrda.xrdald
      LET l_xrce.xrcedocno = l_xrda.xrdadocno
      LET l_xrce.xrceseq = l_seq
      LET l_xrce.xrcesite = l_xrda.xrdasite
      LET l_xrce.xrceorga = l_xrfc.xrfc001
      LET l_xrce.xrce001 = 'axrt460'
      LET l_xrce.xrce002 = l_xrfc.xrfc006
      LET l_xrce.xrce003 = l_xrfc.xrfc003
      LET l_xrce.xrce004 = l_xrfc.xrfc004
      LET l_xrce.xrce005 = l_xrfc.xrfc005
      LET l_xrce.xrce015 = l_xrfc.xrfc013
      
      IF l_para_data= '1' OR l_para_data='2'  THEN 
         #沖銷科目、業務人員、業務部門
         SELECT xrca035,xrca014,xrca015 
           INTO l_xrce.xrce016,l_xrce.xrce017,l_xrce.xrce018
           FROM xrca_t  
         WHERE xrcaent = g_enterprise AND xrcald = l_xrfc.xrfc002
           AND xrcadocno = l_xrfc.xrfc003
         #責任中心
         SELECT ooeg004 INTO l_xrce.xrce019 FROM ooeg_t
         WHERE ooegent=g_enterprise AND ooeg001=l_xrce.xrce018
      END IF 
      IF l_para_data= '3'  THEN 
         #沖銷科目、業務人員、業務部門、責任中心、產品類別、專案代號、WBS編號、區域、客群
         #經營方式、渠道、品牌、十個自由核算項
         SELECT xrcb029,xrcb051,xrcb010,xrcb011,xrcb012,xrcb015,xrcb016,xrcb024,xrcb036,
                xrcb033,xrcb034,xrcb035,xrcb037,xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,
                xrcb043,xrcb044,xrcb045,xrcb046
           INTO l_xrce.xrce016,l_xrce.xrce017,l_xrce.xrce018,l_xrce.xrce019,l_xrce.xrce020,
                l_xrce.xrce022,l_xrce.xrce023,l_xrce.xrce035,l_xrce.xrce036,
                l_xrce.xrce039,l_xrce.xrce040,l_xrce.xrce041,l_xrce.xrce042,l_xrce.xrce043,
                l_xrce.xrce044,l_xrce.xrce045,l_xrce.xrce046,l_xrce.xrce047,l_xrce.xrce048,
                l_xrce.xrce049,l_xrce.xrce050,l_xrce.xrce051
           FROM xrcb_t  
          WHERE xrcbent = g_enterprise AND xrcbld = l_xrfc.xrfc002
            AND xrcbdocno = l_xrfc.xrfc003 
            AND xrcbseq = l_xrfc.xrfc004 
      END IF 
      LET l_xrce.xrce100 = l_xrfc.xrfc100 #幣別
      LET l_xrce.xrce101 = l_xrfc.xrfc101 #匯率
      LET l_xrce.xrce104 = 0
      LET l_xrce.xrce109 = l_xrfc.xrfc103 #原幣沖帳金額
      LET l_xrce.xrce114 = 0
      LET l_xrce.xrce119 = l_xrfc.xrfc104 #本幣沖帳金額
      
      #161128-00061#5---modify----begin------------- 
      #INSERT INTO xrce_t VALUES (l_xrce.*)
      INSERT INTO xrce_t (xrceent,xrcecomp,xrceld,xrcedocno,xrceseq,xrcelegl,xrcesite,xrceorga,xrce001,xrce002,
                          xrce003,xrce004,xrce005,xrce006,xrce007,xrce008,xrce009,xrce010,xrce011,xrce012,xrce013,
                          xrce014,xrce015,xrce016,xrce017,xrce018,xrce019,xrce020,xrce021,xrce022,xrce023,xrce024,
                          xrce025,xrce026,xrce027,xrce028,xrce029,xrce030,xrce035,xrce036,xrce037,xrce038,xrce039,
                          xrce040,xrce041,xrce042,xrce043,xrce044,xrce045,xrce046,xrce047,xrce048,xrce049,xrce050,
                          xrce051,xrce053,xrce054,xrce100,xrce101,xrce104,xrce109,xrce114,xrce119,xrce120,xrce121,
                          xrce124,xrce129,xrce130,xrce131,xrce134,xrce139,xrce055,xrce056,xrce057,xrce058,xrce103,
                          xrce113,xrce123,xrce133,xrce059)
       VALUES (l_xrce.xrceent,l_xrce.xrcecomp,l_xrce.xrceld,l_xrce.xrcedocno,l_xrce.xrceseq,l_xrce.xrcelegl,l_xrce.xrcesite,l_xrce.xrceorga,l_xrce.xrce001,l_xrce.xrce002,
               l_xrce.xrce003,l_xrce.xrce004,l_xrce.xrce005,l_xrce.xrce006,l_xrce.xrce007,l_xrce.xrce008,l_xrce.xrce009,l_xrce.xrce010,l_xrce.xrce011,l_xrce.xrce012,l_xrce.xrce013,
               l_xrce.xrce014,l_xrce.xrce015,l_xrce.xrce016,l_xrce.xrce017,l_xrce.xrce018,l_xrce.xrce019,l_xrce.xrce020,l_xrce.xrce021,l_xrce.xrce022,l_xrce.xrce023,l_xrce.xrce024,
               l_xrce.xrce025,l_xrce.xrce026,l_xrce.xrce027,l_xrce.xrce028,l_xrce.xrce029,l_xrce.xrce030,l_xrce.xrce035,l_xrce.xrce036,l_xrce.xrce037,l_xrce.xrce038,l_xrce.xrce039,
               l_xrce.xrce040,l_xrce.xrce041,l_xrce.xrce042,l_xrce.xrce043,l_xrce.xrce044,l_xrce.xrce045,l_xrce.xrce046,l_xrce.xrce047,l_xrce.xrce048,l_xrce.xrce049,l_xrce.xrce050,
               l_xrce.xrce051,l_xrce.xrce053,l_xrce.xrce054,l_xrce.xrce100,l_xrce.xrce101,l_xrce.xrce104,l_xrce.xrce109,l_xrce.xrce114,l_xrce.xrce119,l_xrce.xrce120,l_xrce.xrce121,
               l_xrce.xrce124,l_xrce.xrce129,l_xrce.xrce130,l_xrce.xrce131,l_xrce.xrce134,l_xrce.xrce139,l_xrce.xrce055,l_xrce.xrce056,l_xrce.xrce057,l_xrce.xrce058,l_xrce.xrce103,
               l_xrce.xrce113,l_xrce.xrce123,l_xrce.xrce133,l_xrce.xrce059)
      #161128-00061#5---modify----end------------- 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins xrce_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      LET l_seq=l_seq+1
   END FOREACH
   
   IF g_glaa.glaa121 = 'Y' THEN 
      CALL s_pre_voucher_ins('AR','R20',l_xrda.xrdald,l_xrda.xrdadocno,l_xrda.xrdadocdt,'2') RETURNING l_success
      
      IF l_success = TRUE THEN 
         LET l_wc = "glgadocno = '",l_xrda.xrdadocno,"'"
         CALL s_pre_voucher_upd('AR','R20',l_xrda.xrdald,'Y','','',l_wc) RETURNING l_success
      END IF
   END IF
   
   #(2).被代收方之沖銷單
   LET l_sql="SELECT DISTINCT xrfc001,xrfc002 ",
             "  FROM xrfc_t ",
             " WHERE xrfcent = ",g_enterprise," AND xrfcdocno = '",g_xrfa_m.xrfadocno,"'",
             "   AND xrfc001 <> '",g_xrfa_m.xrfacomp,"' ",
             " ORDER BY xrfc001,xrfc002 "
   PREPARE axrt460_sel_xrfc_pr3 FROM l_sql
   DECLARE axrt460_sel_xrfc_cs3 CURSOR FOR axrt460_sel_xrfc_pr3
   
   LET l_sql="SELECT xrfc100,xrfc101,SUM(xrfc103),SUM(xrfc104) ",
             "  FROM xrfc_t ",
             " WHERE xrfcent = ",g_enterprise," AND xrfcdocno = '",g_xrfa_m.xrfadocno,"'",
             "   AND xrfc001 =? ",
             " GROUP BY xrfc100,xrfc101",
             " ORDER BY xrfc100,xrfc101 "
   PREPARE axrt460_sel_xrfc_pr4 FROM l_sql
   DECLARE axrt460_sel_xrfc_cs4 CURSOR FOR axrt460_sel_xrfc_pr4
             
   LET l_sql=" SELECT xrfbseq,xrfb001,xrfb004,xrfb005,xrfb006,xrfb007,xrfb100,xrfb101,xrfb103,xrfb104 ",
             "   FROM xrfb_t ",
             "  WHERE xrfbent = ",g_enterprise," AND xrfbdocno = '",g_xrfa_m.xrfadocno,"'",
             "    AND xrfb001 = ?",
             "  ORDER BY xrfbseq "
   PREPARE axrt460_sel_xrfb_pr2 FROM l_sql
   DECLARE axrt460_sel_xrfb_cs2 CURSOR FOR axrt460_sel_xrfb_pr2
   
   LET l_sql="SELECT xrfcseq,xrfc003,xrfc004,xrfc005,xrfc006,xrfc013,xrfc100,xrfc101,xrfc103,xrfc104 ",
             "  FROM xrfc_t ",
             " WHERE xrfcent = ",g_enterprise," AND xrfcdocno = '",g_xrfa_m.xrfadocno,"'",
             "   AND xrfc001 = ?",
             " ORDER BY xrfcseq "
   PREPARE axrt460_sel_xrfc_pr5 FROM l_sql
   DECLARE axrt460_sel_xrfc_cs5 CURSOR FOR axrt460_sel_xrfc_pr5
   
   FOREACH axrt460_sel_xrfc_cs3 INTO l_xrfc.xrfc001,l_xrfc.xrfc002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      #(2.1) 單頭(insert xrda_t)
      INITIALIZE l_xrda.* TO NULL
      LET l_xrda.xrdaent = g_enterprise
      LET l_xrda.xrdacomp = l_xrfc.xrfc001
      LET l_xrda.xrdald = l_xrfc.xrfc002
      #單據別
      SELECT apaf013 INTO l_apaf013 FROM apaf_t 
      WHERE apafent=g_enterprise AND apaf001='1' AND apaf011=l_xrda.xrdacomp
      IF cl_null(l_apaf013) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_xrda.xrdacomp
         LET g_errparam.code   = 'axr-00208'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         CONTINUE FOREACH
      END IF
      #單據日期
      LET l_xrda.xrdadocdt = g_xrfa_m.xrfadocdt
      #單據編號
      CALL s_aooi200_fin_gen_docno(l_xrda.xrdald,'','',l_apaf013,l_xrda.xrdadocdt,'axrt400')
      RETURNING l_success,l_xrda.xrdadocno
      IF l_success  = 0  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = l_apaf013
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         CONTINUE FOREACH
      END IF 
      LET l_xrda.xrdasite = g_xrfa_m.xrfasite 
      LET l_xrda.xrda001 = '41' #帳款單性質
      LET l_xrda.xrda003 = g_xrfa_m.xrfa001 #帳務人員
      LET l_xrda.xrda004 = g_xrfa_m.xrfa002 #帳款核銷客戶
      LET l_xrda.xrda005 = g_xrfa_m.xrfa002 #收款客戶
      LET l_xrda.xrda007 = '1' #產生方式
      LET l_xrda.xrda008 = g_xrfa_m.xrfadocno #來源參考單號
      LET l_xrda.xrda010 = g_xrfa_m.xrfadocno #集團代收付單號 
      #是否抛傳票
      CALL cl_get_doc_para(g_enterprise,l_xrda.xrdacomp,l_apaf013,'D-FIN-0030') RETURNING l_xrda.xrda013 
#      LET l_xrda.xrdastus = 'Y' #160818-00011#1 mark
      LET l_xrda.xrdastus = 'N' #160818-00011#1 add
      LET l_xrda.xrdaownid = g_user
      LET l_xrda.xrdaowndp = g_dept
      LET l_xrda.xrdacrtid = g_user
      LET l_xrda.xrdacrtdp = g_dept 
      LET l_xrda.xrdacrtdt = cl_get_current()
      #161128-00061#5---modify----begin------------- 
      #INSERT INTO xrda_t VALUES (l_xrda.*)
      INSERT INTO xrda_t (xrdaent,xrdacomp,xrdald,xrdadocno,xrdadocdt,xrdasite,xrda001,xrda003,xrda004,xrda005,
                          xrda006,xrda007,xrda008,xrda009,xrda010,xrda011,xrda012,xrda013,xrda014,xrda015,xrda016,
                          xrda017,xrdastus,xrdaownid,xrdaowndp,xrdacrtid,xrdacrtdp,xrdacrtdt,xrdamodid,xrdamoddt,
                          xrda103,xrda104,xrda113,xrda114,xrda123,xrda124,xrda133,xrda134,xrdacnfid,xrdacnfdt,xrdapstid,
                          xrdapstdt,xrda018)
       VALUES (l_xrda.xrdaent,l_xrda.xrdacomp,l_xrda.xrdald,l_xrda.xrdadocno,l_xrda.xrdadocdt,l_xrda.xrdasite,l_xrda.xrda001,l_xrda.xrda003,l_xrda.xrda004,l_xrda.xrda005,
               l_xrda.xrda006,l_xrda.xrda007,l_xrda.xrda008,l_xrda.xrda009,l_xrda.xrda010,l_xrda.xrda011,l_xrda.xrda012,l_xrda.xrda013,l_xrda.xrda014,l_xrda.xrda015,l_xrda.xrda016,
               l_xrda.xrda017,l_xrda.xrdastus,l_xrda.xrdaownid,l_xrda.xrdaowndp,l_xrda.xrdacrtid,l_xrda.xrdacrtdp,l_xrda.xrdacrtdt,l_xrda.xrdamodid,l_xrda.xrdamoddt,
               l_xrda.xrda103,l_xrda.xrda104,l_xrda.xrda113,l_xrda.xrda114,l_xrda.xrda123,l_xrda.xrda124,l_xrda.xrda133,l_xrda.xrda134,l_xrda.xrdacnfid,l_xrda.xrdacnfdt,l_xrda.xrdapstid,
               l_xrda.xrdapstdt,l_xrda.xrda018)
      #161128-00061#5---modify----end------------- 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins xrda_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      
      SELECT glaa001,glaa025 INTO l_glaa001,l_glaa025 FROM glaa_t
       WHERE glaaent=g_enterprise AND glaald=l_xrda.xrdald
      
      #(2.2) 收款及差异处理明细(insert xrde_t)
      #匯總同一法人金額(select xrfc_t)
      LET l_seq=1
      FOREACH axrt460_sel_xrfc_cs4 USING l_xrfc.xrfc001 INTO l_xrfc.xrfc100,l_xrfc.xrfc101,l_xrfc.xrfc103,l_xrfc.xrfc104
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         
         INITIALIZE l_xrde.* TO NULL
         LET l_xrde.xrdeent = l_xrda.xrdaent
         LET l_xrde.xrdecomp = l_xrda.xrdacomp
         LET l_xrde.xrdeld = l_xrda.xrdald
         LET l_xrde.xrdedocno = l_xrda.xrdadocno
         LET l_xrde.xrdeseq = l_seq
         LET l_xrde.xrdesite = l_xrda.xrdasite
         LET l_xrde.xrdeorga = l_xrfc.xrfc001 #帳務歸屬組織
         LET l_xrde.xrde001 = 'axrt460' #來源作業
         #集團代收是否產生其他應收單和待抵單參數（aoos010）
         CALL cl_get_para(g_enterprise,"","E-FIN-0002") RETURNING l_para_data
         #集团代收是否产生其他应收单和待抵单
         CALL cl_get_para(g_enterprise,"","E-FIN-0001") RETURNING l_para_data1 #160818-00011#1 add         
         #類型
         IF l_para_data = 'Y' THEN
            LET l_xrde.xrde002 = '22' #轉第三方應收單
         ELSE
#            LET l_xrde.xrde002 = '92' #其他減項 #160818-00011#1 mark
            #160818-00011#1--add--str--
            IF l_para_data1 = 'Y' THEN
               LET l_xrde.xrde002 = '91' #内部银行+
            ELSE
               LET l_xrde.xrde002 = '22' # 轉第三方應收單
            END IF
            #160818-00011#1--add--end
         END IF
         
         IF l_xrde.xrde002 = '22' THEN 
            #依xrcf 產生待抵對象:被代收方
            #轉入客商碼
            SELECT ooef024 INTO l_xrde.xrde013 FROM ooef_t 
            WHERE ooefent=g_enterprise AND ooef001 = g_xrfa_m.xrfacomp
            #轉入帳款單編號
            SELECT apaf014 INTO l_xrde.xrde014 FROM apaf_t 
             WHERE apafent = g_enterprise AND apaf001 = '1' 
               AND apaf011 = l_xrfc.xrfc001
         END IF
         #沖銷加減項
         SELECT gzcb003 INTO l_xrde.xrde015 FROM gzcb_t WHERE gzcb001='8306' AND gzcb002=l_xrde.xrde002
         #沖銷會科
         CALL s_subject_get(l_xrde.xrde002,l_xrde.xrdeld,l_xrde.xrdecomp,l_xrda.xrda004) RETURNING l_success,l_xrde.xrde016,l_xrde.xrde011 
         IF cl_null(l_xrde.xrde016) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "axr-00351"
            LET g_errparam.extend = l_xrda.xrda004
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
         END IF
         #類型為22轉第三方應收單時重新抓取匯率
         IF l_xrde.xrde002 = '22' THEN
            #幣別
            LET l_xrde.xrde100 = l_xrfc.xrfc100
            #重取匯率
#            CALL s_aooi160_get_exrate('2',l_xrde.xrdeld,g_today,l_xrfc.xrfc100,l_glaa001,0,l_glaa025) 
#            RETURNING l_xrde.xrde101
            LET lc_param.type    = '1'
            LET lc_param.apca004 = g_xrfa_m.xrfa002
            LET ls_js = util.JSON.stringify(lc_param)
            CALL s_fin_get_curr_rate(l_xrde.xrdecomp,l_xrde.xrdeld,g_today,l_xrfc.xrfc100,ls_js)
            RETURNING l_xrde.xrde101,l_rate1,l_rate2
            #原幣金額
            LET l_xrde.xrde109 = l_xrfc.xrfc103
            #本幣金額
            LET l_xrde.xrde119 = l_xrfc.xrfc103 * l_xrde.xrde101
            CALL s_curr_round_ld('1',l_xrde.xrdeld,l_glaa001,l_xrde.xrde119,2) 
                  RETURNING g_sub_success,g_errno,l_xrde.xrde119
         ELSE
            LET l_xrde.xrde100 = l_xrfc.xrfc100 #幣別
            LET l_xrde.xrde101 = l_xrfc.xrfc101 #匯率
            LET l_xrde.xrde109 = l_xrfc.xrfc103 #原幣金額
            LET l_xrde.xrde119 = l_xrfc.xrfc104 #本幣金額
         END IF
         #161128-00061#5---modify----begin------------- 
         #INSERT INTO xrde_t VALUES (l_xrde.*)
         INSERT INTO xrde_t (xrdeent,xrdecomp,xrdeld,xrdedocno,xrdeseq,xrdesite,xrdeorga,xrde001,xrde002,xrde003,
                             xrde004,xrde006,xrde007,xrde008,xrde010,xrde011,xrde012,xrde013,xrde014,xrde015,
                             xrde016,xrde017,xrde018,xrde019,xrde020,xrde022,xrde023,xrde028,xrde029,xrde030,
                             xrde035,xrde036,xrde038,xrde039,xrde040,xrde041,xrde042,xrde043,xrde044,xrde045,
                             xrde046,xrde047,xrde048,xrde049,xrde050,xrde051,xrde100,xrde101,xrde109,xrde119,
                             xrde120,xrde121,xrde129,xrde130,xrde131,xrde139,xrde032,xrde108,xrde118)
          VALUES (l_xrde.xrdeent,l_xrde.xrdecomp,l_xrde.xrdeld,l_xrde.xrdedocno,l_xrde.xrdeseq,l_xrde.xrdesite,l_xrde.xrdeorga,l_xrde.xrde001,l_xrde.xrde002,l_xrde.xrde003,
                  l_xrde.xrde004,l_xrde.xrde006,l_xrde.xrde007,l_xrde.xrde008,l_xrde.xrde010,l_xrde.xrde011,l_xrde.xrde012,l_xrde.xrde013,l_xrde.xrde014,l_xrde.xrde015,
                  l_xrde.xrde016,l_xrde.xrde017,l_xrde.xrde018,l_xrde.xrde019,l_xrde.xrde020,l_xrde.xrde022,l_xrde.xrde023,l_xrde.xrde028,l_xrde.xrde029,l_xrde.xrde030,
                  l_xrde.xrde035,l_xrde.xrde036,l_xrde.xrde038,l_xrde.xrde039,l_xrde.xrde040,l_xrde.xrde041,l_xrde.xrde042,l_xrde.xrde043,l_xrde.xrde044,l_xrde.xrde045,
                  l_xrde.xrde046,l_xrde.xrde047,l_xrde.xrde048,l_xrde.xrde049,l_xrde.xrde050,l_xrde.xrde051,l_xrde.xrde100,l_xrde.xrde101,l_xrde.xrde109,l_xrde.xrde119,
                  l_xrde.xrde120,l_xrde.xrde121,l_xrde.xrde129,l_xrde.xrde130,l_xrde.xrde131,l_xrde.xrde139,l_xrde.xrde032,l_xrde.xrde108,l_xrde.xrde118)
         #161128-00061#5---modify----end------------- 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins xrde_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
         END IF
         LET l_seq=l_seq + 1
      END FOREACH
      
      #(2.3) 抓取差異處理中該法人資料(select xrfb_t)
      FOREACH axrt460_sel_xrfb_cs2 USING l_xrfc.xrfc001 INTO l_xrfb.xrfbseq,l_xrfb.xrfb001,l_xrfb.xrfb004,
                                   l_xrfb.xrfb005,l_xrfb.xrfb006,l_xrfb.xrfb007,l_xrfb.xrfb100,l_xrfb.xrfb101,
                                   l_xrfb.xrfb103,l_xrfb.xrfb104
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         INITIALIZE l_xrde.* TO NULL
         LET l_xrde.xrdeent = l_xrda.xrdaent
         LET l_xrde.xrdecomp = l_xrda.xrdacomp
         LET l_xrde.xrdeld = l_xrda.xrdald
         LET l_xrde.xrdedocno = l_xrda.xrdadocno
         LET l_xrde.xrdeseq = l_seq
         LET l_xrde.xrdesite = l_xrda.xrdasite
         LET l_xrde.xrdeorga = l_xrfb.xrfb001 #帳務歸屬組織
         LET l_xrde.xrde001 = 'axrt460' #來源作業
         LET l_xrde.xrde002 = l_xrfb.xrfb006 #沖銷帳款類型
         LET l_xrde.xrde006 = l_xrfb.xrfb004 #款別代碼
         IF l_xrde.xrde002 ='10' THEN
            #帳戶/票券號碼  #現金變動碼    
            IF l_xrde.xrde006 = '10' OR l_xrde.xrde006='20' THEN 
               SELECT nmbb003,nmbb010 INTO l_xrde.xrde008,l_xrde.xrde012 FROM nmbb_t 
                WHERE nmbbent=g_enterprise AND nmbbcomp=l_xrde.xrdeorga 
                  AND nmbbdocno = l_xrde.xrde003 AND nmbbseq = l_xrde.xrde004
            ELSE              
               SELECT nmbb030,nmbb010 INTO l_xrde.xrde008,l_xrde.xrde012 FROM nmbb_t 
                WHERE nmbbent=g_enterprise AND nmbbcomp=l_xrde.xrdeorga 
                  AND nmbbdocno = l_xrde.xrde003 AND nmbbseq = l_xrde.xrde004
           END IF  
         END IF    
         #轉入客商碼
         IF l_xrde.xrde002 = '20' THEN 
            #依xrcf 產生待抵對象:被代收方
            SELECT ooef024 INTO l_xrde.xrde013 FROM ooef_t 
            WHERE ooefent=g_enterprise AND ooef001 = l_xrfb.xrfb001 
         END IF
         #轉入帳款單編號
         IF l_xrde.xrde002 = '20' THEN
            SELECT apaf021 INTO l_xrde.xrde014 FROM apaf_t 
             WHERE apafent = g_enterprise AND apaf001 = '1' 
               AND apaf011 = l_xrfb.xrfb001
         END IF
         #沖銷加減項
         SELECT gzcb003 INTO l_xrde.xrde015 FROM gzcb_t WHERE gzcb001='8306' AND gzcb002=l_xrde.xrde002
         #沖銷會科
         CALL s_subject_get(l_xrde.xrde002,l_xrde.xrdeld,l_xrde.xrdecomp,l_xrda.xrda004) RETURNING l_success,l_xrde.xrde016,l_xrde.xrde011 
         IF cl_null(l_xrde.xrde016) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "axr-00351"
            LET g_errparam.extend = l_xrda.xrda004
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
         END IF
         LET l_xrde.xrde100 = l_xrfb.xrfb100 #幣別
         LET l_xrde.xrde101 = l_xrfb.xrfb101 #匯率
         LET l_xrde.xrde109 = l_xrfb.xrfb103 #原幣金額
         LET l_xrde.xrde119 = l_xrfb.xrfb104 #本幣金額
         
         #161128-00061#5---modify----begin------------- 
         #INSERT INTO xrde_t VALUES (l_xrde.*)
         INSERT INTO xrde_t (xrdeent,xrdecomp,xrdeld,xrdedocno,xrdeseq,xrdesite,xrdeorga,xrde001,xrde002,xrde003,
                             xrde004,xrde006,xrde007,xrde008,xrde010,xrde011,xrde012,xrde013,xrde014,xrde015,
                             xrde016,xrde017,xrde018,xrde019,xrde020,xrde022,xrde023,xrde028,xrde029,xrde030,
                             xrde035,xrde036,xrde038,xrde039,xrde040,xrde041,xrde042,xrde043,xrde044,xrde045,
                             xrde046,xrde047,xrde048,xrde049,xrde050,xrde051,xrde100,xrde101,xrde109,xrde119,
                             xrde120,xrde121,xrde129,xrde130,xrde131,xrde139,xrde032,xrde108,xrde118)
          VALUES (l_xrde.xrdeent,l_xrde.xrdecomp,l_xrde.xrdeld,l_xrde.xrdedocno,l_xrde.xrdeseq,l_xrde.xrdesite,l_xrde.xrdeorga,l_xrde.xrde001,l_xrde.xrde002,l_xrde.xrde003,
                  l_xrde.xrde004,l_xrde.xrde006,l_xrde.xrde007,l_xrde.xrde008,l_xrde.xrde010,l_xrde.xrde011,l_xrde.xrde012,l_xrde.xrde013,l_xrde.xrde014,l_xrde.xrde015,
                  l_xrde.xrde016,l_xrde.xrde017,l_xrde.xrde018,l_xrde.xrde019,l_xrde.xrde020,l_xrde.xrde022,l_xrde.xrde023,l_xrde.xrde028,l_xrde.xrde029,l_xrde.xrde030,
                  l_xrde.xrde035,l_xrde.xrde036,l_xrde.xrde038,l_xrde.xrde039,l_xrde.xrde040,l_xrde.xrde041,l_xrde.xrde042,l_xrde.xrde043,l_xrde.xrde044,l_xrde.xrde045,
                  l_xrde.xrde046,l_xrde.xrde047,l_xrde.xrde048,l_xrde.xrde049,l_xrde.xrde050,l_xrde.xrde051,l_xrde.xrde100,l_xrde.xrde101,l_xrde.xrde109,l_xrde.xrde119,
                  l_xrde.xrde120,l_xrde.xrde121,l_xrde.xrde129,l_xrde.xrde130,l_xrde.xrde131,l_xrde.xrde139,l_xrde.xrde032,l_xrde.xrde108,l_xrde.xrde118)
         #161128-00061#5---modify----end------------- 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins xrde_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
         END IF
         LET l_seq=l_seq + 1
      END FOREACH
      
      #(2.4) 帳款明細(insert xrce_t)
      LET l_seq=1
      FOREACH axrt460_sel_xrfc_cs5 USING l_xrfc.xrfc001 INTO l_xrfc.xrfcseq,l_xrfc.xrfc003,l_xrfc.xrfc004,
                                   l_xrfc.xrfc005,l_xrfc.xrfc006,l_xrfc.xrfc013,l_xrfc.xrfc100,l_xrfc.xrfc101,
                                   l_xrfc.xrfc103,l_xrfc.xrfc104 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         INITIALIZE l_xrce.* TO NULL
         LET l_xrce.xrceent = l_xrda.xrdaent
         LET l_xrce.xrcecomp = l_xrda.xrdacomp
         LET l_xrce.xrceld = l_xrda.xrdald
         LET l_xrce.xrcedocno = l_xrda.xrdadocno
         LET l_xrce.xrceseq = l_seq
         LET l_xrce.xrcesite = l_xrda.xrdasite
         LET l_xrce.xrceorga = l_xrfc.xrfc001
         LET l_xrce.xrce001 = 'axrt460'
         LET l_xrce.xrce002 = l_xrfc.xrfc006
         LET l_xrce.xrce003 = l_xrfc.xrfc003
         LET l_xrce.xrce004 = l_xrfc.xrfc004
         LET l_xrce.xrce005 = l_xrfc.xrfc005
         LET l_xrce.xrce015 = l_xrfc.xrfc013
         #參數 S-FIN-1002  #應收沖帳參數
         CALL cl_get_para(g_enterprise,g_xrfa_m.xrfacomp,'S-FIN-1002') RETURNING l_para_data
         IF l_para_data= '1' OR l_para_data='2'  THEN 
            #沖銷科目、業務人員、業務部門
            SELECT xrca035,xrca014,xrca015 
              INTO l_xrce.xrce016,l_xrce.xrce017,l_xrce.xrce018
              FROM xrca_t  
            WHERE xrcaent = g_enterprise AND xrcald = l_xrfc.xrfc002
              AND xrcadocno = l_xrfc.xrfc003
            #責任中心
            SELECT ooeg004 INTO l_xrce.xrce019 FROM ooeg_t
            WHERE ooegent=g_enterprise AND ooeg001=l_xrce.xrce018
         END IF 
         IF l_para_data= '3'  THEN 
            #沖銷科目、業務人員、業務部門、責任中心、產品類別、專案代號、WBS編號、區域、客群
            #經營方式、渠道、品牌、十個自由核算項
            SELECT xrcb029,xrcb051,xrcb010,xrcb011,xrcb012,xrcb015,xrcb016,xrcb024,xrcb036,
                   xrcb033,xrcb034,xrcb035,xrcb037,xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,
                   xrcb043,xrcb044,xrcb045,xrcb046
              INTO l_xrce.xrce016,l_xrce.xrce017,l_xrce.xrce018,l_xrce.xrce019,l_xrce.xrce020,
                   l_xrce.xrce022,l_xrce.xrce023,l_xrce.xrce035,l_xrce.xrce036,
                   l_xrce.xrce039,l_xrce.xrce040,l_xrce.xrce041,l_xrce.xrce042,l_xrce.xrce043,
                   l_xrce.xrce044,l_xrce.xrce045,l_xrce.xrce046,l_xrce.xrce047,l_xrce.xrce048,
                   l_xrce.xrce049,l_xrce.xrce050,l_xrce.xrce051
              FROM xrcb_t  
             WHERE xrcbent = g_enterprise AND xrcbld = l_xrfc.xrfc002
               AND xrcbdocno = l_xrfc.xrfc003 
               AND xrcbseq = l_xrfc.xrfc004 
         END IF 
         LET l_xrce.xrce100 = l_xrfc.xrfc100 #幣別
         LET l_xrce.xrce101 = l_xrfc.xrfc101 #匯率
         LET l_xrce.xrce104 = 0
         LET l_xrce.xrce109 = l_xrfc.xrfc103 #原幣沖帳金額
         LET l_xrce.xrce114 = 0
         LET l_xrce.xrce119 = l_xrfc.xrfc104 #本幣沖帳金額
      
         #161128-00061#5---modify----begin------------- 
         #INSERT INTO xrce_t VALUES (l_xrce.*)
         INSERT INTO xrce_t (xrceent,xrcecomp,xrceld,xrcedocno,xrceseq,xrcelegl,xrcesite,xrceorga,xrce001,xrce002,
                             xrce003,xrce004,xrce005,xrce006,xrce007,xrce008,xrce009,xrce010,xrce011,xrce012,xrce013,
                             xrce014,xrce015,xrce016,xrce017,xrce018,xrce019,xrce020,xrce021,xrce022,xrce023,xrce024,
                             xrce025,xrce026,xrce027,xrce028,xrce029,xrce030,xrce035,xrce036,xrce037,xrce038,xrce039,
                             xrce040,xrce041,xrce042,xrce043,xrce044,xrce045,xrce046,xrce047,xrce048,xrce049,xrce050,
                             xrce051,xrce053,xrce054,xrce100,xrce101,xrce104,xrce109,xrce114,xrce119,xrce120,xrce121,
                             xrce124,xrce129,xrce130,xrce131,xrce134,xrce139,xrce055,xrce056,xrce057,xrce058,xrce103,
                             xrce113,xrce123,xrce133,xrce059)
          VALUES (l_xrce.xrceent,l_xrce.xrcecomp,l_xrce.xrceld,l_xrce.xrcedocno,l_xrce.xrceseq,l_xrce.xrcelegl,l_xrce.xrcesite,l_xrce.xrceorga,l_xrce.xrce001,l_xrce.xrce002,
                  l_xrce.xrce003,l_xrce.xrce004,l_xrce.xrce005,l_xrce.xrce006,l_xrce.xrce007,l_xrce.xrce008,l_xrce.xrce009,l_xrce.xrce010,l_xrce.xrce011,l_xrce.xrce012,l_xrce.xrce013,
                  l_xrce.xrce014,l_xrce.xrce015,l_xrce.xrce016,l_xrce.xrce017,l_xrce.xrce018,l_xrce.xrce019,l_xrce.xrce020,l_xrce.xrce021,l_xrce.xrce022,l_xrce.xrce023,l_xrce.xrce024,
                  l_xrce.xrce025,l_xrce.xrce026,l_xrce.xrce027,l_xrce.xrce028,l_xrce.xrce029,l_xrce.xrce030,l_xrce.xrce035,l_xrce.xrce036,l_xrce.xrce037,l_xrce.xrce038,l_xrce.xrce039,
                  l_xrce.xrce040,l_xrce.xrce041,l_xrce.xrce042,l_xrce.xrce043,l_xrce.xrce044,l_xrce.xrce045,l_xrce.xrce046,l_xrce.xrce047,l_xrce.xrce048,l_xrce.xrce049,l_xrce.xrce050,
                  l_xrce.xrce051,l_xrce.xrce053,l_xrce.xrce054,l_xrce.xrce100,l_xrce.xrce101,l_xrce.xrce104,l_xrce.xrce109,l_xrce.xrce114,l_xrce.xrce119,l_xrce.xrce120,l_xrce.xrce121,
                  l_xrce.xrce124,l_xrce.xrce129,l_xrce.xrce130,l_xrce.xrce131,l_xrce.xrce134,l_xrce.xrce139,l_xrce.xrce055,l_xrce.xrce056,l_xrce.xrce057,l_xrce.xrce058,l_xrce.xrce103,
                  l_xrce.xrce113,l_xrce.xrce123,l_xrce.xrce133,l_xrce.xrce059)
         #161128-00061#5---modify----end------------- 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins xrce_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
         END IF
         LET l_seq=l_seq + 1
      END FOREACH
      
      IF g_glaa.glaa121 = 'Y' THEN
         CALL s_pre_voucher_ins('AR','R20',l_xrda.xrdald,l_xrda.xrdadocno,l_xrda.xrdadocdt,'2') RETURNING l_success
         
         IF l_success = TRUE THEN 
            LET l_wc = "glgadocno = '",l_xrda.xrdadocno,"'"
            CALL s_pre_voucher_upd('AR','R20',l_xrda.xrdald,'Y','','',l_wc) RETURNING l_success
         END IF
      END IF
   END FOREACH
   RETURN r_success
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
PRIVATE FUNCTION axrt460_get_glab005(p_xrdeorga,p_xrdeld,p_xrde002,p_xrde003,p_xrde004)
   DEFINE p_xrdeorga       LIKE xrde_t.xrdeorga
   DEFINE p_xrdeld         LIKE xrde_t.xrdeld
   DEFINE p_xrde002        LIKE xrde_t.xrde002
   DEFINE p_xrde003        LIKE xrde_t.xrde003
   DEFINE p_xrde004        LIKE xrde_t.xrde004
   DEFINE l_glab005        LIKE glab_t.glab005
   DEFINE l_nmbb003        LIKE nmbb_t.nmbb003
   DEFINE l_nmbb028        LIKE nmbb_t.nmbb028
   DEFINE l_nmbb029        LIKE nmbb_t.nmbb029
   
   LET l_glab005=''
#   CASE p_xrde002 
#      WHEN '10' #收款 
         #款別分類
         SELECT nmbb003,nmbb028,nmbb029 INTO l_nmbb003,l_nmbb028,l_nmbb029 FROM  nmbb_t 
          WHERE nmbbent=g_enterprise AND nmbbcomp=p_xrdeorga 
            AND nmbbdocno = p_xrde003 AND nmbbseq = p_xrde004
         IF l_nmbb029 MATCHES '[3456]0' THEN 
            #借方科目: 依 agli191 設定 
            SELECT glab005 INTO l_glab005 FROM glab_t  
             WHERE glabent = g_enterprise AND glabld=p_xrdeld
#               AND glab001 = '42'   #設定類型
               AND glab001 = '21'   #設定類型
               AND glab002 = l_nmbb029   
               AND glab003 = l_nmbb028  #款別 
             IF SQLCA.sqlcode=100 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'axr-00288'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()    
              END IF
         END IF
         IF l_nmbb029 = '10' OR l_nmbb029 = '20' THEN        
            #Dr. 銀行帳戶對應會科 
            #借方科目: 依 anmi121  設定 
            SELECT glab005 INTO l_glab005 FROM glab_t 
             WHERE glabent = g_enterprise AND glabld=p_xrdeld 
               AND glab001 = '40'  #設定類型
               AND glab002 = '40'  #分類碼
               AND glab003 = l_nmbb003 #分類碼值=交易帳戶編號
            IF SQLCA.sqlcode=100 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00289'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()   
            END IF
         END IF
         IF SQLCA.sqlcode AND SQLCA.sqlcode <>100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()    
         END IF
#      WHEN '20' #溢收款轉代抵單
#         #xrfc006  帳款類型串axri011 之    
#         SELECT glab005 INTO l_glab005 FROM glab_t 
#          WHERE glabent = g_enterprise AND glabld=p_xrdeld
#            AND glab002 = p_xrfc006 # 帳款類別
#            AND glab001 = '13'      # 應收帳務類型科目設定
#            AND glab003 ='8304_24'
#       
#      WHEN '22' #轉第三方
#         #xrfc006 帳款類型串axri011 之應收帳款
#         SELECT glab005 INTO l_glab005 FROM glab_t 
#          WHERE glabent = g_enterprise AND glabld=p_xrdeld
#            AND glab002 = p_xrde002 # 帳款類別
#            AND glab001 = '13'      # 應收帳務類型科目設定
#            AND glab003 ='8304_01'
#      WHEN '11' #匯損
#         #agli160 
#         SELECT glab005 INTO l_glab005 FROM glab_t 
#          WHERE glabent = g_enterprise AND glabld=p_xrdeld
#            AND glab001 ='12' 
#            AND glab002 ='9711'
#            AND glab003 = '9711_11' 
#      WHEN '12' #匯收
#         #agli160 
#         SELECT glab005 INTO l_glab005 FROM glab_t 
#          WHERE glabent = g_enterprise AND glabld=p_xrdeld
#            AND glab001 ='12' 
#            AND glab002 ='9711'
#            AND glab003 = '9711_12' 
#   END CASE
   RETURN l_glab005
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
PRIVATE FUNCTION axrt460_ins_nmbc()
   DEFINE l_sql        STRING
   #161128-00061#5---modify----begin------------- 
   #DEFINE l_xrfc       RECORD LIKE xrfc_t.*
   #DEFINE l_nmbc       RECORD LIKE nmbc_t.*
    DEFINE l_xrfc RECORD  #集團收款核銷單帳款明細檔
       xrfcent LIKE xrfc_t.xrfcent, #企業編碼
       xrfcdocno LIKE xrfc_t.xrfcdocno, #集團代收單號
       xrfcseq LIKE xrfc_t.xrfcseq, #項次
       xrfc001 LIKE xrfc_t.xrfc001, #帳款法人組織
       xrfc002 LIKE xrfc_t.xrfc002, #帳款所屬帳套
       xrfc003 LIKE xrfc_t.xrfc003, #應收單號
       xrfc004 LIKE xrfc_t.xrfc004, #應收單項次
       xrfc005 LIKE xrfc_t.xrfc005, #多帳期序號
       xrfc006 LIKE xrfc_t.xrfc006, #類型
       xrfc007 LIKE xrfc_t.xrfc007, #收款條件
       xrfc008 LIKE xrfc_t.xrfc008, #稅別
       xrfc009 LIKE xrfc_t.xrfc009, #內部銀行帳戶編碼
       xrfc010 LIKE xrfc_t.xrfc010, #內部銀行存提碼
       xrfc011 LIKE xrfc_t.xrfc011, #應收款日
       xrfc012 LIKE xrfc_t.xrfc012, #帳款類別
       xrfc013 LIKE xrfc_t.xrfc013, #借貸別
       xrfc100 LIKE xrfc_t.xrfc100, #幣別
       xrfc101 LIKE xrfc_t.xrfc101, #匯率
       xrfc103 LIKE xrfc_t.xrfc103, #原幣沖帳金額
       xrfc104 LIKE xrfc_t.xrfc104, #本幣沖帳金額
       xrfc201 LIKE xrfc_t.xrfc201, #對應代收方當日匯率
       xrfc204 LIKE xrfc_t.xrfc204  #對應代收方本金額
       END RECORD
    DEFINE l_nmbc RECORD  #銀存收支異動檔
       nmbcent LIKE nmbc_t.nmbcent, #企業編號
       nmbcownid LIKE nmbc_t.nmbcownid, #資料所有者
       nmbcowndp LIKE nmbc_t.nmbcowndp, #資料所屬部門
       nmbccrtid LIKE nmbc_t.nmbccrtid, #資料建立者
       nmbccrtdp LIKE nmbc_t.nmbccrtdp, #資料建立部門
       nmbccrtdt LIKE nmbc_t.nmbccrtdt, #資料創建日
       nmbcmodid LIKE nmbc_t.nmbcmodid, #資料修改者
       nmbcmoddt LIKE nmbc_t.nmbcmoddt, #最近修改日
       nmbccnfid LIKE nmbc_t.nmbccnfid, #資料確認者
       nmbccnfdt LIKE nmbc_t.nmbccnfdt, #資料確認日
       nmbcpstid LIKE nmbc_t.nmbcpstid, #資料過帳者
       nmbcpstdt LIKE nmbc_t.nmbcpstdt, #資料過帳日
       nmbcstus LIKE nmbc_t.nmbcstus, #狀態碼
       nmbccomp LIKE nmbc_t.nmbccomp, #法人
       nmbcsite LIKE nmbc_t.nmbcsite, #資金中心
       nmbcdocno LIKE nmbc_t.nmbcdocno, #來源單號
       nmbcseq LIKE nmbc_t.nmbcseq, #項次
       nmbc001 LIKE nmbc_t.nmbc001, #單據來源
       nmbc002 LIKE nmbc_t.nmbc002, #交易帳戶編碼
       nmbc003 LIKE nmbc_t.nmbc003, #交易對象
       nmbc004 LIKE nmbc_t.nmbc004, #交易對象識別碼
       nmbc005 LIKE nmbc_t.nmbc005, #銀行日期
       nmbc006 LIKE nmbc_t.nmbc006, #異動別
       nmbc007 LIKE nmbc_t.nmbc007, #存提碼
       nmbc008 LIKE nmbc_t.nmbc008, #調節碼
       nmbc009 LIKE nmbc_t.nmbc009, #對帳碼
       nmbc010 LIKE nmbc_t.nmbc010, #網銀媒體檔轉出日期
       nmbc011 LIKE nmbc_t.nmbc011, #網銀媒體檔轉出批號
       nmbc100 LIKE nmbc_t.nmbc100, #交易帳戶幣別
       nmbc101 LIKE nmbc_t.nmbc101, #主帳套匯率
       nmbc103 LIKE nmbc_t.nmbc103, #主帳套原幣金額
       nmbc113 LIKE nmbc_t.nmbc113, #主帳套本幣金額
       nmbc121 LIKE nmbc_t.nmbc121, #主帳套本位幣二匯率
       nmbc123 LIKE nmbc_t.nmbc123, #主帳套本位幣二金額
       nmbc131 LIKE nmbc_t.nmbc131, #主帳套本位幣三匯率
       nmbc133 LIKE nmbc_t.nmbc133, #主帳套本位幣三金額
       nmbc012 LIKE nmbc_t.nmbc012, #票據號碼
       nmbc013 LIKE nmbc_t.nmbc013, #款別
       nmbc014 LIKE nmbc_t.nmbc014, #到期日
       nmbc015 LIKE nmbc_t.nmbc015, #匯入銀行編號
       nmbc016 LIKE nmbc_t.nmbc016, #匯入帳號
       nmbc017 LIKE nmbc_t.nmbc017, #受款人全名
       nmbcorga LIKE nmbc_t.nmbcorga  #來源組織
       END RECORD
   #161128-00061#5---modify----end------------- 
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_glaa001    LIKE glaa_t.glaa001
   DEFINE l_glaa015    LIKE glaa_t.glaa015
   DEFINE l_glaa016    LIKE glaa_t.glaa016
   DEFINE l_glaa017    LIKE glaa_t.glaa017
   DEFINE l_glaa018    LIKE glaa_t.glaa018
   DEFINE l_glaa019    LIKE glaa_t.glaa019
   DEFINE l_glaa020    LIKE glaa_t.glaa020
   DEFINE l_glaa021    LIKE glaa_t.glaa021
   DEFINE l_glaa022    LIKE glaa_t.glaa022
   DEFINE l_glaa025    LIKE glaa_t.glaa025
   DEFINE ls_js        STRING
   DEFINE lc_param     RECORD
            type       LIKE type_t.chr1,
            apca004    LIKE apca_t.apca004
                   END RECORD
   
   LET r_success = TRUE
   
   LET l_sql="SELECT xrfcseq,xrfc001,xrfc002,xrfc009,xrfc010,xrfc100,xrfc101,xrfc103,xrfc201,xrfc204",
             "  FROM xrfc_t",
             " WHERE xrfcent = ",g_enterprise," AND xrfcdocno = '",g_xrfa_m.xrfadocno,"'",
             "   AND xrfc001 <> '",g_xrfa_m.xrfacomp,"'",
             " ORDER BY xrfcseq "
   PREPARE axrt460_sel_xrfc_pr6 FROM l_sql
   DECLARE axrt460_sel_xrfc_cs6 CURSOR FOR axrt460_sel_xrfc_pr6
   
   SELECT glaa001,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022
     INTO g_glaa.glaa001,g_glaa.glaa015,g_glaa.glaa016,g_glaa.glaa017,g_glaa.glaa018,
          g_glaa.glaa019,g_glaa.glaa020,g_glaa.glaa021,g_glaa.glaa022
     FROM glaa_t
    WHERE glaaent=g_enterprise AND glaald=g_xrfa_m.xrfald
    
   FOREACH axrt460_sel_xrfc_cs6 INTO l_xrfc.xrfcseq,l_xrfc.xrfc001,l_xrfc.xrfc002,l_xrfc.xrfc009,l_xrfc.xrfc010,
                                     l_xrfc.xrfc100,l_xrfc.xrfc101,l_xrfc.xrfc103,l_xrfc.xrfc201,l_xrfc.xrfc204                   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      #1.单头法人对应的内部银行异动资料（提出）
      INITIALIZE l_nmbc.* TO NULL
      LET l_nmbc.nmbcent = g_enterprise
      LET l_nmbc.nmbccomp = g_xrfa_m.xrfacomp
      LET l_nmbc.nmbcsite = g_xrfa_m.xrfasite
      LET l_nmbc.nmbcorga = l_xrfc.xrfc001    #160322-00025#29
      LET l_nmbc.nmbcdocno = g_xrfa_m.xrfadocno
      LET l_nmbc.nmbcseq = l_xrfc.xrfcseq
      LET l_nmbc.nmbc001 = 'axrt460'
      #交易帳戶編碼、#存提码
      SELECT apaf012,apaf015 INTO l_nmbc.nmbc002,l_nmbc.nmbc007 # 歸屬組織內部帳戶
        FROM apaf_t
       WHERE apafent = g_enterprise AND apaf001 = '1'      #  代收款 
         AND apaf011 = g_xrfa_m.xrfacomp   #  帳務歸屬組織"
      #交易對象:xrfc001  法人組織對應的 (aooi100) 
      SELECT ooef024 INTO l_nmbc.nmbc003  #據點對應客戶/廠商編號 
        FROM ooef_t 
       WHERE ooefent=g_enterprise AND ooef001 = l_xrfc.xrfc001
      #銀行日期
      LET l_nmbc.nmbc005 = g_xrfa_m.xrfadocdt
      #異動別
      LET l_nmbc.nmbc006 = '2' #提出
      #交易幣別
      LET l_nmbc.nmbc100 = l_xrfc.xrfc100
      LET l_nmbc.nmbc101 = l_xrfc.xrfc201
      LET l_nmbc.nmbc103 = l_xrfc.xrfc103
      LET l_nmbc.nmbc113 = l_xrfc.xrfc204
      
      LET lc_param.type    = '1'
      LET lc_param.apca004 = g_xrfa_m.xrfa002
      LET ls_js = util.JSON.stringify(lc_param)
      CALL s_fin_get_curr_rate(g_xrfa_m.xrfacomp,g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,l_nmbc.nmbc100,ls_js)
      RETURNING l_nmbc.nmbc101,l_nmbc.nmbc121,l_nmbc.nmbc131
      #本位币二
      IF g_glaa.glaa015='Y' THEN
         IF g_glaa.glaa017='1' THEN #交易原币换算基准
#            CALL s_aooi160_get_exrate('2',g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,l_nmbc.nmbc100,g_glaa.glaa016,0,g_glaa.glaa018)
#            RETURNING l_nmbc.nmbc121
            LET l_nmbc.nmbc123 = l_nmbc.nmbc103 * l_nmbc.nmbc121
            
         ELSE #帐别本币换算基准
#            CALL s_aooi160_get_exrate('2',g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,g_glaa.glaa001,g_glaa.glaa016,0,g_glaa.glaa018)
#            RETURNING l_nmbc.nmbc121
            LET l_nmbc.nmbc123 = l_nmbc.nmbc113 * l_nmbc.nmbc121
         END IF
         CALL s_curr_round_ld('1',g_xrfa_m.xrfald,g_glaa.glaa016,l_nmbc.nmbc123,2) 
                  RETURNING g_sub_success,g_errno,l_nmbc.nmbc123
      END IF
      #本位币三
      IF g_glaa.glaa019='Y' THEN
         IF g_glaa.glaa021='1' THEN #交易原币换算基准
#            CALL s_aooi160_get_exrate('2',g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,l_nmbc.nmbc100,g_glaa.glaa020,0,g_glaa.glaa022)
#            RETURNING l_nmbc.nmbc131
            LET l_nmbc.nmbc133 = l_nmbc.nmbc103 * l_nmbc.nmbc131
         ELSE #帐别本币换算基准
#            CALL s_aooi160_get_exrate('2',g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,g_glaa.glaa001,g_glaa.glaa020,0,g_glaa.glaa022)
#            RETURNING l_nmbc.nmbc131
            LET l_nmbc.nmbc133 = l_nmbc.nmbc113 * l_nmbc.nmbc131
         END IF
         CALL s_curr_round_ld('1',g_xrfa_m.xrfald,g_glaa.glaa016,l_nmbc.nmbc133,2) 
                  RETURNING g_sub_success,g_errno,l_nmbc.nmbc133
      END IF
      LET l_nmbc.nmbcownid = g_user
      LET l_nmbc.nmbcowndp = g_dept
      LET l_nmbc.nmbccrtid = g_user
      LET l_nmbc.nmbccrtdp = g_dept
      LET l_nmbc.nmbccrtdt = cl_get_current()

      INSERT INTO nmbc_t(nmbcent,nmbccomp,nmbcsite,nmbcdocno,nmbcseq,nmbc001,nmbc002,
                         nmbc003,nmbc005,nmbc006,nmbc007,nmbc100,nmbc101,nmbc103,
                         nmbc113,nmbc121,nmbc123,nmbc131,nmbc133,
                         nmbcownid,nmbcowndp,nmbccrtid,nmbccrtdp,nmbccrtdt) 
      VALUES (l_nmbc.nmbcent,l_nmbc.nmbccomp,l_nmbc.nmbcsite,l_nmbc.nmbcdocno,l_nmbc.nmbcseq,l_nmbc.nmbc001,l_nmbc.nmbc002,
              l_nmbc.nmbc003,l_nmbc.nmbc005,l_nmbc.nmbc006,l_nmbc.nmbc007,l_nmbc.nmbc100,l_nmbc.nmbc101,l_nmbc.nmbc103,
              l_nmbc.nmbc113,l_nmbc.nmbc121,l_nmbc.nmbc123,l_nmbc.nmbc131,l_nmbc.nmbc133,
              l_nmbc.nmbcownid,l_nmbc.nmbcowndp,l_nmbc.nmbccrtid,l_nmbc.nmbccrtdp,l_nmbc.nmbccrtdt)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      
      #2.被代收法人的内部银行异动资料（存入）
      INITIALIZE l_nmbc.* TO NULL
      LET l_nmbc.nmbcent = g_enterprise
      LET l_nmbc.nmbccomp = l_xrfc.xrfc001
      LET l_nmbc.nmbcsite = g_xrfa_m.xrfasite
      LET l_nmbc.nmbcorga = l_xrfc.xrfc001    #160322-00025#29
      LET l_nmbc.nmbcdocno = g_xrfa_m.xrfadocno
      LET l_nmbc.nmbcseq = l_xrfc.xrfcseq
      LET l_nmbc.nmbc001 = 'axrt460'
      #交易帳戶編碼
      LET l_nmbc.nmbc002 = l_xrfc.xrfc009
      #存提码
      LET l_nmbc.nmbc007 = l_xrfc.xrfc010
      #交易對象:单头法人xrfacomp 法人組織對應的 (aooi100) 
      SELECT ooef024 INTO l_nmbc.nmbc003  #據點對應客戶/廠商編號 
        FROM ooef_t 
       WHERE ooefent=g_enterprise AND ooef001 = g_xrfa_m.xrfacomp
      #銀行日期
      LET l_nmbc.nmbc005 = g_xrfa_m.xrfadocdt
      #異動別
      LET l_nmbc.nmbc006 = '1' #存入
      
      #交易幣別
      LET l_nmbc.nmbc100 = l_xrfc.xrfc100
      SELECT glaa001,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa025
        INTO l_glaa001,l_glaa015,l_glaa016,l_glaa017,l_glaa018,
             l_glaa019,l_glaa020,l_glaa021,l_glaa022,l_glaa025
        FROM glaa_t
       WHERE glaaent=g_enterprise AND glaald=g_xrfa_m.xrfald
      #汇率
#      CALL s_aooi160_get_exrate('2',l_xrfc.xrfc002,g_xrfa_m.xrfadocdt,l_nmbc.nmbc100,l_glaa001,0,l_glaa025)
#      RETURNING l_nmbc.nmbc101
      LET lc_param.type    = '1'
      LET lc_param.apca004 = g_xrfa_m.xrfa002
      LET ls_js = util.JSON.stringify(lc_param)
      CALL s_fin_get_curr_rate(l_xrfc.xrfc001,l_xrfc.xrfc002,g_xrfa_m.xrfadocdt,l_nmbc.nmbc100,ls_js)
      RETURNING l_nmbc.nmbc101,l_nmbc.nmbc121,l_nmbc.nmbc131
      
      LET l_nmbc.nmbc103 = l_xrfc.xrfc103
      LET l_nmbc.nmbc113 = l_nmbc.nmbc103 * l_nmbc.nmbc101
      CALL s_curr_round_ld('1',l_xrfc.xrfc002,l_glaa001,l_nmbc.nmbc113,2) 
                  RETURNING g_sub_success,g_errno,l_nmbc.nmbc113
      #本位币二
      IF l_glaa015='Y' THEN
         IF l_glaa017='1' THEN #交易原币换算基准
#            CALL s_aooi160_get_exrate('2',l_xrfc.xrfc002,g_xrfa_m.xrfadocdt,l_nmbc.nmbc100,l_glaa016,0,l_glaa018)
#            RETURNING l_nmbc.nmbc121
            LET l_nmbc.nmbc123 = l_nmbc.nmbc103 * l_nmbc.nmbc121
         ELSE #帐别本币换算基准
#            CALL s_aooi160_get_exrate('2',l_xrfc.xrfc002,g_xrfa_m.xrfadocdt,l_glaa001,l_glaa016,0,l_glaa018)
#            RETURNING l_nmbc.nmbc121
            LET l_nmbc.nmbc123 = l_nmbc.nmbc113 * l_nmbc.nmbc121
         END IF
         CALL s_curr_round_ld('1',l_xrfc.xrfc002,l_glaa016,l_nmbc.nmbc123,2) 
                  RETURNING g_sub_success,g_errno,l_nmbc.nmbc123
      END IF
      #本位币三
      IF l_glaa019='Y' THEN
         IF l_glaa021='1' THEN #交易原币换算基准
#            CALL s_aooi160_get_exrate('2',l_xrfc.xrfc002,g_xrfa_m.xrfadocdt,l_nmbc.nmbc100,l_glaa020,0,l_glaa022)
#            RETURNING l_nmbc.nmbc131
            LET l_nmbc.nmbc133 = l_nmbc.nmbc103 * l_nmbc.nmbc131
         ELSE #帐别本币换算基准
#            CALL s_aooi160_get_exrate('2',l_xrfc.xrfc002,g_xrfa_m.xrfadocdt,l_glaa001,l_glaa020,0,l_glaa022)
#            RETURNING l_nmbc.nmbc131
            LET l_nmbc.nmbc133 = l_nmbc.nmbc113 * l_nmbc.nmbc131
         END IF
         CALL s_curr_round_ld('1',l_xrfc.xrfc002,l_glaa020,l_nmbc.nmbc133,2) 
                  RETURNING g_sub_success,g_errno,l_nmbc.nmbc133
      END IF
      LET l_nmbc.nmbcownid = g_user
      LET l_nmbc.nmbcowndp = g_dept
      LET l_nmbc.nmbccrtid = g_user
      LET l_nmbc.nmbccrtdp = g_dept
      LET l_nmbc.nmbccrtdt = cl_get_current()

      INSERT INTO nmbc_t(nmbcent,nmbccomp,nmbcsite,nmbcdocno,nmbcseq,nmbc001,nmbc002,
                         nmbc003,nmbc005,nmbc006,nmbc007,nmbc100,nmbc101,nmbc103,
                         nmbc113,nmbc121,nmbc123,nmbc131,nmbc133,
                         nmbcownid,nmbcowndp,nmbccrtid,nmbccrtdp,nmbccrtdt) 
      VALUES (l_nmbc.nmbcent,l_nmbc.nmbccomp,l_nmbc.nmbcsite,l_nmbc.nmbcdocno,l_nmbc.nmbcseq,l_nmbc.nmbc001,l_nmbc.nmbc002,
              l_nmbc.nmbc003,l_nmbc.nmbc005,l_nmbc.nmbc006,l_nmbc.nmbc007,l_nmbc.nmbc100,l_nmbc.nmbc101,l_nmbc.nmbc103,
              l_nmbc.nmbc113,l_nmbc.nmbc121,l_nmbc.nmbc123,l_nmbc.nmbc131,l_nmbc.nmbc133,
              l_nmbc.nmbcownid,l_nmbc.nmbcowndp,l_nmbc.nmbccrtid,l_nmbc.nmbccrtdp,l_nmbc.nmbccrtdt)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END FOREACH   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 开窗多选时插入选择单号
# Memo...........:
# Usage..........: CALL axrt460_ins_xrfb()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/06 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt460_ins_xrfb()
  #161128-00061#5---modify----begin-------------  
  #DEFINE l_xrfb         RECORD LIKE xrfb_t.*
  #DEFINE l_nmbb         RECORD LIKE nmbb_t.*
   DEFINE l_nmbb RECORD  #銀存收支明細檔
       nmbbent LIKE nmbb_t.nmbbent, #企業編號
       nmbbcomp LIKE nmbb_t.nmbbcomp, #法人
       nmbbdocno LIKE nmbb_t.nmbbdocno, #收支單號
       nmbbseq LIKE nmbb_t.nmbbseq, #項次
       nmbborga LIKE nmbb_t.nmbborga, #來源組織
       nmbblegl LIKE nmbb_t.nmbblegl, #核算組織
       nmbb001 LIKE nmbb_t.nmbb001, #異動別
       nmbb002 LIKE nmbb_t.nmbb002, #存提碼
       nmbb003 LIKE nmbb_t.nmbb003, #交易帳戶編碼
       nmbb004 LIKE nmbb_t.nmbb004, #幣別
       nmbb005 LIKE nmbb_t.nmbb005, #匯率
       nmbb006 LIKE nmbb_t.nmbb006, #主帳套原幣金額
       nmbb007 LIKE nmbb_t.nmbb007, #主帳套本幣金額
       nmbb008 LIKE nmbb_t.nmbb008, #主帳套已沖原幣金額
       nmbb009 LIKE nmbb_t.nmbb009, #主帳套已沖本幣金額
       nmbb010 LIKE nmbb_t.nmbb010, #現金變動碼
       nmbb011 LIKE nmbb_t.nmbb011, #本位幣二幣別
       nmbb012 LIKE nmbb_t.nmbb012, #本位幣二匯率
       nmbb013 LIKE nmbb_t.nmbb013, #本位幣二金額
       nmbb014 LIKE nmbb_t.nmbb014, #本位幣二已沖金額
       nmbb015 LIKE nmbb_t.nmbb015, #本位幣三幣別
       nmbb016 LIKE nmbb_t.nmbb016, #本位幣三匯率
       nmbb017 LIKE nmbb_t.nmbb017, #本位幣三金額
       nmbb018 LIKE nmbb_t.nmbb018, #本位幣三已沖金額
       nmbb019 LIKE nmbb_t.nmbb019, #輔助帳套一匯率
       nmbb020 LIKE nmbb_t.nmbb020, #輔助帳套一原幣已沖
       nmbb021 LIKE nmbb_t.nmbb021, #輔助帳套一本幣已沖
       nmbb022 LIKE nmbb_t.nmbb022, #輔助帳套二匯率
       nmbb023 LIKE nmbb_t.nmbb023, #輔助帳套二原幣已沖
       nmbb024 LIKE nmbb_t.nmbb024, #輔助帳套二本幣已沖
       nmbb025 LIKE nmbb_t.nmbb025, #備註
       nmbb026 LIKE nmbb_t.nmbb026, #交易對象
       nmbb027 LIKE nmbb_t.nmbb027, #一次性交易對象識別碼
       nmbb028 LIKE nmbb_t.nmbb028, #款別編碼
       nmbb029 LIKE nmbb_t.nmbb029, #款別分類
       nmbb030 LIKE nmbb_t.nmbb030, #票據號碼
       nmbb031 LIKE nmbb_t.nmbb031, #到期日
       nmbb032 LIKE nmbb_t.nmbb032, #有價券數量
       nmbb033 LIKE nmbb_t.nmbb033, #有價券面額
       nmbb034 LIKE nmbb_t.nmbb034, #有價券起始編號
       nmbb035 LIKE nmbb_t.nmbb035, #有價券結束編號
       nmbb036 LIKE nmbb_t.nmbb036, #刷卡銀行
       nmbb037 LIKE nmbb_t.nmbb037, #信用卡卡號
       nmbb038 LIKE nmbb_t.nmbb038, #手續費
       nmbb039 LIKE nmbb_t.nmbb039, #第三方代收機構
       nmbb040 LIKE nmbb_t.nmbb040, #背書轉入
       nmbb041 LIKE nmbb_t.nmbb041, #發票人全名
       nmbb042 LIKE nmbb_t.nmbb042, #票況
       nmbb043 LIKE nmbb_t.nmbb043, #票據付款銀行
       nmbb044 LIKE nmbb_t.nmbb044, #票面利率種類
       nmbb045 LIKE nmbb_t.nmbb045, #票面利率百分比
       nmbb046 LIKE nmbb_t.nmbb046, #轉付交易對象
       nmbb047 LIKE nmbb_t.nmbb047, #票據流通期間
       nmbb048 LIKE nmbb_t.nmbb048, #貼現利率種類
       nmbb049 LIKE nmbb_t.nmbb049, #貼現利率
       nmbb050 LIKE nmbb_t.nmbb050, #貼現期間
       nmbb051 LIKE nmbb_t.nmbb051, #貼現撥款原幣金額
       nmbb052 LIKE nmbb_t.nmbb052, #貼現撥款本幣金額
       nmbb053 LIKE nmbb_t.nmbb053, #繳款人員
       nmbb054 LIKE nmbb_t.nmbb054, #繳款部門
       nmbb055 LIKE nmbb_t.nmbb055, #POS繳款單號
       nmbb056 LIKE nmbb_t.nmbb056, #入帳匯率
       nmbb057 LIKE nmbb_t.nmbb057, #入帳原幣金額
       nmbb058 LIKE nmbb_t.nmbb058, #入帳主帳套本幣金額
       nmbb059 LIKE nmbb_t.nmbb059, #入帳主帳套本位幣二匯率
       nmbb060 LIKE nmbb_t.nmbb060, #入帳主帳套本位幣二金額
       nmbb061 LIKE nmbb_t.nmbb061, #入帳主帳套本位幣三匯率
       nmbb062 LIKE nmbb_t.nmbb062, #入帳主帳套本位幣三金額
       nmbb063 LIKE nmbb_t.nmbb063, #對方會科
       nmbb064 LIKE nmbb_t.nmbb064, #差異處理狀態
       nmbb065 LIKE nmbb_t.nmbb065, #開票日期
       nmbb066 LIKE nmbb_t.nmbb066, #重評後本幣金額
       nmbb067 LIKE nmbb_t.nmbb067, #重評後本位幣二金額
       nmbb068 LIKE nmbb_t.nmbb068, #重評後本位幣三金額
       nmbb069 LIKE nmbb_t.nmbb069, #質押否
       nmbb070 LIKE nmbb_t.nmbb070, #往來據點
       nmbb071 LIKE nmbb_t.nmbb071, #來源單號
       nmbb072 LIKE nmbb_t.nmbb072, #項次
       nmbb073 LIKE nmbb_t.nmbb073  #開票帳號
       END RECORD
DEFINE l_xrfb RECORD  #集團收款核銷單收款明細檔
       xrfbent LIKE xrfb_t.xrfbent, #企業編碼
       xrfbdocno LIKE xrfb_t.xrfbdocno, #集團代收單號
       xrfbld LIKE xrfb_t.xrfbld, #帳套
       xrfbseq LIKE xrfb_t.xrfbseq, #項次
       xrfb001 LIKE xrfb_t.xrfb001, #來源組織
       xrfb002 LIKE xrfb_t.xrfb002, #繳款單號
       xrfb003 LIKE xrfb_t.xrfb003, #繳款單項次
       xrfb004 LIKE xrfb_t.xrfb004, #款別
       xrfb005 LIKE xrfb_t.xrfb005, #銀行存提碼
       xrfb006 LIKE xrfb_t.xrfb006, #類型
       xrfb007 LIKE xrfb_t.xrfb007, #借貸別
       xrfb100 LIKE xrfb_t.xrfb100, #收款幣別
       xrfb101 LIKE xrfb_t.xrfb101, #匯率
       xrfb103 LIKE xrfb_t.xrfb103, #收款原幣金額
       xrfb104 LIKE xrfb_t.xrfb104, #收款本幣金額
       xrfb201 LIKE xrfb_t.xrfb201, #對應代收方當日匯率
       xrfb204 LIKE xrfb_t.xrfb204 #對應代收方本幣金額
       END RECORD

  #161128-00061#5---modify----end------------- 
   DEFINE l_count        LIKE type_t.num5
   DEFINE l_ld_s         LIKE type_t.num5
   DEFINE l_gzcb003      LIKE gzcb_t.gzcb003
   DEFINE l_xrde109      LIKE xrde_t.xrde109
   DEFINE l_xrde119      LIKE xrde_t.xrde119
   DEFINE l_rate1        LIKE xrfb_t.xrfb201
   DEFINE l_rate2        LIKE xrfb_t.xrfb201
   DEFINE ls_js          STRING
   DEFINE lc_param       RECORD
            type         LIKE type_t.chr1,
            apca004      LIKE apca_t.apca004
                     END RECORD
   DEFINE l_sql          STRING
   
   CALL s_transaction_end('N',0)

   CALL s_transaction_begin()
   LET g_success = TRUE
   CALL cl_err_collect_init()
   
   DELETE FROM xrfb_t 
    WHERE xrfbent = g_enterprise
      AND xrfbdocno = g_xrfa_m.xrfadocno
      AND xrfbseq = g_xrfb_d[l_ac].xrfbseq
      AND xrfb002 = g_xrfb_d[l_ac].xrfb002
   
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xrfa_m.xrfald
      AND glaa014 = 'Y'
   IF l_count > 0 THEN
     LET l_ld_s = 1
   ELSE
      #次帳套一
      LET l_count = 0
      SELECT COUNT(*) INTO l_count FROM ooab_t 
       WHERE ooab001 = 'S-FIN-0001' AND ooab002 = g_xrfa_m.xrfald
         AND ooabsite= g_xrfa_m.xrfasite
         AND ooabent = g_enterprise #160905-00002#5
      IF l_count > 0 THEN
         LET l_ld_s = 2
      END IF
      #次帳套二
      LET l_count = 0
      SELECT COUNT(*) INTO l_count FROM ooab_t 
       WHERE ooab001 = 'S-FIN-0002' AND ooab002 = g_xrfa_m.xrfald
         AND ooabsite= g_xrfa_m.xrfasite
         AND ooabent = g_enterprise #160905-00002#5
      IF l_count > 0 THEN
         LET l_ld_s = 3
      END IF
   END IF
   
   #161128-00061#5---modify----begin------------- 
   #LET l_sql = "SELECT * FROM nmbb_t WHERE ",g_qryparam.return1
   LET l_sql = "SELECT nmbbent,nmbbcomp,nmbbdocno,nmbbseq,nmbborga,nmbblegl,nmbb001,nmbb002,nmbb003,",
               "nmbb004,nmbb005,nmbb006,nmbb007,nmbb008,nmbb009,nmbb010,nmbb011,nmbb012,nmbb013,nmbb014,",
               "nmbb015,nmbb016,nmbb017,nmbb018,nmbb019,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,nmbb025,",
               "nmbb026,nmbb027,nmbb028,nmbb029,nmbb030,nmbb031,nmbb032,nmbb033,nmbb034,nmbb035,nmbb036,",
               "nmbb037,nmbb038,nmbb039,nmbb040,nmbb041,nmbb042,nmbb043,nmbb044,nmbb045,nmbb046,nmbb047,",
               "nmbb048,nmbb049,nmbb050,nmbb051,nmbb052,nmbb053,nmbb054,nmbb055,nmbb056,nmbb057,nmbb058,",
               "nmbb059,nmbb060,nmbb061,nmbb062,nmbb063,nmbb064,nmbb065,nmbb066,nmbb067,nmbb068,nmbb069,",
               "nmbb070,nmbb071,nmbb072,nmbb073 FROM nmbb_t WHERE ",g_qryparam.return1
   #161128-00061#5---modify----end------------- 
   PREPARE axrt460_sel_nmbb_prep FROM l_sql
   DECLARE axrt460_sel_nmbb_curs CURSOR FOR axrt460_sel_nmbb_prep
   
   INITIALIZE l_nmbb.* TO NULL
   INITIALIZE l_xrfb.* TO NULL
   LET l_xrfb.xrfbent  = l_nmbb.nmbbent   
   LET l_xrfb.xrfbld   = g_xrfb_d[l_ac].xrfbld
   LET l_xrfb.xrfbdocno= g_xrfa_m.xrfadocno
   #项次
   IF cl_null(g_xrfb_d_t.xrfb002) THEN 
      SELECT MAX(xrfbseq) INTO l_xrfb.xrfbseq
        FROM xrfb_t
       WHERE xrfbent = g_enterprise 
         AND xrfbdocno = g_xrfa_m.xrfadocno
      IF cl_null(l_xrfb.xrfbseq) THEN
         LET l_xrfb.xrfbseq = 1
      ELSE
         LET l_xrfb.xrfbseq = l_xrfb.xrfbseq + 1 
      END IF
   ELSE
      LET l_xrfb.xrfbseq = g_xrfb_d_t.xrfbseq
   END IF
   LET l_xrfb.xrfb001  = g_xrfb_d[l_ac].xrfb001
   LET l_xrfb.xrfb004  = g_xrfb_d[l_ac].xrfb004  #款别
   LET l_xrfb.xrfb006  = g_xrfb_d[l_ac].xrfb006  #类型
   #借贷别   
   SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
    WHERE gzcb001 = '8306'
      AND gzcb002 = g_xrfb_d[l_ac].xrfb006
   IF l_gzcb003 = 'D' THEN
      LET l_xrfb.xrfb007   =  'D'
   ELSE
      LET l_xrfb.xrfb007   =  'C'
   END IF
   
   FOREACH axrt460_sel_nmbb_curs INTO l_nmbb.* 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH
      END IF
 
      LET l_xrfb.xrfb002  = l_nmbb.nmbbdocno
      LET l_xrfb.xrfb003  = l_nmbb.nmbbseq
      LET l_xrfb.xrfb005  = l_nmbb.nmbb002
      LET l_xrfb.xrfb100  = l_nmbb.nmbb004
      LET l_xrfb.xrfb101  = l_nmbb.nmbb005
      #計算預沖金額
      LET l_xrde109 = 0   LET l_xrde119 = 0
      SELECT SUM(xrde109),SUM(xrde119)
        INTO l_xrde109,l_xrde119 
        FROM xrde_t,xrda_t    
       WHERE xrdaent   = xrdeent
         AND xrdald    = xrdeld
         AND xrdadocno = xrdedocno
         AND xrde003   = l_nmbb.nmbbdocno
         AND xrde004   = l_nmbb.nmbbseq
         AND xrdastus  = 'N'
      IF cl_null(l_xrde109) THEN LET l_xrde109 = 0 END IF
      IF cl_null(l_xrde119) THEN LET l_xrde119 = 0 END IF
      #原币、本币金额
      CASE
         WHEN l_ld_s = 1
            LET l_xrfb.xrfb103  = l_nmbb.nmbb006 - l_nmbb.nmbb008 - l_xrde109
            LET l_xrfb.xrfb104  = l_nmbb.nmbb007 - l_nmbb.nmbb009 - l_xrde119
         WHEN l_ld_s = 2
            LET l_xrfb.xrfb103  = l_nmbb.nmbb006 - l_nmbb.nmbb020 - l_xrde109
            LET l_xrfb.xrfb104  = l_nmbb.nmbb007 - l_nmbb.nmbb021 - l_xrde119
         WHEN l_ld_s = 3
            LET l_xrfb.xrfb103  = l_nmbb.nmbb006 - l_nmbb.nmbb023 - l_xrde109
            LET l_xrfb.xrfb104  = l_nmbb.nmbb007 - l_nmbb.nmbb024 - l_xrde119
      END CASE
      IF l_xrfb.xrfb103 <= 0 THEN CONTINUE FOREACH END IF
      
      #对应代收方币别的汇率、金额
      LET lc_param.type    = '1'
      LET lc_param.apca004 = g_xrfa_m.xrfa002
      LET ls_js = util.JSON.stringify(lc_param)
      CALL s_fin_get_curr_rate(g_xrfa_m.xrfacomp,g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,l_xrfb.xrfb100,ls_js)
      RETURNING l_xrfb.xrfb201,l_rate1,l_rate2
      #換算代收方本幣
      LET l_xrfb.xrfb204=l_xrfb.xrfb103 * l_xrfb.xrfb201
      CALL s_curr_round_ld('1',g_xrfa_m.xrfald,g_glaa.glaa001,l_xrfb.xrfb204,2) 
      RETURNING g_sub_success,g_errno,l_xrfb.xrfb204
      
      INSERT INTO xrfb_t(xrfbent,xrfbdocno,xrfbseq,xrfb001,xrfbld,
                         xrfb007,xrfb006,xrfb004,xrfb002,xrfb003,
                         xrfb100,xrfb101,xrfb103,xrfb104,xrfb005,
                         xrfb201,xrfb204) 
      VALUES(g_enterprise,l_xrfb.xrfbdocno,l_xrfb.xrfbseq,l_xrfb.xrfb001,l_xrfb.xrfbld,
             l_xrfb.xrfb007,l_xrfb.xrfb006,l_xrfb.xrfb004,l_xrfb.xrfb002,l_xrfb.xrfb003,
             l_xrfb.xrfb100,l_xrfb.xrfb101,l_xrfb.xrfb103,l_xrfb.xrfb104,l_xrfb.xrfb005, 
             l_xrfb.xrfb201,l_xrfb.xrfb204)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "ins xrfb_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_success = FALSE
         CONTINUE FOREACH
      END IF
      
      SELECT MAX(xrfbseq) INTO l_xrfb.xrfbseq
        FROM xrfb_t
       WHERE xrfbent = g_enterprise 
         AND xrfbdocno = g_xrfa_m.xrfadocno
      IF cl_null(l_xrfb.xrfbseq) THEN
         LET l_xrfb.xrfbseq = 1
      ELSE
         LET l_xrfb.xrfbseq = l_xrfb.xrfbseq + 1 
      END IF

   END FOREACH
   
   CALL cl_err_collect_show()
   IF g_success = TRUE THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF

   CALL axrt460_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axrt460_glaa_get(p_ld)
#                  RETURNING 回传参数
# Input parameter: p_ld           账套
# Return code....: 
# Date & Author..: 2015/11/06 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt460_glaa_get(p_ld)
   DEFINE p_ld        LIKE glaa_t.glaald
   DEFINE l_str       LIKE type_t.num5
   DEFINE l_end       LIKE type_t.num5      
   DEFINE l_glaa024   LIKE glaa_t.glaa024
   DEFINE l_glaa136   LIKE glaa_t.glaa136
   
   SELECT glaa024,glaa136 INTO l_glaa024,l_glaa136 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_ld

   #帳套設定:核銷限定立帳己產生傳票
   IF l_glaa136 = 'Y' THEN
      CALL s_aapt420_get_slip_pos('') RETURNING l_str,l_end
      LET g_wc3 =
      #排除所屬單別參數"產生分錄傳票否"為Y,但尚未產生傳票者
      " AND NOT (",
      "      EXISTS (SELECT 1 FROM ooac_t ",
      "               WHERE ooacent = apcaent ",
      "                 AND ooac001 = '",l_glaa024,"' ",
      "                 AND ooac002 = SUBSTR(apcadocno,",l_str,",",l_end,") ",
      "                 AND ooac003 = 'D-FIN-0030' ",
      "                 AND ooac004 ='Y') ",
      "         AND apca038 IS NULL",
      "     )  "
   ELSE
      LET g_wc3 = ''
   END IF
 
END FUNCTION

################################################################################
# Descriptions...: 开窗多选时，将选中单据资料插入xrfc_t表
# Memo...........:
# Usage..........: CALL axrt460_ins_xrfc_04()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/06 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt460_ins_xrfc_04()
   #161128-00061#5---modify----begin------------- 
   #DEFINE l_xrfc        RECORD LIKE xrfc_t.*
   #DEFINE l_xrcc        RECORD LIKE xrcc_t.*
   DEFINE l_xrfc RECORD  #集團收款核銷單帳款明細檔
       xrfcent LIKE xrfc_t.xrfcent, #企業編碼
       xrfcdocno LIKE xrfc_t.xrfcdocno, #集團代收單號
       xrfcseq LIKE xrfc_t.xrfcseq, #項次
       xrfc001 LIKE xrfc_t.xrfc001, #帳款法人組織
       xrfc002 LIKE xrfc_t.xrfc002, #帳款所屬帳套
       xrfc003 LIKE xrfc_t.xrfc003, #應收單號
       xrfc004 LIKE xrfc_t.xrfc004, #應收單項次
       xrfc005 LIKE xrfc_t.xrfc005, #多帳期序號
       xrfc006 LIKE xrfc_t.xrfc006, #類型
       xrfc007 LIKE xrfc_t.xrfc007, #收款條件
       xrfc008 LIKE xrfc_t.xrfc008, #稅別
       xrfc009 LIKE xrfc_t.xrfc009, #內部銀行帳戶編碼
       xrfc010 LIKE xrfc_t.xrfc010, #內部銀行存提碼
       xrfc011 LIKE xrfc_t.xrfc011, #應收款日
       xrfc012 LIKE xrfc_t.xrfc012, #帳款類別
       xrfc013 LIKE xrfc_t.xrfc013, #借貸別
       xrfc100 LIKE xrfc_t.xrfc100, #幣別
       xrfc101 LIKE xrfc_t.xrfc101, #匯率
       xrfc103 LIKE xrfc_t.xrfc103, #原幣沖帳金額
       xrfc104 LIKE xrfc_t.xrfc104, #本幣沖帳金額
       xrfc201 LIKE xrfc_t.xrfc201, #對應代收方當日匯率
       xrfc204 LIKE xrfc_t.xrfc204  #對應代收方本金額
       END RECORD
  DEFINE l_xrcc RECORD  #多帳期明細
       xrccent LIKE xrcc_t.xrccent, #企業編號
       xrccld LIKE xrcc_t.xrccld, #帳套
       xrcccomp LIKE xrcc_t.xrcccomp, #法人
       xrccdocno LIKE xrcc_t.xrccdocno, #應收帳款單號碼
       xrccseq LIKE xrcc_t.xrccseq, #項次
       xrcc001 LIKE xrcc_t.xrcc001, #期別
       xrcc002 LIKE xrcc_t.xrcc002, #應收收款類別
       xrcc003 LIKE xrcc_t.xrcc003, #應收款日
       xrcc004 LIKE xrcc_t.xrcc004, #容許票據到期日
       xrcc005 LIKE xrcc_t.xrcc005, #帳款起算日
       xrcc006 LIKE xrcc_t.xrcc006, #正負值
       xrcclegl LIKE xrcc_t.xrcclegl, #核算組織
       xrcc008 LIKE xrcc_t.xrcc008, #發票編號
       xrcc009 LIKE xrcc_t.xrcc009, #發票號碼
       xrccsite LIKE xrcc_t.xrccsite, #帳務中心
       xrcc010 LIKE xrcc_t.xrcc010, #發票日期
       xrcc011 LIKE xrcc_t.xrcc011, #出貨單據日期
       xrcc012 LIKE xrcc_t.xrcc012, #立帳日期
       xrcc013 LIKE xrcc_t.xrcc013, #交易認定日期
       xrcc014 LIKE xrcc_t.xrcc014, #出入庫扣帳日期
       xrcc100 LIKE xrcc_t.xrcc100, #交易原幣別
       xrcc101 LIKE xrcc_t.xrcc101, #原幣匯率
       xrcc102 LIKE xrcc_t.xrcc102, #原幣重估後匯率
       xrcc103 LIKE xrcc_t.xrcc103, #重評價調整數
       xrcc104 LIKE xrcc_t.xrcc104, #No Use
       xrcc105 LIKE xrcc_t.xrcc105, #No Use
       xrcc106 LIKE xrcc_t.xrcc106, #No Use
       xrcc107 LIKE xrcc_t.xrcc107, #No Use
       xrcc108 LIKE xrcc_t.xrcc108, #原幣應收金額
       xrcc109 LIKE xrcc_t.xrcc109, #原幣收款沖帳金額
       xrcc113 LIKE xrcc_t.xrcc113, #本幣重評價調整數
       xrcc114 LIKE xrcc_t.xrcc114, #No Use
       xrcc115 LIKE xrcc_t.xrcc115, #No Use
       xrcc116 LIKE xrcc_t.xrcc116, #No Use
       xrcc117 LIKE xrcc_t.xrcc117, #No Use
       xrcc118 LIKE xrcc_t.xrcc118, #本幣應收金額
       xrcc119 LIKE xrcc_t.xrcc119, #本幣收款沖帳金額
       xrcc120 LIKE xrcc_t.xrcc120, #本位幣二幣別
       xrcc121 LIKE xrcc_t.xrcc121, #本位幣二匯率
       xrcc122 LIKE xrcc_t.xrcc122, #本位幣二重估後匯率
       xrcc123 LIKE xrcc_t.xrcc123, #本位幣二重評價調整數
       xrcc124 LIKE xrcc_t.xrcc124, #No Use
       xrcc125 LIKE xrcc_t.xrcc125, #No Use
       xrcc126 LIKE xrcc_t.xrcc126, #No Use
       xrcc127 LIKE xrcc_t.xrcc127, #No Use
       xrcc128 LIKE xrcc_t.xrcc128, #本位幣二應收金額
       xrcc129 LIKE xrcc_t.xrcc129, #本位幣二收款沖帳金額
       xrcc130 LIKE xrcc_t.xrcc130, #本位幣三幣別
       xrcc131 LIKE xrcc_t.xrcc131, #本位幣三匯率
       xrcc132 LIKE xrcc_t.xrcc132, #本位幣三重估後匯率
       xrcc133 LIKE xrcc_t.xrcc133, #本位幣三重評價調整數
       xrcc134 LIKE xrcc_t.xrcc134, #No Use
       xrcc135 LIKE xrcc_t.xrcc135, #No Use
       xrcc136 LIKE xrcc_t.xrcc136, #No Use
       xrcc137 LIKE xrcc_t.xrcc137, #No Use
       xrcc138 LIKE xrcc_t.xrcc138, #本位幣三應收金額
       xrcc139 LIKE xrcc_t.xrcc139, #本位幣三收款沖帳金額
       xrcc015 LIKE xrcc_t.xrcc015, #收款條件
       xrcc016 LIKE xrcc_t.xrcc016, #帳款類型
       xrcc017 LIKE xrcc_t.xrcc017 #訂單單號
       END RECORD

   #161128-00061#5---modify----end------------- 
   DEFINE l_gzcb003     LIKE gzcb_t.gzcb003
   DEFINE l_xrce109     LIKE xrce_t.xrce109
   DEFINE l_xrce119     LIKE xrce_t.xrce119
   DEFINE l_xrce109_1   LIKE xrce_t.xrce109
   DEFINE l_xrce119_1   LIKE xrce_t.xrce119
   DEFINE l_rate1        LIKE xrfb_t.xrfb201
   DEFINE l_rate2        LIKE xrfb_t.xrfb201
   DEFINE ls_js          STRING
   DEFINE lc_param       RECORD
            type         LIKE type_t.chr1,
            apca004      LIKE apca_t.apca004
                     END RECORD
   DEFINE l_sql          STRING
   
   CALL s_transaction_end('N',0)

   CALL s_transaction_begin()
   LET g_success = TRUE
   CALL cl_err_collect_init()
   
   DELETE FROM xrfc_t 
    WHERE xrfcent = g_enterprise
      AND xrfcdocno = g_xrfa_m.xrfadocno
      AND xrfcseq = g_xrfb2_d[l_ac].xrfcseq
      AND xrfc003 = g_xrfb2_d[l_ac].xrfc003
   
   #計算帳款部分
   LET l_sql ="SELECT xrccdocno,xrccseq,xrcc001,xrcc003,xrcc100,xrcc102,xrcc108,xrcc109,xrcc118,xrcc119,xrcc113 ",
              "  FROM xrcc_t,xrca_t,gzcb_t",
              " WHERE xrccent = '",g_enterprise,"'",
              "   AND xrccld = xrcald",
              "   AND xrccdocno = xrcadocno",
              "   AND xrccent = xrcaent ",
              "   AND xrcastus = 'Y'",
              "   AND xrca001 = gzcb002",
              "   AND gzcb003 = '1'",
              "   AND gzcb001 = '8302'",
              "   AND xrcc108 - xrcc109 > 0",
              "   AND xrca004 = '",g_xrfa_m.xrfa002,"'",
              "   AND (",g_qryparam.return1,")"
   
   PREPARE axrt460_sel_xrcc_prep FROM l_sql
   DECLARE axrt460_sel_xrcc_curs CURSOR FOR axrt460_sel_xrcc_prep
    
   SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
    WHERE gzcb002 = g_xrfb2_d[l_ac].xrfc006
      AND gzcb001 = '8306'
      
   INITIALIZE l_xrfc.* TO NULL
   LET l_xrfc.xrfcent   = g_enterprise
   LET l_xrfc.xrfcdocno = g_xrfa_m.xrfadocno
   #项次
   IF cl_null(g_xrfb2_d_t.xrfc003) THEN 
      SELECT MAX(xrfcseq) INTO l_xrfc.xrfcseq
        FROM xrfc_t
       WHERE xrfcent = g_enterprise 
         AND xrfcdocno = g_xrfa_m.xrfadocno
      IF cl_null(l_xrfc.xrfcseq) THEN
         LET l_xrfc.xrfcseq = 1
      ELSE
         LET l_xrfc.xrfcseq = l_xrfc.xrfcseq + 1
      END IF
   ELSE
      LET l_xrfc.xrfcseq = g_xrfb2_d_t.xrfcseq
   END IF
   LET l_xrfc.xrfc001   = g_xrfb2_d[l_ac].xrfc001 #法人
   LET l_xrfc.xrfc002   = g_xrfb2_d[l_ac].xrfc002 #账套
   LET l_xrfc.xrfc006   = g_xrfb2_d[l_ac].xrfc006 #类型
   #借贷别
   IF l_gzcb003 = 'D' THEN
      LET l_xrfc.xrfc013   =  'D'
   ELSE
      LET l_xrfc.xrfc013   =  'C'
   END IF
   #账款类别 #收款条件 #税别 #内部银行账户 #内部银行存提码
   SELECT apaf017,apaf018,apaf019,apaf012,apaf015 
     INTO l_xrfc.xrfc012,l_xrfc.xrfc007,l_xrfc.xrfc008,
          l_xrfc.xrfc009,l_xrfc.xrfc010
    FROM apaf_t
   WHERE apafent=g_enterprise AND apaf001='1' 
     AND apaf011=g_xrfb2_d[l_ac].xrfc001
     
   FOREACH axrt460_sel_xrcc_curs INTO l_xrcc.xrccdocno,l_xrcc.xrccseq,l_xrcc.xrcc001,l_xrcc.xrcc003,
                                      l_xrcc.xrcc100,l_xrcc.xrcc102,l_xrcc.xrcc108,l_xrcc.xrcc109,
                                      l_xrcc.xrcc118,l_xrcc.xrcc119,l_xrcc.xrcc113
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH
      END IF
      
      LET l_xrfc.xrfc003  = l_xrcc.xrccdocno #单号
      LET l_xrfc.xrfc004  = l_xrcc.xrccseq   #项次
      LET l_xrfc.xrfc005  = l_xrcc.xrcc001   #分期序号
      LET l_xrfc.xrfc011  = l_xrcc.xrcc003   #应收款日
      LET l_xrfc.xrfc100  = l_xrcc.xrcc100   #币别
      LET l_xrfc.xrfc101  = l_xrcc.xrcc102   #汇率 
      
      #計算預沖金額
      LET l_xrce109 = 0   LET l_xrce119 = 0
      SELECT SUM(xrce109),SUM(xrce119)
        INTO l_xrce109,l_xrce119
        FROM xrce_t,xrda_t
       WHERE xrdaent   = xrceent
         AND xrdald    = xrceld
         AND xrdadocno = xrcedocno
         AND xrdald    = g_xrfb2_d[l_ac].xrfc002
         AND xrce003   = l_xrcc.xrccdocno
         AND xrce004   = l_xrcc.xrccseq
         AND xrce005   = l_xrcc.xrcc001
         AND xrdastus  = 'N'
      IF cl_null(l_xrce109) THEN LET l_xrce109 = 0 END IF
      IF cl_null(l_xrce119) THEN LET l_xrce119 = 0 END IF
      
      #直接冲账
      SELECT SUM(xrce109),SUM(xrce119)
        INTO l_xrce109_1,l_xrce119_1
        FROM xrce_t,xrca_t
       WHERE xrcaent   = g_enterprise
         AND xrcald    = xrceld
         AND xrcadocno = xrcedocno
         AND xrcald    = g_xrfb2_d[l_ac].xrfc002
         AND xrce003   = l_xrcc.xrccdocno
         AND xrce004   = l_xrcc.xrccseq
         AND xrce005   = l_xrcc.xrcc001
         AND xrcastus  = 'N'
         
      IF cl_null(l_xrce109_1) THEN LET l_xrce109_1 = 0 END IF
      IF cl_null(l_xrce119_1) THEN LET l_xrce119_1 = 0 END IF
      
      LET l_xrfc.xrfc103  = l_xrcc.xrcc108 - l_xrcc.xrcc109 - l_xrce109 - l_xrce109_1 
      LET l_xrfc.xrfc104  = l_xrcc.xrcc118 - l_xrcc.xrcc119 + l_xrcc.xrcc113 - l_xrce119 - l_xrce119_1 
      IF l_xrfc.xrfc103 <= 0 THEN CONTINUE FOREACH END IF
      #对应代收方币别的汇率
      LET lc_param.type    = '1'
      LET lc_param.apca004 = g_xrfa_m.xrfa002
      LET ls_js = util.JSON.stringify(lc_param)
      CALL s_fin_get_curr_rate(g_xrfa_m.xrfacomp,g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,l_xrfc.xrfc100,ls_js)
      RETURNING l_xrfc.xrfc201,l_rate1,l_rate2
      #換算被代收方本幣
      LET l_xrfc.xrfc204 = l_xrfc.xrfc103 * l_xrfc.xrfc201
      CALL s_curr_round_ld('1',g_xrfa_m.xrfald,g_glaa.glaa001,l_xrfc.xrfc204,2) 
            RETURNING g_sub_success,g_errno,l_xrfc.xrfc204
            
      INSERT INTO xrfc_t(xrfcent,xrfcdocno,xrfcseq,xrfc001,xrfc002,xrfc006,
                         xrfc013,xrfc003,xrfc004,xrfc005,xrfc011,xrfc100,
                         xrfc101,xrfc103,xrfc104,xrfc201,xrfc204,xrfc012,
                         xrfc007,xrfc008,xrfc009,xrfc010) 
      VALUES(g_enterprise,l_xrfc.xrfcdocno,l_xrfc.xrfcseq,l_xrfc.xrfc001,l_xrfc.xrfc002,l_xrfc.xrfc006, 
             l_xrfc.xrfc013,l_xrfc.xrfc003,l_xrfc.xrfc004,l_xrfc.xrfc005,l_xrfc.xrfc011,l_xrfc.xrfc100, 
             l_xrfc.xrfc101,l_xrfc.xrfc103,l_xrfc.xrfc104,l_xrfc.xrfc201,l_xrfc.xrfc204,l_xrfc.xrfc012, 
             l_xrfc.xrfc007,l_xrfc.xrfc008,l_xrfc.xrfc009,l_xrfc.xrfc010)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "ins xrfc_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_success = FALSE
         CONTINUE FOREACH
      END IF

      SELECT MAX(xrfcseq) INTO l_xrfc.xrfcseq
        FROM xrfc_t
       WHERE xrfcent = g_enterprise 
         AND xrfcdocno = g_xrfa_m.xrfadocno
      IF cl_null(l_xrfc.xrfcseq) THEN
         LET l_xrfc.xrfcseq = 1
      ELSE
         LET l_xrfc.xrfcseq = l_xrfc.xrfcseq + 1
      END IF

   END FOREACH
   
   CALL cl_err_collect_show()
   IF g_success = TRUE THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF

   CALL axrt460_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axrt460_ins_xrfc_12()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/06 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt460_ins_xrfc_12()
   #161128-00061#5---modify----begin------------- 
   #DEFINE l_xrfc        RECORD LIKE xrfc_t.*
   #DEFINE l_apcc        RECORD LIKE apcc_t.*
   DEFINE l_xrfc RECORD  #集團收款核銷單帳款明細檔
       xrfcent LIKE xrfc_t.xrfcent, #企業編碼
       xrfcdocno LIKE xrfc_t.xrfcdocno, #集團代收單號
       xrfcseq LIKE xrfc_t.xrfcseq, #項次
       xrfc001 LIKE xrfc_t.xrfc001, #帳款法人組織
       xrfc002 LIKE xrfc_t.xrfc002, #帳款所屬帳套
       xrfc003 LIKE xrfc_t.xrfc003, #應收單號
       xrfc004 LIKE xrfc_t.xrfc004, #應收單項次
       xrfc005 LIKE xrfc_t.xrfc005, #多帳期序號
       xrfc006 LIKE xrfc_t.xrfc006, #類型
       xrfc007 LIKE xrfc_t.xrfc007, #收款條件
       xrfc008 LIKE xrfc_t.xrfc008, #稅別
       xrfc009 LIKE xrfc_t.xrfc009, #內部銀行帳戶編碼
       xrfc010 LIKE xrfc_t.xrfc010, #內部銀行存提碼
       xrfc011 LIKE xrfc_t.xrfc011, #應收款日
       xrfc012 LIKE xrfc_t.xrfc012, #帳款類別
       xrfc013 LIKE xrfc_t.xrfc013, #借貸別
       xrfc100 LIKE xrfc_t.xrfc100, #幣別
       xrfc101 LIKE xrfc_t.xrfc101, #匯率
       xrfc103 LIKE xrfc_t.xrfc103, #原幣沖帳金額
       xrfc104 LIKE xrfc_t.xrfc104, #本幣沖帳金額
       xrfc201 LIKE xrfc_t.xrfc201, #對應代收方當日匯率
       xrfc204 LIKE xrfc_t.xrfc204  #對應代收方本金額
END RECORD
DEFINE l_apcc RECORD  #應付多帳期檔
       apccent LIKE apcc_t.apccent, #企業編號
       apccld LIKE apcc_t.apccld, #帳套
       apcccomp LIKE apcc_t.apcccomp, #法人
       apcclegl LIKE apcc_t.apcclegl, #核算組織
       apccsite LIKE apcc_t.apccsite, #帳務中心
       apccdocno LIKE apcc_t.apccdocno, #應付帳款單號碼
       apccseq LIKE apcc_t.apccseq, #項次
       apcc001 LIKE apcc_t.apcc001, #分期帳款序
       apcc002 LIKE apcc_t.apcc002, #應付款別性質
       apcc003 LIKE apcc_t.apcc003, #應付款日
       apcc004 LIKE apcc_t.apcc004, #容許票據到期日
       apcc005 LIKE apcc_t.apcc005, #帳款起算日
       apcc006 LIKE apcc_t.apcc006, #正負值
       apcc007 LIKE apcc_t.apcc007, #原幣已請款金額
       apcc008 LIKE apcc_t.apcc008, #發票編號
       apcc009 LIKE apcc_t.apcc009, #發票號碼
       apcc010 LIKE apcc_t.apcc010, #發票日期
       apcc011 LIKE apcc_t.apcc011, #交易單據日期
       apcc012 LIKE apcc_t.apcc012, #立帳日期
       apcc013 LIKE apcc_t.apcc013, #交易認定日期
       apcc014 LIKE apcc_t.apcc014, #出入庫扣帳日期
       apcc100 LIKE apcc_t.apcc100, #交易原幣別
       apcc101 LIKE apcc_t.apcc101, #原幣匯率
       apcc102 LIKE apcc_t.apcc102, #原幣重估後匯率
       apcc103 LIKE apcc_t.apcc103, #NO USE
       apcc104 LIKE apcc_t.apcc104, #NO USE
       apcc105 LIKE apcc_t.apcc105, #NO USE
       apcc106 LIKE apcc_t.apcc106, #NO USE
       apcc107 LIKE apcc_t.apcc107, #NO USE
       apcc108 LIKE apcc_t.apcc108, #原幣應付金額
       apcc109 LIKE apcc_t.apcc109, #原幣付款沖帳金額
       apcc113 LIKE apcc_t.apcc113, #重評價調整數
       apcc114 LIKE apcc_t.apcc114, #NO USE
       apcc115 LIKE apcc_t.apcc115, #NO USE
       apcc116 LIKE apcc_t.apcc116, #NO USE
       apcc117 LIKE apcc_t.apcc117, #NO USE
       apcc118 LIKE apcc_t.apcc118, #本幣應付金額
       apcc119 LIKE apcc_t.apcc119, #本幣付款沖帳金額
       apcc120 LIKE apcc_t.apcc120, #本位幣二幣別
       apcc121 LIKE apcc_t.apcc121, #本位幣二匯率
       apcc122 LIKE apcc_t.apcc122, #本位幣二重估後匯率
       apcc123 LIKE apcc_t.apcc123, #重評價調整數
       apcc124 LIKE apcc_t.apcc124, #NO USE
       apcc125 LIKE apcc_t.apcc125, #NO USE
       apcc126 LIKE apcc_t.apcc126, #NO USE
       apcc127 LIKE apcc_t.apcc127, #NO USE
       apcc128 LIKE apcc_t.apcc128, #本位幣二應付金額
       apcc129 LIKE apcc_t.apcc129, #本位幣二付款沖帳金額
       apcc130 LIKE apcc_t.apcc130, #本位幣三幣別
       apcc131 LIKE apcc_t.apcc131, #本位幣三匯率
       apcc132 LIKE apcc_t.apcc132, #本位幣三重估後匯率
       apcc133 LIKE apcc_t.apcc133, #重評價調整數
       apcc134 LIKE apcc_t.apcc134, #NO USE
       apcc135 LIKE apcc_t.apcc135, #NO USE
       apcc136 LIKE apcc_t.apcc136, #NO USE
       apcc137 LIKE apcc_t.apcc137, #NO USE
       apcc138 LIKE apcc_t.apcc138, #本位幣三應付金額
       apcc139 LIKE apcc_t.apcc139, #本位幣三付款沖帳金額
       apcc015 LIKE apcc_t.apcc015, #付款條件
       apcc016 LIKE apcc_t.apcc016, #帳款類型
       apcc017 LIKE apcc_t.apcc017  #採購單號
       END RECORD
   #161128-00061#5---modify----begin------------- 
   DEFINE l_gzcb003     LIKE gzcb_t.gzcb003
   DEFINE l_xrce109     LIKE xrce_t.xrce109
   DEFINE l_xrce119     LIKE xrce_t.xrce119
   DEFINE l_xrce109_1   LIKE xrce_t.xrce109
   DEFINE l_xrce119_1   LIKE xrce_t.xrce119
   DEFINE l_rate1        LIKE xrfb_t.xrfb201
   DEFINE l_rate2        LIKE xrfb_t.xrfb201
   DEFINE ls_js          STRING
   DEFINE lc_param       RECORD
            type         LIKE type_t.chr1,
            apca004      LIKE apca_t.apca004
                     END RECORD
   DEFINE l_sql          STRING
   
   CALL s_transaction_end('N',0)

   CALL s_transaction_begin()
   LET g_success = TRUE
   CALL cl_err_collect_init()
   
   DELETE FROM xrfc_t 
    WHERE xrfcent = g_enterprise
      AND xrfcdocno = g_xrfa_m.xrfadocno
      AND xrfcseq = g_xrfb2_d[l_ac].xrfcseq
      AND xrfc003 = g_xrfb2_d[l_ac].xrfc003

   LET l_sql ="SELECT apccdocno,apccseq,apcc001,apcc003,apcc100,apcc102,apcc108,apcc109,apcc118,apcc119,apcc113",
              " FROM apcc_t,apca_t,gzcb_t",
              " WHERE apccent = '",g_enterprise,"'",
              "   AND apccld = apcald",
              "   AND apccdocno = apcadocno",
              "   AND apccent = apcaent ",
              "   AND apcastus = 'Y'",
              "   AND apca001 = gzcb002",
              "   AND gzcb003 = '1'",
              "   AND gzcb001 = '8502'",
              "   AND apcc108 - apcc109 > 0",
              "   AND (",g_qryparam.return1,")"
   
   
   PREPARE axrt460_sel_apcc_prep FROM l_sql
   DECLARE axrt460_sel_apcc_curs CURSOR FOR axrt460_sel_apcc_prep
    
   SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
    WHERE gzcb002 = g_xrfb2_d[l_ac].xrfc006
      AND gzcb001 = '8306'
      
   INITIALIZE l_xrfc.* TO NULL
   LET l_xrfc.xrfcent   = g_enterprise
   LET l_xrfc.xrfcdocno = g_xrfa_m.xrfadocno
   #项次
   IF cl_null(g_xrfb2_d_t.xrfc003) THEN 
      SELECT MAX(xrfcseq) INTO l_xrfc.xrfcseq
        FROM xrfc_t
       WHERE xrfcent = g_enterprise 
         AND xrfcdocno = g_xrfa_m.xrfadocno
      IF cl_null(l_xrfc.xrfcseq) THEN
         LET l_xrfc.xrfcseq = 1
      ELSE
         LET l_xrfc.xrfcseq = l_xrfc.xrfcseq + 1
      END IF
   ELSE
      LET l_xrfc.xrfcseq = g_xrfb2_d_t.xrfcseq
   END IF
   
   LET l_xrfc.xrfc001   = g_xrfb2_d[l_ac].xrfc001 #法人
   LET l_xrfc.xrfc002   = g_xrfb2_d[l_ac].xrfc002 #账套
   LET l_xrfc.xrfc006   = g_xrfb2_d[l_ac].xrfc006 #类型
   #借贷别
   IF l_gzcb003 = 'D' THEN
      LET l_xrfc.xrfc013   =  'D'
   ELSE
      LET l_xrfc.xrfc013   =  'C'
   END IF
   #账款类别 #收款条件 #税别 #内部银行账户 #内部银行存提码
   SELECT apaf017,apaf018,apaf019,apaf012,apaf015 
     INTO l_xrfc.xrfc012,l_xrfc.xrfc007,l_xrfc.xrfc008,
          l_xrfc.xrfc009,l_xrfc.xrfc010
    FROM apaf_t
   WHERE apafent=g_enterprise AND apaf001='1' 
     AND apaf011=g_xrfb2_d[l_ac].xrfc001
     
   FOREACH axrt460_sel_apcc_curs INTO l_apcc.apccdocno,l_apcc.apccseq,l_apcc.apcc001,l_apcc.apcc003,
                                      l_apcc.apcc100,l_apcc.apcc102,l_apcc.apcc108,l_apcc.apcc109,
                                      l_apcc.apcc118,l_apcc.apcc119,l_apcc.apcc113
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH
      END IF
      
      LET l_xrfc.xrfc003  = l_apcc.apccdocno #单号
      LET l_xrfc.xrfc004  = l_apcc.apccseq   #项次
      LET l_xrfc.xrfc005  = l_apcc.apcc001   #分期序号
      LET l_xrfc.xrfc011  = l_apcc.apcc003   #应收款日
      LET l_xrfc.xrfc100  = l_apcc.apcc100   #币别
      LET l_xrfc.xrfc101  = l_apcc.apcc102   #汇率 
      
      #計算預沖金額
      LET l_xrce109 = 0   LET l_xrce119 = 0
      SELECT SUM(xrce109),SUM(xrce119)
        INTO l_xrce109,l_xrce119
        FROM xrce_t,xrda_t
       WHERE xrdaent   = xrceent
         AND xrdald    = xrceld
         AND xrdadocno = xrcedocno
         AND xrce003   = l_apcc.apccdocno
         AND xrce004   = l_apcc.apccseq
         AND xrce005   = l_apcc.apcc001
         AND xrdastus  = 'N'
      IF cl_null(l_xrce109) THEN LET l_xrce109 = 0 END IF
      IF cl_null(l_xrce119) THEN LET l_xrce119 = 0 END IF

      LET l_xrfc.xrfc103  = l_apcc.apcc108 - l_apcc.apcc109 - l_xrce109
      LET l_xrfc.xrfc104  = l_apcc.apcc118 - l_apcc.apcc119 + l_apcc.apcc113 - l_xrce119
      IF l_xrfc.xrfc103 <= 0 THEN CONTINUE FOREACH END IF
      #对应代收方币别的汇率
      LET lc_param.type    = '1'
      LET lc_param.apca004 = g_xrfa_m.xrfa002
      LET ls_js = util.JSON.stringify(lc_param)
      CALL s_fin_get_curr_rate(g_xrfa_m.xrfacomp,g_xrfa_m.xrfald,g_xrfa_m.xrfadocdt,l_xrfc.xrfc100,ls_js)
      RETURNING l_xrfc.xrfc201,l_rate1,l_rate2
      #換算被代收方本幣
      LET l_xrfc.xrfc204 = l_xrfc.xrfc103 * l_xrfc.xrfc201
      CALL s_curr_round_ld('1',g_xrfa_m.xrfald,g_glaa.glaa001,l_xrfc.xrfc204,2) 
            RETURNING g_sub_success,g_errno,l_xrfc.xrfc204
            
      INSERT INTO xrfc_t(xrfcent,xrfcdocno,xrfcseq,xrfc001,xrfc002,xrfc006,
                         xrfc013,xrfc003,xrfc004,xrfc005,xrfc011,xrfc100,
                         xrfc101,xrfc103,xrfc104,xrfc201,xrfc204,xrfc012,
                         xrfc007,xrfc008,xrfc009,xrfc010) 
      VALUES(g_enterprise,l_xrfc.xrfcdocno,l_xrfc.xrfcseq,l_xrfc.xrfc001,l_xrfc.xrfc002,l_xrfc.xrfc006, 
             l_xrfc.xrfc013,l_xrfc.xrfc003,l_xrfc.xrfc004,l_xrfc.xrfc005,l_xrfc.xrfc011,l_xrfc.xrfc100, 
             l_xrfc.xrfc101,l_xrfc.xrfc103,l_xrfc.xrfc104,l_xrfc.xrfc201,l_xrfc.xrfc204,l_xrfc.xrfc012, 
             l_xrfc.xrfc007,l_xrfc.xrfc008,l_xrfc.xrfc009,l_xrfc.xrfc010)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "ins xrfc_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_success = FALSE
         CONTINUE FOREACH
      END IF
      
      SELECT MAX(xrfcseq) INTO l_xrfc.xrfcseq
        FROM xrfc_t
       WHERE xrfcent = g_enterprise 
         AND xrfcdocno = g_xrfa_m.xrfadocno
      IF cl_null(l_xrfc.xrfcseq) THEN
         LET l_xrfc.xrfcseq = 1
      ELSE
         LET l_xrfc.xrfcseq = l_xrfc.xrfcseq + 1
      END IF

   END FOREACH
   
   CALL cl_err_collect_show()
   IF g_success = TRUE THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF

   CALL axrt460_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 編輯完單據立即審核
# Memo...........:
# Usage..........: CALL axrt460_immediately_conf()
#                  RETURNING r_success
# Date & Author..: 2015/12/02 By 06862
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt460_immediately_conf()
   DEFINE l_xrfacomp        LIKE xrfa_t.xrfacomp
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_efin5001        LIKE type_t.chr1
   DEFINE l_ooba002         LIKE ooba_t.ooba002
   DEFINE l_flag            LIKE type_t.chr1

   LET r_success = TRUE 
   #無資料直接返回不做處理 
   IF cl_null(g_xrfa_m.xrfald)  THEN 
      LET r_success=FALSE 
      RETURN r_success
   END IF
   #無資料直接返回不做處理   
   IF cl_null(g_xrfa_m.xrfacomp)  THEN 
      LET r_success=FALSE 
      RETURN r_success
   END IF
   #無資料直接返回不做處理   
   IF cl_null(g_xrfa_m.xrfadocno) THEN
      LET r_success=FALSE   
      RETURN r_success=FALSE 
   END IF  
   
   CALL cl_err_collect_init()
   CALL s_transaction_begin()
   
   LET l_doc_success = TRUE
   
   CALL s_aooi200_fin_get_slip(g_xrfa_m.xrfadocno) RETURNING l_doc_success,l_ooba002
   CALL s_fin_chk_E5001(g_xrfa_m.xrfald,g_xrfa_m.xrfacomp,l_ooba002) RETURNING l_efin5001
   IF l_efin5001 = 'N' THEN
      IF g_xrfa_m.xrfacrtid = g_user THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axr-00346'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         LET r_success=FALSE 
         #RETURN r_success
      END IF
   END IF 
   CALL axrt460_confirm_chk() RETURNING l_doc_success
   IF l_doc_success  THEN
      CALL axrt460_confirm_upd() RETURNING l_doc_success
   END IF
   
   UPDATE xrfa_t SET xrfastus = 'Y',
                     xrfamodid= g_user,
                     xrfamoddt= g_xrfa_m.xrfamoddt,
                     xrfacnfid= g_user,
                     xrfacnfdt= g_xrfa_m.xrfacnfdt
    WHERE xrfaent = g_enterprise AND xrfald = g_xrfa_m.xrfald
      AND xrfadocno = g_xrfa_m.xrfadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      LET l_doc_success = FALSE
   END IF
  
   IF l_doc_success THEN
      CALL s_transaction_end('Y',1)
      LET r_success = TRUE
   ELSE
      LET r_success = FALSE
      CALL s_transaction_end('N',1)      
   END IF
   
   CALL cl_err_collect_show()
   RETURN r_success 
END FUNCTION

 
{</section>}
 
