#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0032(2017-01-13 18:10:41), PR版次:0032(2017-02-07 13:59:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000100
#+ Filename...: axrp400
#+ Description: 收款沖帳批次產生作業
#+ Creator....: 02291(2015-07-10 13:40:13)
#+ Modifier...: 02114 -SD/PR- 07900
 
{</section>}
 
{<section id="axrp400.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#151013-00019#11 2015/11/11 By Reanna    帳款明細增加備註apca053
#151125-00006#1  2015/12/05 By 06862     生成單據后立即審核，立即拋轉傳票
#160329-00029#1  2016/03/30 By fengmy    anmt540的款别设置为银行电汇的资料未查出
#160318-00025#35 2016/04/15 By pengxin   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160426-00016#1  2016/04/26 By Dido      xrce038 要記錄 apca004
#160530-00017#1  2016/06/12 By 07900     1: 立帳金額減 (已沖+預沖 ) 若為0 ,則不產生到 axrt400 
#                                        2:调整未冲销金额，本币金额
#160530-00005#5  2016/06/20 By 01727     1.收款單若有勾選暫收,則產生到 axrt400 的科目應取 anmi152 收款待沖銷科目
#                                        2.若條件沒有勾"同對象的應付帳款一併沖銷" , 則帳款明細的來源模組請預設為 AXR , 現在會是空白, 帳款單號開窗時會開  AP 單
#                                        來源模組,簡繁體請確認, 現在繁體環境會出現" 1:AXR应收" 
#                                        3.若無差異時,請不要跳到 axrp400_s01 的視窗
#160620-00010#1  2016/06/20 by 01727     增加收款明細/帳款明細二次篩選功能
#160607-00015#2  2016/06/23 By 01727     抓取沖帳資料時,剔除存在於aist340中的單據
#160727-00019#6  2016/07/28 By 08734     临时表长度超过15码的减少到15码以下  s_voucher_ar_tmp ——> s_voucher_tmp09, s_voucher_ar_group ——> s_voucher_tmp05 
#160325-00025#1  2016/08/01 By Ann_Huang 修正若按選取資料/取消選擇資料後,帳款明細的合計金額會重複累加或累扣 
#160802-00006#1  2016/08/10 By 01727     axrp400重复定义了新建分录底稿临时表的逻辑,应该取消
#160811-00009#4  2016/08/19 By 01531     账务中心/法人/账套权限控管
#160905-00002#7  2016/09/05 By 08171     SQL補上ent
#160901-00020#1  2016/09/08 By 00768     anmt540的账款性质为'30'的未查出
#160912-00038#1  2016/09/13 By 00768     xrde032缺少赋值
#160912-00011#2  2016/09/20 By 01727     收款單開窗時, 要抓出預沖金額顯示, 若已沖+預沖=收款金, 則不可選
#160926-00026#1  2016/09/26 By 01727     產生到axrt400 款別30 沒有沖銷科目
#160929-00026#1  2016/09/26 By 01727     產生到axrt400 款別30 沒有沖銷科目
#161003-00015#1  2016/10/10 By 02599     点‘筛选已存在资料’和‘重新整理’按钮后，刷新‘收付款金额’、‘核销账款单金额’和‘差异金额’这个三个栏位的值
#161013-00003#2  2016/10/13 BY 01727     1.帳款明細增加幣別(xrcc100)顯示
#                                        2.收款單身為 2000 帳款單身 2000 此時仍會跳出差異視窗,請檢查
#                                        3.收款單身為 2000 帳款單身 5000 時(收款>帳款)核銷帳款單金額應該等於收款金額.
#                                        4.無法產生 axrt400 帳款單身資料
#161013-00013#1  2016/10/17 By 01727     axrp400批处理生成收款核销整单axrt400，第一单身有带出银行对应会计科目，但收款账号变为空
#161021-00050#3  2016/10/27 By 08729     處理組織開窗
#161104-00015#1  2016/11/04 By 01727     axrp400账款单身应该按照账款单号+多账期项次+期别的方式显示最明细的资料
#161104-00045#1  2016/11/07 By 01727     因匯率不同,沖帳原幣錯誤
#161111-00049#1  2016/11/12 By 01727     控制组权限修改
#161128-00009#1  2016/11/28 By 01727     收款资料限制显示anmt540,anmt541的资料
#161125-00053#1  2016/11/30 By 01727     增加【款別xrde007】顯示,有來源單號者,依來源anmt540帶入,且不可修改。無來源單據者，可維護款別
#161130-00023#1  2016/11/30 By 01727     账款单身根据收款单身存在的客户进行过滤
#161129-00018#1  2016/12/01 By 02599     xrce001与xrde001 赋值'axrt400'
#161114-00028#1  2016/12/06 By 01727     1.第二單身的內容，應該跟著第一單身的【收款對象】顯示帳款單的內容
#                                        2.第二單身的帳款單, 若為 AAP來源者, 在帳款合計金額上應該是負數計算。
#                                        3.如果同時, 勾選AR/AP 互相沖銷,但在產生到axrt400時,卻少了AP的單號的產生
#                                        4.axrt400 第二單身(帳款單身) 在 axrt330 有四筆多帳期, 在此僅呈現 3 筆這部分需要再確認
#161219-00014#2  2016/12/27  By 07900    标准程式定义采用宣告模式,弃用.*写法
#161026-00010#2  2017/01/04  By 01531    改狀態條件抓取已复核狀態的资料
#170112-00044#4  2017/01/13  By 02114    增加交易對象識別碼的顯示
#170125-00001#1  2017/02/07  By 07900    差异处理采 "1:不处理" 时 不强迫做汇差
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10             #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num10             #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
     sel LIKE type_t.chr1, 
   nmbbdocno LIKE nmbb_t.nmbbdocno,
   nmbbseq LIKE nmbb_t.nmbbseq, 
   nmbb026 LIKE nmbb_t.nmbb026,
   nmbb026_desc LIKE type_t.chr80,
   #170112-00044#4--add--str--lujh
   nmbb027 LIKE nmbb_t.nmbb027,
   nmbb027_desc LIKE type_t.chr80,
   #170112-00044#4--add--end--lujh
   nmbadocdt LIKE nmba_t.nmbadocdt,
   nmbb029 LIKE nmbb_t.nmbb029, 
   nmbb004 LIKE nmbb_t.nmbb004, 
   nmbb006 LIKE nmbb_t.nmbb006, 
   nmbb008 LIKE nmbb_t.nmbb008, 
   nmba008 LIKE nmba_t.nmba008, 
   nmba008_desc LIKE type_t.chr80, 
   nmbb031 LIKE nmbb_t.nmbb031, 
   nmbb030 LIKE nmbb_t.nmbb030, 
   nmbb040 LIKE nmbb_t.nmbb040, 
   nmbb003 LIKE nmbb_t.nmbb003, 
   nmbb003_desc LIKE type_t.chr80, 
   nmbb005 LIKE nmbb_t.nmbb005, 
   nmbb009 LIKE nmbb_t.nmbb009
       END RECORD
       
TYPE type_g_detail2 RECORD
   sel1          LIKE type_t.chr1, 
   flag          LIKE type_t.chr1,
   xrcadocno     LIKE xrca_t.xrcadocno,
   xrccseq       LIKE xrcc_t.xrccseq,
   xrcc001       LIKE xrcc_t.xrcc001,
   xrca001       LIKE type_t.chr80, 
   xrcasite      LIKE xrca_t.xrcasite,
   xrcasite_desc LIKE type_t.chr80,
   xrca003       LIKE xrca_t.xrca003,
   xrca003_desc  LIKE type_t.chr80,
   xrca005       LIKE xrca_t.xrca005,
   xrca005_desc  LIKE type_t.chr80,
   #170112-00044#4--add--str--lujh
   xrca057 LIKE xrca_t.xrca057,
   xrca057_desc LIKE type_t.chr80,
   #170112-00044#4--add--end--lujh
   xrcald        LIKE xrca_t.xrcald,
   xrcald_desc   LIKE type_t.chr80,
   xrcadocdt     LIKE xrca_t.xrcadocdt, 
   xrcc100       LIKE xrcc_t.xrcc100,
   xrcc108       LIKE xrcc_t.xrcc108,
   xrcc109       LIKE xrcc_t.xrcc109,
   xrcc109_1     LIKE xrcc_t.xrcc109,    #160530-00017#1  Add
   xrcc108_1     LIKE xrcc_t.xrcc108,    #151013-00019#11 add ,
   xrca053       LIKE xrca_t.xrca053     #151013-00019#11
       END RECORD
DEFINE g_wc_filter2         STRING   #160620-00010#1 Add
DEFINE g_wc_filter2_t       STRING   #160620-00010#1 Add
DEFINE g_nmbb026            STRING   #161130-00023#1 Add
DEFINE g_nmbb026_t          STRING   #161130-00023#1 Add
DEFINE g_wc_nmbb026         STRING   #161114-00028#1 Add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
 TYPE type_master RECORD
       xrdasite LIKE type_t.chr10, 
   xrdasite_desc LIKE type_t.chr80, 
   xrdald LIKE type_t.chr5, 
   xrdald_desc LIKE type_t.chr80, 
   xrdacomp_desc LIKE type_t.chr500, 
   xrdadocno LIKE type_t.chr20, 
   xrdadocno_desc LIKE type_t.chr80, 
   xrda003 LIKE type_t.chr500, 
   xrda003_desc LIKE type_t.chr80, 
   xrdadocdt LIKE type_t.dat, 
   xrca063 LIKE type_t.chr500, 
   chk LIKE type_t.chr500, 
   diff LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
DEFINE g_detail2_d        DYNAMIC ARRAY OF type_g_detail2
DEFINE g_detail2_t        type_g_detail2
#DEFINE g_glaa             RECORD LIKE glaa_t.* #161219-00014#2--mark--
#161219-00014#2--add--s--
DEFINE g_glaa RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企业编号
       glaaownid LIKE glaa_t.glaaownid, #资料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #资料所有部门
       glaacrtid LIKE glaa_t.glaacrtid, #资料录入者
       glaacrtdp LIKE glaa_t.glaacrtdp, #资料录入部门
       glaacrtdt LIKE glaa_t.glaacrtdt, #资料创建日
       glaamodid LIKE glaa_t.glaamodid, #资料更改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近更改日
       glaastus LIKE glaa_t.glaastus, #状态码
       glaald LIKE glaa_t.glaald, #账套编号
       glaacomp LIKE glaa_t.glaacomp, #归属法人
       glaa001 LIKE glaa_t.glaa001, #使用币种
       glaa002 LIKE glaa_t.glaa002, #汇率参照表号
       glaa003 LIKE glaa_t.glaa003, #会计周期参照表号
       glaa004 LIKE glaa_t.glaa004, #会计科目参照表号
       glaa005 LIKE glaa_t.glaa005, #现金变动参照表号
       glaa006 LIKE glaa_t.glaa006, #月结方式
       glaa007 LIKE glaa_t.glaa007, #年结方式
       glaa008 LIKE glaa_t.glaa008, #平行记账否
       glaa009 LIKE glaa_t.glaa009, #凭证登录方式
       glaa010 LIKE glaa_t.glaa010, #现行年度
       glaa011 LIKE glaa_t.glaa011, #现行期别
       glaa012 LIKE glaa_t.glaa012, #最后过账日期
       glaa013 LIKE glaa_t.glaa013, #关账日期
       glaa014 LIKE glaa_t.glaa014, #主账套
       glaa015 LIKE glaa_t.glaa015, #启用本位币二
       glaa016 LIKE glaa_t.glaa016, #本位币二
       glaa017 LIKE glaa_t.glaa017, #本位币二换算基准
       glaa018 LIKE glaa_t.glaa018, #本位币二汇率采用
       glaa019 LIKE glaa_t.glaa019, #启用本位币三
       glaa020 LIKE glaa_t.glaa020, #本位币三
       glaa021 LIKE glaa_t.glaa021, #本位币三换算基准
       glaa022 LIKE glaa_t.glaa022, #本位币三汇率采用
       glaa023 LIKE glaa_t.glaa023, #次账套账务生成时机
       glaa024 LIKE glaa_t.glaa024, #单据别参照表号
       glaa025 LIKE glaa_t.glaa025, #本位币一汇率采用
       glaa026 LIKE glaa_t.glaa026, #币种参照表号
       glaa100 LIKE glaa_t.glaa100, #凭证录入时自动按缺号生成
       glaa101 LIKE glaa_t.glaa101, #凭证总号录入时机
       glaa102 LIKE glaa_t.glaa102, #凭证成立时,借贷不平衡的处理方式
       glaa103 LIKE glaa_t.glaa103, #未打印的凭证可否进行过账
       glaa111 LIKE glaa_t.glaa111, #应计调整单别
       glaa112 LIKE glaa_t.glaa112, #期末结转单别
       glaa113 LIKE glaa_t.glaa113, #年底结转单别
       glaa120 LIKE glaa_t.glaa120, #成本计算类型
       glaa121 LIKE glaa_t.glaa121, #子模块启用分录底稿
       glaa122 LIKE glaa_t.glaa122, #总账可维护资金异动明细
       glaa027 LIKE glaa_t.glaa027, #单据据点编号
       glaa130 LIKE glaa_t.glaa130, #合并账套否
       glaa131 LIKE glaa_t.glaa131, #分层合并
       glaa132 LIKE glaa_t.glaa132, #平均汇率计算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司导入余额类型
       glaa134 LIKE glaa_t.glaa134, #合并科目转换依据异动码设置值
       glaa135 LIKE glaa_t.glaa135, #现流表间接法群组参照表号
       glaa136 LIKE glaa_t.glaa136, #应收账款核销限定己立账凭证
       glaa137 LIKE glaa_t.glaa137, #应付账款核销限定已立账凭证
       glaa138 LIKE glaa_t.glaa138, #合并报表编制期别
       glaa139 LIKE glaa_t.glaa139, #递延收入(负债)管理生成否
       glaa140 LIKE glaa_t.glaa140, #无原出货单的递延负债减项者,是否仍立递延收入管理?
       glaa123 LIKE glaa_t.glaa123, #应收帐款核销可维护资金异动明细
       glaa124 LIKE glaa_t.glaa124, #应付帐款核销可维护资金异动明细
       glaa028 LIKE glaa_t.glaa028  #汇率来源
       END RECORD
#161219-00014#2--add--e--
DEFINE g_ls               LIKE type_t.chr1
DEFINE g_wc1              STRING
DEFINE g_wc3              STRING
DEFINE g_wc_ar            STRING
DEFINE g_wc_nm            STRING
DEFINE g_wc_ap            STRING
DEFINE g_xrdadocno        LIKE xrda_t.xrdadocno
DEFINE g_amt1             LIKE xrce_t.xrce109
 TYPE type_g_nmbb_d      RECORD
         nmbb026          LIKE nmbb_t.nmbb026
                         END RECORD  
DEFINE g_nmbb026_d        DYNAMIC ARRAY OF type_g_nmbb_d
DEFINE g_cnt1             LIKE type_t.num5
DEFINE g_cnt2             LIKE type_t.num5
DEFINE g_cnt3             LIKE type_t.num5
DEFINE l_ac1              LIKE type_t.num10  
DEFINE l_ac2              LIKE type_t.num10 
DEFINE g_rec_b            LIKE type_t.num5 
DEFINE g_rec_b1           LIKE type_t.num5
DEFINE l_cnt              LIKE type_t.num5
DEFINE g_detail_idx       LIKE type_t.num5

TYPE type_g_detail_s     RECORD
                          diff1 LIKE type_t.chr1,
                          xrdadocno LIKE xrda_t.xrdadocno,
                          amt1 LIKE xrcc_t.xrcc108,
                          amt2 LIKE xrcc_t.xrcc108,
                          amt3 LIKE xrcc_t.xrcc108
                         END RECORD
DEFINE g_detail_s         DYNAMIC ARRAY OF type_g_detail_s

DEFINE g_amt              LIKE type_t.num10     #151125-00006#1---add by aiqq
DEFINE g_amt_xrde119      LIKE xrde_t.xrde119   #161013-00003#2 Add
DEFINE g_amt_xrce119      LIKE xrce_t.xrce119   #161013-00003#2 Add
DEFINE g_sql_ctrl         STRING                #161111-00049#1 Add
#end add-point
 
{</section>}
 
{<section id="axrp400.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   DEFINE l_success         LIKE type_t.num5   #151125-00006#1---add
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axr","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   #151125-00006#1---add---s
   CALL s_fin_create_account_center_tmp()
   CALL s_voucher_cre_ar_tmp_table() RETURNING l_success    
   CALL s_pre_voucher_cre_tmp_table() RETURNING l_success 
   CALL s_fin_continue_no_tmp() 
   #151125-00006#1---add---e
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrp400 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrp400_init()   
 
      #進入選單 Menu (="N")
      CALL axrp400_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axrp400
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axrp400.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrp400_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
 
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL axrp400_create_tmp_table()
  #CALL cl_set_combo_scc('b_xrca001','8302')
   CALL cl_set_combo_scc('b_nmbb029','8310')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrp400.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrp400_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE li_idx1           LIKE type_t.num10
   DEFINE l_n               LIKE type_t.num10
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_xrdasite        LIKE xrda_t.xrdasite
   DEFINE l_xrdald          LIKE xrda_t.xrdald
   DEFINE l_xrda003         LIKE xrda_t.xrda003
   DEFINE l_xrdadocdt       LIKE xrda_t.xrdadocdt
   DEFINE l_glaa024         LIKE glaa_t.glaa024
   DEFINE l_success_1    LIKE type_t.num5
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
                   oofg019     LIKE oofg_t.oofg019,   #field
                   oofg020     LIKE oofg_t.oofg020    #value
                           END RECORD
   DEFINE l_origin_str      STRING
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL axrp400_ui_dialog_1()
   RETURN
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axrp400_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
          

         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
       
#         INPUT ARRAY g_detail_d FROM s_detail1.* 
#              ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
#                        INSERT ROW = FALSE,
#                        DELETE ROW = FALSE,
#                        APPEND ROW = FALSE)
#            BEFORE INPUT
#               IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
#                 CALL FGL_SET_ARR_CURR(g_detail_d.getLength()+1) 
#                 LET g_insert = 'N' 
#               END IF 
#             
#            BEFORE ROW
#               LET l_ac = ARR_CURR()
#               LET g_master_idx = l_ac
#               DISPLAY l_ac TO FORMONLY.h_index
#               CALL axrp400_fetch()              
#               
#            ON CHANGE sel
#               UPDATE axrp400_tmp 
#                  SET sel = g_detail_d[l_ac].sel 
#                WHERE nmbbdocno = g_detail_d[l_ac].nmbbdocno  
#                  AND nmbbseq = g_detail_d[l_ac].nmbbseq
#                  
#         END INPUT
         

#          INPUT ARRAY g_detail2_d FROM s_detail2.* 
#              ATTRIBUTE(COUNT = g_rec_b1,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
#                        INSERT ROW = FALSE,
#                        DELETE ROW = FALSE,
#                        APPEND ROW = FALSE)
#            BEFORE INPUT
#                LET g_rec_b = g_detail2_d.getLength()
#                CALL cl_set_comp_entry("xrcadocno,xrccseq,xrcc001,xrcasite,xrca003,xrca005,xrcald",FALSE)
#             
#            BEFORE ROW
#               LET l_ac1 = ARR_CURR()
#               LET g_master_idx = l_ac1
#               DISPLAY l_ac TO FORMONLY.h_index
#               CALL axrp400_fetch()              
#               
#            ON CHANGE sel1
#            
#               UPDATE axrp400_tmp 
#                  SET sel1 = g_detail2_d[l_ac1].sel1
#                WHERE xrcadocno = g_detail2_d[l_ac1].xrcadocno  
#                  AND xrccseq = g_detail2_d[l_ac1].xrccseq    
#                  AND xrcc001 = g_detail2_d[l_ac1].xrcc001
#            
#         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #應用 a58 樣板自動產生(Version:2)
         
         DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_cnt = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail2_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_cnt
         
         END DISPLAY
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_cnt = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail2_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_cnt

            
               
         END DISPLAY

         #end add-point
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL axrp400_construct()
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               UPDATE axrp400_tmp SET sel = g_detail_d[li_idx].sel 
                WHERE nmbbdocno = g_detail_d[li_idx].nmbbdocno
                  AND nmbbseq = g_detail_d[li_idx].nmbbseq
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            CALL DIALOG.setSelectionRange("s_detail2", 1, -1, 1)
            FOR li_idx1 = 1 TO g_detail2_d.getLength()
               LET g_detail2_d[li_idx1].sel1 = "Y"
#               UPDATE axrp400_tmp SET sel1 = g_detail2_d[li_idx1].sel1    #161003-00015#1 mark
               UPDATE axrp400_cum_tmp SET sel1 = g_detail2_d[li_idx1].sel1 #161003-00015#1 add
                WHERE xrcadocno = g_detail2_d[li_idx1].xrcadocno
                  AND xrccseq = g_detail2_d[li_idx1].xrccseq
                  AND xrcc001 = g_detail2_d[li_idx1].xrcc001
            END FOR
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               UPDATE axrp400_tmp SET sel = g_detail_d[li_idx].sel 
                WHERE nmbbdocno = g_detail_d[li_idx].nmbbdocno
                  AND nmbbseq = g_detail_d[li_idx].nmbbseq
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            CALL DIALOG.setSelectionRange("s_detail2", 1, -1, 0)
            FOR li_idx1 = 1 TO g_detail2_d.getLength()
               LET g_detail2_d[li_idx1].sel1 = "N"
#               UPDATE axrp400_tmp SET sel1 = g_detail2_d[li_idx1].sel1    #161003-00015#1 mark
               UPDATE axrp400_cum_tmp SET sel1 = g_detail2_d[li_idx1].sel1 #161003-00015#1 add
                WHERE xrcadocno = g_detail2_d[li_idx1].xrcadocno
                  AND xrccseq = g_detail2_d[li_idx1].xrccseq
                  AND xrcc001 = g_detail2_d[li_idx1].xrcc001
            END FOR
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
                  UPDATE axrp400_tmp SET sel = g_detail_d[li_idx].sel 
                   WHERE nmbbdocno = g_detail_d[li_idx].nmbbdocno
                     AND nmbbseq = g_detail_d[li_idx].nmbbseq
               END IF
            END FOR
            FOR li_idx1 = 1 TO g_detail2_d.getLength()
               IF DIALOG.isRowSelected("s_detail2", li_idx1) THEN
                  LET g_detail2_d[li_idx1].sel1 = "Y"
#                  UPDATE axrp400_tmp SET sel1 = g_detail2_d[li_idx1].sel1    #161003-00015#1 mark
                  UPDATE axrp400_cum_tmp SET sel1 = g_detail2_d[li_idx1].sel1 #161003-00015#1 add
                   WHERE xrcadocno = g_detail2_d[li_idx1].xrcadocno
                     AND xrccseq = g_detail2_d[li_idx1].xrccseq
                     AND xrcc001 = g_detail2_d[li_idx1].xrcc001
               END IF
            END FOR
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
                  UPDATE axrp400_tmp SET sel = g_detail_d[li_idx].sel 
                   WHERE nmbbdocno = g_detail_d[li_idx].nmbbdocno
                     AND nmbbseq = g_detail_d[li_idx].nmbbseq
               END IF
            END FOR
            FOR li_idx1 = 1 TO g_detail2_d.getLength()
               IF DIALOG.isRowSelected("s_detail2", li_idx1) THEN
                  LET g_detail2_d[li_idx1].sel1 = "N"
#                  UPDATE axrp400_tmp SET sel1 = g_detail2_d[li_idx1].sel1    #161003-00015#1 mark
                  UPDATE axrp400_cum_tmp SET sel1 = g_detail2_d[li_idx1].sel1 #161003-00015#1 add
                   WHERE xrcadocno = g_detail2_d[li_idx1].xrcadocno
                     AND xrccseq = g_detail2_d[li_idx1].xrccseq
                     AND xrcc001 = g_detail2_d[li_idx1].xrcc001
               END IF
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrp400_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            #add-point:ui_dialog段accept之前 name="menu.filter"
            
            #end add-point
            CALL axrp400_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL axrp400_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            SELECT COUNT(*) INTO l_n
              FROM axrp400_tmp
             WHERE (sel = 'Y' OR sel1 = 'Y')
            IF l_n = 0 THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'axr-00159' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               EXIT DIALOG
            END IF
            
            CALL axrp400_get_ar()
            
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:22) ---start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:22) --- end ---
 
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #(ver:22) ---start---
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         #(ver:22) --- end ---
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrp400.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrp400_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   RETURN
   #end add-point
        
   LET g_error_show = 1
   CALL axrp400_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrp400.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrp400_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_sql       STRING
   DEFINE l_sql1      STRING
   DEFINE ls_ac         LIKE type_t.num5
   DEFINE l_cmd         LIKE type_t.num5
   DEFINE l_flag        LIKE type_t.chr1
   DEFINE l_str         STRING
   DEFINE l_sub_sql     STRING
   DEFINE ls_wc1        STRING
   DEFINE ls_wc2        STRING
   DEFINE ls_wc3        STRING
   DEFINE l_success     LIKE type_t.num5  
   DEFINE l_n           LIKE xrde_t.xrde109
   DEFINE l_n1          LIKE xrde_t.xrde109
   DEFINE l_pmaa004     LIKE pmaa_t.pmaa004   #170112-00044#4 add lujh
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_wc1 = cl_replace_str(g_wc1,'b_nmbb','nmbb')
   LET g_wc1 = cl_replace_str(g_wc1,'b_nmba','nmba')
  #160620-00010#1 Add  ---(S)---
   LET g_wc_filter = cl_replace_str(g_wc_filter,'b_nmbb','nmbb')
   LET g_wc_filter = cl_replace_str(g_wc_filter,'b_nmbb','nmbb')
   IF cl_null(g_wc_filter) THEN LET g_wc_filter = " 1=1" END IF
  #160620-00010#1 Add  ---(E)---
   CASE
      WHEN g_ls = '1'
         LET ls_wc = "nmbb006 > nmbb008"
      WHEN g_ls = '2'
         LET ls_wc = "nmbb020 > nmbb021"
      WHEN g_ls = '3'
         LET ls_wc = "nmbb023 > nmbb024"
   END CASE
   
   LET l_sql = " SELECT 'N',nmbbdocno,nmbbseq,nmbb026,'',nmbb027,'',nmbadocdt,nmbb029,nmbb004,nmbb006,nmbb006-nmbb008, ",   #170112-00044#4 add nmbb027,''
               "         nmba008,'',nmbb031,nmbb030,nmbb040,nmbb003,'',nmbb005,nmbb009 "

  #160607-00015#2  Add  ---(S)---
   LET ls_wc1 = " NOT EXISTS (SELECT 1 FROM isba_t,isbb_t WHERE isbaent = isbbent AND isbadocno = isbbdocno ",
                " AND isbacomp = isbbcomp AND isbbent = nmbbent AND isbastus <> 'X' ",
                " AND isbb002 = nmbbdocno AND isbb003 = nmbbseq)"
  #160607-00015#2  Add  ---(E)---

   LET g_sql = l_sql CLIPPED ,
               "  FROM nmba_t,nmbb_t ",
	            " WHERE nmbbent = nmbaent ",
               "   AND nmbbcomp = nmbacomp ",
               "   AND nmbbdocno = nmbadocno",
               "   AND nmbaent = ?",
	            "   AND nmbbcomp = '",g_glaa.glaacomp,"'",
	            #"   AND nmbastus = 'Y' ", #161026-00010#2 mark
	            "   AND nmbastus = 'V' ",  #161026-00010#2 add
	            "   AND nmbb001= '1' ",
               "   AND nmbadocdt <= '",g_master.xrdadocdt,"'",
               "   AND nmba003 ='anmt510'",
               "   AND nmbb029 IN ('10','30')",
               "   AND ",ls_wc CLIPPED,
               "   AND ",g_wc1 CLIPPED,
               "   AND ",g_wc_filter CLIPPED,   #160620-00010#1  Add
               "   AND ",ls_wc1 CLIPPED,        #160607-00015#2  Add
               " UNION ",
               l_sql CLIPPED,
               "  FROM nmba_t,nmbb_t,ooia_t ",
               " WHERE nmbbent = nmbaent ",
               "   AND nmbbcomp = nmbacomp ",
               "   AND nmbbdocno = nmbadocno",
               "   AND nmbbent = nmbaent AND nmbb028 = ooia001 ",
               #"   AND (ooia002 = '10' OR ooia002 = '20')",
               "   AND (ooia002 = '10' OR ooia002 = '20' OR ooia002 = '30')",   #160901-00020#1 mod
               "   AND nmbaent = ",g_enterprise,
	            "   AND nmbbcomp = '",g_glaa.glaacomp,"'",
	           #"   AND (nmbastus = 'Y' OR nmbastus = 'V')",      #161128-00009#1 Mark
	            "   AND nmbastus = 'V' ",                         #161128-00009#1 Add
	            "   AND nmbb001= '1' ",
               "   AND nmbadocdt <= '",g_master.xrdadocdt,"'",
              #"   AND nmba003 = 'anmt540'",                     #161128-00009#1 Mark
               "   AND nmba003 NOT IN ('anmt310','anmt440' )",   #161128-00009#1 Add
               "   AND nmbb029 IN ('10','20','30')",   #160329-00029#1 add '20'
               "   AND ",ls_wc CLIPPED,
               "   AND ",g_wc1 CLIPPED,
               "   AND ",ls_wc1 CLIPPED,        #160607-00015#2  Add
               "   AND ",g_wc_filter CLIPPED   #160620-00010#1  Add
   #end add-point
 
   PREPARE axrp400_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrp400_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   LET g_wc_filter = " 1=1"  #160620-00010#1  Add
   DELETE FROM axrp400_tmp   #160620-00010#1  Add
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].*
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="b_fill.foreach_iside"
      CALL s_axrt300_xrca_ref('xrca003',g_detail_d[l_ac].nmba008,'','') RETURNING l_success,g_detail_d[l_ac].nmba008_desc
      CALL s_axrt300_xrca_ref('xrca005',g_detail_d[l_ac].nmbb026,'','') RETURNING l_success,g_detail_d[l_ac].nmbb026_desc
      
      SELECT nmaal003 INTO g_detail_d[l_ac].nmbb003_desc FROM nmaal_t WHERE nmaalent=g_enterprise AND nmaal001=g_detail_d[l_ac].nmbb003 AND nmaal002=g_dlang
      #160530-00017#1  2016/06/12 By 07900 -add -str      
      LET l_n1 =0
      LET l_n =0
      SELECT SUM(xrde109) INTO l_n
        FROM xrde_t,xrda_t
       WHERE xrdeent = xrdaent AND xrdald = xrdeld AND xrdadocno = xrdedocno 
         AND xrde003 = g_detail_d[l_ac].nmbbdocno AND xrde004 = g_detail_d[l_ac].nmbbseq AND xrdastus='N' AND xrdeent = g_enterprise
       IF cl_null(l_n) THEN
          LET l_n =0  
       END IF
       
      SELECT SUM(xrde109) INTO l_n1
        FROM xrde_t,xrca_t
       WHERE xrdeent = xrcaent AND xrdeld = xrcald AND xrdedocno = xrcadocno 
         AND xrde003 = g_detail_d[l_ac].nmbbdocno AND xrde004 = g_detail_d[l_ac].nmbbseq AND xrcastus='N' AND xrdeent = g_enterprise  
       IF cl_null(l_n1) THEN
          LET l_n1 =0  
       END IF 
       
       #170112-00044#4--add--str--lujh
       LET l_pmaa004 = ''
       SELECT pmaa004 INTO l_pmaa004 
         FROM pmaa_t
        WHERE pmaaent = g_enterprise
          AND pmaa001 = g_detail_d[l_ac].nmbb026
          
       IF l_pmaa004 = '4' THEN   
          INITIALIZE g_ref_fields TO NULL
          LET g_ref_fields[1] = g_detail_d[l_ac].nmbb027 
          CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
          LET g_detail_d[l_ac].nmbb027_desc = '', g_rtn_fields[1] , ''
          DISPLAY BY NAME g_detail_d[l_ac].nmbb027_desc
       END IF   
           
       IF l_pmaa004 = '2' THEN 
          SELECT pmak003 INTO g_detail_d[l_ac].nmbb027_desc
            FROM pmak_t
           WHERE pmakent = g_enterprise
             AND pmak001 = g_detail_d[l_ac].nmbb027
       END IF
       #170112-00044#4--add--end--lujh
       
       IF g_detail_d[l_ac].nmbb008-l_n-l_n1 <=0 THEN
          CONTINUE FOREACH
       END IF     
              
        #调整 未冲销金额,本币金额
       LET g_detail_d[l_ac].nmbb008 = g_detail_d[l_ac].nmbb008 -l_n-l_n1
       LET g_detail_d[l_ac].nmbb009 = g_detail_d[l_ac].nmbb008 * g_detail_d[l_ac].nmbb005       
      #160530-00017#1  2016/06/12 By 07900 -add -end
      
      INSERT INTO axrp400_tmp(sel,nmbbdocno,nmbbseq,nmbb026) 
        VALUES(g_detail_d[l_ac].sel,g_detail_d[l_ac].nmbbdocno,g_detail_d[l_ac].nmbbseq,g_detail_d[l_ac].nmbb026)
      #end add-point
      
      CALL axrp400_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.other_table"
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axrp400_sel
   
   LET l_ac = 1
   CALL axrp400_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   CALL axrp400_b_fill1()
   DISPLAY 0,0,0 TO sum5,sum6,sum7 #161003-00015#1 add
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp400.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrp400_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
 
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axrp400.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrp400_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp400.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrp400_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   DEFINE l_str         STRING
   DEFINE l_nmbb026     STRING   #161130-00023#1
   {   #160620-00010#1 Add
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
   }   #160620-00010#1 Add
  #160620-00010#1 Mark ---(S)---
  #DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt)
  #   ON UPDATE
  #
  #END DISPLAY
  #160620-00010#1 Mark ---(S)---

   LET l_nmbb026 = ''   #161130-00023#1 Add
  #160620-00010#1 Add  ---(S)---
   CALL cl_set_act_visible("accept,cancel", FALSE)
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         CONSTRUCT BY NAME g_wc_filter ON b_nmbbdocno,b_nmbbseq,b_nmbb026,b_nmbadocdt,b_nmbb029,b_nmbb004,b_nmba008,b_nmbb031,b_nmbb030,b_nmbb003
             BEFORE CONSTRUCT

         #161130-00023#1 Add  ---(S)---
         AFTER FIELD b_nmbb026
            CALL FGL_DIALOG_GETBUFFER() RETURNING l_nmbb026
         #161130-00023#1 Add  ---(E)---

         ON ACTION controlp INFIELD b_nmbbdocno
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmbbcomp = '",g_glaa.glaacomp,"'"
           #CALL q_nmbbdocno()                           #呼叫開窗        #161128-00009#1 Mark
            CALL q_nmbbdocno_1()                           #呼叫開窗      #161128-00009#1 Add
            LET g_qryparam.where = ""
            DISPLAY g_qryparam.return1 TO b_nmbbdocno    #顯示到畫面上
            NEXT FIELD b_nmbbdocno                       #返回原欄位

         ON ACTION controlp INFIELD b_nmbb026
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #161111-00049#1 Mark ---(S)---
			  #LET g_qryparam.arg1 = g_glaa.glaacomp
           #CALL q_pmaa001_13()                         #呼叫開窗
			   #161111-00049#1 Mark ---(E)---
			   #161111-00049#1 Add  ---(S)---
            LET g_qryparam.where = "pmaa002 IN ('2','3')"
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_sql_ctrl
            END IF
            LET g_qryparam.arg1="('2','3')"
            CALL q_pmaa001_1()
			   #161111-00049#1 Add  ---(E)---
            DISPLAY g_qryparam.return1 TO b_nmbb026      #顯示到畫面上
            NEXT FIELD b_nmbb026                         #返回原欄位

         ON ACTION controlp INFIELD b_nmbb004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbb004      #顯示到畫面上
            NEXT FIELD b_nmbb004                         #返回原欄位

         ON ACTION controlp INFIELD b_nmba008
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                             #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmba008      #顯示到畫面上
            NEXT FIELD b_nmba008                         #返回原欄位

         ON ACTION controlp INFIELD b_nmbb030
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_nmbb030_02()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbb030      #顯示到畫面上
            NEXT FIELD b_nmbb030                         #返回原欄位

         ON ACTION controlp INFIELD b_nmbb003
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmas_01()                             #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbb003      #顯示到畫面上
            NEXT FIELD b_nmbb003                         #返回原欄位

         END CONSTRUCT

        CONSTRUCT BY NAME g_wc_filter2 ON flag,b_xrcadocno,b_xrccseq,b_xrcc001,b_xrcasite,b_xrca003,b_xrca005,b_xrcald
           BEFORE CONSTRUCT

           AFTER FIELD flag
            CALL FGL_DIALOG_GETBUFFER() RETURNING l_str

            ON ACTION controlp INFIELD b_xrcadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      IF l_str = "flag='1'" OR l_str = " 1=1" OR cl_null(l_str) THEN
                  LET g_qryparam.where= "xrcadocdt <= '",g_master.xrdadocdt,"'",
                                        " AND xrca001 NOT IN ('01','02','03','04','31','141','142')",
                                        " AND xrcald ='",g_master.xrdald,"'",
                                        " AND xrcadocno IN (SELECT UNIQUE xrcadocno FROM axrp400_cum_tmp )"
                  CALL q_xrcadocno_12()                         #呼叫開窗
               ELSE
                  LET g_qryparam.where= "apcadocdt <= '",g_master.xrdadocdt,"'",
                                        " AND apcald ='",g_master.xrdald,"'",
                                        " AND apcadocno IN (SELECT UNIQUE xrcadocno FROM axrp400_cum_tmp )"
                  CALL q_apcadocno_14()
               END IF
               DISPLAY g_qryparam.return1 TO b_xrcadocno      #顯示到畫面上
               LET g_qryparam.where=NULL
               NEXT FIELD b_xrcadocno                        #返回原欄位

            ON ACTION controlp INFIELD b_xrcasite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               #CALL q_ooef001()                           #呼叫開窗   #161021-00050#3 mark
               CALL q_ooef001_46()                                    #161021-00050#3 add
               DISPLAY g_qryparam.return1 TO b_xrcasite    #顯示到畫面上
               NEXT FIELD b_xrcasite                       #返回原欄位

            ON ACTION controlp INFIELD b_xrca003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_xrca003      #顯示到畫面上
               NEXT FIELD b_xrca003                      #返回原欄位

            ON ACTION controlp INFIELD b_xrca005
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      #161111-00049#1 Mark ---(S)---
			     #LET g_qryparam.arg1 = g_glaa.glaacomp
              #CALL q_pmaa001_13()                         #呼叫開窗
			      #161111-00049#1 Mark ---(E)---
			      #161111-00049#1 Add  ---(S)---
               LET g_qryparam.where = "pmaa002 IN ('2','3')"
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND ",g_sql_ctrl
               END IF
               LET g_qryparam.arg1="('2','3')"
               CALL q_pmaa001_1()
			      #161111-00049#1 Add  ---(E)---
               DISPLAY g_qryparam.return1 TO b_xrca005      #顯示到畫面上
               NEXT FIELD b_xrca005                      #返回原欄位

            ON ACTION controlp INFIELD b_xrcald
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_authorised_ld()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_xrcald     #顯示到畫面上
               NEXT FIELD b_xrcld                      #返回原欄位

         END CONSTRUCT

      ON ACTION qbe_select      
 
      ON ACTION qbe_save       
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG

   CALL cl_set_act_visible("accept,cancel", TRUE)
  #160620-00010#1 Add  ---(E)---

   CALL axrp400_filter_show('b_nmbbdocno','b_nmbbdocno')
   CALL axrp400_filter_show('b_nmbbseq','b_nmbbseq')
   CALL axrp400_filter_show('b_nmbb026','b_nmbb026')
   CALL axrp400_filter_show('b_nmbadocdt','b_nmbadocdt')
   CALL axrp400_filter_show('b_nmbb029','b_nmbb029')
   CALL axrp400_filter_show('b_nmbb004','b_nmbb004')
   CALL axrp400_filter_show('b_nmba008','b_nmba008')
   CALL axrp400_filter_show('b_nmbb031','b_nmbb031')
   CALL axrp400_filter_show('b_nmbb030','b_nmbb030')
   CALL axrp400_filter_show('b_nmbb003','b_nmbb003')
   CALL axrp400_filter_show('flag','flag')
   CALL axrp400_filter_show('b_xrcadocno','b_xrcadocno')
   CALL axrp400_filter_show('b_xrccseq','b_xrccseq')
   CALL axrp400_filter_show('b_xrcc001','b_xrcc001')
   CALL axrp400_filter_show('b_xrcasite','b_xrcasite')
   CALL axrp400_filter_show('b_xrca003','b_xrca003')
   CALL axrp400_filter_show('b_xrca005','b_xrca005')
   CALL axrp400_filter_show('b_xrcald','b_xrcald')


   #161130-00023#1 Add  ---(S)---
   IF NOT cl_null(l_nmbb026) THEN
      LET l_nmbb026 = cl_replace_str(l_nmbb026,"|","','")
      LET l_nmbb026 = " xrca004 IN ('",l_nmbb026,"')"
      LET g_nmbb026 = l_nmbb026
   ELSE
      LET g_nmbb026 = g_nmbb026_t
   END IF
   #161130-00023#1 Add  ---(E)---
 
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL axrp400_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="axrp400.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrp400_filter_parser(ps_field)
   #add-point:filter段define(客製用) name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define name="filter_parser.define"
   
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
 
{<section id="axrp400.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrp400_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = axrp400_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrp400.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

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
PRIVATE FUNCTION axrp400_xrdasite_chk(p_site,p_user,p_ld)
   DEFINE p_site      LIKE xrda_t.xrdasite
   DEFINE p_user      LIKE xrca_t.xrca003
   DEFINE p_ld        LIKE xrca_t.xrcald
   DEFINE l_ooeastus  LIKE ooea_t.ooeastus
   DEFINE l_xrahstus  LIKE xrah_t.xrahstus
   DEFINE l_xrah007   LIKE xrah_t.xrah007
   DEFINE l_ooagstus  LIKE ooag_t.ooagstus
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   
   LET g_errno = ' '
   
   IF cl_null(p_site) THEN RETURN END IF
   IF cl_null(p_ld)   THEN RETURN END IF
   
   #帳套下屬於法人否檢查
    SELECT COUNT(*) INTO l_cnt FROM glaa_t,ooef_t,xrah_t 
    WHERE glaald   = p_ld
      AND glaacomp = ooef017 
      AND glaaent  = ooefent 
      AND ooef001  = xrah004 
      AND ooefent  = xrahent 
      AND xrah002  = p_site
      AND xrah001  = 1
      
   IF l_cnt < 1 OR cl_null(l_cnt) THEN
      LET g_errno = 'axr-00089' RETURN
   END IF
   
   IF cl_null(p_user) THEN RETURN g_errno END IF
   
   #人員對應帳套使用權限檢查
   IF NOT cl_null(p_ld) AND NOT cl_null(p_user) THEN
      CALL s_ld_chk_authorization(p_user,p_ld) 
         RETURNING l_success
      IF l_success = FALSE THEN
         LET g_errno = 'axr-00022' RETURN
      END IF
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
PRIVATE FUNCTION axrp400_xrda_dis(p_lab)
   DEFINE p_lab             LIKE type_t.chr10
   DEFINE l_xrcacomp_desc   LIKE type_t.chr80
   DEFINE l_success         LIKE type_t.chr1

   CASE
      WHEN p_lab = 'site'
         CALL s_axrt300_xrca_ref('xrcasite',g_master.xrdasite,'','') RETURNING l_success,g_master.xrdasite_desc
         DISPLAY BY NAME g_master.xrdasite_desc

      WHEN p_lab = 'ld'
         CALL s_axrt300_xrca_ref('xrcald',g_master.xrdald,'','') RETURNING l_success,g_master.xrdald_desc
        #SELECT * INTO g_glaa.* FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrdald  #161219-00014#2--mark--
         #161219-00014#2--add--s--
         SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
         glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,glaa012,
         glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,glaa024,glaa025,
         glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,
         glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
           FROM glaa_t 
          WHERE glaaent = g_enterprise AND glaald = g_master.xrdald
         #161219-00014#2--add--e--
         LET g_master.xrdacomp_desc = g_glaa.glaacomp
         CALL s_axrt300_xrca_ref('xrcasite',g_master.xrdacomp_desc,'','') RETURNING l_success,l_xrcacomp_desc
         IF NOT cl_null(g_master.xrdacomp_desc) THEN LET g_master.xrdacomp_desc = g_master.xrdacomp_desc,'(',l_xrcacomp_desc,')' END IF
         CALL s_axrt300_sel_ld(g_master.xrdald) RETURNING l_success,g_ls
         DISPLAY BY NAME g_master.xrdald_desc,g_master.xrdacomp_desc

   END CASE
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
PRIVATE FUNCTION axrp400_def()
   DEFINE l_xrcacomp_desc         LIKE type_t.chr500
   DEFINE l_success               LIKE type_t.chr1
   DEFINE l_cnt                   LIKE type_t.num5
   DEFINE l_sql                   STRING
   DEFINE l_xrcacomp              LIKE xrca_t.xrcacomp

   IF cl_null(g_master.diff) THEN LET g_master.diff = '1' END IF
   IF cl_null(g_master.chk) THEN LET g_master.chk = 'N' END IF
   
   #帳務中心
   #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
   CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_master.xrdasite,g_errno
   #該帳務中心與帳別無法勾稽到,以登入人員g_user取得預設帳別/法人
   CALL s_fin_orga_get_comp_ld(g_master.xrdasite) RETURNING l_success,g_errno,l_xrcacomp,g_master.xrdald
    
   #若取不出資料,則不預設帳別
   IF NOT l_success THEN
      LET g_master.xrdald   = ''
   END IF
   CALL s_axrt300_sel_ld(g_master.xrdald) RETURNING l_success,g_ls

  #SELECT * INTO g_glaa.* FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrdald  #161219-00014#2--mark--
  #161219-00014#2--add--s--
  SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
  glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,glaa012,
  glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,glaa024,glaa025,
  glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,
  glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
    FROM glaa_t 
   WHERE glaaent = g_enterprise AND glaald = g_master.xrdald
  #161219-00014#2--add--e--
   LET g_master.xrdacomp_desc = g_glaa.glaacomp

   CALL s_axrt300_xrca_ref('xrcasite',g_master.xrdasite,'','') RETURNING l_success,g_master.xrdasite_desc
   CALL s_axrt300_xrca_ref('xrcald',g_master.xrdald,'','') RETURNING l_success,g_master.xrdald_desc
   CALL s_axrt300_xrca_ref('xrcasite',g_master.xrdacomp_desc,'','') RETURNING l_success,l_xrcacomp_desc
   IF NOT cl_null(g_master.xrdacomp_desc) THEN LET g_master.xrdacomp_desc = g_master.xrdacomp_desc,'(',l_xrcacomp_desc,')' END IF
   IF cl_null(g_master.xrda003) THEN LET g_master.xrda003_desc = '' END IF
   DISPLAY BY NAME g_master.xrda003_desc
   DISPLAY BY NAME g_master.xrdald_desc,g_master.xrdasite_desc,g_master.xrdacomp_desc
  #161111-00049#1 Add  ---(S)---
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_glaa.glaacomp) RETURNING g_sub_success,g_sql_ctrl
  #161111-00049#1 Add  ---(E)---
   LET g_amt_xrde119 = 0   #161013-00003#2 Add
   LET g_amt_xrce119 = 0   #161013-00003#2 Add

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
PRIVATE FUNCTION axrp400_ref_xrda003()
   SELECT ooag011 INTO g_master.xrda003_desc FROM ooag_t WHERE ooagent=g_enterprise AND ooag001=g_master.xrda003
   DISPLAY BY NAME g_master.xrda003,g_master.xrda003_desc
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
PRIVATE FUNCTION axrp400_get_sql()
   DEFINE ls_ac         LIKE type_t.num5
   DEFINE l_cmd         LIKE type_t.num5
   DEFINE l_flag        LIKE type_t.chr1
   DEFINE l_str         STRING
   DEFINE l_sub_sql     STRING
   DEFINE ls_wc         STRING
   DEFINE ls_wc1        STRING
   DEFINE ls_wc2        STRING
   DEFINE ls_wc3        STRING

   #NM  資料的獲取
   LET g_wc_nm = "SELECT nmbbdocno,nmbbseq FROM axrp400_tmp ",
                 " WHERE nmbb026 = ? AND sel = 'Y' "
    
   #AR  資料的獲取
   #161013-00003#2 Mark ---(S)---
  #LET g_wc_ar = "SELECT xrcadocno,xrccseq,xrcc001",
  #              "  FROM axrp400_tmp",
  #              " WHERE nmbb026 = ? AND sel1 = 'Y' ",
  #              "   AND flag = '1'"
   #161013-00003#2 Mark ---(E)---
   #161013-00003#2 Mark ---(S)---
   LET g_wc_ar ="SELECT xrcadocno,xrccseq,xrcc001",
                "  FROM axrp400_cum_tmp",
                " WHERE xrca005 = ? AND sel1 = 'Y' ",
                "   AND flag = '1'"
   #161013-00003#2 Mark ---(E)---
                 
   #計算帳款部分
   #161013-00003#2 Mark ---(S)---
  #LET g_wc_ap ="SELECT xrcadocno,xrccseq,xrcc001",
  #             "  FROM axrp400_tmp",
  #             " WHERE nmbb026 = ? AND sel1 = 'Y' ",
  #             "   AND flag = '2'"
   #161013-00003#2 Mark ---(E)---
   #161013-00003#2 Mark ---(S)---
   LET g_wc_ap ="SELECT xrcadocno,xrccseq,xrcc001",
                "  FROM axrp400_cum_tmp",
                " WHERE xrca005 = ? AND sel1 = 'Y' ",
                "   AND flag = '2'"
   #161013-00003#2 Mark ---(E)---

   PREPARE axrp400_nm_prep FROM g_wc_nm
   DECLARE axrp400_nm_curs CURSOR FOR axrp400_nm_prep

   PREPARE axrp400_ar_prep FROM g_wc_ar
   DECLARE axrp400_ar_curs CURSOR FOR axrp400_ar_prep
   
   PREPARE axrp400_sel_apcc_prep FROM g_wc_ap
   DECLARE axrp400_sel_apcc_curs CURSOR FOR axrp400_sel_apcc_prep
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
PRIVATE FUNCTION axrp400_get_ar()
   DEFINE l_sql          STRING 
   DEFINE l_nmbb026      LIKE nmbb_t.nmbb026
   DEFINE l_nmbb027      LIKE nmbb_t.nmbb027
   DEFINE l_nmbb004      LIKE nmbb_t.nmbb004
   DEFINE l_success      LIKE type_t.chr1
   DEFINE i              LIKE type_t.num5
   DEFINE j              LIKE type_t.num5
   DEFINE l_start_no     LIKE xrca_t.xrcadocno
   DEFINE l_end_no       LIKE xrca_t.xrcadocno
   DEFINE l_xrdadocno    LIKE xrda_t.xrdadocno
   #151125-00006#1----add--s
   DEFINE  l_ooba002        LIKE ooba_t.ooba002
   DEFINE  l_slip_success   LIKE type_t.num5
   DEFINE  l_conf_success   LIKE type_t.num5
   DEFINE  l_dfin0031       LIKE type_t.chr1
   DEFINE  l_dfin0032       LIKE type_t.chr1
   DEFINE  l_gl_slip        LIKE ooba_t.ooba002 
   #151125-00006#1----add--e
   
   LET g_success = 'Y'
   LET j = 1
   LET l_start_no = '' 
   CALL axrp400_get_sql()
   DELETE FROM axrp400_s01_tmp
   LET l_sql = " SELECT UNIQUE nmbb026 FROM axrp400_tmp WHERE (sel='Y' OR sel1 = 'Y')",
               " UNION ",                                                                 #161013-00003#2 Add
               " SELECT UNIQUE xrca005 FROM axrp400_cum_tmp WHERE sel1 = 'Y'         "    #161013-00003#2 Add
   PREPARE axrp400_nmbb026_prep FROM l_sql
   DECLARE axrp400_nmbb026_curs CURSOR FOR axrp400_nmbb026_prep
   FOREACH axrp400_nmbb026_curs INTO g_nmbb026_d[j].*
      LET j = j + 1
   END FOREACH
   CALL g_nmbb026_d.deleteElement(g_nmbb026_d.getLength())
   LET j = j - 1
   CALL cl_err_collect_init()
   CALL s_transaction_begin()
   FOR i = 1 TO g_nmbb026_d.getLength() 
     #CALL s_transaction_begin()
      #資料匯入沖帳單單頭檔
      CALL axrp400_ins_xrda(g_nmbb026_d[i].nmbb026) RETURNING l_success

      #資料匯入沖帳單單身檔
      CALL axrp400_ins_xrce(g_nmbb026_d[i].nmbb026)
      CALL axrp400_get_amt()
      
      IF l_success = 'Y' AND g_success ='Y' THEN
         IF cl_null(l_start_no) THEN
            LET l_start_no = g_xrdadocno
         END IF
         LET l_end_no = g_xrdadocno
        #CALL s_transaction_end('Y','1')
      ELSE
        #CALL s_transaction_end('N','1')     
      END IF
      
   END FOR
   
   IF g_amt1 > 0 OR cl_null(g_amt1) THEN   #160530-00005#5 Add
      CALL axrp400_s01()
   END IF                                  #160530-00005#5 Add
   
  #LET g_success ='Y'
  #CALL s_transaction_begin()
   IF g_success ='Y' THEN
      #差异处理
      LET l_sql = " SELECT xrdadocno FROM axrp400_s01_tmp ",
                  "  WHERE diff1 = '2' ",
                  "    AND amt3 > 0"   #161013-00003#2 Add
      PREPARE axrp400_s01_diff_prep FROM l_sql
      DECLARE axrp400_s01_diff_curs CURSOR FOR axrp400_s01_diff_prep
      FOREACH axrp400_s01_diff_curs INTO l_xrdadocno
         CALL axrp400_ar_diff(l_xrdadocno)
      END FOREACH
      
      LET l_xrdadocno = ''
      DELETE FROM s_voucher_tmp09    #160727-00019#6  2016/07/28 By 08734     s_voucher_ar_tmp ——> s_voucher_tmp09       
      DELETE FROM s_voucher_tmp05     #160727-00019#6  2016/07/29 By 08734     s_voucher_ar_group ——> s_voucher_tmp05      
      DELETE FROM s_voucher_glbc
      #产生分录底稿
      LET l_sql = " SELECT UNIQUE xrdadocno FROM axrp400_s01_tmp "
      PREPARE axrp400_s01_diff_prep1 FROM l_sql
      DECLARE axrp400_s01_diff_curs1 CURSOR FOR axrp400_s01_diff_prep1
      FOREACH axrp400_s01_diff_curs1 INTO l_xrdadocno
         CALL s_pre_voucher_ins('AR','R20',g_master.xrdald,l_xrdadocno,g_master.xrdadocdt,'2') RETURNING l_success
         
        IF l_success THEN  
            LET g_success = 'Y'   
         ELSE
            LET g_success = 'N' 
         END IF
      END FOREACH
      
      CALL s_transaction_end('Y','0')
   ELSE
      LET l_start_no = ''
      CALL s_transaction_end('N','0')     
   END IF
   
   IF NOT cl_null(l_start_no) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00251'
      LET g_errparam.replace[1] = l_start_no
      LET g_errparam.replace[2] = l_end_no
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   
   #151125-00006#1---add---s  #执行立即审核及抛砖总账传票
   IF g_success = 'Y' THEN
      
      CALL s_aooi200_fin_get_slip(g_xrdadocno) RETURNING l_slip_success,l_ooba002
      CALL s_fin_get_doc_para(g_master.xrdald,g_glaa.glaacomp,l_ooba002,'D-FIN-0031') RETURNING l_dfin0031
      CALL s_fin_get_doc_para(g_master.xrdald,g_glaa.glaacomp,l_ooba002,'D-FIN-0032') RETURNING l_dfin0032
      CALL s_fin_get_doc_para(g_master.xrdald,g_glaa.glaacomp,l_ooba002,'D-FIN-2002') RETURNING l_gl_slip
      
      IF NOT cl_null(l_dfin0031) AND l_dfin0031 MATCHES '[Yy]' THEN 
         CALL axrp400_immediately_conf(l_start_no,l_end_no) RETURNING l_conf_success
      END IF  
      
      IF NOT cl_null(l_gl_slip) THEN 
         IF NOT cl_null(l_dfin0032) AND l_dfin0032 MATCHES '[Yy]' THEN           
                CALL axrp400_immediately_gen(l_start_no,l_end_no,l_gl_slip)
         END IF 
       ELSE
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = "axr-00987" 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
    END IF 
   #151125-00006#1---add---e
   
   CALL cl_err_collect_show()
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
PRIVATE FUNCTION axrp400_ins_xrda(p_nmbb026)
   DEFINE p_nmbb026      LIKE nmbb_t.nmbb026
  #DEFINE l_xrda         RECORD LIKE xrda_t.*#161219-00014#2
   #161219-00014#2--add--s--
   DEFINE l_xrda RECORD  #收款核銷單單頭檔
       xrdaent LIKE xrda_t.xrdaent, #企业编号
       xrdacomp LIKE xrda_t.xrdacomp, #所属法人
       xrdald LIKE xrda_t.xrdald, #账套别
       xrdadocno LIKE xrda_t.xrdadocno, #冲账单号
       xrdadocdt LIKE xrda_t.xrdadocdt, #冲账日期
       xrdasite LIKE xrda_t.xrdasite, #账务组织
       xrda001 LIKE xrda_t.xrda001, #账款单性质
       xrda003 LIKE xrda_t.xrda003, #账务人员
       xrda004 LIKE xrda_t.xrda004, #账款核销客户
       xrda005 LIKE xrda_t.xrda005, #收款客户
       xrda006 LIKE xrda_t.xrda006, #一次性对象识别码
       xrda007 LIKE xrda_t.xrda007, #生成方式
       xrda008 LIKE xrda_t.xrda008, #来源参考单号
       xrda009 LIKE xrda_t.xrda009, #冲账批序号
       xrda010 LIKE xrda_t.xrda010, #集团代收付单号
       xrda011 LIKE xrda_t.xrda011, #差异处理
       xrda012 LIKE xrda_t.xrda012, #退款类型
       xrda013 LIKE xrda_t.xrda013, #分录底稿是否可重新生成
       xrda014 LIKE xrda_t.xrda014, #抛转凭证号码
       xrda015 LIKE xrda_t.xrda015, #作废理由码
       xrda016 LIKE xrda_t.xrda016, #打印次数
       xrda017 LIKE xrda_t.xrda017, #MEMO备注
       xrdastus LIKE xrda_t.xrdastus, #审核否
       xrdaownid LIKE xrda_t.xrdaownid, #资料所有者
       xrdaowndp LIKE xrda_t.xrdaowndp, #资料所有部门
       xrdacrtid LIKE xrda_t.xrdacrtid, #资料录入者
       xrdacrtdp LIKE xrda_t.xrdacrtdp, #资料录入部门
       xrdacrtdt LIKE xrda_t.xrdacrtdt, #资料创建日
       xrdamodid LIKE xrda_t.xrdamodid, #资料更改者
       xrdamoddt LIKE xrda_t.xrdamoddt, #最近更改日
       xrdaud001 LIKE xrda_t.xrdaud001, #自定义字段(文本)001
       xrdaud002 LIKE xrda_t.xrdaud002, #自定义字段(文本)002
       xrdaud003 LIKE xrda_t.xrdaud003, #自定义字段(文本)003
       xrdaud004 LIKE xrda_t.xrdaud004, #自定义字段(文本)004
       xrdaud005 LIKE xrda_t.xrdaud005, #自定义字段(文本)005
       xrdaud006 LIKE xrda_t.xrdaud006, #自定义字段(文本)006
       xrdaud007 LIKE xrda_t.xrdaud007, #自定义字段(文本)007
       xrdaud008 LIKE xrda_t.xrdaud008, #自定义字段(文本)008
       xrdaud009 LIKE xrda_t.xrdaud009, #自定义字段(文本)009
       xrdaud010 LIKE xrda_t.xrdaud010, #自定义字段(文本)010
       xrdaud011 LIKE xrda_t.xrdaud011, #自定义字段(数字)011
       xrdaud012 LIKE xrda_t.xrdaud012, #自定义字段(数字)012
       xrdaud013 LIKE xrda_t.xrdaud013, #自定义字段(数字)013
       xrdaud014 LIKE xrda_t.xrdaud014, #自定义字段(数字)014
       xrdaud015 LIKE xrda_t.xrdaud015, #自定义字段(数字)015
       xrdaud016 LIKE xrda_t.xrdaud016, #自定义字段(数字)016
       xrdaud017 LIKE xrda_t.xrdaud017, #自定义字段(数字)017
       xrdaud018 LIKE xrda_t.xrdaud018, #自定义字段(数字)018
       xrdaud019 LIKE xrda_t.xrdaud019, #自定义字段(数字)019
       xrdaud020 LIKE xrda_t.xrdaud020, #自定义字段(数字)020
       xrdaud021 LIKE xrda_t.xrdaud021, #自定义字段(日期时间)021
       xrdaud022 LIKE xrda_t.xrdaud022, #自定义字段(日期时间)022
       xrdaud023 LIKE xrda_t.xrdaud023, #自定义字段(日期时间)023
       xrdaud024 LIKE xrda_t.xrdaud024, #自定义字段(日期时间)024
       xrdaud025 LIKE xrda_t.xrdaud025, #自定义字段(日期时间)025
       xrdaud026 LIKE xrda_t.xrdaud026, #自定义字段(日期时间)026
       xrdaud027 LIKE xrda_t.xrdaud027, #自定义字段(日期时间)027
       xrdaud028 LIKE xrda_t.xrdaud028, #自定义字段(日期时间)028
       xrdaud029 LIKE xrda_t.xrdaud029, #自定义字段(日期时间)029
       xrdaud030 LIKE xrda_t.xrdaud030, #自定义字段(日期时间)030
       xrda103 LIKE xrda_t.xrda103, #原币借方金额合计
       xrda104 LIKE xrda_t.xrda104, #原币贷方金额合计
       xrda113 LIKE xrda_t.xrda113, #本币借方金额合计
       xrda114 LIKE xrda_t.xrda114, #本币贷方金额合计
       xrda123 LIKE xrda_t.xrda123, #本位币二借方金额合计
       xrda124 LIKE xrda_t.xrda124, #本位币二贷方金额合计
       xrda133 LIKE xrda_t.xrda133, #本位币三借方金额合计
       xrda134 LIKE xrda_t.xrda134, #本位币三贷方金额合计
       xrdacnfid LIKE xrda_t.xrdacnfid, #资料确认者
       xrdacnfdt LIKE xrda_t.xrdacnfdt, #数据审核日
       xrdapstid LIKE xrda_t.xrdapstid, #资料过账者
       xrdapstdt LIKE xrda_t.xrdapstdt, #资料过账日
       xrda018 LIKE xrda_t.xrda018 #来源类型(流通)
       END RECORD
   #161219-00014#2--add--e--
  #DEFINE l_xrce         RECORD LIKE xrce_t.*#161219-00014#2
   #161219-00014#2--add--s--
   DEFINE l_xrce RECORD  #應收沖銷明細檔
       xrceent LIKE xrce_t.xrceent, #企业编号
       xrcecomp LIKE xrce_t.xrcecomp, #法人
       xrceld LIKE xrce_t.xrceld, #账套
       xrcedocno LIKE xrce_t.xrcedocno, #冲销单单号
       xrceseq LIKE xrce_t.xrceseq, #项次
       xrcelegl LIKE xrce_t.xrcelegl, #no use
       xrcesite LIKE xrce_t.xrcesite, #账务中心
       xrceorga LIKE xrce_t.xrceorga, #账务归属组织
       xrce001 LIKE xrce_t.xrce001, #来源作业
       xrce002 LIKE xrce_t.xrce002, #冲销类型
       xrce003 LIKE xrce_t.xrce003, #冲销账款单单号
       xrce004 LIKE xrce_t.xrce004, #冲销账款单项次
       xrce005 LIKE xrce_t.xrce005, #冲销账款单账期
       xrce006 LIKE xrce_t.xrce006, #no use
       xrce007 LIKE xrce_t.xrce007, #no use
       xrce008 LIKE xrce_t.xrce008, #no use
       xrce009 LIKE xrce_t.xrce009, #no use
       xrce010 LIKE xrce_t.xrce010, #摘要说明
       xrce011 LIKE xrce_t.xrce011, #no use
       xrce012 LIKE xrce_t.xrce012, #no use
       xrce013 LIKE xrce_t.xrce013, #no use
       xrce014 LIKE xrce_t.xrce014, #no use
       xrce015 LIKE xrce_t.xrce015, #冲销加减项
       xrce016 LIKE xrce_t.xrce016, #冲销科目
       xrce017 LIKE xrce_t.xrce017, #业务人员
       xrce018 LIKE xrce_t.xrce018, #业务部门
       xrce019 LIKE xrce_t.xrce019, #责任中心
       xrce020 LIKE xrce_t.xrce020, #产品类别
       xrce021 LIKE xrce_t.xrce021, #no use
       xrce022 LIKE xrce_t.xrce022, #项目编号
       xrce023 LIKE xrce_t.xrce023, #WBS编号
       xrce024 LIKE xrce_t.xrce024, #第二参考单号
       xrce025 LIKE xrce_t.xrce025, #第二参考单号项次
       xrce026 LIKE xrce_t.xrce026, #no use
       xrce027 LIKE xrce_t.xrce027, #应税折抵否
       xrce028 LIKE xrce_t.xrce028, #生成方式
       xrce029 LIKE xrce_t.xrce029, #凭证号码
       xrce030 LIKE xrce_t.xrce030, #凭证项次
       xrce035 LIKE xrce_t.xrce035, #区域
       xrce036 LIKE xrce_t.xrce036, #客户分类
       xrce037 LIKE xrce_t.xrce037, #no use
       xrce038 LIKE xrce_t.xrce038, #对象
       xrce039 LIKE xrce_t.xrce039, #经营方式
       xrce040 LIKE xrce_t.xrce040, #渠道
       xrce041 LIKE xrce_t.xrce041, #品牌
       xrce042 LIKE xrce_t.xrce042, #自由核算项一
       xrce043 LIKE xrce_t.xrce043, #自由核算项二
       xrce044 LIKE xrce_t.xrce044, #自由核算项三
       xrce045 LIKE xrce_t.xrce045, #自由核算项四
       xrce046 LIKE xrce_t.xrce046, #自由核算项五
       xrce047 LIKE xrce_t.xrce047, #自由核算项六
       xrce048 LIKE xrce_t.xrce048, #自由核算项七
       xrce049 LIKE xrce_t.xrce049, #自由核算项八
       xrce050 LIKE xrce_t.xrce050, #自由核算项九
       xrce051 LIKE xrce_t.xrce051, #自由核算项十
       xrce053 LIKE xrce_t.xrce053, #发票编号
       xrce054 LIKE xrce_t.xrce054, #发票号码
       xrce100 LIKE xrce_t.xrce100, #币种
       xrce101 LIKE xrce_t.xrce101, #汇率
       xrce104 LIKE xrce_t.xrce104, #原币应税折抵税额
       xrce109 LIKE xrce_t.xrce109, #原币冲账金额
       xrce114 LIKE xrce_t.xrce114, #本币应税折抵税额
       xrce119 LIKE xrce_t.xrce119, #本币冲账金额
       xrce120 LIKE xrce_t.xrce120, #本位币二币种
       xrce121 LIKE xrce_t.xrce121, #本位币二汇率
       xrce124 LIKE xrce_t.xrce124, #本位币二应税折抵税额
       xrce129 LIKE xrce_t.xrce129, #本位币二冲账金额
       xrce130 LIKE xrce_t.xrce130, #本位币二币种
       xrce131 LIKE xrce_t.xrce131, #本位币三汇率
       xrce134 LIKE xrce_t.xrce134, #本位币三应税折抵税额
       xrce139 LIKE xrce_t.xrce139, #本位币三冲账金额
       xrceud001 LIKE xrce_t.xrceud001, #自定义字段(文本)001
       xrceud002 LIKE xrce_t.xrceud002, #自定义字段(文本)002
       xrceud003 LIKE xrce_t.xrceud003, #自定义字段(文本)003
       xrceud004 LIKE xrce_t.xrceud004, #自定义字段(文本)004
       xrceud005 LIKE xrce_t.xrceud005, #自定义字段(文本)005
       xrceud006 LIKE xrce_t.xrceud006, #自定义字段(文本)006
       xrceud007 LIKE xrce_t.xrceud007, #自定义字段(文本)007
       xrceud008 LIKE xrce_t.xrceud008, #自定义字段(文本)008
       xrceud009 LIKE xrce_t.xrceud009, #自定义字段(文本)009
       xrceud010 LIKE xrce_t.xrceud010, #自定义字段(文本)010
       xrceud011 LIKE xrce_t.xrceud011, #自定义字段(数字)011
       xrceud012 LIKE xrce_t.xrceud012, #自定义字段(数字)012
       xrceud013 LIKE xrce_t.xrceud013, #自定义字段(数字)013
       xrceud014 LIKE xrce_t.xrceud014, #自定义字段(数字)014
       xrceud015 LIKE xrce_t.xrceud015, #自定义字段(数字)015
       xrceud016 LIKE xrce_t.xrceud016, #自定义字段(数字)016
       xrceud017 LIKE xrce_t.xrceud017, #自定义字段(数字)017
       xrceud018 LIKE xrce_t.xrceud018, #自定义字段(数字)018
       xrceud019 LIKE xrce_t.xrceud019, #自定义字段(数字)019
       xrceud020 LIKE xrce_t.xrceud020, #自定义字段(数字)020
       xrceud021 LIKE xrce_t.xrceud021, #自定义字段(日期时间)021
       xrceud022 LIKE xrce_t.xrceud022, #自定义字段(日期时间)022
       xrceud023 LIKE xrce_t.xrceud023, #自定义字段(日期时间)023
       xrceud024 LIKE xrce_t.xrceud024, #自定义字段(日期时间)024
       xrceud025 LIKE xrce_t.xrceud025, #自定义字段(日期时间)025
       xrceud026 LIKE xrce_t.xrceud026, #自定义字段(日期时间)026
       xrceud027 LIKE xrce_t.xrceud027, #自定义字段(日期时间)027
       xrceud028 LIKE xrce_t.xrceud028, #自定义字段(日期时间)028
       xrceud029 LIKE xrce_t.xrceud029, #自定义字段(日期时间)029
       xrceud030 LIKE xrce_t.xrceud030, #自定义字段(日期时间)030
       xrce055 LIKE xrce_t.xrce055, #费用编号
       xrce056 LIKE xrce_t.xrce056, #方向
       xrce057 LIKE xrce_t.xrce057, #预收待抵单号
       xrce058 LIKE xrce_t.xrce058, #应付单号
       xrce103 LIKE xrce_t.xrce103, #税前原币冲销额
       xrce113 LIKE xrce_t.xrce113, #税前本币冲销额
       xrce123 LIKE xrce_t.xrce123, #本位币二税前冲销额
       xrce133 LIKE xrce_t.xrce133, #本位币三税前冲销额
       xrce059 LIKE xrce_t.xrce059  #预收单号
       END RECORD
   #161219-00014#2--add--e--
   DEFINE l_success      LIKE type_t.chr1
   DEFINE l_success_1    LIKE type_t.num5

   LET g_xrdadocno = ''

   CALL s_aooi200_fin_gen_docno(g_master.xrdald,g_glaa.glaa024,g_glaa.glaa003,g_master.xrdadocno,g_master.xrdadocdt,'axrt400')
   RETURNING l_success,g_xrdadocno
   IF l_success  = 0  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = g_xrdadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF

   INITIALIZE l_xrda.* TO NULL

   LET l_xrda.xrdaent  = g_enterprise
   LET l_xrda.xrdacomp = g_glaa.glaacomp
   LET l_xrda.xrdald   = g_master.xrdald
   LET l_xrda.xrdadocno= g_xrdadocno
   LET l_xrda.xrdadocdt= g_master.xrdadocdt
   LET l_xrda.xrdasite = g_master.xrdasite
   LET l_xrda.xrda001  = '41'
   LET l_xrda.xrda003  = g_master.xrda003
   LET l_xrda.xrda004  = p_nmbb026
   LET l_xrda.xrda005  = p_nmbb026
   LET l_xrda.xrda006  = p_nmbb026
   LET l_xrda.xrda007  = '1'
   LET l_xrda.xrda008  = ''
  #LET l_xrda.xrda009  = g_conditions.xrda009
   LET l_xrda.xrda010  = ''
   LET l_xrda.xrda011  = g_master.diff
   LET l_xrda.xrda012  = ''
   LET l_xrda.xrda013  = 'Y'
   LET l_xrda.xrda014  = ''
   LET l_xrda.xrda015  = ''
   LET l_xrda.xrda016  = 0
   LET l_xrda.xrda017  = ''
   LET l_xrda.xrdastus = 'N'
   LET l_xrda.xrdaownid= g_user
   LET l_xrda.xrdaowndp= g_dept
   LET l_xrda.xrdacrtid= g_user
   LET l_xrda.xrdacrtdp= g_dept
   LET l_xrda.xrdacrtdt= cl_get_current()
   LET l_xrda.xrdamodid= ""
   LET l_xrda.xrdamoddt= ""
   IF NOT cl_null(g_master.xrca063) THEN
      LET l_xrda.xrda009 = g_master.xrca063
   END IF
   CALL s_aooi390_oofi_upd('14',l_xrda.xrda009) RETURNING l_success_1  
  #INSERT INTO xrda_t VALUES (l_xrda.*)  #161219-00014#2 mark
   #161219-00014#2--add--s--
   INSERT INTO xrda_t(xrdaent,xrdacomp,xrdald,xrdadocno,xrdadocdt,xrdasite,xrda001,xrda003,xrda004,xrda005,xrda006,xrda007,xrda008,xrda009,xrda010,xrda011,
   xrda012,xrda013,xrda014,xrda015,xrda016,xrda017,xrdastus,xrdaownid,xrdaowndp,xrdacrtid,xrdacrtdp,xrdacrtdt,xrdamodid,xrdamoddt,xrdaud001,xrdaud002,xrdaud003,
   xrdaud004,xrdaud005,xrdaud006,xrdaud007,xrdaud008,xrdaud009,xrdaud010,xrdaud011,xrdaud012,xrdaud013,xrdaud014,xrdaud015,xrdaud016,xrdaud017,xrdaud018,xrdaud019,
   xrdaud020,xrdaud021,xrdaud022,xrdaud023,xrdaud024,xrdaud025,xrdaud026,xrdaud027,xrdaud028,xrdaud029,xrdaud030,xrda103,xrda104,xrda113,xrda114,xrda123,xrda124,
   xrda133,xrda134,xrdacnfid,xrdacnfdt,xrdapstid,xrdapstdt,xrda018) VALUES (l_xrda.xrdaent,l_xrda.xrdacomp,l_xrda.xrdald,l_xrda.xrdadocno,l_xrda.xrdadocdt,l_xrda.xrdasite,
   l_xrda.xrda001,l_xrda.xrda003,l_xrda.xrda004,l_xrda.xrda005,l_xrda.xrda006,l_xrda.xrda007,l_xrda.xrda008,l_xrda.xrda009,l_xrda.xrda010,l_xrda.xrda011,l_xrda.xrda012,l_xrda.xrda013,
   l_xrda.xrda014,l_xrda.xrda015,l_xrda.xrda016,l_xrda.xrda017,l_xrda.xrdastus,l_xrda.xrdaownid,l_xrda.xrdaowndp,l_xrda.xrdacrtid,l_xrda.xrdacrtdp,l_xrda.xrdacrtdt,l_xrda.xrdamodid,
   l_xrda.xrdamoddt,l_xrda.xrdaud001,l_xrda.xrdaud002,l_xrda.xrdaud003,l_xrda.xrdaud004,l_xrda.xrdaud005,l_xrda.xrdaud006,l_xrda.xrdaud007,l_xrda.xrdaud008,l_xrda.xrdaud009,l_xrda.xrdaud010,
   l_xrda.xrdaud011,l_xrda.xrdaud012,l_xrda.xrdaud013,l_xrda.xrdaud014,l_xrda.xrdaud015,l_xrda.xrdaud016,l_xrda.xrdaud017,l_xrda.xrdaud018,l_xrda.xrdaud019,l_xrda.xrdaud020,l_xrda.xrdaud021,
   l_xrda.xrdaud022,l_xrda.xrdaud023,l_xrda.xrdaud024,l_xrda.xrdaud025,l_xrda.xrdaud026,l_xrda.xrdaud027,l_xrda.xrdaud028,l_xrda.xrdaud029,l_xrda.xrdaud030,l_xrda.xrda103,l_xrda.xrda104,
   l_xrda.xrda113,l_xrda.xrda114,l_xrda.xrda123,l_xrda.xrda124,l_xrda.xrda133,l_xrda.xrda134,l_xrda.xrdacnfid,l_xrda.xrdacnfdt,l_xrda.xrdapstid,l_xrda.xrdapstdt,l_xrda.xrda018)
   #161219-00014#2--add--e--
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'xrda_t'
      LET g_errparam.extend = SQLCA.sqlcode
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
   END IF

   RETURN g_success
END FUNCTION

################################################################################
# Descriptions...: 填充第二个单身
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
PRIVATE FUNCTION axrp400_b_fill1()
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_n            LIKE type_t.num5
   DEFINE l_flag         LIKE type_t.chr1
   DEFINE l_xrca001_desc LIKE type_t.chr80
   DEFINE l_sel1         LIKE type_t.chr1
   DEFINE l_n3           LIKE xrce_t.xrce109
   DEFINE l_n1           LIKE xrce_t.xrce109
   DEFINE l_n2           LIKE apce_t.apce109
   DEFINE ls_wc1         STRING                #160607-00015#2 Add
   DEFINE ls_wc2         STRING                #161114-00028#1 Add
   DEFINE l_pmaa004      LIKE pmaa_t.pmaa004   #170112-00044#4 add lujh
   
   LET g_wc2 = cl_replace_str(g_wc2,'apca','xrca')
   LET g_wc2 = cl_replace_str(g_wc2,'apcc','xrcc')
   LET g_wc2 = cl_replace_str(g_wc2,'b_xrca','xrca')
   LET g_wc2 = cl_replace_str(g_wc2,'b_xrcc','xrcc')
  #160620-00010#1 Add  ---(S)---
   LET g_wc_filter2 = cl_replace_str(g_wc_filter2,'b_xrca','xrca')
   LET g_wc_filter2 = cl_replace_str(g_wc_filter2,'b_xrcc','xrcc')
   IF cl_null(g_wc_filter2) THEN LET g_wc_filter2 = " 1=1" END IF
   DELETE FROM axrp400_cum_tmp
  #160620-00010#1 Add  ---(E)---

  #161114-00028#1 Add  ---(S)---
   CALL axrp400_get_nmbb026() RETURNING ls_wc2
  #161114-00028#1 Add  ---(E)---

  #160607-00015#2  Add  ---(S)---
   LET ls_wc1 = " NOT EXISTS (SELECT 1 FROM isba_t,isbc_t WHERE isbaent = isbcent AND isbadocno = isbcdocno ",
                " AND isbacomp = isbccomp AND isbcent = xrccent AND isbastus <> 'X' ",
                " AND isbc007 = xrccdocno AND isbc008 = xrcc001)"
  #160607-00015#2  Add  ---(E)---

   #161013-00003#2 Mark ---(S)---
  ##AR  資料的獲取
  #LET g_sql = " SELECT 'N','1',xrcadocno,xrccseq,xrcc001,xrca001,xrcasite,'',xrca003,'',",
  #            "xrca005,'',xrcald,'',xrcadocdt,xrcc108,xrcc109,0,SUM(xrcc108 - xrcc109)", #160530-00017#1  Add 0
  #            "  FROM xrca_t,xrcb_t,xrcc_t",
  #            " WHERE xrcaent   = xrcbent   AND xrcaent   = xrccent",
  #            "   AND xrcadocno = xrcbdocno AND xrcadocno = xrccdocno",
  #            "   AND xrcald    = xrcbld    AND xrcald    = xrccld",
  #            "   AND xrcbseq   = xrccseq",
  #            "   AND xrcaent   = ",g_enterprise,
  #            "   AND xrca001 NOT IN ('01','02','03','04','31','141','142')",
  #            "   AND xrcald = '",g_master.xrdald,"'",
  #            "   AND xrcacomp = '",g_glaa.glaacomp,"'",
  #            "   AND xrcastus = 'Y' ",
  #            "   AND ", g_wc2 CLIPPED,
  #            "   AND ", ls_wc1 CLIPPED,   #160607-00015#2  Add
  #            " GROUP BY xrcadocno,xrccseq,xrcc001,xrca001,xrcasite,xrca003,xrca005,xrcald,xrcadocdt,xrcc108,xrcc109",
  #            " HAVING SUM(xrcc108 - xrcc109) > 0"
  #IF g_master.chk = 'Y' THEN
  #   LET g_wc2 = cl_replace_str(g_wc2,'xrca','apca')
  #   LET g_wc2 = cl_replace_str(g_wc2,'xrcc','apcc')
  #  #IF g_wc3 = "flag='2'" THEN
  #   LET g_sql = g_sql CLIPPED," UNION ",
  #            " SELECT 'N','2',apcadocno,apccseq,apcc001,apca001,apcasite,'',apca003,'',",
  #            "apca005,'',apcald,'',apcadocdt,apcc108,apcc109,0,SUM(apcc108 - apcc109)",  #160530-00017#1  Add 0
  #            "  FROM apcc_t,apca_t,gzcb_t",
  #            " WHERE apccent = ",g_enterprise,
  #            "   AND apccld = apcald",
  #            "   AND apccdocno = apcadocno",
  #            "   AND apccent = apcaent ",
  #            "   AND apcastus = 'Y'",
  #            "   AND apcacomp = '",g_glaa.glaacomp,"'",
  #            "   AND apcald = '",g_master.xrdald,"'",
  #            "   AND apca001 = gzcb002",
  #            "   AND gzcb003 = '1'",
  #            "   AND gzcb001 = '8502'",
  #            "   AND ", g_wc2 CLIPPED,
  #            "   AND apcc108 - apcc109 > 0",
  #            " GROUP BY apcadocno,apccseq,apcc001,apca001,apcasite,apca003,apca005,apcald,apcadocdt,apcc108,apcc109"
  #END IF
   #161013-00003#2 Mark ---(E)---
   #161013-00003#2 Add  ---(S)---
   #AR  資料的獲取
   LET g_sql = " SELECT 'N','1',xrcadocno,xrccseq,xrcc001,xrca001,xrcasite,'',xrca003,'',",
               "xrca005,'',xrca057,'',xrcald,'',xrcadocdt,xrcc100,xrcc108,xrcc109,0,SUM(xrcc108 - xrcc109)",   #170112-00044#4 add xrca057,'' lujh
               "  FROM xrca_t,xrcc_t",
               " WHERE xrcaent   = xrccent   AND xrcadocno = xrccdocno",
               "   AND xrcald    = xrccld    AND xrcaent   = ",g_enterprise,
               "   AND xrca001 NOT IN ('01','02','03','04','31','141','142')",
               "   AND xrcald = '",g_master.xrdald,"'",
               "   AND xrcacomp = '",g_glaa.glaacomp,"'",
               "   AND xrcastus = 'Y' ",
               "   AND ", g_wc2 CLIPPED,
               "   AND ", ls_wc1 CLIPPED,
               "   AND ", ls_wc2 CLIPPED,   #161114-00028#1 Add
               "   AND xrca005 IN (SELECT nmbb026 FROM axrp400_tmp)",   #161130-00023#1 Add
               "   AND ", g_nmbb026,   #161130-00023#1 Add
               " GROUP BY xrcadocno,xrccseq,xrcc001,xrca001,xrcasite,xrca003,xrca005,xrca057,xrcald,xrcadocdt,xrcc100,xrcc108,xrcc109",  #170112-00044#4 add xrca057 lujh
               " HAVING SUM(xrcc108 - xrcc109) > 0"
   #AP  資料的獲取
   IF g_master.chk = 'Y' THEN
      LET g_wc2 = cl_replace_str(g_wc2,'xrca','apca')
      LET g_wc2 = cl_replace_str(g_wc2,'xrcc','apcc')
      LET ls_wc2= cl_replace_str(ls_wc2,'xrca','apca')   #161114-00028#1 Add
      LET g_sql = g_sql CLIPPED," UNION ",
               " SELECT 'N','2',apcadocno,apccseq,apcc001,apca001,apcasite,'',apca003,'',",
               "apca005,'',apca057,'',apcald,'',apcadocdt,apcc100,apcc108,apcc109,0,SUM(apcc108 - apcc109)",   #170112-00044#4 add apca057,'' lujh
               "  FROM apcc_t,apca_t,gzcb_t",
               " WHERE apccent = ",g_enterprise,
               "   AND apccld = apcald",
               "   AND apccdocno = apcadocno",
               "   AND apccent = apcaent ",
               "   AND apcastus = 'Y'",
               "   AND apcacomp = '",g_glaa.glaacomp,"'",
               "   AND apcald = '",g_master.xrdald,"'",
               "   AND apca005 IN (SELECT nmbb026 FROM axrp400_tmp)",   #161130-00023#1 Add
               "   AND apca001 = gzcb002",
               "   AND gzcb003 = '1'",
               "   AND gzcb001 = '8502'",
               "   AND ", g_wc2 CLIPPED,
               "   AND ", ls_wc2 CLIPPED,   #161114-00028#1 Add
               "   AND apcc108 - apcc109 > 0",
               " GROUP BY apcadocno,apccseq,apcc001,apca001,apcasite,apca003,apca005,apca057,apcald,apcc100,apcadocdt,apcc108,apcc109"  #170112-00044#4 add apca057 lujh
   END IF
   #161013-00003#2 Add  ---(E)---
   LET l_ac1 = 1
   PREPARE axrp400_sum_prep FROM g_sql
   DECLARE axrp400_sum_curs CURSOR FOR axrp400_sum_prep
   FOREACH axrp400_sum_curs INTO g_detail2_d[l_ac1].*
     #161104-00015#1 Mark ---(S)---
     #SELECT COUNT(*) INTO l_n FROM axrp400_cum_tmp WHERE xrcadocno = g_detail2_d[l_ac1].xrcadocno
     #IF l_n > 0 THEN 
     #   CONTINUE FOREACH 
     #END IF
     #161104-00015#1 Mark ---(E)---
      #151013-00019#11 add ------
      #這裡取備註
      SELECT xrca053 INTO g_detail2_d[l_ac1].xrca053
        FROM xrca_t
       WHERE xrcaent = g_enterprise
         AND xrcald = g_master.xrdald
         AND xrcadocno = g_detail2_d[l_ac1].xrcadocno
      #151013-00019#11 add end---
      
      #170112-00044#4--add--str--lujh
      LET l_pmaa004 = ''
      SELECT pmaa004 INTO l_pmaa004 
        FROM pmaa_t
       WHERE pmaaent = g_enterprise
         AND pmaa001 = g_detail2_d[l_ac1].xrca005
         
      IF l_pmaa004 = '4' THEN   
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_detail2_d[l_ac1].xrca057
         CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
         LET g_detail2_d[l_ac1].xrca057_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_detail2_d[l_ac1].xrca057_desc
      END IF   
          
      IF l_pmaa004 = '2' THEN 
         SELECT pmak003 INTO g_detail2_d[l_ac1].xrca057_desc
           FROM pmak_t
          WHERE pmakent = g_enterprise
            AND pmak001 = g_detail2_d[l_ac1].xrca057
      END IF
      #170112-00044#4--add--end--lujh
      
      INSERT INTO axrp400_cum_tmp VALUES(g_detail2_d[l_ac1].*)
   END FOREACH
   
   SELECT COUNT(*) INTO l_n FROM axrp400_cum_tmp
   DISPLAY "axrp400_cum_tmp: ",l_n
   
   LET g_sql = "SELECT t1.* FROM axrp400_cum_tmp t1 ",
               " WHERE 1=1",
               "   AND ",g_wc_filter2 CLIPPED #160620-00010#1 Add
#               " LEFT OUTER JOIN axrp400_tmp t2 ON t1.xrcadocno = t2.xrcadocno ",
#               "   AND t1.xrccseq = t2.xrccseq AND t1.xrcc001 = t2.xrcc001 "
   
   PREPARE axrp400_sel1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR axrp400_sel1
   
   CALL g_detail2_d.clear()
   LET g_wc_filter2 = " 1=1"   #160620-00010#1 Add
   
   SELECT COUNT(*) INTO l_n FROM axrp400_cum_tmp t1 
    LEFT OUTER JOIN axrp400_tmp t2 ON t1.xrcadocno = t2.xrcadocno 
      AND t1.xrccseq = t2.xrccseq AND t1.xrcc001 = t2.xrcc001 
   DISPLAY "b_fill_curs1: ",l_n
   
   LET l_ac1 = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs1 INTO g_detail2_d[l_ac1].*
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充
      IF g_detail2_d[l_ac1].flag = '1' THEN  #应收
        #CALL cl_set_combo_scc('b_xrca001','8302')
         SELECT gzcbl004 INTO l_xrca001_desc FROM gzcbl_t 
          WHERE gzcbl001 = '8302' 
            AND gzcbl002 = g_detail2_d[l_ac1].xrca001 AND gzcbl003 = g_dlang
          #160530-00017#1  2016/06/12 By 07900 -add -str      
           LET l_n1 =0
           LET l_n3 =0
           LET l_n2 =0 
           SELECT SUM(xrce109) INTO l_n3
             FROM xrce_t,xrda_t
            WHERE xrceent = xrdaent AND xrdald = xrceld AND xrdadocno = xrcedocno 
              AND xrce003 = g_detail2_d[l_ac1].xrcadocno AND xrce004 = g_detail2_d[l_ac1].xrccseq AND xrdastus='N' AND xrceent = g_enterprise
            IF cl_null(l_n3) THEN
               LET l_n3 =0  
            END IF
            
           SELECT SUM(xrce109) INTO l_n1
             FROM xrce_t,xrca_t
            WHERE xrceent = xrcaent AND xrceld = xrcald AND xrcedocno = xrcadocno 
              AND xrce003 = g_detail2_d[l_ac1].xrcadocno AND xrce004 = g_detail2_d[l_ac1].xrccseq AND xrcastus='N' AND xrceent = g_enterprise  
            IF cl_null(l_n1) THEN
               LET l_n1 =0  
            END IF 
            
            SELECT SUM(apce109) INTO l_n2
              FROM apce_t,apda_t
             WHERE apceent = apdaent AND apceld = apdald AND apcedocno=apdadocno
               AND apce003= g_detail2_d[l_ac1].xrcadocno AND apce004 = g_detail2_d[l_ac1].xrccseq AND apdastus='N' AND apceent= g_enterprise
             IF cl_null(l_n2) THEN
               LET l_n2 =0  
            END IF
                                         
            
            IF g_detail2_d[l_ac1].xrcc108 - g_detail2_d[l_ac1].xrcc109-l_n3-l_n1-l_n2 <=0 THEN
               CONTINUE FOREACH
            END IF  
            #调整原币未冲金额       
            LET g_detail2_d[l_ac1].xrcc108_1 = g_detail2_d[l_ac1].xrcc108_1-l_n3-l_n1-l_n2  
                          
           #160530-00017#1  2016/06/12 By 07900 -add -end    
           
      ELSE   #应付
        #CALL cl_set_combo_scc('b_xrca001','8502')
         SELECT gzcbl004 INTO l_xrca001_desc FROM gzcbl_t 
          WHERE gzcbl001 = '8502' 
            AND gzcbl002 = g_detail2_d[l_ac1].xrca001 AND gzcbl003 = g_dlang
         #160530-00017#1  2016/06/12 By 07900 -add -str      
           LET l_n1 =0
           LET l_n3 =0
           LET l_n2 =0 
           SELECT SUM(apce109) INTO l_n3
             FROM apce_t,apda_t
            WHERE apceent = apdaent AND apdald = apceld AND apdadocno = apcedocno 
              AND apce003 = g_detail2_d[l_ac1].xrcadocno AND apce004 = g_detail2_d[l_ac1].xrccseq AND apdastus='N' AND apceent = g_enterprise
            IF cl_null(l_n3) THEN
               LET l_n3 =0  
            END IF
            
           SELECT SUM(apce109) INTO l_n1
             FROM apce_t,apca_t
            WHERE apceent = apcaent AND apceld = apcald AND apcedocno = apcadocno 
              AND apce003 = g_detail2_d[l_ac1].xrcadocno AND apce004 = g_detail2_d[l_ac1].xrccseq AND apcastus='N' AND apceent = g_enterprise  
            IF cl_null(l_n1) THEN
               LET l_n1 =0  
            END IF 
            
            SELECT SUM(xrce109) INTO l_n2
              FROM xrce_t,xrda_t
             WHERE xrceent = xrdaent AND xrceld = xrdald AND xrcedocno=xrdadocno
               AND xrce003= g_detail2_d[l_ac1].xrcadocno AND xrce004 = g_detail2_d[l_ac1].xrccseq AND xrdastus='N' AND xrceent= g_enterprise
             IF cl_null(l_n2) THEN
               LET l_n2 =0  
            END IF
                  
                               
            IF g_detail2_d[l_ac1].xrcc108 - g_detail2_d[l_ac1].xrcc109-l_n3-l_n1-l_n2 <=0 THEN
               CONTINUE FOREACH
            END IF  
            #调整原币未冲金额       
            LET g_detail2_d[l_ac1].xrcc108_1 = g_detail2_d[l_ac1].xrcc108_1-l_n3-l_n1-l_n2  
            
           #160530-00017#1  2016/06/12 By 07900 -add -end    
      END IF
      LET g_detail2_d[l_ac1].xrcc109_1 = l_n1 + l_n2 + l_n3#160530-00017#1  Add
      LET g_detail2_d[l_ac1].xrca001 = g_detail2_d[l_ac1].xrca001,":",l_xrca001_desc
      CALL s_axrt300_xrca_ref('xrcasite',g_detail2_d[l_ac1].xrcasite,'','') RETURNING l_success,g_detail2_d[l_ac1].xrcasite_desc
      CALL s_axrt300_xrca_ref('xrcald',g_detail2_d[l_ac1].xrcald,'','') RETURNING l_success,g_detail2_d[l_ac1].xrcald_desc
      CALL s_axrt300_xrca_ref('xrca003',g_detail2_d[l_ac1].xrca003,'','') RETURNING l_success,g_detail2_d[l_ac1].xrca003_desc
      CALL s_axrt300_xrca_ref('xrca005',g_detail2_d[l_ac1].xrca005,'','') RETURNING l_success,g_detail2_d[l_ac1].xrca005_desc
      
      LET l_sel1 = 'N'
      SELECT sel1 INTO l_sel1 FROM axrp400_tmp
       WHERE xrcadocno = g_detail2_d[l_ac1].xrcadocno 
         AND xrccseq = g_detail2_d[l_ac1].xrccseq AND xrcc001 = g_detail2_d[l_ac1].xrcc001 
      LET g_detail2_d[l_ac1].sel1 = l_sel1
      IF cl_null(g_detail2_d[l_ac1].sel1) THEN LET g_detail2_d[l_ac1].sel1 = 'N' END IF
     
      INSERT INTO axrp400_tmp(nmbb026,sel1,xrcadocno,xrccseq,xrcc001,flag) 
         VALUES(g_detail2_d[l_ac1].xrca005,g_detail2_d[l_ac1].sel1,g_detail2_d[l_ac1].xrcadocno,
                g_detail2_d[l_ac1].xrccseq,g_detail2_d[l_ac1].xrcc001,g_detail2_d[l_ac1].flag)
      #end add-point
      
      CALL axrp400_detail_show()      
 
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
   LET g_error_show = 0

   CLOSE b_fill_curs1
   FREE axrp400_sel1
   
   LET l_ac1 = 1
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
PRIVATE FUNCTION axrp400_create_tmp_table()
DEFINE r_success       LIKE type_t.num5

   DROP TABLE axrp400_tmp;
   CREATE TEMP TABLE axrp400_tmp(
      sel          VARCHAR(1),
      nmbbdocno    VARCHAR(20),
      nmbbseq      INTEGER,
      nmbb026      VARCHAR(10),
      sel1         VARCHAR(1),
      xrcadocno    VARCHAR(20),
      xrccseq      INTEGER,
      xrcc001      INTEGER,
      flag         VARCHAR(1)     #区分资料来源是AX还是AP
   );
   
   DROP TABLE axrp400_s01_tmp;
   CREATE TEMP TABLE axrp400_s01_tmp(
      diff1        VARCHAR(1),
      xrdadocno    VARCHAR(20),
      amt1         DECIMAL(20,6),
      amt2         DECIMAL(20,6),
      amt3         DECIMAL(20,6)
   );
     
   DROP TABLE axrp400_cum_tmp;
   CREATE TEMP TABLE axrp400_cum_tmp(
      sel1           VARCHAR(1),
      flag           VARCHAR(1),
      xrcadocno      VARCHAR(20),
      xrccseq        INTEGER,
      xrcc001        INTEGER,
      xrca001        VARCHAR(80),
      xrcasite       VARCHAR(10),
      xrcasite_desc  VARCHAR(80),
      xrca003        VARCHAR(20),
      xrca003_desc   VARCHAR(80),
      xrca005        VARCHAR(10),
      xrca005_desc   VARCHAR(80),
      #170112-00044#4--add--str--lujh
      xrca057        VARCHAR(20),
      xrca057_desc   VARCHAR(80),
      #170112-00044#4--add--end--lujh
      xrcald         VARCHAR(5),
      xrcald_desc    VARCHAR(80),
      xrcadocdt      DATE,
      xrcc100        VARCHAR(10),         #161013-00003#2 Add
      xrcc108        DECIMAL(20,6),
      xrcc109        DECIMAL(20,6),
      xrcc109_1      DECIMAL(20,6),         #160530-00017#1  Add
      xrcc108_1      DECIMAL(20,6),         #151013-00019#11 add ,
      xrca053        VARCHAR(255)     #151013-00019#11
   );

  #160802-00006#1 Mark ---(S)---
  #DROP TABLE s_voucher_tmp09;      #160727-00019#6  2016/07/28 By 08734     s_voucher_ar_tmp ——> s_voucher_tmp09  
  #   
  #CREATE TEMP TABLE s_voucher_tmp09(       #160727-00019#6  2016/07/28 By 08734     s_voucher_ar_tmp ——> s_voucher_tmp09
  #   docno       LIKE glaq_t.glaqdocno,
  #   docdt       LIKE glap_t.glapdocdt,
  #   sw          LIKE type_t.chr1,
  #   glaqent     LIKE glaq_t.glaqent,
  #   glaqcomp    LIKE glaq_t.glaqcomp,
  #   glaqld      LIKE glaq_t.glaqld,
  #   glaq001     LIKE glaq_t.glaq001,
  #   glaq002     LIKE glaq_t.glaq002,
  #   glaq005     LIKE glaq_t.glaq005,
  #   glaq006     LIKE glaq_t.glaq006,
  #   glaq007     LIKE glaq_t.glaq007,
  #   glaq009     LIKE glaq_t.glaq009,
  #   glaq011     LIKE glaq_t.glaq011,
  #   glaq012     LIKE glaq_t.glaq012,
  #   glaq013     LIKE glaq_t.glaq013,
  #   glaq014     LIKE glaq_t.glaq014,
  #   glaq015     LIKE glaq_t.glaq015,
  #   glaq016     LIKE glaq_t.glaq016,
  #   glaq017     LIKE glaq_t.glaq017,
  #   glaq018     LIKE glaq_t.glaq018,
  #   glaq019     LIKE glaq_t.glaq019,
  #   glaq020     LIKE glaq_t.glaq020,
  #   glaq021     LIKE glaq_t.glaq021,
  #   glaq022     LIKE glaq_t.glaq022,
  #   glaq023     LIKE glaq_t.glaq023,
  #   glaq024     LIKE glaq_t.glaq024,
  #   glaq025     LIKE glaq_t.glaq025,
  #   glaq027     LIKE glaq_t.glaq027,
  #   glaq028     LIKE glaq_t.glaq028,
  #   glaq051     LIKE glaq_t.glaq051,  #經營方式
  #   glaq052     LIKE glaq_t.glaq052,  #渠道
  #   glaq053     LIKE glaq_t.glaq053,  #品牌
  #   glaq029     LIKE glaq_t.glaq029,
  #   glaq030     LIKE glaq_t.glaq030,
  #   glaq031     LIKE glaq_t.glaq031,
  #   glaq032     LIKE glaq_t.glaq032,
  #   glaq033     LIKE glaq_t.glaq033,
  #   glaq034     LIKE glaq_t.glaq034,
  #   glaq035     LIKE glaq_t.glaq035,
  #   glaq036     LIKE glaq_t.glaq036,
  #   glaq037     LIKE glaq_t.glaq037,
  #   glaq038     LIKE glaq_t.glaq038,
  #   glbc004     LIKE glbc_t.glbc004,  #现金变动码
  #   d           LIKE glaq_t.glaq003,
  #   c           LIKE glaq_t.glaq004,
  #   qty         LIKE glaq_t.glaq008,
  #   sum         LIKE glaq_t.glaq010,
  #   glaq039     LIKE glaq_t.glaq039,
  #   glaq040     LIKE glaq_t.glaq040,
  #   glaq041     LIKE glaq_t.glaq041,
  #   glaq042     LIKE glaq_t.glaq042,
  #   glaq043     LIKE glaq_t.glaq043,
  #   glaq044     LIKE glaq_t.glaq044,
  #   seq         LIKE glaq_t.glaqseq,
  #   source      LIKE type_t.chr100,
  #   glaqseq     LIKE glaq_t.glaqseq,
  #   xrca039     LIKE xrca_t.xrca039,
  #   b_glaq021   LIKE glaq_t.glaq021,
  #   b_glaq022   LIKE glaq_t.glaq022,
  #   red         LIKE type_t.chr1       #红冲否(待抵单使用) #20150612 add lujh
  #);
  ##160727-00019#6  2016/07/29 By 08734     s_voucher_ar_group ——> s_voucher_tmp05
  #DROP TABLE s_voucher_tmp05;  
  ##160727-00019#6  2016/07/29 By 08734     s_voucher_ar_group ——> s_voucher_tmp05   
  #CREATE TEMP TABLE s_voucher_tmp05(   
  #   docno       LIKE glaq_t.glaqdocno,
  #   docdt       LIKE glap_t.glapdocdt,
  #   sw          LIKE type_t.chr1,
  #   glaqent     LIKE glaq_t.glaqent,
  #   glaqcomp    LIKE glaq_t.glaqcomp,
  #   glaqld      LIKE glaq_t.glaqld,
  #   glaq001     LIKE glaq_t.glaq001,
  #   glaq002     LIKE glaq_t.glaq002,
  #   glaq005     LIKE glaq_t.glaq005,
  #   glaq006     LIKE glaq_t.glaq006,
  #   glaq007     LIKE glaq_t.glaq007,
  #   glaq009     LIKE glaq_t.glaq009,
  #   glaq011     LIKE glaq_t.glaq011,
  #   glaq012     LIKE glaq_t.glaq012,
  #   glaq013     LIKE glaq_t.glaq013,
  #   glaq014     LIKE glaq_t.glaq014,
  #   glaq015     LIKE glaq_t.glaq015,
  #   glaq016     LIKE glaq_t.glaq016,
  #   glaq017     LIKE glaq_t.glaq017,
  #   glaq018     LIKE glaq_t.glaq018,
  #   glaq019     LIKE glaq_t.glaq019,
  #   glaq020     LIKE glaq_t.glaq020,
  #   glaq021     LIKE glaq_t.glaq021,
  #   glaq022     LIKE glaq_t.glaq022,
  #   glaq023     LIKE glaq_t.glaq023,
  #   glaq024     LIKE glaq_t.glaq024,
  #   glaq025     LIKE glaq_t.glaq025,
  #   glaq027     LIKE glaq_t.glaq027,
  #   glaq028     LIKE glaq_t.glaq028,
  #   glaq051     LIKE glaq_t.glaq051,  #經營方式
  #   glaq052     LIKE glaq_t.glaq052,  #渠道
  #   glaq053     LIKE glaq_t.glaq053,  #品牌
  #   glaq029     LIKE glaq_t.glaq029,
  #   glaq030     LIKE glaq_t.glaq030,
  #   glaq031     LIKE glaq_t.glaq031,
  #   glaq032     LIKE glaq_t.glaq032,
  #   glaq033     LIKE glaq_t.glaq033,
  #   glaq034     LIKE glaq_t.glaq034,
  #   glaq035     LIKE glaq_t.glaq035,
  #   glaq036     LIKE glaq_t.glaq036,
  #   glaq037     LIKE glaq_t.glaq037,
  #   glaq038     LIKE glaq_t.glaq038,
  #   glbc004     LIKE glbc_t.glbc004,  #现金变动码
  #   d           LIKE glaq_t.glaq003,
  #   c           LIKE glaq_t.glaq004,
  #   qty         LIKE glaq_t.glaq008,
  #   sum         LIKE glaq_t.glaq010,
  #   glaq039     LIKE glaq_t.glaq039,
  #   glaq040     LIKE glaq_t.glaq040,
  #   glaq041     LIKE glaq_t.glaq041,
  #   glaq042     LIKE glaq_t.glaq042,
  #   glaq043     LIKE glaq_t.glaq043,
  #   glaq044     LIKE glaq_t.glaq044,
  #   seq         LIKE glaq_t.glaqseq,
  #   source      LIKE type_t.chr100,
  #   glaqseq     LIKE glaq_t.glaqseq,
  #   xrca039     LIKE xrca_t.xrca039,
  #   b_glaq021   LIKE glaq_t.glaq021,
  #   b_glaq022   LIKE glaq_t.glaq022,
  #   red         LIKE type_t.chr1       #红冲否(待抵单使用) #20150612 add lujh
  #);
  #
  #DROP TABLE s_voucher_glbc;
  #CREATE TEMP TABLE s_voucher_glbc(
  #   glbcent    LIKE glbc_t.glbcent,
  #   glbcld     LIKE glbc_t.glbcld,
  #   glbccomp   LIKE glbc_t.glbccomp,
  #   glbcdocno  LIKE glbc_t.glbcdocno,
  #   glbcseq    LIKE glbc_t.glbcseq,
  #   glbc001    LIKE glbc_t.glbc001,
  #   glbc002    LIKE glbc_t.glbc002,
  #   glbc003    LIKE glbc_t.glbc003,
  #   glbc004    LIKE glbc_t.glbc004,
  #   glbc005    LIKE glbc_t.glbc005,
  #   glbc006    LIKE glbc_t.glbc006,
  #   glbc007    LIKE glbc_t.glbc007,
  #   glbc008    LIKE glbc_t.glbc008,
  #   glbc009    LIKE glbc_t.glbc009,
  #   glbc010    LIKE glbc_t.glbc010,
  #   glbc011    LIKE glbc_t.glbc011,
  #   glbc012    LIKE glbc_t.glbc012,
  #   glbc013    LIKE glbc_t.glbc013,
  #   glbc014    LIKE glbc_t.glbc014,
  #   xrdadocno  LIKE xrda_t.xrdadocno
  #)
  #160802-00006#1 Mark ---(E)---
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
PRIVATE FUNCTION axrp400_ins_xrce(p_nmbb026)
   DEFINE p_nmbb026        LIKE nmbb_t.nmbb026
   DEFINE l_nmbbdocno      LIKE nmbb_t.nmbbdocno
   DEFINE l_nmbbseq        LIKE nmbb_t.nmbbseq
  #DEFINE l_nmba           RECORD LIKE nmba_t.* #161219-00014#2 mark
   #161219-00014#2--add--s--
   DEFINE l_nmba RECORD  #銀存收支主檔
       nmbaent LIKE nmba_t.nmbaent, #企业编号
       nmbaownid LIKE nmba_t.nmbaownid, #资料所有者
       nmbaowndp LIKE nmba_t.nmbaowndp, #资料所有部门
       nmbacrtid LIKE nmba_t.nmbacrtid, #资料录入者
       nmbacrtdp LIKE nmba_t.nmbacrtdp, #资料录入部门
       nmbacrtdt LIKE nmba_t.nmbacrtdt, #资料创建日
       nmbamodid LIKE nmba_t.nmbamodid, #资料更改者
       nmbamoddt LIKE nmba_t.nmbamoddt, #最近更改日
       nmbacnfid LIKE nmba_t.nmbacnfid, #资料审核者
       nmbacnfdt LIKE nmba_t.nmbacnfdt, #数据审核日
       nmbastus LIKE nmba_t.nmbastus, #审核码
       nmbacomp LIKE nmba_t.nmbacomp, #法人
       nmbadocno LIKE nmba_t.nmbadocno, #收支单号
       nmbadocdt LIKE nmba_t.nmbadocdt, #收支日期
       nmbasite LIKE nmba_t.nmbasite, #资金中心
       nmba001 LIKE nmba_t.nmba001, #缴款部门
       nmba002 LIKE nmba_t.nmba002, #账务人员
       nmba003 LIKE nmba_t.nmba003, #来源作业类型
       nmba004 LIKE nmba_t.nmba004, #交易对象
       nmba005 LIKE nmba_t.nmba005, #一次性交易对象识别码
       nmba006 LIKE nmba_t.nmba006, #暂收否
       nmba007 LIKE nmba_t.nmba007, #账务单号
       nmba008 LIKE nmba_t.nmba008, #缴款人员
       nmba009 LIKE nmba_t.nmba009, #核准日期
       nmba010 LIKE nmba_t.nmba010, #账套二账务单号
       nmba011 LIKE nmba_t.nmba011, #账套三账务单号
       nmbaud001 LIKE nmba_t.nmbaud001, #自定义字段(文本)001
       nmbaud002 LIKE nmba_t.nmbaud002, #自定义字段(文本)002
       nmbaud003 LIKE nmba_t.nmbaud003, #自定义字段(文本)003
       nmbaud004 LIKE nmba_t.nmbaud004, #自定义字段(文本)004
       nmbaud005 LIKE nmba_t.nmbaud005, #自定义字段(文本)005
       nmbaud006 LIKE nmba_t.nmbaud006, #自定义字段(文本)006
       nmbaud007 LIKE nmba_t.nmbaud007, #自定义字段(文本)007
       nmbaud008 LIKE nmba_t.nmbaud008, #自定义字段(文本)008
       nmbaud009 LIKE nmba_t.nmbaud009, #自定义字段(文本)009
       nmbaud010 LIKE nmba_t.nmbaud010, #自定义字段(文本)010
       nmbaud011 LIKE nmba_t.nmbaud011, #自定义字段(数字)011
       nmbaud012 LIKE nmba_t.nmbaud012, #自定义字段(数字)012
       nmbaud013 LIKE nmba_t.nmbaud013, #自定义字段(数字)013
       nmbaud014 LIKE nmba_t.nmbaud014, #自定义字段(数字)014
       nmbaud015 LIKE nmba_t.nmbaud015, #自定义字段(数字)015
       nmbaud016 LIKE nmba_t.nmbaud016, #自定义字段(数字)016
       nmbaud017 LIKE nmba_t.nmbaud017, #自定义字段(数字)017
       nmbaud018 LIKE nmba_t.nmbaud018, #自定义字段(数字)018
       nmbaud019 LIKE nmba_t.nmbaud019, #自定义字段(数字)019
       nmbaud020 LIKE nmba_t.nmbaud020, #自定义字段(数字)020
       nmbaud021 LIKE nmba_t.nmbaud021, #自定义字段(日期时间)021
       nmbaud022 LIKE nmba_t.nmbaud022, #自定义字段(日期时间)022
       nmbaud023 LIKE nmba_t.nmbaud023, #自定义字段(日期时间)023
       nmbaud024 LIKE nmba_t.nmbaud024, #自定义字段(日期时间)024
       nmbaud025 LIKE nmba_t.nmbaud025, #自定义字段(日期时间)025
       nmbaud026 LIKE nmba_t.nmbaud026, #自定义字段(日期时间)026
       nmbaud027 LIKE nmba_t.nmbaud027, #自定义字段(日期时间)027
       nmbaud028 LIKE nmba_t.nmbaud028, #自定义字段(日期时间)028
       nmbaud029 LIKE nmba_t.nmbaud029, #自定义字段(日期时间)029
       nmbaud030 LIKE nmba_t.nmbaud030, #自定义字段(日期时间)030
       nmba012 LIKE nmba_t.nmba012, #立账否(for流通)
       nmba013 LIKE nmba_t.nmba013, #起始日期
       nmba014 LIKE nmba_t.nmba014, #截止日期
       nmba015 LIKE nmba_t.nmba015  #往来据点
       END RECORD
   #161219-00014#2--add--e--
   #DEFINE l_nmbb           RECORD LIKE nmbb_t.* #161219-00014#2 mark
   #161219-00014#2--add--s--
   DEFINE l_nmbb RECORD  #銀存收支明細檔
       nmbbent LIKE nmbb_t.nmbbent, #企业编号
       nmbbcomp LIKE nmbb_t.nmbbcomp, #法人
       nmbbdocno LIKE nmbb_t.nmbbdocno, #收支单号
       nmbbseq LIKE nmbb_t.nmbbseq, #项次
       nmbborga LIKE nmbb_t.nmbborga, #来源组织
       nmbblegl LIKE nmbb_t.nmbblegl, #核算组织
       nmbb001 LIKE nmbb_t.nmbb001, #异动别
       nmbb002 LIKE nmbb_t.nmbb002, #存提码
       nmbb003 LIKE nmbb_t.nmbb003, #交易账户编码
       nmbb004 LIKE nmbb_t.nmbb004, #币种
       nmbb005 LIKE nmbb_t.nmbb005, #汇率
       nmbb006 LIKE nmbb_t.nmbb006, #主账套原币金额
       nmbb007 LIKE nmbb_t.nmbb007, #主账套本币金额
       nmbb008 LIKE nmbb_t.nmbb008, #主账套已冲原币金额
       nmbb009 LIKE nmbb_t.nmbb009, #主账套已冲本币金额
       nmbb010 LIKE nmbb_t.nmbb010, #现金变动码
       nmbb011 LIKE nmbb_t.nmbb011, #本位币二币种
       nmbb012 LIKE nmbb_t.nmbb012, #本位币二汇率
       nmbb013 LIKE nmbb_t.nmbb013, #本位币二金额
       nmbb014 LIKE nmbb_t.nmbb014, #本位币二已冲金额
       nmbb015 LIKE nmbb_t.nmbb015, #本位币三币种
       nmbb016 LIKE nmbb_t.nmbb016, #本位币三汇率
       nmbb017 LIKE nmbb_t.nmbb017, #本位币三金额
       nmbb018 LIKE nmbb_t.nmbb018, #本位币三已冲金额
       nmbb019 LIKE nmbb_t.nmbb019, #辅助账套一汇率
       nmbb020 LIKE nmbb_t.nmbb020, #辅助账套一原币已冲
       nmbb021 LIKE nmbb_t.nmbb021, #辅助账套一本币已冲
       nmbb022 LIKE nmbb_t.nmbb022, #辅助账套二汇率
       nmbb023 LIKE nmbb_t.nmbb023, #辅助账套二原币已冲
       nmbb024 LIKE nmbb_t.nmbb024, #辅助账套二本币已冲
       nmbb025 LIKE nmbb_t.nmbb025, #备注
       nmbb026 LIKE nmbb_t.nmbb026, #交易对象
       nmbb027 LIKE nmbb_t.nmbb027, #一次性交易对象识别码
       nmbb028 LIKE nmbb_t.nmbb028, #款别编码
       nmbb029 LIKE nmbb_t.nmbb029, #款别分类
       nmbb030 LIKE nmbb_t.nmbb030, #票据号码
       nmbb031 LIKE nmbb_t.nmbb031, #到期日
       nmbb032 LIKE nmbb_t.nmbb032, #有价券数量
       nmbb033 LIKE nmbb_t.nmbb033, #有价券面额
       nmbb034 LIKE nmbb_t.nmbb034, #有价券起始编号
       nmbb035 LIKE nmbb_t.nmbb035, #有价券结束编号
       nmbb036 LIKE nmbb_t.nmbb036, #刷卡银行
       nmbb037 LIKE nmbb_t.nmbb037, #信用卡卡号
       nmbb038 LIKE nmbb_t.nmbb038, #手续费
       nmbb039 LIKE nmbb_t.nmbb039, #第三方代收机构
       nmbb040 LIKE nmbb_t.nmbb040, #背书转入
       nmbb041 LIKE nmbb_t.nmbb041, #发票人全名
       nmbb042 LIKE nmbb_t.nmbb042, #票况
       nmbb043 LIKE nmbb_t.nmbb043, #票据付款银行
       nmbb044 LIKE nmbb_t.nmbb044, #票面利率种类
       nmbb045 LIKE nmbb_t.nmbb045, #票面利率百分比
       nmbb046 LIKE nmbb_t.nmbb046, #转付交易对象
       nmbb047 LIKE nmbb_t.nmbb047, #票据流通期间
       nmbb048 LIKE nmbb_t.nmbb048, #贴现利率种类
       nmbb049 LIKE nmbb_t.nmbb049, #贴现利率
       nmbb050 LIKE nmbb_t.nmbb050, #贴现期间
       nmbb051 LIKE nmbb_t.nmbb051, #贴现拨款原币金额
       nmbb052 LIKE nmbb_t.nmbb052, #贴现拨款本币金额
       nmbb053 LIKE nmbb_t.nmbb053, #缴款人员
       nmbb054 LIKE nmbb_t.nmbb054, #缴款部门
       nmbb055 LIKE nmbb_t.nmbb055, #POS缴款单号
       nmbb056 LIKE nmbb_t.nmbb056, #入账汇率
       nmbb057 LIKE nmbb_t.nmbb057, #入账原币金额
       nmbb058 LIKE nmbb_t.nmbb058, #入账主账套本币金额
       nmbb059 LIKE nmbb_t.nmbb059, #入账主账套本位币二汇率
       nmbb060 LIKE nmbb_t.nmbb060, #入账主账套本位币二金额
       nmbb061 LIKE nmbb_t.nmbb061, #入账主账套本位币三汇率
       nmbb062 LIKE nmbb_t.nmbb062, #入账主账套本位币三金额
       nmbb063 LIKE nmbb_t.nmbb063, #对方会科
       nmbb064 LIKE nmbb_t.nmbb064, #差异处理状态
       nmbb065 LIKE nmbb_t.nmbb065, #开票日期
       nmbb066 LIKE nmbb_t.nmbb066, #重评后本币金额
       nmbb067 LIKE nmbb_t.nmbb067, #重评后本位币二金额
       nmbb068 LIKE nmbb_t.nmbb068, #重评后本位币三金额
       nmbb069 LIKE nmbb_t.nmbb069, #质押否
       nmbbud001 LIKE nmbb_t.nmbbud001, #自定义字段(文本)001
       nmbbud002 LIKE nmbb_t.nmbbud002, #自定义字段(文本)002
       nmbbud003 LIKE nmbb_t.nmbbud003, #自定义字段(文本)003
       nmbbud004 LIKE nmbb_t.nmbbud004, #自定义字段(文本)004
       nmbbud005 LIKE nmbb_t.nmbbud005, #自定义字段(文本)005
       nmbbud006 LIKE nmbb_t.nmbbud006, #自定义字段(文本)006
       nmbbud007 LIKE nmbb_t.nmbbud007, #自定义字段(文本)007
       nmbbud008 LIKE nmbb_t.nmbbud008, #自定义字段(文本)008
       nmbbud009 LIKE nmbb_t.nmbbud009, #自定义字段(文本)009
       nmbbud010 LIKE nmbb_t.nmbbud010, #自定义字段(文本)010
       nmbbud011 LIKE nmbb_t.nmbbud011, #自定义字段(数字)011
       nmbbud012 LIKE nmbb_t.nmbbud012, #自定义字段(数字)012
       nmbbud013 LIKE nmbb_t.nmbbud013, #自定义字段(数字)013
       nmbbud014 LIKE nmbb_t.nmbbud014, #自定义字段(数字)014
       nmbbud015 LIKE nmbb_t.nmbbud015, #自定义字段(数字)015
       nmbbud016 LIKE nmbb_t.nmbbud016, #自定义字段(数字)016
       nmbbud017 LIKE nmbb_t.nmbbud017, #自定义字段(数字)017
       nmbbud018 LIKE nmbb_t.nmbbud018, #自定义字段(数字)018
       nmbbud019 LIKE nmbb_t.nmbbud019, #自定义字段(数字)019
       nmbbud020 LIKE nmbb_t.nmbbud020, #自定义字段(数字)020
       nmbbud021 LIKE nmbb_t.nmbbud021, #自定义字段(日期时间)021
       nmbbud022 LIKE nmbb_t.nmbbud022, #自定义字段(日期时间)022
       nmbbud023 LIKE nmbb_t.nmbbud023, #自定义字段(日期时间)023
       nmbbud024 LIKE nmbb_t.nmbbud024, #自定义字段(日期时间)024
       nmbbud025 LIKE nmbb_t.nmbbud025, #自定义字段(日期时间)025
       nmbbud026 LIKE nmbb_t.nmbbud026, #自定义字段(日期时间)026
       nmbbud027 LIKE nmbb_t.nmbbud027, #自定义字段(日期时间)027
       nmbbud028 LIKE nmbb_t.nmbbud028, #自定义字段(日期时间)028
       nmbbud029 LIKE nmbb_t.nmbbud029, #自定义字段(日期时间)029
       nmbbud030 LIKE nmbb_t.nmbbud030, #自定义字段(日期时间)030
       nmbb070 LIKE nmbb_t.nmbb070, #往来据点
       nmbb071 LIKE nmbb_t.nmbb071, #来源单号
       nmbb072 LIKE nmbb_t.nmbb072, #项次
       nmbb073 LIKE nmbb_t.nmbb073  #开票帐号
       END RECORD
   #161219-00014#2--add--e--
  #DEFINE l_xrca           RECORD LIKE xrca_t.* #161219-00014#2 mark
   #161219-00014#2--add--s--
   DEFINE l_xrca RECORD  #應收憑單單頭
       xrcaent LIKE xrca_t.xrcaent, #企业编号
       xrcaownid LIKE xrca_t.xrcaownid, #资料所有者
       xrcaowndp LIKE xrca_t.xrcaowndp, #资料所有部门
       xrcacrtid LIKE xrca_t.xrcacrtid, #资料录入者
       xrcacrtdp LIKE xrca_t.xrcacrtdp, #资料录入部门
       xrcacrtdt LIKE xrca_t.xrcacrtdt, #资料创建日
       xrcamodid LIKE xrca_t.xrcamodid, #资料更改者
       xrcamoddt LIKE xrca_t.xrcamoddt, #最近更改日
       xrcacnfid LIKE xrca_t.xrcacnfid, #资料审核者
       xrcacnfdt LIKE xrca_t.xrcacnfdt, #数据审核日
       xrcapstid LIKE xrca_t.xrcapstid, #资料过账者
       xrcapstdt LIKE xrca_t.xrcapstdt, #资料过账日
       xrcastus LIKE xrca_t.xrcastus, #状态码
       xrcacomp LIKE xrca_t.xrcacomp, #法人
       xrcald LIKE xrca_t.xrcald, #账套
       xrcadocno LIKE xrca_t.xrcadocno, #売掛金番号
       xrcadocdt LIKE xrca_t.xrcadocdt, #账款日期
       xrca001 LIKE xrca_t.xrca001, #账款单性质
       xrcasite LIKE xrca_t.xrcasite, #账务中心
       xrca003 LIKE xrca_t.xrca003, #账务人员
       xrca004 LIKE xrca_t.xrca004, #账款客户编号
       xrca005 LIKE xrca_t.xrca005, #收款客户
       xrca006 LIKE xrca_t.xrca006, #客户分类
       xrca007 LIKE xrca_t.xrca007, #账款类别
       xrca008 LIKE xrca_t.xrca008, #收款条件编号
       xrca009 LIKE xrca_t.xrca009, #应收款日/应扣抵日
       xrca010 LIKE xrca_t.xrca010, #容许票据到期日
       xrca011 LIKE xrca_t.xrca011, #税种
       xrca012 LIKE xrca_t.xrca012, #税率
       xrca013 LIKE xrca_t.xrca013, #含税否
       xrca014 LIKE xrca_t.xrca014, #人员编号
       xrca015 LIKE xrca_t.xrca015, #部门编号
       xrca016 LIKE xrca_t.xrca016, #来源作业类型
       xrca017 LIKE xrca_t.xrca017, #生成方式
       xrca018 LIKE xrca_t.xrca018, #来源参考单号
       xrca019 LIKE xrca_t.xrca019, #系统生成对应单号(待抵账款-预收)
       xrca020 LIKE xrca_t.xrca020, #信用状申请流程否
       xrca021 LIKE xrca_t.xrca021, #商业发票号码(IV no.)
       xrca022 LIKE xrca_t.xrca022, #出口报单号码
       xrca023 LIKE xrca_t.xrca023, #发票客户编号
       xrca024 LIKE xrca_t.xrca024, #发票客户税号
       xrca025 LIKE xrca_t.xrca025, #发票客户全名
       xrca026 LIKE xrca_t.xrca026, #发票客户地址
       xrca028 LIKE xrca_t.xrca028, #发票类型
       xrca029 LIKE xrca_t.xrca029, #发票汇率
       xrca030 LIKE xrca_t.xrca030, #发票应开税前金额
       xrca031 LIKE xrca_t.xrca031, #发票应开税额
       xrca032 LIKE xrca_t.xrca032, #发票应开含税金额
       xrca033 LIKE xrca_t.xrca033, #项目编号
       xrca034 LIKE xrca_t.xrca034, #责任中心
       xrca035 LIKE xrca_t.xrca035, #应收(借方)科目编号
       xrca036 LIKE xrca_t.xrca036, #收入(贷方)科目编号
       xrca037 LIKE xrca_t.xrca037, #分录凭证生成否
       xrca038 LIKE xrca_t.xrca038, #抛转凭证号码
       xrca039 LIKE xrca_t.xrca039, #会计检核附件份数
       xrca040 LIKE xrca_t.xrca040, #留置否
       xrca041 LIKE xrca_t.xrca041, #留置理由码
       xrca042 LIKE xrca_t.xrca042, #留置设置日期
       xrca043 LIKE xrca_t.xrca043, #留置解除日期
       xrca044 LIKE xrca_t.xrca044, #留置原币金额
       xrca045 LIKE xrca_t.xrca045, #留置说明
       xrca046 LIKE xrca_t.xrca046, #关系人否
       xrca047 LIKE xrca_t.xrca047, #多角序号
       xrca048 LIKE xrca_t.xrca048, #集团代收/代付单号
       xrca049 LIKE xrca_t.xrca049, #来源营运中心编号
       xrca050 LIKE xrca_t.xrca050, #交易原始单据份数
       xrca051 LIKE xrca_t.xrca051, #作废理由码
       xrca052 LIKE xrca_t.xrca052, #打印次数
       xrca053 LIKE xrca_t.xrca053, #备注
       xrca054 LIKE xrca_t.xrca054, #多账期设置
       xrca055 LIKE xrca_t.xrca055, #缴款优惠条件
       xrca056 LIKE xrca_t.xrca056, #会计检核附件状态
       xrca057 LIKE xrca_t.xrca057, #交易对象识别码
       xrca058 LIKE xrca_t.xrca058, #销售分类
       xrca059 LIKE xrca_t.xrca059, #预算编号
       xrca060 LIKE xrca_t.xrca060, #发票开立原则
       xrca061 LIKE xrca_t.xrca061, #预计开立发票日期
       xrca062 LIKE xrca_t.xrca062, #多角性质
       xrca063 LIKE xrca_t.xrca063, #整账批序号
       xrca064 LIKE xrca_t.xrca064, #订金序次
       xrca065 LIKE xrca_t.xrca065, #发票编号
       xrca066 LIKE xrca_t.xrca066, #发票号码
       xrca100 LIKE xrca_t.xrca100, #交易原币种
       xrca101 LIKE xrca_t.xrca101, #原币汇率
       xrca103 LIKE xrca_t.xrca103, #原币税前金额
       xrca104 LIKE xrca_t.xrca104, #原币税额
       xrca106 LIKE xrca_t.xrca106, #原币直接折抵合计金额
       xrca107 LIKE xrca_t.xrca107, #原币直接冲账(调整)合计金额
       xrca108 LIKE xrca_t.xrca108, #原币应收金额
       xrca113 LIKE xrca_t.xrca113, #本币税前金额
       xrca114 LIKE xrca_t.xrca114, #本币税额
       xrca116 LIKE xrca_t.xrca116, #本币直接冲账(调整)合计金额
       xrca117 LIKE xrca_t.xrca117, #本币直接冲账(调整)合计金额
       xrca118 LIKE xrca_t.xrca118, #本币应收金额
       xrca120 LIKE xrca_t.xrca120, #本位币二币种
       xrca121 LIKE xrca_t.xrca121, #本位币二汇率
       xrca123 LIKE xrca_t.xrca123, #本位币二税前金额
       xrca124 LIKE xrca_t.xrca124, #本位币二税额
       xrca126 LIKE xrca_t.xrca126, #本位币二直接折抵合计金额
       xrca127 LIKE xrca_t.xrca127, #本位币二直接冲账(调整)合计金额
       xrca128 LIKE xrca_t.xrca128, #本位币二应收金额
       xrca130 LIKE xrca_t.xrca130, #本位币三币种
       xrca131 LIKE xrca_t.xrca131, #本位币三汇率
       xrca133 LIKE xrca_t.xrca133, #本位币三税前金额
       xrca134 LIKE xrca_t.xrca134, #本位币三税额
       xrca136 LIKE xrca_t.xrca136, #本位币三直接折抵合计金额
       xrca137 LIKE xrca_t.xrca137, #本位币三直接冲账(调整)合计金额
       xrca138 LIKE xrca_t.xrca138, #本位币三应收金额
       xrcaud001 LIKE xrca_t.xrcaud001, #自定义字段(文本)001
       xrcaud002 LIKE xrca_t.xrcaud002, #自定义字段(文本)002
       xrcaud003 LIKE xrca_t.xrcaud003, #自定义字段(文本)003
       xrcaud004 LIKE xrca_t.xrcaud004, #自定义字段(文本)004
       xrcaud005 LIKE xrca_t.xrcaud005, #自定义字段(文本)005
       xrcaud006 LIKE xrca_t.xrcaud006, #自定义字段(文本)006
       xrcaud007 LIKE xrca_t.xrcaud007, #自定义字段(文本)007
       xrcaud008 LIKE xrca_t.xrcaud008, #自定义字段(文本)008
       xrcaud009 LIKE xrca_t.xrcaud009, #自定义字段(文本)009
       xrcaud010 LIKE xrca_t.xrcaud010, #自定义字段(文本)010
       xrcaud011 LIKE xrca_t.xrcaud011, #自定义字段(数字)011
       xrcaud012 LIKE xrca_t.xrcaud012, #自定义字段(数字)012
       xrcaud013 LIKE xrca_t.xrcaud013, #自定义字段(数字)013
       xrcaud014 LIKE xrca_t.xrcaud014, #自定义字段(数字)014
       xrcaud015 LIKE xrca_t.xrcaud015, #自定义字段(数字)015
       xrcaud016 LIKE xrca_t.xrcaud016, #自定义字段(数字)016
       xrcaud017 LIKE xrca_t.xrcaud017, #自定义字段(数字)017
       xrcaud018 LIKE xrca_t.xrcaud018, #自定义字段(数字)018
       xrcaud019 LIKE xrca_t.xrcaud019, #自定义字段(数字)019
       xrcaud020 LIKE xrca_t.xrcaud020, #自定义字段(数字)020
       xrcaud021 LIKE xrca_t.xrcaud021, #自定义字段(日期时间)021
       xrcaud022 LIKE xrca_t.xrcaud022, #自定义字段(日期时间)022
       xrcaud023 LIKE xrca_t.xrcaud023, #自定义字段(日期时间)023
       xrcaud024 LIKE xrca_t.xrcaud024, #自定义字段(日期时间)024
       xrcaud025 LIKE xrca_t.xrcaud025, #自定义字段(日期时间)025
       xrcaud026 LIKE xrca_t.xrcaud026, #自定义字段(日期时间)026
       xrcaud027 LIKE xrca_t.xrcaud027, #自定义字段(日期时间)027
       xrcaud028 LIKE xrca_t.xrcaud028, #自定义字段(日期时间)028
       xrcaud029 LIKE xrca_t.xrcaud029, #自定义字段(日期时间)029
       xrcaud030 LIKE xrca_t.xrcaud030  #自定义字段(日期时间)030
       END RECORD
   #161219-00014#2--add--e--
   #DEFINE l_xrcb           RECORD LIKE xrcb_t.* #161219-00014#2 mark
   #161219-00014#2--add--s--
   DEFINE l_xrcb RECORD  #應收憑單單身
       xrcbent LIKE xrcb_t.xrcbent, #企业编号
       xrcbld LIKE xrcb_t.xrcbld, #账套
       xrcbdocno LIKE xrcb_t.xrcbdocno, #单号
       xrcbseq LIKE xrcb_t.xrcbseq, #项次
       xrcbsite LIKE xrcb_t.xrcbsite, #营运据点
       xrcborga LIKE xrcb_t.xrcborga, #账务来源SITE
       xrcb001 LIKE xrcb_t.xrcb001, #来源类型
       xrcb002 LIKE xrcb_t.xrcb002, #来源业务单据号码
       xrcb003 LIKE xrcb_t.xrcb003, #来源业务单据项次
       xrcb004 LIKE xrcb_t.xrcb004, #产品编号
       xrcb005 LIKE xrcb_t.xrcb005, #品名规格
       xrcb006 LIKE xrcb_t.xrcb006, #单位
       xrcb007 LIKE xrcb_t.xrcb007, #计价数量
       xrcb008 LIKE xrcb_t.xrcb008, #参考单据号码
       xrcb009 LIKE xrcb_t.xrcb009, #参考单号项次
       xrcblegl LIKE xrcb_t.xrcblegl, #核算组织
       xrcb010 LIKE xrcb_t.xrcb010, #业务部门
       xrcb011 LIKE xrcb_t.xrcb011, #责任中心
       xrcb012 LIKE xrcb_t.xrcb012, #产品类别
       xrcb013 LIKE xrcb_t.xrcb013, #发票账否(搭赠/备品/样品)
       xrcb014 LIKE xrcb_t.xrcb014, #理由码
       xrcb015 LIKE xrcb_t.xrcb015, #项目编号
       xrcb016 LIKE xrcb_t.xrcb016, #WBS编号
       xrcb017 LIKE xrcb_t.xrcb017, #预算细项
       xrcb018 LIKE xrcb_t.xrcb018, #商户编号
       xrcb019 LIKE xrcb_t.xrcb019, #开票性质
       xrcb020 LIKE xrcb_t.xrcb020, #税种
       xrcb021 LIKE xrcb_t.xrcb021, #收入会计科目
       xrcb022 LIKE xrcb_t.xrcb022, #正负值
       xrcb023 LIKE xrcb_t.xrcb023, #冲暂估单否
       xrcb024 LIKE xrcb_t.xrcb024, #区域
       xrcb025 LIKE xrcb_t.xrcb025, #凭证号码
       xrcb026 LIKE xrcb_t.xrcb026, #凭证项次
       xrcb027 LIKE xrcb_t.xrcb027, #发票编号
       xrcb028 LIKE xrcb_t.xrcb028, #发票号码
       xrcb029 LIKE xrcb_t.xrcb029, #应收账款科目
       xrcb030 LIKE xrcb_t.xrcb030, #已开发票数量
       xrcb031 LIKE xrcb_t.xrcb031, #收款条件编号
       xrcb032 LIKE xrcb_t.xrcb032, #订金序次
       xrcb033 LIKE xrcb_t.xrcb033, #经营方式
       xrcb034 LIKE xrcb_t.xrcb034, #渠道
       xrcb035 LIKE xrcb_t.xrcb035, #品牌
       xrcb036 LIKE xrcb_t.xrcb036, #客群
       xrcb037 LIKE xrcb_t.xrcb037, #自由核算项一
       xrcb038 LIKE xrcb_t.xrcb038, #自由核算项二
       xrcb039 LIKE xrcb_t.xrcb039, #自由核算项三
       xrcb040 LIKE xrcb_t.xrcb040, #自由核算项四
       xrcb041 LIKE xrcb_t.xrcb041, #自由核算项五
       xrcb042 LIKE xrcb_t.xrcb042, #自由核算项六
       xrcb043 LIKE xrcb_t.xrcb043, #自由核算项七
       xrcb044 LIKE xrcb_t.xrcb044, #自由核算项八
       xrcb045 LIKE xrcb_t.xrcb045, #自由核算项九
       xrcb046 LIKE xrcb_t.xrcb046, #自由核算项十
       xrcb047 LIKE xrcb_t.xrcb047, #摘要
       xrcb048 LIKE xrcb_t.xrcb048, #客户订购单号
       xrcb049 LIKE xrcb_t.xrcb049, #开票单号
       xrcb050 LIKE xrcb_t.xrcb050, #开票项次
       xrcb051 LIKE xrcb_t.xrcb051, #业务人员
       xrcb100 LIKE xrcb_t.xrcb100, #交易原币
       xrcb101 LIKE xrcb_t.xrcb101, #交易原币单价
       xrcb102 LIKE xrcb_t.xrcb102, #交易汇率
       xrcb103 LIKE xrcb_t.xrcb103, #交易原币税前金额
       xrcb104 LIKE xrcb_t.xrcb104, #交易原币税额
       xrcb105 LIKE xrcb_t.xrcb105, #交易原币含税金额
       xrcb106 LIKE xrcb_t.xrcb106, #交易原币调整差异金额
       xrcb111 LIKE xrcb_t.xrcb111, #本币单价
       xrcb113 LIKE xrcb_t.xrcb113, #本币税前金额
       xrcb114 LIKE xrcb_t.xrcb114, #本币税额
       xrcb115 LIKE xrcb_t.xrcb115, #本币含税金额
       xrcb116 LIKE xrcb_t.xrcb116, #本币调整差异金额
       xrcb117 LIKE xrcb_t.xrcb117, #已开发票金额(税前)
       xrcb118 LIKE xrcb_t.xrcb118, #应开发票税前金额
       xrcb119 LIKE xrcb_t.xrcb119, #应开发票含税金额
       xrcb121 LIKE xrcb_t.xrcb121, #本位币二汇率
       xrcb123 LIKE xrcb_t.xrcb123, #本位币二税前金额
       xrcb124 LIKE xrcb_t.xrcb124, #本位币二税额
       xrcb125 LIKE xrcb_t.xrcb125, #本位币二含税金额
       xrcb126 LIKE xrcb_t.xrcb126, #本位币二调整差异金额
       xrcb131 LIKE xrcb_t.xrcb131, #本位币三汇率
       xrcb133 LIKE xrcb_t.xrcb133, #本位币三税前金额
       xrcb134 LIKE xrcb_t.xrcb134, #本位币三税额
       xrcb135 LIKE xrcb_t.xrcb135, #本位币三含税金额
       xrcb136 LIKE xrcb_t.xrcb136, #本位币三调整差异金额
       xrcbud001 LIKE xrcb_t.xrcbud001, #自定义字段(文本)001
       xrcbud002 LIKE xrcb_t.xrcbud002, #自定义字段(文本)002
       xrcbud003 LIKE xrcb_t.xrcbud003, #自定义字段(文本)003
       xrcbud004 LIKE xrcb_t.xrcbud004, #自定义字段(文本)004
       xrcbud005 LIKE xrcb_t.xrcbud005, #自定义字段(文本)005
       xrcbud006 LIKE xrcb_t.xrcbud006, #自定义字段(文本)006
       xrcbud007 LIKE xrcb_t.xrcbud007, #自定义字段(文本)007
       xrcbud008 LIKE xrcb_t.xrcbud008, #自定义字段(文本)008
       xrcbud009 LIKE xrcb_t.xrcbud009, #自定义字段(文本)009
       xrcbud010 LIKE xrcb_t.xrcbud010, #自定义字段(文本)010
       xrcbud011 LIKE xrcb_t.xrcbud011, #自定义字段(数字)011
       xrcbud012 LIKE xrcb_t.xrcbud012, #自定义字段(数字)012
       xrcbud013 LIKE xrcb_t.xrcbud013, #自定义字段(数字)013
       xrcbud014 LIKE xrcb_t.xrcbud014, #自定义字段(数字)014
       xrcbud015 LIKE xrcb_t.xrcbud015, #自定义字段(数字)015
       xrcbud016 LIKE xrcb_t.xrcbud016, #自定义字段(数字)016
       xrcbud017 LIKE xrcb_t.xrcbud017, #自定义字段(数字)017
       xrcbud018 LIKE xrcb_t.xrcbud018, #自定义字段(数字)018
       xrcbud019 LIKE xrcb_t.xrcbud019, #自定义字段(数字)019
       xrcbud020 LIKE xrcb_t.xrcbud020, #自定义字段(数字)020
       xrcbud021 LIKE xrcb_t.xrcbud021, #自定义字段(日期时间)021
       xrcbud022 LIKE xrcb_t.xrcbud022, #自定义字段(日期时间)022
       xrcbud023 LIKE xrcb_t.xrcbud023, #自定义字段(日期时间)023
       xrcbud024 LIKE xrcb_t.xrcbud024, #自定义字段(日期时间)024
       xrcbud025 LIKE xrcb_t.xrcbud025, #自定义字段(日期时间)025
       xrcbud026 LIKE xrcb_t.xrcbud026, #自定义字段(日期时间)026
       xrcbud027 LIKE xrcb_t.xrcbud027, #自定义字段(日期时间)027
       xrcbud028 LIKE xrcb_t.xrcbud028, #自定义字段(日期时间)028
       xrcbud029 LIKE xrcb_t.xrcbud029, #自定义字段(日期时间)029
       xrcbud030 LIKE xrcb_t.xrcbud030, #自定义字段(日期时间)030
       xrcb052 LIKE xrcb_t.xrcb052, #款别编号
       xrcb053 LIKE xrcb_t.xrcb053, #账款对象
       xrcb054 LIKE xrcb_t.xrcb054, #收款对象
       xrcb055 LIKE xrcb_t.xrcb055, #收现金额(流通)
       xrcb056 LIKE xrcb_t.xrcb056, #应收金额(流通)
       xrcb057 LIKE xrcb_t.xrcb057, #扣款金额(流通)
       xrcb058 LIKE xrcb_t.xrcb058, #预收科目
       xrcb059 LIKE xrcb_t.xrcb059, #代收银科目
       xrcb060 LIKE xrcb_t.xrcb060, #月份类型
       xrcb107 LIKE xrcb_t.xrcb107  #出货单单价
       END RECORD
   #161219-00014#2--add--e--
   #DEFINE l_xrcc           RECORD LIKE xrcc_t.* #161219-00014#2 mark
   #161219-00014#2--add--s--
   DEFINE l_xrcc RECORD  #多帳期明細
       xrccent LIKE xrcc_t.xrccent, #企业编号
       xrccld LIKE xrcc_t.xrccld, #账套
       xrcccomp LIKE xrcc_t.xrcccomp, #法人
       xrccdocno LIKE xrcc_t.xrccdocno, #売掛金番号
       xrccseq LIKE xrcc_t.xrccseq, #项次
       xrcc001 LIKE xrcc_t.xrcc001, #期别
       xrcc002 LIKE xrcc_t.xrcc002, #应收收款类别
       xrcc003 LIKE xrcc_t.xrcc003, #应收款日
       xrcc004 LIKE xrcc_t.xrcc004, #容许票据到期日
       xrcc005 LIKE xrcc_t.xrcc005, #账款起算日
       xrcc006 LIKE xrcc_t.xrcc006, #正负值
       xrcclegl LIKE xrcc_t.xrcclegl, #核算组织
       xrcc008 LIKE xrcc_t.xrcc008, #发票编号
       xrcc009 LIKE xrcc_t.xrcc009, #发票号码
       xrccsite LIKE xrcc_t.xrccsite, #账务中心
       xrcc010 LIKE xrcc_t.xrcc010, #发票日期
       xrcc011 LIKE xrcc_t.xrcc011, #出货单据日期
       xrcc012 LIKE xrcc_t.xrcc012, #立账日期
       xrcc013 LIKE xrcc_t.xrcc013, #交易认定日期
       xrcc014 LIKE xrcc_t.xrcc014, #出入库扣账日期
       xrcc100 LIKE xrcc_t.xrcc100, #交易原币种
       xrcc101 LIKE xrcc_t.xrcc101, #原币汇率
       xrcc102 LIKE xrcc_t.xrcc102, #原币重估后汇率
       xrcc103 LIKE xrcc_t.xrcc103, #重评价调整数
       xrcc104 LIKE xrcc_t.xrcc104, #No Use
       xrcc105 LIKE xrcc_t.xrcc105, #No Use
       xrcc106 LIKE xrcc_t.xrcc106, #No Use
       xrcc107 LIKE xrcc_t.xrcc107, #No Use
       xrcc108 LIKE xrcc_t.xrcc108, #原币应收金额
       xrcc109 LIKE xrcc_t.xrcc109, #原币收款冲账金额
       xrcc113 LIKE xrcc_t.xrcc113, #本币重评价调整数
       xrcc114 LIKE xrcc_t.xrcc114, #No Use
       xrcc115 LIKE xrcc_t.xrcc115, #No Use
       xrcc116 LIKE xrcc_t.xrcc116, #No Use
       xrcc117 LIKE xrcc_t.xrcc117, #No Use
       xrcc118 LIKE xrcc_t.xrcc118, #本币应收金额
       xrcc119 LIKE xrcc_t.xrcc119, #本币收款冲账金额
       xrcc120 LIKE xrcc_t.xrcc120, #本位币二币种
       xrcc121 LIKE xrcc_t.xrcc121, #本位币二汇率
       xrcc122 LIKE xrcc_t.xrcc122, #本位币二重估后汇率
       xrcc123 LIKE xrcc_t.xrcc123, #本位币二重评价调整数
       xrcc124 LIKE xrcc_t.xrcc124, #No Use
       xrcc125 LIKE xrcc_t.xrcc125, #No Use
       xrcc126 LIKE xrcc_t.xrcc126, #No Use
       xrcc127 LIKE xrcc_t.xrcc127, #No Use
       xrcc128 LIKE xrcc_t.xrcc128, #本位币二应收金额
       xrcc129 LIKE xrcc_t.xrcc129, #本位币二收款冲账金额
       xrcc130 LIKE xrcc_t.xrcc130, #本位币三币种
       xrcc131 LIKE xrcc_t.xrcc131, #本位币三汇率
       xrcc132 LIKE xrcc_t.xrcc132, #本位币三重估后汇率
       xrcc133 LIKE xrcc_t.xrcc133, #本位币三重评价调整数
       xrcc134 LIKE xrcc_t.xrcc134, #No Use
       xrcc135 LIKE xrcc_t.xrcc135, #No Use
       xrcc136 LIKE xrcc_t.xrcc136, #No Use
       xrcc137 LIKE xrcc_t.xrcc137, #No Use
       xrcc138 LIKE xrcc_t.xrcc138, #本位币三应收金额
       xrcc139 LIKE xrcc_t.xrcc139, #本位币三收款冲账金额
       xrccud001 LIKE xrcc_t.xrccud001, #自定义字段(文本)001
       xrccud002 LIKE xrcc_t.xrccud002, #自定义字段(文本)002
       xrccud003 LIKE xrcc_t.xrccud003, #自定义字段(文本)003
       xrccud004 LIKE xrcc_t.xrccud004, #自定义字段(文本)004
       xrccud005 LIKE xrcc_t.xrccud005, #自定义字段(文本)005
       xrccud006 LIKE xrcc_t.xrccud006, #自定义字段(文本)006
       xrccud007 LIKE xrcc_t.xrccud007, #自定义字段(文本)007
       xrccud008 LIKE xrcc_t.xrccud008, #自定义字段(文本)008
       xrccud009 LIKE xrcc_t.xrccud009, #自定义字段(文本)009
       xrccud010 LIKE xrcc_t.xrccud010, #自定义字段(文本)010
       xrccud011 LIKE xrcc_t.xrccud011, #自定义字段(数字)011
       xrccud012 LIKE xrcc_t.xrccud012, #自定义字段(数字)012
       xrccud013 LIKE xrcc_t.xrccud013, #自定义字段(数字)013
       xrccud014 LIKE xrcc_t.xrccud014, #自定义字段(数字)014
       xrccud015 LIKE xrcc_t.xrccud015, #自定义字段(数字)015
       xrccud016 LIKE xrcc_t.xrccud016, #自定义字段(数字)016
       xrccud017 LIKE xrcc_t.xrccud017, #自定义字段(数字)017
       xrccud018 LIKE xrcc_t.xrccud018, #自定义字段(数字)018
       xrccud019 LIKE xrcc_t.xrccud019, #自定义字段(数字)019
       xrccud020 LIKE xrcc_t.xrccud020, #自定义字段(数字)020
       xrccud021 LIKE xrcc_t.xrccud021, #自定义字段(日期时间)021
       xrccud022 LIKE xrcc_t.xrccud022, #自定义字段(日期时间)022
       xrccud023 LIKE xrcc_t.xrccud023, #自定义字段(日期时间)023
       xrccud024 LIKE xrcc_t.xrccud024, #自定义字段(日期时间)024
       xrccud025 LIKE xrcc_t.xrccud025, #自定义字段(日期时间)025
       xrccud026 LIKE xrcc_t.xrccud026, #自定义字段(日期时间)026
       xrccud027 LIKE xrcc_t.xrccud027, #自定义字段(日期时间)027
       xrccud028 LIKE xrcc_t.xrccud028, #自定义字段(日期时间)028
       xrccud029 LIKE xrcc_t.xrccud029, #自定义字段(日期时间)029
       xrccud030 LIKE xrcc_t.xrccud030, #自定义字段(日期时间)030
       xrcc015 LIKE xrcc_t.xrcc015, #收款条件
       xrcc016 LIKE xrcc_t.xrcc016, #账款类型
       xrcc017 LIKE xrcc_t.xrcc017  #订单单号
       END RECORD
   #161219-00014#2--add--e--
  #DEFINE l_xrde           RECORD LIKE xrde_t.* #161219-00014#2 mark
   #161219-00014#2--add--s--
   DEFINE l_xrde RECORD  #收款及差異處理明細檔
       xrdeent LIKE xrde_t.xrdeent, #
       xrdecomp LIKE xrde_t.xrdecomp, #法人
       xrdeld LIKE xrde_t.xrdeld, #
       xrdedocno LIKE xrde_t.xrdedocno, #冲销单单号
       xrdeseq LIKE xrde_t.xrdeseq, #项次
       xrdesite LIKE xrde_t.xrdesite, #账务中心
       xrdeorga LIKE xrde_t.xrdeorga, #账务归属组织
       xrde001 LIKE xrde_t.xrde001, #来源作业
       xrde002 LIKE xrde_t.xrde002, #冲销账款类型
       xrde003 LIKE xrde_t.xrde003, #来源单号
       xrde004 LIKE xrde_t.xrde004, #来源单项次
       xrde006 LIKE xrde_t.xrde006, #
       xrde007 LIKE xrde_t.xrde007, #款别编号
       xrde008 LIKE xrde_t.xrde008, #账户/票券号码
       xrde010 LIKE xrde_t.xrde010, #摘要
       xrde011 LIKE xrde_t.xrde011, #银行存提码
       xrde012 LIKE xrde_t.xrde012, #现金变动码
       xrde013 LIKE xrde_t.xrde013, #转入客商码
       xrde014 LIKE xrde_t.xrde014, #转入账款单编号
       xrde015 LIKE xrde_t.xrde015, #冲销加减项
       xrde016 LIKE xrde_t.xrde016, #冲销会科
       xrde017 LIKE xrde_t.xrde017, #业务人员
       xrde018 LIKE xrde_t.xrde018, #业务部门
       xrde019 LIKE xrde_t.xrde019, #责任中心
       xrde020 LIKE xrde_t.xrde020, #产品类别
       xrde022 LIKE xrde_t.xrde022, #项目编号
       xrde023 LIKE xrde_t.xrde023, #WBS编号
       xrde028 LIKE xrde_t.xrde028, #生成方式
       xrde029 LIKE xrde_t.xrde029, #凭证号码
       xrde030 LIKE xrde_t.xrde030, #凭证项次
       xrde035 LIKE xrde_t.xrde035, #区域
       xrde036 LIKE xrde_t.xrde036, #客群
       xrde038 LIKE xrde_t.xrde038, #对象
       xrde039 LIKE xrde_t.xrde039, #经营方式
       xrde040 LIKE xrde_t.xrde040, #渠道
       xrde041 LIKE xrde_t.xrde041, #品牌
       xrde042 LIKE xrde_t.xrde042, #自由核算项一
       xrde043 LIKE xrde_t.xrde043, #自由核算项二
       xrde044 LIKE xrde_t.xrde044, #自由核算项三
       xrde045 LIKE xrde_t.xrde045, #自由核算项四
       xrde046 LIKE xrde_t.xrde046, #自由核算项五
       xrde047 LIKE xrde_t.xrde047, #自由核算项六
       xrde048 LIKE xrde_t.xrde048, #自由核算项七
       xrde049 LIKE xrde_t.xrde049, #自由核算项八
       xrde050 LIKE xrde_t.xrde050, #自由核算项九
       xrde051 LIKE xrde_t.xrde051, #自由核算项十
       xrde100 LIKE xrde_t.xrde100, #币种
       xrde101 LIKE xrde_t.xrde101, #汇率
       xrde109 LIKE xrde_t.xrde109, #原币冲账金额
       xrde119 LIKE xrde_t.xrde119, #本币冲账金额
       xrde120 LIKE xrde_t.xrde120, #本位币二币种
       xrde121 LIKE xrde_t.xrde121, #本位币二汇率
       xrde129 LIKE xrde_t.xrde129, #本位币二冲账金额
       xrde130 LIKE xrde_t.xrde130, #本位币三币种
       xrde131 LIKE xrde_t.xrde131, #本位币三汇率
       xrde139 LIKE xrde_t.xrde139, #本位币三冲账金额
       xrde032 LIKE xrde_t.xrde032, #收款日期
       xrde108 LIKE xrde_t.xrde108, #原币手续费
       xrde118 LIKE xrde_t.xrde118  #本币手续费
       END RECORD
   #161219-00014#2--add--e--
   #DEFINE l_xrce           RECORD LIKE xrce_t.* #161219-00014#2 mark
   #161219-00014#2--add--s--
   DEFINE l_xrce RECORD  #應收沖銷明細檔
       xrceent LIKE xrce_t.xrceent, #企业编号
       xrcecomp LIKE xrce_t.xrcecomp, #法人
       xrceld LIKE xrce_t.xrceld, #账套
       xrcedocno LIKE xrce_t.xrcedocno, #冲销单单号
       xrceseq LIKE xrce_t.xrceseq, #项次
       xrcelegl LIKE xrce_t.xrcelegl, #no use
       xrcesite LIKE xrce_t.xrcesite, #账务中心
       xrceorga LIKE xrce_t.xrceorga, #账务归属组织
       xrce001 LIKE xrce_t.xrce001, #来源作业
       xrce002 LIKE xrce_t.xrce002, #冲销类型
       xrce003 LIKE xrce_t.xrce003, #冲销账款单单号
       xrce004 LIKE xrce_t.xrce004, #冲销账款单项次
       xrce005 LIKE xrce_t.xrce005, #冲销账款单账期
       xrce006 LIKE xrce_t.xrce006, #no use
       xrce007 LIKE xrce_t.xrce007, #no use
       xrce008 LIKE xrce_t.xrce008, #no use
       xrce009 LIKE xrce_t.xrce009, #no use
       xrce010 LIKE xrce_t.xrce010, #摘要说明
       xrce011 LIKE xrce_t.xrce011, #no use
       xrce012 LIKE xrce_t.xrce012, #no use
       xrce013 LIKE xrce_t.xrce013, #no use
       xrce014 LIKE xrce_t.xrce014, #no use
       xrce015 LIKE xrce_t.xrce015, #冲销加减项
       xrce016 LIKE xrce_t.xrce016, #冲销科目
       xrce017 LIKE xrce_t.xrce017, #业务人员
       xrce018 LIKE xrce_t.xrce018, #业务部门
       xrce019 LIKE xrce_t.xrce019, #责任中心
       xrce020 LIKE xrce_t.xrce020, #产品类别
       xrce021 LIKE xrce_t.xrce021, #no use
       xrce022 LIKE xrce_t.xrce022, #项目编号
       xrce023 LIKE xrce_t.xrce023, #WBS编号
       xrce024 LIKE xrce_t.xrce024, #第二参考单号
       xrce025 LIKE xrce_t.xrce025, #第二参考单号项次
       xrce026 LIKE xrce_t.xrce026, #no use
       xrce027 LIKE xrce_t.xrce027, #应税折抵否
       xrce028 LIKE xrce_t.xrce028, #生成方式
       xrce029 LIKE xrce_t.xrce029, #凭证号码
       xrce030 LIKE xrce_t.xrce030, #凭证项次
       xrce035 LIKE xrce_t.xrce035, #区域
       xrce036 LIKE xrce_t.xrce036, #客户分类
       xrce037 LIKE xrce_t.xrce037, #no use
       xrce038 LIKE xrce_t.xrce038, #对象
       xrce039 LIKE xrce_t.xrce039, #经营方式
       xrce040 LIKE xrce_t.xrce040, #渠道
       xrce041 LIKE xrce_t.xrce041, #品牌
       xrce042 LIKE xrce_t.xrce042, #自由核算项一
       xrce043 LIKE xrce_t.xrce043, #自由核算项二
       xrce044 LIKE xrce_t.xrce044, #自由核算项三
       xrce045 LIKE xrce_t.xrce045, #自由核算项四
       xrce046 LIKE xrce_t.xrce046, #自由核算项五
       xrce047 LIKE xrce_t.xrce047, #自由核算项六
       xrce048 LIKE xrce_t.xrce048, #自由核算项七
       xrce049 LIKE xrce_t.xrce049, #自由核算项八
       xrce050 LIKE xrce_t.xrce050, #自由核算项九
       xrce051 LIKE xrce_t.xrce051, #自由核算项十
       xrce053 LIKE xrce_t.xrce053, #发票编号
       xrce054 LIKE xrce_t.xrce054, #发票号码
       xrce100 LIKE xrce_t.xrce100, #币种
       xrce101 LIKE xrce_t.xrce101, #汇率
       xrce104 LIKE xrce_t.xrce104, #原币应税折抵税额
       xrce109 LIKE xrce_t.xrce109, #原币冲账金额
       xrce114 LIKE xrce_t.xrce114, #本币应税折抵税额
       xrce119 LIKE xrce_t.xrce119, #本币冲账金额
       xrce120 LIKE xrce_t.xrce120, #本位币二币种
       xrce121 LIKE xrce_t.xrce121, #本位币二汇率
       xrce124 LIKE xrce_t.xrce124, #本位币二应税折抵税额
       xrce129 LIKE xrce_t.xrce129, #本位币二冲账金额
       xrce130 LIKE xrce_t.xrce130, #本位币二币种
       xrce131 LIKE xrce_t.xrce131, #本位币三汇率
       xrce134 LIKE xrce_t.xrce134, #本位币三应税折抵税额
       xrce139 LIKE xrce_t.xrce139, #本位币三冲账金额
       xrceud001 LIKE xrce_t.xrceud001, #自定义字段(文本)001
       xrceud002 LIKE xrce_t.xrceud002, #自定义字段(文本)002
       xrceud003 LIKE xrce_t.xrceud003, #自定义字段(文本)003
       xrceud004 LIKE xrce_t.xrceud004, #自定义字段(文本)004
       xrceud005 LIKE xrce_t.xrceud005, #自定义字段(文本)005
       xrceud006 LIKE xrce_t.xrceud006, #自定义字段(文本)006
       xrceud007 LIKE xrce_t.xrceud007, #自定义字段(文本)007
       xrceud008 LIKE xrce_t.xrceud008, #自定义字段(文本)008
       xrceud009 LIKE xrce_t.xrceud009, #自定义字段(文本)009
       xrceud010 LIKE xrce_t.xrceud010, #自定义字段(文本)010
       xrceud011 LIKE xrce_t.xrceud011, #自定义字段(数字)011
       xrceud012 LIKE xrce_t.xrceud012, #自定义字段(数字)012
       xrceud013 LIKE xrce_t.xrceud013, #自定义字段(数字)013
       xrceud014 LIKE xrce_t.xrceud014, #自定义字段(数字)014
       xrceud015 LIKE xrce_t.xrceud015, #自定义字段(数字)015
       xrceud016 LIKE xrce_t.xrceud016, #自定义字段(数字)016
       xrceud017 LIKE xrce_t.xrceud017, #自定义字段(数字)017
       xrceud018 LIKE xrce_t.xrceud018, #自定义字段(数字)018
       xrceud019 LIKE xrce_t.xrceud019, #自定义字段(数字)019
       xrceud020 LIKE xrce_t.xrceud020, #自定义字段(数字)020
       xrceud021 LIKE xrce_t.xrceud021, #自定义字段(日期时间)021
       xrceud022 LIKE xrce_t.xrceud022, #自定义字段(日期时间)022
       xrceud023 LIKE xrce_t.xrceud023, #自定义字段(日期时间)023
       xrceud024 LIKE xrce_t.xrceud024, #自定义字段(日期时间)024
       xrceud025 LIKE xrce_t.xrceud025, #自定义字段(日期时间)025
       xrceud026 LIKE xrce_t.xrceud026, #自定义字段(日期时间)026
       xrceud027 LIKE xrce_t.xrceud027, #自定义字段(日期时间)027
       xrceud028 LIKE xrce_t.xrceud028, #自定义字段(日期时间)028
       xrceud029 LIKE xrce_t.xrceud029, #自定义字段(日期时间)029
       xrceud030 LIKE xrce_t.xrceud030, #自定义字段(日期时间)030
       xrce055 LIKE xrce_t.xrce055, #费用编号
       xrce056 LIKE xrce_t.xrce056, #方向
       xrce057 LIKE xrce_t.xrce057, #预收待抵单号
       xrce058 LIKE xrce_t.xrce058, #应付单号
       xrce103 LIKE xrce_t.xrce103, #税前原币冲销额
       xrce113 LIKE xrce_t.xrce113, #税前本币冲销额
       xrce123 LIKE xrce_t.xrce123, #本位币二税前冲销额
       xrce133 LIKE xrce_t.xrce133, #本位币三税前冲销额
       xrce059 LIKE xrce_t.xrce059  #预收单号
       END RECORD
   #161219-00014#2--add--e--
   #DEFINE l_xrce_t         RECORD LIKE xrce_t.* #161219-00014#2 mark
   #161219-00014#2--add--s--
   DEFINE l_xrce_t RECORD  #應收沖銷明細檔
       xrceent LIKE xrce_t.xrceent, #企业编号
       xrcecomp LIKE xrce_t.xrcecomp, #法人
       xrceld LIKE xrce_t.xrceld, #账套
       xrcedocno LIKE xrce_t.xrcedocno, #冲销单单号
       xrceseq LIKE xrce_t.xrceseq, #项次
       xrcelegl LIKE xrce_t.xrcelegl, #no use
       xrcesite LIKE xrce_t.xrcesite, #账务中心
       xrceorga LIKE xrce_t.xrceorga, #账务归属组织
       xrce001 LIKE xrce_t.xrce001, #来源作业
       xrce002 LIKE xrce_t.xrce002, #冲销类型
       xrce003 LIKE xrce_t.xrce003, #冲销账款单单号
       xrce004 LIKE xrce_t.xrce004, #冲销账款单项次
       xrce005 LIKE xrce_t.xrce005, #冲销账款单账期
       xrce006 LIKE xrce_t.xrce006, #no use
       xrce007 LIKE xrce_t.xrce007, #no use
       xrce008 LIKE xrce_t.xrce008, #no use
       xrce009 LIKE xrce_t.xrce009, #no use
       xrce010 LIKE xrce_t.xrce010, #摘要说明
       xrce011 LIKE xrce_t.xrce011, #no use
       xrce012 LIKE xrce_t.xrce012, #no use
       xrce013 LIKE xrce_t.xrce013, #no use
       xrce014 LIKE xrce_t.xrce014, #no use
       xrce015 LIKE xrce_t.xrce015, #冲销加减项
       xrce016 LIKE xrce_t.xrce016, #冲销科目
       xrce017 LIKE xrce_t.xrce017, #业务人员
       xrce018 LIKE xrce_t.xrce018, #业务部门
       xrce019 LIKE xrce_t.xrce019, #责任中心
       xrce020 LIKE xrce_t.xrce020, #产品类别
       xrce021 LIKE xrce_t.xrce021, #no use
       xrce022 LIKE xrce_t.xrce022, #项目编号
       xrce023 LIKE xrce_t.xrce023, #WBS编号
       xrce024 LIKE xrce_t.xrce024, #第二参考单号
       xrce025 LIKE xrce_t.xrce025, #第二参考单号项次
       xrce026 LIKE xrce_t.xrce026, #no use
       xrce027 LIKE xrce_t.xrce027, #应税折抵否
       xrce028 LIKE xrce_t.xrce028, #生成方式
       xrce029 LIKE xrce_t.xrce029, #凭证号码
       xrce030 LIKE xrce_t.xrce030, #凭证项次
       xrce035 LIKE xrce_t.xrce035, #区域
       xrce036 LIKE xrce_t.xrce036, #客户分类
       xrce037 LIKE xrce_t.xrce037, #no use
       xrce038 LIKE xrce_t.xrce038, #对象
       xrce039 LIKE xrce_t.xrce039, #经营方式
       xrce040 LIKE xrce_t.xrce040, #渠道
       xrce041 LIKE xrce_t.xrce041, #品牌
       xrce042 LIKE xrce_t.xrce042, #自由核算项一
       xrce043 LIKE xrce_t.xrce043, #自由核算项二
       xrce044 LIKE xrce_t.xrce044, #自由核算项三
       xrce045 LIKE xrce_t.xrce045, #自由核算项四
       xrce046 LIKE xrce_t.xrce046, #自由核算项五
       xrce047 LIKE xrce_t.xrce047, #自由核算项六
       xrce048 LIKE xrce_t.xrce048, #自由核算项七
       xrce049 LIKE xrce_t.xrce049, #自由核算项八
       xrce050 LIKE xrce_t.xrce050, #自由核算项九
       xrce051 LIKE xrce_t.xrce051, #自由核算项十
       xrce053 LIKE xrce_t.xrce053, #发票编号
       xrce054 LIKE xrce_t.xrce054, #发票号码
       xrce100 LIKE xrce_t.xrce100, #币种
       xrce101 LIKE xrce_t.xrce101, #汇率
       xrce104 LIKE xrce_t.xrce104, #原币应税折抵税额
       xrce109 LIKE xrce_t.xrce109, #原币冲账金额
       xrce114 LIKE xrce_t.xrce114, #本币应税折抵税额
       xrce119 LIKE xrce_t.xrce119, #本币冲账金额
       xrce120 LIKE xrce_t.xrce120, #本位币二币种
       xrce121 LIKE xrce_t.xrce121, #本位币二汇率
       xrce124 LIKE xrce_t.xrce124, #本位币二应税折抵税额
       xrce129 LIKE xrce_t.xrce129, #本位币二冲账金额
       xrce130 LIKE xrce_t.xrce130, #本位币二币种
       xrce131 LIKE xrce_t.xrce131, #本位币三汇率
       xrce134 LIKE xrce_t.xrce134, #本位币三应税折抵税额
       xrce139 LIKE xrce_t.xrce139, #本位币三冲账金额
       xrceud001 LIKE xrce_t.xrceud001, #自定义字段(文本)001
       xrceud002 LIKE xrce_t.xrceud002, #自定义字段(文本)002
       xrceud003 LIKE xrce_t.xrceud003, #自定义字段(文本)003
       xrceud004 LIKE xrce_t.xrceud004, #自定义字段(文本)004
       xrceud005 LIKE xrce_t.xrceud005, #自定义字段(文本)005
       xrceud006 LIKE xrce_t.xrceud006, #自定义字段(文本)006
       xrceud007 LIKE xrce_t.xrceud007, #自定义字段(文本)007
       xrceud008 LIKE xrce_t.xrceud008, #自定义字段(文本)008
       xrceud009 LIKE xrce_t.xrceud009, #自定义字段(文本)009
       xrceud010 LIKE xrce_t.xrceud010, #自定义字段(文本)010
       xrceud011 LIKE xrce_t.xrceud011, #自定义字段(数字)011
       xrceud012 LIKE xrce_t.xrceud012, #自定义字段(数字)012
       xrceud013 LIKE xrce_t.xrceud013, #自定义字段(数字)013
       xrceud014 LIKE xrce_t.xrceud014, #自定义字段(数字)014
       xrceud015 LIKE xrce_t.xrceud015, #自定义字段(数字)015
       xrceud016 LIKE xrce_t.xrceud016, #自定义字段(数字)016
       xrceud017 LIKE xrce_t.xrceud017, #自定义字段(数字)017
       xrceud018 LIKE xrce_t.xrceud018, #自定义字段(数字)018
       xrceud019 LIKE xrce_t.xrceud019, #自定义字段(数字)019
       xrceud020 LIKE xrce_t.xrceud020, #自定义字段(数字)020
       xrceud021 LIKE xrce_t.xrceud021, #自定义字段(日期时间)021
       xrceud022 LIKE xrce_t.xrceud022, #自定义字段(日期时间)022
       xrceud023 LIKE xrce_t.xrceud023, #自定义字段(日期时间)023
       xrceud024 LIKE xrce_t.xrceud024, #自定义字段(日期时间)024
       xrceud025 LIKE xrce_t.xrceud025, #自定义字段(日期时间)025
       xrceud026 LIKE xrce_t.xrceud026, #自定义字段(日期时间)026
       xrceud027 LIKE xrce_t.xrceud027, #自定义字段(日期时间)027
       xrceud028 LIKE xrce_t.xrceud028, #自定义字段(日期时间)028
       xrceud029 LIKE xrce_t.xrceud029, #自定义字段(日期时间)029
       xrceud030 LIKE xrce_t.xrceud030, #自定义字段(日期时间)030
       xrce055 LIKE xrce_t.xrce055, #费用编号
       xrce056 LIKE xrce_t.xrce056, #方向
       xrce057 LIKE xrce_t.xrce057, #预收待抵单号
       xrce058 LIKE xrce_t.xrce058, #应付单号
       xrce103 LIKE xrce_t.xrce103, #税前原币冲销额
       xrce113 LIKE xrce_t.xrce113, #税前本币冲销额
       xrce123 LIKE xrce_t.xrce123, #本位币二税前冲销额
       xrce133 LIKE xrce_t.xrce133, #本位币三税前冲销额
       xrce059 LIKE xrce_t.xrce059  #预收单号
       END RECORD
   #161219-00014#2--add--e--
   DEFINE l_xrccdocno      LIKE xrcc_t.xrccdocno
   DEFINE l_xrccseq        LIKE xrcc_t.xrccseq
   DEFINE l_xrcc001        LIKE xrcc_t.xrcc001
   DEFINE l_apccdocno      LIKE apcc_t.apccdocno
   DEFINE l_apccseq        LIKE apcc_t.apccseq
   DEFINE l_apcc001        LIKE apcc_t.apcc001
   DEFINE l_seq            LIKE xrcc_t.xrccseq
   DEFINE l_xrce016        LIKE xrce_t.xrce016
   DEFINE l_trans          LIKE xrce_t.xrce109   #收款原幣金額
   DEFINE l_xrde109        LIKE xrde_t.xrde109
   DEFINE l_xrde119        LIKE xrde_t.xrde119
   DEFINE l_xrde129        LIKE xrde_t.xrde129
   DEFINE l_xrde139        LIKE xrde_t.xrde139
   DEFINE l_xrce109        LIKE xrce_t.xrce109
   DEFINE l_xrce119        LIKE xrce_t.xrce119
   DEFINE l_xrce129        LIKE xrce_t.xrce129
   DEFINE l_xrce139        LIKE xrce_t.xrce139
   DEFINE l_xrde109_1      LIKE xrde_t.xrde109
   DEFINE l_xrde119_1      LIKE xrde_t.xrde119
   DEFINE l_xrde129_1      LIKE xrde_t.xrde129
   DEFINE l_xrde139_1      LIKE xrde_t.xrde139
   DEFINE l_gzcb003        LIKE gzcb_t.gzcb003
  #DEFINE l_apca_t         RECORD LIKE apca_t.* #161219-00014#2 mark
   #161219-00014#2--add--s--
   DEFINE l_apca_t  RECORD  #應付憑單單頭
       apcaent LIKE apca_t.apcaent, #企业编号
       apcaownid LIKE apca_t.apcaownid, #资料所有者
       apcaowndp LIKE apca_t.apcaowndp, #资料所有部门
       apcacrtid LIKE apca_t.apcacrtid, #资料录入者
       apcacrtdp LIKE apca_t.apcacrtdp, #资料录入部门
       apcacrtdt LIKE apca_t.apcacrtdt, #资料创建日
       apcamodid LIKE apca_t.apcamodid, #资料更改者
       apcamoddt LIKE apca_t.apcamoddt, #最近更改日
       apcacnfid LIKE apca_t.apcacnfid, #资料审核者
       apcacnfdt LIKE apca_t.apcacnfdt, #数据审核日
       apcapstid LIKE apca_t.apcapstid, #资料过账者
       apcapstdt LIKE apca_t.apcapstdt, #资料过账日
       apcastus LIKE apca_t.apcastus, #状态码
       apcald LIKE apca_t.apcald, #账套
       apcacomp LIKE apca_t.apcacomp, #法人
       apcadocno LIKE apca_t.apcadocno, #应付账款单号码
       apcadocdt LIKE apca_t.apcadocdt, #账款日期
       apcasite LIKE apca_t.apcasite, #账务中心
       apca001 LIKE apca_t.apca001, #账款单性质
       apca003 LIKE apca_t.apca003, #账务人员
       apca004 LIKE apca_t.apca004, #账款对象编号
       apca005 LIKE apca_t.apca005, #付款对象
       apca006 LIKE apca_t.apca006, #供应商分类
       apca007 LIKE apca_t.apca007, #账款类别
       apca008 LIKE apca_t.apca008, #付款条件编号
       apca009 LIKE apca_t.apca009, #应付款日/应扣抵日
       apca010 LIKE apca_t.apca010, #容许票据到期日
       apca011 LIKE apca_t.apca011, #税种
       apca012 LIKE apca_t.apca012, #税率
       apca013 LIKE apca_t.apca013, #含税否
       apca014 LIKE apca_t.apca014, #人员编号
       apca015 LIKE apca_t.apca015, #部门编号
       apca016 LIKE apca_t.apca016, #来源作业类型
       apca017 LIKE apca_t.apca017, #生成方式
       apca018 LIKE apca_t.apca018, #来源参考单号
       apca019 LIKE apca_t.apca019, #系统生成对应单号(待抵账款-预付)
       apca020 LIKE apca_t.apca020, #信用状付款否
       apca021 LIKE apca_t.apca021, #商业发票号码(IV no.)
       apca022 LIKE apca_t.apca022, #进口报单号码
       apca025 LIKE apca_t.apca025, #差异处理(发票与账款差异)
       apca026 LIKE apca_t.apca026, #原币税前差异
       apca027 LIKE apca_t.apca027, #原币税额差异
       apca028 LIKE apca_t.apca028, #本币税前差异
       apca029 LIKE apca_t.apca029, #本币币税额差异
       apca030 LIKE apca_t.apca030, #差异科目
       apca031 LIKE apca_t.apca031, #生成之差异折让单号
       apca032 LIKE apca_t.apca032, #发票类型
       apca033 LIKE apca_t.apca033, #项目编号
       apca034 LIKE apca_t.apca034, #责任中心
       apca035 LIKE apca_t.apca035, #应付(贷方)科目编号
       apca036 LIKE apca_t.apca036, #费用(借方)科目编号
       apca037 LIKE apca_t.apca037, #生成凭证否
       apca038 LIKE apca_t.apca038, #抛转凭证号码
       apca039 LIKE apca_t.apca039, #会计检核附件份数
       apca040 LIKE apca_t.apca040, #留置否
       apca041 LIKE apca_t.apca041, #留置理由码
       apca042 LIKE apca_t.apca042, #留置设置日期
       apca043 LIKE apca_t.apca043, #留置解除日期
       apca044 LIKE apca_t.apca044, #留置原币金额
       apca045 LIKE apca_t.apca045, #留置说明
       apca046 LIKE apca_t.apca046, #关系人否
       apca047 LIKE apca_t.apca047, #多角序号
       apca048 LIKE apca_t.apca048, #集团代付/代付单号
       apca049 LIKE apca_t.apca049, #来源营运中心编号
       apca050 LIKE apca_t.apca050, #交易原始单据份数
       apca051 LIKE apca_t.apca051, #作废理由码
       apca052 LIKE apca_t.apca052, #打印次数
       apca053 LIKE apca_t.apca053, #备注
       apca054 LIKE apca_t.apca054, #多账期设置
       apca055 LIKE apca_t.apca055, #缴款优惠条件
       apca056 LIKE apca_t.apca056, #会计检核附件状态
       apca057 LIKE apca_t.apca057, #交易对象识别码
       apca058 LIKE apca_t.apca058, #税种交易类型
       apca059 LIKE apca_t.apca059, #预算编号
       apca060 LIKE apca_t.apca060, #发票开立方式
       apca061 LIKE apca_t.apca061, #预开发票基准日
       apca062 LIKE apca_t.apca062, #多角性质
       apca063 LIKE apca_t.apca063, #整账批序号
       apca064 LIKE apca_t.apca064, #订金序次
       apca065 LIKE apca_t.apca065, #发票编号
       apca066 LIKE apca_t.apca066, #发票号码
       apca100 LIKE apca_t.apca100, #交易原币种
       apca101 LIKE apca_t.apca101, #原币汇率
       apca103 LIKE apca_t.apca103, #原币税前金额
       apca104 LIKE apca_t.apca104, #原币税额
       apca106 LIKE apca_t.apca106, #原币应税折抵合计金额
       apca107 LIKE apca_t.apca107, #原币直接冲账(调整)合计金额
       apca108 LIKE apca_t.apca108, #原币应付金额
       apca113 LIKE apca_t.apca113, #本币税前金额
       apca114 LIKE apca_t.apca114, #本币税额
       apca116 LIKE apca_t.apca116, #本币应税折抵合计金额
       apca117 LIKE apca_t.apca117, #NO USE
       apca118 LIKE apca_t.apca118, #本币应付金额
       apca120 LIKE apca_t.apca120, #本位币二币种
       apca121 LIKE apca_t.apca121, #本位币二汇率
       apca123 LIKE apca_t.apca123, #本位币二税前金额
       apca124 LIKE apca_t.apca124, #本位币二税额
       apca126 LIKE apca_t.apca126, #本位币二应税折抵合计金额
       apca127 LIKE apca_t.apca127, #NO USE
       apca128 LIKE apca_t.apca128, #本位币二应付金额
       apca130 LIKE apca_t.apca130, #本位币三币种
       apca131 LIKE apca_t.apca131, #本位币三汇率
       apca133 LIKE apca_t.apca133, #本位币三税前金额
       apca134 LIKE apca_t.apca134, #本位币三税额
       apca136 LIKE apca_t.apca136, #本位币三应税折抵合计金额
       apca137 LIKE apca_t.apca137, #NO USE
       apca138 LIKE apca_t.apca138, #本位币三应付金额
       apcaud001 LIKE apca_t.apcaud001, #自定义字段(文本)001
       apcaud002 LIKE apca_t.apcaud002, #自定义字段(文本)002
       apcaud003 LIKE apca_t.apcaud003, #自定义字段(文本)003
       apcaud004 LIKE apca_t.apcaud004, #自定义字段(文本)004
       apcaud005 LIKE apca_t.apcaud005, #自定义字段(文本)005
       apcaud006 LIKE apca_t.apcaud006, #自定义字段(文本)006
       apcaud007 LIKE apca_t.apcaud007, #自定义字段(文本)007
       apcaud008 LIKE apca_t.apcaud008, #自定义字段(文本)008
       apcaud009 LIKE apca_t.apcaud009, #自定义字段(文本)009
       apcaud010 LIKE apca_t.apcaud010, #自定义字段(文本)010
       apcaud011 LIKE apca_t.apcaud011, #自定义字段(数字)011
       apcaud012 LIKE apca_t.apcaud012, #自定义字段(数字)012
       apcaud013 LIKE apca_t.apcaud013, #自定义字段(数字)013
       apcaud014 LIKE apca_t.apcaud014, #自定义字段(数字)014
       apcaud015 LIKE apca_t.apcaud015, #自定义字段(数字)015
       apcaud016 LIKE apca_t.apcaud016, #自定义字段(数字)016
       apcaud017 LIKE apca_t.apcaud017, #自定义字段(数字)017
       apcaud018 LIKE apca_t.apcaud018, #自定义字段(数字)018
       apcaud019 LIKE apca_t.apcaud019, #自定义字段(数字)019
       apcaud020 LIKE apca_t.apcaud020, #自定义字段(数字)020
       apcaud021 LIKE apca_t.apcaud021, #自定义字段(日期时间)021
       apcaud022 LIKE apca_t.apcaud022, #自定义字段(日期时间)022
       apcaud023 LIKE apca_t.apcaud023, #自定义字段(日期时间)023
       apcaud024 LIKE apca_t.apcaud024, #自定义字段(日期时间)024
       apcaud025 LIKE apca_t.apcaud025, #自定义字段(日期时间)025
       apcaud026 LIKE apca_t.apcaud026, #自定义字段(日期时间)026
       apcaud027 LIKE apca_t.apcaud027, #自定义字段(日期时间)027
       apcaud028 LIKE apca_t.apcaud028, #自定义字段(日期时间)028
       apcaud029 LIKE apca_t.apcaud029, #自定义字段(日期时间)029
       apcaud030 LIKE apca_t.apcaud030, #自定义字段(日期时间)030
       apca067 LIKE apca_t.apca067, #管理品类
       apca068 LIKE apca_t.apca068, #经营方式
       apca069 LIKE apca_t.apca069, #no use
       apca070 LIKE apca_t.apca070, #no use
       apca071 LIKE apca_t.apca071, #no use
       apca072 LIKE apca_t.apca072, #no use
       apca073 LIKE apca_t.apca073  #L/C No.
       END RECORD
   #161219-00014#2--add--e--
   #DEFINE l_apcb_t         RECORD LIKE apcb_t.* #161219-00014#2 mark
   #161219-00014#2--add--s--
    DEFINE l_apcb_t RECORD  #應付憑單單身
       apcbent LIKE apcb_t.apcbent, #企业编号
       apcbld LIKE apcb_t.apcbld, #账套
       apcblegl LIKE apcb_t.apcblegl, #核算组织
       apcborga LIKE apcb_t.apcborga, #账务归属组织(来源组织)
       apcbsite LIKE apcb_t.apcbsite, #应付账务组织
       apcbdocno LIKE apcb_t.apcbdocno, #单号
       apcbseq LIKE apcb_t.apcbseq, #项次
       apcb001 LIKE apcb_t.apcb001, #来源类型
       apcb002 LIKE apcb_t.apcb002, #来源业务单据号码
       apcb003 LIKE apcb_t.apcb003, #来源业务单据项次
       apcb004 LIKE apcb_t.apcb004, #产品编号
       apcb005 LIKE apcb_t.apcb005, #品名规格
       apcb006 LIKE apcb_t.apcb006, #单位
       apcb007 LIKE apcb_t.apcb007, #计价数量
       apcb008 LIKE apcb_t.apcb008, #参考单据号码
       apcb009 LIKE apcb_t.apcb009, #参考单据项次
       apcb010 LIKE apcb_t.apcb010, #业务部门
       apcb011 LIKE apcb_t.apcb011, #责任中心
       apcb012 LIKE apcb_t.apcb012, #产品类别
       apcb013 LIKE apcb_t.apcb013, #搭赠
       apcb014 LIKE apcb_t.apcb014, #理由码
       apcb015 LIKE apcb_t.apcb015, #项目编号
       apcb016 LIKE apcb_t.apcb016, #WBS编号
       apcb017 LIKE apcb_t.apcb017, #预算细项
       apcb018 LIKE apcb_t.apcb018, #专柜编号
       apcb019 LIKE apcb_t.apcb019, #开票性质
       apcb020 LIKE apcb_t.apcb020, #税种
       apcb021 LIKE apcb_t.apcb021, #费用会计科目
       apcb022 LIKE apcb_t.apcb022, #正负值
       apcb023 LIKE apcb_t.apcb023, #冲暂估单否
       apcb024 LIKE apcb_t.apcb024, #区域
       apcb025 LIKE apcb_t.apcb025, #凭证号码
       apcb026 LIKE apcb_t.apcb026, #凭证项次
       apcb027 LIKE apcb_t.apcb027, #发票编号
       apcb028 LIKE apcb_t.apcb028, #发票号码
       apcb029 LIKE apcb_t.apcb029, #应付账款科目
       apcb030 LIKE apcb_t.apcb030, #付款条件
       apcb032 LIKE apcb_t.apcb032, #订金序次
       apcb033 LIKE apcb_t.apcb033, #经营方式
       apcb034 LIKE apcb_t.apcb034, #渠道
       apcb035 LIKE apcb_t.apcb035, #品牌
       apcb036 LIKE apcb_t.apcb036, #客群
       apcb037 LIKE apcb_t.apcb037, #自由核算项一
       apcb038 LIKE apcb_t.apcb038, #自由核算项二
       apcb039 LIKE apcb_t.apcb039, #自由核算项三
       apcb040 LIKE apcb_t.apcb040, #自由核算项四
       apcb041 LIKE apcb_t.apcb041, #自由核算项五
       apcb042 LIKE apcb_t.apcb042, #自由核算项六
       apcb043 LIKE apcb_t.apcb043, #自由核算项七
       apcb044 LIKE apcb_t.apcb044, #自由核算项八
       apcb045 LIKE apcb_t.apcb045, #自由核算项九
       apcb046 LIKE apcb_t.apcb046, #自由核算项十
       apcb047 LIKE apcb_t.apcb047, #摘要
       apcb048 LIKE apcb_t.apcb048, #来源订购单号
       apcb049 LIKE apcb_t.apcb049, #开票单号
       apcb050 LIKE apcb_t.apcb050, #开票项次
       apcb051 LIKE apcb_t.apcb051, #业务人员
       apcb100 LIKE apcb_t.apcb100, #交易原币
       apcb101 LIKE apcb_t.apcb101, #交易原币单价
       apcb102 LIKE apcb_t.apcb102, #原币汇率
       apcb103 LIKE apcb_t.apcb103, #交易原币税前金额
       apcb104 LIKE apcb_t.apcb104, #交易原币税额
       apcb105 LIKE apcb_t.apcb105, #交易原币含税金额
       apcb106 LIKE apcb_t.apcb106, #交易币标准成本金额
       apcb107 LIKE apcb_t.apcb107, #入库单单价
       apcb108 LIKE apcb_t.apcb108, #交易原币成本认列金额
       apcb111 LIKE apcb_t.apcb111, #本币单价
       apcb113 LIKE apcb_t.apcb113, #本币税前金额
       apcb114 LIKE apcb_t.apcb114, #本币税额
       apcb115 LIKE apcb_t.apcb115, #本币含税金额
       apcb116 LIKE apcb_t.apcb116, #本币标准成本金额
       apcb117 LIKE apcb_t.apcb117, #NO USE
       apcb118 LIKE apcb_t.apcb118, #本币成本认列金额
       apcb119 LIKE apcb_t.apcb119, #应开发票含税金额
       apcb121 LIKE apcb_t.apcb121, #本位币二汇率
       apcb123 LIKE apcb_t.apcb123, #本位币二税前金额
       apcb124 LIKE apcb_t.apcb124, #本位币二税额
       apcb125 LIKE apcb_t.apcb125, #本位币二含税金额
       apcb126 LIKE apcb_t.apcb126, #本币二标准成本金额
       apcb127 LIKE apcb_t.apcb127, #NO USE
       apcb128 LIKE apcb_t.apcb128, #本位币二成本认列金额
       apcb131 LIKE apcb_t.apcb131, #本位币三汇率
       apcb133 LIKE apcb_t.apcb133, #本位币三税前金额
       apcb134 LIKE apcb_t.apcb134, #本位币三税额
       apcb135 LIKE apcb_t.apcb135, #本位币三含税金额
       apcb136 LIKE apcb_t.apcb136, #本币三标准成本金额
       apcb137 LIKE apcb_t.apcb137, #NO USE
       apcb138 LIKE apcb_t.apcb138, #本位币三成本认列金额
       apcbud001 LIKE apcb_t.apcbud001, #自定义字段(文本)001
       apcbud002 LIKE apcb_t.apcbud002, #自定义字段(文本)002
       apcbud003 LIKE apcb_t.apcbud003, #自定义字段(文本)003
       apcbud004 LIKE apcb_t.apcbud004, #自定义字段(文本)004
       apcbud005 LIKE apcb_t.apcbud005, #自定义字段(文本)005
       apcbud006 LIKE apcb_t.apcbud006, #自定义字段(文本)006
       apcbud007 LIKE apcb_t.apcbud007, #自定义字段(文本)007
       apcbud008 LIKE apcb_t.apcbud008, #自定义字段(文本)008
       apcbud009 LIKE apcb_t.apcbud009, #自定义字段(文本)009
       apcbud010 LIKE apcb_t.apcbud010, #自定义字段(文本)010
       apcbud011 LIKE apcb_t.apcbud011, #自定义字段(数字)011
       apcbud012 LIKE apcb_t.apcbud012, #自定义字段(数字)012
       apcbud013 LIKE apcb_t.apcbud013, #自定义字段(数字)013
       apcbud014 LIKE apcb_t.apcbud014, #自定义字段(数字)014
       apcbud015 LIKE apcb_t.apcbud015, #自定义字段(数字)015
       apcbud016 LIKE apcb_t.apcbud016, #自定义字段(数字)016
       apcbud017 LIKE apcb_t.apcbud017, #自定义字段(数字)017
       apcbud018 LIKE apcb_t.apcbud018, #自定义字段(数字)018
       apcbud019 LIKE apcb_t.apcbud019, #自定义字段(数字)019
       apcbud020 LIKE apcb_t.apcbud020, #自定义字段(数字)020
       apcbud021 LIKE apcb_t.apcbud021, #自定义字段(日期时间)021
       apcbud022 LIKE apcb_t.apcbud022, #自定义字段(日期时间)022
       apcbud023 LIKE apcb_t.apcbud023, #自定义字段(日期时间)023
       apcbud024 LIKE apcb_t.apcbud024, #自定义字段(日期时间)024
       apcbud025 LIKE apcb_t.apcbud025, #自定义字段(日期时间)025
       apcbud026 LIKE apcb_t.apcbud026, #自定义字段(日期时间)026
       apcbud027 LIKE apcb_t.apcbud027, #自定义字段(日期时间)027
       apcbud028 LIKE apcb_t.apcbud028, #自定义字段(日期时间)028
       apcbud029 LIKE apcb_t.apcbud029, #自定义字段(日期时间)029
       apcbud030 LIKE apcb_t.apcbud030, #自定义字段(日期时间)030
       apcb052 LIKE apcb_t.apcb052, #税额
       apcb053 LIKE apcb_t.apcb053, #含税金额
       apcb054 LIKE apcb_t.apcb054, #账款对象
       apcb055 LIKE apcb_t.apcb055  #付款对象
       END RECORD
   #161219-00014#2--add--e--
   #DEFINE l_apcc_t         RECORD LIKE apcc_t.* #161219-00014#2 mark
   #161219-00014#2--add--s--
   DEFINE l_apcc_t RECORD  #應付多帳期檔
       apccent LIKE apcc_t.apccent, #企业编号
       apccld LIKE apcc_t.apccld, #账套
       apcccomp LIKE apcc_t.apcccomp, #法人
       apcclegl LIKE apcc_t.apcclegl, #核算组织
       apccsite LIKE apcc_t.apccsite, #账务中心
       apccdocno LIKE apcc_t.apccdocno, #应付账款单号码
       apccseq LIKE apcc_t.apccseq, #项次
       apcc001 LIKE apcc_t.apcc001, #分期账款序
       apcc002 LIKE apcc_t.apcc002, #应付款别性质
       apcc003 LIKE apcc_t.apcc003, #应付款日
       apcc004 LIKE apcc_t.apcc004, #容许票据到期日
       apcc005 LIKE apcc_t.apcc005, #账款起算日
       apcc006 LIKE apcc_t.apcc006, #正负值
       apcc007 LIKE apcc_t.apcc007, #原币已请款金额
       apcc008 LIKE apcc_t.apcc008, #发票编号
       apcc009 LIKE apcc_t.apcc009, #发票号码
       apcc010 LIKE apcc_t.apcc010, #发票日期
       apcc011 LIKE apcc_t.apcc011, #交易单据日期
       apcc012 LIKE apcc_t.apcc012, #立账日期
       apcc013 LIKE apcc_t.apcc013, #交易认定日期
       apcc014 LIKE apcc_t.apcc014, #出入库扣账日期
       apcc100 LIKE apcc_t.apcc100, #交易原币种
       apcc101 LIKE apcc_t.apcc101, #原币汇率
       apcc102 LIKE apcc_t.apcc102, #原币重估后汇率
       apcc103 LIKE apcc_t.apcc103, #NO USE
       apcc104 LIKE apcc_t.apcc104, #NO USE
       apcc105 LIKE apcc_t.apcc105, #NO USE
       apcc106 LIKE apcc_t.apcc106, #NO USE
       apcc107 LIKE apcc_t.apcc107, #NO USE
       apcc108 LIKE apcc_t.apcc108, #原币应付金额
       apcc109 LIKE apcc_t.apcc109, #原币付款冲账金额
       apcc113 LIKE apcc_t.apcc113, #重评价调整数
       apcc114 LIKE apcc_t.apcc114, #NO USE
       apcc115 LIKE apcc_t.apcc115, #NO USE
       apcc116 LIKE apcc_t.apcc116, #NO USE
       apcc117 LIKE apcc_t.apcc117, #NO USE
       apcc118 LIKE apcc_t.apcc118, #本币应付金额
       apcc119 LIKE apcc_t.apcc119, #本币付款冲账金额
       apcc120 LIKE apcc_t.apcc120, #本位币二币种
       apcc121 LIKE apcc_t.apcc121, #本位币二汇率
       apcc122 LIKE apcc_t.apcc122, #本位币二重估后汇率
       apcc123 LIKE apcc_t.apcc123, #重评价调整数
       apcc124 LIKE apcc_t.apcc124, #NO USE
       apcc125 LIKE apcc_t.apcc125, #NO USE
       apcc126 LIKE apcc_t.apcc126, #NO USE
       apcc127 LIKE apcc_t.apcc127, #NO USE
       apcc128 LIKE apcc_t.apcc128, #本位币二应付金额
       apcc129 LIKE apcc_t.apcc129, #本位币二付款冲账金额
       apcc130 LIKE apcc_t.apcc130, #本位币三币种
       apcc131 LIKE apcc_t.apcc131, #本位币三汇率
       apcc132 LIKE apcc_t.apcc132, #本位币三重估后汇率
       apcc133 LIKE apcc_t.apcc133, #重评价调整数
       apcc134 LIKE apcc_t.apcc134, #NO USE
       apcc135 LIKE apcc_t.apcc135, #NO USE
       apcc136 LIKE apcc_t.apcc136, #NO USE
       apcc137 LIKE apcc_t.apcc137, #NO USE
       apcc138 LIKE apcc_t.apcc138, #本位币三应付金额
       apcc139 LIKE apcc_t.apcc139, #本位币三付款冲账金额
       apccud001 LIKE apcc_t.apccud001, #自定义字段(文本)001
       apccud002 LIKE apcc_t.apccud002, #自定义字段(文本)002
       apccud003 LIKE apcc_t.apccud003, #自定义字段(文本)003
       apccud004 LIKE apcc_t.apccud004, #自定义字段(文本)004
       apccud005 LIKE apcc_t.apccud005, #自定义字段(文本)005
       apccud006 LIKE apcc_t.apccud006, #自定义字段(文本)006
       apccud007 LIKE apcc_t.apccud007, #自定义字段(文本)007
       apccud008 LIKE apcc_t.apccud008, #自定义字段(文本)008
       apccud009 LIKE apcc_t.apccud009, #自定义字段(文本)009
       apccud010 LIKE apcc_t.apccud010, #自定义字段(文本)010
       apccud011 LIKE apcc_t.apccud011, #自定义字段(数字)011
       apccud012 LIKE apcc_t.apccud012, #自定义字段(数字)012
       apccud013 LIKE apcc_t.apccud013, #自定义字段(数字)013
       apccud014 LIKE apcc_t.apccud014, #自定义字段(数字)014
       apccud015 LIKE apcc_t.apccud015, #自定义字段(数字)015
       apccud016 LIKE apcc_t.apccud016, #自定义字段(数字)016
       apccud017 LIKE apcc_t.apccud017, #自定义字段(数字)017
       apccud018 LIKE apcc_t.apccud018, #自定义字段(数字)018
       apccud019 LIKE apcc_t.apccud019, #自定义字段(数字)019
       apccud020 LIKE apcc_t.apccud020, #自定义字段(数字)020
       apccud021 LIKE apcc_t.apccud021, #自定义字段(日期时间)021
       apccud022 LIKE apcc_t.apccud022, #自定义字段(日期时间)022
       apccud023 LIKE apcc_t.apccud023, #自定义字段(日期时间)023
       apccud024 LIKE apcc_t.apccud024, #自定义字段(日期时间)024
       apccud025 LIKE apcc_t.apccud025, #自定义字段(日期时间)025
       apccud026 LIKE apcc_t.apccud026, #自定义字段(日期时间)026
       apccud027 LIKE apcc_t.apccud027, #自定义字段(日期时间)027
       apccud028 LIKE apcc_t.apccud028, #自定义字段(日期时间)028
       apccud029 LIKE apcc_t.apccud029, #自定义字段(日期时间)029
       apccud030 LIKE apcc_t.apccud030, #自定义字段(日期时间)030
       apcc015 LIKE apcc_t.apcc015, #付款条件
       apcc016 LIKE apcc_t.apcc016, #账款类型
       apcc017 LIKE apcc_t.apcc017  #采购单号
       END RECORD
   #161219-00014#2--add--e--
   DEFINE l_ooab002        LIKE ooab_t.ooab002
   DEFINE l_xrca001_str    STRING
   DEFINE l_apca001_str    STRING
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_tot1           LIKE nmbb_t.nmbb006   #原幣金額
   DEFINE l_tot2           LIKE nmbb_t.nmbb007   #本幣金額
   DEFINE l_amt1           LIKE nmbb_t.nmbb008   #已沖原幣金額  主帳套
   DEFINE l_amt2           LIKE nmbb_t.nmbb009   #已沖本幣金額  主帳套
   DEFINE l_amt3           LIKE nmbb_t.nmbb020   #已沖原幣金額  次帳套一
   DEFINE l_amt4           LIKE nmbb_t.nmbb021   #已沖本幣金額  次帳套一
   DEFINE l_amt5           LIKE nmbb_t.nmbb023   #已沖原幣金額  次帳套二
   DEFINE l_amt6           LIKE nmbb_t.nmbb024   #已沖本幣金額  次帳套二
   DEFINE l_count          LIKE type_t.num5
   DEFINE l_xrcc108        LIKE xrcc_t.xrcc108
   DEFINE l_xrcc118        LIKE xrcc_t.xrcc118
   DEFINE l_xrcc128        LIKE xrcc_t.xrcc128
   DEFINE l_xrcc138        LIKE xrcc_t.xrcc138
   DEFINE l_apcc108        LIKE apcc_t.apcc108
   DEFINE l_apcc118        LIKE apcc_t.apcc118
   DEFINE l_apcc128        LIKE apcc_t.apcc128
   DEFINE l_apcc138        LIKE apcc_t.apcc138
   DEFINE l_str            LIKE type_t.chr500
   DEFINE l_amt_xrce119    LIKE xrce_t.xrce119   #161013-00003#2 Add
  

   LET g_cnt1 = 0
   LET g_cnt2 = 0
   LET g_cnt3 = 0
   #主畫面選擇未沖帳款全部產生時不考慮差異問題
   #主畫面選擇依收款金額顯示相符未沖帳款時且存在差異金額時,需要考慮差異處理
   
   LET l_seq = 0
   LET l_trans = 0
   #匯入收款資料
   FOREACH axrp400_nm_curs USING p_nmbb026 INTO l_nmbbdocno,l_nmbbseq
      
      #賬務資料獲取
      INITIALIZE l_nmbb.* TO NULL
      #161219-00014#2--mark--s--
#      SELECT * INTO l_nmbb.* FROM nmbb_t
#       WHERE nmbbent = g_enterprise AND nmbbdocno = l_nmbbdocno AND nmbbseq = l_nmbbseq
#      SELECT * INTO l_nmba.* FROM nmba_t
#       WHERE nmbaent = g_enterprise AND nmbadocno = l_nmbbdocno
      #161219-00014#2--mark--e-- 
      #161219-00014#2--add--s--
      SELECT nmbbent,nmbbcomp,nmbbdocno,nmbbseq,nmbborga,nmbblegl,nmbb001,nmbb002,nmbb003,nmbb004,nmbb005,
      nmbb006,nmbb007,nmbb008,nmbb009,nmbb010,nmbb011,nmbb012,nmbb013,nmbb014,nmbb015,nmbb016,nmbb017,
      nmbb018,nmbb019,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,nmbb025,nmbb026,nmbb027,nmbb028,nmbb029,
      nmbb030,nmbb031,nmbb032,nmbb033,nmbb034,nmbb035,nmbb036,nmbb037,nmbb038,nmbb039,nmbb040,nmbb041,
      nmbb042,nmbb043,nmbb044,nmbb045,nmbb046,nmbb047,nmbb048,nmbb049,nmbb050,nmbb051,nmbb052,nmbb053,
      nmbb054,nmbb055,nmbb056,nmbb057,nmbb058,nmbb059,nmbb060,nmbb061,nmbb062,nmbb063,nmbb064,nmbb065,
      nmbb066,nmbb067,nmbb068,nmbb069,nmbbud001,nmbbud002,nmbbud003,nmbbud004,nmbbud005,nmbbud006,nmbbud007,
      nmbbud008,nmbbud009,nmbbud010,nmbbud011,nmbbud012,nmbbud013,nmbbud014,nmbbud015,nmbbud016,nmbbud017,
      nmbbud018,nmbbud019,nmbbud020,nmbbud021,nmbbud022,nmbbud023,nmbbud024,nmbbud025,nmbbud026,nmbbud027,
      nmbbud028,nmbbud029,nmbbud030,nmbb070,nmbb071,nmbb072,nmbb073 INTO l_nmbb.* 
        FROM nmbb_t
       WHERE nmbbent = g_enterprise AND nmbbdocno = l_nmbbdocno AND nmbbseq = l_nmbbseq
       
      SELECT nmbaent,nmbaownid,nmbaowndp,nmbacrtid,nmbacrtdp,nmbacrtdt,nmbamodid,nmbamoddt,nmbacnfid,nmbacnfdt,
      nmbastus,nmbacomp,nmbadocno,nmbadocdt,nmbasite,nmba001,nmba002,nmba003,nmba004,nmba005,nmba006,nmba007,
      nmba008,nmba009,nmba010,nmba011,nmbaud001,nmbaud002,nmbaud003,nmbaud004,nmbaud005,nmbaud006,nmbaud007,
      nmbaud008,nmbaud009,nmbaud010,nmbaud011,nmbaud012,nmbaud013,nmbaud014,nmbaud015,nmbaud016,nmbaud017,
      nmbaud018,nmbaud019,nmbaud020,nmbaud021,nmbaud022,nmbaud023,nmbaud024,nmbaud025,nmbaud026,nmbaud027,
      nmbaud028,nmbaud029,nmbaud030,nmba012,nmba013,nmba014,nmba015 INTO l_nmba.* 
        FROM nmba_t
       WHERE nmbaent = g_enterprise AND nmbadocno = l_nmbbdocno
      #161219-00014#2--add--e--
      SELECT nmbb006,nmbb007,nmbb008,nmbb009,nmbb020,nmbb021,nmbb023,nmbb024
        INTO l_tot1,l_tot2,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6
        FROM nmbb_t
       WHERE nmbbent  = g_enterprise
         AND nmbbdocno= l_nmbb.nmbbdocno
         AND nmbbseq  = l_nmbb.nmbbseq
      IF g_ls = 1 THEN
         LET l_tot1 = l_tot1 - l_amt1
         LET l_tot2 = l_tot2 - l_amt2
      ELSE
         IF g_ls = 2 THEN
           LET l_tot1 = l_tot1 - l_amt3
           LET l_tot2 = l_tot2 - l_amt4
         ELSE
           LET l_tot1 = l_tot1 - l_amt5
           LET l_tot2 = l_tot2 - l_amt6
         END IF
      END IF
      LET l_str = l_nmbb.nmbbdocno,"|",l_nmbb.nmbbseq
      IF l_tot1 = 0 OR l_tot2 = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_str
         LET g_errparam.code = 'axr-00054'
#         LET g_errparam.replace[1] = l_nmbb.nmbbdocno
#         LET g_errparam.replace[2] = l_nmbb.nmbbseq
         
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CONTINUE FOREACH
      END IF

      #其他資料獲取
      IF l_nmba.nmba006 = 'N' THEN   #160530-00005#5 Add
         #160926-00026#1 Mark ---(S)---
        #SELECT glab005 INTO l_xrce016 FROM glab_t
        # #WHERE glabld = g_master.xrdald  #160905-00002#7 mark
        # WHERE glabent= g_enterprise    #160905-00002#7
        #   AND glabld = g_master.xrdald #160905-00002#7
        #   AND glab001= '40'
        #   AND glab002= '40'
        #   AND glab003= l_nmbb.nmbb003
         #160926-00026#1 Mark ---(E)---
         #160926-00026#1 Add  ---(S)---
         #抓取科目
         IF l_nmbb.nmbb029 = '10' OR l_nmbb.nmbb029 = '20' THEN   #160929-00026#1 Mod
            #借方科目: 依 anmi121  設定 
            SELECT DISTINCT glab005 INTO l_xrce016
              FROM glab_t
             WHERE glabent = g_enterprise 
               AND glabld  = g_master.xrdald   #160929-00026#1 Mod
               AND glab001 = '40'
               AND glab002 = '40'     
               AND glab003 = l_nmbb.nmbb003  #交易帳戶編號
         END IF
         #依agli190设定
         IF l_nmbb.nmbb029 MATCHES '[3456]0' THEN   #160929-00026#1 Mod
            SELECT DISTINCT glab005 INTO l_xrce016
              FROM glab_t
             WHERE glabent = g_enterprise 
               AND glabld  = g_master.xrdald   #160929-00026#1 Mod
               AND glab001 = '21'
               AND glab002 = l_nmbb.nmbb029   #160929-00026#1 Mod
               AND glab003 = l_nmbb.nmbb028
         END IF
         #160926-00026#1 Add  ---(E)---
     #160530-00005#5 Add  ---(S)---
      ELSE
         SELECT glab005 INTO l_xrce016 FROM glab_t
          #WHERE glabld = g_master.xrdald  #160905-00002#7 mark
          WHERE glabent= g_enterprise    #160905-00002#7
            AND glabld = g_master.xrdald #160905-00002#7
            AND glab001= '41'
            AND glab002= '8714'
            AND glab003= 'F'
      END IF
     #160530-00005#5 Add  ---(E)---
      IF l_nmba.nmba003 = 'anmt510' THEN
         LET l_xrde.xrde006 = '10'
      END IF
      IF l_nmba.nmba003 = 'anmt540' THEN
         SELECT ooia002 INTO l_xrde.xrde006 FROM ooia_t
          WHERE ooiaent = g_enterprise AND ooia001 = l_nmbb.nmbb028
      END IF

      LET l_xrde.xrdeent = g_enterprise
      LET l_xrde.xrdecomp= g_glaa.glaacomp
      LET l_xrde.xrdeld  = g_master.xrdald
      LET l_xrde.xrdedocno= g_xrdadocno
      LET l_xrde.xrdeseq = l_seq + 1
      LET l_xrde.xrdesite= l_nmbb.nmbbcomp
      LET l_xrde.xrdeorga= l_nmbb.nmbborga
#      LET l_xrde.xrde001 = l_nmba.nmba003 #161129-00018#1 mark
      LET l_xrde.xrde001 = 'axrt400' #161129-00018#1 add
      LET l_xrde.xrde002 = 10
      LET l_xrde.xrde003 = l_nmbb.nmbbdocno
      LET l_xrde.xrde004 = l_nmbb.nmbbseq
      LET l_xrde.xrde006 = l_nmbb.nmbb029
     #LET l_xrde.xrde007 = l_nmbb.nmbb006
      LET l_xrde.xrde007 = l_nmbb.nmbb028   #161125-00053#1 Add
      LET l_xrde.xrde008 = l_nmbb.nmbb003   #161013-00013#1 Umark
      LET l_xrde.xrde010 = ''
      LET l_xrde.xrde011 = l_nmbb.nmbb002
      LET l_xrde.xrde012 = l_nmbb.nmbb010
      LET l_xrde.xrde013 = ''
      LET l_xrde.xrde014 = ''
      SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
       WHERE gzcb002 = '10'
         AND gzcb001 = '8306'
      IF l_gzcb003 = 'D' THEN
         LET l_xrde.xrde015 = 'D'
      ELSE
         LET l_xrde.xrde015 = 'C'
      END IF
      LET l_xrde.xrde016 = l_xrce016
      LET l_xrde.xrde017 = ''
      LET l_xrde.xrde018 = ''
      LET l_xrde.xrde019 = ''
      LET l_xrde.xrde020 = ''
      LET l_xrde.xrde022 = ''
      LET l_xrde.xrde023 = ''
      LET l_xrde.xrde028 = ''
      LET l_xrde.xrde029 = ''
      LET l_xrde.xrde030 = ''
      LET l_xrde.xrde035 = ''
      LET l_xrde.xrde036 = ''
      LET l_xrde.xrde038 = ''
      LET l_xrde.xrde039 = ''
      LET l_xrde.xrde040 = ''
      LET l_xrde.xrde041 = ''
      LET l_xrde.xrde042 = ''
      LET l_xrde.xrde043 = ''
      LET l_xrde.xrde044 = ''
      LET l_xrde.xrde045 = ''
      LET l_xrde.xrde046 = ''
      LET l_xrde.xrde047 = ''
      LET l_xrde.xrde048 = ''
      LET l_xrde.xrde049 = ''
      LET l_xrde.xrde050 = ''
      LET l_xrde.xrde051 = ''
      LET l_xrde.xrde100 = l_nmbb.nmbb004
      LET l_xrde.xrde101 = l_nmbb.nmbb005
      SELECT SUM(xrde109),SUM(xrde119),SUM(xrde129),SUM(xrde139) INTO l_xrde109,l_xrde119,l_xrde129,l_xrde139 FROM xrde_t,xrda_t
       WHERE xrdaent   = g_enterprise
         AND xrdaent   = xrdeent
         AND xrdald    = xrdeld
         AND xrdadocno = xrdedocno
         AND xrde003   = l_nmbb.nmbbdocno
         AND xrde004   = l_nmbb.nmbbseq
         AND xrdastus  = 'N'
      IF cl_null(l_xrde109) THEN LET l_xrde109 = 0 END IF
      IF cl_null(l_xrde119) THEN LET l_xrde119 = 0 END IF
      IF cl_null(l_xrde129) THEN LET l_xrde129 = 0 END IF
      IF cl_null(l_xrde139) THEN LET l_xrde139 = 0 END IF
      CASE
         WHEN g_ls = 1
            LET l_xrde.xrde109 = l_nmbb.nmbb006 - l_nmbb.nmbb008 - l_xrde109
            LET l_xrde.xrde119 = l_nmbb.nmbb007 - l_nmbb.nmbb009 - l_xrde119
         WHEN g_ls = 2
            LET l_xrde.xrde109 = l_nmbb.nmbb006 - l_nmbb.nmbb020 - l_xrde109
            LET l_xrde.xrde119 = l_nmbb.nmbb007 - l_nmbb.nmbb021 - l_xrde119
         WHEN g_ls = 3
            LET l_xrde.xrde109 = l_nmbb.nmbb006 - l_nmbb.nmbb023 - l_xrde109
            LET l_xrde.xrde119 = l_nmbb.nmbb007 - l_nmbb.nmbb024 - l_xrde119
      END CASE
      LET l_xrde.xrde120 = l_nmbb.nmbb011
      LET l_xrde.xrde121 = l_nmbb.nmbb012
      LET l_xrde.xrde129 = l_nmbb.nmbb013 - l_nmbb.nmbb014 - l_xrde129
      LET l_xrde.xrde130 = l_nmbb.nmbb015
      LET l_xrde.xrde131 = l_nmbb.nmbb016
      LET l_xrde.xrde139 = l_nmbb.nmbb017 - l_nmbb.nmbb018 - l_xrde139
      #160912-00038#1 add--s
      LET l_xrde.xrde032 = NULL
      SELECT nmbadocdt INTO l_xrde.xrde032 FROM nmba_t
       WHERE nmbaent  = g_enterprise
         AND nmbacomp = l_nmbb.nmbbcomp
         AND nmbadocno= l_nmbb.nmbbdocno
      #160912-00038#1 add--

      #INSERT INTO xrde_t VALUES (l_xrde.*)  #161219-00014#2--mark--
      #161219-00014#2--add--s--
      INSERT INTO xrde_t(xrdeent,xrdecomp,xrdeld,xrdedocno,xrdeseq,xrdesite,xrdeorga,xrde001,xrde002,xrde003,xrde004,xrde006,xrde007,xrde008,
      xrde010,xrde011,xrde012,xrde013,xrde014,xrde015,xrde016,xrde017,xrde018,xrde019,xrde020,xrde022,xrde023,xrde028,xrde029,xrde030,xrde035,
      xrde036,xrde038,xrde039,xrde040,xrde041,xrde042,xrde043,xrde044,xrde045,xrde046,xrde047,xrde048,xrde049,xrde050,xrde051,xrde100,xrde101,
      xrde109,xrde119,xrde120,xrde121,xrde129,xrde130,xrde131,xrde139,xrde032,xrde108,xrde118) VALUES (l_xrde.xrdeent,l_xrde.xrdecomp,l_xrde.xrdeld,
      l_xrde.xrdedocno,l_xrde.xrdeseq,l_xrde.xrdesite,l_xrde.xrdeorga,l_xrde.xrde001,l_xrde.xrde002,l_xrde.xrde003,l_xrde.xrde004,l_xrde.xrde006,l_xrde.xrde007,
      l_xrde.xrde008,l_xrde.xrde010,l_xrde.xrde011,l_xrde.xrde012,l_xrde.xrde013,l_xrde.xrde014,l_xrde.xrde015,l_xrde.xrde016,l_xrde.xrde017,l_xrde.xrde018,
      l_xrde.xrde019,l_xrde.xrde020,l_xrde.xrde022,l_xrde.xrde023,l_xrde.xrde028,l_xrde.xrde029,l_xrde.xrde030,l_xrde.xrde035,l_xrde.xrde036,l_xrde.xrde038,
      l_xrde.xrde039,l_xrde.xrde040,l_xrde.xrde041,l_xrde.xrde042,l_xrde.xrde043,l_xrde.xrde044,l_xrde.xrde045,l_xrde.xrde046,l_xrde.xrde047,l_xrde.xrde048,
      l_xrde.xrde049,l_xrde.xrde050,l_xrde.xrde051,l_xrde.xrde100,l_xrde.xrde101,l_xrde.xrde109,l_xrde.xrde119,l_xrde.xrde120,l_xrde.xrde121,l_xrde.xrde129,
      l_xrde.xrde130,l_xrde.xrde131,l_xrde.xrde139,l_xrde.xrde032,l_xrde.xrde108,l_xrde.xrde118)      
      #161219-00014#2--add--e--
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'xrde_t'
         LET g_errparam.extend = SQLCA.sqlcode
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
         EXIT FOREACH
      ELSE
         LET g_cnt1 = g_cnt1 + 1
      END IF

      LET l_seq = l_seq + 1

      LET l_trans = l_trans + l_xrde.xrde109

   END FOREACH
   IF g_success = 'N' THEN
      RETURN
   END IF

   #161013-00003#2 Add  ---(S)---
   LET g_amt_xrce119 = 0
   SELECT SUM(xrde109) INTO g_amt_xrce119 FROM xrde_t WHERE xrdeent = g_enterprise   #161104-00045#1 Mod xrde119 --> xrde109
      AND xrdedocno = l_xrde.xrdedocno
      AND xrdeld = l_xrde.xrdeld
   #161013-00003#2 Add  ---(E)---

  #IF l_seq > 1 THEN LET l_seq = l_seq - 1 END IF

   #161114-00028#1 Mod  ---(S)---
   #先处理可能被勾选的负向金额
   LET l_count = 0
   IF g_master.chk = 'Y' THEN 
      
      FOREACH axrp400_sel_apcc_curs USING p_nmbb026 INTO l_apccdocno,l_apccseq,l_apcc001#獲取AR資料
         #161219-00014#2--mark--s--
#         SELECT * INTO l_apca_t.* FROM apca_t WHERE apcaent = g_enterprise AND apcald = g_master.xrdald
#            AND apcadocno = l_apccdocno
#         SELECT * INTO l_apcc_t.* FROM apcc_t WHERE apccent = g_enterprise AND apccld = g_master.xrdald
#            AND apccdocno = l_apccdocno AND apccseq = l_apccseq AND apcc001 = l_apcc001
#         SELECT * INTO l_apcb_t.* FROM apcb_t WHERE apcbent = g_enterprise AND apcbld = g_master.xrdald
#            AND apcbdocno = l_apcc_t.apccdocno AND apcbseq = l_apcc_t.apccseq
         #161219-00014#2--mark--e-- 
         #161219-00014#2--add--s--     
         SELECT apcaent,apcaownid,apcaowndp,apcacrtid,apcacrtdp,apcacrtdt,apcamodid,apcamoddt,apcacnfid,apcacnfdt,apcapstid,apcapstdt,apcastus,
         apcald,apcacomp,apcadocno,apcadocdt,apcasite,apca001,apca003,apca004,apca005,apca006,apca007,apca008,apca009,apca010,apca011,apca012,
         apca013,apca014,apca015,apca016,apca017,apca018,apca019,apca020,apca021,apca022,apca025,apca026,apca027,apca028,apca029,apca030,apca031,
         apca032,apca033,apca034,apca035,apca036,apca037,apca038,apca039,apca040,apca041,apca042,apca043,apca044,apca045,apca046,apca047,apca048,
         apca049,apca050,apca051,apca052,apca053,apca054,apca055,apca056,apca057,apca058,apca059,apca060,apca061,apca062,apca063,apca064,apca065,
         apca066,apca100,apca101,apca103,apca104,apca106,apca107,apca108,apca113,apca114,apca116,apca117,apca118,apca120,apca121,apca123,apca124,
         apca126,apca127,apca128,apca130,apca131,apca133,apca134,apca136,apca137,apca138,apcaud001,apcaud002,apcaud003,apcaud004,apcaud005,apcaud006,
         apcaud007,apcaud008,apcaud009,apcaud010,apcaud011,apcaud012,apcaud013,apcaud014,apcaud015,apcaud016,apcaud017,apcaud018,apcaud019,apcaud020,
         apcaud021,apcaud022,apcaud023,apcaud024,apcaud025,apcaud026,apcaud027,apcaud028,apcaud029,apcaud030,apca067,apca068,apca069,apca070,apca071,
         apca072,apca073 INTO l_apca_t.* 
           FROM apca_t 
          WHERE apcaent = g_enterprise AND apcald = g_master.xrdald
            AND apcadocno = l_apccdocno
            
         SELECT apccent,apccld,apcccomp,apcclegl,apccsite,apccdocno,apccseq,apcc001,apcc002,apcc003,apcc004,apcc005,apcc006,apcc007,apcc008,
         apcc009,apcc010,apcc011,apcc012,apcc013,apcc014,apcc100,apcc101,apcc102,apcc103,apcc104,apcc105,apcc106,apcc107,apcc108,apcc109,
         apcc113,apcc114,apcc115,apcc116,apcc117,apcc118,apcc119,apcc120,apcc121,apcc122,apcc123,apcc124,apcc125,apcc126,apcc127,apcc128,
         apcc129,apcc130,apcc131,apcc132,apcc133,apcc134,apcc135,apcc136,apcc137,apcc138,apcc139,apccud001,apccud002,apccud003,apccud004,
         apccud005,apccud006,apccud007,apccud008,apccud009,apccud010,apccud011,apccud012,apccud013,apccud014,apccud015,apccud016,apccud017,
         apccud018,apccud019,apccud020,apccud021,apccud022,apccud023,apccud024,apccud025,apccud026,apccud027,apccud028,apccud029,apccud030,
         apcc015,apcc016,apcc017 INTO l_apcc_t.* 
           FROM apcc_t 
          WHERE apccent = g_enterprise AND apccld = g_master.xrdald
            AND apccdocno = l_apccdocno AND apccseq = l_apccseq AND apcc001 = l_apcc001
            
         SELECT apcbent,apcbld,apcblegl,apcborga,apcbsite,apcbdocno,apcbseq,apcb001,apcb002,apcb003,apcb004,apcb005,apcb006,apcb007,apcb008,
         apcb009,apcb010,apcb011,apcb012,apcb013,apcb014,apcb015,apcb016,apcb017,apcb018,apcb019,apcb020,apcb021,apcb022,apcb023,apcb024,
         apcb025,apcb026,apcb027,apcb028,apcb029,apcb030,apcb032,apcb033,apcb034,apcb035,apcb036,apcb037,apcb038,apcb039,apcb040,apcb041,
         apcb042,apcb043,apcb044,apcb045,apcb046,apcb047,apcb048,apcb049,apcb050,apcb051,apcb100,apcb101,apcb102,apcb103,apcb104,apcb105,
         apcb106,apcb107,apcb108,apcb111,apcb113,apcb114,apcb115,apcb116,apcb117,apcb118,apcb119,apcb121,apcb123,apcb124,apcb125,apcb126,
         apcb127,apcb128,apcb131,apcb133,apcb134,apcb135,apcb136,apcb137,apcb138,apcbud001,apcbud002,apcbud003,apcbud004,apcbud005,apcbud006,
         apcbud007,apcbud008,apcbud009,apcbud010,apcbud011,apcbud012,apcbud013,apcbud014,apcbud015,apcbud016,apcbud017,apcbud018,apcbud019,
         apcbud020,apcbud021,apcbud022,apcbud023,apcbud024,apcbud025,apcbud026,apcbud027,apcbud028,apcbud029,apcbud030,apcb052,apcb053,apcb054,
         apcb055 INTO l_apcb_t.* 
           FROM apcb_t 
          WHERE apcbent = g_enterprise AND apcbld = g_master.xrdald
            AND apcbdocno = l_apcc_t.apccdocno AND apcbseq = l_apcc_t.apccseq
         #161219-00014#2--add--e--         
         #計算預沖金額
         LET l_xrce109 = 0   LET l_xrce119 = 0
         LET l_xrce129 = 0   LET l_xrce139 = 0
         SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139) INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
           FROM xrce_t,xrda_t
          WHERE xrdaent   = xrceent
            AND xrdald    = xrceld
            AND xrdadocno = xrcedocno
            AND xrce003   = l_apcc_t.apccdocno
            AND xrce004   = l_apcc_t.apccseq
            AND xrce005   = l_apcc_t.apcc001
            AND xrdastus  = 'N'
         IF cl_null(l_xrce109) THEN LET l_xrce109 = 0 END IF
         IF cl_null(l_xrce119) THEN LET l_xrce119 = 0 END IF
         IF cl_null(l_xrce129) THEN LET l_xrce129 = 0 END IF
         IF cl_null(l_xrce139) THEN LET l_xrce139 = 0 END IF
         
         SELECT MAX(xrceseq) INTO l_xrce_t.xrceseq
           FROM xrce_t
          WHERE xrceent = g_enterprise 
            AND xrceld = g_master.xrdald
            AND xrcedocno = g_xrdadocno
         IF cl_null(l_xrce_t.xrceseq) THEN
            LET l_xrce_t.xrceseq = 1
         ELSE
            LET l_xrce_t.xrceseq = l_xrce_t.xrceseq + 1
         END IF

         LET l_xrce_t.xrceent = g_enterprise
         LET l_xrce_t.xrceld = g_master.xrdald
         LET l_xrce_t.xrcedocno = g_xrdadocno
         LET l_xrce_t.xrcesite  = g_master.xrdasite
         LET l_xrce_t.xrceorga  = l_apcb_t.apcborga
         LET l_apca001_str = l_apca_t.apca001
         LET l_apca001_str = l_apca001_str.substring(1,1)
         IF l_apca001_str = '1' THEN
            LET l_xrce_t.xrce002   = '40'
         END IF
         IF l_apca001_str = '2' AND l_apca_t.apca001 <> '25' THEN 
            LET l_xrce_t.xrce002   = '41'
         END IF
         IF l_apca_t.apca001 = '25' THEN 
            LET l_xrce_t.xrce002   = '42'
         END IF
         
         IF l_xrce_t.xrce002 = '40' OR l_xrce_t.xrce002 = '41' OR l_xrce_t.xrce002 = '42' THEN       
            #檢查資料1:存在性;2.可沖金額大於0
            SELECT COUNT(*) INTO l_count FROM apca_t,apcc_t
             WHERE apcaent = g_enterprise
               AND apcaent = apccent
               AND apcadocno = apccdocno
               AND apcald = apccld
               AND apccld = g_master.xrdald
               AND apccdocno = l_apcc_t.apccdocno
               AND apccseq = l_apcc_t.apccseq
               AND apcc001 = l_apcc_t.apcc001
            SELECT SUM(apcc108 - apcc109),SUM(apcc118 - apcc119 + apcc113),SUM(apcc128 - apcc129 + apcc123),SUM(apcc138 - apcc139 + apcc133) 
              INTO l_apcc108,l_apcc118,l_apcc128,l_apcc138
              FROM apcc_t
             WHERE apccent = g_enterprise
               AND apccld = g_master.xrdald
               AND apccdocno = l_apcc_t.apccdocno
               AND apccseq = l_apcc_t.apccseq
               AND apcc001 = l_apcc_t.apcc001
        
            IF cl_null(l_apcc108) THEN LET l_apcc108 = 0 END IF
            IF cl_null(l_apcc118) THEN LET l_apcc118 = 0 END IF
            IF cl_null(l_apcc128) THEN LET l_apcc128 = 0 END IF
            IF cl_null(l_apcc138) THEN LET l_apcc138 = 0 END IF
            
            LET l_str = l_apcc_t.apccdocno,"|",l_apcc_t.apccseq,"|",l_apcc_t.apcc001
            CASE
               WHEN l_count = 0
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = l_str
                  LET g_errparam.code = 'axr-00333'
#                  LET g_errparam.replace[1] = l_apcc_t.apccdocno
#                  LET g_errparam.replace[2] = l_apcc_t.apccseq
#                  LET g_errparam.replace[3] = l_apcc_t.apcc001
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE FOREACH
               WHEN l_apcc108 = 0 OR l_apcc118 = 0
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = l_str
                  LET g_errparam.code = 'axr-00058'
#                  LET g_errparam.replace[1] = l_apcc_t.apccdocno
#                  LET g_errparam.replace[2] = l_apcc_t.apccseq
#                  LET g_errparam.replace[3] = l_apcc_t.apcc001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE FOREACH
            END CASE
         END IF
         
         LET l_xrce_t.xrce010   = ''
         SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
          WHERE gzcb002 = l_xrce_t.xrce002
            AND gzcb001 = '8306'
         IF l_gzcb003 = 'D' THEN
            LET l_xrce_t.xrce015   =  'D'
         ELSE
            LET l_xrce_t.xrce015   =  'C'
         END IF
         
         
         LET l_xrce_t.xrcecomp = l_apcc_t.apcccomp
         LET l_xrce_t.xrce001  = 'axrt400'
         LET l_xrce_t.xrce003  = l_apcc_t.apccdocno
         LET l_xrce_t.xrce004  = l_apcc_t.apccseq
         LET l_xrce_t.xrce005  = l_apcc_t.apcc001
         LET l_xrce_t.xrce016  = l_apca_t.apca035
         LET l_xrce_t.xrce017  = l_apca_t.apca014
         LET l_xrce_t.xrce018  = l_apca_t.apca015
         LET l_xrce_t.xrce027  = 'N'
         LET l_xrce_t.xrce028  = 0
         LET l_xrce_t.xrce036  = l_apca_t.apca006
         LET l_xrce_t.xrce038  = l_apca_t.apca004     #160426-00016
         LET l_xrce_t.xrce053  = l_apcc_t.apcc008
         LET l_xrce_t.xrce054  = l_apcc_t.apcc009
         LET l_xrce_t.xrce100  = l_apcc_t.apcc100
         LET l_xrce_t.xrce101  = l_apcc_t.apcc102     #20150313  apcc101 ---->apcc102
         LET l_xrce_t.xrce104   = 0
         LET l_xrce_t.xrce114   = 0
         LET l_xrce_t.xrce120  = l_apcc_t.apcc120
         LET l_xrce_t.xrce121  = l_apcc_t.apcc122
         LET l_xrce_t.xrce130  = l_apcc_t.apcc130
         LET l_xrce_t.xrce131  = l_apcc_t.apcc132
         
         LET l_xrce_t.xrce109  = l_apcc_t.apcc108 - l_apcc_t.apcc109 - l_xrce109
         LET l_xrce_t.xrce119  = l_apcc_t.apcc118 - l_apcc_t.apcc119 - l_xrce119
         IF l_xrce_t.xrce109 <= 0 THEN CONTINUE FOREACH END IF
         LET l_xrce_t.xrce129  = l_apcc_t.apcc128 - l_apcc_t.apcc129 - l_xrce129
         LET l_xrce_t.xrce139  = l_apcc_t.apcc138 - l_apcc_t.apcc139 - l_xrce139
      
         IF g_glaa.glaa015 = 'N' THEN
            LET l_xrce_t.xrce120 = ''
            LET l_xrce_t.xrce121 = 0
            LET l_xrce_t.xrce129 = 0
         END IF
         
         IF g_glaa.glaa019 = 'N' THEN
            LET l_xrce_t.xrce130 = ''
            LET l_xrce_t.xrce131 = 0
            LET l_xrce_t.xrce139 = 0
         END IF

         #161114-00028#1 Mark ---(S)---
         #161013-00003#2 Add  ---(S)---
        #IF l_xrce.xrce119 <= g_amt_xrce119 THEN
        #   LET g_amt_xrce119 = l_xrce.xrce119
        #ELSE
        #   LET l_xrce.xrce119= g_amt_xrce119
        #   LET l_xrce.xrce109=l_xrce.xrce119 / l_xrce.xrce101
        #   CALL s_curr_round_ld('1',l_xrce.xrceld,l_xrce.xrce100,l_xrce.xrce109,2)
        #      RETURNING l_success,g_errno,l_xrce.xrce109
        #   LET g_amt_xrce119 = 0
        #END IF
         #161013-00003#2 Add  ---(E)---
         #161114-00028#1 Mark ---(E)---
         #161114-00028#1 Add  ---(S)---
         IF l_xrce_t.xrce015 = 'D' THEN
            LET g_amt_xrce119 = g_amt_xrce119 + l_xrce_t.xrce119
         ELSE
            IF l_xrce_t.xrce119 <= g_amt_xrce119 THEN
               LET g_amt_xrce119 = g_amt_xrce119 - l_xrce_t.xrce119
            ELSE
               LET l_xrce_t.xrce119= g_amt_xrce119
               LET l_xrce_t.xrce109=l_xrce_t.xrce119 / l_xrce_t.xrce101
               CALL s_curr_round_ld('1',l_xrce_t.xrceld,l_xrce_t.xrce100,l_xrce_t.xrce109,2)
                  RETURNING l_success,g_errno,l_xrce_t.xrce109
               LET g_amt_xrce119 = 0
            END IF
         END IF
         #161114-00028#1 Add  ---(E)---

         #INSERT INTO xrce_t VALUES(l_xrce_t.*)
         INSERT INTO xrce_t(xrceent,xrcecomp,xrceorga,xrcesite,xrceld,xrcedocno,xrceseq,xrce001,xrce002,xrce003,
                            xrce004,xrce005,xrce010,xrce015,xrce016,xrce017,xrce018,xrce027,xrce028,xrce036,
                            xrce053,xrce054,xrce100,xrce101,xrce104,xrce114,xrce109,
                            xrce119,xrce120,xrce121,xrce129,xrce130,xrce131,xrce139)
                     VALUES(l_xrce_t.xrceent,l_xrce_t.xrcecomp ,l_xrce_t.xrceorga,l_xrce_t.xrcesite,
                            l_xrce_t.xrceld ,l_xrce_t.xrcedocno,l_xrce_t.xrceseq ,l_xrce_t.xrce001 ,
                            l_xrce_t.xrce002,l_xrce_t.xrce003  ,l_xrce_t.xrce004 ,l_xrce_t.xrce005 ,
                            l_xrce_t.xrce010,l_xrce_t.xrce015  ,l_xrce_t.xrce016 ,l_xrce_t.xrce017 ,
                            l_xrce_t.xrce018,l_xrce_t.xrce027  ,l_xrce_t.xrce028 ,l_xrce_t.xrce036 ,
                            l_xrce_t.xrce053,l_xrce_t.xrce054  ,l_xrce_t.xrce100 ,l_xrce_t.xrce101 ,
                            l_xrce_t.xrce104,l_xrce_t.xrce114  ,l_xrce_t.xrce109 ,l_xrce_t.xrce119 ,
                            l_xrce_t.xrce120,l_xrce_t.xrce121  ,l_xrce_t.xrce129 ,l_xrce_t.xrce130 ,
                            l_xrce_t.xrce131,l_xrce_t.xrce139
                           )
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'xrce_t'
            LET g_errparam.extend = SQLCA.sqlcode
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N' 
            EXIT FOREACH
         ELSE
            LET g_cnt3 = g_cnt3 + 1
         END IF

         #161013-00003#2 Add  ---(S)---
         IF g_amt_xrce119 = 0 THEN
            EXIT FOREACH
         END IF
         #161013-00003#2 Add  ---(E)---

      END FOREACH
      IF g_success = 'N' THEN
         RETURN
      END IF
   END IF

   #161013-00003#2 Add  ---(S)---
   IF g_amt_xrce119 = 0 THEN
      RETURN
   END IF
   #161013-00003#2 Add  ---(E)---

   LET l_seq = 0
   #匯入帳款資料
   FOREACH axrp400_ar_curs USING p_nmbb026 INTO l_xrccdocno,l_xrccseq,l_xrcc001
      #獲取AR資料
      #161219-00014#2--mark--s--
#      SELECT * INTO l_xrca.* FROM xrca_t WHERE xrcaent = g_enterprise AND xrcald = g_master.xrdald
#         AND xrcadocno = l_xrccdocno
#      SELECT * INTO l_xrcb.* FROM xrcb_t WHERE xrcbent = g_enterprise AND xrcbld = g_master.xrdald
#         AND xrcbdocno = l_xrccdocno AND xrcbseq = l_xrccseq
#      SELECT * INTO l_xrcc.* FROM xrcc_t WHERE xrccent = g_enterprise AND xrccld = g_master.xrdald
#         AND xrccdocno = l_xrccdocno AND xrccseq = l_xrccseq AND xrcc001 = l_xrcc001
      #161219-00014#2--mark--e--
      #161219-00014#2--add--s---
      SELECT xrcaent,xrcaownid,xrcaowndp,xrcacrtid,xrcacrtdp,xrcacrtdt,xrcamodid,xrcamoddt,xrcacnfid,xrcacnfdt,
      xrcapstid,xrcapstdt,xrcastus,xrcacomp,xrcald,xrcadocno,xrcadocdt,xrca001,xrcasite,xrca003,xrca004,xrca005,
      xrca006,xrca007,xrca008,xrca009,xrca010,xrca011,xrca012,xrca013,xrca014,xrca015,xrca016,xrca017,xrca018,
      xrca019,xrca020,xrca021,xrca022,xrca023,xrca024,xrca025,xrca026,xrca028,xrca029,xrca030,xrca031,xrca032,
      xrca033,xrca034,xrca035,xrca036,xrca037,xrca038,xrca039,xrca040,xrca041,xrca042,xrca043,xrca044,xrca045,
      xrca046,xrca047,xrca048,xrca049,xrca050,xrca051,xrca052,xrca053,xrca054,xrca055,xrca056,xrca057,xrca058,
      xrca059,xrca060,xrca061,xrca062,xrca063,xrca064,xrca065,xrca066,xrca100,xrca101,xrca103,xrca104,xrca106,
      xrca107,xrca108,xrca113,xrca114,xrca116,xrca117,xrca118,xrca120,xrca121,xrca123,xrca124,xrca126,xrca127,
      xrca128,xrca130,xrca131,xrca133,xrca134,xrca136,xrca137,xrca138,xrcaud001,xrcaud002,xrcaud003,xrcaud004,
      xrcaud005,xrcaud006,xrcaud007,xrcaud008,xrcaud009,xrcaud010,xrcaud011,xrcaud012,xrcaud013,xrcaud014,xrcaud015,
      xrcaud016,xrcaud017,xrcaud018,xrcaud019,xrcaud020,xrcaud021,xrcaud022,xrcaud023,xrcaud024,xrcaud025,xrcaud026,
      xrcaud027,xrcaud028,xrcaud029,xrcaud030 INTO l_xrca.* 
        FROM xrca_t 
       WHERE xrcaent = g_enterprise AND xrcald = g_master.xrdald
         AND xrcadocno = l_xrccdocno
         
      SELECT xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,xrcb003,xrcb004,xrcb005,xrcb006,xrcb007,
      xrcb008,xrcb009,xrcblegl,xrcb010,xrcb011,xrcb012,xrcb013,xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,xrcb020,
      xrcb021,xrcb022,xrcb023,xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,xrcb034,
      xrcb035,xrcb036,xrcb037,xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,xrcb044,xrcb045,xrcb046,xrcb047,xrcb048,
      xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,xrcb102,xrcb103,xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,
      xrcb116,xrcb117,xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,xrcb134,xrcb135,xrcb136,
      xrcbud001,xrcbud002,xrcbud003,xrcbud004,xrcbud005,xrcbud006,xrcbud007,xrcbud008,xrcbud009,xrcbud010,xrcbud011,
      xrcbud012,xrcbud013,xrcbud014,xrcbud015,xrcbud016,xrcbud017,xrcbud018,xrcbud019,xrcbud020,xrcbud021,xrcbud022,
      xrcbud023,xrcbud024,xrcbud025,xrcbud026,xrcbud027,xrcbud028,xrcbud029,xrcbud030,xrcb052,xrcb053,xrcb054,xrcb055,
      xrcb056,xrcb057,xrcb058,xrcb059,xrcb060,xrcb107 INTO l_xrcb.* 
        FROM xrcb_t 
       WHERE xrcbent = g_enterprise AND xrcbld = g_master.xrdald
         AND xrcbdocno = l_xrccdocno AND xrcbseq = l_xrccseq
         
      SELECT xrccent,xrccld,xrcccomp,xrccdocno,xrccseq,xrcc001,xrcc002,xrcc003,xrcc004,xrcc005,xrcc006,xrcclegl,xrcc008,
      xrcc009,xrccsite,xrcc010,xrcc011,xrcc012,xrcc013,xrcc014,xrcc100,xrcc101,xrcc102,xrcc103,xrcc104,xrcc105,xrcc106,
      xrcc107,xrcc108,xrcc109,xrcc113,xrcc114,xrcc115,xrcc116,xrcc117,xrcc118,xrcc119,xrcc120,xrcc121,xrcc122,xrcc123,
      xrcc124,xrcc125,xrcc126,xrcc127,xrcc128,xrcc129,xrcc130,xrcc131,xrcc132,xrcc133,xrcc134,xrcc135,xrcc136,xrcc137,
      xrcc138,xrcc139,xrccud001,xrccud002,xrccud003,xrccud004,xrccud005,xrccud006,xrccud007,xrccud008,xrccud009,xrccud010,
      xrccud011,xrccud012,xrccud013,xrccud014,xrccud015,xrccud016,xrccud017,xrccud018,xrccud019,xrccud020,xrccud021,xrccud022,
      xrccud023,xrccud024,xrccud025,xrccud026,xrccud027,xrccud028,xrccud029,xrccud030,xrcc015,xrcc016,xrcc017 INTO l_xrcc.* 
        FROM xrcc_t 
       WHERE xrccent = g_enterprise AND xrccld = g_master.xrdald
         AND xrccdocno = l_xrccdocno AND xrccseq = l_xrccseq AND xrcc001 = l_xrcc001
      #161219-00014#2--add--e--
      #其他資料獲取
      LET l_xrca001_str = l_xrca.xrca001
      IF l_xrca001_str.substring(1,1) = '1' THEN
         LET l_xrce.xrce002 = '30'
      END IF 
      IF l_xrca001_str.substring(1,1) = '2' THEN
         LET l_xrce.xrce002 = '31'
      END IF
      
      IF l_xrce.xrce002 = '30' OR l_xrce.xrce002 = '31' THEN
         #檢查資料1:存在性;2.可沖金額大於0
         SELECT COUNT(*) INTO l_count FROM xrca_t,xrcc_t
          WHERE xrcaent = g_enterprise
            AND xrcaent = xrccent
            AND xrcadocno = xrccdocno
            AND xrcald = xrccld
            AND xrccld = g_master.xrdald
            AND xrccdocno = l_xrcc.xrccdocno
            AND xrccseq = l_xrcc.xrccseq
            AND xrcc001 = l_xrcc.xrcc001
         SELECT SUM(xrcc108 - xrcc109),SUM(xrcc118 - xrcc119 + xrcc113),SUM(xrcc128 - xrcc129 + xrcc123),SUM(xrcc138 - xrcc139 + xrcc133) 
           INTO l_xrcc108,l_xrcc118,l_xrcc128,l_xrcc138
           FROM xrcc_t
          WHERE xrccent = g_enterprise
            AND xrccld = g_master.xrdald
            AND xrccdocno = l_xrcc.xrccdocno
            AND xrccseq = l_xrcc.xrccseq
            AND xrcc001 = l_xrcc.xrcc001
       
         IF cl_null(l_xrcc108) THEN LET l_xrcc108 = 0 END IF
         IF cl_null(l_xrcc118) THEN LET l_xrcc118 = 0 END IF
         IF cl_null(l_xrcc128) THEN LET l_xrcc128 = 0 END IF
         IF cl_null(l_xrcc138) THEN LET l_xrcc138 = 0 END IF
         LET l_str = l_xrcc.xrccdocno,"|",l_xrcc.xrccseq,"|",l_xrcc.xrcc001
         CASE
            WHEN l_count = 0
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00067'
               LET g_errparam.extend = l_str
#               LET g_errparam.replace[1] = l_xrcc.xrccdocno
#               LET g_errparam.replace[2] = l_xrcc.xrccseq
#               LET g_errparam.replace[3] = l_xrcc.xrcc001
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CONTINUE FOREACH
            WHEN l_xrcc108 = 0 OR l_xrcc118 = 0
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axr-00058'
               LET g_errparam.extend = l_str
#               LET g_errparam.replace[1] = l_xrcc.xrccdocno
#               LET g_errparam.replace[2] = l_xrcc.xrccseq
#               LET g_errparam.replace[3] = l_xrcc.xrcc001
               
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CONTINUE FOREACH
         END CASE
      END IF
      SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
       WHERE gzcb002 = l_xrce.xrce002
         AND gzcb001 = '8306'
      IF l_gzcb003 = 'D' THEN
         LET l_xrce.xrce015   =  'D'
      ELSE
         LET l_xrce.xrce015   =  'C'
      END IF
      LET l_xrce.xrceent = g_enterprise
      LET l_xrce.xrcecomp= l_xrcc.xrcccomp
      LET l_xrce.xrceld  = g_master.xrdald
      LET l_xrce.xrcedocno= g_xrdadocno

      SELECT MAX(xrceseq) INTO l_xrce.xrceseq
        FROM xrce_t
       WHERE xrceent = g_enterprise 
         AND xrceld = g_master.xrdald
         AND xrcedocno = g_xrdadocno
      IF cl_null(l_xrce.xrceseq) THEN
         LET l_xrce.xrceseq = 1
      ELSE
         LET l_xrce.xrceseq = l_xrce.xrceseq + 1
      END IF

      LET l_xrce.xrcelegl= l_xrcc.xrcclegl
      LET l_xrce.xrcesite= l_xrcc.xrccsite
      LET l_xrce.xrceorga= l_xrcb.xrcborga
#      LET l_xrce.xrce001 = l_xrcb.xrcb001 #161129-00018#1 mark
      LET l_xrce.xrce001 = 'axrt300' #161129-00018#1 add
     #LET l_xrce.xrce002 = '30'
      LET l_xrce.xrce003 = l_xrcc.xrccdocno
      LET l_xrce.xrce004 = l_xrccseq
      LET l_xrce.xrce005 = l_xrcc.xrcc001
      LET l_xrce.xrce006 = ''
      LET l_xrce.xrce007 = l_xrcc.xrcc108 - l_xrcc.xrcc109
      LET l_xrce.xrce008 = l_xrcc.xrccdocno
      LET l_xrce.xrce009 = ''
      LET l_xrce.xrce010 = ''
      LET l_xrce.xrce011 = ''
      LET l_xrce.xrce012 = ''
      LET l_xrce.xrce013 = ''
      LET l_xrce.xrce014 = ''
     #LET l_xrce.xrce015 = 'C'
      LET l_xrce.xrce016 = l_xrca.xrca035
      LET l_xrce.xrce017 = l_xrca.xrca014
      LET l_xrce.xrce018 = l_xrcb.xrcb010
      LET l_xrce.xrce019 = l_xrcb.xrcb011
      LET l_xrce.xrce020 = l_xrcb.xrcb012
      LET l_xrce.xrce021 = l_xrcb.xrcb017
      LET l_xrce.xrce022 = l_xrcb.xrcb015
      LET l_xrce.xrce023 = l_xrcb.xrcb016
      LET l_xrce.xrce024 = l_xrcb.xrcb002
      LET l_xrce.xrce025 = l_xrcb.xrcb003
      LET l_xrce.xrce026 = ''
      LET l_xrce.xrce027 = ''
      LET l_xrce.xrce028 = ''
      LET l_xrce.xrce029 = ''
      LET l_xrce.xrce030 = ''
      LET l_xrce.xrce035 = ''
      LET l_xrce.xrce036 = ''
      LET l_xrce.xrce037 = ''
      LET l_xrce.xrce038 = ''
      LET l_xrce.xrce104 = 0
      LET l_xrce.xrce114 = 0
      LET l_xrce.xrce124 = 0
      LET l_xrce.xrce134 = 0
      LET l_xrce.xrce100 = l_xrcc.xrcc100
      LET l_xrce.xrce101 = l_xrcc.xrcc102
      LET l_xrce.xrce120 = l_xrcc.xrcc120
      LET l_xrce.xrce121 = l_xrcc.xrcc122
      LET l_xrce.xrce130 = l_xrcc.xrcc130
      LET l_xrce.xrce131 = l_xrcc.xrcc132
      CALL axrp400_ar_amt(l_xrccdocno,l_xrccseq,l_xrcc001)
         RETURNING l_xrce.xrce109,l_xrce.xrce119,l_xrce.xrce129,l_xrce.xrce139
      
      IF l_xrce.xrce109 <=0 THEN CONTINUE FOREACH END IF
      #161104-00045#1 Mark ---(S)---
     ##161013-00003#2 Add  ---(S)---
     #IF l_xrce.xrce119 <= g_amt_xrce119 THEN
     #   LET g_amt_xrce119 = l_xrce.xrce119
     #ELSE
     #   LET l_xrce.xrce119= g_amt_xrce119
     #   LET l_xrce.xrce109=l_xrce.xrce119 / l_xrce.xrce101
     #   CALL s_curr_round_ld('1',l_xrce.xrceld,l_xrce.xrce100,l_xrce.xrce109,2)
     #      RETURNING l_success,g_errno,l_xrce.xrce109
     #   LET g_amt_xrce119 = 0
     #END IF
     ##161013-00003#2 Add  ---(E)---
      #161104-00045#1 Mark ---(E)---
      #161114-00028#1 Mark ---(S)---
      #161104-00045#1 Add  ---(S)---
     #IF l_xrce.xrce109 <= g_amt_xrce119 THEN
     #   LET g_amt_xrce119 = g_amt_xrce119 - l_xrce.xrce119
     #ELSE
     #   LET l_xrce.xrce109= g_amt_xrce119
     #   LET l_xrce.xrce119=l_xrce.xrce109 * l_xrce.xrce101
     #   CALL s_curr_round_ld('1',l_xrce.xrceld,l_xrce.xrce100,l_xrce.xrce119,2)
     #      RETURNING l_success,g_errno,l_xrce.xrce119
     #   LET g_amt_xrce119 = 0
     #END IF
      #161104-00045#1 Add  ---(E)---
      #161114-00028#1 Mark ---(E)---
      #161114-00028#1 Add  ---(S)---
      IF l_xrce_t.xrce015 = 'C' THEN
         #170125-00001#1--add--s--xul
         IF g_master.diff = '1' THEN
          
         ELSE
         #170125-00001#1--add--e--xul
            LET g_amt_xrce119 = g_amt_xrce119 + l_xrce.xrce119
         END IF #170125-00001#1 ADD xul  
      ELSE
         IF l_xrce.xrce119 <= g_amt_xrce119 THEN
            #170125-00001#1--add--s--xul
            IF g_master.diff = '1' THEN
         
            ELSE
            #170125-00001#1--add--e--xul
               LET g_amt_xrce119 = g_amt_xrce119 - l_xrce.xrce119
            END IF #170125-00001#1 ADD xul
         ELSE
            LET l_xrce.xrce119= g_amt_xrce119
            LET l_xrce.xrce109=l_xrce.xrce119 / l_xrce.xrce101
            CALL s_curr_round_ld('1',l_xrce.xrceld,l_xrce.xrce100,l_xrce.xrce109,2)
               RETURNING l_success,g_errno,l_xrce.xrce109
            LET g_amt_xrce119 = 0
         END IF
      END IF
      #161114-00028#1 Add  ---(E)---


     #INSERT INTO xrce_t VALUES (l_xrce.*)  #161219-00014#2 mark
      
      #161219-00014#2--add--s--
      INSERT INTO xrce_t(xrceent,xrcecomp,xrceld,xrcedocno,xrceseq,xrcelegl,xrcesite,xrceorga,xrce001,xrce002,xrce003,xrce004,xrce005,xrce006,xrce007,
      xrce008,xrce009,xrce010,xrce011,xrce012,xrce013,xrce014,xrce015,xrce016,xrce017,xrce018,xrce019,xrce020,xrce021,xrce022,xrce023,xrce024,xrce025,
      xrce026,xrce027,xrce028,xrce029,xrce030,xrce035,xrce036,xrce037,xrce038,xrce039,xrce040,xrce041,xrce042,xrce043,xrce044,xrce045,xrce046,xrce047,
      xrce048,xrce049,xrce050,xrce051,xrce053,xrce054,xrce100,xrce101,xrce104,xrce109,xrce114,xrce119,xrce120,xrce121,xrce124,xrce129,xrce130,xrce131,
      xrce134,xrce139,xrceud001,xrceud002,xrceud003,xrceud004,xrceud005,xrceud006,xrceud007,xrceud008,xrceud009,xrceud010,xrceud011,xrceud012,xrceud013,
      xrceud014,xrceud015,xrceud016,xrceud017,xrceud018,xrceud019,xrceud020,xrceud021,xrceud022,xrceud023,xrceud024,xrceud025,xrceud026,xrceud027,xrceud028,
      xrceud029,xrceud030,xrce055,xrce056,xrce057,xrce058,xrce103,xrce113,xrce123,xrce133,xrce059) VALUES (l_xrce.xrceent,l_xrce.xrcecomp,l_xrce.xrceld,
      l_xrce.xrcedocno,l_xrce.xrceseq,l_xrce.xrcelegl,l_xrce.xrcesite,l_xrce.xrceorga,l_xrce.xrce001,l_xrce.xrce002,l_xrce.xrce003,l_xrce.xrce004,l_xrce.xrce005,
      l_xrce.xrce006,l_xrce.xrce007,l_xrce.xrce008,l_xrce.xrce009,l_xrce.xrce010,l_xrce.xrce011,l_xrce.xrce012,l_xrce.xrce013,l_xrce.xrce014,l_xrce.xrce015,
      l_xrce.xrce016,l_xrce.xrce017,l_xrce.xrce018,l_xrce.xrce019,l_xrce.xrce020,l_xrce.xrce021,l_xrce.xrce022,l_xrce.xrce023,l_xrce.xrce024,l_xrce.xrce025,
      l_xrce.xrce026,l_xrce.xrce027,l_xrce.xrce028,l_xrce.xrce029,l_xrce.xrce030,l_xrce.xrce035,l_xrce.xrce036,l_xrce.xrce037,l_xrce.xrce038,l_xrce.xrce039,
      l_xrce.xrce040,l_xrce.xrce041,l_xrce.xrce042,l_xrce.xrce043,l_xrce.xrce044,l_xrce.xrce045,l_xrce.xrce046,l_xrce.xrce047,l_xrce.xrce048,l_xrce.xrce049,
      l_xrce.xrce050,l_xrce.xrce051,l_xrce.xrce053,l_xrce.xrce054,l_xrce.xrce100,l_xrce.xrce101,l_xrce.xrce104,l_xrce.xrce109,l_xrce.xrce114,l_xrce.xrce119,
      l_xrce.xrce120,l_xrce.xrce121,l_xrce.xrce124,l_xrce.xrce129,l_xrce.xrce130,l_xrce.xrce131,l_xrce.xrce134,l_xrce.xrce139,l_xrce.xrceud001,l_xrce.xrceud002,
      l_xrce.xrceud003,l_xrce.xrceud004,l_xrce.xrceud005,l_xrce.xrceud006,l_xrce.xrceud007,l_xrce.xrceud008,l_xrce.xrceud009,l_xrce.xrceud010,l_xrce.xrceud011,
      l_xrce.xrceud012,l_xrce.xrceud013,l_xrce.xrceud014,l_xrce.xrceud015,l_xrce.xrceud016,l_xrce.xrceud017,l_xrce.xrceud018,l_xrce.xrceud019,l_xrce.xrceud020,
      l_xrce.xrceud021,l_xrce.xrceud022,l_xrce.xrceud023,l_xrce.xrceud024,l_xrce.xrceud025,l_xrce.xrceud026,l_xrce.xrceud027,l_xrce.xrceud028,l_xrce.xrceud029,
      l_xrce.xrceud030,l_xrce.xrce055,l_xrce.xrce056,l_xrce.xrce057,l_xrce.xrce058,l_xrce.xrce103,l_xrce.xrce113,l_xrce.xrce123,l_xrce.xrce133,l_xrce.xrce059)     
      #161219-00014#2--add--e--
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'xrce_t'
         LET g_errparam.extend = SQLCA.sqlcode
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N' 
         EXIT FOREACH
      ELSE
         LET g_cnt2 = g_cnt2 + 1
      END IF

      LET l_seq = l_seq + 1

      #161013-00003#2 Add  ---(S)---
      IF g_amt_xrce119 = 0 THEN
         EXIT FOREACH
      END IF
      #161013-00003#2 Add  ---(E)---

   END FOREACH
   IF g_success = 'N' THEN
      RETURN
   END IF
   #161114-00028#1 Mod  ---(E)---

   IF g_cnt1 = 0 AND g_cnt2 = 0 AND g_cnt3 = 0 THEN
      LET g_success = 'N'
      RETURN
   END IF
   
#   IF g_master.diff = '2' THEN
#      CALL axrp400_ar_diff()
#   END IF

#   IF NOT cl_null(g_xrdadocno) THEN 
#      CALL s_pre_voucher_ins('AR','R20',g_master.xrdald,g_xrdadocno,g_master.xrdadocdt,'2') RETURNING l_success
#      
#      IF l_success THEN
#         LET g_success = 'Y'   
#      ELSE
#         LET g_success = 'N' 
#      END IF
#   END IF

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
PRIVATE FUNCTION axrp400_ar_amt(p_xrccdocno,p_xrccseq,p_xrcc001)
   DEFINE p_xrccdocno         LIKE xrcc_t.xrccdocno
   DEFINE p_xrccseq           LIKE xrcc_t.xrccseq
   DEFINE p_xrcc001           LIKE xrcc_t.xrcc001
   #DEFINE l_xrca              RECORD LIKE xrca_t.*  #161219-00014#2--mark--
   #161219-00014#2--add--s--
   DEFINE l_xrca RECORD  #應收憑單單頭
       xrcaent LIKE xrca_t.xrcaent, #企业编号
       xrcaownid LIKE xrca_t.xrcaownid, #资料所有者
       xrcaowndp LIKE xrca_t.xrcaowndp, #资料所有部门
       xrcacrtid LIKE xrca_t.xrcacrtid, #资料录入者
       xrcacrtdp LIKE xrca_t.xrcacrtdp, #资料录入部门
       xrcacrtdt LIKE xrca_t.xrcacrtdt, #资料创建日
       xrcamodid LIKE xrca_t.xrcamodid, #资料更改者
       xrcamoddt LIKE xrca_t.xrcamoddt, #最近更改日
       xrcacnfid LIKE xrca_t.xrcacnfid, #资料审核者
       xrcacnfdt LIKE xrca_t.xrcacnfdt, #数据审核日
       xrcapstid LIKE xrca_t.xrcapstid, #资料过账者
       xrcapstdt LIKE xrca_t.xrcapstdt, #资料过账日
       xrcastus LIKE xrca_t.xrcastus, #状态码
       xrcacomp LIKE xrca_t.xrcacomp, #法人
       xrcald LIKE xrca_t.xrcald, #账套
       xrcadocno LIKE xrca_t.xrcadocno, #売掛金番号
       xrcadocdt LIKE xrca_t.xrcadocdt, #账款日期
       xrca001 LIKE xrca_t.xrca001, #账款单性质
       xrcasite LIKE xrca_t.xrcasite, #账务中心
       xrca003 LIKE xrca_t.xrca003, #账务人员
       xrca004 LIKE xrca_t.xrca004, #账款客户编号
       xrca005 LIKE xrca_t.xrca005, #收款客户
       xrca006 LIKE xrca_t.xrca006, #客户分类
       xrca007 LIKE xrca_t.xrca007, #账款类别
       xrca008 LIKE xrca_t.xrca008, #收款条件编号
       xrca009 LIKE xrca_t.xrca009, #应收款日/应扣抵日
       xrca010 LIKE xrca_t.xrca010, #容许票据到期日
       xrca011 LIKE xrca_t.xrca011, #税种
       xrca012 LIKE xrca_t.xrca012, #税率
       xrca013 LIKE xrca_t.xrca013, #含税否
       xrca014 LIKE xrca_t.xrca014, #人员编号
       xrca015 LIKE xrca_t.xrca015, #部门编号
       xrca016 LIKE xrca_t.xrca016, #来源作业类型
       xrca017 LIKE xrca_t.xrca017, #生成方式
       xrca018 LIKE xrca_t.xrca018, #来源参考单号
       xrca019 LIKE xrca_t.xrca019, #系统生成对应单号(待抵账款-预收)
       xrca020 LIKE xrca_t.xrca020, #信用状申请流程否
       xrca021 LIKE xrca_t.xrca021, #商业发票号码(IV no.)
       xrca022 LIKE xrca_t.xrca022, #出口报单号码
       xrca023 LIKE xrca_t.xrca023, #发票客户编号
       xrca024 LIKE xrca_t.xrca024, #发票客户税号
       xrca025 LIKE xrca_t.xrca025, #发票客户全名
       xrca026 LIKE xrca_t.xrca026, #发票客户地址
       xrca028 LIKE xrca_t.xrca028, #发票类型
       xrca029 LIKE xrca_t.xrca029, #发票汇率
       xrca030 LIKE xrca_t.xrca030, #发票应开税前金额
       xrca031 LIKE xrca_t.xrca031, #发票应开税额
       xrca032 LIKE xrca_t.xrca032, #发票应开含税金额
       xrca033 LIKE xrca_t.xrca033, #项目编号
       xrca034 LIKE xrca_t.xrca034, #责任中心
       xrca035 LIKE xrca_t.xrca035, #应收(借方)科目编号
       xrca036 LIKE xrca_t.xrca036, #收入(贷方)科目编号
       xrca037 LIKE xrca_t.xrca037, #分录凭证生成否
       xrca038 LIKE xrca_t.xrca038, #抛转凭证号码
       xrca039 LIKE xrca_t.xrca039, #会计检核附件份数
       xrca040 LIKE xrca_t.xrca040, #留置否
       xrca041 LIKE xrca_t.xrca041, #留置理由码
       xrca042 LIKE xrca_t.xrca042, #留置设置日期
       xrca043 LIKE xrca_t.xrca043, #留置解除日期
       xrca044 LIKE xrca_t.xrca044, #留置原币金额
       xrca045 LIKE xrca_t.xrca045, #留置说明
       xrca046 LIKE xrca_t.xrca046, #关系人否
       xrca047 LIKE xrca_t.xrca047, #多角序号
       xrca048 LIKE xrca_t.xrca048, #集团代收/代付单号
       xrca049 LIKE xrca_t.xrca049, #来源营运中心编号
       xrca050 LIKE xrca_t.xrca050, #交易原始单据份数
       xrca051 LIKE xrca_t.xrca051, #作废理由码
       xrca052 LIKE xrca_t.xrca052, #打印次数
       xrca053 LIKE xrca_t.xrca053, #备注
       xrca054 LIKE xrca_t.xrca054, #多账期设置
       xrca055 LIKE xrca_t.xrca055, #缴款优惠条件
       xrca056 LIKE xrca_t.xrca056, #会计检核附件状态
       xrca057 LIKE xrca_t.xrca057, #交易对象识别码
       xrca058 LIKE xrca_t.xrca058, #销售分类
       xrca059 LIKE xrca_t.xrca059, #预算编号
       xrca060 LIKE xrca_t.xrca060, #发票开立原则
       xrca061 LIKE xrca_t.xrca061, #预计开立发票日期
       xrca062 LIKE xrca_t.xrca062, #多角性质
       xrca063 LIKE xrca_t.xrca063, #整账批序号
       xrca064 LIKE xrca_t.xrca064, #订金序次
       xrca065 LIKE xrca_t.xrca065, #发票编号
       xrca066 LIKE xrca_t.xrca066, #发票号码
       xrca100 LIKE xrca_t.xrca100, #交易原币种
       xrca101 LIKE xrca_t.xrca101, #原币汇率
       xrca103 LIKE xrca_t.xrca103, #原币税前金额
       xrca104 LIKE xrca_t.xrca104, #原币税额
       xrca106 LIKE xrca_t.xrca106, #原币直接折抵合计金额
       xrca107 LIKE xrca_t.xrca107, #原币直接冲账(调整)合计金额
       xrca108 LIKE xrca_t.xrca108, #原币应收金额
       xrca113 LIKE xrca_t.xrca113, #本币税前金额
       xrca114 LIKE xrca_t.xrca114, #本币税额
       xrca116 LIKE xrca_t.xrca116, #本币直接冲账(调整)合计金额
       xrca117 LIKE xrca_t.xrca117, #本币直接冲账(调整)合计金额
       xrca118 LIKE xrca_t.xrca118, #本币应收金额
       xrca120 LIKE xrca_t.xrca120, #本位币二币种
       xrca121 LIKE xrca_t.xrca121, #本位币二汇率
       xrca123 LIKE xrca_t.xrca123, #本位币二税前金额
       xrca124 LIKE xrca_t.xrca124, #本位币二税额
       xrca126 LIKE xrca_t.xrca126, #本位币二直接折抵合计金额
       xrca127 LIKE xrca_t.xrca127, #本位币二直接冲账(调整)合计金额
       xrca128 LIKE xrca_t.xrca128, #本位币二应收金额
       xrca130 LIKE xrca_t.xrca130, #本位币三币种
       xrca131 LIKE xrca_t.xrca131, #本位币三汇率
       xrca133 LIKE xrca_t.xrca133, #本位币三税前金额
       xrca134 LIKE xrca_t.xrca134, #本位币三税额
       xrca136 LIKE xrca_t.xrca136, #本位币三直接折抵合计金额
       xrca137 LIKE xrca_t.xrca137, #本位币三直接冲账(调整)合计金额
       xrca138 LIKE xrca_t.xrca138, #本位币三应收金额
       xrcaud001 LIKE xrca_t.xrcaud001, #自定义字段(文本)001
       xrcaud002 LIKE xrca_t.xrcaud002, #自定义字段(文本)002
       xrcaud003 LIKE xrca_t.xrcaud003, #自定义字段(文本)003
       xrcaud004 LIKE xrca_t.xrcaud004, #自定义字段(文本)004
       xrcaud005 LIKE xrca_t.xrcaud005, #自定义字段(文本)005
       xrcaud006 LIKE xrca_t.xrcaud006, #自定义字段(文本)006
       xrcaud007 LIKE xrca_t.xrcaud007, #自定义字段(文本)007
       xrcaud008 LIKE xrca_t.xrcaud008, #自定义字段(文本)008
       xrcaud009 LIKE xrca_t.xrcaud009, #自定义字段(文本)009
       xrcaud010 LIKE xrca_t.xrcaud010, #自定义字段(文本)010
       xrcaud011 LIKE xrca_t.xrcaud011, #自定义字段(数字)011
       xrcaud012 LIKE xrca_t.xrcaud012, #自定义字段(数字)012
       xrcaud013 LIKE xrca_t.xrcaud013, #自定义字段(数字)013
       xrcaud014 LIKE xrca_t.xrcaud014, #自定义字段(数字)014
       xrcaud015 LIKE xrca_t.xrcaud015, #自定义字段(数字)015
       xrcaud016 LIKE xrca_t.xrcaud016, #自定义字段(数字)016
       xrcaud017 LIKE xrca_t.xrcaud017, #自定义字段(数字)017
       xrcaud018 LIKE xrca_t.xrcaud018, #自定义字段(数字)018
       xrcaud019 LIKE xrca_t.xrcaud019, #自定义字段(数字)019
       xrcaud020 LIKE xrca_t.xrcaud020, #自定义字段(数字)020
       xrcaud021 LIKE xrca_t.xrcaud021, #自定义字段(日期时间)021
       xrcaud022 LIKE xrca_t.xrcaud022, #自定义字段(日期时间)022
       xrcaud023 LIKE xrca_t.xrcaud023, #自定义字段(日期时间)023
       xrcaud024 LIKE xrca_t.xrcaud024, #自定义字段(日期时间)024
       xrcaud025 LIKE xrca_t.xrcaud025, #自定义字段(日期时间)025
       xrcaud026 LIKE xrca_t.xrcaud026, #自定义字段(日期时间)026
       xrcaud027 LIKE xrca_t.xrcaud027, #自定义字段(日期时间)027
       xrcaud028 LIKE xrca_t.xrcaud028, #自定义字段(日期时间)028
       xrcaud029 LIKE xrca_t.xrcaud029, #自定义字段(日期时间)029
       xrcaud030 LIKE xrca_t.xrcaud030  #自定义字段(日期时间)030
       END RECORD
   #161219-00014#2--add--e--
   DEFINE l_flag              LIKE type_t.chr1
   DEFINE l_xrce109           LIKE xrce_t.xrce109
   DEFINE l_xrce119           LIKE xrce_t.xrce119
   DEFINE l_xrce129           LIKE xrce_t.xrce129
   DEFINE l_xrce139           LIKE xrce_t.xrce139
   DEFINE r_xrcc              RECORD
             xrcc109             LIKE xrcc_t.xrcc109,
             xrcc119             LIKE xrcc_t.xrcc119,
             xrcc129             LIKE xrcc_t.xrcc129,
             xrcc139             LIKE xrcc_t.xrcc139
                              END RECORD

   #獲取該應收單可沖金額：應收-已收-預收
      #應收 - 已收
      SELECT xrcc108 - xrcc109,xrcc118 - xrcc119,xrcc128 - xrcc129,xrcc138 - xrcc139
        INTO r_xrcc.xrcc109,r_xrcc.xrcc119,r_xrcc.xrcc129,r_xrcc.xrcc139
        FROM xrcc_t
       WHERE xrccent = g_enterprise   AND xrccdocno = p_xrccdocno
         AND xrccld  = g_master.xrdald AND xrccseq = p_xrccseq
         AND xrcc001 = p_xrcc001
      IF cl_null(r_xrcc.xrcc109) THEN LET r_xrcc.xrcc109 = 0 END IF
      IF cl_null(r_xrcc.xrcc119) THEN LET r_xrcc.xrcc119 = 0 END IF
      IF cl_null(r_xrcc.xrcc129) THEN LET r_xrcc.xrcc129 = 0 END IF
      IF cl_null(r_xrcc.xrcc139) THEN LET r_xrcc.xrcc139 = 0 END IF

      #預收
      SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139)
        INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
        FROM xrce_t,xrda_t
       WHERE xrceent = xrdaent AND xrdadocno = xrcedocno 
         AND xrdald    = xrceld
         AND xrce003 = p_xrccdocno AND xrce004 = p_xrccseq 
         AND xrce005 = p_xrcc001 AND xrdastus = 'N'
      IF cl_null(l_xrce109) THEN LET l_xrce109 = 0 END IF
      IF cl_null(l_xrce119) THEN LET l_xrce119 = 0 END IF
      IF cl_null(l_xrce129) THEN LET l_xrce129 = 0 END IF
      IF cl_null(l_xrce139) THEN LET l_xrce139 = 0 END IF
      LET r_xrcc.xrcc109 = r_xrcc.xrcc109 - l_xrce109
      LET r_xrcc.xrcc119 = r_xrcc.xrcc119 - l_xrce119
      LET r_xrcc.xrcc129 = r_xrcc.xrcc129 - l_xrce129
      LET r_xrcc.xrcc139 = r_xrcc.xrcc139 - l_xrce139


   RETURN r_xrcc.*
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
PRIVATE FUNCTION axrp400_ar_diff(p_xrdadocno)
   DEFINE p_xrdadocno   LIKE xrda_t.xrdadocno
   DEFINE l_glab003     LIKE glab_t.glab003
  #DEFINE l_xrde_t      RECORD LIKE xrde_t.*  #161219-00014#2--mark--
   #161219-00014#2--add--s--
   DEFINE l_xrde_t RECORD  #收款及差異處理明細檔
       xrdeent LIKE xrde_t.xrdeent, #
       xrdecomp LIKE xrde_t.xrdecomp, #法人
       xrdeld LIKE xrde_t.xrdeld, #
       xrdedocno LIKE xrde_t.xrdedocno, #冲销单单号
       xrdeseq LIKE xrde_t.xrdeseq, #项次
       xrdesite LIKE xrde_t.xrdesite, #账务中心
       xrdeorga LIKE xrde_t.xrdeorga, #账务归属组织
       xrde001 LIKE xrde_t.xrde001, #来源作业
       xrde002 LIKE xrde_t.xrde002, #冲销账款类型
       xrde003 LIKE xrde_t.xrde003, #来源单号
       xrde004 LIKE xrde_t.xrde004, #来源单项次
       xrde006 LIKE xrde_t.xrde006, #
       xrde007 LIKE xrde_t.xrde007, #款别编号
       xrde008 LIKE xrde_t.xrde008, #账户/票券号码
       xrde010 LIKE xrde_t.xrde010, #摘要
       xrde011 LIKE xrde_t.xrde011, #银行存提码
       xrde012 LIKE xrde_t.xrde012, #现金变动码
       xrde013 LIKE xrde_t.xrde013, #转入客商码
       xrde014 LIKE xrde_t.xrde014, #转入账款单编号
       xrde015 LIKE xrde_t.xrde015, #冲销加减项
       xrde016 LIKE xrde_t.xrde016, #冲销会科
       xrde017 LIKE xrde_t.xrde017, #业务人员
       xrde018 LIKE xrde_t.xrde018, #业务部门
       xrde019 LIKE xrde_t.xrde019, #责任中心
       xrde020 LIKE xrde_t.xrde020, #产品类别
       xrde022 LIKE xrde_t.xrde022, #项目编号
       xrde023 LIKE xrde_t.xrde023, #WBS编号
       xrde028 LIKE xrde_t.xrde028, #生成方式
       xrde029 LIKE xrde_t.xrde029, #凭证号码
       xrde030 LIKE xrde_t.xrde030, #凭证项次
       xrde035 LIKE xrde_t.xrde035, #区域
       xrde036 LIKE xrde_t.xrde036, #客群
       xrde038 LIKE xrde_t.xrde038, #对象
       xrde039 LIKE xrde_t.xrde039, #经营方式
       xrde040 LIKE xrde_t.xrde040, #渠道
       xrde041 LIKE xrde_t.xrde041, #品牌
       xrde042 LIKE xrde_t.xrde042, #自由核算项一
       xrde043 LIKE xrde_t.xrde043, #自由核算项二
       xrde044 LIKE xrde_t.xrde044, #自由核算项三
       xrde045 LIKE xrde_t.xrde045, #自由核算项四
       xrde046 LIKE xrde_t.xrde046, #自由核算项五
       xrde047 LIKE xrde_t.xrde047, #自由核算项六
       xrde048 LIKE xrde_t.xrde048, #自由核算项七
       xrde049 LIKE xrde_t.xrde049, #自由核算项八
       xrde050 LIKE xrde_t.xrde050, #自由核算项九
       xrde051 LIKE xrde_t.xrde051, #自由核算项十
       xrde100 LIKE xrde_t.xrde100, #币种
       xrde101 LIKE xrde_t.xrde101, #汇率
       xrde109 LIKE xrde_t.xrde109, #原币冲账金额
       xrde119 LIKE xrde_t.xrde119, #本币冲账金额
       xrde120 LIKE xrde_t.xrde120, #本位币二币种
       xrde121 LIKE xrde_t.xrde121, #本位币二汇率
       xrde129 LIKE xrde_t.xrde129, #本位币二冲账金额
       xrde130 LIKE xrde_t.xrde130, #本位币三币种
       xrde131 LIKE xrde_t.xrde131, #本位币三汇率
       xrde139 LIKE xrde_t.xrde139, #本位币三冲账金额
       xrde032 LIKE xrde_t.xrde032, #收款日期
       xrde108 LIKE xrde_t.xrde108, #原币手续费
       xrde118 LIKE xrde_t.xrde118  #本币手续费
       END RECORD
   #161219-00014#2--add--e--
   DEFINE l_sql         STRING
   DEFINE l_xrde100     LIKE xrde_t.xrde100
   DEFINE l_xrde109     LIKE xrde_t.xrde109
   DEFINE l_xrde119     LIKE xrde_t.xrde119
   DEFINE l_xrde109_1   LIKE xrde_t.xrde109
   DEFINE l_xrde119_1   LIKE xrde_t.xrde119
   DEFINE l_xrde109_2   LIKE xrde_t.xrde109
   DEFINE l_xrde119_2   LIKE xrde_t.xrde119
   DEFINE l_ooab002     LIKE ooab_t.ooab002
   DEFINE l_amt         LIKE xrde_t.xrde119   #匯差
 
   SELECT MAX(xrdeseq) + 1 INTO l_xrde_t.xrdeseq
     FROM xrde_t
    WHERE xrdeent = g_enterprise 
      AND xrdeld = g_master.xrdald
      AND xrdedocno = p_xrdadocno
      
   IF cl_null(l_xrde_t.xrdeseq) THEN 
      LET l_xrde_t.xrdeseq = 1
   END IF
   
   IF l_xrde_t.xrdeseq > 1 THEN 
      SELECT xrde010 INTO l_xrde_t.xrde010
        FROM xrde_t
       WHERE xrdeent = g_enterprise
         AND xrdeld = g_master.xrdald
         AND xrdedocno = p_xrdadocno
         AND xrdeseq = l_xrde_t.xrdeseq - 1 
   END IF

   LET l_xrde_t.xrdeent  = g_enterprise
   LET l_xrde_t.xrdecomp = g_glaa.glaacomp
   LET l_xrde_t.xrdeld   = g_master.xrdald
   LET l_xrde_t.xrdesite = g_master.xrdasite
   LET l_xrde_t.xrdedocno= p_xrdadocno  
   LET l_xrde_t.xrdeorga = g_glaa.glaacomp   
   #本幣
   LET l_sql ="SELECT SUM(xrde109),SUM(xrde119),SUM(xrde109_1),SUM(xrde119_1),SUM(xrde109_2),SUM(xrde119_2)",
              "  FROM (",
              "       SELECT SUM(xrde109) xrde109,SUM(xrde119) xrde119,0 xrde109_1,0 xrde119_1,0 xrde109_2,0 xrde119_2 FROM xrde_t",       #收款金額
              "        WHERE xrde002 = 10",
              "          AND xrdeent = ",g_enterprise,
              "          AND xrdedocno = '",p_xrdadocno,"'",
              "          AND xrdeld = '",g_master.xrdald,"'",
              "        UNION ",
              "       SELECT 0 xrde109,0 xrde119,SUM(xrce109 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END) xrde109_1,SUM(xrce119 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END) xrde119_1,0 xrde109_2,0 xrde119_2 FROM xrce_t,gzcb_t",#帳款金額
              "        WHERE xrce002 = gzcb002",
              "          AND gzcb001 = '8306'",
              "          AND gzcb004 = '2'",
              "          AND xrceent = ",g_enterprise,
              "          AND xrcedocno = '",p_xrdadocno,"'",
              "          AND xrceld = '",g_master.xrdald,"'",
              "        UNION ",
              "       SELECT 0 xrde109,0 xrde119,0 xrde109_1,0 xrde119_1,SUM(xrde109 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END) xrde109_2,SUM(xrde119 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END) xrde119_2 FROM xrde_t,gzcb_t",#帳款金額
              "        WHERE xrde002 = gzcb002",
              "          AND gzcb001 = '8306'",
              "          AND gzcb004 = '1'",
              "          AND xrde002 <> 10",
              "          AND xrdeent = ",g_enterprise,
              "          AND xrdedocno = '",p_xrdadocno,"'",
              "          AND xrdeld = '",g_master.xrdald,"'",
              "      )"
   PREPARE axrt400_01_prep31 FROM l_sql
   DECLARE axrt400_01_xrde1 CURSOR FOR axrt400_01_prep31

   FOREACH axrt400_01_xrde1 INTO l_xrde109,l_xrde119,l_xrde109_1,l_xrde119_1,l_xrde109_2,l_xrde119_2
      IF cl_null(l_xrde109)   THEN LET l_xrde109   = 0 END IF
      IF cl_null(l_xrde119)   THEN LET l_xrde119   = 0 END IF
      IF cl_null(l_xrde109_1) THEN LET l_xrde109_1 = 0 END IF
      IF cl_null(l_xrde119_1) THEN LET l_xrde119_1 = 0 END IF
      IF cl_null(l_xrde109_2) THEN LET l_xrde109_2 = 0 END IF
      IF cl_null(l_xrde119_2) THEN LET l_xrde119_2 = 0 END IF
      #本幣帳款 < 收款:12.匯兌收益;　反之(11.匯損).
      #需要考慮本位幣二、三產生的匯兌損益
      IF l_xrde119 - l_xrde119_2 != l_xrde119_1 THEN
         LET l_amt = l_xrde119 + l_xrde119_1 + l_xrde119_2

         IF l_amt < 0 THEN
            LET l_xrde_t.xrde002  = '11'
            LET l_glab003 = '9711_11'
            LET l_amt = l_amt * -1
         ELSE
            LET l_xrde_t.xrde002  = '12'
            LET l_glab003 = '9711_12'
         END IF
         SELECT gzcb003 INTO l_xrde_t.xrde015 FROM gzcb_t
          WHERE gzcb002 = l_xrde_t.xrde002
            AND gzcb001 = '8306'
         LET l_xrde_t.xrde006  = ''
#         IF g_prog = 'axrt400' THEN 
            LET l_xrde_t.xrde001  = 'axrt400'
#         ELSE
#            LET l_xrde_t.xrde001  = 'axrt300'
#         END IF
         LET l_xrde_t.xrde003  = ''
         LET l_xrde_t.xrde004  = ''
         LET l_xrde_t.xrde008  = ''
         LET l_xrde_t.xrde013  = ''
         LET l_xrde_t.xrde014  = ''
         LET l_xrde_t.xrde100  = g_glaa.glaa001
         LET l_xrde_t.xrde101  = 1
         LET l_xrde_t.xrde109  = 0
         LET l_xrde_t.xrde119  = l_amt
         LET l_xrde_t.xrde120 = g_glaa.glaa016
         LET l_xrde_t.xrde121 = 0
         LET l_xrde_t.xrde129 = 0
         LET l_xrde_t.xrde130 = g_glaa.glaa020
         LET l_xrde_t.xrde131 = 0
         LET l_xrde_t.xrde139 = 0
         LET l_xrde_t.xrde017  = g_master.xrda003
         
         SELECT ooag003 INTO l_xrde_t.xrde018 FROM ooag_t
          WHERE ooagent = g_enterprise
            AND ooag001 = g_master.xrda003
         
         SELECT glaacomp INTO l_xrde_t.xrdeorga 
           FROM glaa_t
          WHERE glaaent = g_enterprise
            AND glaald  = g_ld
         LET l_xrde_t.xrde019  = l_xrde_t.xrdeorga
         LET l_xrde_t.xrde020  = ''
         LET l_xrde_t.xrde022  = ''
         LET l_xrde_t.xrde023  = ''
         
             
         SELECT glab005,glab010 INTO l_xrde_t.xrde016,l_xrde_t.xrde011 FROM glab_t
          WHERE glabent = g_enterprise
            AND glabld = g_master.xrdald
            AND glab003 = l_glab003
         
         SELECT nmad003 INTO l_xrde_t.xrde012 FROM nmad_t
          WHERE nmadent = g_enterprise
            AND nmad001 = g_glaa.glaa005
            AND nmad002 = l_xrde_t.xrde011
           
         #SELECT gzcb003 INTO l_xrde_t.xrde015 FROM gzcb_t
         # WHERE gzcb002 = '20'
         #   AND gzcb001 = '8306'
            
         IF l_xrde_t.xrde119 < 0 THEN 
            LET l_xrde_t.xrde119 = l_xrde_t.xrde119 * -1
         END IF
         
         IF l_xrde_t.xrde129 < 0 THEN 
            LET l_xrde_t.xrde129 = l_xrde_t.xrde129 * -1
         END IF
         
         IF l_xrde_t.xrde139 < 0 THEN 
            LET l_xrde_t.xrde139 = l_xrde_t.xrde139 * -1
         END IF

         #INSERT INTO xrde_t VALUES(l_xrde_t.*)
         INSERT INTO xrde_t(xrdeent,xrdecomp,xrdeld,xrdesite,xrdeorga,xrdedocno,xrdeseq,xrde001,
                            xrde002,xrde003,xrde004,xrde006,xrde008,xrde032,xrde010,xrde011,xrde012,xrde013,  #160912-00038#1 add xede032
                            xrde014,xrde015,xrde016,xrde017,xrde018,xrde019,xrde020,xrde022,xrde023,
                            xrde100,xrde101,xrde109,xrde119,xrde120,xrde121,xrde129,xrde130,xrde131,xrde139)
                     VALUES(l_xrde_t.xrdeent ,l_xrde_t.xrdecomp ,l_xrde_t.xrdeld ,l_xrde_t.xrdesite,
                            l_xrde_t.xrdeorga,l_xrde_t.xrdedocno,l_xrde_t.xrdeseq,l_xrde_t.xrde001,
                            l_xrde_t.xrde002 ,l_xrde_t.xrde003  ,l_xrde_t.xrde004,l_xrde_t.xrde006,
                            l_xrde_t.xrde008 ,'',l_xrde_t.xrde010  ,l_xrde_t.xrde011,l_xrde_t.xrde012,     #160912-00038#1 add ''
                            l_xrde_t.xrde013 ,l_xrde_t.xrde014  ,l_xrde_t.xrde015,l_xrde_t.xrde016,
                            l_xrde_t.xrde017 ,l_xrde_t.xrde018  ,l_xrde_t.xrde019,l_xrde_t.xrde020,
                            l_xrde_t.xrde022 ,l_xrde_t.xrde023  ,l_xrde_t.xrde100,l_xrde_t.xrde101,
                            l_xrde_t.xrde109 ,l_xrde_t.xrde119  ,l_xrde_t.xrde120,l_xrde_t.xrde121,
                            l_xrde_t.xrde129 ,l_xrde_t.xrde130  ,l_xrde_t.xrde131,l_xrde_t.xrde139
                            )
         
         
         IF SQLCA.sqlcode THEN
            LET g_success = 'N' RETURN
         END IF
         
         LET l_xrde_t.xrdeseq = l_xrde_t.xrdeseq + 1
         
      END IF

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
PRIVATE FUNCTION axrp400_get_amt()
   DEFINE l_amt1,l_amt2      LIKE xrde_t.xrde109     #收款金額
   DEFINE l_amt3,l_amt4      LIKE xrce_t.xrce109     #帳款金額
   DEFINE l_amt5,l_amt6      LIKE xrce_t.xrce109     #匯差及調整金額
   DEFINE l_amt7,l_amt8      LIKE xrce_t.xrce109     #差異金額
   DEFINE l_amt1_1,l_amt2_1  LIKE xrde_t.xrde109     #收款金額         本位幣二/三
   DEFINE l_amt3_1,l_amt4_1  LIKE xrce_t.xrce109     #帳款金額         本位幣二/三
   DEFINE l_amt5_1,l_amt6_1  LIKE xrce_t.xrce109     #匯差及調整金額    本位幣二/三
   DEFINE l_amt7_1,l_amt8_1  LIKE xrce_t.xrce109     #差異金額         本位幣二/三
   DEFINE l_xrde109_d        LIKE xrde_t.xrde109
   DEFINE l_xrde119_d        LIKE xrde_t.xrde109
   DEFINE l_xrde129_d        LIKE xrde_t.xrde109
   DEFINE l_xrde139_d        LIKE xrde_t.xrde109
   DEFINE l_xrce109_d        LIKE xrce_t.xrce109
   DEFINE l_xrce119_d        LIKE xrce_t.xrce109
   DEFINE l_xrce129_d        LIKE xrce_t.xrce109
   DEFINE l_xrce139_d        LIKE xrce_t.xrce109
   DEFINE l_xrde109_c        LIKE xrde_t.xrde109
   DEFINE l_xrde119_c        LIKE xrde_t.xrde109
   DEFINE l_xrde129_c        LIKE xrde_t.xrde109
   DEFINE l_xrde139_c        LIKE xrde_t.xrde109
   DEFINE l_xrce109_c        LIKE xrce_t.xrce109
   DEFINE l_xrce119_c        LIKE xrce_t.xrce109
   DEFINE l_xrce129_c        LIKE xrce_t.xrce109
   DEFINE l_xrce139_c        LIKE xrce_t.xrce109
   
   #計算收款
   SELECT SUM(xrde109),SUM(xrde119) INTO l_amt1,l_amt2 FROM xrde_t,gzcb_t
    WHERE xrdeent = g_enterprise
      AND xrdeld  = g_master.xrdald
      AND xrdedocno = g_xrdadocno
      AND xrde002 = gzcb002
      AND gzcb001 = '8306'
      AND gzcb004 = '1'
      AND xrde002 = '10'
   IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF
   IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
   
   #計算帳款
   SELECT SUM(xrce109 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END),SUM(xrce119 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END)
     INTO l_amt3,l_amt4
     FROM xrce_t,gzcb_t
    WHERE xrceent = g_enterprise
      AND xrceld  = g_master.xrdald
      AND xrcedocno = g_xrdadocno
      AND gzcb001 = '8306'
      AND gzcb004 = '2'
      AND gzcb002 = xrce002
   IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF
   IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
   
   #計算匯差及調整帳款
   SELECT SUM(xrde109 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END),SUM(xrde119 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END)
     INTO l_amt5,l_amt6
     FROM xrde_t,gzcb_t
    WHERE xrdeent = g_enterprise
      AND xrdeld  = g_master.xrdald
      AND xrdedocno = g_xrdadocno
      AND xrde002 = gzcb002
      AND gzcb001 = '8306'
      AND xrde002 <> 10
      AND gzcb004 = '1'
   IF cl_null(l_amt5) THEN LET l_amt5 = 0 END IF
   IF cl_null(l_amt6) THEN LET l_amt6 = 0 END IF
   
   LET l_amt7 = 0
   LET l_amt8 = l_amt2 + l_amt4 + l_amt6
   INSERT INTO axrp400_s01_tmp VALUES(g_master.diff,g_xrdadocno,l_amt2,l_amt4,l_amt8)
   LET g_amt1 = l_amt8
END FUNCTION

################################################################################
# Descriptions...: 將取回的字串轉換為SQL條件
################################################################################
PRIVATE FUNCTION axrp400_change_to_sql(p_wc)
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
   LET r_wc = "'",l_str,"'"

   RETURN r_wc
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
PRIVATE FUNCTION axrp400_construct()
    DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define
   DEFINE li_idx1           LIKE type_t.num10
   DEFINE l_n               LIKE type_t.num10
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_xrdasite        LIKE xrda_t.xrdasite
   DEFINE l_xrdald          LIKE xrda_t.xrdald
   DEFINE l_xrda003         LIKE xrda_t.xrda003
   DEFINE l_xrdadocdt       LIKE xrda_t.xrdadocdt
   DEFINE l_glaa024         LIKE glaa_t.glaa024
   DEFINE l_success_1    LIKE type_t.num5
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
                   oofg019     LIKE oofg_t.oofg019,   #field
                   oofg020     LIKE oofg_t.oofg020    #value
                           END RECORD
   DEFINE l_origin_str      STRING
   #end add-point 

   CLEAR FORM
   INITIALIZE g_wc  TO NULL
   INITIALIZE g_wc2 TO NULL
   INITIALIZE g_wc_nmbb026 TO NULL   #161114-00028#1 Add
   LET g_nmbb026   = ''   #161130-00023#1 Add
   LET g_nmbb026_t = ''   #161130-00023#1 Add
   CALL cl_set_act_visible("accept,cancel", FALSE)
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         #add-point:ui_dialog段input
         INPUT BY NAME g_master.xrdasite,g_master.xrdald,g_master.xrdadocno,g_master.xrda003,g_master.xrdadocdt, 
                       g_master.xrca063,g_master.chk,g_master.diff
             
            BEFORE INPUT
               CALL axrp400_def()
               LET g_master.xrdadocdt = g_today
               DISPLAY BY NAME g_master.*
               
            ON ACTION controlp INFIELD xrdasite
                INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xrdasite       #給予default值
               #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00009#4 

               #給予arg

               #CALL q_ooef001()                                 #呼叫開窗    #161021-00050#3 mark
               LET g_qryparam.where = " ooefstus = 'Y' "                     #161021-00050#3 add
               CALL q_ooef001_46()                                           #161021-00050#3 add
               LET g_master.xrdasite = g_qryparam.return1        #將開窗取得的值回傳到變數
               IF NOT cl_null(g_master.xrdasite) THEN
                  CALL s_axrt300_site_geared_ld(g_master.xrdasite,g_master.xrdald,g_user,g_today,'site')
                     RETURNING l_success,g_master.xrdasite,g_master.xrdasite_desc,g_master.xrdald,g_master.xrdald_desc
                 #SELECT * INTO g_glaa.* FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrdald  #161219-00014#2--mark--
                  #161219-00014#2--add--s--
                  SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                  glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,glaa012,
                  glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,glaa024,glaa025,
                  glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,
                  glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
                    FROM glaa_t 
                   WHERE glaaent = g_enterprise AND glaald = g_master.xrdald
                  #161219-00014#2--add--e-- 
               END IF
               DISPLAY g_master.xrdasite TO xrdasite             #顯示到畫面上
               CALL axrp400_xrda_dis('site')
               NEXT FIELD xrdasite                               #返回原欄位
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xrdasite
            #add-point:BEFORE FIELD xrdasite
            LET l_xrdasite = g_master.xrdasite
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xrdasite
            
            #add-point:AFTER FIELD xrdasite
             LET g_master.xrdasite_desc = ' '
               DISPLAY BY NAME g_master.xrdasite_desc
               IF NOT cl_null(g_master.xrdasite) THEN
                  IF NOT cl_null(g_master.xrdasite) THEN
                     CALL s_axrt300_site_geared_ld(g_master.xrdasite,g_master.xrdald,g_user,g_today,'site')
                        RETURNING l_success,g_master.xrdasite,g_master.xrdasite_desc,g_master.xrdald,g_master.xrdald_desc
                     DISPLAY BY NAME g_master.xrdasite,g_master.xrdasite_desc
                     DISPLAY BY NAME g_master.xrdald,g_master.xrdald_desc
                     IF NOT l_success THEN NEXT FIELD CURRENT END IF
                  ELSE
                     LET g_master.xrdasite_desc = ''
                  END IF
                  CALL s_fin_create_account_center_tmp()
                  CALL s_fin_account_center_sons_query('3',g_master.xrdasite,g_today,'1')
                  IF cl_null(g_master.xrdasite) THEN
                    CALL s_fin_orga_get_comp_ld(g_master.xrdasite) RETURNING l_success,g_errno,g_master.xrdacomp_desc,g_master.xrdald
                  END IF
                  CALL s_fin_account_center_with_ld_chk(g_master.xrdasite,g_master.xrdald,g_user,'3','N','',g_master.xrdadocdt) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_master.xrdasite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_master.xrdasite = ''
                     LET g_master.xrdald = ''
                     LET g_master.xrdacomp_desc = ''
                     
                     CALL axrp400_xrda_dis('site')
                     DISPLAY BY NAME g_master.xrdald_desc,g_master.xrdacomp_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_axrt300_date_chk(g_master.xrdasite,g_master.xrdadocdt) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = "axr-00299"
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_master.xrdasite = ''
                     LET g_master.xrdald = ''
                     LET g_master.xrdacomp_desc = ''
                     DISPLAY BY NAME g_master.xrdald_desc,g_master.xrdacomp_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161111-00049#1 Add  ---(S)---
                   SELECT glaacomp INTO g_glaa.glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrdald
                   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_glaa.glaacomp) RETURNING g_sub_success,g_sql_ctrl
                  #161111-00049#1 Add  ---(E)---
#                  
               END IF
               CALL axrp400_xrda_dis('site')
               CALL axrp400_xrda_dis('ld')
            #END add-point
            
 
            #Ctrlp:construct.c.xrdald
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD xrdald
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xrdald         #給予default值
               #取得帳務組織下所屬成員
               CALL s_fin_account_center_sons_query('3',g_master.xrdasite,g_master.xrdadocdt,'1')
               #取得帳務組織下所屬成員之帳別
               CALL s_fin_account_center_comp_str() RETURNING l_origin_str
               #將取回的字串轉換為SQL條件
               CALL axrp400_change_to_sql(l_origin_str) RETURNING l_origin_str
#160811-00009#4 mod s---               
#               IF l_origin_str <> '''' THEN
#                  LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN (",l_origin_str," )"
#               ELSE
#                  LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y')"
#               END IF
                LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN (",l_origin_str," )"
#160811-00009#4 mod e---
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               CALL  q_authorised_ld()                           #呼叫開窗
               LET g_master.xrdald = g_qryparam.return1          #將開窗取得的值回傳到變數
               DISPLAY g_master.xrdald TO xrdald                 #顯示到畫面上
               LET g_qryparam.where = ''
               CALL axrp400_xrda_dis('ld')
               NEXT FIELD xrdald                                 #返回原欄位
 
            #應用 a01 樣板自動產生(Version:1)
            BEFORE FIELD xrdald
               #add-point:BEFORE FIELD xrdald
               LET l_xrdald = g_master.xrdald
               #END add-point
 
            #應用 a02 樣板自動產生(Version:1)
            AFTER FIELD xrdald
            
               #add-point:AFTER FIELD xrdald
               LET g_master.xrdald_desc = ' '
               DISPLAY BY NAME g_master.xrdald_desc
               IF NOT cl_null(g_master.xrdald) THEN
                  CALL s_fin_account_center_with_ld_chk(g_master.xrdasite,g_master.xrdald,g_user,'3','N','',g_master.xrdadocdt) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_master.xrdald
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.xrdald = ''
                     CALL axrp400_xrda_dis('ld')
                     NEXT FIELD CURRENT
                  END IF
                  #161111-00049#1 Add  ---(S)---
                   SELECT glaacomp INTO g_glaa.glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrdald
                   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_glaa.glaacomp) RETURNING g_sub_success,g_sql_ctrl
                  #161111-00049#1 Add  ---(E)---
               END IF
               CALL axrp400_xrda_dis('ld')
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD glaacomp_desc
            #add-point:BEFORE FIELD glaacomp_desc

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD glaacomp_desc
            
            #add-point:AFTER FIELD glaacomp_desc

            #END add-point
            
 
         #Ctrlp:construct.c.glaacomp_desc
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD glaacomp_desc
            #add-point:ON ACTION controlp INFIELD glaacomp_desc

            #END add-point
 
         #Ctrlp:construct.c.xrdadocno
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xrdadocno
            #add-point:ON ACTION controlp INFIELD xrdadocno
            #應用 a08 樣板自動產生(Version:2)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xrdadocno             #給予default值
            LET l_glaa024 = ''
            SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrdald
            #給予arg
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = "axrt400"
            
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_master.xrdadocno = g_qryparam.return1              

            DISPLAY g_master.xrdadocno TO xrdadocno              #

            NEXT FIELD xrdadocno                          #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xrdadocno
            #add-point:BEFORE FIELD xrdadocno

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xrdadocno
            
            #add-point:AFTER FIELD xrdadocno
            LET l_glaa024 = ''
            SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrdald
            IF NOT cl_null(g_master.xrdadocno) THEN
               CALL s_aooi200_fin_chk_slip(g_master.xrdald,l_glaa024,g_master.xrdadocno,'axrt400') RETURNING l_success
               IF l_success = FALSE THEN
                  LET g_master.xrdadocno = ''
                  NEXT FIELD xrdadocno
               END IF
            END IF
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xrda003
            #add-point:BEFORE FIELD xrda003
            LET l_xrda003 = g_master.xrda003
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xrda003
            
            #add-point:AFTER FIELD xrda003
            IF NOT cl_null(g_master.xrda003) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.xrda003
               #160318-00025#35  2016/05/15  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#35  2016/05/15  by pengxin  add(E)
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.xrda003 = l_xrda003
                  CALL axrp400_ref_xrda003()
                  NEXT FIELD CURRENT
               END IF
            
               CALL axrp400_ref_xrda003() 
            END IF 
            #END add-point
            
 
         #Ctrlp:construct.c.xrda003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xrda003
            #add-point:ON ACTION controlp INFIELD xrda003
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xrda003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_master.xrda003 = g_qryparam.return1       
            CALL axrp400_ref_xrda003()            

            DISPLAY g_master.xrda003 TO xrda003              #

            NEXT FIELD xrda003                          #返回原欄位
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xrdadocdt
            #add-point:BEFORE FIELD xrdadocdt
            LET l_xrdadocdt = g_master.xrdadocdt
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xrdadocdt
            
            #add-point:AFTER FIELD xrdadocdt
            IF NOT cl_null(g_master.xrdadocdt) THEN
               CALL s_axrt300_date_chk(g_master.xrdasite,g_master.xrdadocdt) RETURNING l_success
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "axr-00299"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_master.xrdadocdt = l_xrdadocdt
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
         #Ctrlp:construct.c.xrdadocdt
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xrdadocdt
            #add-point:ON ACTION controlp INFIELD xrdadocdt

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xrca063
            #add-point:BEFORE FIELD xrca063

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xrca063
            
            #add-point:AFTER FIELD xrca063

            #END add-point
            
 
         #Ctrlp:construct.c.xrca063
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xrca063
            #add-point:ON ACTION controlp INFIELD xrca063
            CALL s_aooi390_gen('14') RETURNING l_success_1,g_master.xrca063,l_oofg_return
            DISPLAY BY NAME g_master.xrca063
            NEXT FIELD xrca063
            #END add-point
 
  
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD diff
            #add-point:BEFORE FIELD diff

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD diff
            
            #add-point:AFTER FIELD diff

            #END add-point
            
 
         #Ctrlp:construct.c.diff
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD diff
            #add-point:ON ACTION controlp INFIELD diff

            #END add-point
 
         END INPUT
         
      CONSTRUCT BY NAME g_wc1 ON b_nmbbdocno,b_nmbbseq,b_nmbb026,b_nmbadocdt,b_nmbb029,b_nmbb004,b_nmba008,b_nmbb031,b_nmbb030,b_nmbb003
             BEFORE CONSTRUCT

         #161130-00023#1 Add  ---(S)---
         AFTER FIELD b_nmbb026
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_nmbb026
         #161130-00023#1 Add  ---(E)---

         #Ctrlp:construct.c.nmbbdocno
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_nmbbdocno
            #add-point:ON ACTION controlp INFIELD nmbbdocno
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmbbcomp = '",g_glaa.glaacomp,"'"
           #CALL q_nmbbdocno()                           #呼叫開窗        #160912-00011#2 Mark
            CALL q_nmbbdocno_1()                           #呼叫開窗      #160912-00011#2 Add
            LET g_qryparam.where = ""
            DISPLAY g_qryparam.return1 TO b_nmbbdocno  #顯示到畫面上
            NEXT FIELD b_nmbbdocno                     #返回原欄位
            #END add-point
 
         
         #Ctrlp:construct.c.nmbb026
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_nmbb026
            #add-point:ON ACTION controlp INFIELD nmbb026
            #應用 a08 樣板自動產生(Version:2)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #161111-00049#1 Mark ---(S)---
			  #LET g_qryparam.arg1 = g_glaa.glaacomp
           #CALL q_pmaa001_13()                         #呼叫開窗
			   #161111-00049#1 Mark ---(E)---
			   #161111-00049#1 Add  ---(S)---
            LET g_qryparam.where = "pmaa002 IN ('2','3')"
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_sql_ctrl
            END IF
            LET g_qryparam.arg1="('2','3')"
            CALL q_pmaa001_1()
			   #161111-00049#1 Add  ---(E)---
            DISPLAY g_qryparam.return1 TO b_nmbb026      #顯示到畫面上
            NEXT FIELD b_nmbb026                         #返回原欄位
            #END add-point
           

         #Ctrlp:construct.c.nmbb004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_nmbb004
            #add-point:ON ACTION controlp INFIELD nmbb004
            #應用 a08 樣板自動產生(Version:2)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbb004      #顯示到畫面上
            NEXT FIELD b_nmbb004                         #返回原欄位
            #END add-point
            
         #Ctrlp:construct.c.nmba008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_nmba008
            #add-point:ON ACTION controlp INFIELD nmba008
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmba008  #顯示到畫面上
            NEXT FIELD b_nmba008                    #返回原欄位
            #END add-point
 
         #Ctrlp:construct.c.nmbb030
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_nmbb030
            #add-point:ON ACTION controlp INFIELD nmbb030
            #應用 a08 樣板自動產生(Version:2)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_nmbb030_02()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbb030      #顯示到畫面上
            NEXT FIELD b_nmbb030                         #返回原欄位
            #END add-point
        
         #Ctrlp:construct.c.nmbb003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_nmbb003
            #add-point:ON ACTION controlp INFIELD nmbb003
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbb003  #顯示到畫面上
            NEXT FIELD b_nmbb003                     #返回原欄位

            #END add-point
            
         END CONSTRUCT
        
         CONSTRUCT BY NAME g_wc3 ON flag
          
           AFTER CONSTRUCT
             IF g_wc3 = "flag='1'" THEN
                CALL cl_set_combo_scc('b_xrca001','8302')
             ELSE
                CALL cl_set_combo_scc('b_xrca001','8502')
             END IF
        END CONSTRUCT
       
        CONSTRUCT BY NAME g_wc2 ON b_xrcadocno,b_xrccseq,b_xrcc001,b_xrcasite,b_xrca003,b_xrca005,b_xrcald
           BEFORE CONSTRUCT
            IF g_wc3 = "flag='1'" THEN
                CALL cl_set_combo_scc('b_xrca001','8302')
             ELSE
                CALL cl_set_combo_scc('b_xrca001','8502')
             END IF
         
            #Ctrlp:construct.c.xrcadocno
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD b_xrcadocno
               #add-point:ON ACTION controlp INFIELD xrcadocno
               #應用 a08 樣板自動產生(Version:2)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      IF g_wc3 = "flag='1'" OR g_wc3 = " 1=1" THEN   #160530-00005#5 Add g_wc3 = " 1=1"
                  LET g_qryparam.where= "xrcadocdt <= '",g_master.xrdadocdt,"'",
                                        " AND xrca001 NOT IN ('01','02','03','04','31','141','142')",
                                        " AND xrcald ='",g_master.xrdald,"'",
                                        " AND xrcadocno IN (SELECT UNIQUE xrcadocno FROM axrp400_cum_tmp )"  #160530-00005#5 Del NOT
                  CALL q_xrcadocno_12()                         #呼叫開窗
               ELSE
                  LET g_qryparam.where= "apcadocdt <= '",g_master.xrdadocdt,"'",
                                        " AND apcald ='",g_master.xrdald,"'",
                                        " AND apcadocno IN (SELECT UNIQUE xrcadocno FROM axrp400_cum_tmp )"  #160530-00005#5 Del NOT
                  CALL q_apcadocno_14()
               END IF
               DISPLAY g_qryparam.return1 TO b_xrcadocno      #顯示到畫面上
               LET g_qryparam.where=NULL
               NEXT FIELD b_xrcadocno                        #返回原欄位
               #END add-point
            
            ON ACTION controlp INFIELD b_xrcasite
               #add-point:ON ACTION controlp INFIELD xrcasite
               #應用 a08 樣板自動產生(Version:2)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               #CALL q_ooef001()                           #呼叫開窗   #161021-00050#3 mark
               CALL q_ooef001_46()                                    #161021-00050#3 add
               DISPLAY g_qryparam.return1 TO b_xrcasite    #顯示到畫面上
               NEXT FIELD b_xrcasite                       #返回原欄位
               #END add-point
            
            ON ACTION controlp INFIELD b_xrca003
               #add-point:ON ACTION controlp INFIELD xrca003
               #應用 a08 樣板自動產生(Version:2)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_xrca003      #顯示到畫面上
               NEXT FIELD b_xrca003                      #返回原欄位
               #END add-point
            
            ON ACTION controlp INFIELD b_xrca005
               #add-point:ON ACTION controlp INFIELD xrca005
               #應用 a08 樣板自動產生(Version:2)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      #161111-00049#1 Mark ---(S)---
			     #LET g_qryparam.arg1 = g_glaa.glaacomp
              #CALL q_pmaa001_13()                         #呼叫開窗
			      #161111-00049#1 Mark ---(E)---
			      #161111-00049#1 Add  ---(S)---
               LET g_qryparam.where = "pmaa002 IN ('2','3')"
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND ",g_sql_ctrl
               END IF
               LET g_qryparam.arg1="('2','3')"
               CALL q_pmaa001_1()
			      #161111-00049#1 Add  ---(E)---
               DISPLAY g_qryparam.return1 TO b_xrca005      #顯示到畫面上
               NEXT FIELD b_xrca005                      #返回原欄位
               #END add-point
            
            ON ACTION controlp INFIELD b_xrcald
               #add-point:ON ACTION controlp INFIELD xrcald
               #應用 a08 樣板自動產生(Version:2)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_authorised_ld()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_xrcald     #顯示到畫面上
               NEXT FIELD b_xrcld                      #返回原欄位
               #END add-point
            
         END CONSTRUCT
         #end add-point
      
#      ON ACTION cum_query  #累計查詢
#         CALL axrp400_cum_query()
#         ACCEPT DIALOG
      
      ON ACTION qbe_select      
 
      ON ACTION qbe_save       
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   
   CALL cl_set_act_visible("accept,cancel", TRUE)

   #161130-00023#1 Add  ---(S)---
   IF NOT cl_null(g_nmbb026) THEN
      LET g_nmbb026 = cl_replace_str(g_nmbb026,"|","','")
      LET g_nmbb026 = " xrca004 IN ('",g_nmbb026,"')"
   ELSE
      LET g_nmbb026 = " 1=1"
   END IF
   LET g_nmbb026_t  = g_nmbb026
   #161130-00023#1 Add  ---(E)---
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0 
      RETURN
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
PRIVATE FUNCTION axrp400_ui_dialog_1()
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define
   DEFINE li_idx1           LIKE type_t.num10
   DEFINE l_n               LIKE type_t.num10
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_xrdasite        LIKE xrda_t.xrdasite
   DEFINE l_xrdald          LIKE xrda_t.xrdald
   DEFINE l_xrda003         LIKE xrda_t.xrda003
   DEFINE l_xrdadocdt       LIKE xrda_t.xrdadocdt
   DEFINE l_glaa024         LIKE glaa_t.glaa024
   DEFINE l_success_1    LIKE type_t.num5
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
                   oofg019     LIKE oofg_t.oofg019,   #field
                   oofg020     LIKE oofg_t.oofg020    #value
                           END RECORD
   DEFINE l_origin_str      STRING
   DEFINE l_amt2             LIKE xrde_t.xrde109     #收款金額
   DEFINE l_amt4             LIKE xrce_t.xrce109     #帳款金額
   DEFINE l_amt6             LIKE xrce_t.xrce109     #匯差及調整金額
   DEFINE l_amt8             LIKE xrce_t.xrce109     #差異金額
   #160325-00025#1---(S)
   DEFINE l_set_o            DYNAMIC ARRAY OF RECORD 
                               sel  LIKE type_t.chr1,    #第1單身紀錄選取狀況  
                               sel1 LIKE type_t.chr1     #第2單身紀錄選取狀況 
                             END RECORD                               
   #160325-00025#1---(E)                          
   DEFINE l_amt41            LIKE xrca_t.xrca108     #161114-00028#1 Add
   #end add-point 
   #add-point:ui_dialog段define

   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         CALL g_detail2_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc1 = ' 1=1'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axrp400_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct
          

         #end add-point
         #add-point:ui_dialog段input
         
         INPUT ARRAY g_detail_d FROM s_detail1.* 
              ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                        INSERT ROW = FALSE,
                        DELETE ROW = FALSE,
                        APPEND ROW = FALSE)
            BEFORE INPUT
               IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
                 CALL FGL_SET_ARR_CURR(g_detail_d.getLength()+1) 
                 LET g_insert = 'N' 
               END IF 
               CALL cl_set_comp_entry("b_nmbbdocno,b_nmbbseq,b_nmbb026,b_nmbadocdt,b_nmbb029,b_nmbb004,b_nmbb006,b_nmbb008,
                                       b_nmba008,b_nmbb031,b_nmbb030,b_nmbb040,b_nmbb003,b_nmbb005,b_nmbb009",FALSE)
             
            BEFORE ROW
               LET l_ac = ARR_CURR()
               LET g_master_idx = l_ac
               DISPLAY l_ac TO FORMONLY.h_index
              #CALL axrp400_fetch()              
               
            ON CHANGE sel
               #161003-00015#1--add--str--
               LET l_ac = ARR_CURR()
               LET g_master_idx = l_ac
               DISPLAY l_ac TO FORMONLY.h_index
               #161003-00015#1--add--end
               UPDATE axrp400_tmp 
                  SET sel = g_detail_d[l_ac].sel 
                WHERE nmbbdocno = g_detail_d[l_ac].nmbbdocno  
                  AND nmbbseq = g_detail_d[l_ac].nmbbseq
               
               CALL axrp400_ref_nmbb_amt(g_detail_d[l_ac].sel,g_detail_d[l_ac].nmbbdocno,g_detail_d[l_ac].nmbbseq,l_amt2) RETURNING l_amt2
               IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
               IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8 = 0 END IF
               #161114-00028#1 Add  ---(S)---
               IF l_amt4 < 0 THEN
                  LET l_amt41 = l_amt4 * -1
               ELSE
                  LET l_amt41 = l_amt4
               END IF
               #161114-00028#1 Add  ---(E)---
               DISPLAY l_amt2,l_amt41,l_amt8 TO sum5,sum6,sum7   #161114-00028#1 Mod l_amt4 - l_amt41
               CALL axrp400_b_fill1()
                  
         END INPUT
         

          INPUT ARRAY g_detail2_d FROM s_detail2.* 
              ATTRIBUTE(COUNT = g_rec_b1,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                        INSERT ROW = FALSE,
                        DELETE ROW = FALSE,
                        APPEND ROW = FALSE)
            BEFORE INPUT
                LET g_rec_b = g_detail2_d.getLength()
                CALL cl_set_comp_entry("flag,b_xrcadocno,b_xrccseq,b_xrcc001,b_xrca001,b_xrcasite,b_xrca003,b_xrca005,b_xrcald,
                                        b_xrcadocdt,b_xrcc108,b_xrcc109,b_xrcc108_1",FALSE)
             
            BEFORE ROW
               LET l_ac1 = ARR_CURR()
               LET g_master_idx = l_ac1
              #DISPLAY l_ac TO FORMONLY.h_index
              #CALL axrp400_fetch()              
               
            ON CHANGE sel1
               #161003-00015#1--add--str--
               LET l_ac1 = ARR_CURR()
               LET g_master_idx = l_ac1
               #161003-00015#1--add--end
#               UPDATE axrp400_tmp    #161003-00015#1 mark
               UPDATE axrp400_cum_tmp #161003-00015#1 add
                  SET sel1 = g_detail2_d[l_ac1].sel1
                WHERE xrcadocno = g_detail2_d[l_ac1].xrcadocno  
                  AND xrccseq = g_detail2_d[l_ac1].xrccseq    
                  AND xrcc001 = g_detail2_d[l_ac1].xrcc001
            
               CALL axrp400_ref_amt1(g_detail2_d[l_ac1].flag,g_detail2_d[l_ac1].sel1,g_detail2_d[l_ac1].xrcadocno,g_detail2_d[l_ac1].xrca001,g_detail2_d[l_ac1].xrccseq,g_detail2_d[l_ac1].xrcc001,l_amt4) RETURNING l_amt4
               IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
               IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8 = 0 END IF
               LET l_amt8 = l_amt2 - l_amt4   #161114-00028#1 Mod + --> -
               #161114-00028#1 Add  ---(S)---
               IF l_amt4 < 0 THEN
                  LET l_amt41 = l_amt4 * -1
               ELSE
                  LET l_amt41 = l_amt4
               END IF
               #161114-00028#1 Add  ---(E)---
               DISPLAY l_amt2,l_amt41,l_amt8 TO sum5,sum6,sum7   #161114-00028#1 Mod l_amt4 - l_amt41
               LET g_amt_xrde119 = l_amt2   #161013-00003#2 Add
               LET g_amt_xrce119 = l_amt4   #161013-00003#2 Add
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array
         #應用 a58 樣板自動產生(Version:2)
         
#         DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
#      
#            BEFORE DISPLAY 
#               LET g_current_page = 1
# 
#            BEFORE ROW
#               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
#               LET l_cnt = g_detail_idx
#               DISPLAY g_detail_idx TO FORMONLY.h_index
#               DISPLAY g_detail2_d.getLength() TO FORMONLY.h_count
#               LET g_master_idx = l_cnt
#         
#         END DISPLAY
#         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt) 
#      
#            BEFORE DISPLAY 
#               LET g_current_page = 1
# 
#            BEFORE ROW
#               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
#               LET l_cnt = g_detail_idx
#               DISPLAY g_detail_idx TO FORMONLY.h_index
#               DISPLAY g_detail2_d.getLength() TO FORMONLY.h_count
#               LET g_master_idx = l_cnt
#
#            
#               
#         END DISPLAY

         #end add-point
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.sel1", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.sel1", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2
            CALL axrp400_construct()
            CALL axrp400_b_fill()
            #160929-00026#1 Add  ---(S)---
            IF g_detail_d.getLength() = 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.sel1", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.sel1", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #160929-00026#1 Add  ---(E)---
            LET l_amt2 = 0
            LET l_amt4 = 0
            LET l_amt8 = 0
           #CALL axrp400_b_fill1()
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall

            #end add-point            
            LET l_amt2 = 0
            LET l_amt4 = 0
            LET l_amt8 = 0
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall
               UPDATE axrp400_tmp SET sel = g_detail_d[li_idx].sel 
                WHERE nmbbdocno = g_detail_d[li_idx].nmbbdocno
                  AND nmbbseq = g_detail_d[li_idx].nmbbseq
               CALL axrp400_ref_nmbb_amt(g_detail_d[li_idx].sel,g_detail_d[li_idx].nmbbdocno,g_detail_d[li_idx].nmbbseq,l_amt2) RETURNING l_amt2
               IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
               IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8 = 0 END IF
               LET l_amt8 = l_amt2 + l_amt4
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall
            CALL DIALOG.setSelectionRange("s_detail2", 1, -1, 1)
            FOR li_idx1 = 1 TO g_detail2_d.getLength()
               LET g_detail2_d[li_idx1].sel1 = "Y"
#               UPDATE axrp400_tmp SET sel1 = g_detail2_d[li_idx1].sel1    #161003-00015#1 mark
               UPDATE axrp400_cum_tmp SET sel1 = g_detail2_d[li_idx1].sel1 #161003-00015#1 add
                WHERE xrcadocno = g_detail2_d[li_idx1].xrcadocno
                  AND xrccseq = g_detail2_d[li_idx1].xrccseq
                  AND xrcc001 = g_detail2_d[li_idx1].xrcc001
               CALL axrp400_ref_amt1(g_detail2_d[li_idx1].flag,g_detail2_d[li_idx1].sel1,g_detail2_d[li_idx1].xrcadocno,g_detail2_d[li_idx1].xrca001,g_detail2_d[li_idx1].xrccseq,g_detail2_d[li_idx1].xrcc001,l_amt4)
                 RETURNING l_amt4
               IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
               IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
               IF cl_null(l_amt8) THEN LET l_amt8 = 0 END IF
               LET l_amt8 = l_amt2 - l_amt4   #161114-00028#1 Mod + --> -
            END FOR
            #161114-00028#1 Add  ---(S)---
            IF l_amt4 < 0 THEN
               LET l_amt41 = l_amt4 * -1
            ELSE
               LET l_amt41 = l_amt4
            END IF
            #161114-00028#1 Add  ---(E)---
            DISPLAY l_amt2,l_amt41,l_amt8 TO sum5,sum6,sum7   #161114-00028#1 Mod l_amt4 - l_amt41
            LET g_amt_xrde119 = l_amt2   #161013-00003#2 Add
            LET g_amt_xrce119 = l_amt4   #161013-00003#2 Add
            CALL axrp400_b_fill1()       #161114-00028#1 Add
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               UPDATE axrp400_tmp SET sel = g_detail_d[li_idx].sel 
                WHERE nmbbdocno = g_detail_d[li_idx].nmbbdocno
                  AND nmbbseq = g_detail_d[li_idx].nmbbseq
            END FOR
            CALL DIALOG.setSelectionRange("s_detail2", 1, -1, 0)
            FOR li_idx1 = 1 TO g_detail2_d.getLength()
               LET g_detail2_d[li_idx1].sel1 = "N"
#               UPDATE axrp400_tmp SET sel1 = g_detail2_d[li_idx1].sel1    #161003-00015#1 mark
               UPDATE axrp400_cum_tmp SET sel1 = g_detail2_d[li_idx1].sel1 #161003-00015#1 add
                WHERE xrcadocno = g_detail2_d[li_idx1].xrcadocno
                  AND xrccseq = g_detail2_d[li_idx1].xrccseq
                  AND xrcc001 = g_detail2_d[li_idx1].xrcc001
            END FOR
            LET l_amt2 = 0
            LET l_amt4 = 0
            LET l_amt8 = 0
            DISPLAY l_amt2,l_amt4,l_amt8 TO sum5,sum6,sum7
            CALL axrp400_b_fill1()       #161114-00028#1 Add
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET l_set_o[li_idx].sel  = g_detail_d[li_idx].sel  #160325-00025#1 add                  
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel
            FOR li_idx = 1 TO g_detail_d.getLength()               
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  #有異動才計算               
                  IF l_set_o[li_idx].sel = 'N' THEN                  #160325-00025#1 add
                     LET g_detail_d[li_idx].sel = "Y"
                     UPDATE axrp400_tmp SET sel = g_detail_d[li_idx].sel 
                      WHERE nmbbdocno = g_detail_d[li_idx].nmbbdocno
                        AND nmbbseq = g_detail_d[li_idx].nmbbseq
                     CALL axrp400_ref_nmbb_amt(g_detail_d[li_idx].sel,g_detail_d[li_idx].nmbbdocno,g_detail_d[li_idx].nmbbseq,l_amt2) RETURNING l_amt2
                     IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
                     IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
                     IF cl_null(l_amt8) THEN LET l_amt8 = 0 END IF
                     LET l_amt8 = l_amt2 + l_amt4                     
                     #161114-00028#1 Add  ---(S)---
                     IF l_amt4 < 0 THEN
                        LET l_amt41 = l_amt4 * -1
                     ELSE
                        LET l_amt41 = l_amt4
                     END IF
                     #161114-00028#1 Add  ---(E)---
                     DISPLAY l_amt2,l_amt41,l_amt8 TO sum5,sum6,sum7   #161114-00028#1 Mod l_amt4 - l_amt41
                  END IF  #160325-00025#1 add
               END IF
            END FOR
            FOR li_idx1 = 1 TO g_detail2_d.getLength()     
               LET l_set_o[li_idx1].sel1 = g_detail2_d[li_idx1].sel1 #160325-00025#1 add            
               IF DIALOG.isRowSelected("s_detail2", li_idx1) THEN
                  #有異動才計算               
                  IF l_set_o[li_idx1].sel1 ='N' THEN                 #160325-00025#1 add
                     LET g_detail2_d[li_idx1].sel1 = "Y"
#                     UPDATE axrp400_tmp SET sel1 = g_detail2_d[li_idx1].sel1    #161003-00015#1 mark
                     UPDATE axrp400_cum_tmp SET sel1 = g_detail2_d[li_idx1].sel1 #161003-00015#1 add
                      WHERE xrcadocno = g_detail2_d[li_idx1].xrcadocno
                        AND xrccseq = g_detail2_d[li_idx1].xrccseq
                        AND xrcc001 = g_detail2_d[li_idx1].xrcc001
                     CALL axrp400_ref_amt1(g_detail2_d[li_idx1].flag,g_detail2_d[li_idx1].sel1,g_detail2_d[li_idx1].xrcadocno,g_detail2_d[li_idx1].xrca001,g_detail2_d[li_idx1].xrccseq,g_detail2_d[li_idx1].xrcc001,l_amt4)
                       RETURNING l_amt4
                     IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
                     IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
                     IF cl_null(l_amt8) THEN LET l_amt8 = 0 END IF
                     LET l_amt8 = l_amt2 - l_amt4   #161114-00028#1 Mod + --> -
                     #161114-00028#1 Add  ---(S)---
                     IF l_amt4 < 0 THEN
                        LET l_amt41 = l_amt4 * -1
                     ELSE
                        LET l_amt41 = l_amt4
                     END IF
                     #161114-00028#1 Add  ---(E)---
                     DISPLAY l_amt2,l_amt41,l_amt8 TO sum5,sum6,sum7   #161114-00028#1 Mod l_amt4 - l_amt41
                     LET g_amt_xrde119 = l_amt2   #161013-00003#2 Add
                     LET g_amt_xrce119 = l_amt4   #161013-00003#2 Add
                  END IF  #160325-00025#1 add   
               END IF
            END FOR
            CALL axrp400_b_fill1()       #161114-00028#1 Add
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET l_set_o[li_idx].sel  = g_detail_d[li_idx].sel  #160325-00025#1 add
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel
            FOR li_idx = 1 TO g_detail_d.getLength()               
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  #有異動才計算               
                  IF l_set_o[li_idx].sel = 'Y' THEN                   #160325-00025#1 add
                     LET g_detail_d[li_idx].sel = "N"
                     UPDATE axrp400_tmp SET sel = g_detail_d[li_idx].sel 
                      WHERE nmbbdocno = g_detail_d[li_idx].nmbbdocno
                        AND nmbbseq = g_detail_d[li_idx].nmbbseq
                     CALL axrp400_ref_nmbb_amt(g_detail_d[li_idx].sel,g_detail_d[li_idx].nmbbdocno,g_detail_d[li_idx].nmbbseq,l_amt2) RETURNING l_amt2
                     IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
                     IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
                     IF cl_null(l_amt8) THEN LET l_amt8 = 0 END IF
                     #LET l_amt8 = l_amt8 - l_amt2            #160325-00025#1 mark
                     LET l_amt8 = l_amt2 + l_amt4             #160325-00025#1 add
                     #161114-00028#1 Add  ---(S)---
                     IF l_amt4 < 0 THEN
                        LET l_amt41 = l_amt4 * -1
                     ELSE
                        LET l_amt41 = l_amt4
                     END IF
                     #161114-00028#1 Add  ---(E)---
                     DISPLAY l_amt2,l_amt41,l_amt8 TO sum5,sum6,sum7   #161114-00028#1 Mod l_amt4 - l_amt41
                  END IF  #160325-00025#1 add
               END IF
            END FOR
            FOR li_idx1 = 1 TO g_detail2_d.getLength()   
               LET l_set_o[li_idx1].sel1 = g_detail2_d[li_idx1].sel1  #160325-00025#1 add              
               IF DIALOG.isRowSelected("s_detail2", li_idx1) THEN  
                  #有異動才計算               
                  IF l_set_o[li_idx1].sel1 = 'Y' THEN                 #160325-00025#1 add
                     LET g_detail2_d[li_idx1].sel1 = "N"
#                     UPDATE axrp400_tmp SET sel1 = g_detail2_d[li_idx1].sel1    #161003-00015#1 mark
                     UPDATE axrp400_cum_tmp SET sel1 = g_detail2_d[li_idx1].sel1 #161003-00015#1 add
                      WHERE xrcadocno = g_detail2_d[li_idx1].xrcadocno
                        AND xrccseq = g_detail2_d[li_idx1].xrccseq
                        AND xrcc001 = g_detail2_d[li_idx1].xrcc001
                     CALL axrp400_ref_amt1(g_detail2_d[li_idx1].flag,g_detail2_d[li_idx1].sel1,g_detail2_d[li_idx1].xrcadocno,g_detail2_d[li_idx1].xrca001,g_detail2_d[li_idx1].xrccseq,g_detail2_d[li_idx1].xrcc001,l_amt4)
                       RETURNING l_amt4
                     IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
                     IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
                     IF cl_null(l_amt8) THEN LET l_amt8 = 0 END IF
                     #LET l_amt8 = l_amt8 - l_amt4            #160325-00025#1 mark 
                     LET l_amt8 = l_amt2 + l_amt4             #160325-00025#1 add
                     LET l_amt8 = l_amt2 - l_amt4   #161114-00028#1 Mod + --> -
                     #161114-00028#1 Add  ---(S)---
                     IF l_amt4 < 0 THEN
                        LET l_amt41 = l_amt4 * -1
                     ELSE
                        LET l_amt41 = l_amt4
                     END IF
                     #161114-00028#1 Add  ---(E)---
                     DISPLAY l_amt2,l_amt41,l_amt8 TO sum5,sum6,sum7   #161114-00028#1 Mod l_amt4 - l_amt41
                     LET g_amt_xrde119 = l_amt2   #161013-00003#2 Add
                     LET g_amt_xrce119 = l_amt4   #161013-00003#2 Add
                  END IF  #160325-00025#1 add
               END IF
            END FOR
            CALL axrp400_b_fill1()       #161114-00028#1 Add
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrp400_filter()
            #add-point:ON ACTION filter
            LET l_amt2=0  #161003-00015#1 add
            LET l_amt4=0  #161003-00015#1 add
            LET l_amt8=0  #161003-00015#1 add
            #END add-point
           #EXIT DIALOG   #160620-00010#1 Mark
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
           #LET INT_FLAG=FALSE
            LET g_action_choice="exit"
            EXIT DIALOG
 
#         ON ACTION accept
#            #add-point:ui_dialog段accept之前
#
#            #end add-point
#            CALL axrp400_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段
            CLEAR FORM
            INITIALIZE g_master.* TO NULL
            CALL axrp400_def()
            CALL g_detail_d.clear()
            CALL g_detail2_d.clear()
            CALL axrp400_construct()
            CALL axrp400_b_fill()
            LET l_amt2=0  #161003-00015#1 add
            LET l_amt4=0  #161003-00015#1 add
            LET l_amt8=0  #161003-00015#1 add
            DISPLAY 0,0,0 TO sum5,sum6,sum7
           #CALL axrp400_b_fill1()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh
            LET l_amt2=0  #161003-00015#1 add
            LET l_amt4=0  #161003-00015#1 add
            LET l_amt8=0  #161003-00015#1 add
            #end add-point
            CALL axrp400_b_fill()
 
         #add-point:ui_dialog段action
         ON ACTION cancel
            #清除畫面及相關資料
            CLEAR FORM
            CALL g_detail_d.clear()
            CALL g_detail2_d.clear()
            LET g_wc  = ' 1=2'
            LET g_wc1 = ' 1=1'
            LET g_wc2 = ' 1=1'
            LET g_action_choice = ""
            CALL axrp400_init()
            DISPLAY 0,0,0 TO sum5,sum6,sum7
            LET INT_FLAG = 0
            EXIT DIALOG 
            
         ON ACTION batch_execute
            SELECT COUNT(*) INTO l_n
              FROM axrp400_tmp
             WHERE (sel = 'Y' OR sel1 = 'Y')
            IF l_n = 0 THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'axr-00159' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               EXIT DIALOG
            END IF
            
            CALL axrp400_get_ar()
            EXIT DIALOG   #160620-00010#1 Add
         
         ON ACTION cum_query  #累計查詢
            CALL axrp400_cum_query()
            CALL axrp400_b_fill1()
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
#      IF INT_FLAG THEN
#         LET INT_FLAG = FALSE
#         EXIT WHILE
#      END IF
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
   DROP TABLE axrp400_tmp;
   DROP TABLE axrp400_s01_tmp;
   DROP TABLE s_voucher_ar_tmp;       #160727-00019#6  2016/07/28 By 08734   临时表长度超过15码的减少到15码以下  s_voucher_ar_tmp ——> s_voucher_tmp09 
   DROP TABLE s_voucher_ar_group;     #160727-00019#6  2016/07/29 By 08734   s_voucher_ar_group ——> s_voucher_tmp05         
   DROP TABLE s_voucher_glbc;
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION

################################################################################
# Descriptions...: 金額欄位顯示
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
PRIVATE FUNCTION axrp400_ref_amt1(p_flag,p_sel1,p_xrcadocno,p_xrca001,p_xrccseq,p_xrcc001,p_amt4)
   DEFINE p_flag             LIKE type_t.chr1
   DEFINE p_sel1             LIKE type_t.chr1
   DEFINE p_xrcadocno        LIKE xrca_t.xrcadocno
   DEFINE p_xrca001          LIKE xrca_t.xrca001
   DEFINE p_xrccseq          LIKE xrcc_t.xrccseq
   DEFINE p_xrcc001          LIKE xrcc_t.xrcc001
   DEFINE p_amt4             LIKE xrce_t.xrce109
   DEFINE l_amt2             LIKE xrde_t.xrde109     #收款金額
   DEFINE l_amt4             LIKE xrce_t.xrce109     #帳款金額
   DEFINE l_amt6             LIKE xrce_t.xrce109     #匯差及調整金額
   DEFINE l_amt8             LIKE xrce_t.xrce109     #差異金額
   DEFINE l_xrca001_str      STRING
   DEFINE l_amt2_1           LIKE xrde_t.xrde109
   DEFINE l_xrce002          LIKE xrce_t.xrce002
   DEFINE l_gzcb003          LIKE gzcb_t.gzcb003
   DEFINE l_xrcc119          LIKE xrcc_t.xrcc119
   
   IF cl_null(p_amt4) THEN LET p_amt4 = 0 END IF
   IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
   #計算帳款
   LET l_xrca001_str = p_xrca001
   LET l_xrca001_str = l_xrca001_str.substring(1,1)
   IF p_flag = '1' THEN
      IF l_xrca001_str = '1' THEN
         LET l_xrce002 = '30'
      END IF 
      IF l_xrca001_str = '2' THEN
         LET l_xrce002 = '31'
      END IF
      SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
       WHERE gzcb001 = '8306'
         AND gzcb002 = l_xrce002
      #應收 - 已收
      SELECT xrcc118 - xrcc119 INTO l_xrcc119
        FROM xrcc_t
       WHERE xrccent = g_enterprise   AND xrccdocno = p_xrcadocno
         AND xrccld  = g_master.xrdald AND xrccseq = p_xrccseq
         AND xrcc001 = p_xrcc001
   ELSE
      IF l_xrca001_str = '1' THEN
         LET l_xrce002   = '40'
      END IF
      IF l_xrca001_str = '2' AND p_xrca001 <> '25' THEN 
         LET l_xrce002   = '41'
      END IF
      IF p_xrca001 = '25' THEN 
         LET l_xrce002   = '42'
      END IF
      SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
       WHERE gzcb001 = '8306'
         AND gzcb002 = l_xrce002
      #應收 - 已收
      SELECT apcc118 - apcc119 INTO l_xrcc119
        FROM apcc_t
       WHERE apccent = g_enterprise   AND apccdocno = p_xrcadocno
         AND apccld  = g_master.xrdald AND apccseq = p_xrccseq
         AND apcc001 = p_xrcc001
   END IF
   IF l_gzcb003 = 'C' THEN   #161114-00028#1 Mod D --> C
      LET l_amt4 = l_xrcc119
   ELSE
      LET l_amt4 = l_xrcc119 * -1
   END IF
   IF p_sel1 = 'N' THEN
      LET l_amt4 = p_amt4 - l_amt4
   ELSE
      LET l_amt4 = p_amt4 + l_amt4
   END IF

   RETURN l_amt4
   
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
PRIVATE FUNCTION axrp400_ref_nmbb_amt(p_sel,p_nmbbdocno,p_nmbbseq,p_amt2)
   DEFINE p_sel              LIKE type_t.chr1
   DEFINE p_nmbbdocno        LIKE nmbb_t.nmbbdocno
   DEFINE p_nmbbseq        LIKE nmbb_t.nmbbseq
   DEFINE p_amt2             LIKE xrde_t.xrde109
   DEFINE l_amt2             LIKE xrde_t.xrde109     #收款金額
   DEFINE l_amt2_1           LIKE xrde_t.xrde109     
   DEFINE l_nmbb007_1        LIKE xrde_t.xrde109
   DEFINE l_nmbb007_2        LIKE xrde_t.xrde109
   DEFINE l_nmbb007_3        LIKE xrde_t.xrde109
   
   IF cl_null(p_amt2) THEN LET p_amt2 = 0 END IF
   IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
   #計算收款
   SELECT nmbb007-nmbb009,nmbb007-nmbb021,nmbb007-nmbb024 INTO l_nmbb007_1,l_nmbb007_2,l_nmbb007_3
     FROM nmbb_t
    WHERE nmbbent = g_enterprise AND nmbbdocno = p_nmbbdocno 
      AND nmbbseq = p_nmbbseq
   CASE
      WHEN g_ls = 1
         LET l_amt2 = l_nmbb007_1
      WHEN g_ls = 2
         LET l_amt2 = l_nmbb007_2
      WHEN g_ls = 3
         LET l_amt2 = l_nmbb007_3
   END CASE
   IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
   IF p_sel = 'N' THEN
      LET l_amt2 = p_amt2 - l_amt2
   ELSE
      LET l_amt2 = p_amt2 + l_amt2
   END IF
   RETURN l_amt2
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
PRIVATE FUNCTION axrp400_s01()
   OPEN WINDOW w_axrp400_s01 WITH FORM cl_ap_formpath("axr","axrp400_s01")

   INPUT ARRAY g_detail_s FROM s_detail3.* 
              ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                        INSERT ROW = FALSE,
                        DELETE ROW = FALSE,
                        APPEND ROW = FALSE)
      BEFORE INPUT
         CALL axrp400_s01_b_fill()
         CALL cl_set_comp_entry("xrdadocno,amt1,amt2,amt3",FALSE)
      
      BEFORE ROW
         LET l_ac2 = ARR_CURR() 
      
      ON CHANGE diff1
         UPDATE axrp400_s01_tmp SET diff1 = g_detail_s[l_ac2].diff1
          WHERE xrdadocno = g_detail_s[l_ac2].xrdadocno
      
      ON ACTION accept1
         ACCEPT INPUT
   
#      ON ACTION cancel1
#         UPDATE axrp400_s01_tmp SET diff1 = '1'
#         LET INT_FLAG = TRUE
#         EXIT INPUT
   
      ON ACTION close
         LET INT_FLAG = TRUE
         LET g_success = 'N'
         EXIT INPUT
   
      ON ACTION exit
         LET INT_FLAG = TRUE
         LET g_success = 'N'
         EXIT INPUT
   
   END INPUT
   
   #畫面關閉
   CLOSE WINDOW w_axrp400_s01

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
PRIVATE FUNCTION axrp400_s01_b_fill()
   DEFINE l_glab003     LIKE glab_t.glab003
  #DEFINE l_xrde_t      RECORD LIKE xrde_t.*  #161219-00014#2--mark--
   #161219-00014#2--add--s--
   DEFINE l_xrde_t RECORD  #收款及差異處理明細檔
       xrdeent LIKE xrde_t.xrdeent, #
       xrdecomp LIKE xrde_t.xrdecomp, #法人
       xrdeld LIKE xrde_t.xrdeld, #
       xrdedocno LIKE xrde_t.xrdedocno, #冲销单单号
       xrdeseq LIKE xrde_t.xrdeseq, #项次
       xrdesite LIKE xrde_t.xrdesite, #账务中心
       xrdeorga LIKE xrde_t.xrdeorga, #账务归属组织
       xrde001 LIKE xrde_t.xrde001, #来源作业
       xrde002 LIKE xrde_t.xrde002, #冲销账款类型
       xrde003 LIKE xrde_t.xrde003, #来源单号
       xrde004 LIKE xrde_t.xrde004, #来源单项次
       xrde006 LIKE xrde_t.xrde006, #
       xrde007 LIKE xrde_t.xrde007, #款别编号
       xrde008 LIKE xrde_t.xrde008, #账户/票券号码
       xrde010 LIKE xrde_t.xrde010, #摘要
       xrde011 LIKE xrde_t.xrde011, #银行存提码
       xrde012 LIKE xrde_t.xrde012, #现金变动码
       xrde013 LIKE xrde_t.xrde013, #转入客商码
       xrde014 LIKE xrde_t.xrde014, #转入账款单编号
       xrde015 LIKE xrde_t.xrde015, #冲销加减项
       xrde016 LIKE xrde_t.xrde016, #冲销会科
       xrde017 LIKE xrde_t.xrde017, #业务人员
       xrde018 LIKE xrde_t.xrde018, #业务部门
       xrde019 LIKE xrde_t.xrde019, #责任中心
       xrde020 LIKE xrde_t.xrde020, #产品类别
       xrde022 LIKE xrde_t.xrde022, #项目编号
       xrde023 LIKE xrde_t.xrde023, #WBS编号
       xrde028 LIKE xrde_t.xrde028, #生成方式
       xrde029 LIKE xrde_t.xrde029, #凭证号码
       xrde030 LIKE xrde_t.xrde030, #凭证项次
       xrde035 LIKE xrde_t.xrde035, #区域
       xrde036 LIKE xrde_t.xrde036, #客群
       xrde038 LIKE xrde_t.xrde038, #对象
       xrde039 LIKE xrde_t.xrde039, #经营方式
       xrde040 LIKE xrde_t.xrde040, #渠道
       xrde041 LIKE xrde_t.xrde041, #品牌
       xrde042 LIKE xrde_t.xrde042, #自由核算项一
       xrde043 LIKE xrde_t.xrde043, #自由核算项二
       xrde044 LIKE xrde_t.xrde044, #自由核算项三
       xrde045 LIKE xrde_t.xrde045, #自由核算项四
       xrde046 LIKE xrde_t.xrde046, #自由核算项五
       xrde047 LIKE xrde_t.xrde047, #自由核算项六
       xrde048 LIKE xrde_t.xrde048, #自由核算项七
       xrde049 LIKE xrde_t.xrde049, #自由核算项八
       xrde050 LIKE xrde_t.xrde050, #自由核算项九
       xrde051 LIKE xrde_t.xrde051, #自由核算项十
       xrde100 LIKE xrde_t.xrde100, #币种
       xrde101 LIKE xrde_t.xrde101, #汇率
       xrde109 LIKE xrde_t.xrde109, #原币冲账金额
       xrde119 LIKE xrde_t.xrde119, #本币冲账金额
       xrde120 LIKE xrde_t.xrde120, #本位币二币种
       xrde121 LIKE xrde_t.xrde121, #本位币二汇率
       xrde129 LIKE xrde_t.xrde129, #本位币二冲账金额
       xrde130 LIKE xrde_t.xrde130, #本位币三币种
       xrde131 LIKE xrde_t.xrde131, #本位币三汇率
       xrde139 LIKE xrde_t.xrde139, #本位币三冲账金额
       xrde032 LIKE xrde_t.xrde032, #收款日期
       xrde108 LIKE xrde_t.xrde108, #原币手续费
       xrde118 LIKE xrde_t.xrde118  #本币手续费
       END RECORD
   #161219-00014#2--add--e--
   DEFINE l_sql         STRING
   DEFINE l_xrde100     LIKE xrde_t.xrde100
   DEFINE l_xrde109     LIKE xrde_t.xrde109
   DEFINE l_xrde119     LIKE xrde_t.xrde119
   DEFINE l_xrde109_1   LIKE xrde_t.xrde109
   DEFINE l_xrde119_1   LIKE xrde_t.xrde119
   DEFINE l_xrde109_2   LIKE xrde_t.xrde109
   DEFINE l_xrde119_2   LIKE xrde_t.xrde119
   DEFINE l_ooab002     LIKE ooab_t.ooab002
   DEFINE l_amt         LIKE xrde_t.xrde119   #匯差
 
   #本幣
   LET l_sql ="SELECT diff1,xrdadocno,amt1,amt2,amt3",
              "  FROM axrp400_s01_tmp WHERE amt3<>0"
   PREPARE axrt400_s01_prep FROM l_sql
   DECLARE axrt400_s01_curs CURSOR FOR axrt400_s01_prep

   CALL g_detail_s.clear()

   LET l_ac2 = 1   
   ERROR "Searching!" 
      
      
   FOREACH axrt400_s01_curs INTO g_detail_s[l_ac2].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      LET l_ac2 = l_ac2 + 1
      
   END FOREACH
  #CALL g_detail_s.deleteElement(g_detail_s.getLength())
   LET g_error_show = 0

   CLOSE axrt400_s01_curs
   
   LET l_ac2 = 1
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
PRIVATE FUNCTION axrp400_cum_query()
    
    DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
       CONSTRUCT BY NAME g_wc3 ON flag
          
          AFTER CONSTRUCT
             IF g_wc3 = "flag='1'" THEN
                CALL cl_set_combo_scc('b_xrca001','8302')
             ELSE
                CALL cl_set_combo_scc('b_xrca001','8502')
             END IF
       END CONSTRUCT
       
       CONSTRUCT BY NAME g_wc2 ON b_xrcadocno,b_xrccseq,b_xrcc001,b_xrcasite,b_xrca003,b_xrca005,b_xrcald
          BEFORE CONSTRUCT
            IF g_wc3 = "flag='1'" THEN
                CALL cl_set_combo_scc('b_xrca001','8302')
             ELSE
                CALL cl_set_combo_scc('b_xrca001','8502')
             END IF
         
            #Ctrlp:construct.c.xrcadocno
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD b_xrcadocno
               #add-point:ON ACTION controlp INFIELD xrcadocno
               #應用 a08 樣板自動產生(Version:2)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      IF g_wc3 = "flag='1'" OR g_wc3 = " 1=1" THEN   #160530-00005#5 Add g_wc3 = " 1=1"
                  LET g_qryparam.where= "xrcadocdt <= '",g_master.xrdadocdt,"'",
                                        " AND xrca001 NOT IN ('01','02','03','04','31','141','142')",
                                        " AND xrcald ='",g_master.xrdald,"'",
                                        " AND xrcadocno IN (SELECT UNIQUE xrcadocno FROM axrp400_cum_tmp )"  #160530-00005#5 Del NOT
                  CALL q_xrcadocno_12()                         #呼叫開窗
               ELSE
                  LET g_qryparam.where= "apcadocdt <= '",g_master.xrdadocdt,"'",
                                        " AND apcald ='",g_master.xrdald,"'",
                                        " AND apcadocno IN (SELECT UNIQUE xrcadocno FROM axrp400_cum_tmp )"  #160530-00005#5 Del NOT
                  CALL q_apcadocno_14()
               END IF
               DISPLAY g_qryparam.return1 TO b_xrcadocno      #顯示到畫面上
               LET g_qryparam.where=NULL
               NEXT FIELD b_xrcadocno                        #返回原欄位
               #END add-point
            
            ON ACTION controlp INFIELD b_xrcasite
               #add-point:ON ACTION controlp INFIELD xrcasite
               #應用 a08 樣板自動產生(Version:2)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               #CALL q_ooef001()                           #呼叫開窗    #161021-00050#3 mark
               CALL q_ooef001_46()                                     #161021-00050#3 add
               DISPLAY g_qryparam.return1 TO b_xrcasite    #顯示到畫面上
               NEXT FIELD b_xrcasite                       #返回原欄位
               #END add-point
            
            ON ACTION controlp INFIELD b_xrca003
               #add-point:ON ACTION controlp INFIELD xrca003
               #應用 a08 樣板自動產生(Version:2)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_xrca003      #顯示到畫面上
               NEXT FIELD b_xrca003                      #返回原欄位
               #END add-point
            
            ON ACTION controlp INFIELD b_xrca005
               #add-point:ON ACTION controlp INFIELD xrca005
               #應用 a08 樣板自動產生(Version:2)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.arg1 = g_glaa.glaacomp
               CALL q_pmaa001_13()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_xrca005      #顯示到畫面上
               NEXT FIELD b_xrca005                      #返回原欄位
               #END add-point
            
            ON ACTION controlp INFIELD b_xrcald
               #add-point:ON ACTION controlp INFIELD xrcald
               #應用 a08 樣板自動產生(Version:2)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_authorised_ld()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_xrcald     #顯示到畫面上
               NEXT FIELD b_xrcld                      #返回原欄位
               #END add-point
            
         END CONSTRUCT
       ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   
   
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0 
      RETURN
   END IF
END FUNCTION

################################################################################
# Descriptions...: 直接审核功能
# Memo...........:
# Usage..........: CALL axrp400_immediately_conf(p_start_no,p_end_no)
#                  RETURNING r_success
#
# Date & Author..: 2015/12/07 By 06862
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp400_immediately_conf(p_start_no,p_end_no)
   DEFINE p_nmbb026         LIKE nmbb_t.nmbb026
   DEFINE p_start_no        LIKE xrda_t.xrdadocno 
   DEFINE p_end_no          LIKE xrda_t.xrdadocno 
   DEFINE l_xrdacomp        LIKE xrda_t.xrdacomp
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_efin5001        LIKE type_t.chr1
   DEFINE l_ooba002         LIKE ooba_t.ooba002
   DEFINE l_flag            LIKE type_t.chr1
   DEFINE l_xrdamoddt       LIKE xrda_t.xrdamoddt
  #DEFINE l_xrda            RECORD LIKE xrda_t.*#161219-00014#2
   #161219-00014#2--add--s--
   DEFINE l_xrda RECORD  #收款核銷單單頭檔
       xrdaent LIKE xrda_t.xrdaent, #企业编号
       xrdacomp LIKE xrda_t.xrdacomp, #所属法人
       xrdald LIKE xrda_t.xrdald, #账套别
       xrdadocno LIKE xrda_t.xrdadocno, #冲账单号
       xrdadocdt LIKE xrda_t.xrdadocdt, #冲账日期
       xrdasite LIKE xrda_t.xrdasite, #账务组织
       xrda001 LIKE xrda_t.xrda001, #账款单性质
       xrda003 LIKE xrda_t.xrda003, #账务人员
       xrda004 LIKE xrda_t.xrda004, #账款核销客户
       xrda005 LIKE xrda_t.xrda005, #收款客户
       xrda006 LIKE xrda_t.xrda006, #一次性对象识别码
       xrda007 LIKE xrda_t.xrda007, #生成方式
       xrda008 LIKE xrda_t.xrda008, #来源参考单号
       xrda009 LIKE xrda_t.xrda009, #冲账批序号
       xrda010 LIKE xrda_t.xrda010, #集团代收付单号
       xrda011 LIKE xrda_t.xrda011, #差异处理
       xrda012 LIKE xrda_t.xrda012, #退款类型
       xrda013 LIKE xrda_t.xrda013, #分录底稿是否可重新生成
       xrda014 LIKE xrda_t.xrda014, #抛转凭证号码
       xrda015 LIKE xrda_t.xrda015, #作废理由码
       xrda016 LIKE xrda_t.xrda016, #打印次数
       xrda017 LIKE xrda_t.xrda017, #MEMO备注
       xrdastus LIKE xrda_t.xrdastus, #审核否
       xrdaownid LIKE xrda_t.xrdaownid, #资料所有者
       xrdaowndp LIKE xrda_t.xrdaowndp, #资料所有部门
       xrdacrtid LIKE xrda_t.xrdacrtid, #资料录入者
       xrdacrtdp LIKE xrda_t.xrdacrtdp, #资料录入部门
       xrdacrtdt LIKE xrda_t.xrdacrtdt, #资料创建日
       xrdamodid LIKE xrda_t.xrdamodid, #资料更改者
       xrdamoddt LIKE xrda_t.xrdamoddt, #最近更改日
       xrdaud001 LIKE xrda_t.xrdaud001, #自定义字段(文本)001
       xrdaud002 LIKE xrda_t.xrdaud002, #自定义字段(文本)002
       xrdaud003 LIKE xrda_t.xrdaud003, #自定义字段(文本)003
       xrdaud004 LIKE xrda_t.xrdaud004, #自定义字段(文本)004
       xrdaud005 LIKE xrda_t.xrdaud005, #自定义字段(文本)005
       xrdaud006 LIKE xrda_t.xrdaud006, #自定义字段(文本)006
       xrdaud007 LIKE xrda_t.xrdaud007, #自定义字段(文本)007
       xrdaud008 LIKE xrda_t.xrdaud008, #自定义字段(文本)008
       xrdaud009 LIKE xrda_t.xrdaud009, #自定义字段(文本)009
       xrdaud010 LIKE xrda_t.xrdaud010, #自定义字段(文本)010
       xrdaud011 LIKE xrda_t.xrdaud011, #自定义字段(数字)011
       xrdaud012 LIKE xrda_t.xrdaud012, #自定义字段(数字)012
       xrdaud013 LIKE xrda_t.xrdaud013, #自定义字段(数字)013
       xrdaud014 LIKE xrda_t.xrdaud014, #自定义字段(数字)014
       xrdaud015 LIKE xrda_t.xrdaud015, #自定义字段(数字)015
       xrdaud016 LIKE xrda_t.xrdaud016, #自定义字段(数字)016
       xrdaud017 LIKE xrda_t.xrdaud017, #自定义字段(数字)017
       xrdaud018 LIKE xrda_t.xrdaud018, #自定义字段(数字)018
       xrdaud019 LIKE xrda_t.xrdaud019, #自定义字段(数字)019
       xrdaud020 LIKE xrda_t.xrdaud020, #自定义字段(数字)020
       xrdaud021 LIKE xrda_t.xrdaud021, #自定义字段(日期时间)021
       xrdaud022 LIKE xrda_t.xrdaud022, #自定义字段(日期时间)022
       xrdaud023 LIKE xrda_t.xrdaud023, #自定义字段(日期时间)023
       xrdaud024 LIKE xrda_t.xrdaud024, #自定义字段(日期时间)024
       xrdaud025 LIKE xrda_t.xrdaud025, #自定义字段(日期时间)025
       xrdaud026 LIKE xrda_t.xrdaud026, #自定义字段(日期时间)026
       xrdaud027 LIKE xrda_t.xrdaud027, #自定义字段(日期时间)027
       xrdaud028 LIKE xrda_t.xrdaud028, #自定义字段(日期时间)028
       xrdaud029 LIKE xrda_t.xrdaud029, #自定义字段(日期时间)029
       xrdaud030 LIKE xrda_t.xrdaud030, #自定义字段(日期时间)030
       xrda103 LIKE xrda_t.xrda103, #原币借方金额合计
       xrda104 LIKE xrda_t.xrda104, #原币贷方金额合计
       xrda113 LIKE xrda_t.xrda113, #本币借方金额合计
       xrda114 LIKE xrda_t.xrda114, #本币贷方金额合计
       xrda123 LIKE xrda_t.xrda123, #本位币二借方金额合计
       xrda124 LIKE xrda_t.xrda124, #本位币二贷方金额合计
       xrda133 LIKE xrda_t.xrda133, #本位币三借方金额合计
       xrda134 LIKE xrda_t.xrda134, #本位币三贷方金额合计
       xrdacnfid LIKE xrda_t.xrdacnfid, #资料确认者
       xrdacnfdt LIKE xrda_t.xrdacnfdt, #数据审核日
       xrdapstid LIKE xrda_t.xrdapstid, #资料过账者
       xrdapstdt LIKE xrda_t.xrdapstdt, #资料过账日
       xrda018 LIKE xrda_t.xrda018 #来源类型(流通)
       END RECORD
   #161219-00014#2--add--e-- 
   DEFINE l_sql             STRING 

   LET r_success = TRUE 
   #161219-00014#2--mark--s--
#   LET l_sql = "SELECT * FROM xrda_t where xrdaent = '",g_enterprise,"' 
#                          and xrdadocno between '",p_start_no,"' and '",p_end_no,"'
#                          AND xrdald = '",g_master.xrdald,"' "
   #161219-00014#2--mark--e--
   #161219-00014#2--add--s--
   LET l_sql = "SELECT xrdaent,xrdacomp,xrdald,xrdadocno,xrdadocdt,xrdasite,xrda001,xrda003,xrda004,xrda005,xrda006,xrda007,xrda008,xrda009,xrda010,",
               " xrda011,xrda012,xrda013,xrda014,xrda015,xrda016,xrda017,xrdastus,xrdaownid,xrdaowndp,xrdacrtid,xrdacrtdp,xrdacrtdt,xrdamodid,xrdamoddt,",
               " xrdaud001,xrdaud002,xrdaud003,xrdaud004,xrdaud005,xrdaud006,xrdaud007,xrdaud008,xrdaud009,xrdaud010,xrdaud011,xrdaud012,xrdaud013,xrdaud014,",
               " xrdaud015,xrdaud016,xrdaud017,xrdaud018,xrdaud019,xrdaud020,xrdaud021,xrdaud022,xrdaud023,xrdaud024,xrdaud025,xrdaud026,xrdaud027,xrdaud028,",
               " xrdaud029,xrdaud030,xrda103,xrda104,xrda113,xrda114,xrda123,xrda124,xrda133,xrda134,xrdacnfid,xrdacnfdt,xrdapstid,xrdapstdt,xrda018 ",
               "  FROM xrda_t where xrdaent = '",g_enterprise,"' ",
               "   and xrdadocno between '",p_start_no,"' and '",p_end_no,"'",
               "   AND xrdald = '",g_master.xrdald,"' "
   #161219-00014#2--add--e--   
   PREPARE axrp400_immediately_conf_pre FROM l_sql
   DECLARE axrp400_immediately_conf_cs CURSOR FOR axrp400_immediately_conf_pre
   
   CALL s_transaction_begin()
   
   FOREACH axrp400_immediately_conf_cs INTO l_xrda.*
   
           #無資料直接返回不做處理
           IF cl_null(l_xrda.xrdald)  THEN 
              LET  r_success=FALSE   
              RETURN r_success 
           END IF 
           #無資料直接返回不做處理   
           IF cl_null(l_xrda.xrdacomp)  THEN 
              LET  r_success=FALSE   
              RETURN r_success 
           END IF 
           #無資料直接返回不做處理   
           IF cl_null(l_xrda.xrdadocno) THEN 
              LET  r_success=FALSE   
              RETURN r_success 
           END IF                            
           
           LET l_doc_success = TRUE
           
           CALL s_axrt400_conf_chk(l_xrda.xrdald,l_xrda.xrdadocno) RETURNING l_doc_success,l_flag
           
           IF NOT l_doc_success THEN
              LET r_success = FALSE
           ELSE 
              IF NOT s_axrt400_conf_upd(l_xrda.xrdald,l_xrda.xrdadocno) THEN
                 LET r_success = FALSE
              END IF
           END IF
           
           #異動狀態碼欄位/修改人/修改日期
           LET l_xrdamoddt = cl_get_current()
           UPDATE xrda_t SET xrdastus = 'Y',
                             xrdamodid= g_user,
                             xrdamoddt= l_xrdamoddt
            WHERE xrdaent = g_enterprise AND xrdald = l_xrda.xrdald
              AND xrdadocno = l_xrda.xrdadocno
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL 
              LET g_errparam.extend = "" 
              LET g_errparam.code   = SQLCA.sqlcode 
              LET g_errparam.popup  = FALSE 
              CALL cl_err()
              LET l_doc_success = FALSE
           END IF
           
           IF l_flag = 'S' OR l_doc_success=FALSE THEN
              LET r_success = FALSE 
           END IF 
   END FOREACH 
   
   IF r_success THEN 
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF 
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 直接抛转总账传票功能
# Memo...........:
# input..........: p_slip  默认总账单据别
# Usage..........: axrp400_immediately_gen()
# Date & Author..: 2015/12/07 By 06862
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp400_immediately_gen(p_start_no,p_end_no,p_slip)
   DEFINE p_slip            LIKE type_t.chr20
   DEFINE p_start_no        LIKE xrda_t.xrdadocno
   DEFINE p_end_no          LIKE xrda_t.xrdadocno 
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0032        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_glap001         LIKE glap_t.glap001
   DEFINE l_glaa121         LIKE glaa_t.glaa121
   DEFINE l_xrdastus        LIKE xrda_t.xrdastus
   DEFINE l_xrdamoddt       LIKE xrda_t.xrdamoddt
   DEFINE r_success         LIKE type_t.num5
   DEFINE r_start_no        LIKE glap_t.glapdocno
   DEFINE r_end_no          LIKE glap_t.glapdocno
   DEFINE l_wc              STRING 
   DEFINE l_sql             STRING  
  #DEFINE l_xrda            RECORD LIKE xrda_t.*#161219-00014#2
   #161219-00014#2--add--s--
   DEFINE l_xrda RECORD  #收款核銷單單頭檔
       xrdaent LIKE xrda_t.xrdaent, #企业编号
       xrdacomp LIKE xrda_t.xrdacomp, #所属法人
       xrdald LIKE xrda_t.xrdald, #账套别
       xrdadocno LIKE xrda_t.xrdadocno, #冲账单号
       xrdadocdt LIKE xrda_t.xrdadocdt, #冲账日期
       xrdasite LIKE xrda_t.xrdasite, #账务组织
       xrda001 LIKE xrda_t.xrda001, #账款单性质
       xrda003 LIKE xrda_t.xrda003, #账务人员
       xrda004 LIKE xrda_t.xrda004, #账款核销客户
       xrda005 LIKE xrda_t.xrda005, #收款客户
       xrda006 LIKE xrda_t.xrda006, #一次性对象识别码
       xrda007 LIKE xrda_t.xrda007, #生成方式
       xrda008 LIKE xrda_t.xrda008, #来源参考单号
       xrda009 LIKE xrda_t.xrda009, #冲账批序号
       xrda010 LIKE xrda_t.xrda010, #集团代收付单号
       xrda011 LIKE xrda_t.xrda011, #差异处理
       xrda012 LIKE xrda_t.xrda012, #退款类型
       xrda013 LIKE xrda_t.xrda013, #分录底稿是否可重新生成
       xrda014 LIKE xrda_t.xrda014, #抛转凭证号码
       xrda015 LIKE xrda_t.xrda015, #作废理由码
       xrda016 LIKE xrda_t.xrda016, #打印次数
       xrda017 LIKE xrda_t.xrda017, #MEMO备注
       xrdastus LIKE xrda_t.xrdastus, #审核否
       xrdaownid LIKE xrda_t.xrdaownid, #资料所有者
       xrdaowndp LIKE xrda_t.xrdaowndp, #资料所有部门
       xrdacrtid LIKE xrda_t.xrdacrtid, #资料录入者
       xrdacrtdp LIKE xrda_t.xrdacrtdp, #资料录入部门
       xrdacrtdt LIKE xrda_t.xrdacrtdt, #资料创建日
       xrdamodid LIKE xrda_t.xrdamodid, #资料更改者
       xrdamoddt LIKE xrda_t.xrdamoddt, #最近更改日
       xrdaud001 LIKE xrda_t.xrdaud001, #自定义字段(文本)001
       xrdaud002 LIKE xrda_t.xrdaud002, #自定义字段(文本)002
       xrdaud003 LIKE xrda_t.xrdaud003, #自定义字段(文本)003
       xrdaud004 LIKE xrda_t.xrdaud004, #自定义字段(文本)004
       xrdaud005 LIKE xrda_t.xrdaud005, #自定义字段(文本)005
       xrdaud006 LIKE xrda_t.xrdaud006, #自定义字段(文本)006
       xrdaud007 LIKE xrda_t.xrdaud007, #自定义字段(文本)007
       xrdaud008 LIKE xrda_t.xrdaud008, #自定义字段(文本)008
       xrdaud009 LIKE xrda_t.xrdaud009, #自定义字段(文本)009
       xrdaud010 LIKE xrda_t.xrdaud010, #自定义字段(文本)010
       xrdaud011 LIKE xrda_t.xrdaud011, #自定义字段(数字)011
       xrdaud012 LIKE xrda_t.xrdaud012, #自定义字段(数字)012
       xrdaud013 LIKE xrda_t.xrdaud013, #自定义字段(数字)013
       xrdaud014 LIKE xrda_t.xrdaud014, #自定义字段(数字)014
       xrdaud015 LIKE xrda_t.xrdaud015, #自定义字段(数字)015
       xrdaud016 LIKE xrda_t.xrdaud016, #自定义字段(数字)016
       xrdaud017 LIKE xrda_t.xrdaud017, #自定义字段(数字)017
       xrdaud018 LIKE xrda_t.xrdaud018, #自定义字段(数字)018
       xrdaud019 LIKE xrda_t.xrdaud019, #自定义字段(数字)019
       xrdaud020 LIKE xrda_t.xrdaud020, #自定义字段(数字)020
       xrdaud021 LIKE xrda_t.xrdaud021, #自定义字段(日期时间)021
       xrdaud022 LIKE xrda_t.xrdaud022, #自定义字段(日期时间)022
       xrdaud023 LIKE xrda_t.xrdaud023, #自定义字段(日期时间)023
       xrdaud024 LIKE xrda_t.xrdaud024, #自定义字段(日期时间)024
       xrdaud025 LIKE xrda_t.xrdaud025, #自定义字段(日期时间)025
       xrdaud026 LIKE xrda_t.xrdaud026, #自定义字段(日期时间)026
       xrdaud027 LIKE xrda_t.xrdaud027, #自定义字段(日期时间)027
       xrdaud028 LIKE xrda_t.xrdaud028, #自定义字段(日期时间)028
       xrdaud029 LIKE xrda_t.xrdaud029, #自定义字段(日期时间)029
       xrdaud030 LIKE xrda_t.xrdaud030, #自定义字段(日期时间)030
       xrda103 LIKE xrda_t.xrda103, #原币借方金额合计
       xrda104 LIKE xrda_t.xrda104, #原币贷方金额合计
       xrda113 LIKE xrda_t.xrda113, #本币借方金额合计
       xrda114 LIKE xrda_t.xrda114, #本币贷方金额合计
       xrda123 LIKE xrda_t.xrda123, #本位币二借方金额合计
       xrda124 LIKE xrda_t.xrda124, #本位币二贷方金额合计
       xrda133 LIKE xrda_t.xrda133, #本位币三借方金额合计
       xrda134 LIKE xrda_t.xrda134, #本位币三贷方金额合计
       xrdacnfid LIKE xrda_t.xrdacnfid, #资料确认者
       xrdacnfdt LIKE xrda_t.xrdacnfdt, #数据审核日
       xrdapstid LIKE xrda_t.xrdapstid, #资料过账者
       xrdapstdt LIKE xrda_t.xrdapstdt, #资料过账日
       xrda018 LIKE xrda_t.xrda018 #来源类型(流通)
       END RECORD
   #161219-00014#2--add--e--  
     
   LET r_success = TRUE 
   #161219-00014#2--mark--s--
#  LET l_sql = "SELECT * FROM xrda_t where xrdaent = '",g_enterprise,"' 
#                          and xrdadocno between '",p_start_no,"' and '",p_end_no,"'
#                          AND xrdald = '",g_master.xrdald,"' "
   #161219-00014#2--mark--e--
   #161219-00014#2--add--s--
   LET l_sql = "SELECT xrdaent,xrdacomp,xrdald,xrdadocno,xrdadocdt,xrdasite,xrda001,xrda003,xrda004,xrda005,xrda006,xrda007,xrda008,xrda009,xrda010,",
               " xrda011,xrda012,xrda013,xrda014,xrda015,xrda016,xrda017,xrdastus,xrdaownid,xrdaowndp,xrdacrtid,xrdacrtdp,xrdacrtdt,xrdamodid,xrdamoddt,",
               " xrdaud001,xrdaud002,xrdaud003,xrdaud004,xrdaud005,xrdaud006,xrdaud007,xrdaud008,xrdaud009,xrdaud010,xrdaud011,xrdaud012,xrdaud013,xrdaud014,",
               " xrdaud015,xrdaud016,xrdaud017,xrdaud018,xrdaud019,xrdaud020,xrdaud021,xrdaud022,xrdaud023,xrdaud024,xrdaud025,xrdaud026,xrdaud027,xrdaud028,",
               " xrdaud029,xrdaud030,xrda103,xrda104,xrda113,xrda114,xrda123,xrda124,xrda133,xrda134,xrdacnfid,xrdacnfdt,xrdapstid,xrdapstdt,xrda018 ",
               "  FROM xrda_t where xrdaent = '",g_enterprise,"' ",
               "   and xrdadocno between '",p_start_no,"' and '",p_end_no,"'",
               "   AND xrdald = '",g_master.xrdald,"' "
   #161219-00014#2--add--e--                           
   PREPARE axrp400_immediately_gen_pre FROM l_sql
   DECLARE axrp400_immediately_gen_cs CURSOR FOR axrp400_immediately_gen_pre
   
   CALL s_transaction_begin()
   FOREACH axrp400_immediately_gen_cs INTO l_xrda.*
  
           IF cl_null(l_xrda.xrdald)    THEN RETURN END IF   #無資料直接返回不做處理
           IF cl_null(l_xrda.xrdadocno) THEN RETURN END IF   #無資料直接返回不做處理
           IF NOT cl_null(l_xrda.xrda014)   THEN RETURN END IF   #無傳票單號不做處理
           IF l_xrda.xrdastus <> 'Y' THEN RETURN END IF 
           
           #是否产生分录底稿
           SELECT glaa121 INTO l_glaa121
             FROM glaa_t
            WHERE glaaent = g_enterprise
              AND glaald = l_xrda.xrdald
           
           IF l_glaa121 = 'Y' THEN 
              LET l_wc =" glgbdocno = '", l_xrda.xrdadocno,"' "
              CALL s_pre_voucher_ins_glap('AR','R20',g_master.xrdald,g_master.xrdadocdt,p_slip,1,l_wc) 
                   RETURNING l_success,r_start_no,r_end_no
           ELSE
              LET l_wc =" xrdadocno IN (SELECT xrdadocno FROM axrp420_tmp WHERE sel = 'Y')"   
              CALL s_voucher_gen_ar('2',g_master.xrdald,g_master.xrdadocdt,p_slip,1,l_wc,'N') 
                   RETURNING l_success,r_start_no,r_end_no
           END IF
           
           IF NOT l_success THEN 
              LET r_success = FALSE 
           END IF 
           
           #更新传票单号
           LET l_xrdamoddt = cl_get_current()
           UPDATE xrda_t SET xrda014 = r_start_no,
                             xrdamodid= g_user,
                             xrdamoddt= l_xrdamoddt
                       WHERE xrdaent = g_enterprise
                         AND xrdadocno = l_xrda.xrdadocno                 
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL 
              LET g_errparam.extend = "" 
              LET g_errparam.code   = SQLCA.sqlcode 
              LET g_errparam.popup  = FALSE 
              CALL cl_err()
              LET r_success = FALSE
           END IF
           
   END FOREACH 
   
   IF r_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      IF cl_null(r_start_no) THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'axc-00530' 
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'axr-00120' 
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      CALL s_transaction_end('N','0')    
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 取得第一单身收款对象
# Memo...........:
# Usage..........: CALL axrp400_get_nmbb026()
#                  RETURNING r_wc
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........: #161114-00028#1 Add
################################################################################
PRIVATE FUNCTION axrp400_get_nmbb026()
   DEFINE r_wc         STRING
   DEFINE l_i          LIKE type_t.num10

   LET r_wc = ''
   FOR l_i = 1 TO g_detail_d.getlength()
      IF g_detail_d[l_i].sel = 'N' THEN CONTINUE FOR END IF
      IF cl_null(r_wc) THEN
         LET r_wc = "'",g_detail_d[l_i].nmbb026,"'"
      ELSE
         LET r_wc = r_wc,",'",g_detail_d[l_i].nmbb026,"'"
      END IF
   END FOR
   IF cl_null(r_wc) THEN
      LET r_wc = " 1=1"
   ELSE
      LET r_wc = " xrca005 IN (",r_wc,")"
   END IF

   RETURN r_wc

END FUNCTION

#end add-point
 
{</section>}
 
