#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp620.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2016-06-27 17:40:31), PR版次:0009(2017-02-20 10:20:25)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000064
#+ Filename...: apmp620
#+ Description: 訂單轉採購批次作業
#+ Creator....: 01534(2015-04-13 18:01:53)
#+ Modifier...: 06814 -SD/PR- 01996
 
{</section>}
 
{<section id="apmp620.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160413-00011#1  2016/04/15 By xianghui 效能优化
#160318-00025#50 2016/04/26 By 07673 將重複內容的錯誤訊息置換為公用錯誤訊息
#160825-00018#1  2016/09/10 By catmoon 存舊新值的陣列未清空，導致畫面顯示錯誤
#161124-00048#8  2016/12/19 By zhujing  .*整批调整
#161207-00033#21 2016/12/20 By lixh     一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
#161221-00064#10 2017/01/10 By zhujing  增加pmao000(1-采购，2-销售),用于区分axmi120和apmi120数据显示
#160711-00040#24 2017/02/20 By xujing   T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                          CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
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
        sel                 LIKE type_t.chr1,
        xmdadocno           LIKE xmda_t.xmdadocno,             
        xmddseq             LIKE xmdd_t.xmddseq,
        xmddseq1            LIKE xmdd_t.xmddseq1,
        xmddseq2            LIKE xmdd_t.xmddseq2,        
        xmda004             LIKE xmda_t.xmda004,
        xmda004_desc        LIKE type_t.chr80,
        xmda002             LIKE xmda_t.xmda002,
        xmda002_desc        LIKE type_t.chr80,
        xmdadocdt           LIKE xmda_t.xmdadocdt,
        xmdd011             LIKE xmdd_t.xmdd011,
        xmdc001             LIKE xmdc_t.xmdc001,
        xmdc001_desc        LIKE type_t.chr80,
        xmdc001_desc_desc   LIKE type_t.chr80,
        xmdc002             LIKE xmdc_t.xmdc002,
        xmdc002_desc        LIKE type_t.chr80,
        xmdc006             LIKE xmdc_t.xmdc006,
        xmdc006_desc        LIKE type_t.chr80,
        xmdc007             LIKE xmdc_t.xmdc007,
        num                 LIKE xmdc_t.xmdc007,
        pmdb006             LIKE pmdb_t.pmdb006,
        pmdl004             LIKE pmdl_t.pmdl004,
        pmdl004_desc        LIKE type_t.chr80,
        xmda017             LIKE xmda_t.xmda017,
        xmda017_desc        LIKE type_t.chr80,
        xmda015             LIKE xmda_t.xmda015,
        xmda015_desc        LIKE type_t.chr80,
        xmda016             LIKE xmda_t.xmda016,
        xmda011             LIKE xmda_t.xmda011,
        xmda011_desc        LIKE type_t.chr80,
        xmda012             LIKE xmda_t.xmda012,
        xmda013             LIKE xmda_t.xmda013,
        pmal002             LIKE pmal_t.pmal002
                     END RECORD
DEFINE  g_pmdldocno         LIKE pmdl_t.pmdldocno
DEFINE  g_s_pmdldocno       LIKE pmdl_t.pmdldocno
DEFINE  g_pmdldocno_t       LIKE pmdl_t.pmdldocno
DEFINE  g_pmdldocno_desc    LIKE type_t.chr80
DEFINE  g_type              LIKE type_t.chr10
DEFINE  g_price             LIKE type_t.chr10
DEFINE  l_ooef004           LIKE ooef_t.ooef004
DEFINE  g_rec_b             LIKE type_t.num10 
DEFINE  g_flag              LIKE type_t.chr1   #單頭產生否
DEFINE  g_status            LIKE type_t.num5
DEFINE  g_ooef019           LIKE ooef_t.ooef019
DEFINE  g_detail_d_t        type_g_detail_d
DEFINE  l_xmdd              type_g_detail_d
DEFINE   l_pmdl004_t     LIKE pmdl_t.pmdl004
DEFINE   l_xmdadocno_t   LIKE xmda_t.xmdadocno
DEFINE   l_xmda004_t     LIKE xmda_t.xmda004
DEFINE   l_xmdc001_t       LIKE xmdc_t.xmdc001
#161124-00048#8 mod-S
#DEFINE   l_pmdn            RECORD LIKE pmdn_t.*
DEFINE l_pmdn RECORD  #採購單身明細檔
       pmdnent LIKE pmdn_t.pmdnent, #企业编号
       pmdnsite LIKE pmdn_t.pmdnsite, #营运据点
       pmdnunit LIKE pmdn_t.pmdnunit, #应用组织
       pmdndocno LIKE pmdn_t.pmdndocno, #采购单号
       pmdnseq LIKE pmdn_t.pmdnseq, #项次
       pmdn001 LIKE pmdn_t.pmdn001, #料件编号
       pmdn002 LIKE pmdn_t.pmdn002, #产品特征
       pmdn003 LIKE pmdn_t.pmdn003, #包装容器
       pmdn004 LIKE pmdn_t.pmdn004, #作业编号
       pmdn005 LIKE pmdn_t.pmdn005, #作业序
       pmdn006 LIKE pmdn_t.pmdn006, #采购单位
       pmdn007 LIKE pmdn_t.pmdn007, #采购数量
       pmdn008 LIKE pmdn_t.pmdn008, #参考单位
       pmdn009 LIKE pmdn_t.pmdn009, #参考数量
       pmdn010 LIKE pmdn_t.pmdn010, #计价单位
       pmdn011 LIKE pmdn_t.pmdn011, #计价数量
       pmdn012 LIKE pmdn_t.pmdn012, #出货日期
       pmdn013 LIKE pmdn_t.pmdn013, #到厂日期
       pmdn014 LIKE pmdn_t.pmdn014, #到库日期
       pmdn015 LIKE pmdn_t.pmdn015, #单价
       pmdn016 LIKE pmdn_t.pmdn016, #税种
       pmdn017 LIKE pmdn_t.pmdn017, #税率
       pmdn019 LIKE pmdn_t.pmdn019, #子件特性
       pmdn020 LIKE pmdn_t.pmdn020, #紧急度
       pmdn021 LIKE pmdn_t.pmdn021, #保税
       pmdn022 LIKE pmdn_t.pmdn022, #部分交货
       pmdnorga LIKE pmdn_t.pmdnorga, #付款据点
       pmdn023 LIKE pmdn_t.pmdn023, #送货供应商
       pmdn024 LIKE pmdn_t.pmdn024, #多交期
       pmdn025 LIKE pmdn_t.pmdn025, #收货地址编号
       pmdn026 LIKE pmdn_t.pmdn026, #账款地址编号
       pmdn027 LIKE pmdn_t.pmdn027, #供应商料号
       pmdn028 LIKE pmdn_t.pmdn028, #收货库位
       pmdn029 LIKE pmdn_t.pmdn029, #收货储位
       pmdn030 LIKE pmdn_t.pmdn030, #收货批号
       pmdn031 LIKE pmdn_t.pmdn031, #运输方式
       pmdn032 LIKE pmdn_t.pmdn032, #取货模式
       pmdn033 LIKE pmdn_t.pmdn033, #备品率
       pmdn034 LIKE pmdn_t.pmdn034, #no use
       pmdn035 LIKE pmdn_t.pmdn035, #价格核决
       pmdn036 LIKE pmdn_t.pmdn036, #项目编号
       pmdn037 LIKE pmdn_t.pmdn037, #WBS编号
       pmdn038 LIKE pmdn_t.pmdn038, #活动编号
       pmdn039 LIKE pmdn_t.pmdn039, #费用原因
       pmdn040 LIKE pmdn_t.pmdn040, #取价来源
       pmdn041 LIKE pmdn_t.pmdn041, #价格参考单号
       pmdn042 LIKE pmdn_t.pmdn042, #价格参考项次
       pmdn043 LIKE pmdn_t.pmdn043, #取出价格
       pmdn044 LIKE pmdn_t.pmdn044, #价差比
       pmdn045 LIKE pmdn_t.pmdn045, #行状态
       pmdn046 LIKE pmdn_t.pmdn046, #税前金额
       pmdn047 LIKE pmdn_t.pmdn047, #含税金额
       pmdn048 LIKE pmdn_t.pmdn048, #税额
       pmdn049 LIKE pmdn_t.pmdn049, #理由码
       pmdn050 LIKE pmdn_t.pmdn050, #备注
       pmdn051 LIKE pmdn_t.pmdn051, #留置/结案理由码
       pmdn052 LIKE pmdn_t.pmdn052, #检验否
       pmdn053 LIKE pmdn_t.pmdn053, #库存管理特征
       pmdn200 LIKE pmdn_t.pmdn200, #商品条码
       pmdn201 LIKE pmdn_t.pmdn201, #包装单位
       pmdn202 LIKE pmdn_t.pmdn202, #包装数量
       pmdn203 LIKE pmdn_t.pmdn203, #收货部门
       pmdn204 LIKE pmdn_t.pmdn204, #No Use
       pmdn205 LIKE pmdn_t.pmdn205, #要货组织
       pmdn206 LIKE pmdn_t.pmdn206, #库存量
       pmdn207 LIKE pmdn_t.pmdn207, #采购在途量
       pmdn208 LIKE pmdn_t.pmdn208, #前日销售量
       pmdn209 LIKE pmdn_t.pmdn209, #上月销量
       pmdn210 LIKE pmdn_t.pmdn210, #第一周销量
       pmdn211 LIKE pmdn_t.pmdn211, #第二周销量
       pmdn212 LIKE pmdn_t.pmdn212, #第三周销量
       pmdn213 LIKE pmdn_t.pmdn213, #第四周销量
       pmdn214 LIKE pmdn_t.pmdn214, #采购渠道
       pmdn215 LIKE pmdn_t.pmdn215, #渠道性质
       pmdn216 LIKE pmdn_t.pmdn216, #经营方式
       pmdn217 LIKE pmdn_t.pmdn217, #结算方式
       pmdn218 LIKE pmdn_t.pmdn218, #合同编号
       pmdn219 LIKE pmdn_t.pmdn219, #协议编号
       pmdn220 LIKE pmdn_t.pmdn220, #采购人员
       pmdn221 LIKE pmdn_t.pmdn221, #采购部门
       pmdn222 LIKE pmdn_t.pmdn222, #采购中心
       pmdn223 LIKE pmdn_t.pmdn223, #配送中心
       pmdn224 LIKE pmdn_t.pmdn224, #采购失效日
       pmdn900 LIKE pmdn_t.pmdn900, #保留字段str
       pmdn999 LIKE pmdn_t.pmdn999, #保留字段end
       pmdn225 LIKE pmdn_t.pmdn225, #最终收货组织
       pmdn054 LIKE pmdn_t.pmdn054, #还料数量
       pmdn055 LIKE pmdn_t.pmdn055, #还量参考数量
       pmdn056 LIKE pmdn_t.pmdn056, #还价数量
       pmdn057 LIKE pmdn_t.pmdn057, #还价参考数量
       pmdn226 LIKE pmdn_t.pmdn226, #长效期每次送货量
       pmdn227 LIKE pmdn_t.pmdn227, #补货规格说明
       pmdn058 LIKE pmdn_t.pmdn058, #预算科目
       pmdn228 LIKE pmdn_t.pmdn228  #商品品类
END RECORD
#161124-00048#8 mod-E
DEFINE   g_tax_app         LIKE oodb_t.oodb011
DEFINE   g_flag1           LIKE type_t.chr1     #單身產生否
DEFINE   g_flag2           LIKE type_t.chr1     #
DEFINE   g_s_pmdnseq       LIKE pmdn_t.pmdnseq  #add by lixh 20150610
#161124-00048#8 mod-S
#DEFINE   l_pmdl            RECORD LIKE pmdl_t.*
DEFINE l_pmdl RECORD  #採購單頭檔
       pmdlent LIKE pmdl_t.pmdlent, #企业编号
       pmdlsite LIKE pmdl_t.pmdlsite, #营运据点
       pmdlunit LIKE pmdl_t.pmdlunit, #应用组织
       pmdldocno LIKE pmdl_t.pmdldocno, #采购单号
       pmdldocdt LIKE pmdl_t.pmdldocdt, #采购日期
       pmdl001 LIKE pmdl_t.pmdl001, #版次
       pmdl002 LIKE pmdl_t.pmdl002, #采购人员
       pmdl003 LIKE pmdl_t.pmdl003, #采购部门
       pmdl004 LIKE pmdl_t.pmdl004, #供应商编号
       pmdl005 LIKE pmdl_t.pmdl005, #采购性质
       pmdl006 LIKE pmdl_t.pmdl006, #多角性质
       pmdl007 LIKE pmdl_t.pmdl007, #数据源类型
       pmdl008 LIKE pmdl_t.pmdl008, #来源单号
       pmdl009 LIKE pmdl_t.pmdl009, #付款条件
       pmdl010 LIKE pmdl_t.pmdl010, #交易条件
       pmdl011 LIKE pmdl_t.pmdl011, #税种
       pmdl012 LIKE pmdl_t.pmdl012, #税率
       pmdl013 LIKE pmdl_t.pmdl013, #单价含税否
       pmdl015 LIKE pmdl_t.pmdl015, #币种
       pmdl016 LIKE pmdl_t.pmdl016, #汇率
       pmdl017 LIKE pmdl_t.pmdl017, #取价方式
       pmdl018 LIKE pmdl_t.pmdl018, #付款优惠条件
       pmdl019 LIKE pmdl_t.pmdl019, #纳入APS计算
       pmdl020 LIKE pmdl_t.pmdl020, #运送方式
       pmdl021 LIKE pmdl_t.pmdl021, #付款供应商
       pmdl022 LIKE pmdl_t.pmdl022, #送货供应商
       pmdl023 LIKE pmdl_t.pmdl023, #采购分类一
       pmdl024 LIKE pmdl_t.pmdl024, #采购分类二
       pmdl025 LIKE pmdl_t.pmdl025, #送货地址
       pmdl026 LIKE pmdl_t.pmdl026, #账款地址
       pmdl027 LIKE pmdl_t.pmdl027, #供应商连络人
       pmdl028 LIKE pmdl_t.pmdl028, #一次性交易对象识别码
       pmdl029 LIKE pmdl_t.pmdl029, #收货部门
       pmdl030 LIKE pmdl_t.pmdl030, #多角贸易已抛转
       pmdl031 LIKE pmdl_t.pmdl031, #多角序号
       pmdl032 LIKE pmdl_t.pmdl032, #最终客户
       pmdl033 LIKE pmdl_t.pmdl033, #发票类型
       pmdl040 LIKE pmdl_t.pmdl040, #采购总税前金额
       pmdl041 LIKE pmdl_t.pmdl041, #采购总含税金额
       pmdl042 LIKE pmdl_t.pmdl042, #采购总税额
       pmdl043 LIKE pmdl_t.pmdl043, #留置原因
       pmdl044 LIKE pmdl_t.pmdl044, #备注
       pmdl046 LIKE pmdl_t.pmdl046, #预付款发票开立方式
       pmdl047 LIKE pmdl_t.pmdl047, #物流结案
       pmdl048 LIKE pmdl_t.pmdl048, #账流结案
       pmdl049 LIKE pmdl_t.pmdl049, #金流结案
       pmdl050 LIKE pmdl_t.pmdl050, #多角最终站否
       pmdl051 LIKE pmdl_t.pmdl051, #多角流程编号
       pmdl052 LIKE pmdl_t.pmdl052, #最终供应商
       pmdl053 LIKE pmdl_t.pmdl053, #两角目的据点
       pmdl054 LIKE pmdl_t.pmdl054, #内外购
       pmdl055 LIKE pmdl_t.pmdl055, #汇率计算基准
       pmdl200 LIKE pmdl_t.pmdl200, #采购中心
       pmdl201 LIKE pmdl_t.pmdl201, #联络电话
       pmdl202 LIKE pmdl_t.pmdl202, #传真号码
       pmdl203 LIKE pmdl_t.pmdl203, #采购方式
       pmdl204 LIKE pmdl_t.pmdl204, #配送中心
       pmdl900 LIKE pmdl_t.pmdl900, #保留字段str
       pmdl999 LIKE pmdl_t.pmdl999, #保留字段end
       pmdlownid LIKE pmdl_t.pmdlownid, #资料所有者
       pmdlowndp LIKE pmdl_t.pmdlowndp, #资料所有部门
       pmdlcrtid LIKE pmdl_t.pmdlcrtid, #资料录入者
       pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #资料录入部门
       pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #资料创建日
       pmdlmodid LIKE pmdl_t.pmdlmodid, #资料更改者
       pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近更改日
       pmdlcnfid LIKE pmdl_t.pmdlcnfid, #资料审核者
       pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #数据审核日
       pmdlpstid LIKE pmdl_t.pmdlpstid, #资料过账者
       pmdlpstdt LIKE pmdl_t.pmdlpstdt, #资料过账日
       pmdlstus LIKE pmdl_t.pmdlstus, #状态码
       pmdl205 LIKE pmdl_t.pmdl205, #采购最终有效日
       pmdl206 LIKE pmdl_t.pmdl206, #长效期订单否
       pmdl207 LIKE pmdl_t.pmdl207, #所属品类
       pmdl208 LIKE pmdl_t.pmdl208  #电子采购单号
END RECORD
#161124-00048#8 mod-E
DEFINE   g_detail_d_old    DYNAMIC ARRAY OF type_g_detail_d   #160413-00011#1
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmp620.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp620 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmp620_init()   
 
      #進入選單 Menu (="N")
      CALL apmp620_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp620
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE apmp620_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp620.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apmp620_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   #獲得當前營運據點的所屬稅區
   LET g_ooef019 = ''
   SELECT ooef019 INTO g_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site   
   LET l_ooef004 = ''
   SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise
   CALL cl_set_combo_scc('l_type','4058') 
   LET g_type = '1' 
   DROP TABLE apmp620_tmp;
   CREATE TEMP TABLE apmp620_tmp(
        sel                 LIKE type_t.chr1,
        xmdadocno           LIKE xmda_t.xmdadocno,             
        xmddseq             LIKE xmdd_t.xmddseq,
        xmddseq1            LIKE xmdd_t.xmddseq1, 
        xmddseq2            LIKE xmdd_t.xmddseq2,        
        xmda004             LIKE xmda_t.xmda004,
        xmda004_desc        LIKE type_t.chr80,
        xmda002             LIKE xmda_t.xmda002,
        xmda002_desc        LIKE type_t.chr80,
        xmdadocdt           LIKE xmda_t.xmdadocdt,
        xmdd011             LIKE xmdd_t.xmdd011,
        xmdc001             LIKE xmdc_t.xmdc001,
        xmdc001_desc        LIKE type_t.chr80,
        xmdc001_desc_desc   LIKE type_t.chr80,
        xmdc002             LIKE xmdc_t.xmdc002,
        xmdc002_desc        LIKE type_t.chr80,
        xmdc006             LIKE xmdc_t.xmdc006,
        xmdc006_desc        LIKE type_t.chr80,
        xmdc007             LIKE xmdc_t.xmdc007,
        num                 LIKE xmdc_t.xmdc007,
        pmdb006             LIKE pmdb_t.pmdb006,
        pmdl004             LIKE pmdl_t.pmdl004,
        pmdl004_desc        LIKE type_t.chr80,
        xmda017             LIKE xmda_t.xmda017,
        xmda017_desc        LIKE type_t.chr80,
        xmda015             LIKE xmda_t.xmda015,
        xmda015_desc        LIKE type_t.chr80,
        xmda016             LIKE xmda_t.xmda016,
        xmda011             LIKE xmda_t.xmda011,
        xmda011_desc        LIKE type_t.chr80,
        xmda012             LIKE xmda_t.xmda012,
        xmda013             LIKE xmda_t.xmda013,
        pmal002             LIKE pmal_t.pmal002,
        pmdl009             LIKE pmdl_t.pmdl009,
        pmdl010             LIKE pmdl_t.pmdl010,
        pmdl020             LIKE pmdl_t.pmdl020,
        pmdl021             LIKE pmdl_t.pmdl021,
        pmdl022             LIKE pmdl_t.pmdl022,
        pmdl023             LIKE pmdl_t.pmdl023,
        pmdl024             LIKE pmdl_t.pmdl024,
        pmdl027             LIKE pmdl_t.pmdl027,
        pmdl033             LIKE pmdl_t.pmdl033,
        pmdl054             LIKE pmdl_t.pmdl054,
        pmdl055             LIKE pmdl_t.pmdl055
   );   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmp620.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp620_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_flag       LIKE type_t.num5
   DEFINE l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE l_allow_delete        LIKE type_t.num5                #可刪除否   
   DEFINE l_sql        STRING   
   DEFINE l_controlno     LIKE ooha_t.ooha001
   DEFINE l_n             LIKE type_t.num10
   DEFINE l_ooef016       LIKE ooef_t.ooef016
   DEFINE l_scc40         LIKE type_t.chr2
   DEFINE l_oodbl004      LIKE oodbl_t.oodbl004  #稅別名稱
   DEFINE l_oodb005       LIKE oodb_t.oodb005    #含稅否
   DEFINE l_oodb006       LIKE oodb_t.oodb006    #稅率 
   DEFINE l_oodb011       LIKE oodb_t.oodb011    #取得稅別類型1:正常稅率2:依料件設定   
   DEFINE l_where         STRING
   DEFINE  l_sql1          STRING     #160711-00040#24 add
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET l_allow_insert = FALSE
   LET l_allow_delete = FALSE   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apmp620_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         INPUT g_pmdldocno,g_type,g_price FROM pmdldocno,l_type,l_price
            BEFORE INPUT
               
               AFTER FIELD pmdldocno
                  IF NOT cl_null(g_pmdldocno) THEN
                     #檢核輸入的單據別是否可以被key人員對應的控制組使用,'4' 為採購控制組類型
                     CALL s_control_chk_doc('1',g_pmdldocno,'4',g_user,g_dept,'','') RETURNING l_success,l_flag
                     IF l_success THEN
                        IF NOT l_flag THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apm-00266'
                           LET g_errparam.extend = g_pmdldocno
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                 
                           LET g_pmdldocno = g_pmdldocno_t
                           CALL s_aooi200_get_slip_desc(g_pmdldocno) RETURNING g_pmdldocno_desc
                           DISPLAY BY NAME g_pmdldocno_desc
                           NEXT FIELD CURRENT
                        END IF
                     ELSE
                        LET g_pmdldocno = g_pmdldocno_t
                        CALL s_aooi200_get_slip_desc(g_pmdldocno) RETURNING g_pmdldocno_desc
                        DISPLAY BY NAME g_pmdldocno_desc
                        NEXT FIELD CURRENT
                     END IF
                     
                     IF NOT s_aooi200_chk_docno(g_site,g_pmdldocno,g_today,'apmt500') THEN
                        LET g_pmdldocno = g_pmdldocno_t
                        CALL s_aooi200_get_slip_desc(g_pmdldocno) RETURNING g_pmdldocno_desc
                        DISPLAY BY NAME g_pmdldocno_desc
                        NEXT FIELD CURRENT   
                     END IF               
                  END IF
                  
              ON ACTION controlp INFIELD pmdldocno
                 #add-point:ON ACTION controlp INFIELD pmdldocno
		     	     INITIALIZE g_qryparam.* TO NULL
                 LET g_qryparam.state = 'i'
		     	     LET g_qryparam.reqry = FALSE
          
                 LET g_qryparam.default1 = g_pmdldocno             #給予default值
          
                 #給予arg
                 LET g_qryparam.arg1 = l_ooef004
                 LET g_qryparam.arg2 = 'apmt500'
                 #160711-00040#24 add(s)
                 CALL s_control_get_docno_sql(g_user,g_dept)
                     RETURNING l_success,l_sql1
                 IF NOT cl_null(l_sql1) THEN
                    LET g_qryparam.where = l_sql1
                 END IF
                 #160711-00040#24 add(e)
                 CALL q_ooba002_1()                                #呼叫開窗
          
                 LET g_pmdldocno = g_qryparam.return1              #將開窗取得的值回傳到變數
          
                 DISPLAY g_pmdldocno TO pmdldocno              #顯示到畫面上
                 CALL s_aooi200_get_slip_desc(g_pmdldocno) RETURNING g_pmdldocno_desc
          
                 NEXT FIELD pmdldocno                          #返回原欄位
            
            AFTER INPUT
         END INPUT
         
         CONSTRUCT BY NAME g_wc ON xmdadocno,xmdadocdt,xmdd011,xmda004,xmda002,xmda003,xmda023,xmdc001,imaf111
            BEFORE CONSTRUCT
                                                      
            ON ACTION controlp INFIELD xmdadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #組合過濾前後置單據資料SQL
               CALL s_aooi210_get_check_sql(g_site,'',g_pmdldocno,'2','axmt500','xmdadocno') RETURNING l_success,l_where
               LET g_qryparam.where = l_where                
               CALL q_xmdadocno_6()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdadocno  #顯示到畫面上
               NEXT FIELD xmdadocno                     #返回原欄位
               
            ON ACTION controlp INFIELD xmda004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site
               CALL q_pmaa001_6()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmda004  #顯示到畫面上
               NEXT FIELD xmda004      

            ON ACTION controlp INFIELD xmda002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmda002  #顯示到畫面上
               NEXT FIELD xmda002      
               
            ON ACTION controlp INFIELD xmda003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmda003  #顯示到畫面上
               NEXT FIELD xmda003   
    
            ON ACTION controlp INFIELD xmda023
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #160621-00003#3 20160627 modify by beckxie---S
			      #LET g_qryparam.arg1 = "275"
               #CALL q_oocq002()                           #呼叫開窗
               LET g_qryparam.arg1 = '1'
               CALL q_oojd001_1()
               #160621-00003#3 20160627 modify by beckxie---E
               DISPLAY g_qryparam.return1 TO xmda023  #顯示到畫面上
               NEXT FIELD xmda023  
               
            ON ACTION controlp INFIELD xmdc001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaf001_15()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdc001  #顯示到畫面上
               NEXT FIELD xmdc001 

            ON ACTION controlp INFIELD imaf111
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imcd111()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaf111  #顯示到畫面上
               NEXT FIELD imaf111 

         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"

 
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                     INSERT ROW = l_allow_insert, 
                     DELETE ROW = l_allow_delete,
                     APPEND ROW = l_allow_insert)
            BEFORE INPUT
               LET l_ac = ARR_CURR()
               DISPLAY l_ac TO FORMONLY.h_index    #160413-00011#1
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               CALL FGL_SET_ARR_CURR(l_ac)
               IF l_ac = 0 THEN LET l_ac = 1 END IF               
               LET g_detail_d_t.* = g_detail_d[l_ac].*  
               CALL cl_set_comp_required("b_pmdl004",TRUE)  #add by lixh 20150602
               DISPLAY l_ac TO FORMONLY.h_index    #160413-00011#1
#            AFTER FIELD sel
            ON CHANGE sel
               IF NOT cl_null(g_detail_d[l_ac].sel) THEN
                  IF g_detail_d[l_ac].sel <> g_detail_d_t.sel OR g_detail_d_t.sel IS NULL THEN
#                     UPDATE apmp620_tmp SET sel = g_detail_d[l_ac].sel,
#                                            xmdd011 = g_detail_d[l_ac].xmdd011,
#                                            pmdb006 = g_detail_d[l_ac].pmdb006,
#                                            pmdl004 = g_detail_d[l_ac].pmdl004,
#                                            pmdl004_desc = g_detail_d[l_ac].pmdl004_desc,
#                                            xmda017 = g_detail_d[l_ac].xmda017,
#                                            xmda017_desc = g_detail_d[l_ac].xmda017_desc,
#                                            xmda015 = g_detail_d[l_ac].xmda015,
#                                            xmda015_desc = g_detail_d[l_ac].xmda015_desc,
#                                            xmda016 = g_detail_d[l_ac].xmda016,
#                                            xmda011 = g_detail_d[l_ac].xmda011,
#                                            xmda011_desc = g_detail_d[l_ac].xmda011_desc,
#                                            xmda012 = g_detail_d[l_ac].xmda012,
#                                            xmda013 = g_detail_d[l_ac].xmda013
#                                            
#                                      WHERE xmdadocno = g_detail_d[l_ac].xmdadocno
#                                        AND xmddseq = g_detail_d[l_ac].xmddseq
#                                        AND xmddseq1 = g_detail_d[l_ac].xmddseq1
#                                        AND xmddseq2 = g_detail_d[l_ac].xmddseq2 
                  END IF                    
               END IF   
               LET g_detail_d_t.sel = g_detail_d[l_ac].sel               
               
            AFTER FIELD b_pmdb006
               IF NOT cl_ap_chk_range(g_detail_d[l_ac].pmdb006,"0","0","","","azz-00079",1) THEN
                  NEXT FIELD b_pmdb006
               END IF             
               IF NOT cl_null(g_detail_d[l_ac].pmdb006) THEN
                  IF g_detail_d[l_ac].pmdb006 > g_detail_d[l_ac].num THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00878'
                     LET g_errparam.extend = g_detail_d[l_ac].pmdb006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()  
                     LET g_detail_d[l_ac].pmdb006 = g_detail_d_t.pmdb006
                     NEXT FIELD b_pmdb006                     
                  END IF    
#                  UPDATE apmp620_tmp SET sel = g_detail_d[l_ac].sel,
#                                         xmdd011 = g_detail_d[l_ac].xmdd011,
#                                         pmdb006 = g_detail_d[l_ac].pmdb006,
#                                         pmdl004 = g_detail_d[l_ac].pmdl004,
#                                         pmdl004_desc = g_detail_d[l_ac].pmdl004_desc,
#                                         xmda017 = g_detail_d[l_ac].xmda017,
#                                         xmda017_desc = g_detail_d[l_ac].xmda017_desc,
#                                         xmda015 = g_detail_d[l_ac].xmda015,
#                                         xmda015_desc = g_detail_d[l_ac].xmda015_desc,
#                                         xmda016 = g_detail_d[l_ac].xmda016,
#                                         xmda011 = g_detail_d[l_ac].xmda011,
#                                         xmda011_desc = g_detail_d[l_ac].xmda011_desc,
#                                         xmda012 = g_detail_d[l_ac].xmda012,
#                                         xmda013 = g_detail_d[l_ac].xmda013
#                                         
#                                   WHERE xmdadocno = g_detail_d[l_ac].xmdadocno
#                                     AND xmddseq = g_detail_d[l_ac].xmddseq
#                                     AND xmddseq1 = g_detail_d[l_ac].xmddseq1
#                                     AND xmddseq2 = g_detail_d[l_ac].xmddseq2                      
               END IF   
               LET g_detail_d_t.pmdb006 = g_detail_d[l_ac].pmdb006
            
            #ON CHANGE b_pmdl004  
            AFTER FIELD b_pmdl004
               CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].pmdl004)  
                    RETURNING g_detail_d[l_ac].pmdl004_desc               
               IF NOT cl_null(g_detail_d[l_ac].pmdl004) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_detail_d[l_ac].pmdl004
              
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_pmaa001_1") THEN
                     LET g_detail_d[l_ac].pmdl004 = g_detail_d_t.pmdl004
                     CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].pmdl004)  
                          RETURNING g_detail_d[l_ac].pmdl004_desc                    
                     NEXT FIELD b_pmdl004
                  END IF
                  
                  #檢核輸入的供應商是否在單據別限制範圍內，若不在限制內則不允許跟此供應商採購
                  CALL s_control_chk_doc('2',g_pmdldocno,g_detail_d[l_ac].pmdl004,'','','','') RETURNING l_success,l_flag
                  IF NOT l_success THEN      #处理状态
                     LET g_detail_d[l_ac].pmdl004 = g_detail_d_t.pmdl004
                     CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].pmdl004)  
                          RETURNING g_detail_d[l_ac].pmdl004_desc                    
                     NEXT FIELD b_pmdl004
                  ELSE
                     IF NOT l_flag THEN      #是否存在
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apm-00239'
                        LET g_errparam.extend = g_detail_d[l_ac].pmdl004
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_detail_d[l_ac].pmdl004 = g_detail_d_t.pmdl004
                        CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].pmdl004)  
                             RETURNING g_detail_d[l_ac].pmdl004_desc                          
                        NEXT FIELD b_pmdl004
                     END IF 
                  END IF  
                  CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].pmdl004)  
                       RETURNING g_detail_d[l_ac].pmdl004_desc 
                       
                  #判斷輸入的供應商編號是否在採購控制組限制的供應商範圍內，若不在限制內則不允許跟此供應商採購  
                  CALL s_control_chk_group('2','4',g_user,g_dept,g_detail_d[l_ac].pmdl004,'','','','') RETURNING l_success,l_flag
                  IF NOT l_success THEN      #处理状态
                     LET g_detail_d[l_ac].pmdl004 = g_detail_d_t.pmdl004
                     CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].pmdl004)  
                          RETURNING g_detail_d[l_ac].pmdl004_desc                    
                     NEXT FIELD b_pmdl004
                  ELSE
                     IF NOT l_flag THEN      #是否存在
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apm-00268'
                        LET g_errparam.extend = g_detail_d[l_ac].pmdl004
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_detail_d[l_ac].pmdl004 = g_detail_d_t.pmdl004
                        CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].pmdl004)  
                             RETURNING g_detail_d[l_ac].pmdl004_desc                
                        NEXT FIELD b_pmdl004
                     END IF 
                     #add by lixh 20150427
                     #先判斷這個供應商是否有設多個當前採購控制組範圍內的供應商預設條件，則開窗，讓user 選擇帶哪一個控制組的資料
                     LET l_controlno = ''
                     CALL s_control_get_group('4',g_user,g_dept) RETURNING l_success,l_controlno
                     
                     IF NOT cl_null(l_controlno) THEN
                        #判斷供應商是否有設置採購控制組供應商預設條件(apmi110)，若有則抓取相關的預設條件default到採購單上
                        SELECT COUNT(*) INTO l_n FROM pmal_t WHERE pmalent = g_enterprise AND pmal001 = g_detail_d[l_ac].pmdl004 AND pmal002 = l_controlno AND pmalstus = 'Y'
                        IF l_n > 0  AND (g_detail_d_t.pmdl004 <> g_detail_d[l_ac].pmdl004 OR g_detail_d_t.pmdl004 IS NULL) THEN
                           SELECT pmal004,pmal003,pmal021
                             INTO g_detail_d[l_ac].xmda011,g_detail_d[l_ac].xmda015,g_detail_d[l_ac].xmda017                
                           FROM pmal_t WHERE pmalent = g_enterprise AND pmal001 = g_detail_d[l_ac].pmdl004 AND pmal002 = l_controlno AND pmalstus = 'Y'
                        END IF
                     END IF
                     
                     #若沒有設置採購控制組供應商預設條件資料則改抓供應商據點預設條件(apmm202)資料  
                     IF cl_null(l_controlno) OR l_n = 0  AND (g_detail_d_t.pmdl004 <> g_detail_d[l_ac].pmdl004 OR g_detail_d_t.pmdl004 IS NULL) THEN
                        SELECT pmab034,pmab033,pmab054
                          INTO g_detail_d[l_ac].xmda011,g_detail_d[l_ac].xmda015,g_detail_d[l_ac].xmda017
                          FROM pmab_t WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = g_detail_d[l_ac].pmdl004           
                     END IF
                     #取稅率、單價含稅否
                     IF NOT cl_null(g_detail_d[l_ac].xmda011) THEN
                        LET l_oodb005 = ''
                        LET l_oodb006 = ''
                        LET l_oodb011 = ''
                        CALL s_tax_chk(g_site,g_detail_d[l_ac].xmda011)
                          RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
                          
                        IF l_success THEN
                           LET g_tax_app = l_oodb011
                           LET g_detail_d[l_ac].xmda012 = l_oodb006
                           LET g_detail_d[l_ac].xmda013 = l_oodb005
                           LET g_detail_d[l_ac].xmda011_desc = l_oodbl004
                        END IF           
                     END IF
                     
                     #取匯率
                     IF NOT cl_null(g_detail_d[l_ac].xmda015) THEN
                        #根據內外購獲取當前營運據點參數設置的汇率类型
                        LET l_scc40 = ''
                    
                        LET l_scc40 = cl_get_para(g_enterprise,g_site,'S-BAS-0014')
                    
                        LET l_ooef016 = ''
                        SELECT ooef016 INTO l_ooef016 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
                        IF NOT cl_null(l_scc40) THEN
                           CALL s_aooi160_get_exrate('1',g_site,g_today,g_detail_d[l_ac].xmda015,l_ooef016,0,l_scc40) RETURNING g_detail_d[l_ac].xmda016
                        END IF
                     END IF    
#                     UPDATE apmp620_tmp SET sel = g_detail_d[l_ac].sel,
#                                            xmdd011 = g_detail_d[l_ac].xmdd011,
#                                            pmdb006 = g_detail_d[l_ac].pmdb006,
#                                            pmdl004 = g_detail_d[l_ac].pmdl004,
#                                            pmdl004_desc = g_detail_d[l_ac].pmdl004_desc,
#                                            xmda017 = g_detail_d[l_ac].xmda017,
#                                            xmda017_desc = g_detail_d[l_ac].xmda017_desc,
#                                            xmda015 = g_detail_d[l_ac].xmda015,
#                                            xmda015_desc = g_detail_d[l_ac].xmda015_desc,
#                                            xmda016 = g_detail_d[l_ac].xmda016,
#                                            xmda011 = g_detail_d[l_ac].xmda011,
#                                            xmda011_desc = g_detail_d[l_ac].xmda011_desc,
#                                            xmda012 = g_detail_d[l_ac].xmda012,
#                                            xmda013 = g_detail_d[l_ac].xmda013
#                                            
#                                      WHERE xmdadocno = g_detail_d[l_ac].xmdadocno
#                                        AND xmddseq = g_detail_d[l_ac].xmddseq
#                                        AND xmddseq1 = g_detail_d[l_ac].xmddseq1
#                                        AND xmddseq2 = g_detail_d[l_ac].xmddseq2                      
                  #add by lixh 20150427
                  END IF
                  
#                  #檢核輸入的供應商是否在單據別限制範圍內，若不在限制內則不允許跟此供應商採購
#                  CALL s_control_chk_doc('2',g_pmdldocno,g_detail_d[l_ac].pmdl004,'','','','') RETURNING l_success,l_flag
#                  IF NOT l_success THEN      #处理状态
#                     LET g_detail_d[l_ac].pmdl004 = g_detail_d_t.pmdl004
#                     CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].pmdl004)  
#                          RETURNING g_detail_d[l_ac].pmdl004_desc                    
#                     NEXT FIELD b_pmdl004
#                  ELSE
#                     IF NOT l_flag THEN      #是否存在
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = 'apm-00239'
#                        LET g_errparam.extend = g_detail_d[l_ac].pmdl004
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#                        LET g_detail_d[l_ac].pmdl004 = g_detail_d_t.pmdl004
#                        CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].pmdl004)  
#                             RETURNING g_detail_d[l_ac].pmdl004_desc                          
#                        NEXT FIELD b_pmdl004
#                     END IF 
#                  END IF  
#                  CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].pmdl004)  
#                       RETURNING g_detail_d[l_ac].pmdl004_desc 
               ELSE
                  LET g_detail_d[l_ac].pmdl004_desc = ''             
               END IF
               LET g_detail_d_t.pmdl004 = g_detail_d[l_ac].pmdl004               

               AFTER FIELD b_xmda017
                  CALL s_desc_get_price_type_desc(g_detail_d[l_ac].xmda017) RETURNING g_detail_d[l_ac].xmda017_desc
                  IF NOT cl_null(g_detail_d[l_ac].xmda017) THEN
                     INITIALIZE g_chkparam.* TO NULL
                     
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_detail_d[l_ac].xmda017
                     LET g_errshow = TRUE   #160318-00025#50
                     LET g_chkparam.err_str[1] = "apm-00210:sub-01302|apmi130|",cl_get_progname("apmi130",g_lang,"2"),"|:EXEPROGapmi130"    #160318-00025#50    
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_pmam001") THEN 
                     ELSE
                        LET g_detail_d[l_ac].xmda017 = g_detail_d_t.xmda017 
                        CALL s_desc_get_price_type_desc(g_detail_d[l_ac].xmda017) RETURNING g_detail_d[l_ac].xmda017_desc
                        NEXT FIELD b_xmda017
                     END IF   
#                     UPDATE apmp620_tmp SET sel = g_detail_d[l_ac].sel,
#                                            xmdd011 = g_detail_d[l_ac].xmdd011,
#                                            pmdb006 = g_detail_d[l_ac].pmdb006,
#                                            pmdl004 = g_detail_d[l_ac].pmdl004,
#                                            pmdl004_desc = g_detail_d[l_ac].pmdl004_desc,
#                                            xmda017 = g_detail_d[l_ac].xmda017,
#                                            xmda017_desc = g_detail_d[l_ac].xmda017_desc,
#                                            xmda015 = g_detail_d[l_ac].xmda015,
#                                            xmda015_desc = g_detail_d[l_ac].xmda015_desc,
#                                            xmda016 = g_detail_d[l_ac].xmda016,
#                                            xmda011 = g_detail_d[l_ac].xmda011,
#                                            xmda011_desc = g_detail_d[l_ac].xmda011_desc,
#                                            xmda012 = g_detail_d[l_ac].xmda012,
#                                            xmda013 = g_detail_d[l_ac].xmda013
#                                            
#                                      WHERE xmdadocno = g_detail_d[l_ac].xmdadocno
#                                        AND xmddseq = g_detail_d[l_ac].xmddseq
#                                        AND xmddseq1 = g_detail_d[l_ac].xmddseq1
#                                        AND xmddseq2 = g_detail_d[l_ac].xmddseq2                      
                  END IF
                  LET g_detail_d_t.xmda017 = g_detail_d[l_ac].xmda017 

             AFTER FIELD b_xmda015
                CALL s_desc_get_currency_desc(g_detail_d[l_ac].xmda015) RETURNING g_detail_d[l_ac].xmda015_desc
                IF NOT cl_null(g_detail_d[l_ac].xmda015) THEN
                   #根據內外購獲取當前營運據點參數設置的汇率类型
                   LET l_scc40 = ''
                   
                   LET l_scc40 = cl_get_para(g_enterprise,g_site,'S-BAS-0014')
                   
                   LET l_ooef016 = ''
                   SELECT ooef016 INTO l_ooef016 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
                   IF NOT cl_null(l_scc40) THEN
                      CALL s_aooi160_get_exrate('1',g_site,g_today,g_detail_d[l_ac].xmda015,l_ooef016,0,l_scc40) RETURNING g_detail_d[l_ac].xmda016
                   END IF  
#                   UPDATE apmp620_tmp SET sel = g_detail_d[l_ac].sel,
#                                          xmdd011 = g_detail_d[l_ac].xmdd011,
#                                          pmdb006 = g_detail_d[l_ac].pmdb006,
#                                          pmdl004 = g_detail_d[l_ac].pmdl004,
#                                          pmdl004_desc = g_detail_d[l_ac].pmdl004_desc,
#                                          xmda017 = g_detail_d[l_ac].xmda017,
#                                          xmda017_desc = g_detail_d[l_ac].xmda017_desc,
#                                          xmda015 = g_detail_d[l_ac].xmda015,
#                                          xmda015_desc = g_detail_d[l_ac].xmda015_desc,
#                                          xmda016 = g_detail_d[l_ac].xmda016,
#                                          xmda011 = g_detail_d[l_ac].xmda011,
#                                          xmda011_desc = g_detail_d[l_ac].xmda011_desc,
#                                          xmda012 = g_detail_d[l_ac].xmda012,
#                                          xmda013 = g_detail_d[l_ac].xmda013
#                                          
#                                    WHERE xmdadocno = g_detail_d[l_ac].xmdadocno
#                                      AND xmddseq = g_detail_d[l_ac].xmddseq
#                                      AND xmddseq1 = g_detail_d[l_ac].xmddseq1
#                                      AND xmddseq2 = g_detail_d[l_ac].xmddseq2                    
                END IF
                CALL s_desc_get_currency_desc(g_detail_d[l_ac].xmda015) RETURNING g_detail_d[l_ac].xmda015_desc
                
             AFTER FIELD b_xmda011
                IF NOT cl_null(g_detail_d[l_ac].xmda011) THEN
                   LET l_oodb005 = ''
                   LET l_oodb006 = ''
                   LET l_oodb011 = ''
                   CALL s_tax_chk(g_site,g_detail_d[l_ac].xmda011)
                     RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
                     
                   IF l_success THEN
                      LET g_tax_app = l_oodb011
                      LET g_detail_d[l_ac].xmda012 = l_oodb006
                      LET g_detail_d[l_ac].xmda013 = l_oodb005
                      LET g_detail_d[l_ac].xmda011_desc = l_oodbl004
                   END IF 
#                   UPDATE apmp620_tmp SET sel = g_detail_d[l_ac].sel,
#                                          xmdd011 = g_detail_d[l_ac].xmdd011,
#                                          pmdb006 = g_detail_d[l_ac].pmdb006,
#                                          pmdl004 = g_detail_d[l_ac].pmdl004,
#                                          pmdl004_desc = g_detail_d[l_ac].pmdl004_desc,
#                                          xmda017 = g_detail_d[l_ac].xmda017,
#                                          xmda017_desc = g_detail_d[l_ac].xmda017_desc,
#                                          xmda015 = g_detail_d[l_ac].xmda015,
#                                          xmda015_desc = g_detail_d[l_ac].xmda015_desc,
#                                          xmda016 = g_detail_d[l_ac].xmda016,
#                                          xmda011 = g_detail_d[l_ac].xmda011,
#                                          xmda011_desc = g_detail_d[l_ac].xmda011_desc,
#                                          xmda012 = g_detail_d[l_ac].xmda012,
#                                          xmda013 = g_detail_d[l_ac].xmda013
#                                          
#                                    WHERE xmdadocno = g_detail_d[l_ac].xmdadocno
#                                      AND xmddseq = g_detail_d[l_ac].xmddseq
#                                      AND xmddseq1 = g_detail_d[l_ac].xmddseq1
#                                      AND xmddseq2 = g_detail_d[l_ac].xmddseq2                    
                ELSE 
                   LET g_detail_d[l_ac].xmda011_desc = ''      
                   LET g_detail_d[l_ac].xmda012 = ''                  
                END IF             
             
             ON ROW CHANGE
#                IF l_ac <> 0 THEN
#                  UPDATE apmp620_tmp SET sel = g_detail_d[l_ac].sel,
#                                         xmdd011 = g_detail_d[l_ac].xmdd011,
#                                         pmdb006 = g_detail_d[l_ac].pmdb006,
#                                         pmdl004 = g_detail_d[l_ac].pmdl004,
#                                         pmdl004_desc = g_detail_d[l_ac].pmdl004_desc,
#                                         xmda017 = g_detail_d[l_ac].xmda017,
#                                         xmda017_desc = g_detail_d[l_ac].xmda017_desc,
#                                         xmda015 = g_detail_d[l_ac].xmda015,
#                                         xmda015_desc = g_detail_d[l_ac].xmda015_desc,
#                                         xmda016 = g_detail_d[l_ac].xmda016,
#                                         xmda011 = g_detail_d[l_ac].xmda011,
#                                         xmda011_desc = g_detail_d[l_ac].xmda011_desc,
#                                         xmda012 = g_detail_d[l_ac].xmda012,
#                                         xmda013 = g_detail_d[l_ac].xmda013
#                                         
#                                   WHERE xmdadocno = g_detail_d[l_ac].xmdadocno
#                                     AND xmddseq = g_detail_d[l_ac].xmddseq
#                                     AND xmddseq1 = g_detail_d[l_ac].xmddseq1
#                                     AND xmddseq2 = g_detail_d[l_ac].xmddseq2 
#                END IF                                   
  
            ON ACTION controlp INFIELD b_pmdl004
            
		  	      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
		  	      LET g_qryparam.reqry = FALSE
          
               LET g_qryparam.default1 = g_detail_d[l_ac].pmdl004             #給予default值
          
               LET g_qryparam.where = "1=1 "
               
               LET l_sql = " 1=1"
               CALL s_control_get_sql("pmaa080",'3','4',g_user,g_dept) RETURNING l_success,l_sql
               IF l_success THEN
                  IF cl_null(l_sql) THEN
                     LET l_sql = " 1=1"
                  END IF
                  LET g_qryparam.where = g_qryparam.where ," AND ",l_sql
               END IF
               
               LET l_sql = " 1=1"
               CALL s_control_get_sql("pmaa001",'4','4',g_user,g_dept) RETURNING l_success,l_sql
               IF l_success THEN
                  IF cl_null(l_sql) THEN
                     LET l_sql = " 1=1"
                  END IF
                  LET g_qryparam.where = g_qryparam.where ," AND ",l_sql
               END IF
               
               LET l_sql = " 1=1"
               CALL s_control_get_doc_sql("pmaa083",g_pmdldocno,'2') RETURNING l_success,l_sql
               IF l_success THEN
                  IF cl_null(l_sql) THEN
                     LET l_sql = " 1=1"
                  END IF
                  LET g_qryparam.where = g_qryparam.where ," AND ",l_sql
               END IF
               
               CALL q_pmaa001_3()                                #呼叫開窗
          
               LET g_detail_d[l_ac].pmdl004 = g_qryparam.return1              #將開窗取得的值回傳到變數
          
               DISPLAY g_detail_d[l_ac].pmdl004 TO b_pmdl004              #顯示到畫面上
          
               NEXT FIELD b_pmdl004                          #返回原欄位
               
            ON ACTION controlp INFIELD b_xmda017
		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
		      	LET g_qryparam.reqry = FALSE
            
               LET g_qryparam.default1 = g_detail_d[l_ac].xmda017             #給予default值
            
               #給予arg
            
               CALL q_pmam001()                                #呼叫開窗
            
               LET g_detail_d[l_ac].xmda017 = g_qryparam.return1              #將開窗取得的值回傳到變數
            
               DISPLAY g_detail_d[l_ac].xmda017 TO b_xmda017             #顯示到畫面上
            
               NEXT FIELD b_xmda017                          #返回原欄位            
               
            ON ACTION controlp INFIELD b_xmda011

		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
		      	LET g_qryparam.reqry = FALSE
         
               LET g_qryparam.default1 = g_detail_d[l_ac].xmda011             #給予default值

               CALL q_oodb002_11()
               LET g_detail_d[l_ac].xmda011 = g_qryparam.return1              #將開窗取得的值回傳到變數
         
               DISPLAY g_detail_d[l_ac].xmda011 TO xmda011              #顯示到畫面上

         
               NEXT FIELD b_xmda011                          #返回原欄位        

            ON ACTION controlp INFIELD b_xmda015
		      	INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
		      	LET g_qryparam.reqry = FALSE
           
               LET g_qryparam.default1 = g_detail_d[l_ac].xmda015             #給予default值
           
               #給予arg
               LET g_qryparam.arg1 = g_site #
           
               CALL q_ooaj002_1()                                
           
               LET g_detail_d[l_ac].xmda015 = g_qryparam.return1             
           
               DISPLAY g_detail_d[l_ac].xmda015 TO b_xmda015             
           
               NEXT FIELD b_xmda015                         #返回原欄位
            
         END INPUT    
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
      
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
            IF cl_null(g_type) THEN
               LET g_type = '1'
            END IF
            DISPLAY g_type TO l_type
            IF cl_null(g_price) THEN
               LET g_price = 'Y'
            END IF 
            DISPLAY g_price TO l_price         
            LET g_qryparam.state = 'i'            
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apmp620_filter()
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
            CALL apmp620_query()
            CALL cl_set_comp_required("b_pmdl004",FALSE)  #add by lixh 20150602
            NEXT FIELD pmdldocno          #add by lixh 20150602
            #end add-point
            CALL apmp620_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apmp620_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL apmp620_gene_pmdl_pmdn()
            #CALL apmp620_b_fill()         #add by lixh 20150601    #160413-00011#1 mark
            CALL cl_set_comp_required("b_pmdl004",FALSE)  #add by lixh 20150602
            DISPLAY g_detail_d.getLength() TO FORMONLY.h_count   #160413-00011#1 add
            NEXT FIELD pmdldocno          #add by lixh 20150602
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
 
{<section id="apmp620.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmp620_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF cl_null(g_pmdldocno) THEN
      RETURN
   END IF   
   #end add-point
        
   LET g_error_show = 1
   CALL apmp620_b_fill()
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
 
{<section id="apmp620.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmp620_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_oobn003       LIKE oobn_t.oobn003
   DEFINE l_pmdo006       LIKE pmdo_t.pmdo006
   DEFINE r_pmdn007       LIKE pmdn_t.pmdn007
   DEFINE s_pmdn007       LIKE pmdn_t.pmdn007
   DEFINE l_pmdo004       LIKE pmdo_t.pmdo004
   DEFINE l_sql           STRING
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5   
   DEFINE r_flag          LIKE type_t.num5   
   DEFINE l_controlno     LIKE ooha_t.ooha001
   DEFINE l_n             LIKE type_t.num10
   DEFINE l_ooef016       LIKE ooef_t.ooef016
   DEFINE l_scc40         LIKE type_t.chr2
   DEFINE l_oodbl004      LIKE oodbl_t.oodbl004  #稅別名稱
   DEFINE l_oodb005       LIKE oodb_t.oodb005    #含稅否
   DEFINE l_oodb006       LIKE oodb_t.oodb006    #稅率 
   DEFINE l_oodb011       LIKE oodb_t.oodb011    #取得稅別類型1:正常稅率2:依料件設
   #160413-00011#1---add---begin
   DEFINE l_sql_1         STRING
   DEFINE l_sql_2         STRING
   DEFINE l_sql_3         STRING
   DEFINE l_sql_4         STRING
   DEFINE l_sql_5         STRING
   DEFINE l_n1            LIKE type_t.num10
   DEFINE l_n2            LIKE type_t.num10
   DEFINE l_n3            LIKE type_t.num10
   DEFINE l_n4            LIKE type_t.num10
   DEFINE l_n5            LIKE type_t.num10
   DEFINE l_ooef004       LIKE ooef_t.ooef014
   #160413-00011#1---add---end
   DEFINE l_xmda028       LIKE xmda_t.xmda028  #161207-00033#21
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_pmdldocno) THEN
      RETURN
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   #160413-00011#1---add---begin
   #先判斷這個供應商是否有設多個當前採購控制組範圍內的供應商預設條件，則開窗，讓user 選擇帶哪一個控制組的資料
   LET l_controlno = ''
   CALL s_control_get_group('4',g_user,g_dept) RETURNING l_success,l_controlno
   
   #根據內外購獲取當前營運據點參數設置的汇率类型
   LET l_scc40 = ''
    
   LET l_scc40 = cl_get_para(g_enterprise,g_site,'S-BAS-0014')
    
   LET l_ooef016 = ''
   SELECT ooef004,ooef016 INTO l_ooef004,l_ooef016 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   SELECT COUNT(oobd003) INTO l_n1 FROM ooba_t,oobd_t 
    WHERE oobaent = oobdent AND ooba001 = oobd001 AND ooba002 = oobd002
      AND oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = g_pmdldocno
      AND oobd003='285'
      
   SELECT COUNT(oobd003) INTO l_n2 FROM ooba_t,oobd_t 
    WHERE oobaent = oobdent AND ooba001 = oobd001 AND ooba002 = oobd002
      AND oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = g_pmdldocno
      AND oobd003='210' 
      
   SELECT COUNT(oobd003) INTO l_n3 FROM ooba_t,oobd_t  
    WHERE oobaent = oobdent AND ooba001 = oobd001 
      AND ooba002 = oobd002 AND oobaent = g_enterprise 
      AND ooba001 = l_ooef004 AND ooba002 = g_pmdldocno AND oobd003='255'  
      
   #依据传入的人员编号p_user来抓取控制组
   LET l_sql_1 = "SELECT unique ooha001 FROM ooha_t,oohc_t WHERE oohaent=oohcent AND ooha001=oohc001 ",
                 "   AND oohastus = 'Y'",  #160303-00027#1 2016/03/17 By earl add
                 "   AND ooha002='4' AND oohc002='",g_user,"'",
                 "   AND (oohc003<='",g_today,"' AND (oohc004 IS NULL OR oohc004>'",g_today,"'))"
   
   #依据传入的部门编号p_group来抓取控制组
   LET l_sql_2 = "SELECT unique ooha001 FROM ooha_t,oohb_t WHERE oohaent=oohbent AND ooha001=oohb001 ",
                 "   AND oohastus = 'Y'",  #160303-00027#1 2016/03/17 By earl add
                 "   AND ooha002='4' AND oohb002='",g_dept,"'",
                 "   AND (oohb003<='",g_today,"' AND (oohb004 IS NULL OR oohb004>'",g_today,"'))"
                
   LET l_sql_3 = l_sql_1," UNION ",l_sql_2    
    
   LET l_sql_4 = "SELECT COUNT(oohg002) FROM ooha_t,oohg_t WHERE oohaent=oohgent AND ooha001=oohg001 ",
                 "   AND oohastus = 'Y'",  
                 "   AND oohaent = '",g_enterprise,"' AND ooha001 IN(",l_sql_3,")"
   PREPARE con_pre2_1 FROM l_sql_4
   EXECUTE con_pre2_1 INTO l_n4
   
   LET l_sql_5 = "SELECT COUNT(oohf002) FROM ooha_t,oohf_t WHERE oohaent=oohfent AND ooha001=oohf001 ",
                 "   AND oohastus = 'Y'",
                 "   AND oohaent = '",g_enterprise,"' AND ooha001 IN(",l_sql_3,")"
   PREPARE con_pre2_2 FROM l_sql_5
   EXECUTE con_pre2_2 INTO l_n5
   #160413-00011#1---add---end   
   
   #DELETE FROM apmp620_tmp;          #160413-00011#1
   #160413-00011#1---mod---begin
#   LET g_sql = " SELECT DISTINCT 'N',xmdadocno,xmddseq,xmddseq1,xmddseq2,xmda004,'',xmda002,'',xmdadocdt,xmdd011,xmdc001,'','',xmdc002,'',",
#      #         "        xmdc006,'',xmdc007,0,0,'','',xmda017,'',xmda015,'',xmda016,xmda011,'',xmda012,xmda013 ",
#               "        xmdc006,'',xmdd006,0,0,'','',xmda017,'',xmda015,'',xmda016,xmda011,'',xmda012,xmda013,'' ",
#               "   FROM xmda_t,xmdd_t,xmdc_t ",
#               "   LEFT OUTER JOIN imaf_t ON xmdcent = imafent AND xmdcsite = imafsite AND xmdc001 = imaf001 ",
#               "  WHERE xmdcent = ? ",
#               "    AND xmdcsite = '",g_site,"'",
#               "    AND xmdcent = xmddent ",
#               "    AND xmdcsite = xmddsite",
#               "    AND xmdcdocno = xmdddocno ",
#               "    AND xmdcseq = xmddseq",
#               "    AND xmdaent = xmdcent",
#               "    AND xmdasite = xmdcsite ",
#               "    AND xmdadocno = xmdcdocno ",
#               "    AND xmdastus = 'Y' ",
#               "    AND ",g_wc,
#               "    ORDER BY xmdadocno,xmddseq,xmddseq1,xmddseq2 "
   LET g_sql = " SELECT DISTINCT 'N',xmdadocno,xmddseq,xmddseq1,xmddseq2,xmda004,a.pmaal004,xmda002,ooag011,xmdadocdt,xmdd011,xmdc001,imaal003,imaal004,xmdc002,inaml004,",
               "        xmdc006,oocal003,xmdd006,0,0,imaf153,b.pmaal004,xmda017,pmaml003,xmda015,ooail003,xmda016,xmda011,oodbl004,xmda012,xmda013,'',xmda028 ", #161207-00033#21 add xmda028
               "   FROM xmda_t",
               "   INNER JOIN xmdc_t ON xmdaent = xmdcent AND xmdadocno = xmdcdocno ",
               "   INNER JOIN xmdd_t ON xmdcent = xmddent AND xmdcdocno = xmdddocno AND xmdcseq = xmddseq ",              
               "   LEFT OUTER JOIN ooag_t ON xmdaent = ooagent AND xmda002 = ooag001 ",
               "   LEFT OUTER JOIN imaf_t ON xmdcent = imafent AND xmdcsite = imafsite AND xmdc001 = imaf001 ",
               "   LEFT OUTER JOIN pmaal_t a ON xmdaent = a.pmaalent AND xmda004 = a.pmaal001 AND a.pmaal002 = '",g_dlang,"'",
               "   LEFT OUTER JOIN ooail_t ON xmdaent = ooailent AND xmda015 = ooail001 AND ooail002 = '",g_dlang,"'",
               "   LEFT OUTER JOIN oodbl_t ON oodblent = xmdaent AND oodbl001 = '",g_ooef019,"' AND oodbl002 = xmda011 AND oodbl003 = '",g_dlang,"'",
               "   LEFT OUTER JOIN pmaml_t ON xmdaent = pmamlent AND xmda017 = pmaml001 AND pmaml002 = '",g_dlang,"'",
               "   LEFT OUTER JOIN imaal_t ON xmdcent = imaalent AND xmdc001 = imaal001 AND imaal002 = '",g_dlang,"'",
               "   LEFT OUTER JOIN oocal_t ON xmdcent = oocalent AND xmdc006 = oocal001 AND oocal002 = '",g_dlang,"'",
               "   LEFT OUTER JOIN pmaal_t b ON xmdaent = b.pmaalent AND imaf153 = b.pmaal001 AND b.pmaal002 = '",g_dlang,"'",
               "   LEFT OUTER JOIN inaml_t ON inamlent = xmdcent AND inaml001 = xmdc001 AND inaml002 = xmdc002 AND inaml003 = '",g_dlang,"'",
               "  WHERE xmdcent = ? ",
               "    AND xmdcsite = '",g_site,"'",
               "    AND xmdastus = 'Y' ",
               "    AND ",g_wc
   IF l_n1 > 0 THEN 
      LET g_sql = g_sql," AND EXISTS(SELECT 1 FROM ooba_t,oobd_t ",
                        "            WHERE oobaent = oobdent AND ooba001 = oobd001 AND ooba002 = oobd002 ",
                        "              AND oobaent = '",g_enterprise,"' AND ooba001 = '",l_ooef004,"' AND ooba002 = '",g_pmdldocno,"'",
                        "              AND oobd003='285' AND oobd004 = (SELECT pmaa093 FROM pmaa_t WHERE pmaaent = '",g_enterprise,"' AND pmaa001 = xmda004)) "
   END IF
   IF l_n2 > 0 THEN 
      LET g_sql = g_sql," AND EXISTS(SELECT 1 FROM ooba_t,oobd_t ",
                        "            WHERE oobaent = oobdent AND ooba001 = oobd001 AND ooba002 = oobd002 ",
                        "              AND oobaent = '",g_enterprise,"' AND ooba001 = '",l_ooef004,"' AND ooba002 = '",g_pmdldocno,"'",
                        "              AND oobd003='285' AND oobd004 = (SELECT imaf016 FROM imaf_t WHERE imafent = '",g_enterprise,"' AND imaf001 = xmdc001 AND imafsite = '",g_site,"')) "
   END IF 
   IF l_n3 > 0 THEN 
      LET g_sql = g_sql," AND EXISTS(SELECT 1 FROM ooba_t,oobd_t ",
                        "            WHERE oobaent = oobdent AND ooba001 = oobd001 AND ooba002 = oobd002 ",
                        "              AND oobaent = '",g_enterprise,"' AND ooba001 = '",l_ooef004,"' AND ooba002 = '",g_pmdldocno,"'",
                        "              AND oobd003='285' AND oobd004 = (SELECT pmaa083 FROM pmaa_t WHERE pmaaent = '",g_enterprise,"' AND pmaa001 = pmdl004)) "
   END IF   
   IF l_n4 > 0 OR l_n5 > 0 THEN 
      IF l_n4 > 0 THEN
         LET g_sql = g_sql," AND EXISTS (",l_sql_4," AND oohg002 = pmdl004)"
      END IF
      IF l_n5 > 0 THEN
         LET g_sql = g_sql," AND EXISTS (",l_sql_5," AND oohf002 = (SELECT pmaa080 INTO l_pmaa080 FROM pmaa_t WHERE pmaaent= '",g_enterprise,"' AND pmaa001=pmdl004))"
      END IF      
   END IF
   LET g_sql = g_sql,"    ORDER BY xmdadocno,xmddseq,xmddseq1,xmddseq2 " 
   #160413-00011#1---mod---end               
#   PREPARE apmp610_ins_tmp FROM l_sql
#   EXECUTE apmp610_ins_tmp  
#   LET l_sql = " SELECT pmdo004,pmdo006 FROM pmdn_t,pmdl_t,pmdo_t ",
#               "  WHERE pmdnent = pmdlent ",
#               "    AND pmdnsite = pmdlsite ",
#               "    AND pmdndocno = pmdldocno ",
#               "    AND pmdoent = pmdnent ",
#               "    AND pmdosite = pmdnsite ",
#               "    AND pmdodocno = pmdndocno ",
#               "    AND pmdoseq = pmdnseq ",
#               "    AND pmdlent = '",g_enterprise,"' ",
#               "    AND pmdlsite = '",g_site,"'",
#               "    AND pmdlstus <> 'X' ",
#               "    AND pmdo036 = ? ",
#               "    AND pmdo037 = ? ",
#               "    AND pmdo038 = ? ",
#               "    AND pmdo039 = ? "

   LET l_sql = " SELECT pmdp022,pmdp023 FROM pmdn_t,pmdp_t,pmdl_t ",
               "  WHERE pmdnent = pmdpent ",
               "    AND pmdnsite = pmdpsite ",
               "    AND pmdndocno = pmdpdocno ",
               "    AND pmdnseq = pmdpseq ",
               "    AND pmdlent = pmdpent ",
               "    AND pmdlsite = pmdpsite ",
               "    AND pmdldocno = pmdpdocno ",
               "    AND pmdnent = '",g_enterprise,"' ",
               "    AND pmdnsite = '",g_site,"'",
               "    AND pmdlstus <> 'X' ",
               "    AND pmdp003 = ? ",
               "    AND pmdp004 = ? ",
               "    AND pmdp005 = ? ",
               "    AND pmdp006 = ? ",
               "    AND pmdp022 IS NOT NULL ",    #160413-00011#1
               "    AND pmdp023 IS NOT NULL "     #160413-00011#1
   PREPARE apmp620_sel_01 FROM l_sql
   DECLARE b_fill_curs_01 CURSOR WITH HOLD FOR apmp620_sel_01  
   #end add-point
 
   PREPARE apmp620_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmp620_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   CALL cl_err_collect_init()    #add by lixh 20150914
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
           g_detail_d[l_ac].sel,g_detail_d[l_ac].xmdadocno,g_detail_d[l_ac].xmddseq,g_detail_d[l_ac].xmddseq1,g_detail_d[l_ac].xmddseq2,g_detail_d[l_ac].xmda004,
           g_detail_d[l_ac].xmda004_desc,g_detail_d[l_ac].xmda002,g_detail_d[l_ac].xmda002_desc,g_detail_d[l_ac].xmdadocdt,g_detail_d[l_ac].xmdd011,
           g_detail_d[l_ac].xmdc001,g_detail_d[l_ac].xmdc001_desc,g_detail_d[l_ac].xmdc001_desc_desc,g_detail_d[l_ac].xmdc002,g_detail_d[l_ac].xmdc002_desc,
           g_detail_d[l_ac].xmdc006,g_detail_d[l_ac].xmdc006_desc,g_detail_d[l_ac].xmdc007,g_detail_d[l_ac].num,g_detail_d[l_ac].pmdb006,
           g_detail_d[l_ac].pmdl004,g_detail_d[l_ac].pmdl004_desc,g_detail_d[l_ac].xmda017,g_detail_d[l_ac].xmda017_desc,g_detail_d[l_ac].xmda015,
           g_detail_d[l_ac].xmda015_desc,g_detail_d[l_ac].xmda016,g_detail_d[l_ac].xmda011,g_detail_d[l_ac].xmda011_desc,g_detail_d[l_ac].xmda012,
           g_detail_d[l_ac].xmda013,g_detail_d[l_ac].pmal002,l_xmda028     #161207-00033#21 add xmda028      
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
      #161207-00033#21-S
      IF NOT cl_null(l_xmda028) THEN
         CALL s_desc_get_oneturn_guest_desc(l_xmda028) RETURNING g_detail_d[l_ac].xmda004_desc
      END IF
      #161207-00033#21-E

#160413-00011#1---mod---begin
#      SELECT imaf153 INTO g_detail_d[l_ac].pmdl004 FROM imaf_t
#       WHERE imafent = g_enterprise
#         AND imafsite = g_site
#         AND imaf001 = g_detail_d[l_ac].xmdc001
#
#      #先判斷這個供應商是否有設多個當前採購控制組範圍內的供應商預設條件，則開窗，讓user 選擇帶哪一個控制組的資料
#      LET l_controlno = ''
#      CALL s_control_get_group('4',g_user,g_dept) RETURNING l_success,l_controlno
#160413-00011#1---mod---end 获取控制组编号放到FOREACH外面抓取     

#160413-00011#1---add---begin
      IF NOT s_aooi210_check_doc(g_site,'',g_detail_d[l_ac].xmdadocno,g_pmdldocno,'2','axmt500') THEN
         CONTINUE FOREACH
      END IF      
      #訂單須為確認狀態且銷售量未全數請購單的數量
      #單位轉換
      LET s_pmdn007 = 0
      LET l_pmdo004 = ''
      LET l_pmdo006 = 0
      LET r_pmdn007 = 0
      FOREACH b_fill_curs_01 USING g_detail_d[l_ac].xmdadocno,g_detail_d[l_ac].xmddseq,g_detail_d[l_ac].xmddseq1,g_detail_d[l_ac].xmddseq2
                              INTO l_pmdo004,l_pmdo006
         IF NOT cl_null(l_pmdo004) AND NOT cl_null(g_detail_d[l_ac].xmdc006) THEN
            CALL s_aooi250_convert_qty(g_detail_d[l_ac].xmdc001,l_pmdo004,
                                       g_detail_d[l_ac].xmdc006,l_pmdo006)
                 RETURNING r_success,r_pmdn007    
            IF cl_null(r_pmdn007) THEN
               LET r_pmdn007 = 0
            END IF  
         END IF         
         LET s_pmdn007 = s_pmdn007 + r_pmdn007
      END FOREACH
      
      LET g_detail_d[l_ac].num = g_detail_d[l_ac].xmdc007 - s_pmdn007     
      LET g_detail_d[l_ac].pmdb006 = g_detail_d[l_ac].num  
      IF g_detail_d[l_ac].num = 0 THEN
         CONTINUE FOREACH
      END IF   
#160413-00011#1---add---end      
      IF NOT cl_null(l_controlno) THEN
         #判斷供應商是否有設置採購控制組供應商預設條件(apmi110)，若有則抓取相關的預設條件default到採購單上
         SELECT COUNT(*) INTO l_n FROM pmal_t WHERE pmalent = g_enterprise AND pmal001 = g_detail_d[l_ac].pmdl004 AND pmal002 = l_controlno AND pmalstus = 'Y'
         IF l_n > 0 THEN
            SELECT pmal004,pmal003,pmal021
              INTO g_detail_d[l_ac].xmda011,g_detail_d[l_ac].xmda015,g_detail_d[l_ac].xmda017                
            FROM pmal_t WHERE pmalent = g_enterprise AND pmal001 = g_detail_d[l_ac].pmdl004 AND pmal002 = l_controlno AND pmalstus = 'Y'
         END IF
      END IF
      
      #若沒有設置採購控制組供應商預設條件資料則改抓供應商據點預設條件(apmm202)資料  
      IF cl_null(l_controlno) OR l_n = 0 THEN
         SELECT pmab034,pmab033,pmab054
           INTO g_detail_d[l_ac].xmda011,g_detail_d[l_ac].xmda015,g_detail_d[l_ac].xmda017
           FROM pmab_t WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = g_detail_d[l_ac].pmdl004           
      END IF
      #取稅率、單價含稅否
      IF NOT cl_null(g_detail_d[l_ac].xmda011) THEN
         LET l_oodb005 = ''
         LET l_oodb006 = ''
         LET l_oodb011 = ''
         CALL s_tax_chk(g_site,g_detail_d[l_ac].xmda011)
           RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
           
         IF l_success THEN
            LET g_tax_app = l_oodb011
            LET g_detail_d[l_ac].xmda012 = l_oodb006
            LET g_detail_d[l_ac].xmda013 = l_oodb005
            LET g_detail_d[l_ac].xmda011_desc = l_oodbl004
         END IF           
      END IF
      #add by lixh 20150601
      IF cl_null(g_detail_d[l_ac].xmda013) THEN
         LET g_detail_d[l_ac].xmda013 = 'N'
      END IF
      #add by lixh 20150601
      #取匯率
      IF NOT cl_null(g_detail_d[l_ac].xmda015) THEN
#160413-00011#1---mark---end
#l_scc40和l_ooef016可以放在FOREACH外面做，虽然有可能xmda015为空，但如果有多笔不为空的情况下重复抓取多次，故放在外面做
#         #根據內外購獲取當前營運據點參數設置的汇率类型
#         LET l_scc40 = ''
#
#         LET l_scc40 = cl_get_para(g_enterprise,g_site,'S-BAS-0014')
#
#         LET l_ooef016 = ''
#         SELECT ooef016 INTO l_ooef016 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
#160413-00011#1---add---begin
         IF NOT cl_null(l_scc40) THEN
            CALL s_aooi160_get_exrate('1',g_site,g_today,g_detail_d[l_ac].xmda015,l_ooef016,0,l_scc40) RETURNING g_detail_d[l_ac].xmda016
         END IF
      END IF 
      
#160413-00011#1---mark---begin      
#      #訂單須為確認狀態且銷售量未全數請購單的數量
#      #單位轉換
#      LET s_pmdn007 = 0
#      LET l_pmdo004 = ''
#      LET l_pmdo006 = 0
#      LET r_pmdn007 = 0
#      FOREACH b_fill_curs_01 USING g_detail_d[l_ac].xmdadocno,g_detail_d[l_ac].xmddseq,g_detail_d[l_ac].xmddseq1,g_detail_d[l_ac].xmddseq2
#                              INTO l_pmdo004,l_pmdo006
#         IF NOT cl_null(l_pmdo004) AND NOT cl_null(g_detail_d[l_ac].xmdc006) THEN
#            CALL s_aooi250_convert_qty(g_detail_d[l_ac].xmdc001,l_pmdo004,
#                                       g_detail_d[l_ac].xmdc006,l_pmdo006)
#                 RETURNING r_success,r_pmdn007    
#            IF cl_null(r_pmdn007) THEN
#               LET r_pmdn007 = 0
#            END IF  
#         END IF         
#         LET s_pmdn007 = s_pmdn007 + r_pmdn007
#      END FOREACH
#      
#      LET g_detail_d[l_ac].num = g_detail_d[l_ac].xmdc007 - s_pmdn007     
#      LET g_detail_d[l_ac].pmdb006 = g_detail_d[l_ac].num  
#      IF g_detail_d[l_ac].num = 0 THEN
#         CONTINUE FOREACH
#      END IF    
#160413-00011#1---mark---end
#160413-00011#1---mark---begin 
#      #客戶生命週期檢核
#      CALL s_control_chk_doc('3',g_pmdldocno,g_detail_d[l_ac].xmda004,'','','','')  RETURNING r_success,r_flag
#      IF r_success THEN
#         IF NOT r_flag THEN
#            CONTINUE FOREACH
#         END IF
#      ELSE
#         CONTINUE FOREACH
#      END IF
#      #產品生命週期檢核
#      CALL s_control_chk_doc('4',g_pmdldocno,g_detail_d[l_ac].xmdc001,'','','','')  RETURNING r_success,r_flag
#      IF r_success THEN
#         IF NOT r_flag THEN
#            CONTINUE FOREACH
#         END IF
#      ELSE
#         CONTINUE FOREACH
#      END IF
#160413-00011#1---mark---end 
#160413-00011#1---mark---begin 
#      #供應商檢核
#      #判斷輸入的供應商編號是否在採購控制組限制的供應商範圍內，若不在限制內則不允許跟此供應商採購 
#      IF NOT cl_null(g_detail_d[l_ac].pmdl004) THEN      
#         CALL s_control_chk_group('2','4',g_user,g_dept,g_detail_d[l_ac].pmdl004,'','','','') RETURNING r_success,r_flag
#         IF NOT r_success THEN      #处理状态
#            LET g_detail_d[l_ac].pmdl004 = ''
##            CONTINUE FOREACH
#         ELSE
#            IF NOT r_flag THEN      #是否存在
#             #  CONTINUE FOREACH
#               LET g_detail_d[l_ac].pmdl004 = ''
#            END IF 
#         END IF
#
#      
#         #檢核輸入的供應商是否在單據別限制範圍內，若不在限制內則不允許跟此供應商採購
#         CALL s_control_chk_doc('2',g_pmdldocno,g_detail_d[l_ac].pmdl004,'','','','') RETURNING r_success,r_flag
#         IF NOT r_success THEN      #处理状态
##            CONTINUE FOREACH
#            LET g_detail_d[l_ac].pmdl004 = ''
#         ELSE
#            IF NOT r_flag THEN      #是否存在
#            #   CONTINUE FOREACH
#               LET g_detail_d[l_ac].pmdl004 = ''
#            END IF 
#         END IF      
#      END IF
#160413-00011#1---mark---end      
#      #檢核前後置單別的合理性
#      IF NOT s_aooi210_check_doc(g_site,'',g_detail_d[l_ac].xmdadocno,g_pmdldocno,'1','apmt500') THEN
#         LET r_success = FALSE
#      END IF
#160413-00011#1---mark---begin
#      #檢核前後置單別的合理性
#      IF NOT s_aooi210_check_doc(g_site,'',g_detail_d[l_ac].xmdadocno,g_pmdldocno,'2','axmt500') THEN
#         LET r_success = FALSE
#      END IF
#      #add by lixh 20150528
#        
#      IF NOT r_success THEN
#         CONTINUE FOREACH
#      END IF
#160413-00011#1---mark---end       
#160413-00011#1---mark---begin      
#      CALL s_desc_get_item_desc(g_detail_d[l_ac].xmdc001) RETURNING g_detail_d[l_ac].xmdc001_desc,g_detail_d[l_ac].xmdc001_desc_desc
#      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].xmda004) RETURNING g_detail_d[l_ac].xmda004_desc
#      CALL s_desc_get_person_desc(g_detail_d[l_ac].xmda002) RETURNING g_detail_d[l_ac].xmda002_desc
#      CALL s_desc_get_unit_desc(g_detail_d[l_ac].xmdc006) RETURNING g_detail_d[l_ac].xmdc006_desc
#      CALL s_feature_description(g_detail_d[l_ac].xmdc001,g_detail_d[l_ac].xmdc002)
#           RETURNING r_success,g_detail_d[l_ac].xmdc002_desc 
#      CALL s_desc_get_tax_desc(g_ooef019,g_detail_d[l_ac].xmda011) RETURNING g_detail_d[l_ac].xmda011_desc     
#      CALL s_desc_get_currency_desc(g_detail_d[l_ac].xmda015) RETURNING g_detail_d[l_ac].xmda015_desc
#      CALL s_desc_get_price_type_desc(g_detail_d[l_ac].xmda017) RETURNING g_detail_d[l_ac].xmda017_desc
#      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].pmdl004)  
#           RETURNING g_detail_d[l_ac].pmdl004_desc
#                   
#      INSERT INTO apmp620_tmp (sel,xmdadocno,xmddseq,xmddseq1,xmddseq2,xmda004,xmda004_desc,xmda002,xmda002_desc,xmdadocdt,xmdd011,xmdc001,xmdc001_desc,xmdc001_desc_desc,
#                               xmdc002,xmdc002_desc,xmdc006,xmdc006_desc,xmdc007,num,pmdb006,pmdl004,pmdl004_desc,xmda017,xmda017_desc,xmda015,xmda015_desc,
#                               xmda016,xmda011,xmda011_desc,xmda012,xmda013)
#                       VALUES (g_detail_d[l_ac].sel,g_detail_d[l_ac].xmdadocno,g_detail_d[l_ac].xmddseq,g_detail_d[l_ac].xmddseq1,g_detail_d[l_ac].xmddseq2,g_detail_d[l_ac].xmda004,
#                               g_detail_d[l_ac].xmda004_desc,g_detail_d[l_ac].xmda002,g_detail_d[l_ac].xmda002_desc,g_detail_d[l_ac].xmdadocdt,g_detail_d[l_ac].xmdd011,
#                               g_detail_d[l_ac].xmdc001,g_detail_d[l_ac].xmdc001_desc,g_detail_d[l_ac].xmdc001_desc_desc,g_detail_d[l_ac].xmdc002,g_detail_d[l_ac].xmdc002_desc,
#                               g_detail_d[l_ac].xmdc006,g_detail_d[l_ac].xmdc006_desc,g_detail_d[l_ac].xmdc007,g_detail_d[l_ac].num,g_detail_d[l_ac].pmdb006,
#                               g_detail_d[l_ac].pmdl004,g_detail_d[l_ac].pmdl004_desc,g_detail_d[l_ac].xmda017,g_detail_d[l_ac].xmda017_desc,g_detail_d[l_ac].xmda015,
#                               g_detail_d[l_ac].xmda015_desc,g_detail_d[l_ac].xmda016,g_detail_d[l_ac].xmda011,g_detail_d[l_ac].xmda011_desc,g_detail_d[l_ac].xmda012,
#                               g_detail_d[l_ac].xmda013)
#160413-00011#1---mark---end                                 
      #end add-point
      
      CALL apmp620_detail_show()      
 
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
   CALL cl_err_collect_show()   #add by lixh 20150914
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE apmp620_sel
   
   LET l_ac = 1
   CALL apmp620_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   LET g_master_idx = l_ac  #add by lixh 20150602
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp620.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmp620_fetch()
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
 
{<section id="apmp620.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmp620_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp620.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apmp620_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL apmp620_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apmp620.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apmp620_filter_parser(ps_field)
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
 
{<section id="apmp620.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apmp620_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmp620_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmp620.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 產生採購單
# Memo...........:
# Usage..........: CALL apmp620_gene_pmdl_pmdn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp620_gene_pmdl_pmdn()
DEFINE   r_success       LIKE type_t.num5
#DEFINE   l_pmdl004       LIKE pmdl_t.pmdl004
#DEFINE   l_pmdl004_t     LIKE pmdl_t.pmdl004
#DEFINE   l_xmdadocno     LIKE xmda_t.xmdadocno
#DEFINE   l_xmdadocno_t   LIKE xmda_t.xmdadocno
#DEFINE   l_xmda004       LIKE xmda_t.xmda004
#DEFINE   l_xmda004_t     LIKE xmda_t.xmda004
DEFINE   la_param   RECORD
         prog       STRING,
         actionid   STRING,
         background LIKE type_t.chr1,
         param      DYNAMIC ARRAY OF STRING
         END RECORD
DEFINE   ls_js      STRING
DEFINE   ls_sql     STRING
DEFINE   l_sql      STRING
DEFINE   j          LIKE type_t.num10
DEFINE   l_n        LIKE type_t.num10
#DEFINE   l_pmdl     RECORD LIKE pmdl_t.*
DEFINE   l_pmdl017    LIKE pmdl_t.pmdl017
DEFINE   l_pmdl004    LIKE pmdl_t.pmdl004
DEFINE   l_pmdl015    LIKE pmdl_t.pmdl015
DEFINE   l_pmdl009    LIKE pmdl_t.pmdl009
DEFINE   l_pmdl010    LIKE pmdl_t.pmdl010
DEFINE   l_pmdl023    LIKE pmdl_t.pmdl023
DEFINE   l_pmdl054    LIKE pmdl_t.pmdl054
DEFINE   l_pmdn001    LIKE pmdn_t.pmdn001
DEFINE   l_pmdn002    LIKE pmdn_t.pmdn002
DEFINE   l_pmdn016    LIKE pmdn_t.pmdn016
DEFINE   l_pmdn010    LIKE pmdn_t.pmdn010
DEFINE   l_pmdn011    LIKE pmdn_t.pmdn011
DEFINE   l_pmdn004    LIKE pmdn_t.pmdn004
DEFINE   l_pmdn005    LIKE pmdn_t.pmdn005
DEFINE   l_pmdn040    LIKE pmdn_t.pmdn040
DEFINE   l_pmdn041    LIKE pmdn_t.pmdn041
DEFINE   l_pmdn042    LIKE pmdn_t.pmdn042
DEFINE   l_pmdn043    LIKE pmdn_t.pmdn043
DEFINE   l_pmdn046    LIKE pmdn_t.pmdn046
DEFINE   l_pmdn047    LIKE pmdn_t.pmdn047
DEFINE   l_pmdn048    LIKE pmdn_t.pmdn048
DEFINE   l_pmdn015    LIKE pmdn_t.pmdn015
DEFINE   l_pmdn044    LIKE pmdn_t.pmdn044
DEFINE   l_i          LIKE type_t.num10    #160413-00011#1

   DELETE FROM apmp620_tmp;
   CALL g_detail_d_old.clear()  #160825-00018#1 add
   LET l_i = 1
   FOR j = 1 TO g_detail_d.getLength() 
      IF g_detail_d[j].sel = 'N' THEN
         #160413-00011#1---add---begin
         LET g_detail_d_old[l_i].* = g_detail_d[j].*
         LET l_i = l_i + 1
         #160413-00011#1---add---end
         CONTINUE FOR
      END IF
      CALL apmp620_pmdl004_desc(g_detail_d[j].pmdl004,g_detail_d[j].pmal002) RETURNING l_pmdl.*
      CALL s_desc_get_price_type_desc(g_detail_d[j].xmda017) RETURNING g_detail_d[j].xmda017_desc
      INSERT INTO apmp620_tmp (sel,xmdadocno,xmddseq,xmddseq1,xmddseq2,xmda004,xmda004_desc,xmda002,xmda002_desc,xmdadocdt,xmdd011,xmdc001,xmdc001_desc,xmdc001_desc_desc,
                               xmdc002,xmdc002_desc,xmdc006,xmdc006_desc,xmdc007,num,pmdb006,pmdl004,pmdl004_desc,xmda017,xmda017_desc,xmda015,xmda015_desc,
                               xmda016,xmda011,xmda011_desc,xmda012,xmda013,pmal002,pmdl009,pmdl010,pmdl020,pmdl021,pmdl022,pmdl023,pmdl024,pmdl027,pmdl033,pmdl054,pmdl055)
                       VALUES (g_detail_d[j].sel,g_detail_d[j].xmdadocno,g_detail_d[j].xmddseq,g_detail_d[j].xmddseq1,g_detail_d[j].xmddseq2,g_detail_d[j].xmda004,
                               g_detail_d[j].xmda004_desc,g_detail_d[j].xmda002,g_detail_d[j].xmda002_desc,g_detail_d[j].xmdadocdt,g_detail_d[j].xmdd011,
                               g_detail_d[j].xmdc001,g_detail_d[j].xmdc001_desc,g_detail_d[j].xmdc001_desc_desc,g_detail_d[j].xmdc002,g_detail_d[j].xmdc002_desc,
                               g_detail_d[j].xmdc006,g_detail_d[j].xmdc006_desc,g_detail_d[j].xmdc007,g_detail_d[j].num,g_detail_d[j].pmdb006,
                               g_detail_d[j].pmdl004,g_detail_d[j].pmdl004_desc,g_detail_d[j].xmda017,g_detail_d[j].xmda017_desc,g_detail_d[j].xmda015,
                               g_detail_d[j].xmda015_desc,g_detail_d[j].xmda016,g_detail_d[j].xmda011,g_detail_d[j].xmda011_desc,g_detail_d[j].xmda012,
                               g_detail_d[j].xmda013,g_detail_d[j].pmal002,l_pmdl.pmdl009,l_pmdl.pmdl010,l_pmdl.pmdl020,l_pmdl.pmdl021,l_pmdl.pmdl022,l_pmdl.pmdl023,l_pmdl.pmdl024,
                               l_pmdl.pmdl027,l_pmdl.pmdl033,l_pmdl.pmdl054,l_pmdl.pmdl055)
   END FOR
   #160413-00011#1---mod---begin
   #160825-00018#1--mark--start-- 
   #LET l_i = l_i - 1
   #LET j = j - 1
   #CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #FOR l_i = 1 TO g_detail_d_old.getLength()
   #160825-00018#1--mark--end----
   #160825-00018#1--add--start--
   CALL g_detail_d.clear()
   FOR l_i = 1 TO g_detail_d_old.getLength()
   #160825-00018#1--add--end----  
       LET g_detail_d[l_i].* = g_detail_d_old[l_i].*
   END FOR
   #LET j = j - 1
   #CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #160413-00011#1---mod---end
   LET l_sql = " SELECT DISTINCT * FROM apmp620_tmp WHERE 1=1"
   
   IF g_type = '1' THEN
      LET l_sql = l_sql," ORDER BY pmdl004,xmdc001,xmdd011,xmdadocno,xmddseq,xmddseq1,xmddseq2,xmda004 "
   END IF
   IF g_type = '2' THEN
      LET l_sql = l_sql," ORDER BY pmdl004,xmdadocno,xmddseq,xmddseq1,xmddseq2,xmdc001,xmdd011,xmda004 "
   END IF
   IF g_type = '3' THEN
      LET l_sql = l_sql," ORDER BY pmdl004,xmda004,xmdc001,xmdd011,xmdadocno,xmddseq,xmddseq1,xmddseq2 "
   END IF
   LET l_sql = l_sql, ",xmddseq,xmddseq1,xmddseq2"
   PREPARE apmp620_sel_tmp FROM l_sql
   DECLARE b_fill_curs_tmp CURSOR WITH HOLD FOR apmp620_sel_tmp  
   
   LET l_pmdl004_t = ''
   LET l_xmdadocno_t = ''
   LET l_xmda004_t = ''
   CALL cl_err_collect_init()
   LET g_flag = 'N' 
   LET g_s_pmdldocno = ''
   LET g_s_pmdnseq = ''
   LET g_flag1 = 'N' 
   LET g_flag2 = 'N' 
   LET ls_sql = ''
   INITIALIZE l_pmdl.* TO NULL
   FOREACH b_fill_curs_tmp INTO l_xmdd.sel,l_xmdd.xmdadocno,l_xmdd.xmddseq,l_xmdd.xmddseq1,l_xmdd.xmddseq2,l_xmdd.xmda004,l_xmdd.xmda004_desc,l_xmdd.xmda002,
                                l_xmdd.xmda002_desc,l_xmdd.xmdadocdt,l_xmdd.xmdd011,l_xmdd.xmdc001,l_xmdd.xmdc001_desc,l_xmdd.xmdc001_desc_desc,
                                l_xmdd.xmdc002,l_xmdd.xmdc002_desc,l_xmdd.xmdc006,l_xmdd.xmdc006_desc,l_xmdd.xmdc007,l_xmdd.num,l_xmdd.pmdb006,
                                l_xmdd.pmdl004,l_xmdd.pmdl004_desc,l_xmdd.xmda017,l_xmdd.xmda017_desc,l_xmdd.xmda015,l_xmdd.xmda015_desc,l_xmdd.xmda016,
                                l_xmdd.xmda011,l_xmdd.xmda011_desc,l_xmdd.xmda012,l_xmdd.xmda013,l_xmdd.pmal002,l_pmdl.pmdl009,l_pmdl.pmdl010,l_pmdl.pmdl020,l_pmdl.pmdl021,
                                l_pmdl.pmdl022,l_pmdl.pmdl023,l_pmdl.pmdl024,l_pmdl.pmdl027,l_pmdl.pmdl033,l_pmdl.pmdl054,l_pmdl.pmdl055

      IF l_xmdd.sel = 'N' THEN
         CONTINUE FOREACH
      END IF      
      CALL s_transaction_begin()   
            
      IF g_type = '1' THEN
         IF l_xmdd.pmdl004 <> l_pmdl004_t OR l_pmdl004_t IS NULL THEN
            #add by lixh 20150610
            IF l_xmdd.pmdl004 <> l_pmdl004_t THEN
               IF g_price = 'Y' THEN
                  SELECT pmdl017,pmdl004,pmdl015,pmdl009,pmdl010,pmdl023,pmdl054,pmdn001,pmdn002,pmdn016,pmdn010,pmdn011,pmdn004,pmdn005 
                    INTO l_pmdl017,l_pmdl004,l_pmdl015,l_pmdl009,l_pmdl010,l_pmdl023,l_pmdl054,l_pmdn001,
                         l_pmdn002,l_pmdn016,l_pmdn010,l_pmdn011,l_pmdn004,l_pmdn005 
                    FROM pmdl_t,pmdn_t
                   WHERE pmdlent = pmdnent 
                     AND pmdldocno = pmdndocno
                     AND pmdndocno = g_s_pmdldocno
                     AND pmdnseq = g_s_pmdnseq                     
                  CALL s_apmt500_get_price(l_pmdl017,l_pmdl004,l_pmdn001,l_pmdn002,l_pmdl015,
                          l_pmdn016,l_pmdl009,l_pmdl010,l_pmdl023,g_s_pmdldocno,
                          g_today,l_pmdn010,l_pmdn011,g_site,l_pmdl054,'1',l_pmdn004,l_pmdn005)
                      RETURNING l_pmdn040,l_pmdn043,l_pmdn041,l_pmdn042
                  
                  LET l_pmdn015 = l_pmdn043
                  LET l_pmdn044 = 0
                  IF cl_null(l_pmdn015) THEN
                     LET l_pmdn015 = 0
                     LET l_pmdn043 = 0
                  END IF
                  #重新計算[C:未稅金額]、[C:含稅金額]、[稅額]
                  CALL s_apmt500_get_amount(g_s_pmdldocno,g_s_pmdnseq,l_pmdl015,l_pmdn011,l_pmdn015,l_pmdn016)
                                      RETURNING l_pmdn046,l_pmdn048,l_pmdn047 
                  UPDATE pmdn_t SET pmdn015 = l_pmdn015,
                                    pmdn043 = l_pmdn043,
                                    pmdn046 = l_pmdn046,
                                    pmdn047 = l_pmdn047,
                                    pmdn048 = l_pmdn048
                   WHERE pmdnent = g_enterprise
                     AND pmdndocno = g_s_pmdldocno
                     ANd pmdnseq = g_s_pmdnseq 
               END IF                     
               IF NOT s_apmt500_gen_pmdo(g_s_pmdldocno,g_s_pmdnseq) THEN
                  LET r_success = FALSE 
               ELSE
                  IF g_price = 'Y' THEN                            
                     LET l_n = 0
                     SELECT COUNT(*)  INTO l_n FROM pmdo_t
                      WHERE pmdoent = g_enterprise
                        AND pmdodocno = g_s_pmdldocno
                        AND pmdoseq = g_s_pmdnseq  
                     IF l_n <= 1 THEN
                        UPDATE pmdn_t SET pmdn024 = 'N' WHERE pmdnent = g_enterprise
                                                          AND pmdndocno = g_s_pmdldocno
                                                          ANd pmdnseq = g_s_pmdnseq 
                     END IF
                  END IF                  
               END IF     
            END IF            
            #add by lixh 20150610
            LET l_pmdl004_t = l_xmdd.pmdl004 
            CALL apmp620_ins_pmdl(l_pmdl.*) RETURNING r_success,g_s_pmdldocno
            IF cl_null(ls_sql) THEN
               LET ls_sql = " AND pmdldocno IN ('",g_s_pmdldocno,"'"
            ELSE
               LET ls_sql = ls_sql,",","'",g_s_pmdldocno,"'"        
            END IF                
            IF NOT r_success THEN
               CALL s_transaction_end('N','0')
               CONTINUE FOREACH
            END IF
            LET g_flag = 'Y'             
         END IF                  
      END IF
      
      IF g_type = '2' THEN
         IF (l_xmdd.pmdl004 <> l_pmdl004_t OR l_pmdl004_t IS NULL) OR (l_xmdd.xmdadocno <> l_xmdadocno_t OR l_xmdadocno_t IS NULL) THEN
            #add by lixh 20150610
            IF l_xmdd.pmdl004 <> l_pmdl004_t OR l_xmdd.xmdadocno <> l_xmdadocno_t THEN
               IF g_price = 'Y' THEN
                  SELECT pmdl017,pmdl004,pmdl015,pmdl009,pmdl010,pmdl023,pmdl054,pmdn001,pmdn002,pmdn016,pmdn010,pmdn011,pmdn004,pmdn005 
                    INTO l_pmdl017,l_pmdl004,l_pmdl015,l_pmdl009,l_pmdl010,l_pmdl023,l_pmdl054,l_pmdn001,
                         l_pmdn002,l_pmdn016,l_pmdn010,l_pmdn011,l_pmdn004,l_pmdn005 
                    FROM pmdl_t,pmdn_t
                   WHERE pmdlent = pmdnent 
                     AND pmdldocno = pmdndocno
                     AND pmdndocno = g_s_pmdldocno
                     AND pmdnseq = g_s_pmdnseq                     
                  CALL s_apmt500_get_price(l_pmdl017,l_pmdl004,l_pmdn001,l_pmdn002,l_pmdl015,
                          l_pmdn016,l_pmdl009,l_pmdl010,l_pmdl023,g_s_pmdldocno,
                          g_today,l_pmdn010,l_pmdn011,g_site,l_pmdl054,'1',l_pmdn004,l_pmdn005)
                      RETURNING l_pmdn040,l_pmdn043,l_pmdn041,l_pmdn042
                  
                  LET l_pmdn015 = l_pmdn043
                  LET l_pmdn044 = 0
                  IF cl_null(l_pmdn015) THEN
                     LET l_pmdn015 = 0
                     LET l_pmdn043 = 0
                  END IF
                  #重新計算[C:未稅金額]、[C:含稅金額]、[稅額]
                  CALL s_apmt500_get_amount(g_s_pmdldocno,g_s_pmdnseq,l_pmdl015,l_pmdn011,l_pmdn015,l_pmdn016)
                                      RETURNING l_pmdn046,l_pmdn048,l_pmdn047 
                  UPDATE pmdn_t SET pmdn015 = l_pmdn015,
                                    pmdn043 = l_pmdn043,
                                    pmdn046 = l_pmdn046,
                                    pmdn047 = l_pmdn047,
                                    pmdn048 = l_pmdn048
                   WHERE pmdnent = g_enterprise
                     AND pmdndocno = g_s_pmdldocno
                     ANd pmdnseq = g_s_pmdnseq 
               END IF                     
               IF NOT s_apmt500_gen_pmdo(g_s_pmdldocno,g_s_pmdnseq) THEN
                  LET r_success = FALSE 
               ELSE
                  IF g_price = 'Y' THEN 
                     LET l_n = 0
                     SELECT COUNT(*)  INTO l_n FROM pmdo_t
                      WHERE pmdoent = g_enterprise
                        AND pmdodocno = g_s_pmdldocno
                        AND pmdoseq = g_s_pmdnseq  
                     IF l_n <= 1 THEN
                        UPDATE pmdn_t SET pmdn024 = 'N' WHERE pmdnent = g_enterprise
                                                          AND pmdndocno = g_s_pmdldocno
                                                          ANd pmdnseq = g_s_pmdnseq 
                     END IF 
                  END IF                  
               END IF                    
            END IF            
            #add by lixh 20150610           
            LET l_pmdl004_t = l_xmdd.pmdl004
            LET l_xmdadocno_t = l_xmdd.xmdadocno
            CALL apmp620_ins_pmdl(l_pmdl.*) RETURNING r_success,g_s_pmdldocno
            IF cl_null(ls_sql) THEN
               LET ls_sql = " AND pmdldocno IN ('",g_s_pmdldocno,"'"
            ELSE
               LET ls_sql = ls_sql,",","'",g_s_pmdldocno,"'"        
            END IF              
            IF NOT r_success THEN
               CALL s_transaction_end('N','0')
               CONTINUE FOREACH
            END IF  
            LET g_flag = 'Y'             
         END IF
      END IF
      
      IF g_type = '3' THEN
         IF (l_xmdd.pmdl004 <> l_pmdl004_t OR l_pmdl004_t IS NULL) OR (l_xmdd.xmda004 <> l_xmda004_t OR l_xmda004_t IS NULL) THEN
            #add by lixh 20150610
            IF l_xmdd.pmdl004 <> l_pmdl004_t OR l_xmdd.xmda004 <> l_xmda004_t THEN
               IF g_price = 'Y' THEN
                  SELECT pmdl017,pmdl004,pmdl015,pmdl009,pmdl010,pmdl023,pmdl054,pmdn001,pmdn002,pmdn016,pmdn010,pmdn011,pmdn004,pmdn005 
                    INTO l_pmdl017,l_pmdl004,l_pmdl015,l_pmdl009,l_pmdl010,l_pmdl023,l_pmdl054,l_pmdn001,
                         l_pmdn002,l_pmdn016,l_pmdn010,l_pmdn011,l_pmdn004,l_pmdn005 
                    FROM pmdl_t,pmdn_t
                   WHERE pmdlent = pmdnent 
                     AND pmdldocno = pmdndocno
                     AND pmdndocno = g_s_pmdldocno
                     AND pmdnseq = g_s_pmdnseq                     
                  CALL s_apmt500_get_price(l_pmdl017,l_pmdl004,l_pmdn001,l_pmdn002,l_pmdl015,
                          l_pmdn016,l_pmdl009,l_pmdl010,l_pmdl023,g_s_pmdldocno,
                          g_today,l_pmdn010,l_pmdn011,g_site,l_pmdl054,'1',l_pmdn004,l_pmdn005)
                      RETURNING l_pmdn040,l_pmdn043,l_pmdn041,l_pmdn042
                  
                  LET l_pmdn015 = l_pmdn043
                  LET l_pmdn044 = 0
                  IF cl_null(l_pmdn015) THEN
                     LET l_pmdn015 = 0
                     LET l_pmdn043 = 0
                  END IF
                  #重新計算[C:未稅金額]、[C:含稅金額]、[稅額]
                  CALL s_apmt500_get_amount(g_s_pmdldocno,g_s_pmdnseq,l_pmdl015,l_pmdn011,l_pmdn015,l_pmdn016)
                                      RETURNING l_pmdn046,l_pmdn048,l_pmdn047 
                  UPDATE pmdn_t SET pmdn015 = l_pmdn015,
                                    pmdn043 = l_pmdn043,
                                    pmdn046 = l_pmdn046,
                                    pmdn047 = l_pmdn047,
                                    pmdn048 = l_pmdn048
                   WHERE pmdnent = g_enterprise
                     AND pmdndocno = g_s_pmdldocno
                     ANd pmdnseq = g_s_pmdnseq     
               END IF                        
               IF NOT s_apmt500_gen_pmdo(g_s_pmdldocno,g_s_pmdnseq) THEN
                  LET r_success = FALSE 
               ELSE
                  IF g_price = 'Y' THEN
                     LET l_n = 0
                     SELECT COUNT(*)  INTO l_n FROM pmdo_t
                      WHERE pmdoent = g_enterprise
                        AND pmdodocno = g_s_pmdldocno
                        AND pmdoseq = g_s_pmdnseq  
                     IF l_n <= 1 THEN
                        UPDATE pmdn_t SET pmdn024 = 'N' WHERE pmdnent = g_enterprise
                                                          AND pmdndocno = g_s_pmdldocno
                                                          ANd pmdnseq = g_s_pmdnseq 
                     END IF  
                  END IF                  
               END IF     
            END IF            
            #add by lixh 20150610             
            LET l_pmdl004_t = l_xmdd.pmdl004
            LET l_xmda004_t = l_xmdd.xmda004
            CALL apmp620_ins_pmdl(l_pmdl.*) RETURNING r_success,g_s_pmdldocno
            IF cl_null(ls_sql) THEN
               LET ls_sql = " AND pmdldocno IN ('",g_s_pmdldocno,"'"
            ELSE
               LET ls_sql = ls_sql,",","'",g_s_pmdldocno,"'"        
            END IF              
            IF NOT r_success THEN
               CALL s_transaction_end('N','0')
               CONTINUE FOREACH
            END IF 
            LET g_flag = 'Y'                         
         END IF      
      END IF
      #產生採購單單身     
      IF NOT apmp620_ins_pmdn() THEN
         CALL s_transaction_end('N','0')
         CONTINUE FOREACH
      ELSE
         LET g_flag1 = 'Y'            
      END IF
      CALL s_transaction_end('Y','0')
      LET g_flag2 = 'Y'
   END FOREACH 
   IF NOT cl_null(ls_sql) THEN
      LET ls_sql = ls_sql,")"
   END IF   
   #add by lixh 20150610
   CALL s_transaction_begin()
   IF g_price = 'Y' THEN
      SELECT pmdl017,pmdl004,pmdl015,pmdl009,pmdl010,pmdl023,pmdl054,pmdn001,pmdn002,pmdn016,pmdn010,pmdn011,pmdn004,pmdn005 
        INTO l_pmdl017,l_pmdl004,l_pmdl015,l_pmdl009,l_pmdl010,l_pmdl023,l_pmdl054,l_pmdn001,
             l_pmdn002,l_pmdn016,l_pmdn010,l_pmdn011,l_pmdn004,l_pmdn005 
        FROM pmdl_t,pmdn_t
       WHERE pmdlent = pmdnent 
         AND pmdldocno = pmdndocno
         AND pmdndocno = g_s_pmdldocno
         AND pmdnseq = g_s_pmdnseq                     
      CALL s_apmt500_get_price(l_pmdl017,l_pmdl004,l_pmdn001,l_pmdn002,l_pmdl015,
              l_pmdn016,l_pmdl009,l_pmdl010,l_pmdl023,g_s_pmdldocno,
              g_today,l_pmdn010,l_pmdn011,g_site,l_pmdl054,'1',l_pmdn004,l_pmdn005)
          RETURNING l_pmdn040,l_pmdn043,l_pmdn041,l_pmdn042
      
      LET l_pmdn015 = l_pmdn043
      LET l_pmdn044 = 0
      IF cl_null(l_pmdn015) THEN
         LET l_pmdn015 = 0
         LET l_pmdn043 = 0
      END IF
      #重新計算[C:未稅金額]、[C:含稅金額]、[稅額]
      CALL s_apmt500_get_amount(g_s_pmdldocno,g_s_pmdnseq,l_pmdl015,l_pmdn011,l_pmdn015,l_pmdn016)
                          RETURNING l_pmdn046,l_pmdn048,l_pmdn047 
      UPDATE pmdn_t SET pmdn015 = l_pmdn015,
                        pmdn043 = l_pmdn043,
                        pmdn046 = l_pmdn046,
                        pmdn047 = l_pmdn047,
                        pmdn048 = l_pmdn048
       WHERE pmdnent = g_enterprise
         AND pmdndocno = g_s_pmdldocno
         ANd pmdnseq = g_s_pmdnseq 
   END IF            
   IF NOT s_apmt500_gen_pmdo(g_s_pmdldocno,g_s_pmdnseq) THEN    
      LET r_success = FALSE
      CALL s_transaction_end('N','0')
   ELSE
      IF g_price = 'Y' THEN
         LET l_n = 0
         SELECT COUNT(*)  INTO l_n FROM pmdo_t
          WHERE pmdoent = g_enterprise
            AND pmdodocno = g_s_pmdldocno
            AND pmdoseq = g_s_pmdnseq  
         IF l_n <= 1 THEN
            UPDATE pmdn_t SET pmdn024 = 'N' WHERE pmdnent = g_enterprise
                                              AND pmdndocno = g_s_pmdldocno
                                              ANd pmdnseq = g_s_pmdnseq   
         END IF                                                          
      END IF         
      CALL s_transaction_end('Y','0')   
   END IF   
   #add by lixh 20150610
   LET g_status = 100 
   DISPLAY g_status TO stagecomplete  
   CALL cl_err_collect_show()
   IF g_flag1 = 'Y' AND g_flag2 = 'Y' THEN
      #执行成功    
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00217'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      #add by lixh 20150601
      INITIALIZE la_param.* TO NULL
      LET la_param.prog     = 'apmt500'
      LET la_param.param[1] = ''      
#      LET la_param.param[2] = ''
      LET la_param.param[2] = ls_sql
      LET ls_js = util.JSON.stringify(la_param)
      CALL cl_cmdrun(ls_js)  
      #add by lixh 20150601 
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00218'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()        
   END IF    
END FUNCTION

################################################################################
# Descriptions...: 新增採購單頭資料
# Memo...........:
# Usage..........: CALL apmp620_ins_pmdl(p_pmdl)
#                  RETURNING r_success,g_s_pmdldocno
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp620_ins_pmdl(p_pmdl)
DEFINE   r_success               LIKE type_t.num5
#DEFINE   l_pmdl                  RECORD LIKE pmdl_t.*
#161124-00048#8 mod-S
#DEFINE   p_pmdl                  RECORD LIKE pmdl_t.*
DEFINE p_pmdl RECORD  #採購單頭檔
       pmdlent LIKE pmdl_t.pmdlent, #企业编号
       pmdlsite LIKE pmdl_t.pmdlsite, #营运据点
       pmdlunit LIKE pmdl_t.pmdlunit, #应用组织
       pmdldocno LIKE pmdl_t.pmdldocno, #采购单号
       pmdldocdt LIKE pmdl_t.pmdldocdt, #采购日期
       pmdl001 LIKE pmdl_t.pmdl001, #版次
       pmdl002 LIKE pmdl_t.pmdl002, #采购人员
       pmdl003 LIKE pmdl_t.pmdl003, #采购部门
       pmdl004 LIKE pmdl_t.pmdl004, #供应商编号
       pmdl005 LIKE pmdl_t.pmdl005, #采购性质
       pmdl006 LIKE pmdl_t.pmdl006, #多角性质
       pmdl007 LIKE pmdl_t.pmdl007, #数据源类型
       pmdl008 LIKE pmdl_t.pmdl008, #来源单号
       pmdl009 LIKE pmdl_t.pmdl009, #付款条件
       pmdl010 LIKE pmdl_t.pmdl010, #交易条件
       pmdl011 LIKE pmdl_t.pmdl011, #税种
       pmdl012 LIKE pmdl_t.pmdl012, #税率
       pmdl013 LIKE pmdl_t.pmdl013, #单价含税否
       pmdl015 LIKE pmdl_t.pmdl015, #币种
       pmdl016 LIKE pmdl_t.pmdl016, #汇率
       pmdl017 LIKE pmdl_t.pmdl017, #取价方式
       pmdl018 LIKE pmdl_t.pmdl018, #付款优惠条件
       pmdl019 LIKE pmdl_t.pmdl019, #纳入APS计算
       pmdl020 LIKE pmdl_t.pmdl020, #运送方式
       pmdl021 LIKE pmdl_t.pmdl021, #付款供应商
       pmdl022 LIKE pmdl_t.pmdl022, #送货供应商
       pmdl023 LIKE pmdl_t.pmdl023, #采购分类一
       pmdl024 LIKE pmdl_t.pmdl024, #采购分类二
       pmdl025 LIKE pmdl_t.pmdl025, #送货地址
       pmdl026 LIKE pmdl_t.pmdl026, #账款地址
       pmdl027 LIKE pmdl_t.pmdl027, #供应商连络人
       pmdl028 LIKE pmdl_t.pmdl028, #一次性交易对象识别码
       pmdl029 LIKE pmdl_t.pmdl029, #收货部门
       pmdl030 LIKE pmdl_t.pmdl030, #多角贸易已抛转
       pmdl031 LIKE pmdl_t.pmdl031, #多角序号
       pmdl032 LIKE pmdl_t.pmdl032, #最终客户
       pmdl033 LIKE pmdl_t.pmdl033, #发票类型
       pmdl040 LIKE pmdl_t.pmdl040, #采购总税前金额
       pmdl041 LIKE pmdl_t.pmdl041, #采购总含税金额
       pmdl042 LIKE pmdl_t.pmdl042, #采购总税额
       pmdl043 LIKE pmdl_t.pmdl043, #留置原因
       pmdl044 LIKE pmdl_t.pmdl044, #备注
       pmdl046 LIKE pmdl_t.pmdl046, #预付款发票开立方式
       pmdl047 LIKE pmdl_t.pmdl047, #物流结案
       pmdl048 LIKE pmdl_t.pmdl048, #账流结案
       pmdl049 LIKE pmdl_t.pmdl049, #金流结案
       pmdl050 LIKE pmdl_t.pmdl050, #多角最终站否
       pmdl051 LIKE pmdl_t.pmdl051, #多角流程编号
       pmdl052 LIKE pmdl_t.pmdl052, #最终供应商
       pmdl053 LIKE pmdl_t.pmdl053, #两角目的据点
       pmdl054 LIKE pmdl_t.pmdl054, #内外购
       pmdl055 LIKE pmdl_t.pmdl055, #汇率计算基准
       pmdl200 LIKE pmdl_t.pmdl200, #采购中心
       pmdl201 LIKE pmdl_t.pmdl201, #联络电话
       pmdl202 LIKE pmdl_t.pmdl202, #传真号码
       pmdl203 LIKE pmdl_t.pmdl203, #采购方式
       pmdl204 LIKE pmdl_t.pmdl204, #配送中心
       pmdl900 LIKE pmdl_t.pmdl900, #保留字段str
       pmdl999 LIKE pmdl_t.pmdl999, #保留字段end
       pmdlownid LIKE pmdl_t.pmdlownid, #资料所有者
       pmdlowndp LIKE pmdl_t.pmdlowndp, #资料所有部门
       pmdlcrtid LIKE pmdl_t.pmdlcrtid, #资料录入者
       pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #资料录入部门
       pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #资料创建日
       pmdlmodid LIKE pmdl_t.pmdlmodid, #资料更改者
       pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近更改日
       pmdlcnfid LIKE pmdl_t.pmdlcnfid, #资料审核者
       pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #数据审核日
       pmdlpstid LIKE pmdl_t.pmdlpstid, #资料过账者
       pmdlpstdt LIKE pmdl_t.pmdlpstdt, #资料过账日
       pmdlstus LIKE pmdl_t.pmdlstus, #状态码
       pmdl205 LIKE pmdl_t.pmdl205, #采购最终有效日
       pmdl206 LIKE pmdl_t.pmdl206, #长效期订单否
       pmdl207 LIKE pmdl_t.pmdl207, #所属品类
       pmdl208 LIKE pmdl_t.pmdl208  #电子采购单号
END RECORD
#161124-00048#8 mod-E
DEFINE   l_success               LIKE type_t.num5

   INITIALIZE l_pmdl.* TO NULL
   LET r_success = TRUE
   CALL s_aooi200_gen_docno(g_site,g_pmdldocno,g_today,'apmt500') RETURNING l_success,l_pmdl.pmdldocno
   IF NOT l_success THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = l_pmdl.pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()        
   END IF 
    
   LET l_pmdl.pmdlent = g_enterprise  
   LET l_pmdl.pmdlsite = g_site
   LET l_pmdl.pmdldocdt = g_today 
   LET l_pmdl.pmdl001 = 0
   LET l_pmdl.pmdl002 = g_user
   LET l_pmdl.pmdl003 = g_dept
   LET l_pmdl.pmdl004 = l_xmdd.pmdl004        #供应商
   LET l_pmdl.pmdl005 = '1'
   
   LET l_pmdl.pmdl006 = '1'
   LET l_pmdl.pmdl007 = '3'
   LET l_pmdl.pmdl008 = l_xmdd.xmdadocno        #单号
 
   LET l_pmdl.pmdlstus = "N"
   LET l_pmdl.pmdl019 = "Y"
   LET l_pmdl.pmdl054 = "1"
   LET l_pmdl.pmdl055 = "1"
   LET l_pmdl.pmdl030 = "N"
   LET l_pmdl.pmdl042 = "0"
   LET l_pmdl.pmdl047 = "N"
   LET l_pmdl.pmdl048 = "N"
   LET l_pmdl.pmdl049 = "N"
   LET l_pmdl.pmdl046 = "1"
   LET l_pmdl.pmdl040 = "0"
   LET l_pmdl.pmdl041 = "0"   
   LET l_pmdl.pmdlownid = g_user
   LET l_pmdl.pmdlowndp = g_dept
   LET l_pmdl.pmdlcrtid = g_user
   LET l_pmdl.pmdlcrtdp = g_dept 
   LET l_pmdl.pmdlcrtdt = cl_get_current()
   LET l_pmdl.pmdlmodid = g_user
   LET l_pmdl.pmdlmoddt = cl_get_current()
   LET l_pmdl.pmdlstus = 'N'
   #獲取當前營運據點的出貨地址、帳款地址
   CALL apmp620_get_oofb019(g_site) RETURNING l_pmdl.pmdl025
   CALL apmp620_get_oofb019_5(g_site) RETURNING l_pmdl.pmdl026   
   LET l_pmdl.pmdl011 = l_xmdd.xmda011
   LET l_pmdl.pmdl012 = l_xmdd.xmda012
   LET l_pmdl.pmdl013 = l_xmdd.xmda013
   LET l_pmdl.pmdl015 = l_xmdd.xmda015
   LET l_pmdl.pmdl016 = l_xmdd.xmda016
   LET l_pmdl.pmdl017 = l_xmdd.xmda017
   LET l_pmdl.pmdl009 = p_pmdl.pmdl009
   LET l_pmdl.pmdl010 = p_pmdl.pmdl010
   LET l_pmdl.pmdl020 = p_pmdl.pmdl020
   LET l_pmdl.pmdl021 = p_pmdl.pmdl021
   LET l_pmdl.pmdl022 = p_pmdl.pmdl022
   LET l_pmdl.pmdl023 = p_pmdl.pmdl023
   LET l_pmdl.pmdl024 = p_pmdl.pmdl024
   LET l_pmdl.pmdl027 = p_pmdl.pmdl027
   LET l_pmdl.pmdl033 = p_pmdl.pmdl033
   LET l_pmdl.pmdl054 = p_pmdl.pmdl054
   LET l_pmdl.pmdl055 = p_pmdl.pmdl055
  
   #单据默认栏位值
   LET l_pmdl.pmdldocdt = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdldocdt',l_pmdl.pmdldocdt)
   LET l_pmdl.pmdl001 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl001',l_pmdl.pmdl001)
   LET l_pmdl.pmdl002 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl002',l_pmdl.pmdl002)
   LET l_pmdl.pmdl003 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl003',l_pmdl.pmdl003)
   LET l_pmdl.pmdl004 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl004',l_pmdl.pmdl004)
   LET l_pmdl.pmdl005 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl005',l_pmdl.pmdl005)
   LET l_pmdl.pmdl006 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl006',l_pmdl.pmdl006)
   LET l_pmdl.pmdl007 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl007',l_pmdl.pmdl007)
   LET l_pmdl.pmdl008 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl008',l_pmdl.pmdl008)
   LET l_pmdl.pmdl027 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl027',l_pmdl.pmdl027)
   LET l_pmdl.pmdl009 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl009',l_pmdl.pmdl009)
   LET l_pmdl.pmdl010 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl010',l_pmdl.pmdl010)
   LET l_pmdl.pmdl011 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl011',l_pmdl.pmdl011)
   LET l_pmdl.pmdl012 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl012',l_pmdl.pmdl012)
   LET l_pmdl.pmdl013 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl013',l_pmdl.pmdl013)
   LET l_pmdl.pmdl033 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl033',l_pmdl.pmdl033)
   LET l_pmdl.pmdl015 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl015',l_pmdl.pmdl015)
   LET l_pmdl.pmdl016 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl016',l_pmdl.pmdl016)
   LET l_pmdl.pmdl017 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl017',l_pmdl.pmdl017)
   LET l_pmdl.pmdl018 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl018',l_pmdl.pmdl018)
   LET l_pmdl.pmdl019 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl019',l_pmdl.pmdl019)
   LET l_pmdl.pmdl043 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl043',l_pmdl.pmdl043)
   LET l_pmdl.pmdl044 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl044',l_pmdl.pmdl044)
   LET l_pmdl.pmdl020 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl020',l_pmdl.pmdl020)
   LET l_pmdl.pmdl025 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl025',l_pmdl.pmdl025)
   LET l_pmdl.pmdl026 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl026',l_pmdl.pmdl026)
   LET l_pmdl.pmdl029 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl029',l_pmdl.pmdl029)
   LET l_pmdl.pmdl021 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl021',l_pmdl.pmdl021)
   LET l_pmdl.pmdl022 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl022',l_pmdl.pmdl022)
   LET l_pmdl.pmdl032 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl032',l_pmdl.pmdl032)
   LET l_pmdl.pmdl023 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl023',l_pmdl.pmdl023)
   LET l_pmdl.pmdl024 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl024',l_pmdl.pmdl024)
   LET l_pmdl.pmdl030 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl030',l_pmdl.pmdl030)
   LET l_pmdl.pmdl031 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl031',l_pmdl.pmdl031)
   LET l_pmdl.pmdl028 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl028',l_pmdl.pmdl028)
   LET l_pmdl.pmdl040 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl040',l_pmdl.pmdl040)
   LET l_pmdl.pmdl041 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl041',l_pmdl.pmdl041)
   LET l_pmdl.pmdl042 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl042',l_pmdl.pmdl042)
   LET l_pmdl.pmdl046 = s_aooi200_get_doc_default(g_site,'1',l_pmdl.pmdldocno,'pmdl046',l_pmdl.pmdl046)    
   
   INSERT INTO pmdl_t(pmdlent,pmdlsite,pmdldocno,pmdldocdt,pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,pmdl006,pmdl007,pmdl008,pmdl009,pmdl010,
                      pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,pmdl017,pmdl018,pmdl019,pmdl020,pmdl021,pmdl022,pmdl023,pmdl024,pmdl025,pmdl026,
                      pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,pmdl032,pmdl033,pmdl040,pmdl041,pmdl042,pmdl043,pmdl044,pmdl046,pmdl047,pmdl048,
                      pmdl049,pmdl050,pmdl051,pmdl052,pmdl053,pmdl054,pmdl055,
                      pmdlownid,pmdlowndp,pmdlcrtid,pmdlcrtdp,pmdlcrtdt,pmdlmodid,pmdlmoddt,pmdlcnfid,pmdlcnfdt,pmdlstus)
               VALUES(l_pmdl.pmdlent,l_pmdl.pmdlsite,l_pmdl.pmdldocno,l_pmdl.pmdldocdt,l_pmdl.pmdl001,l_pmdl.pmdl002,l_pmdl.pmdl003,l_pmdl.pmdl004,
                      l_pmdl.pmdl005,l_pmdl.pmdl006,l_pmdl.pmdl007,l_pmdl.pmdl008,l_pmdl.pmdl009,l_pmdl.pmdl010,l_pmdl.pmdl011,l_pmdl.pmdl012,l_pmdl.pmdl013,
                      l_pmdl.pmdl015,l_pmdl.pmdl016,l_pmdl.pmdl017,l_pmdl.pmdl018,l_pmdl.pmdl019,l_pmdl.pmdl020,l_pmdl.pmdl021,l_pmdl.pmdl022,l_pmdl.pmdl023,
                      l_pmdl.pmdl024,l_pmdl.pmdl025,l_pmdl.pmdl026,l_pmdl.pmdl027,l_pmdl.pmdl028,l_pmdl.pmdl029,l_pmdl.pmdl030,l_pmdl.pmdl031,l_pmdl.pmdl032,
                      l_pmdl.pmdl033,l_pmdl.pmdl040,l_pmdl.pmdl041,l_pmdl.pmdl042,l_pmdl.pmdl043,l_pmdl.pmdl044,l_pmdl.pmdl046,l_pmdl.pmdl047,l_pmdl.pmdl048,
                      l_pmdl.pmdl049,l_pmdl.pmdl050,l_pmdl.pmdl051,l_pmdl.pmdl052,l_pmdl.pmdl053,l_pmdl.pmdl054,l_pmdl.pmdl055,
                      l_pmdl.pmdlownid,l_pmdl.pmdlowndp,l_pmdl.pmdlcrtid,l_pmdl.pmdlcrtdp,l_pmdl.pmdlcrtdt,l_pmdl.pmdlmodid,l_pmdl.pmdlmoddt,l_pmdl.pmdlcnfid,
                      l_pmdl.pmdlcnfdt,l_pmdl.pmdlstus) 
                      
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE 
   END IF                   
               
   RETURN r_success,l_pmdl.pmdldocno
END FUNCTION

################################################################################
# Descriptions...: 單身資料
# Memo...........:
# Usage..........: CALL apmp620_ins_pmdn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp620_ins_pmdn()
#DEFINE  l_pmdn            RECORD LIKE pmdn_t.*
#161124-00048#8 mod-S
#DEFINE  l_pmdo            RECORD LIKE pmdo_t.*
#DEFINE  l_pmdq            RECORD LIKE pmdq_t.*
#DEFINE  l_pmdp            RECORD LIKE pmdp_t.*
DEFINE l_pmdo RECORD  #採購交期明細檔
       pmdoent LIKE pmdo_t.pmdoent, #企业编号
       pmdosite LIKE pmdo_t.pmdosite, #营运据点
       pmdodocno LIKE pmdo_t.pmdodocno, #采购单号
       pmdoseq LIKE pmdo_t.pmdoseq, #采购项次
       pmdoseq1 LIKE pmdo_t.pmdoseq1, #项序
       pmdoseq2 LIKE pmdo_t.pmdoseq2, #分批序
       pmdo001 LIKE pmdo_t.pmdo001, #料件编号
       pmdo002 LIKE pmdo_t.pmdo002, #产品特征
       pmdo003 LIKE pmdo_t.pmdo003, #子件特性
       pmdo004 LIKE pmdo_t.pmdo004, #采购单位
       pmdo005 LIKE pmdo_t.pmdo005, #采购总数量
       pmdo006 LIKE pmdo_t.pmdo006, #分批采购数量
       pmdo007 LIKE pmdo_t.pmdo007, #折合主件数量
       pmdo008 LIKE pmdo_t.pmdo008, #QPA
       pmdo009 LIKE pmdo_t.pmdo009, #交期类型
       pmdo010 LIKE pmdo_t.pmdo010, #收货时段
       pmdo011 LIKE pmdo_t.pmdo011, #出货日期
       pmdo012 LIKE pmdo_t.pmdo012, #到厂日期
       pmdo013 LIKE pmdo_t.pmdo013, #到库日期
       pmdo014 LIKE pmdo_t.pmdo014, #MRP交期冻结
       pmdo015 LIKE pmdo_t.pmdo015, #已收货量
       pmdo016 LIKE pmdo_t.pmdo016, #验退量
       pmdo017 LIKE pmdo_t.pmdo017, #仓退换货量
       pmdo019 LIKE pmdo_t.pmdo019, #已入库量
       pmdo020 LIKE pmdo_t.pmdo020, #VMI请款量
       pmdo021 LIKE pmdo_t.pmdo021, #交货状态
       pmdo022 LIKE pmdo_t.pmdo022, #参考价格
       pmdo023 LIKE pmdo_t.pmdo023, #税种
       pmdo024 LIKE pmdo_t.pmdo024, #税率
       pmdo025 LIKE pmdo_t.pmdo025, #电子采购单号
       pmdo026 LIKE pmdo_t.pmdo026, #最近更改人员
       pmdo027 LIKE pmdo_t.pmdo027, #最近更改时间
       pmdo028 LIKE pmdo_t.pmdo028, #分批参考单位
       pmdo029 LIKE pmdo_t.pmdo029, #分批参考数量
       pmdo030 LIKE pmdo_t.pmdo030, #分批计价单位
       pmdo031 LIKE pmdo_t.pmdo031, #分批计价数量
       pmdo032 LIKE pmdo_t.pmdo032, #分批税前金额
       pmdo033 LIKE pmdo_t.pmdo033, #分批含税金额
       pmdo034 LIKE pmdo_t.pmdo034, #分批税额
       pmdo035 LIKE pmdo_t.pmdo035, #初始营运据点
       pmdo036 LIKE pmdo_t.pmdo036, #初始来源单号
       pmdo037 LIKE pmdo_t.pmdo037, #初始来源项次
       pmdo038 LIKE pmdo_t.pmdo038, #初始项序
       pmdo039 LIKE pmdo_t.pmdo039, #初始分批序
       pmdo040 LIKE pmdo_t.pmdo040, #仓退量
       pmdo200 LIKE pmdo_t.pmdo200, #分批包装单位
       pmdo201 LIKE pmdo_t.pmdo201, #分批包装数量
       pmdo900 LIKE pmdo_t.pmdo900, #保留字段str
       pmdo999 LIKE pmdo_t.pmdo999, #保留字段end
       pmdo041 LIKE pmdo_t.pmdo041, #还料数量
       pmdo042 LIKE pmdo_t.pmdo042, #还量参考数量
       pmdo043 LIKE pmdo_t.pmdo043, #还价数量
       pmdo044 LIKE pmdo_t.pmdo044  #还价参考数量
END RECORD
DEFINE l_pmdq RECORD  #採購多交期匯總檔
       pmdqent LIKE pmdq_t.pmdqent, #企业编号
       pmdqsite LIKE pmdq_t.pmdqsite, #营运据点
       pmdqdocno LIKE pmdq_t.pmdqdocno, #采购单号
       pmdqseq LIKE pmdq_t.pmdqseq, #采购项次
       pmdqseq2 LIKE pmdq_t.pmdqseq2, #分批序
       pmdq002 LIKE pmdq_t.pmdq002, #分批数量
       pmdq003 LIKE pmdq_t.pmdq003, #交货日期
       pmdq004 LIKE pmdq_t.pmdq004, #到厂日期
       pmdq005 LIKE pmdq_t.pmdq005, #到库日期
       pmdq006 LIKE pmdq_t.pmdq006, #收货时段
       pmdq007 LIKE pmdq_t.pmdq007, #MRP冻结否
       pmdq008 LIKE pmdq_t.pmdq008, #交期类型
       pmdq201 LIKE pmdq_t.pmdq201, #分批包装单位
       pmdq202 LIKE pmdq_t.pmdq202, #分批包装数量
       pmdq900 LIKE pmdq_t.pmdq900, #保留字段str
       pmdq999 LIKE pmdq_t.pmdq999  #保留字段end
END RECORD
DEFINE l_pmdp RECORD  #採購關聯單據明細檔
       pmdpent LIKE pmdp_t.pmdpent, #企业编号
       pmdpsite LIKE pmdp_t.pmdpsite, #营运据点
       pmdpdocno LIKE pmdp_t.pmdpdocno, #采购单号
       pmdpseq LIKE pmdp_t.pmdpseq, #采购项次
       pmdpseq1 LIKE pmdp_t.pmdpseq1, #项序
       pmdp001 LIKE pmdp_t.pmdp001, #料件编号
       pmdp002 LIKE pmdp_t.pmdp002, #产品特征
       pmdp003 LIKE pmdp_t.pmdp003, #来源单号
       pmdp004 LIKE pmdp_t.pmdp004, #来源项次
       pmdp005 LIKE pmdp_t.pmdp005, #来源项序
       pmdp006 LIKE pmdp_t.pmdp006, #来源分批序
       pmdp007 LIKE pmdp_t.pmdp007, #来源料号
       pmdp008 LIKE pmdp_t.pmdp008, #来源产品特征
       pmdp009 LIKE pmdp_t.pmdp009, #来源作业编号
       pmdp010 LIKE pmdp_t.pmdp010, #来源作业序
       pmdp011 LIKE pmdp_t.pmdp011, #来源BOM特性
       pmdp012 LIKE pmdp_t.pmdp012, #来源生产控制组
       pmdp021 LIKE pmdp_t.pmdp021, #冲销顺序
       pmdp022 LIKE pmdp_t.pmdp022, #需求单位
       pmdp023 LIKE pmdp_t.pmdp023, #需求数量
       pmdp024 LIKE pmdp_t.pmdp024, #折合采购量
       pmdp025 LIKE pmdp_t.pmdp025, #已收货量
       pmdp026 LIKE pmdp_t.pmdp026, #已入库量
       pmdp900 LIKE pmdp_t.pmdp900, #保留字段str
       pmdp999 LIKE pmdp_t.pmdp999  #保留字段end
END RECORD
#161124-00048#8 mod-E
DEFINE  l_time            DATETIME YEAR TO SECOND
#DEFINE  l_xmdc001_t       LIKE xmdc_t.xmdc001
#DEFINE  l_xmdadocno       LIKE xmda_t.xmdadocno
#DEFINE  l_xmddseq         LIKE xmdd_t.xmddseq
#DEFINE  l_xmdadocno_t     LIKE xmda_t.xmdadocno
#DEFINE  l_xmddseq_t       LIKE xmdd_t.xmddseq
DEFINE  r_success    LIKE type_t.num5
DEFINE  l_pmdn007    LIKE pmdn_t.pmdn007
DEFINE  l_imaf173    LIKE imaf_t.imaf173
DEFINE  l_imaf174    LIKE imaf_t.imaf174
DEFINE  l_ooef008    LIKE ooef_t.ooef008
DEFINE  l_ooef009    LIKE ooef_t.ooef009
DEFINE   l_pmdl017    LIKE pmdl_t.pmdl017
DEFINE   l_pmdl004    LIKE pmdl_t.pmdl004
DEFINE   l_pmdl015    LIKE pmdl_t.pmdl015
DEFINE   l_pmdl009    LIKE pmdl_t.pmdl009
DEFINE   l_pmdl010    LIKE pmdl_t.pmdl010
DEFINE   l_pmdl023    LIKE pmdl_t.pmdl023
DEFINE   l_pmdl054    LIKE pmdl_t.pmdl054
DEFINE   l_pmdn001    LIKE pmdn_t.pmdn001
DEFINE   l_pmdn002    LIKE pmdn_t.pmdn002
DEFINE   l_pmdn016    LIKE pmdn_t.pmdn016
DEFINE   l_pmdn010    LIKE pmdn_t.pmdn010
DEFINE   l_pmdn011    LIKE pmdn_t.pmdn011
DEFINE   l_pmdn004    LIKE pmdn_t.pmdn004
DEFINE   l_pmdn005    LIKE pmdn_t.pmdn005
DEFINE   l_pmdn040    LIKE pmdn_t.pmdn040
DEFINE   l_pmdn041    LIKE pmdn_t.pmdn041
DEFINE   l_pmdn042    LIKE pmdn_t.pmdn042
DEFINE   l_pmdn043    LIKE pmdn_t.pmdn043
DEFINE   l_pmdn046    LIKE pmdn_t.pmdn046
DEFINE   l_pmdn047    LIKE pmdn_t.pmdn047
DEFINE   l_pmdn048    LIKE pmdn_t.pmdn048
DEFINE   l_pmdn015    LIKE pmdn_t.pmdn015
DEFINE   l_pmdn044    LIKE pmdn_t.pmdn044
DEFINE   l_n          LIKE type_t.num10

      IF g_flag = 'Y' THEN
#         LET l_xmdadocno_t = ''
#         LET l_xmddseq_t = ''
         LET l_xmdc001_t = ''
      END IF
      IF g_price = 'Y' AND (g_flag = 'Y' OR (l_xmdd.xmdc001 <> l_xmdc001_t OR l_xmdc001_t IS NULL))  THEN
         INITIALIZE l_pmdn.* TO NULL      
      END IF      
      LET l_pmdn.pmdn009 = "0"
      LET l_pmdn.pmdn024 = "N"
      LET l_pmdn.pmdn045 = "1"
      LET l_pmdn.pmdn011 = "0"
      LET l_pmdn.pmdn015 = "0"
      LET l_pmdn.pmdn046 = "0"
      LET l_pmdn.pmdn047 = "0"
      LET l_pmdn.pmdn048 = "0"
      LET l_pmdn.pmdn019 = "1"
      LET l_pmdn.pmdn020 = "1"
      LET l_pmdn.pmdn052 = "N"
      LET l_pmdn.pmdn021 = "N"
      LET l_pmdn.pmdn022 = "Y"
      LET l_pmdn.pmdn054 = "0"
      LET l_pmdn.pmdn055 = "0"
      LET l_pmdn.pmdn056 = "0"
      LET l_pmdn.pmdn057 = "0"
      LET l_pmdn.pmdn032 = '1'
      LET l_pmdn.pmdn035 = '1'
      LET l_pmdn.pmdn040 = "1"
      LET l_pmdn.pmdn043 = "0" 
      LET l_pmdn.pmdnunit = g_site
      LET l_pmdn.pmdnorga = g_site
      LET l_pmdn.pmdndocno = g_s_pmdldocno
      LET l_pmdn.pmdnsite = g_site
#      LET l_pmdn.pmdn041 = l_xmdd.xmdadocno
#      LET l_pmdn.pmdn042 = l_xmdd.xmddseq
      LET l_pmdn.pmdn001 = l_xmdd.xmdc001
      LET l_pmdn.pmdn002 = l_xmdd.xmdc002
      SELECT imaf143,imaf144,imaf015 INTO l_pmdn.pmdn006,l_pmdn.pmdn010,l_pmdn.pmdn008 FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = l_xmdd.xmdc001
         
      CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_xmdd.xmdc006,l_pmdn.pmdn006,l_xmdd.pmdb006) 
           RETURNING r_success,l_pmdn.pmdn007
            
      CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_xmdd.xmdc006,l_pmdn.pmdn008,l_xmdd.pmdb006) 
           RETURNING r_success,l_pmdn.pmdn009   
      LET l_pmdn.pmdn010 = l_pmdn.pmdn006
      LET l_pmdn.pmdn011 = l_pmdn.pmdn007      
#      CALL apmp620_get_qcap006()      
      IF g_price = 'Y' THEN
         LET l_pmdn.pmdn024 = 'Y'   #多交期
      END IF
#      IF g_price = 'N' THEN
#         LET l_pmdn.pmdn012 = l_xmdd.xmdd011
#         LET l_pmdn.pmdn013 = l_xmdd.xmdd011
#         LET l_pmdn.pmdn014 = l_xmdd.xmdd011 
#      ELSE
#         IF g_flag = 'Y' THEN
#            LET l_pmdn.pmdn012 = l_xmdd.xmdd011
#            LET l_pmdn.pmdn013 = l_xmdd.xmdd011
#            LET l_pmdn.pmdn014 = l_xmdd.xmdd011          
#         END IF
#      END IF     
      LET l_pmdn.pmdn012 = l_xmdd.xmdd011
      LET l_pmdo.pmdoseq1 = 1 
      IF g_price = 'N' THEN  #不匯總取價
         SELECT MAX(pmdnseq)+1 INTO l_pmdn.pmdnseq FROM pmdn_t
          WHERE pmdnent = g_enterprise
            AND pmdnsite = g_site
            AND pmdndocno = g_s_pmdldocno
         IF cl_null(l_pmdn.pmdnseq) THEN   
            LET l_pmdn.pmdnseq = 1           
         END IF    
         LET g_s_pmdnseq = l_pmdn.pmdnseq    #add by lixh 20150610
         LET l_pmdn.pmdn041 = l_xmdd.xmdadocno
         LET l_pmdn.pmdn042 = l_xmdd.xmddseq  
         LET l_pmdn.pmdn054 = 0
         LET l_pmdn.pmdn055 = 0
         LET l_pmdn.pmdn056 = 0
         LET l_pmdn.pmdn057 = 0         
         CALL apmp620_pmdn001_desc()         #add by lixh 20150610   

         CALL s_apmt500_get_price(l_pmdl.pmdl017,l_pmdl.pmdl004,l_pmdn.pmdn001,l_pmdn.pmdn002,l_pmdl.pmdl015,
                 l_pmdn.pmdn016,l_pmdl.pmdl009,l_pmdl.pmdl010,l_pmdl.pmdl023,l_pmdl.pmdldocno,
                 l_pmdl.pmdldocdt,l_pmdn.pmdn010,l_pmdn.pmdn011,g_site,l_pmdl.pmdl054,'1',l_pmdn.pmdn004,l_pmdn.pmdn005)
             RETURNING l_pmdn.pmdn040,l_pmdn.pmdn043,l_pmdn.pmdn041,l_pmdn.pmdn042
         
         LET l_pmdn.pmdn015 = l_pmdn.pmdn043
         LET l_pmdn.pmdn044 = 0
         IF cl_null(l_pmdn.pmdn015) THEN
            LET l_pmdn.pmdn015 = 0
            LET l_pmdn.pmdn043 = 0
         END IF
         #重新計算[C:未稅金額]、[C:含稅金額]、[稅額]
         CALL s_apmt500_get_amount(l_pmdl.pmdldocno,l_pmdn.pmdnseq,l_pmdl.pmdl015,l_pmdn.pmdn011,l_pmdn.pmdn015,l_pmdn.pmdn016)
                             RETURNING l_pmdn.pmdn046,l_pmdn.pmdn048,l_pmdn.pmdn047   
         LET l_imaf173 = 0
         LET l_imaf174 = 0
         
         SELECT imaf173,imaf174 INTO l_imaf173,l_imaf174
           FROM imaf_t 
           WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdn.pmdn001
         
         #1.輸入交貨日期後需自動計算到廠日期，公式為交貨日期+[T:料件據點進銷存檔].[C:到廠前置時間]
         #2.輸入交貨日期後需自動計算到庫日期，公式為到廠日期+[T:料件據點進銷存檔].[C:到庫前置時間]
         #根据当前营运据点g_site抓取aooi120中设置的行事历参照表号
         SELECT ooef008,ooef009 INTO l_ooef008,l_ooef009 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001=g_site
         
         IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
            CALL s_date_get_work_date(g_site,l_ooef008,l_ooef009,l_pmdn.pmdn012,0,l_imaf173) RETURNING l_pmdn.pmdn013
         ELSE
            LET l_pmdn.pmdn013 = l_pmdn.pmdn012
         END IF
         IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
            CALL s_date_get_work_date(g_site,l_ooef008,l_ooef009,l_pmdn.pmdn013,0,l_imaf174) RETURNING l_pmdn.pmdn014
         ELSE
            LET l_pmdn.pmdn014 = l_pmdn.pmdn013
         END IF                             
         INSERT INTO pmdn_t (pmdnent,pmdnsite,pmdnunit,pmdndocno,pmdnseq,pmdn001,pmdn002,pmdn003,pmdn004,pmdn005,pmdn006,pmdn007,pmdn008,
                              pmdn009,pmdn010,pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,pmdn022,pmdnorga,
                              pmdn023,pmdn024,pmdn025,pmdn026,pmdn027,pmdn028,pmdn029,pmdn030,pmdn031,pmdn032,pmdn033,pmdn034,pmdn035,pmdn036,
                              pmdn037,pmdn038,pmdn039,pmdn040,pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,pmdn046,pmdn047,pmdn048,pmdn049,pmdn050,
                              pmdn051,pmdn052,pmdn053,pmdn054,pmdn055,pmdn056,pmdn057)
                      VALUES (g_enterprise,l_pmdn.pmdnsite,l_pmdn.pmdnunit,l_pmdn.pmdndocno,l_pmdn.pmdnseq,l_pmdn.pmdn001,l_pmdn.pmdn002,l_pmdn.pmdn003,
                              l_pmdn.pmdn004,l_pmdn.pmdn005,l_pmdn.pmdn006,l_pmdn.pmdn007,l_pmdn.pmdn008,l_pmdn.pmdn009,l_pmdn.pmdn010,l_pmdn.pmdn011,
                              l_pmdn.pmdn012,l_pmdn.pmdn013,l_pmdn.pmdn014,l_pmdn.pmdn015,l_pmdn.pmdn016,l_pmdn.pmdn017,l_pmdn.pmdn019,l_pmdn.pmdn020,
                              l_pmdn.pmdn021,l_pmdn.pmdn022,l_pmdn.pmdnorga,l_pmdn.pmdn023,l_pmdn.pmdn024,l_pmdn.pmdn025,l_pmdn.pmdn026,l_pmdn.pmdn027,
                              l_pmdn.pmdn028,l_pmdn.pmdn029,l_pmdn.pmdn030,l_pmdn.pmdn031,l_pmdn.pmdn032,l_pmdn.pmdn033,l_pmdn.pmdn034,l_pmdn.pmdn035,
                              l_pmdn.pmdn036,l_pmdn.pmdn037,l_pmdn.pmdn038,l_pmdn.pmdn039,l_pmdn.pmdn040,l_pmdn.pmdn041,l_pmdn.pmdn042,l_pmdn.pmdn043,
                              l_pmdn.pmdn044,l_pmdn.pmdn045,l_pmdn.pmdn046,l_pmdn.pmdn047,l_pmdn.pmdn048,l_pmdn.pmdn049,l_pmdn.pmdn050,l_pmdn.pmdn051,
                              l_pmdn.pmdn052,l_pmdn.pmdn053,l_pmdn.pmdn054,l_pmdn.pmdn055,l_pmdn.pmdn056,l_pmdn.pmdn057)
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE 
         END IF  
         IF g_price = 'Y' THEN
            SELECT pmdl017,pmdl004,pmdl015,pmdl009,pmdl010,pmdl023,pmdl054,pmdn001,pmdn002,pmdn016,pmdn010,pmdn011,pmdn004,pmdn005 
              INTO l_pmdl017,l_pmdl004,l_pmdl015,l_pmdl009,l_pmdl010,l_pmdl023,l_pmdl054,l_pmdn001,
                   l_pmdn002,l_pmdn016,l_pmdn010,l_pmdn011,l_pmdn004,l_pmdn005 
              FROM pmdl_t,pmdn_t
             WHERE pmdlent = pmdnent 
               AND pmdldocno = pmdndocno
               AND pmdndocno = g_s_pmdldocno
               AND pmdnseq = g_s_pmdnseq                     
            CALL s_apmt500_get_price(l_pmdl017,l_pmdl004,l_pmdn001,l_pmdn002,l_pmdl015,
                    l_pmdn016,l_pmdl009,l_pmdl010,l_pmdl023,g_s_pmdldocno,
                    g_today,l_pmdn010,l_pmdn011,g_site,l_pmdl054,'1',l_pmdn004,l_pmdn005)
                RETURNING l_pmdn040,l_pmdn043,l_pmdn041,l_pmdn042
            
            LET l_pmdn015 = l_pmdn043
            LET l_pmdn044 = 0
            IF cl_null(l_pmdn015) THEN
               LET l_pmdn015 = 0
               LET l_pmdn043 = 0
            END IF
            #重新計算[C:未稅金額]、[C:含稅金額]、[稅額]
            CALL s_apmt500_get_amount(g_s_pmdldocno,g_s_pmdnseq,l_pmdl015,l_pmdn011,l_pmdn015,l_pmdn016)
                                RETURNING l_pmdn046,l_pmdn048,l_pmdn047 
            UPDATE pmdn_t SET pmdn015 = l_pmdn015,
                              pmdn043 = l_pmdn043,
                              pmdn046 = l_pmdn046,
                              pmdn047 = l_pmdn047,
                              pmdn048 = l_pmdn048
             WHERE pmdnent = g_enterprise
               AND pmdndocno = g_s_pmdldocno
               ANd pmdnseq = g_s_pmdnseq     
         END IF                  
         IF NOT s_apmt500_gen_pmdo(g_s_pmdldocno,g_s_pmdnseq) THEN
            LET r_success = FALSE
         ELSE
            IF g_price = 'Y' THEN
               LET l_n = 0
               SELECT COUNT(*)  INTO l_n FROM pmdo_t
                WHERE pmdoent = g_enterprise
                  AND pmdodocno = g_s_pmdldocno
                  AND pmdoseq = g_s_pmdnseq  
               IF l_n <= 1 THEN
                  UPDATE pmdn_t SET pmdn024 = 'N' WHERE pmdnent = g_enterprise
                                                                AND pmdndocno = g_s_pmdldocno
                                                                ANd pmdnseq = g_s_pmdnseq   
               END IF                    
            END IF 
         END IF         
         LET l_pmdo.pmdodocno = l_pmdn.pmdndocno
         LET l_pmdo.pmdoseq = l_pmdn.pmdnseq
         LET l_pmdo.pmdoseq1 = 1 
         LET l_pmdo.pmdoseq2 = 1          
      ELSE
         #匯總取價         
         IF g_flag = 'Y' OR (l_xmdd.xmdc001 <> l_xmdc001_t OR l_xmdc001_t IS NULL) THEN
            #add by lixh 20150610
            IF l_xmdd.xmdc001 <> l_xmdc001_t THEN
               IF g_price = 'Y' THEN
                  SELECT pmdl017,pmdl004,pmdl015,pmdl009,pmdl010,pmdl023,pmdl054,pmdn001,pmdn002,pmdn016,pmdn010,pmdn011,pmdn004,pmdn005 
                    INTO l_pmdl017,l_pmdl004,l_pmdl015,l_pmdl009,l_pmdl010,l_pmdl023,l_pmdl054,l_pmdn001,
                         l_pmdn002,l_pmdn016,l_pmdn010,l_pmdn011,l_pmdn004,l_pmdn005 
                    FROM pmdl_t,pmdn_t
                   WHERE pmdlent = pmdnent 
                     AND pmdldocno = pmdndocno
                     AND pmdndocno = g_s_pmdldocno
                     AND pmdnseq = g_s_pmdnseq                     
                  CALL s_apmt500_get_price(l_pmdl017,l_pmdl004,l_pmdn001,l_pmdn002,l_pmdl015,
                          l_pmdn016,l_pmdl009,l_pmdl010,l_pmdl023,g_s_pmdldocno,
                          g_today,l_pmdn010,l_pmdn011,g_site,l_pmdl054,'1',l_pmdn004,l_pmdn005)
                      RETURNING l_pmdn040,l_pmdn043,l_pmdn041,l_pmdn042
                  
                  LET l_pmdn015 = l_pmdn043
                  LET l_pmdn044 = 0
                  IF cl_null(l_pmdn015) THEN
                     LET l_pmdn015 = 0
                     LET l_pmdn043 = 0
                  END IF
                  #重新計算[C:未稅金額]、[C:含稅金額]、[稅額]
                  CALL s_apmt500_get_amount(g_s_pmdldocno,g_s_pmdnseq,l_pmdl015,l_pmdn011,l_pmdn015,l_pmdn016)
                                      RETURNING l_pmdn046,l_pmdn048,l_pmdn047 
                  UPDATE pmdn_t SET pmdn015 = l_pmdn015,
                                    pmdn043 = l_pmdn043,
                                    pmdn046 = l_pmdn046,
                                    pmdn047 = l_pmdn047,
                                    pmdn048 = l_pmdn048
                   WHERE pmdnent = g_enterprise
                     AND pmdndocno = g_s_pmdldocno
                     ANd pmdnseq = g_s_pmdnseq  
               END IF                        
               IF NOT s_apmt500_gen_pmdo(g_s_pmdldocno,g_s_pmdnseq) THEN
                  LET r_success = FALSE 
               ELSE
                  IF g_price = 'Y' THEN
                     LET l_n = 0
                     SELECT COUNT(*)  INTO l_n FROM pmdo_t
                      WHERE pmdoent = g_enterprise
                        AND pmdodocno = g_s_pmdldocno
                        AND pmdoseq = g_s_pmdnseq  
                     IF l_n <= 1 THEN
                        UPDATE pmdn_t SET pmdn024 = 'N' WHERE pmdnent = g_enterprise
                                                                      AND pmdndocno = g_s_pmdldocno
                                                                      ANd pmdnseq = g_s_pmdnseq   
                     END IF                          
                  END IF
               END IF
            END IF
            #add by lixh 20150610
            LET l_xmdc001_t = l_xmdd.xmdc001
            SELECT MAX(pmdnseq)+1 INTO l_pmdn.pmdnseq FROM pmdn_t
             WHERE pmdnent = g_enterprise
               AND pmdnsite = g_site
               AND pmdndocno = g_s_pmdldocno
            IF cl_null(l_pmdn.pmdnseq) THEN   
               LET l_pmdn.pmdnseq = 1
            END IF
            LET g_s_pmdnseq = l_pmdn.pmdnseq    #add by lixh 20150610
#            LET l_xmdadocno_t = l_xmdd.xmdadocno
#            LET l_xmddseq_t = l_xmdd.xmddseq
         LET l_pmdn.pmdn041 = l_xmdd.xmdadocno
         LET l_pmdn.pmdn042 = l_xmdd.xmddseq  
         LET l_pmdn.pmdn054 = 0
         LET l_pmdn.pmdn055 = 0
         LET l_pmdn.pmdn056 = 0
         LET l_pmdn.pmdn057 = 0         
         CALL apmp620_pmdn001_desc()         #add by lixh 20150610   

         CALL s_apmt500_get_price(l_pmdl.pmdl017,l_pmdl.pmdl004,l_pmdn.pmdn001,l_pmdn.pmdn002,l_pmdl.pmdl015,
                 l_pmdn.pmdn016,l_pmdl.pmdl009,l_pmdl.pmdl010,l_pmdl.pmdl023,l_pmdl.pmdldocno,
                 l_pmdl.pmdldocdt,l_pmdn.pmdn010,l_pmdn.pmdn011,g_site,l_pmdl.pmdl054,'1',l_pmdn.pmdn004,l_pmdn.pmdn005)
             RETURNING l_pmdn.pmdn040,l_pmdn.pmdn043,l_pmdn.pmdn041,l_pmdn.pmdn042
         
         LET l_pmdn.pmdn015 = l_pmdn.pmdn043
         LET l_pmdn.pmdn044 = 0
         
         #重新計算[C:未稅金額]、[C:含稅金額]、[稅額]
         CALL s_apmt500_get_amount(l_pmdl.pmdldocno,l_pmdn.pmdnseq,l_pmdl.pmdl015,l_pmdn.pmdn011,l_pmdn.pmdn015,l_pmdn.pmdn016)
                             RETURNING l_pmdn.pmdn046,l_pmdn.pmdn048,l_pmdn.pmdn047   
         LET l_imaf173 = 0
         LET l_imaf174 = 0
         
         SELECT imaf173,imaf174 INTO l_imaf173,l_imaf174
           FROM imaf_t 
           WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdn.pmdn001
         
         #1.輸入交貨日期後需自動計算到廠日期，公式為交貨日期+[T:料件據點進銷存檔].[C:到廠前置時間]
         #2.輸入交貨日期後需自動計算到庫日期，公式為到廠日期+[T:料件據點進銷存檔].[C:到庫前置時間]
         #根据当前营运据点g_site抓取aooi120中设置的行事历参照表号
         SELECT ooef008,ooef009 INTO l_ooef008,l_ooef009 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001=g_site
         
         IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
            CALL s_date_get_work_date(g_site,l_ooef008,l_ooef009,l_pmdn.pmdn012,0,l_imaf173) RETURNING l_pmdn.pmdn013
         ELSE
            LET l_pmdn.pmdn013 = l_pmdn.pmdn012
         END IF
         IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
            CALL s_date_get_work_date(g_site,l_ooef008,l_ooef009,l_pmdn.pmdn013,0,l_imaf174) RETURNING l_pmdn.pmdn014
         ELSE
            LET l_pmdn.pmdn014 = l_pmdn.pmdn013
         END IF   
            INSERT INTO pmdn_t (pmdnent,pmdnsite,pmdnunit,pmdndocno,pmdnseq,pmdn001,pmdn002,pmdn003,pmdn004,pmdn005,pmdn006,pmdn007,pmdn008,
                                pmdn009,pmdn010,pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,pmdn022,pmdnorga,
                                pmdn023,pmdn024,pmdn025,pmdn026,pmdn027,pmdn028,pmdn029,pmdn030,pmdn031,pmdn032,pmdn033,pmdn034,pmdn035,pmdn036,
                                pmdn037,pmdn038,pmdn039,pmdn040,pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,pmdn046,pmdn047,pmdn048,pmdn049,pmdn050,
                                pmdn051,pmdn052,pmdn053)
                        VALUES (g_enterprise,l_pmdn.pmdnsite,l_pmdn.pmdnunit,l_pmdn.pmdndocno,l_pmdn.pmdnseq,l_pmdn.pmdn001,l_pmdn.pmdn002,l_pmdn.pmdn003,
                                l_pmdn.pmdn004,l_pmdn.pmdn005,l_pmdn.pmdn006,l_pmdn.pmdn007,l_pmdn.pmdn008,l_pmdn.pmdn009,l_pmdn.pmdn010,l_pmdn.pmdn011,
                                l_pmdn.pmdn012,l_pmdn.pmdn013,l_pmdn.pmdn014,l_pmdn.pmdn015,l_pmdn.pmdn016,l_pmdn.pmdn017,l_pmdn.pmdn019,l_pmdn.pmdn020,
                                l_pmdn.pmdn021,l_pmdn.pmdn022,l_pmdn.pmdnorga,l_pmdn.pmdn023,l_pmdn.pmdn024,l_pmdn.pmdn025,l_pmdn.pmdn026,l_pmdn.pmdn027,
                                l_pmdn.pmdn028,l_pmdn.pmdn029,l_pmdn.pmdn030,l_pmdn.pmdn031,l_pmdn.pmdn032,l_pmdn.pmdn033,l_pmdn.pmdn034,l_pmdn.pmdn035,
                                l_pmdn.pmdn036,l_pmdn.pmdn037,l_pmdn.pmdn038,l_pmdn.pmdn039,l_pmdn.pmdn040,l_pmdn.pmdn041,l_pmdn.pmdn042,l_pmdn.pmdn043,
                                l_pmdn.pmdn044,l_pmdn.pmdn045,l_pmdn.pmdn046,l_pmdn.pmdn047,l_pmdn.pmdn048,l_pmdn.pmdn049,l_pmdn.pmdn050,l_pmdn.pmdn051,
                                l_pmdn.pmdn052,l_pmdn.pmdn053)
           IF SQLCA.sqlcode THEN
              LET r_success = FALSE 
           END IF     
           LET l_pmdo.pmdodocno = l_pmdn.pmdndocno
           LET l_pmdo.pmdoseq = l_pmdn.pmdnseq
           LET l_pmdo.pmdoseq1 = 1
           LET l_pmdo.pmdoseq2 = 1
           LET l_pmdo.pmdo035 = g_site
           LET l_pmdo.pmdo036 = l_xmdd.xmdadocno
           LET l_pmdo.pmdo037 = l_xmdd.xmddseq
           LET l_pmdo.pmdo038 = l_xmdd.xmddseq1
           LET l_pmdo.pmdo039 = l_xmdd.xmddseq2
           #add by lixh 20150610
           LET l_pmdq.pmdqdocno = l_pmdn.pmdndocno
           LET l_pmdq.pmdqseq = l_pmdn.pmdnseq
           LET l_pmdq.pmdqseq2 = 1
           #add by lixh 20150610           
#            SELECT MAX(pmdoseq2)+1 INTO l_pmdo.pmdoseq2 FROM pmdo_t 
#             WHERE pmdoent = g_enterprise
#               AND pmdosite = g_site
#               AND pmdodocno = l_pmdn.pmdndocno
#               AND pmdoseq = l_pmdn.pmdnseq   
#               AND pmdoseq1 = l_pmdo.pmdoseq1 
#             IF cl_null(l_pmdo.pmdoseq2) THEN LET l_pmdo.pmdoseq2 = 1 END IF              
#            LET l_pmdo.pmdo001 = l_pmdn.pmdn001
#            LET l_pmdo.pmdo002 = l_pmdn.pmdn002
#            LET l_pmdo.pmdo003 = l_pmdn.pmdn019
#            LET l_pmdo.pmdo004 = l_pmdn.pmdn006
#            #LET l_pmdo.pmdo005 = l_pmdn.pmdn007
#            LET l_pmdo.pmdo006 = l_pmdn.pmdn007
#            LET l_pmdo.pmdo009 = '1'
#            LET l_pmdo.pmdo011 = l_pmdn.pmdn012
#            LET l_pmdo.pmdo012 = l_pmdn.pmdn012 
#            LET l_pmdo.pmdo013 = l_pmdn.pmdn012
#            LET l_pmdo.pmdo014 = 'N'
#            LET l_pmdo.pmdo021 = '2'
#            LET l_pmdo.pmdo022 = l_pmdn.pmdn015
#            LET l_pmdo.pmdo023 = l_pmdn.pmdn016
#            LET l_pmdo.pmdo024 = l_pmdn.pmdn017
#            LET l_pmdo.pmdo032 = 0
#            LET l_pmdo.pmdo033 = 0
#            LET l_pmdo.pmdo034 = 0
#            LET l_pmdo.pmdo026 = g_user
#            LET l_time = cl_get_current()
#            LET l_pmdo.pmdo027 = l_time 

         ELSE
            IF l_xmdd.xmdc001 = l_xmdc001_t THEN
               UPDATE pmdn_t SET pmdn007 = pmdn007 + l_pmdn.pmdn007,
                                 pmdn009 = pmdn009 + l_pmdn.pmdn009,
                                 pmdn011 = pmdn011 + l_pmdn.pmdn011
                                 
                WHERE pmdnent = g_enterprise
                  AND pmdnsite = g_site
                  AND pmdndocno = g_s_pmdldocno  
                  AND pmdnseq = l_pmdn.pmdnseq
               IF SQLCA.sqlcode THEN
                  LET r_success = FALSE  
               END IF    
               SELECT MAX(pmdoseq2)+1 INTO l_pmdo.pmdoseq2 FROM pmdo_t 
                WHERE pmdoent = g_enterprise
                  AND pmdosite = g_site
                  AND pmdodocno = l_pmdn.pmdndocno
                  AND pmdoseq = l_pmdn.pmdnseq   
                  AND pmdoseq1 = l_pmdo.pmdoseq1
               IF cl_null(l_pmdo.pmdoseq2) THEN LET l_pmdo.pmdoseq2 = 1 END IF      
               #add by lixh 20150610
               SELECT MAX(pmdqseq2)+1 INTO l_pmdq.pmdqseq2 FROM pmdq_t
                WHERE pmdqent = g_enterprise
                  AND pmdqsite = g_site
                  AND pmdqdocno = l_pmdn.pmdndocno
                  AND pmdqseq = l_pmdn.pmdnseq
               IF cl_null(l_pmdq.pmdqseq2) THEN LET l_pmdq.pmdqseq2 = 1 END IF
                              
               #add by lixh 20150610               
            END IF         
         END IF
      END IF
      #add by lixh 20150610
      LET l_pmdq.pmdq002 = l_xmdd.pmdb006
      LET l_pmdq.pmdq003 = l_pmdn.pmdn012
      LET l_pmdq.pmdq004 = l_pmdn.pmdn012
      LET l_pmdq.pmdq005 = l_pmdn.pmdn012
 
      LET l_pmdq.pmdq007 = 'N'
      LET l_pmdq.pmdq008 = 1
      SELECT MAX(pmdqseq2)+1 INTO l_pmdq.pmdqseq2 FROM pmdq_t
       WHERE pmdqent = g_enterprise
         AND pmdqsite = g_site
         AND pmdqdocno = l_pmdn.pmdndocno
         AND pmdqseq = l_pmdn.pmdnseq
      IF cl_null(l_pmdq.pmdqseq2) THEN LET l_pmdq.pmdqseq2 = 1 END IF      
      INSERT INTO pmdq_t (pmdqent,pmdqsite,pmdqdocno,pmdqseq,pmdqseq2,pmdq002,pmdq003,pmdq004,pmdq005,pmdq006,pmdq007,pmdq008)
        VALUES (g_enterprise,g_site,l_pmdn.pmdndocno,l_pmdn.pmdnseq,l_pmdq.pmdqseq2,l_pmdq.pmdq002,l_pmdq.pmdq003,l_pmdq.pmdq004,
                l_pmdq.pmdq005,l_pmdq.pmdq006,l_pmdq.pmdq007,l_pmdq.pmdq008)
                
      LET l_pmdp.pmdp001 = l_pmdn.pmdn001
      LET l_pmdp.pmdp002 = l_pmdn.pmdn002
      LET l_pmdp.pmdp003 = l_xmdd.xmdadocno
      LET l_pmdp.pmdp004 = l_xmdd.xmddseq
      LET l_pmdp.pmdp005 = l_xmdd.xmddseq1
      LET l_pmdp.pmdp006 = l_xmdd.xmddseq2
      LET l_pmdp.pmdp007 = l_pmdn.pmdn001
      LET l_pmdp.pmdp008 = l_pmdn.pmdn002
      LET l_pmdp.pmdp022 = l_pmdn.pmdn006  
      LET l_pmdp.pmdp023 = l_pmdn.pmdn007 
      LET l_pmdp.pmdp024 = l_pmdn.pmdn007    
      LET l_pmdp.pmdp025 = 0
      LET l_pmdp.pmdp026 = 0
      SELECT MAX(pmdpseq1)+1 INTO l_pmdp.pmdpseq1 FROM pmdp_t
       WHERE pmdpent = g_enterprise
         AND pmdpdocno = l_pmdn.pmdndocno
         AND pmdpseq = l_pmdn.pmdnseq
      IF cl_null(l_pmdp.pmdpseq1) THEN LET l_pmdp.pmdpseq1 = 1 END IF
      INSERT INTO pmdp_t (pmdpent,pmdpsite,pmdpdocno,pmdpseq,pmdpseq1,pmdp001,pmdp002,pmdp003,pmdp004,pmdp005,pmdp006,pmdp007,pmdp008,
                          pmdp022,pmdp023,pmdp024,pmdp025,pmdp026)
                  VALUES (g_enterprise,g_site,l_pmdn.pmdndocno,l_pmdn.pmdnseq,l_pmdp.pmdpseq1,l_pmdp.pmdp001,l_pmdp.pmdp002,l_pmdp.pmdp003,l_pmdp.pmdp004,
                          l_pmdp.pmdp005,l_pmdp.pmdp006,l_pmdp.pmdp007,l_pmdp.pmdp008,l_pmdp.pmdp022,l_pmdp.pmdp023,l_pmdp.pmdp024,
                          l_pmdp.pmdp025,l_pmdp.pmdp026)
      #add by lixh 20150610
      LET l_pmdo.pmdodocno = l_pmdn.pmdndocno
      LET l_pmdo.pmdoseq = l_pmdn.pmdnseq
      LET l_pmdo.pmdoseq1 = 1         
      LET l_pmdo.pmdo001 = l_pmdn.pmdn001
      LET l_pmdo.pmdo002 = l_pmdn.pmdn002
      LET l_pmdo.pmdo003 = l_pmdn.pmdn019
      LET l_pmdo.pmdo004 = l_pmdn.pmdn006
      IF g_price = 'N' THEN
        LET l_pmdo.pmdo005 = l_pmdn.pmdn007
      END IF  
      LET l_pmdo.pmdo006 = l_pmdn.pmdn007
      LET l_pmdo.pmdo009 = '1'
      LET l_pmdo.pmdo011 = l_pmdn.pmdn012
      LET l_pmdo.pmdo012 = l_pmdn.pmdn012 
      LET l_pmdo.pmdo013 = l_pmdn.pmdn012
      LET l_pmdo.pmdo014 = 'N'
      LET l_pmdo.pmdo021 = '2'
      LET l_pmdo.pmdo022 = l_pmdn.pmdn015
      LET l_pmdo.pmdo023 = l_pmdn.pmdn016
      LET l_pmdo.pmdo024 = l_pmdn.pmdn017
      LET l_pmdo.pmdo032 = 0
      LET l_pmdo.pmdo033 = 0
      LET l_pmdo.pmdo034 = 0
      LET l_pmdo.pmdo026 = g_user
      LET l_time = cl_get_current()
      LET l_pmdo.pmdo027 = l_time       
      LET l_pmdo.pmdo036 = l_xmdd.xmdadocno
      LET l_pmdo.pmdo037 = l_xmdd.xmddseq
      LET l_pmdo.pmdo038 = l_xmdd.xmddseq1
      LET l_pmdo.pmdo039 = l_xmdd.xmddseq2      
#      INSERT INTO pmdo_t (pmdoent,pmdosite,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,pmdo001,pmdo002,pmdo003,pmdo004,pmdo005,pmdo006,
#                          pmdo007,pmdo008,pmdo009,pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,pmdo015,pmdo016,pmdo017,pmdo019,
#                          pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,pmdo025,pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,pmdo031,pmdo032,
#                          pmdo033,pmdo034,pmdo035,pmdo036,pmdo037,pmdo038,pmdo039,pmdo040,pmdo041,pmdo042,pmdo043,pmdo044)
#                  VALUES (g_enterprise,g_site,l_pmdo.pmdodocno,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,l_pmdo.pmdo001,l_pmdo.pmdo002,
#                          l_pmdo.pmdo003,l_pmdo.pmdo004,l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,
#                          l_pmdo.pmdo011,l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,l_pmdo.pmdo015,l_pmdo.pmdo016,l_pmdo.pmdo017,
#                          l_pmdo.pmdo019,l_pmdo.pmdo020,l_pmdo.pmdo021,l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,l_pmdo.pmdo025,l_pmdo.pmdo026,
#                          l_pmdo.pmdo027,l_pmdo.pmdo028,l_pmdo.pmdo029,l_pmdo.pmdo030,l_pmdo.pmdo031,l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034,
#                          l_pmdo.pmdo035,l_pmdo.pmdo036,l_pmdo.pmdo037,l_pmdo.pmdo038,l_pmdo.pmdo039,l_pmdo.pmdo040,l_pmdo.pmdo041,l_pmdo.pmdo042,
#                          l_pmdo.pmdo043,l_pmdo.pmdo044)
                          
#      IF SQLCA.sqlcode THEN
#         LET r_success = FALSE 
#      END IF   
      IF g_price = 'Y' THEN   #匯總取價
         SELECT pmdn007 INTO l_pmdn007 FROM pmdn_t
          WHERE pmdnent = g_enterprise
            AND pmdnsite = g_site
            AND pmdndocno = l_pmdo.pmdodocno
            AND pmdnseq = l_pmdo.pmdoseq
#         UPDATE pmdo_t SET pmdo005 = l_pmdn007  
#          WHERE pmdoent = g_enterprise
#            AND pmdosite = g_site
#            AND pmdodocno = l_pmdo.pmdodocno            
#            AND pmdoseq = l_pmdo.pmdoseq
      END IF
      LET g_flag = 'N'   #復位
      RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp620_get_oofb019(p_site)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp620_get_oofb019(p_site)
DEFINE p_site     LIKE ooef_t.ooef001
DEFINE l_oofa001  LIKE oofa_t.oofa001
DEFINE r_oofb019  LIKE oofb_t.oofb019
DEFINE r_oofb011  LIKE oofb_t.oofb011

      LET r_oofb019 = ''
      LET r_oofb011 = ''

      #獲取當前營運據點的聯絡對象識別碼
      LET l_oofa001 = ''
      SELECT oofa001 INTO l_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = p_site
      
      IF NOT cl_null(l_oofa001) THEN
         #主要出貨地址
         SELECT oofb019,oofb011 INTO r_oofb019,r_oofb011 FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 = l_oofa001 AND oofb008 = '3' AND oofa010 = 'Y'
         #若沒有勾選主要的
         IF cl_null(r_oofb019) THEN
            SELECT oofb019,oofb011 INTO r_oofb019,r_oofb011 FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 = l_oofa001 AND oofb008 = '3' AND rownum = 1
         END IF
         #呼叫地址組合應用元件
         
      END IF   
      RETURN r_oofb019 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp620_get_oofb019_5(p_site)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp620_get_oofb019_5(p_site)
DEFINE p_site     LIKE ooef_t.ooef001
DEFINE l_oofa001  LIKE oofa_t.oofa001
DEFINE r_oofb019  LIKE oofb_t.oofb019
DEFINE r_oofb011  LIKE oofb_t.oofb011

      LET r_oofb019 = ''
      LET r_oofb011 = ''

      #獲取當前營運據點的聯絡對象識別碼
      LET l_oofa001 = ''
      SELECT oofa001 INTO l_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = p_site
      
      IF NOT cl_null(l_oofa001) THEN
         #主要帳款地址
         SELECT oofb019,oofb011 INTO r_oofb019,r_oofb011 FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 = l_oofa001 AND oofb008 = '5' AND oofa010 = 'Y'
         #若沒有勾選主要的
         IF cl_null(r_oofb019) THEN
            SELECT oofb019,oofb011 INTO r_oofb019,r_oofb011 FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 = l_oofa001 AND oofb008 = '5' AND rownum = 1
         END IF
         #呼叫地址組合應用元件
         
      END IF
      RETURN r_oofb019
END FUNCTION

################################################################################
# Descriptions...: 供應商帶出預設資料
# Memo...........:
# Usage..........: CALL apmp620_pmdl004_desc(p_pmdl004,p_pmal002)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   供應商
#                : 传入参数变量2   控制組
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp620_pmdl004_desc(p_pmdl004,p_pmal002)
DEFINE  p_pmdl004        LIKE pmdl_t.pmdl004
DEFINE  p_pmal002        LIKE pmal_t.pmal002
DEFINE  l_n              LIKE type_t.num5

   INITIALIZE l_pmdl.* TO NULL
   IF NOT cl_null(p_pmdl004) THEN
      #判斷供應商是否有設置採購控制組供應商預設條件(apmi110)，若有則抓取相關的預設條件default到採購單上
      SELECT COUNT(*) INTO l_n FROM pmal_t WHERE pmalent = g_enterprise AND pmal001 = p_pmdl004 AND pmal002 = p_pmal002 AND pmalstus = 'Y'
      IF l_n > 0 THEN
         SELECT pmal006,pmal020,pmal004,pmal003,pmal021,pmal011,pmal008,pmal009,pmal022,pmal023,pmal024
               ,pmal019,pmal025   
           INTO l_pmdl.pmdl009,l_pmdl.pmdl010,l_pmdl.pmdl011,l_pmdl.pmdl015,l_pmdl.pmdl017,l_pmdl.pmdl020,l_pmdl.pmdl023,l_pmdl.pmdl024,l_pmdl.pmdl033,
                l_pmdl.pmdl054,l_pmdl.pmdl055
               ,l_pmdl.pmdl002,l_pmdl.pmdl003   
         FROM pmal_t WHERE pmalent = g_enterprise AND pmal001 = p_pmdl004 AND pmal002 = p_pmal002 AND pmalstus = 'Y'
      END IF
   END IF
   
   #若沒有設置採購控制組供應商預設條件資料則改抓供應商據點預設條件(apmm202)資料  
   IF cl_null(p_pmdl004) OR l_n = 0 THEN
      SELECT pmab037,pmab053,pmab034,pmab033,pmab054,pmab040,pmab038,pmab039,pmab056,pmab057,pmab058
            ,pmab031,pmab059  
          INTO l_pmdl.pmdl009,l_pmdl.pmdl010,l_pmdl.pmdl011,l_pmdl.pmdl015,l_pmdl.pmdl017,l_pmdl.pmdl020,l_pmdl.pmdl023,l_pmdl.pmdl024,l_pmdl.pmdl033,
               l_pmdl.pmdl054,l_pmdl.pmdl055,
               l_pmdl.pmdl002,l_pmdl.pmdl003   
        FROM pmab_t WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = p_pmdl004
        
   END IF
                              
   #抓取交易對象夥伴關係檔且交易類型為"1:收/付款對象"的交易對象顯示在採購單上的
   #[C:帳款供應商]，若有設置多筆收/付款交易對象時，則取有勾選主要的交易對象那一個，
   #若沒有設交易對象夥伴關係檔且交易類型為"1:收/付款對象"的交易對象時，則[C:帳款供應商]預設採購供應商
   LET l_pmdl.pmdl021 = ''
   SELECT pmac002 INTO l_pmdl.pmdl021 FROM pmac_t WHERE pmacent = g_enterprise AND pmac001 = p_pmdl004 AND pmac003 = '1' AND pmacstus = 'Y' AND pmac004 = 'Y'
   IF cl_null(l_pmdl.pmdl021) THEN
      SELECT pmac002 INTO l_pmdl.pmdl021 FROM pmac_t WHERE pmacent = g_enterprise AND pmac001 = p_pmdl004 AND pmac003 = '1' AND pmacstus = 'Y' AND rownum = 1
      IF cl_null(l_pmdl.pmdl021) THEN
         LET l_pmdl.pmdl021 = p_pmdl004
      END IF
   END IF
   
   #抓取交易對象夥伴關係檔且交易類型為"2:出貨對象"的交易對象顯示在採購單上的[C:送貨供應商]，
   #若有設置多筆出貨交易對象時，則取有勾選主要的交易對象那一個，
   #若沒有設交易對象夥伴關係檔且交易類型為"2:出貨對象"的交易對象時，則[C:送貨供應商]預設採購供應商
   LET l_pmdl.pmdl022 = ''
   SELECT pmac002 INTO l_pmdl.pmdl022 FROM pmac_t WHERE pmacent = g_enterprise AND pmac001 = p_pmdl004 AND pmac003 = '2' AND pmacstus = 'Y' AND pmac004 = 'Y'
   IF cl_null(l_pmdl.pmdl022) THEN
      SELECT pmac002 INTO l_pmdl.pmdl022 FROM pmac_t WHERE pmacent = g_enterprise AND pmac001 = p_pmdl004 AND pmac003 = '2' AND pmacstus = 'Y' AND rownum = 1
      IF cl_null(l_pmdl.pmdl022) THEN
         LET l_pmdl.pmdl022 = p_pmdl004
      END IF
   END IF
   
   #抓取交易對象聯絡人明細檔的聯絡對像識別碼顯示在採購單上的[C:供應商連絡人]，
   #若有設置多個聯絡人時，則取有勾選主要聯絡人的那一個
   LET l_pmdl.pmdl027 = ''
   SELECT pmaj002 INTO l_pmdl.pmdl027 FROM pmaj_t WHERE pmajent = g_enterprise AND pmaj001 = p_pmdl004 AND pmajstus = 'Y' AND pmaj004 = 'Y'
   IF cl_null(l_pmdl.pmdl022) THEN
      SELECT pmaj002 INTO l_pmdl.pmdl027 FROM pmaj_t WHERE pmajent = g_enterprise AND pmaj001 = p_pmdl004 AND pmajstus = 'Y' AND pmaj004 = 'Y' AND rownum = 1  
   END IF
   RETURN l_pmdl.*
END FUNCTION

################################################################################
# Descriptions...: 根據料件供應商帶值
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp620_pmdn001_desc()
DEFINE    l_n         LIKE type_t.num5
DEFINE    l_oodbl004  LIKE oodbl_t.oodbl004
DEFINE    l_oodb005   LIKE oodb_t.oodb005
DEFINE    l_oodb006   LIKE oodb_t.oodb006
DEFINE    l_oodb011   LIKE oodb_t.oodb011
DEFINE    l_imaf158   LIKE imaf_t.imaf158
DEFINE    l_success   LIKE type_t.num5

      IF NOT cl_null(l_xmdd.pmal002) THEN
         SELECT COUNT(*) INTO l_n FROM pmap_t 
            WHERE pmapent = g_enterprise AND pmapsite = g_site AND pmap001 = l_xmdd.pmdl004
              AND pmap002 = l_xmdd.pmal002 AND pmap003 = l_pmdn.pmdn001 AND pmap004 = l_pmdn.pmdn002
         #若採購料件有設置'供應商控制組料件預設條件'(apmi121)時，則需將設置的預設條件值預設到採購單對應欄位
         IF l_n > 0 THEN

            SELECT pmap006,pmap008,pmap009,pmap012,pmap014,pmap005
              INTO l_pmdn.pmdn006,l_pmdn.pmdn010,l_pmdn.pmdnunit,l_pmdn.pmdn025,l_pmdn.pmdn031,l_pmdn.pmdn003
            
            FROM pmap_t 
            WHERE pmapent = g_enterprise AND pmapsite = g_site AND pmap001 = l_xmdd.pmdl004
              AND pmap002 = l_xmdd.pmal002 AND pmap003 = l_pmdn.pmdn001 AND pmap004 = l_pmdn.pmdn002
  
         END IF
      END IF
      
      IF cl_null(l_xmdd.pmal002) OR l_n = 0 THEN        
         #沒有設置'供應商控制組料件預設條件'(apmi121)才改抓料件進銷存檔預設的條件
         SELECT imaf143,imaf144,imaf157
           INTO l_pmdn.pmdn006,l_pmdn.pmdn010,l_pmdn.pmdn003
           FROM imaf_t
         WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdn.pmdn001  
      END IF
      #取得稅別類型
      CALL s_tax_chk(g_site,l_xmdd.xmda011)
        RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
      IF l_success THEN
         LET g_tax_app = l_oodb011
      END IF               
      #若稅別應用為2.依料件設定，呼叫應用元件帶出稅別、稅率
      IF g_tax_app = '2' AND NOT cl_null(l_pmdl.pmdl004) THEN
         #依料件檢核是否有依交易分類設定稅別
         CALL s_tax_chktype(g_site,l_xmdd.pmdl004,l_pmdn.pmdn001,'1',l_pmdl.pmdl004)
           RETURNING l_success,l_pmdn.pmdn016,l_pmdn.pmdn017         
         IF l_success THEN
         ELSE
            #檢查失敗時後續處理
            LET l_pmdn.pmdn016 = ''
            LET l_pmdn.pmdn017 = ''
         END IF           
      ELSE
         LET l_pmdn.pmdn016 = l_xmdd.xmda011
         LET l_pmdn.pmdn017 = l_xmdd.xmda012
      END IF             
      
      #[C:備品率] = [T:料件進銷存檔].[C:採購備品率]  imaf165
      #[C:參考單位] = [T:料件進銷存檔][C:參考單位]   imaf015
      #若[T:料件進銷存檔].[C:接單拆解方式(採購)]的值為'1:自動CKD'或是'2:自動SKD'時，imaf158
      #則[C:子件特性]的值預設'2:CKD'或是'3:SKD'
      LET l_pmdn.pmdn008 = ''
      LET l_pmdn.pmdn033 = ''
      LET l_pmdn.pmdn019 = '1'
      LET l_imaf158 = ''
      SELECT imaf158,imaf165,imaf015 INTO l_imaf158,l_pmdn.pmdn033,l_pmdn.pmdn008 FROM imaf_t
        WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdn.pmdn001
      IF l_imaf158 = '1' THEN
         LET l_pmdn.pmdn019 = '2'
      END IF
      IF l_imaf158 = '2' THEN
         LET l_pmdn.pmdn019 = '3'
      END IF
      
      #整體參數使用採購計價單位時:
      #[C:計價單位]=[T:料件據點進銷存檔].[C:採購計價單位] 
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN  
         SELECT imaf144 INTO l_pmdn.pmdn010 FROM imaf_t
            WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdn.pmdn001
      END IF
      
      #若採購料件有設置'交易對象對應料號'(apmi070)有供應商料號時，需將對應的料號抓出顯示在
      #[C:供應商料號]欄位上，若有設置多筆對應料號時以有勾選主要對應料那一筆為預設值
      LET l_pmdn.pmdn027 = ''
      SELECT pmao004 INTO l_pmdn.pmdn027 FROM pmao_t 
        WHERE pmaoent = g_enterprise AND pmao001 = l_xmdd.pmdl004 AND pmao002 = l_pmdn.pmdn001 
          AND pmao000 = '1'      #161221-00064#10 add
          AND pmao003 = l_pmdn.pmdn002 AND pmao007 = 'Y'
      IF cl_null(l_pmdn.pmdn027) THEN
         SELECT pmao004 INTO l_pmdn.pmdn027 FROM pmao_t 
           WHERE pmaoent = g_enterprise AND pmao001 = l_xmdd.pmdl004 AND pmao002 = l_pmdn.pmdn001 
             AND pmao000 = '1'      #161221-00064#10 add
             AND pmao003 = l_pmdn.pmdn002 AND rownum = 1
      END IF 
      CALL apmp620_get_qcap006() 
      IF cl_null(l_pmdn.pmdn010) OR cl_null(l_pmdn.pmdn011) THEN
         LET l_pmdn.pmdn010 = l_pmdn.pmdn006
         LET l_pmdn.pmdn011 = l_pmdn.pmdn007
      END IF

END FUNCTION

################################################################################
# Descriptions...: 檢驗否
# Memo...........:
# Usage..........: CALL apmp620_get_qcap006()
#                  RETURNING lixh
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp620_get_qcap006()
DEFINE l_sql      STRING

      LET l_pmdn.pmdn052 = ''
      
      LET l_sql = " SELECT qcap006 FROM qcap_t ",
                 " WHERE qcapent = '",g_enterprise,"' ",
                 "  AND qcapsite = '",g_site,"' ",
                 "  AND qcap001 = '",l_pmdn.pmdn001,"' ",
                 "  AND qcap002 = '",l_xmdd.pmdl004,"' "
                 
      IF l_pmdn.pmdn002 IS NOT NULL THEN
         LET l_sql = l_sql ," AND (qcap005 = '",l_pmdn.pmdn002,"' OR qcap005 = 'ALL' )"
      END IF
      IF (NOT cl_null(l_pmdn.pmdn004)) AND (NOT cl_null(l_pmdn.pmdn005)) THEN
         LET l_sql = l_sql ," AND (qcap003 = '",l_pmdn.pmdn004,"' OR qcap003 = 'ALL' ) AND qcap004 = '",l_pmdn.pmdn005,"' "
      END IF
      
      PREPARE get_qcap FROM l_sql
      EXECUTE get_qcap INTO l_pmdn.pmdn052   
      FREE get_qcap
      
      IF cl_null(l_pmdn.pmdn052) THEN
         #若沒有維護aqci050,再從aqci040中帶值
         SELECT imae114 INTO l_pmdn.pmdn052 FROM imae_t 
             WHERE imaeent = g_enterprise AND imaesite = g_site AND imae001 = l_pmdn.pmdn001
             
      END IF
      
      IF cl_null(l_pmdn.pmdn052) THEN
         LET l_pmdn.pmdn052 = 'N'
      END IF
END FUNCTION

#end add-point
 
{</section>}
 
