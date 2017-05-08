#該程式未解開Section, 採用最新樣板產出!
{<section id="axcp950.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-07-21 14:34:16), PR版次:0007(2017-01-05 18:43:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000022
#+ Filename...: axcp950
#+ Description: 內部交易收入成本計算作業
#+ Creator....: 00768(2015-12-23 14:16:14)
#+ Modifier...: 00768 -SD/PR- 00768
 
{</section>}
 
{<section id="axcp950.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160318-00025#8   2016/04/21 By 07675   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160616-00006#2   2016/06/17 By 00768   增加xcja011设置，为2时为原逻辑，为1时不考虑生产明细发生的利润中心变动，销售若非自己利润中心的，直接增加该利润中心的内部成本，已成本金额计算 
#160616-00006#4   2016/07/14 By 00768   补充内部加工收入和成本
#                 需求有2种状况：
#                 第一种：同一法人下A分公司接单给B生产部门做，工单开在A分公司据点下，但由B生产部门负责做，这样A与B之间需要内部结算加工收入和费用。
#                 第二种：同一法人下A分公司接单给B生产部门做，工单开在A分公司据点下，但由B生产部门又把其中某几道工序转给C生产部门负责做，这样除了A与B之间需要内部结算加工收入和费用外，B与C之间也需要内部结算加工收入和费用。
#160721 按要求取消产生利润中心部分异动类型来源
#160805-00006#1   2016/08/08 By xianghui  1，账套编号的开窗与检查需一致，帐套输入完带出法人，检查axct950资料是否存在时，应过滤掉作废的单据
#161019-00017#7   2016/10/19 By zhujing   据点组织开窗资料整批调整
#161103-00045#2   2016/11/04 By shiun     更改s_get_item_acc傳入參數
#161124-00048#12  2016/12/13 By xujing     整批调整系统RECORD LIKE xxxx_t.* 星号写法
#170105-00002#1   2017/01/05 By 00768     取消aooi110的限制
#                                         修正161124-00048#12错处，导致FOREACH axcp950_ins_xcjf_c1错误
#                                         修改161103-00045#2修改的取科目错误
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_schedule.inc"
GLOBALS
   DEFINE gwin_curr2  ui.Window
   DEFINE gfrm_curr2  ui.Form
   DEFINE gi_hiden_asign       LIKE type_t.num5
   DEFINE gi_hiden_exec        LIKE type_t.num5
   DEFINE gi_hiden_spec        LIKE type_t.num5
   DEFINE gi_hiden_exec_end    LIKE type_t.num5
   DEFINE g_chk_jobid          LIKE type_t.num5
END GLOBALS
 
PRIVATE TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       xcjeld LIKE type_t.chr5, 
   xcjeld_desc LIKE type_t.chr80, 
   xcje002 LIKE type_t.num5, 
   xcje003 LIKE type_t.num5, 
   xcjedocno LIKE type_t.chr20, 
   glaacomp LIKE type_t.chr10, 
   glaacomp_desc LIKE type_t.chr80, 
   xcje006 LIKE type_t.chr10, 
   xcje006_desc LIKE type_t.chr80, 
   xcjedocdt LIKE type_t.dat, 
   xcjf016 LIKE type_t.chr500, 
   xcjf013 LIKE type_t.chr10, 
   has_cnt LIKE type_t.chr500, 
   left_cnt LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80, 
   item LIKE type_t.chr500, 
   item_desc LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#DEFINE g_glaa               RECORD LIKE glaa_t.*  #161124-00048#12 mark
#DEFINE g_xcja               RECORD LIKE xcja_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
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
DEFINE g_xcja RECORD  #內部交易計算基礎設定
       xcjaent LIKE xcja_t.xcjaent, #企业编号
       xcja001 LIKE xcja_t.xcja001, #计算类型(版本)
       xcja002 LIKE xcja_t.xcja002, #主类型(版本)否
       xcja003 LIKE xcja_t.xcja003, #利润中心来源
       xcja004 LIKE xcja_t.xcja004, #类别
       xcja005 LIKE xcja_t.xcja005, #计算依据
       xcja006 LIKE xcja_t.xcja006, #核算币种
       xcja007 LIKE xcja_t.xcja007, #虚拟利润中心编号
       xcja008 LIKE xcja_t.xcja008, #计算方式
       xcja009 LIKE xcja_t.xcja009, #对比成本计算类型
       xcja010 LIKE xcja_t.xcja010, #结存是否计算内部成本
       xcjaownid LIKE xcja_t.xcjaownid, #资料所有者
       xcjaowndp LIKE xcja_t.xcjaowndp, #资料所有部门
       xcjacrtid LIKE xcja_t.xcjacrtid, #资料录入者
       xcjacrtdp LIKE xcja_t.xcjacrtdp, #资料录入部门
       xcjacrtdt LIKE xcja_t.xcjacrtdt, #资料创建日
       xcjamodid LIKE xcja_t.xcjamodid, #资料更改者
       xcjamoddt LIKE xcja_t.xcjamoddt, #最近更改日
       xcjastus LIKE xcja_t.xcjastus, #状态码
       xcja011 LIKE xcja_t.xcja011  #成本调整取价
END RECORD
#161124-00048#12 add(e)
DEFINE g_wc2                STRING  #g_master.wc construct中漏了xcjf016栏位，再加个补

#axcp950_ins_xcjf中foreah栏位
#DEFINE g_xcck         RECORD LIKE xcck_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE g_xcck RECORD  #本期料件明細進出成本檔
       xcckent LIKE xcck_t.xcckent, #企业编号
       xccksite LIKE xcck_t.xccksite, #site组织
       xcckcomp LIKE xcck_t.xcckcomp, #法人组织
       xcckld LIKE xcck_t.xcckld, #账套
       xcck001 LIKE xcck_t.xcck001, #账套本位币顺序
       xcck002 LIKE xcck_t.xcck002, #成本域
       xcck003 LIKE xcck_t.xcck003, #成本计算类型
       xcck004 LIKE xcck_t.xcck004, #年度
       xcck005 LIKE xcck_t.xcck005, #期别
       xcck006 LIKE xcck_t.xcck006, #参考单号
       xcck007 LIKE xcck_t.xcck007, #项次
       xcck008 LIKE xcck_t.xcck008, #项序
       xcck009 LIKE xcck_t.xcck009, #出入库码
       xcck010 LIKE xcck_t.xcck010, #料号
       xcck011 LIKE xcck_t.xcck011, #产品特征
       xcck012 LIKE xcck_t.xcck012, #单据类型
       xcck013 LIKE xcck_t.xcck013, #单据日期
       xcck014 LIKE xcck_t.xcck014, #时间
       xcck015 LIKE xcck_t.xcck015, #仓库编号
       xcck016 LIKE xcck_t.xcck016, #储位编号
       xcck017 LIKE xcck_t.xcck017, #批号
       xcck020 LIKE xcck_t.xcck020, #异动类型
       xcck021 LIKE xcck_t.xcck021, #原因码
       xcck022 LIKE xcck_t.xcck022, #交易对象
       xcck023 LIKE xcck_t.xcck023, #客群
       xcck024 LIKE xcck_t.xcck024, #区域
       xcck025 LIKE xcck_t.xcck025, #成本中心
       xcck026 LIKE xcck_t.xcck026, #经营类别
       xcck027 LIKE xcck_t.xcck027, #渠道
       xcck028 LIKE xcck_t.xcck028, #品类
       xcck029 LIKE xcck_t.xcck029, #品牌
       xcck030 LIKE xcck_t.xcck030, #项目号
       xcck031 LIKE xcck_t.xcck031, #WBS
       xcck032 LIKE xcck_t.xcck032, #存货科目
       xcck033 LIKE xcck_t.xcck033, #费用成本科目
       xcck034 LIKE xcck_t.xcck034, #收入科目
       xcck040 LIKE xcck_t.xcck040, #交易币种
       xcck041 LIKE xcck_t.xcck041, #本位币种
       xcck042 LIKE xcck_t.xcck042, #汇率
       xcck043 LIKE xcck_t.xcck043, #交易单位
       xcck044 LIKE xcck_t.xcck044, #成本单位
       xcck045 LIKE xcck_t.xcck045, #换算率
       xcck046 LIKE xcck_t.xcck046, #交易数量
       xcck047 LIKE xcck_t.xcck047, #工单号码
       xcck048 LIKE xcck_t.xcck048, #重复性生产-计划编号
       xcck049 LIKE xcck_t.xcck049, #重复性生产-生产料号
       xcck050 LIKE xcck_t.xcck050, #重复性生产-生产料号BOM特性
       xcck051 LIKE xcck_t.xcck051, #重复性生产-生产料号产品特征
       xcck055 LIKE xcck_t.xcck055, #xccc类型
       xcck201 LIKE xcck_t.xcck201, #本期异动数量
       xcck202 LIKE xcck_t.xcck202, #本期异动金额
       xcck202a LIKE xcck_t.xcck202a, #本期异动金额-材料
       xcck202b LIKE xcck_t.xcck202b, #本期异动金额-人工
       xcck202c LIKE xcck_t.xcck202c, #本期异动金额-加工费
       xcck202d LIKE xcck_t.xcck202d, #本期异动金额-制费一
       xcck202e LIKE xcck_t.xcck202e, #本期异动金额-制费二
       xcck202f LIKE xcck_t.xcck202f, #本期异动金额-制费三
       xcck202g LIKE xcck_t.xcck202g, #本期异动金额-制费四
       xcck202h LIKE xcck_t.xcck202h, #本期异动金额-制费五
       xcck282 LIKE xcck_t.xcck282, #本期异动单价
       xcck282a LIKE xcck_t.xcck282a, #本期异动单价-材料
       xcck282b LIKE xcck_t.xcck282b, #本期异动单价-人工
       xcck282c LIKE xcck_t.xcck282c, #本期异动单价-加工
       xcck282d LIKE xcck_t.xcck282d, #本期异动单价-制费一
       xcck282e LIKE xcck_t.xcck282e, #本期异动单价-制费二
       xcck282f LIKE xcck_t.xcck282f, #本期异动单价-制费三
       xcck282g LIKE xcck_t.xcck282g, #本期异动单价-制费四
       xcck282h LIKE xcck_t.xcck282h, #本期异动单价-制费五
       xcck301 LIKE xcck_t.xcck301, #已耗数量
       xcck302 LIKE xcck_t.xcck302, #已耗金额
       xcck302a LIKE xcck_t.xcck302a, #已耗金额-材料
       xcck302b LIKE xcck_t.xcck302b, #已耗金额-人工
       xcck302c LIKE xcck_t.xcck302c, #已耗金额-加工费
       xcck302d LIKE xcck_t.xcck302d, #已耗金额-制费一
       xcck302e LIKE xcck_t.xcck302e, #已耗金额-制费二
       xcck302f LIKE xcck_t.xcck302f, #已耗金额-制费三
       xcck302g LIKE xcck_t.xcck302g, #已耗金额-制费四
       xcck302h LIKE xcck_t.xcck302h, #已耗金额-制费五
       xcck901 LIKE xcck_t.xcck901, #结存数量
       xcck902 LIKE xcck_t.xcck902, #结存金额
       xcck902a LIKE xcck_t.xcck902a, #结存金额-材料
       xcck902b LIKE xcck_t.xcck902b, #结存金额-人工
       xcck902c LIKE xcck_t.xcck902c, #结存金额-加工费
       xcck902d LIKE xcck_t.xcck902d, #结存金额-制费一
       xcck902e LIKE xcck_t.xcck902e, #结存金额-制费二
       xcck902f LIKE xcck_t.xcck902f, #结存金额-制费三
       xcck902g LIKE xcck_t.xcck902g, #结存金额-制费四
       xcck902h LIKE xcck_t.xcck902h, #结存金额-制费五
       xcck980 LIKE xcck_t.xcck980, #结存单位成本
       xcck980a LIKE xcck_t.xcck980a, #结存单位成本-材料
       xcck980b LIKE xcck_t.xcck980b, #结存单位成本-人工
       xcck980c LIKE xcck_t.xcck980c, #结存单位成本-加工费
       xcck980d LIKE xcck_t.xcck980d, #结存单位成本-制费一
       xcck980e LIKE xcck_t.xcck980e, #结存单位成本-制费二
       xcck980f LIKE xcck_t.xcck980f, #结存单位成本-制费三
       xcck980g LIKE xcck_t.xcck980g, #结存单位成本-制费四
       xcck980h LIKE xcck_t.xcck980h, #结存单位成本-制费五
       xcck903 LIKE xcck_t.xcck903, #结存调整金额
       xcck903a LIKE xcck_t.xcck903a, #结存调整金额-材料
       xcck903b LIKE xcck_t.xcck903b, #结存调整金额-人工
       xcck903c LIKE xcck_t.xcck903c, #结存调整金额-加工费
       xcck903d LIKE xcck_t.xcck903d, #结存调整金额-制费一
       xcck903e LIKE xcck_t.xcck903e, #结存调整金额-制费二
       xcck903f LIKE xcck_t.xcck903f, #结存调整金额-制费三
       xcck903g LIKE xcck_t.xcck903g, #结存调整金额-制费四
       xcck903h LIKE xcck_t.xcck903h, #结存调整金额-制费五
       xcckownid LIKE xcck_t.xcckownid, #资料所有者
       xcckowndp LIKE xcck_t.xcckowndp, #资料所有部门
       xcckcrtid LIKE xcck_t.xcckcrtid, #资料录入者
       xcckcrtdp LIKE xcck_t.xcckcrtdp, #资料录入部门
       xcckcrtdt LIKE xcck_t.xcckcrtdt, #资料创建日
       xcckmodid LIKE xcck_t.xcckmodid, #资料更改者
       xcckmoddt LIKE xcck_t.xcckmoddt, #最近更改日
       xcckstus LIKE xcck_t.xcckstus, #状态码
       xcck056 LIKE xcck_t.xcck056  #成本代销单号
END RECORD
#161124-00048#12 add(e)
DEFINE g_center       LIKE inaa_t.inaa005  #仓库所在利润中心
DEFINE g_ob_center    LIKE inaa_t.inaa005  #对应利润中心
#--axci951中值
DEFINE g_xcjb007      LIKE xcjb_t.xcjb007  #计价单位
DEFINE g_xcjb008      LIKE xcjb_t.xcjb008  #币别
DEFINE g_xcjb009      LIKE xcjb_t.xcjb009  #内部交易单价
#--成本计算结果
DEFINE g_imaa006      LIKE imaa_t.imaa006  #成本单位
DEFINE g_xccc010      LIKE xccc_t.xccc010  #币别
DEFINE g_xccc280      LIKE xccc_t.xccc280  #实际单价
#--
DEFINE g_inaj017      LIKE inaj_t.inaj017  #异动部门
DEFINE g_inaj035      LIKE inaj_t.inaj035  #异动作业
DEFINE g_xcjc006      LIKE xcjc_t.xcjc006  #分摊组织：主销售的时候用
DEFINE g_xcjc007      LIKE xcjc_t.xcjc007  #分摊比率：主销售的时候用
DEFINE g_xccq003      LIKE xccq_t.xccq003  #成本计算类型
DEFINE g_xccq006      LIKE xccq_t.xccq006  #料号
DEFINE g_xccq010      LIKE xccq_t.xccq010  #仓库
DEFINE g_xccq901      LIKE xccq_t.xccq901  #期末数量
DEFINE g_xccq902      LIKE xccq_t.xccq902  #期末金额
DEFINE g_bdate        LIKE type_t.dat    #当期所属的起始日期
DEFINE g_edate        LIKE type_t.dat    #当期所属的截止日期
#ins插入用的全局变量
#DEFINE g_xcje         RECORD LIKE xcje_t.*  #161124-00048#12 mark
#DEFINE g_xcjf         RECORD LIKE xcjf_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE g_xcje RECORD  #內部收入成本數據單頭檔
       xcjeent LIKE xcje_t.xcjeent, #企业编号
       xcjesite LIKE xcje_t.xcjesite, #账务中心
       xcjeld LIKE xcje_t.xcjeld, #账套
       xcjedocno LIKE xcje_t.xcjedocno, #单据编号
       xcjedocdt LIKE xcje_t.xcjedocdt, #单据日期
       xcje001 LIKE xcje_t.xcje001, #来源类型
       xcje002 LIKE xcje_t.xcje002, #年度
       xcje003 LIKE xcje_t.xcje003, #期别
       xcje004 LIKE xcje_t.xcje004, #凭证号码
       xcje005 LIKE xcje_t.xcje005, #凭证日期
       xcje006 LIKE xcje_t.xcje006, #计算类型(版本)
       xcje007 LIKE xcje_t.xcje007, #账务人员
       xcjeownid LIKE xcje_t.xcjeownid, #资料所有者
       xcjeowndp LIKE xcje_t.xcjeowndp, #资料所有部门
       xcjecrtid LIKE xcje_t.xcjecrtid, #资料录入者
       xcjecrtdp LIKE xcje_t.xcjecrtdp, #资料录入部门
       xcjecrtdt LIKE xcje_t.xcjecrtdt, #资料创建日
       xcjemodid LIKE xcje_t.xcjemodid, #资料更改者
       xcjemoddt LIKE xcje_t.xcjemoddt, #最近更改日
       xcjecnfid LIKE xcje_t.xcjecnfid, #资料审核者
       xcjecnfdt LIKE xcje_t.xcjecnfdt, #数据审核日
       xcjepstid LIKE xcje_t.xcjepstid, #资料过账者
       xcjepstdt LIKE xcje_t.xcjepstdt, #资料过账日
       xcjestus LIKE xcje_t.xcjestus, #状态码
       xcjeud001 LIKE xcje_t.xcjeud001, #自定义字段(文本)001
       xcjeud002 LIKE xcje_t.xcjeud002, #自定义字段(文本)002
       xcjeud003 LIKE xcje_t.xcjeud003, #自定义字段(文本)003
       xcjeud004 LIKE xcje_t.xcjeud004, #自定义字段(文本)004
       xcjeud005 LIKE xcje_t.xcjeud005, #自定义字段(文本)005
       xcjeud006 LIKE xcje_t.xcjeud006, #自定义字段(文本)006
       xcjeud007 LIKE xcje_t.xcjeud007, #自定义字段(文本)007
       xcjeud008 LIKE xcje_t.xcjeud008, #自定义字段(文本)008
       xcjeud009 LIKE xcje_t.xcjeud009, #自定义字段(文本)009
       xcjeud010 LIKE xcje_t.xcjeud010, #自定义字段(文本)010
       xcjeud011 LIKE xcje_t.xcjeud011, #自定义字段(数字)011
       xcjeud012 LIKE xcje_t.xcjeud012, #自定义字段(数字)012
       xcjeud013 LIKE xcje_t.xcjeud013, #自定义字段(数字)013
       xcjeud014 LIKE xcje_t.xcjeud014, #自定义字段(数字)014
       xcjeud015 LIKE xcje_t.xcjeud015, #自定义字段(数字)015
       xcjeud016 LIKE xcje_t.xcjeud016, #自定义字段(数字)016
       xcjeud017 LIKE xcje_t.xcjeud017, #自定义字段(数字)017
       xcjeud018 LIKE xcje_t.xcjeud018, #自定义字段(数字)018
       xcjeud019 LIKE xcje_t.xcjeud019, #自定义字段(数字)019
       xcjeud020 LIKE xcje_t.xcjeud020, #自定义字段(数字)020
       xcjeud021 LIKE xcje_t.xcjeud021, #自定义字段(日期时间)021
       xcjeud022 LIKE xcje_t.xcjeud022, #自定义字段(日期时间)022
       xcjeud023 LIKE xcje_t.xcjeud023, #自定义字段(日期时间)023
       xcjeud024 LIKE xcje_t.xcjeud024, #自定义字段(日期时间)024
       xcjeud025 LIKE xcje_t.xcjeud025, #自定义字段(日期时间)025
       xcjeud026 LIKE xcje_t.xcjeud026, #自定义字段(日期时间)026
       xcjeud027 LIKE xcje_t.xcjeud027, #自定义字段(日期时间)027
       xcjeud028 LIKE xcje_t.xcjeud028, #自定义字段(日期时间)028
       xcjeud029 LIKE xcje_t.xcjeud029, #自定义字段(日期时间)029
       xcjeud030 LIKE xcje_t.xcjeud030  #自定义字段(日期时间)030
END RECORD

DEFINE g_xcjf RECORD  #內部收入成本數據明細檔
       xcjfent LIKE xcjf_t.xcjfent, #企业编号
       xcjfsite LIKE xcjf_t.xcjfsite, #账务中心
       xcjfld LIKE xcjf_t.xcjfld, #账套
       xcjfdocno LIKE xcjf_t.xcjfdocno, #单据编号
       xcjfseq LIKE xcjf_t.xcjfseq, #项次
       xcjf001 LIKE xcjf_t.xcjf001, #业务单据
       xcjf002 LIKE xcjf_t.xcjf002, #项次
       xcjf003 LIKE xcjf_t.xcjf003, #项次
       xcjf010 LIKE xcjf_t.xcjf010, #类型(收入/成本)
       xcjf011 LIKE xcjf_t.xcjf011, #来源(存货/在制)
       xcjf012 LIKE xcjf_t.xcjf012, #计算类别(损益/资产)
       xcjf013 LIKE xcjf_t.xcjf013, #实体利润中心（组织)
       xcjf014 LIKE xcjf_t.xcjf014, #虚拟利润中心(组织)
       xcjf015 LIKE xcjf_t.xcjf015, #交易组织(site)
       xcjf016 LIKE xcjf_t.xcjf016, #料号
       xcjf017 LIKE xcjf_t.xcjf017, #仓库
       xcjf018 LIKE xcjf_t.xcjf018, #批号
       xcjf019 LIKE xcjf_t.xcjf019, #异动类型
       xcjf020 LIKE xcjf_t.xcjf020, #基础单位
       xcjf021 LIKE xcjf_t.xcjf021, #出入库码
       xcjf022 LIKE xcjf_t.xcjf022, #异动数量
       xcjf023 LIKE xcjf_t.xcjf023, #计价单位
       xcjf024 LIKE xcjf_t.xcjf024, #换算率
       xcjf028 LIKE xcjf_t.xcjf028, #收入/成本/存货科目
       xcjf029 LIKE xcjf_t.xcjf029, #对方科目
       xcjf030 LIKE xcjf_t.xcjf030, #摘要
       xcjf031 LIKE xcjf_t.xcjf031, #部门
       xcjf032 LIKE xcjf_t.xcjf032, #成本中心
       xcjf033 LIKE xcjf_t.xcjf033, #区域
       xcjf034 LIKE xcjf_t.xcjf034, #交易对象
       xcjf035 LIKE xcjf_t.xcjf035, #账款对象
       xcjf036 LIKE xcjf_t.xcjf036, #客群
       xcjf037 LIKE xcjf_t.xcjf037, #品类
       xcjf038 LIKE xcjf_t.xcjf038, #经营类别
       xcjf039 LIKE xcjf_t.xcjf039, #渠道
       xcjf040 LIKE xcjf_t.xcjf040, #品牌
       xcjf041 LIKE xcjf_t.xcjf041, #人员
       xcjf042 LIKE xcjf_t.xcjf042, #项目号
       xcjf043 LIKE xcjf_t.xcjf043, #WBS
       xcjf044 LIKE xcjf_t.xcjf044, #自由核算项1
       xcjf045 LIKE xcjf_t.xcjf045, #自由核算项2
       xcjf046 LIKE xcjf_t.xcjf046, #自由核算项3
       xcjf047 LIKE xcjf_t.xcjf047, #自由核算项4
       xcjf048 LIKE xcjf_t.xcjf048, #自由核算项5
       xcjf049 LIKE xcjf_t.xcjf049, #自由核算项6
       xcjf050 LIKE xcjf_t.xcjf050, #自由核算项7
       xcjf051 LIKE xcjf_t.xcjf051, #自由核算项8
       xcjf052 LIKE xcjf_t.xcjf052, #自由核算项9
       xcjf053 LIKE xcjf_t.xcjf053, #自由核算项10
       xcjf101 LIKE xcjf_t.xcjf101, #交易币种
       xcjf102 LIKE xcjf_t.xcjf102, #交易单价
       xcjf110 LIKE xcjf_t.xcjf110, #交易金额
       xcjf200 LIKE xcjf_t.xcjf200, #换算汇率
       xcjf201 LIKE xcjf_t.xcjf201, #本位币一金额
       xcjf210 LIKE xcjf_t.xcjf210, #换算汇率二
       xcjf211 LIKE xcjf_t.xcjf211, #本位币二金额
       xcjf220 LIKE xcjf_t.xcjf220, #换算汇率三
       xcjf221 LIKE xcjf_t.xcjf221, #本位币三金额
       xcjfud001 LIKE xcjf_t.xcjfud001, #自定义字段(文本)001
       xcjfud002 LIKE xcjf_t.xcjfud002, #自定义字段(文本)002
       xcjfud003 LIKE xcjf_t.xcjfud003, #自定义字段(文本)003
       xcjfud004 LIKE xcjf_t.xcjfud004, #自定义字段(文本)004
       xcjfud005 LIKE xcjf_t.xcjfud005, #自定义字段(文本)005
       xcjfud006 LIKE xcjf_t.xcjfud006, #自定义字段(文本)006
       xcjfud007 LIKE xcjf_t.xcjfud007, #自定义字段(文本)007
       xcjfud008 LIKE xcjf_t.xcjfud008, #自定义字段(文本)008
       xcjfud009 LIKE xcjf_t.xcjfud009, #自定义字段(文本)009
       xcjfud010 LIKE xcjf_t.xcjfud010, #自定义字段(文本)010
       xcjfud011 LIKE xcjf_t.xcjfud011, #自定义字段(数字)011
       xcjfud012 LIKE xcjf_t.xcjfud012, #自定义字段(数字)012
       xcjfud013 LIKE xcjf_t.xcjfud013, #自定义字段(数字)013
       xcjfud014 LIKE xcjf_t.xcjfud014, #自定义字段(数字)014
       xcjfud015 LIKE xcjf_t.xcjfud015, #自定义字段(数字)015
       xcjfud016 LIKE xcjf_t.xcjfud016, #自定义字段(数字)016
       xcjfud017 LIKE xcjf_t.xcjfud017, #自定义字段(数字)017
       xcjfud018 LIKE xcjf_t.xcjfud018, #自定义字段(数字)018
       xcjfud019 LIKE xcjf_t.xcjfud019, #自定义字段(数字)019
       xcjfud020 LIKE xcjf_t.xcjfud020, #自定义字段(数字)020
       xcjfud021 LIKE xcjf_t.xcjfud021, #自定义字段(日期时间)021
       xcjfud022 LIKE xcjf_t.xcjfud022, #自定义字段(日期时间)022
       xcjfud023 LIKE xcjf_t.xcjfud023, #自定义字段(日期时间)023
       xcjfud024 LIKE xcjf_t.xcjfud024, #自定义字段(日期时间)024
       xcjfud025 LIKE xcjf_t.xcjfud025, #自定义字段(日期时间)025
       xcjfud026 LIKE xcjf_t.xcjfud026, #自定义字段(日期时间)026
       xcjfud027 LIKE xcjf_t.xcjfud027, #自定义字段(日期时间)027
       xcjfud028 LIKE xcjf_t.xcjfud028, #自定义字段(日期时间)028
       xcjfud029 LIKE xcjf_t.xcjfud029, #自定义字段(日期时间)029
       xcjfud030 LIKE xcjf_t.xcjfud030  #自定义字段(日期时间)030
END RECORD
#161124-00048#12 add(e)
DEFINE g_seq          LIKE type_t.num10

#进度显示
DEFINE g_cnt          LIKE type_t.num10
DEFINE g_has_cnt      LIKE type_t.num10
DEFINE g_left_cnt     LIKE type_t.num10
DEFINE g_imaal003     LIKE imaal_t.imaal003
DEFINE g_imaal004     LIKE imaal_t.imaal004
DEFINE g_axc_00379    LIKE gzze_t.gzze003
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcp950.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axc","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axcp950_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcp950 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcp950_init()
 
      #進入選單 Menu (="N")
      CALL axcp950_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcp950
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcp950.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcp950_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   
   #end add-point
 
   LET g_error_show = 1
   LET gwin_curr2 = ui.Window.getCurrent()
   LET gfrm_curr2 = gwin_curr2.getForm()
   CALL cl_schedule_import_4fd()
   CALL cl_set_combo_scc("gzpa003","75")
   IF cl_get_para(g_enterprise,"","E-SYS-0005") = "N" THEN
       CALL cl_set_comp_visible("scheduling_page,history_page",FALSE)
   END IF 
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcp950.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcp950_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_oobal002 LIKE oobal_t.oobal002
   DEFINE l_flag     LIKE type_t.num5
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   INITIALIZE g_master.* TO NULL
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xcjeld,g_master.xcje002,g_master.xcje003,g_master.xcjedocno,g_master.glaacomp, 
             g_master.xcje006,g_master.xcjedocdt 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               #取法人编号
               IF cl_null(g_master.glaacomp) THEN
                  SELECT ooef017 INTO g_master.glaacomp FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_site
               END IF
               
               #取法人所属的主帐套值
               IF cl_null(g_master.xcjeld) THEN
                  CALL s_axcp500_get_ld(g_master.glaacomp) 
                       RETURNING l_success,g_master.xcjeld
               END IF
#               SELECT * INTO g_glaa.* FROM glaa_t #161124-00048#12 mark
               #161124-00048#12 add(s)
               SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,
                      glaamoddt,glaastus,glaald,glaacomp,glaa001,glaa002,glaa003,glaa004,
                      glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,glaa012,glaa013,
                      glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,
                      glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,
                      glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,
                      glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,
                      glaa124,glaa028 INTO g_glaa.* FROM glaa_t
               #161124-00048#12 add(e)
                WHERE glaaent = g_enterprise 
                  AND glaald  = g_master.xcjeld
               
               #取当期的年度/期别及日期范围
               IF cl_null(g_master.xcje002) OR g_master.xcje002=0 OR cl_null(g_master.xcje003) OR g_master.xcje003=0 THEN
                  LET g_master.xcje002 = g_glaa.glaa010 #年
                  LET g_master.xcje003 = g_glaa.glaa011 #期
               END IF
               
               #单据日期
               IF cl_null(g_master.xcjedocdt) THEN
                  LET g_master.xcjedocdt = g_today
               END IF
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcjeld
            
            #add-point:AFTER FIELD xcjeld name="input.a.xcjeld"
            CALL axcp950_chk_column('xcjeld') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            IF NOT cl_null(g_master.xcjeld) THEN
               CALL s_desc_get_ld_desc(g_master.xcjeld) RETURNING g_master.xcjeld_desc #帳別編號
               DISPLAY g_master.xcjeld_desc TO xcjeld_desc
               
#               SELECT * INTO g_glaa.* FROM glaa_t #161124-00048#12 mark
               #161124-00048#12 add(s)
               SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,
                      glaamoddt,glaastus,glaald,glaacomp,glaa001,glaa002,glaa003,glaa004,
                      glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,glaa012,glaa013,
                      glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,
                      glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,
                      glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,
                      glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,
                      glaa124,glaa028 INTO g_glaa.* FROM glaa_t
               #161124-00048#12 add(e)
                WHERE glaaent = g_enterprise 
                  AND glaald  = g_master.xcjeld
               #160805-00006#1---add---s
               LET g_master.glaacomp = g_glaa.glaacomp
               CALL s_desc_get_department_desc(g_master.glaacomp) RETURNING g_master.glaacomp_desc  #法人組織
               DISPLAY g_master.glaacomp_desc TO glaacomp_desc
               #160805-00006#1---add---e               
            ELSE
               DISPLAY '' TO xcjeld_desc
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcjeld
            #add-point:BEFORE FIELD xcjeld name="input.b.xcjeld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcjeld
            #add-point:ON CHANGE xcjeld name="input.g.xcjeld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcje002
            #add-point:BEFORE FIELD xcje002 name="input.b.xcje002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcje002
            
            #add-point:AFTER FIELD xcje002 name="input.a.xcje002"
            CALL axcp950_chk_column('xcje002') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcje002
            #add-point:ON CHANGE xcje002 name="input.g.xcje002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcje003
            #add-point:BEFORE FIELD xcje003 name="input.b.xcje003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcje003
            
            #add-point:AFTER FIELD xcje003 name="input.a.xcje003"
            CALL axcp950_chk_column('xcje003') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcje003
            #add-point:ON CHANGE xcje003 name="input.g.xcje003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcjedocno
            #add-point:BEFORE FIELD xcjedocno name="input.b.xcjedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcjedocno
            
            #add-point:AFTER FIELD xcjedocno name="input.a.xcjedocno"
            IF cl_null(g_master.xcjeld) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axc-00746'  #请先维护账别资料
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD xcjeld
            END IF
            IF NOT cl_null(g_master.xcjedocno) THEN
               IF NOT s_aooi200_fin_chk_docno(g_master.xcjeld,'','',g_master.xcjedocno,g_master.xcjedocdt,'axct950') THEN
                  NEXT FIELD CURRENT
               END IF
               #CALL s_aooi200_get_slip_desc(g_master.xcjedocno) RETURNING g_master.xcjedocno_desc
               #DISPLAY g_master.xcjedocno_desc TO xcjedocno_desc
            ELSE
               #DISPLAY '' TO xcjedocno_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcjedocno
            #add-point:ON CHANGE xcjedocno name="input.g.xcjedocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacomp
            
            #add-point:AFTER FIELD glaacomp name="input.a.glaacomp"
            CALL axcp950_chk_column('glaacomp') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            IF NOT cl_null(g_master.glaacomp) THEN
               CALL s_desc_get_department_desc(g_master.glaacomp) RETURNING g_master.glaacomp_desc  #法人組織
               DISPLAY g_master.glaacomp_desc TO glaacomp_desc
            ELSE
               DISPLAY '' TO glaacomp_desc
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp name="input.b.glaacomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaacomp
            #add-point:ON CHANGE glaacomp name="input.g.glaacomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcje006
            
            #add-point:AFTER FIELD xcje006 name="input.a.xcje006"
            CALL axcp950_chk_column('xcje006') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            
            IF NOT cl_null(g_master.xcje006) THEN
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xcje006
               CALL ap_ref_array2(g_ref_fields," SELECT xcjal003 FROM xcjal_t WHERE xcjalent = '"
                   ||g_enterprise||"' AND xcjal001 = ? AND xcjal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xcje006_desc = g_rtn_fields[1]
               DISPLAY g_master.xcje006_desc TO xcje006_desc
            ELSE
               DISPLAY '' TO xcje006_desc
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcje006
            #add-point:BEFORE FIELD xcje006 name="input.b.xcje006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcje006
            #add-point:ON CHANGE xcje006 name="input.g.xcje006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcjedocdt
            #add-point:BEFORE FIELD xcjedocdt name="input.b.xcjedocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcjedocdt
            
            #add-point:AFTER FIELD xcjedocdt name="input.a.xcjedocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcjedocdt
            #add-point:ON CHANGE xcjedocdt name="input.g.xcjedocdt"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xcjeld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcjeld
            #add-point:ON ACTION controlp INFIELD xcjeld name="input.c.xcjeld"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            IF NOT cl_null(g_master.glaacomp) THEN
               LET g_qryparam.where = " glaacomp = '",g_master.glaacomp,"'"
            END IF
            CALL q_authorised_ld()                #呼叫開窗
            LET g_master.xcjeld = g_qryparam.return1
            DISPLAY g_master.xcjeld TO xcjeld  #顯示到畫面上

            CALL s_desc_get_ld_desc(g_master.xcjeld) RETURNING g_master.xcjeld_desc #帳別編號
            DISPLAY g_master.xcjeld_desc TO xcjeld_desc
            #160805-00006#1---add---s
            IF NOT cl_null(g_master.xcjeld) THEN
               CALL s_desc_get_ld_desc(g_master.xcjeld) RETURNING g_master.xcjeld_desc #帳別編號
               DISPLAY g_master.xcjeld_desc TO xcjeld_desc
               
#               SELECT * INTO g_glaa.* FROM glaa_t #161124-00048#12 mark
              #161124-00048#12 add(s)
               SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,
                      glaamoddt,glaastus,glaald,glaacomp,glaa001,glaa002,glaa003,glaa004,
                      glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,glaa012,glaa013,
                      glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,
                      glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,
                      glaa112,glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,
                      glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,
                      glaa124,glaa028 INTO g_glaa.* FROM glaa_t
               #161124-00048#12 add(e)
                WHERE glaaent = g_enterprise 
                  AND glaald  = g_master.xcjeld
               LET g_master.glaacomp = g_glaa.glaacomp
               CALL s_desc_get_department_desc(g_master.glaacomp) RETURNING g_master.glaacomp_desc  #法人組織
               DISPLAY g_master.glaacomp_desc TO glaacomp_desc              
            END IF            
            #160805-00006#1---add---e
            NEXT FIELD xcjeld                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xcje002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcje002
            #add-point:ON ACTION controlp INFIELD xcje002 name="input.c.xcje002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcje003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcje003
            #add-point:ON ACTION controlp INFIELD xcje003 name="input.c.xcje003"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcjedocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcjedocno
            #add-point:ON ACTION controlp INFIELD xcjedocno name="input.c.xcjedocno"
            IF cl_null(g_glaa.glaa024) THEN  #單據別參照表號
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axc-00746'  #请先维护账别资料
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD xcjeld
            END IF
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xcjedocno             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_glaa.glaa024
            LET g_qryparam.arg2 = 'axct950'
            CALL q_ooba002_1()                                #呼叫開窗
            LET g_master.xcjedocno = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_master.xcjedocno TO xcjedocno              #顯示到畫面上
            
            #CALL s_aooi200_get_slip_desc(g_master.xcjedocno) RETURNING g_master.xcjedocno_desc
            #DISPLAY BY NAME g_master.xcjedocno_desc

            NEXT FIELD xcjedocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.glaacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp name="input.c.glaacomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_2()                      #呼叫開窗
            LET g_master.glaacomp = g_qryparam.return1
            DISPLAY g_master.glaacomp TO glaacomp  #顯示到畫面上

            CALL s_desc_get_department_desc(g_master.glaacomp) RETURNING g_master.glaacomp_desc #法人組織
            DISPLAY g_master.glaacomp_desc TO glaacomp_desc

            NEXT FIELD glaacomp                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xcje006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcje006
            #add-point:ON ACTION controlp INFIELD xcje006 name="input.c.xcje006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_xcja001()              #呼叫開窗
            LET g_master.xcje006 = g_qryparam.return1
            DISPLAY g_master.xcje006 TO xcje006  #顯示到畫面上

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xcje006
            CALL ap_ref_array2(g_ref_fields," SELECT xcjal003 FROM xcjal_t WHERE xcjalent = '"
                ||g_enterprise||"' AND xcjal001 = ? AND xcjal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xcje006_desc = g_rtn_fields[1]
            DISPLAY g_master.xcje006_desc TO xcje006_desc

            NEXT FIELD xcje006                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xcjedocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcjedocdt
            #add-point:ON ACTION controlp INFIELD xcjedocdt name="input.c.xcjedocdt"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            CALL axcp950_chk_column('glaacomp+xcjeld') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD xcjeld
            END IF
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON xcjf013
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcjf013
            #add-point:BEFORE FIELD xcjf013 name="construct.b.xcjf013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcjf013
            
            #add-point:AFTER FIELD xcjf013 name="construct.a.xcjf013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcjf013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcjf013
            #add-point:ON ACTION controlp INFIELD xcjf013 name="construct.c.xcjf013"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #如果要抓非最末级的，将下面ooed004改成ooed005就可以了
            CASE g_xcja.xcja003 
               WHEN '1'   #部门
			           LET g_qryparam.where = " ooef203 = 'Y' AND ooefstus='Y' ",
                                           " AND (ooef017 ='",g_glaa.glaacomp,"' OR ooef017 = 'ALL') "   #法人
                                           #170105-00002#1 mark --s
			                                  #" AND EXISTS (SELECT 1 FROM ooed_t ",  #范围限定在aooi110中
			                                  #"              WHERE ooedent = ooefent AND ooed004 = ooef001 ",
			                                  #") " 
                                           #170105-00002#1 mark --e
               WHEN '2'   #组织
			           LET g_qryparam.where = " ooef201 = 'Y' AND ooefstus='Y' ",
                                           " AND (ooef017 ='",g_glaa.glaacomp,"' OR ooef017 = 'ALL') "   #法人
                                           #170105-00002#1 mark --s
			                                  #" AND EXISTS (SELECT 1 FROM ooed_t ",  #范围限定在aooi110中
			                                  #"              WHERE ooedent = ooefent AND ooed004 = ooef001 ",
			                                  #") " 
                                           #170105-00002#1 mark --e
            END CASE
#			   CALL q_ooef001_10()                    #161019-00017#7 marked
			   CALL q_ooef001()                    #161019-00017#7 add
            DISPLAY g_qryparam.return1 TO xcjf016  #顯示到畫面上
            NEXT FIELD xcjf016                    #返回原欄位
            #END add-point
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc2 ON xcjf016
            BEFORE CONSTRUCT

         ON ACTION controlp INFIELD xcjf016
            #add-point:ON ACTION controlp INFIELD xcjf013
			   #料
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_imaa001_22()  
            DISPLAY g_qryparam.return1 TO xcjf016  #顯示到畫面上
            NEXT FIELD xcjf016                    #返回原欄位
            #END add-point
 
 
            
            #add-point:其他管控

            #end add-point
            
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL axcp950_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            
            #end add-point
 
         ON ACTION batch_execute
            LET g_action_choice = "batch_execute"
            ACCEPT DIALOG
 
         #add-point:ui_dialog段before_qbeclear name="ui_dialog.before_qbeclear"
         
         #end add-point
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE g_master.* TO NULL   #畫面變數清空
            INITIALIZE lc_param.* TO NULL   #傳遞參數變數清空
            #add-point:ui_dialog段qbeclear name="ui_dialog.qbeclear"
            
            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM   
         INITIALIZE g_master.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL axcp950_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      
      #end add-point
 
      LET ls_js = util.JSON.stringify(lc_param)  #r類使用g_master/p類使用lc_param
 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      ELSE
         IF g_chk_jobid THEN 
            LET g_jobid = g_schedule.gzpa001
         ELSE 
            LET g_jobid = cl_schedule_get_jobid(g_prog)
         END IF 
 
         #依照指定模式執行報表列印
         CASE 
            WHEN g_schedule.gzpa003 = "0"
                 CALL axcp950_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcp950_transfer_argv(ls_js)
                 CALL cl_cmdrun(ls_js)
 
            WHEN g_schedule.gzpa003 = "2"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
 
            WHEN g_schedule.gzpa003 = "3"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
         END CASE  
 
         IF g_schedule.gzpa003 = "2" OR g_schedule.gzpa003 = "3" THEN 
            CALL cl_ask_confirm3("std-00014","") #設定完成
         END IF    
         LET g_schedule.gzpa003 = "0" #預設一開始 立即於前景執行
 
         #add-point:ui_dialog段after schedule name="process.after_schedule"
         
         #end add-point
 
         #欄位初始資訊 
         CALL cl_schedule_init_info("all",g_schedule.gzpa003) 
         LET gi_hiden_asign = FALSE 
         LET gi_hiden_exec = FALSE 
         LET gi_hiden_spec = FALSE 
         LET gi_hiden_exec_end = FALSE 
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axcp950.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcp950_transfer_argv(ls_js)
 
   #add-point:transfer_agrv段define (客製用) name="transfer_agrv.define_customerization"
   
   #end add-point
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog       STRING,
             actionid   STRING,
             background LIKE type_t.chr1,
             param      DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter
   #add-point:transfer_agrv段define name="transfer_agrv.define"
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容 name="transfer.argv.define"
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="axcp950.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcp950_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success     LIKE type_t.num5
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"

   #取当期的起始及截止日期
   CALL s_fin_date_get_period_range(g_glaa.glaa003,g_master.xcje002,g_master.xcje003)
        RETURNING g_bdate,g_edate
   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axcp950_process_cs CURSOR FROM ls_sql
#  FOREACH axcp950_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL axcp950_create_tmp_table() RETURNING l_success
      IF l_success THEN
         CALL cl_err_collect_init() #汇总错误讯息初始化
         
         CALL s_transaction_begin()
         CALL axcp950_process_do() RETURNING l_success
         IF l_success THEN
            CALL s_transaction_end('Y',1)
         ELSE
            CALL s_transaction_end('N',1)
         END IF     
         CALL cl_err_collect_show() #显示错误讯息汇总
      END IF
      CALL axcp950_drop_tmp_table()
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      CALL axcp950_create_tmp_table() RETURNING l_success
      IF NOT l_success THEN
         CALL cl_err_collect_init() #汇总错误讯息初始化
         
         CALL s_transaction_begin()
         CALL axcp950_process_do() RETURNING l_success
         IF l_success THEN
	         CALL s_transaction_end('Y',1)
	      ELSE
	         CALL s_transaction_end('N',1)
	      END IF
	      
         CALL cl_err_collect_show() #显示错误讯息汇总
	   END IF
      CALL axcp950_drop_tmp_table()
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axcp950_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp950.get_buffer" >}
PRIVATE FUNCTION axcp950_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xcjeld = p_dialog.getFieldBuffer('xcjeld')
   LET g_master.xcje002 = p_dialog.getFieldBuffer('xcje002')
   LET g_master.xcje003 = p_dialog.getFieldBuffer('xcje003')
   LET g_master.xcjedocno = p_dialog.getFieldBuffer('xcjedocno')
   LET g_master.glaacomp = p_dialog.getFieldBuffer('glaacomp')
   LET g_master.xcje006 = p_dialog.getFieldBuffer('xcje006')
   LET g_master.xcjedocdt = p_dialog.getFieldBuffer('xcjedocdt')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcp950.msgcentre_notify" >}
PRIVATE FUNCTION axcp950_msgcentre_notify()
 
   #add-point:process段define (客製用) name="msgcentre_notify.define_customerization"
   
   #end add-point
   DEFINE lc_state LIKE type_t.chr5
   #add-point:process段define name="msgcentre_notify.define"
   
   #end add-point
 
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = "process"
 
   #add-point:msgcentre其他通知 name="msg_centre.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp950.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#
PRIVATE FUNCTION axcp950_chk_column(p_column)
   DEFINE p_column      LIKE type_t.chr100
   DEFINE r_success     LIKE type_t.num5


   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   CASE p_column
      WHEN 'xcjeld'    #帐套
           IF NOT cl_null(g_master.xcjeld) THEN
              #160805-00006#1---add---s
              IF NOT cl_null(g_master.glaacomp) THEN 
                 #校验
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_chkparam.arg1 = g_master.xcjeld
                 LET g_chkparam.arg2 = g_master.glaacomp
                 #160318-00025#8--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
                  #160318-00025#8--add--end
                 IF NOT cl_chk_exist("v_glaald_5") THEN
                    LET r_success = FALSE
                    RETURN r_success
                 END IF 
              ELSE 
              #160805-00006#1---add---e              
                 #校验
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_chkparam.arg1 = g_master.xcjeld
                 #160318-00025#8--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
                  #160318-00025#8--add--end
                 IF NOT cl_chk_exist("v_glaald") THEN
                    LET r_success = FALSE
                    RETURN r_success
                 END IF
              END IF   #160805-00006#1 add
           END IF
      WHEN 'glaacomp'  #法人
           IF NOT cl_null(g_master.glaacomp) THEN
              #160805-00006#1---add---s
              IF NOT cl_null(g_master.xcjeld) THEN
                 #校验
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_chkparam.arg1 = g_master.xcjeld
                 LET g_chkparam.arg2 = g_master.glaacomp
                 #160318-00025#8--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
                  #160318-00025#8--add--end
                 IF NOT cl_chk_exist("v_glaald_5") THEN
                    LET r_success = FALSE
                    RETURN r_success
                 END IF 
              ELSE 
              #160805-00006#1---add---e               
                 #校验
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_chkparam.arg1 = g_master.glaacomp
                 IF NOT cl_chk_exist("v_ooef001_1") THEN
                    LET r_success = FALSE
                    RETURN r_success
                 END IF
              END IF  #160805-00006#1---add
           END IF
      WHEN 'glaacomp+xcjeld'  #法人+帐套
           IF NOT cl_null(g_master.glaacomp) AND NOT cl_null(g_master.xcjeld) THEN
              #校验
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = g_master.xcjeld
              LET g_chkparam.arg2 = g_master.glaacomp
              #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#8--add--end
              IF NOT cl_chk_exist("v_glaald_5") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcje002'  #年度
           IF NOT cl_null(g_master.xcje002) THEN
              IF NOT s_fin_date_chk_year(g_master.xcje002) THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcje003'  #期别
           IF NOT cl_null(g_master.xcje003) THEN
              IF NOT s_fin_date_chk_month(g_master.xcje003) THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcje006'   #计算类型
           IF NOT cl_null(g_master.xcje006) THEN
              #校验
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = g_master.xcje006
              IF NOT cl_chk_exist("v_xcja001") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
              #检查axci950中资料是否缺失，xcja008='2'时xcja009不能为空
#              SELECT * INTO g_xcja.* FROM xcja_t  #161124-00048#12 mark
              #161124-00048#12 add(s)
              SELECT xcjaent,xcja001,xcja002,xcja003,xcja004,xcja005,xcja006,xcja007,xcja008,
                     xcja009,xcja010,xcjaownid,xcjaowndp,xcjacrtid,xcjacrtdp,xcjacrtdt,xcjamodid,
                     xcjamoddt,xcjastus,xcja011 
                INTO g_xcja.* FROM xcja_t
              #161124-00048#12 add(e)
               WHERE xcjaent = g_enterprise
                 AND xcja001 = g_master.xcje006
              IF g_xcja.xcja008 = '2' AND cl_null(g_xcja.xcja009) THEN #计算方法=对比法&对比成本计算类型为空
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.replace[1] = g_master.xcje006
                 LET g_errparam.code = 'axc-00750'  #请先维护账别资料
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
   END CASE
   RETURN r_success
END FUNCTION

#
PRIVATE FUNCTION axcp950_process_do()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   
   LET r_success = TRUE
   
   #进度显示--开始
   SELECT COUNT(*) INTO l_cnt FROM axcp950_xcck
   LET g_cnt = l_cnt
   #160616-00006#4 add--s
   SELECT COUNT(UNIQUE xcck006||xcck007||xcck008||xcck047||xcck010||xcck015||xcck017||xcck043||xcck046||sfaa017||ooeg004||sfaa068)  INTO l_cnt
     FROM axcp950_xcck,sfaa_t,ooeg_t
    WHERE xcck047 IS NOT NULL 
      AND xcck020 IN ('110','111','112','113','114') 
      AND xcckent = sfaaent 
      AND xcck047 = sfaadocno  #工单
      AND ooegent = sfaaent
      AND ooeg001 = sfaa017    #部门
      AND ooeg004 IS NOT NULL
      AND ooeg004!= sfaa068
   LET g_cnt = g_cnt + l_cnt
   
   SELECT UNIQUE COUNT(UNIQUE sffbdocno||sffb005||sffb029||sfaa017||a.ooeg004||sffb003||b.ooeg004||sffb017||sffb016)  INTO l_cnt
     FROM sffb_t,sfaa_t,ooeg_t a,ooeg_t b
    WHERE sffbent = g_enterprise
      AND sffbsite = g_site
      AND sffbdocdt BETWEEN g_bdate AND g_edate
      AND sffbstus = 'Y'
      AND sffb005 = sfaadocno   #工单
      AND sffbent = sfaaent
      AND a.ooegent = sfaaent
      AND a.ooeg001 = sfaa017   #生产部门
      AND a.ooeg004 IS NOT NULL
      AND b.ooegent = sffbent
      AND b.ooeg001 = sffb003   #报工部门
      AND b.ooeg004 IS NOT NULL
      AND a.ooeg004!= b.ooeg004
   LET g_cnt = g_cnt + l_cnt
   #160616-00006#4 add--e
   IF g_xcja.xcja010 = 'Y' AND g_xcja.xcja005 != '2' THEN
      SELECT COUNT(*) INTO l_cnt FROM axcp950_xccq
      LET g_cnt = g_cnt + l_cnt
   END IF
   IF g_cnt = 0 THEN
      #无合乎条件资料!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = 'afa-00067'
      LET g_errparam.extend = ''
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET g_has_cnt = 0
   LET g_left_cnt = g_cnt
   DISPLAY g_cnt TO FORMONLY.cnt
   DISPLAY g_has_cnt TO FORMONLY.has_cnt
   DISPLAY g_left_cnt TO FORMONLY.left_cnt
   IF g_bgjob <> "Y" THEN
      CALL cl_progress_bar_no_window(g_cnt)
   END IF
   LET g_axc_00379 = cl_getmsg('axc-00379',g_dlang)  #结存
   
   #已有资料的处理
   SELECT COUNT(*) INTO l_cnt
     FROM xcje_t
    WHERE xcjeent = g_enterprise
      AND xcjeld  = g_master.xcjeld    #账套
      AND xcje002 = g_master.xcje002   #年度
      AND xcje003 = g_master.xcje003   #期别
      AND xcje006 = g_master.xcje006   #计算类型(版本)
      AND xcjestus <> 'X'    #160805-00006#1
   IF l_cnt > 0 THEN
      #若有資料詢問是否刪除重生?
      IF NOT cl_ask_confirm("afm-00111") THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         DELETE FROM xcje_t
          WHERE xcjeent = g_enterprise
            AND xcjeld  = g_master.xcjeld    #账套
            AND xcje002 = g_master.xcje002   #年度
            AND xcje003 = g_master.xcje003   #期别
            AND xcje006 = g_master.xcje006   #计算类型(版本)
            AND xcjestus <> 'X'    #160805-00006#1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.extend = "del xcje_t"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         DELETE FROM xcjf_t
          WHERE NOT EXISTS (SELECT 1 FROM xcje_t
                             WHERE xcjeent = xcjfent
                               AND xcjeld  = xcjfld
                               AND xcjedocno=xcjfdocno)
            AND xcjfent = g_enterprise #160902-00048#4
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.extend = "del xcjf_t"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
   END IF
   
   #ins xcje
   CALL axcp950_ins_xcje() RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #ins xcjf
   #1.计算各异动类型xcck
   #2.计算库存结存xccq
   CALL axcp950_ins_xcjf() RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #产生分录底稿
   CALL axcp950_gen_pre() RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

#ins xcje
PRIVATE FUNCTION axcp950_ins_xcje()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   
   LET r_success = TRUE
   
   INITIALIZE g_xcje.* TO NULL   #變數清空
   LET g_xcje.xcjeent   = g_enterprise    #企业编号
	LET g_xcje.xcjedocdt = g_master.xcjedocdt    #单据日期
	#LET g_xcje.xcjesite  =     #账务中心
   CALL s_fin_get_account_center('',g_user,'3',g_xcje.xcjedocdt) RETURNING l_success,g_xcje.xcjesite,g_errno
	LET g_xcje.xcjeld    = g_master.xcjeld    #账套
	LET g_xcje.xcje001   = '1'    #来源类型:1.自动计算
	LET g_xcje.xcje002   = g_master.xcje002    #年度
	LET g_xcje.xcje003   = g_master.xcje003    #期别
	LET g_xcje.xcje004   = ''    #凭证号码
	LET g_xcje.xcje005   = ''    #凭证日期
	LET g_xcje.xcje006   = g_master.xcje006    #计算类型(版本)
	LET g_xcje.xcje007   = g_user    #账务人员
	LET g_xcje.xcjeownid = g_user    #资料所有者
	LET g_xcje.xcjeowndp = g_dept    #资料所有部门
	LET g_xcje.xcjecrtid = g_user    #资料建立者
	LET g_xcje.xcjecrtdp = g_dept    #资料建立部门
	LET g_xcje.xcjecrtdt = cl_get_current() #资料创建日
	LET g_xcje.xcjemodid = ''    #资料修改者
	LET g_xcje.xcjemoddt = ''    #最近修改日
	LET g_xcje.xcjecnfid = ''    #资料确认者
	LET g_xcje.xcjecnfdt = ''    #数据确认日
	LET g_xcje.xcjepstid = ''    #资料过账者
	LET g_xcje.xcjepstdt = ''    #资料过账日
	LET g_xcje.xcjestus  = 'N'   #状态码
	LET g_xcje.xcjeud021 = ''    #自定义字段(日期时间)
	LET g_xcje.xcjeud022 = ''    #自定义字段(日期时间)
	LET g_xcje.xcjeud023 = ''    #自定义字段(日期时间)
	LET g_xcje.xcjeud024 = ''    #自定义字段(日期时间)
	LET g_xcje.xcjeud025 = ''    #自定义字段(日期时间)
	LET g_xcje.xcjeud026 = ''    #自定义字段(日期时间)
	LET g_xcje.xcjeud027 = ''    #自定义字段(日期时间)
	LET g_xcje.xcjeud028 = ''    #自定义字段(日期时间)
	LET g_xcje.xcjeud029 = ''    #自定义字段(日期时间)
	LET g_xcje.xcjeud030 = ''    #自定义字段(日期时间)
	LET g_xcje.xcjedocno = g_master.xcjedocno    #单据编号
	#CALL s_aooi200_gen_docno(g_master.glaacomp,g_xcje.xcjedocno,g_xcje.xcjedocdt,'axct950')
	CALL s_aooi200_fin_gen_docno(g_xcje.xcjeld,'','',g_xcje.xcjedocno,g_xcje.xcjedocdt,'axct950')
      RETURNING l_success,g_xcje.xcjedocno
   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = g_xcje.xcjedocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
#   INSERT INTO xcje_t VALUES g_xcje.*  #161124-00048#12 mark
   #161124-00048#12 add(s)
   INSERT INTO xcje_t(xcjeent,xcjesite,xcjeld,xcjedocno,xcjedocdt,xcje001,xcje002,xcje003,
                      xcje004,xcje005,xcje006,xcje007,xcjeownid,xcjeowndp,xcjecrtid,xcjecrtdp,
                      xcjecrtdt,xcjemodid,xcjemoddt,xcjecnfid,xcjecnfdt,xcjepstid,xcjepstdt,xcjestus,
                      xcjeud001,xcjeud002,xcjeud003,xcjeud004,xcjeud005,xcjeud006,xcjeud007,xcjeud008,
                      xcjeud009,xcjeud010,xcjeud011,xcjeud012,xcjeud013,xcjeud014,xcjeud015,xcjeud016,
                      xcjeud017,xcjeud018,xcjeud019,xcjeud020,xcjeud021,xcjeud022,xcjeud023,xcjeud024,
                      xcjeud025,xcjeud026,xcjeud027,xcjeud028,xcjeud029,xcjeud030) 
               VALUES(g_xcje.xcjeent,g_xcje.xcjesite,g_xcje.xcjeld,g_xcje.xcjedocno,g_xcje.xcjedocdt,g_xcje.xcje001,g_xcje.xcje002,g_xcje.xcje003,
                      g_xcje.xcje004,g_xcje.xcje005,g_xcje.xcje006,g_xcje.xcje007,g_xcje.xcjeownid,g_xcje.xcjeowndp,g_xcje.xcjecrtid,g_xcje.xcjecrtdp,
                      g_xcje.xcjecrtdt,g_xcje.xcjemodid,g_xcje.xcjemoddt,g_xcje.xcjecnfid,g_xcje.xcjecnfdt,g_xcje.xcjepstid,g_xcje.xcjepstdt,g_xcje.xcjestus,
                      g_xcje.xcjeud001,g_xcje.xcjeud002,g_xcje.xcjeud003,g_xcje.xcjeud004,g_xcje.xcjeud005,g_xcje.xcjeud006,g_xcje.xcjeud007,g_xcje.xcjeud008,
                      g_xcje.xcjeud009,g_xcje.xcjeud010,g_xcje.xcjeud011,g_xcje.xcjeud012,g_xcje.xcjeud013,g_xcje.xcjeud014,g_xcje.xcjeud015,g_xcje.xcjeud016,
                      g_xcje.xcjeud017,g_xcje.xcjeud018,g_xcje.xcjeud019,g_xcje.xcjeud020,g_xcje.xcjeud021,g_xcje.xcjeud022,g_xcje.xcjeud023,g_xcje.xcjeud024,
                      g_xcje.xcjeud025,g_xcje.xcjeud026,g_xcje.xcjeud027,g_xcje.xcjeud028,g_xcje.xcjeud029,g_xcje.xcjeud030) 
   #161124-00048#12 add(e)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins xcje'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

#ins xcjf
#1.计算各异动类型xcck
#2.计算库存结存xccq
PRIVATE FUNCTION axcp950_ins_xcjf()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   #add 160616-00006#4 --s
   DEFINE l_xcck006   LIKE xcck_t.xcck006  #异动单
   DEFINE l_xcck007   LIKE xcck_t.xcck007  #项次
   DEFINE l_xcck008   LIKE xcck_t.xcck008  #项序
   DEFINE l_xcck047   LIKE xcck_t.xcck047  #工单
   DEFINE l_xcck010   LIKE xcck_t.xcck010  #料
   DEFINE l_xcck011   LIKE xcck_t.xcck011  #特征
   DEFINE l_xcck015   LIKE xcck_t.xcck015  #仓
   DEFINE l_xcck016   LIKE xcck_t.xcck016  #储
   DEFINE l_xcck017   LIKE xcck_t.xcck017  #批
   DEFINE l_xcck043   LIKE xcck_t.xcck043  #交易数量
   DEFINE l_xcck046   LIKE xcck_t.xcck046  #交易单位
   DEFINE l_sfaa017   LIKE sfaa_t.sfaa017
   DEFINE l_ooeg004   LIKE ooeg_t.ooeg004
   DEFINE l_sfaa068   LIKE sfaa_t.sfaa068
   DEFINE l_sfaa012   LIKE sfaa_t.sfaa012
   DEFINE l_sfaa013   LIKE sfaa_t.sfaa013
   
   DEFINE l_sffb029       LIKE sffb_t.sffb029  #报工料号
   DEFINE l_sffbdocno     LIKE sffb_t.sffbdocno
   DEFINE l_sffb005       LIKE sffb_t.sffb005
   DEFINE l_ooeg004_sfaa  LIKE ooeg_t.ooeg004
   DEFINE l_sffb003       LIKE sffb_t.sffb003
   DEFINE l_ooeg004_sffb  LIKE ooeg_t.ooeg004
   DEFINE l_sffb017       LIKE sffb_t.sffb017
   DEFINE l_sffb016       LIKE sffb_t.sffb016
   #add 160616-00006#4 --e

   LET r_success = TRUE
   LET l_success = TRUE
   
   #----------------------------------------------------------------------------------------------
   #1.计算各异动类型xcck
   #----------------------------------------------------------------------------------------------
   #axcp950_xcck的栏位：xcck_t.*,center,ob_center,xcjb007,xcjb008,xcjb009,imaa006,xccc010,xccc280,inaj017,inaj035
   #xcjc006:分摊组织，xcjc007:分摊比率
   #已经筛除重复的
#   LET g_sql = " SELECT axcp950_xcck.*,xcjc006,xcjc007 ",  #161124-00048#12 mark
    #161124-00048#12 add(s)
    LET g_sql =" SELECT xcckent,xccksite,xcckcomp,xcckld,xcck001,xcck002,xcck003,xcck004,xcck005,xcck006,xcck007,xcck008,  ",
               "         xcck009,xcck010,xcck011,xcck012,xcck013,xcck014,xcck015,xcck016,xcck017,xcck020,xcck021,xcck022,  ",
               "         xcck023,xcck024,xcck025,xcck026,xcck027,xcck028,xcck029,xcck030,xcck031,xcck032,xcck033,xcck034,  ",
               "         xcck040,xcck041,xcck042,xcck043,xcck044,xcck045,xcck046,xcck047,xcck048,xcck049,xcck050,xcck051,  ",
               "         xcck055,xcck201,xcck202,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,  ",
               "         xcck282,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,xcck301,xcck302,  ",
               "         xcck302a,xcck302b,xcck302c,xcck302d,xcck302e,xcck302f,xcck302g,xcck302h,xcck901,xcck902,xcck902a, ",
               "         xcck902b,xcck902c,xcck902d,xcck902e,xcck902f,xcck902g,xcck902h,xcck980,xcck980a,xcck980b,xcck980c,",
               "         xcck980d,xcck980e,xcck980f,xcck980g,xcck980h,xcck903,xcck903a,xcck903b,xcck903c,xcck903d,xcck903e,",
               "         xcck903f,xcck903g,xcck903h,xcckownid,xcckowndp,xcckcrtid,xcckcrtdp,xcckcrtdt,xcckmodid,xcckmoddt, ",
               "         xcckstus,xcck056, ",
               "         center,ob_center,xcjb007,xcjb008,xcjb009,imaa006,xccc010,xccc280,inaj017,inaj035, ",  #170105-00002#1 add
               "         xcjc006,xcjc007 ",
    #161124-00048#12 add(e)
    
               "   FROM axcp950_xcck ",
               "        LEFT JOIN xcjc_t ON xcjcent=xcckent ",
               "                        AND xcjc001='",g_master.xcje006,"' ", #计算类型
               "                        AND xcjc002= ",g_master.xcje002,  #年
               "                        AND xcjc003= ",g_master.xcje003,  #期
               "                        AND xcjc004=xcck010 ",   #料
               #mod zhangllc 160729 --s mod前理解为axci952中的组织为利润中心，mod后理解为axci952中的组织为部门
               #"                        AND xcjc005=ob_center ", #销售组织=业务部门所在利润中心
               #"                        AND xcjc006!=ob_center ", #分摊组织！=业务部门所在利润中心
               "                        AND xcjc005=inaj017 ", #销售组织=业务部门
               "                        AND xcjc006!=inaj017 ", #分摊组织！=业务部门
               #mod zhangllc 160729 --e
               "                        AND xcck020 IN ('201','202') ",   #销售类
               "                        AND center = ob_center ",   #销售类的同利润中心才需要用到分摊
               "  ORDER BY xcck006,xcck007,xcck008 "  #单据/项次/项序
   PREPARE axcp950_ins_xcjf_p1 FROM g_sql
   DECLARE axcp950_ins_xcjf_c1 CURSOR FOR axcp950_ins_xcjf_p1
   LET g_seq = 0
   FOREACH axcp950_ins_xcjf_c1 INTO g_xcck.*,g_center,g_ob_center,g_xcjb007,g_xcjb008,g_xcjb009,g_imaa006,g_xccc010,g_xccc280,g_inaj017,g_inaj035,
                                    g_xcjc006,g_xcjc007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach axcp950_ins_xcjf_c1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      LET l_success = TRUE
      #进度条显示
      LET g_has_cnt = g_has_cnt + 1
      LET g_left_cnt = g_left_cnt - 1
      CALL s_desc_get_item_desc(g_xcck.xcck010) RETURNING g_imaal003,g_imaal004
      DISPLAY g_has_cnt TO FORMONLY.has_cnt
      DISPLAY g_left_cnt TO FORMONLY.left_cnt
      DISPLAY g_xcck.xcck010 TO FORMONLY.item
      DISPLAY g_imaal003 TO FORMONLY.item_desc
      #每一笔显示进度及处理作业的说明
      IF g_bgjob <> "Y" THEN
         CALL cl_progress_no_window_ing(g_xcck.xcck006||'/'||g_xcck.xcck007||'/'||g_xcck.xcck008||'/'||g_xcck.xcck009)
      END IF
      
      #根据不同异动类型处理
      CASE #g_xcck.xcck020
         WHEN g_xcck.xcck020 = '201'  #销售出货
              IF cl_null(g_inaj017) THEN
                 #此单据或同类单据缺少异动部门信息,请联系MIS检查其异动记录档中是否写入inaj017信息！！
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'axc-00753'
                 LET g_errparam.extend = g_inaj035,":",g_xcck.xcck006
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 CONTINUE FOREACH
              END IF
              IF cl_null(g_ob_center) THEN
                 #不存在此部门或此部门未设置归属责任中心,请检查[部门维护作业aooi125]!
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'axc-00754'
                 LET g_errparam.extend = g_inaj017
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 CONTINUE FOREACH
              END IF 
              
              IF g_center = g_ob_center THEN
                 #axci952中没有分摊组织，就代表都是业务部门本身的外部收入了，这在销售的时候已经计算过外部收入了，不需再计算
                 #           有分摊组织，就代表销售是已计算过的收入，要分给分摊的组织，本身要扣掉被分摊的那部分
                 IF NOT cl_null(g_xcjc006) THEN
                    CALL axcp950_ins_xcjf_f_xcck('2011')  #销售出货-分摊组织的内部收入增加
                       RETURNING l_success
                    CALL axcp950_ins_xcjf_f_xcck('2012_1')  #销售出货-销售组织的内部成本增加
                       RETURNING l_success
                    CALL axcp950_ins_xcjf_f_xcck('2012_2')  #销售出货-销售组织的外部收入减少
                       RETURNING l_success
                 END IF
              ELSE
                 #销售出货其他成本中心的仓库库存时，增加被领用的内部收入（center），和增加领用的内部成本、减少领用的外部收入（ob_center）
                 CALL axcp950_ins_xcjf_f_xcck('2013')  #销售出货不同利润中心的库存-库存所在利润中心方（center）--增加内部收入
                    RETURNING l_success
                 CALL axcp950_ins_xcjf_f_xcck('2014_1')  #销售出货不同利润中心的库存-申请部门所在利润中心方(ob_center)--增加内部成本
                    RETURNING l_success
                 CALL axcp950_ins_xcjf_f_xcck('2014_2')  #销售出货不同利润中心的库存-申请部门所在利润中心方(ob_center)--减少外部收入(金额为成本金额xccc280)
                    RETURNING l_success
                 #add zhangllc 160617 --s 160616-00006#2
                 IF g_xcja.xcja011='1' THEN
                    CALL axcp950_ins_xcjf_f_xcck('2015')  #销售出货不同利润中心的库存-库存所在利润中心方（center）--增加内部成本（金额为成本金额）
                       RETURNING l_success
                 END IF
                 #add zhangllc 160617 --e
              END IF
         WHEN g_xcck.xcck020 = '202'  #销售退货
              IF cl_null(g_inaj017) THEN
                 #此单据或同类单据缺少异动部门信息,请联系MIS检查其异动记录档中是否写入inaj017信息！！
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'axc-00753'
                 LET g_errparam.extend = g_inaj035,":",g_xcck.xcck006
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 CONTINUE FOREACH
              END IF
              IF cl_null(g_ob_center) THEN
                 #不存在此部门或此部门未设置归属责任中心,请检查[部门维护作业aooi125]!
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'axc-00754'
                 LET g_errparam.extend = g_inaj017
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 CONTINUE FOREACH
              END IF 
              
              IF g_center = g_ob_center THEN
                 #axci952中没有分摊组织，就代表都是业务部门本身的外部收入了，这在销售的时候已经计算过外部收入了，不需再计算
                 #           有分摊组织，就代表销售是已计算过的收入，要分给分摊的组织，本身要扣掉被分摊的那部分
                 IF NOT cl_null(g_xcjc006) THEN
                    CALL axcp950_ins_xcjf_f_xcck('2021')  #销售退货-分摊组织的内部收入减少
                       RETURNING l_success
                    CALL axcp950_ins_xcjf_f_xcck('2022_1')  #销售退货-销售组织的内部成本减少
                       RETURNING l_success
                    CALL axcp950_ins_xcjf_f_xcck('2022_2')  #销售退货-销售组织的外部收入增加
                       RETURNING l_success
                 END IF
              ELSE
                 #销售退货其他成本中心的仓库库存时，减少被领用的内部收入（center），和减少领用的内部成本、增加领用的外部收入（ob_center）
                 CALL axcp950_ins_xcjf_f_xcck('2023')  #销售退货不同利润中心的库存-库存所在利润中心方（center）--减少内部收入
                    RETURNING l_success
                 CALL axcp950_ins_xcjf_f_xcck('2024_1')  #销售退货不同利润中心的库存-申请部门所在利润中心方(ob_center)--减少内部成本
                    RETURNING l_success
                 CALL axcp950_ins_xcjf_f_xcck('2024_2')  #销售退货不同利润中心的库存-申请部门所在利润中心方(ob_center)--增加外部收入(金额为成本金额xccc280)
                    RETURNING l_success
                 #add zhangllc 160617 --s 160616-00006#2
                 IF g_xcja.xcja011='1' THEN
                    CALL axcp950_ins_xcjf_f_xcck('2025')  #销售退货不同利润中心的库存-库存所在利润中心方（center）--减少内部成本（金额为成本金额）
                       RETURNING l_success
                 END IF
                 #add zhangllc 160617 --e
              END IF
         WHEN g_xcck.xcck020 = '401'  #调拨
              #1.移转：只要计算调拨出的利润中心的内部收入，调拨入的利润中心的内部成本不计算。
              #2.投入：要计算调拨出的利润中心的内部收入和调拨入的利润中心的内部成本。
              #入库算成本,出库算收入，此处移转不计算成本
              IF g_xcja.xcja005 = '1' AND g_xcck.xcck009 = 1 THEN
                 CONTINUE FOREACH
              END IF
              
              CALL axcp950_ins_xcjf_f_xcck('401')  #调拨处理
                 RETURNING l_success
         #WHEN g_xcck.xcck020 = '302'  #生产发料
         WHEN g_xcck.xcck020 = '302' AND g_xcja.xcja011='2' #生产发料 #mod zhangllc 160617 160616-00006#2
              IF cl_null(g_inaj017) THEN
                 #此单据或同类单据缺少异动部门信息,请联系MIS检查其异动记录档中是否写入inaj017信息！！
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'axc-00753'
                 LET g_errparam.extend = g_inaj035,":",g_xcck.xcck006
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 CONTINUE FOREACH
              END IF
              IF cl_null(g_ob_center) THEN
                 #不存在此部门或此部门未设置归属责任中心,请检查[部门维护作业aooi125]!
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'axc-00754'
                 LET g_errparam.extend = g_inaj017
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 CONTINUE FOREACH
              END IF 
              
              IF g_center = g_ob_center THEN
                 #发自己成本中心的仓库库存时，
                 #计算依据xcja005=1.移转：计算领用的内部成本
                 #计算依据xcja005=2.投入：不计算领用的内部成本
                 
                 #此处投入时不计算
                 IF g_xcja.xcja005 = '2' THEN
                    CONTINUE FOREACH
                 END IF
                 
                 CALL axcp950_ins_xcjf_f_xcck('3021')  #生产发料
                    RETURNING l_success
              ELSE
                 #发料其他成本中心的仓库库存时，计算领用的内部成本（ob_center），和被领用的内部收入（center）
                 CALL axcp950_ins_xcjf_f_xcck('3022')  #生产发料不同利润中心的库存-库存所在利润中心方（center）
                    RETURNING l_success
                 
                 CALL axcp950_ins_xcjf_f_xcck('3023')  #生产发料不同利润中心的库存-申请部门所在利润中心方(ob_center)
                    RETURNING l_success
              END IF
         #WHEN g_xcck.xcck020 = '303'  #生产退料 生产发料反向
         WHEN g_xcck.xcck020 = '303' AND g_xcja.xcja011='2'  #生产退料 生产发料反向 #mod zhangllc 160617 160616-00006#2
              IF cl_null(g_inaj017) THEN
                 #此单据或同类单据缺少异动部门信息,请联系MIS检查其异动记录档中是否写入inaj017信息！！
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'axc-00753'
                 LET g_errparam.extend = g_inaj035,":",g_xcck.xcck006
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 CONTINUE FOREACH
              END IF
              IF cl_null(g_ob_center) THEN
                 #不存在此部门或此部门未设置归属责任中心,请检查[部门维护作业aooi125]!
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'axc-00754'
                 LET g_errparam.extend = g_inaj017
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 CONTINUE FOREACH
              END IF 
         
              IF g_center = g_ob_center THEN
                 #退自己成本中心的仓库库存时，
                 #计算依据xcja005=1.移转：计算领用的内部成本
                 #计算依据xcja005=2.投入：不计算领用的内部成本
                 
                 #此处投入时不计算
                 IF g_xcja.xcja005 = '2' THEN
                    CONTINUE FOREACH
                 END IF
                 
                 CALL axcp950_ins_xcjf_f_xcck('3031')  #生产退料
                    RETURNING l_success
              ELSE
                 #退料其他成本中心的仓库库存时，计算领用的内部成本（ob_center），和被领用的内部收入（center）
                 CALL axcp950_ins_xcjf_f_xcck('3032')  #生产退料不同利润中心的库存-库存所在利润中心方（center）
                    RETURNING l_success
                 
                 CALL axcp950_ins_xcjf_f_xcck('3033')  #生产退料不同利润中心的库存-申请部门所在利润中心方(ob_center)
                    RETURNING l_success
              END IF
         WHEN g_xcck.xcck020='301' OR g_xcck.xcck020='304' OR (g_xcck.xcck009=-1 AND g_xcck.xcck020='501')  #杂发出库,库存报废,盘亏
              IF cl_null(g_inaj017) THEN
                 #此单据或同类单据缺少异动部门信息,请联系MIS检查其异动记录档中是否写入inaj017信息！！
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'axc-00753'
                 LET g_errparam.extend = g_inaj035,":",g_xcck.xcck006
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 CONTINUE FOREACH
              END IF
              IF cl_null(g_ob_center) THEN
                 #不存在此部门或此部门未设置归属责任中心,请检查[部门维护作业aooi125]!
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'axc-00754'
                 LET g_errparam.extend = g_inaj017
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 CONTINUE FOREACH
              END IF
              
              IF g_center = g_ob_center THEN
                 #杂发自己成本中心的仓库库存时，
                 #计算依据xcja005=1.移转：计算领用的内部成本
                 #计算依据xcja005=2.投入：不计算领用的内部成本
                 
                 #此处投入时不计算
                 IF g_xcja.xcja005 = '2' THEN
                    CONTINUE FOREACH
                 END IF
                 
                 CALL axcp950_ins_xcjf_f_xcck('3011')  #杂发处理
                    RETURNING l_success
              ELSE
                 #杂发其他成本中心的仓库库存时，计算领用的内部成本（ob_center），和被领用的内部收入（center）
                 CALL axcp950_ins_xcjf_f_xcck('3012')  #杂发不同利润中心的库存-库存所在利润中心方（center）
                    RETURNING l_success
                 
                 CALL axcp950_ins_xcjf_f_xcck('3013')  #杂发不同利润中心的库存-申请部门所在利润中心方(ob_center)
                    RETURNING l_success
              END IF
         WHEN g_xcck.xcck020='101' OR (g_xcck.xcck009= 1 AND g_xcck.xcck020='501')  #杂收入库,盘盈
              #1.移转：不计算内部成本
              #2.投入：计算内部成本
              IF g_xcja.xcja005 = '1' THEN
                 CONTINUE FOREACH
              END IF
                 
              CALL axcp950_ins_xcjf_f_xcck('110')  #杂收入库
                 RETURNING l_success
         #WHEN g_xcck.xcck020='115' #当站下线
         WHEN g_xcck.xcck020='115' AND g_xcja.xcja011='2' #当站下线  #mod zhangllc 160617 160616-00006#2
              #1.移转：不计算内部成本
              #2.投入：计算内部成本
              IF g_xcja.xcja005 = '1' THEN
                 CONTINUE FOREACH
              END IF
              
              CALL axcp950_ins_xcjf_f_xcck('115')  #当站下线
                 RETURNING l_success
         WHEN g_xcck.xcck020 = '102'  #采购入库
              #1.移转：不计算内部成本
              #2.投入：计算内部成本
              IF g_xcja.xcja005 = '1' THEN
                 CONTINUE FOREACH
              END IF
              
              CALL axcp950_ins_xcjf_f_xcck('102')  #采购入库
                 RETURNING l_success
         WHEN g_xcck.xcck020 = '103'  #委外入库 同采购入库
              #1.移转：不计算内部成本
              #2.投入：计算内部成本
              IF g_xcja.xcja005 = '1' THEN
                 CONTINUE FOREACH
              END IF
              
              CALL axcp950_ins_xcjf_f_xcck('103')  #采购入库
                 RETURNING l_success
         WHEN g_xcck.xcck020 = '108'  #采购仓退 采购入库的反向
              #1.移转：不计算内部成本
              #2.投入：计算内部成本
              IF g_xcja.xcja005 = '1' THEN
                 CONTINUE FOREACH
              END IF
              
              CALL axcp950_ins_xcjf_f_xcck('108')  #采购入库
                 RETURNING l_success
         #WHEN g_xcck.xcck020 = '110' OR g_xcck.xcck020 = '111' OR g_xcck.xcck020='112' OR g_xcck.xcck020 = '113' OR g_xcck.xcck020 = '114' #生产入库/联产品入库/多产出主件入库/拆件入库/回收入库
         WHEN (g_xcck.xcck020 = '110' OR g_xcck.xcck020 = '111' OR g_xcck.xcck020='112' OR g_xcck.xcck020 = '113' OR g_xcck.xcck020 = '114') AND g_xcja.xcja011='2'  #生产入库/联产品入库/多产出主件入库/拆件入库/回收入库  #mod zhangllc 160617 160616-00006#2
              #1.移转：不计算内部成本
              #2.投入：计算内部成本
              IF g_xcja.xcja005 = '1' THEN
                 CONTINUE FOREACH
              END IF
              
              CALL axcp950_ins_xcjf_f_xcck('110')  #生产入库
                 RETURNING l_success
         #WHEN g_xcck.xcck020='999'  #非库存异动   不发生成本和收入
      END CASE
      IF NOT l_success THEN
         LET r_success = FALSE
      END IF
   END FOREACH
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'foreach axcp950_ins_xcjf_c1'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #add--s 160616-00006#4
   #----------------------------------------------------------------------------------------------
   #3.计算内部加工收入和成本
   #  有2种状况：
   #  第一种：同一法人下A分公司接单给B生产部门做，工单开在A分公司据点下，但由B生产部门负责做，这样A与B之间需要内部结算加工收入和费用。
   #  第二种：同一法人下A分公司接单给B生产部门做，工单开在A分公司据点下，但由B生产部门又把其中某几道工序转给C生产部门负责做，这样除了A与B之间需要内部结算加工收入和费用外，B与C之间也需要内部结算加工收入和费用。
   #----------------------------------------------------------------------------------------------
   #--第一种：同一法人下A分公司接单给B生产部门做，工单开在A分公司据点下，但由B生产部门负责做，这样A与B之间需要内部结算加工收入和费用。
   #工单，生产料号，部门供应商，部门所属成本中心，成本中心,生产数量，生产单位
   LET g_sql = " SELECT UNIQUE xcck006,xcck007,xcck008,xcck047,xcck010,xcck015,xcck017,xcck043,xcck046,sfaa017,ooeg004,sfaa068 ",
               "   FROM axcp950_xcck,sfaa_t,ooeg_t ",
               "  WHERE xcck047 IS NOT NULL ",
               "    AND xcck020 IN ('110','111','112','113','114') ",
               "    AND xcckent = sfaaent   ",
               "    AND xcck047 = sfaadocno ",  #工单
               "    AND ooegent = sfaaent   ",
               "    AND ooeg001 = sfaa017   ",  #部门
               "    AND ooeg004 IS NOT NULL ",
               "    AND ooeg004!= sfaa068   ",
               "  ORDER BY xcck047 " 
   PREPARE axcp950_ins_xcjf_p31 FROM g_sql
   DECLARE axcp950_ins_xcjf_c31 CURSOR FOR axcp950_ins_xcjf_p31
   LET g_seq = 0
   FOREACH axcp950_ins_xcjf_c31 INTO l_xcck006,l_xcck007,l_xcck008,l_xcck047,l_xcck010,l_xcck015,l_xcck017,l_xcck043,l_xcck046,l_sfaa017,l_ooeg004,l_sfaa068
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach axcp950_ins_xcjf_c31'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #进度条显示
      LET g_has_cnt = g_has_cnt + 1
      LET g_left_cnt = g_left_cnt - 1
      CALL s_desc_get_item_desc(l_xcck010) RETURNING g_imaal003,g_imaal004
      DISPLAY g_has_cnt TO FORMONLY.has_cnt
      DISPLAY g_left_cnt TO FORMONLY.left_cnt
      DISPLAY l_xcck010 TO FORMONLY.item
      DISPLAY g_imaal003 TO FORMONLY.item_desc
      #每一笔显示进度及处理作业的说明
      IF g_bgjob <> "Y" THEN
         CALL cl_progress_no_window_ing(l_xcck047||'/'||l_xcck010||'/'||l_ooeg004||'/'||l_sfaa068)
      END IF
      
      CALL axct950_01_ins_xcjf_f_sfaa(g_xcje.xcjeld,g_xcje.xcjedocno,l_xcck006,l_xcck007,l_xcck008,l_xcck047,l_xcck010,l_xcck015,l_xcck017,l_xcck046,l_xcck043,l_ooeg004,l_sfaa068)  RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
      END IF
   END FOREACH
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'foreach axcp950_ins_xcjf_c31'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   #--第二种：同一法人下A分公司接单给B生产部门做，工单开在A分公司据点下，但由B生产部门又把其中某几道工序转给C生产部门负责做，这样除了A与B之间需要内部结算加工收入和费用外，B与C之间也需要内部结算加工收入和费用。
   #                           报工单，   工单，  生产料号，生产部门，成本中心，报工部门，成本中心，报工数量，报工单位
   LET g_sql = " SELECT UNIQUE sffbdocno,sffb005,sffb029,sfaa017,a.ooeg004,sffb003,b.ooeg004,sffb017,sffb016  ",
               "   FROM sffb_t,sfaa_t,ooeg_t a,ooeg_t b ",
               "  WHERE sffbent = ",g_enterprise,
               "    AND sffbdocdt BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND sffbstus = 'Y' ",
               "    AND sffb005 = sfaadocno ",  #工单
               "    AND sffbent = sfaaent   ",
               "    AND a.ooegent = sfaaent  ",
               "    AND a.ooeg001 = sfaa017   ",  #生产部门
               "    AND a.ooeg004 IS NOT NULL ",
               "    AND b.ooegent = sffbent ",
               "    AND b.ooeg001 = sffb003   ",  #报工部门
               "    AND b.ooeg004 IS NOT NULL ",
               "    AND a.ooeg004!= b.ooeg004   ",
               #"    AND EXISTS (SELECT 1 FROM axcp950_center ",  #在利润中心范围内
               #"                 WHERE inaa005 = ooef001 ) ",
               #"    AND ",g_master.wc_bb CLIPPED,
               "  ORDER BY sffbdocno "
   PREPARE axcp950_ins_xcjf_p32 FROM g_sql
   DECLARE axcp950_ins_xcjf_c32 CURSOR FOR axcp950_ins_xcjf_p32
   LET g_seq = 0
   
   FOREACH axcp950_ins_xcjf_c32 INTO l_sffbdocno,l_sffb005,l_sffb029,l_sfaa017,l_ooeg004_sfaa,l_sffb003,l_ooeg004_sffb,l_sffb017,l_sffb016
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach axcp950_ins_xcjf_c32'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      #进度条显示
      LET g_has_cnt = g_has_cnt + 1
      LET g_left_cnt = g_left_cnt - 1
      CALL s_desc_get_item_desc(l_sffb029) RETURNING g_imaal003,g_imaal004
      DISPLAY g_has_cnt TO FORMONLY.has_cnt
      DISPLAY g_left_cnt TO FORMONLY.left_cnt
      DISPLAY l_sffb029 TO FORMONLY.item
      DISPLAY g_imaal003 TO FORMONLY.item_desc
      #每一笔显示进度及处理作业的说明
      IF g_bgjob <> "Y" THEN
         CALL cl_progress_no_window_ing(l_sffbdocno||'/'||l_sffb005||'/'||l_ooeg004_sfaa||'/'||l_ooeg004_sffb)
      END IF
      
      CALL axct950_01_ins_xcjf_f_sffb(g_xcje.xcjeld,g_xcje.xcjedocno,l_sffbdocno,l_sffb005,l_sffb029,l_ooeg004_sfaa,l_ooeg004_sffb,l_sffb017,l_sffb016) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
      END IF
   END FOREACH
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'foreach axcp950_ins_xcjf_c32'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #add--e 160616-00006#4
              
   #----------------------------------------------------------------------------------------------
   #2.计算库存结存xccq
   #----------------------------------------------------------------------------------------------
   #xcja010结存计算否为Y的，且xcja005='1.转移'的才计算
   IF g_xcja.xcja010 = 'N' OR g_xcja.xcja005 = '2' THEN
      RETURN r_success
   END IF
   
   #axcp950_xccq的栏位：
   #成本計算類型/料號/仓库/期末数量/期末金额、仓库对应利润中心/内部交易定价单位/内部交易定价币别/内部交易定价价格
   LET g_sql = " SELECT xccq003,xccq006,xccq010,xccq901,xccq902, ",
               "        center ,xcjb007,xcjb008,xcjb009, ",
               "        imaa006,xccc010,xccc280 ",
               "   FROM axcp950_xccq ",
               #"  GROUP BY xccq003,xccq006,center,xcjb007,xcjb008,xcjb009,imaa006,xccc010,xccc280 ",
               "  ORDER BY xccq006,center "  #料/仓库
   PREPARE axcp950_ins_xcjf_p2 FROM g_sql
   DECLARE axcp950_ins_xcjf_c2 CURSOR FOR axcp950_ins_xcjf_p2
   FOREACH axcp950_ins_xcjf_c2 INTO g_xccq003,g_xccq006,g_xccq010,g_xccq901,g_xccq902,
                                    g_center,g_xcjb007,g_xcjb008,g_xcjb009,g_imaa006,g_xccc010,g_xccc280
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach axcp950_ins_xcjf_c2'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      #进度条显示
      LET g_has_cnt = g_has_cnt + 1
      LET g_left_cnt = g_left_cnt - 1
      CALL s_desc_get_item_desc(g_xccq006) RETURNING g_imaal003,g_imaal004
      DISPLAY g_has_cnt TO FORMONLY.has_cnt
      DISPLAY g_left_cnt TO FORMONLY.left_cnt
      DISPLAY g_xccq006 TO FORMONLY.item
      DISPLAY g_imaal003 TO FORMONLY.item_desc
      #每一笔显示进度及处理作业的说明
      IF g_bgjob <> "Y" THEN
         CALL cl_progress_no_window_ing(g_axc_00379||'：'||g_xccq006||'/'||g_xccq010)
      END IF
      
      CALL axcp950_ins_xcjf_f_xccq()  #库存结存 --仓库所属利润中心的内部成本 金额为正向
         RETURNING l_success

   END FOREACH
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'foreach axcp950_ins_xcjf_c2'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

#产生分录底稿
PRIVATE FUNCTION axcp950_gen_pre()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_ooac004   LIKE ooac_t.ooac004   #參數值

   LET r_success = TRUE
   
   #是否抛傳票
   CALL s_fin_get_doc_para(g_master.xcjeld,g_glaa.glaacomp,g_master.xcjedocno,'D-FIN-0030') RETURNING l_ooac004
   IF l_ooac004 = 'N' THEN
      RETURN r_success
   END IF
   
   IF g_glaa.glaa121 = 'Y' THEN  #子模組啟用分錄底稿
      CALL s_pre_voucher_ins('XC','C10',g_master.xcjeld,g_xcje.xcjedocno,g_xcje.xcjedocdt,'95')  #scc=8920,15内部收入成本，在axct701基础上加
         RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

#建立临时表
PRIVATE FUNCTION axcp950_create_tmp_table()
   DEFINE r_success  LIKE type_t.num5
   
   LET r_success = TRUE
   
   #axcp950_center：参与计算的利润中心临时表
   DROP TABLE axcp950_center; 
   LET g_sql = " SELECT DISTINCT ooef001 ",
               "   FROM ooef_t ",
               "  WHERE ooefent=",g_enterprise,
               "    AND (ooef017 ='",g_glaa.glaacomp,"' OR ooef017 = 'ALL') ",  #法人
               "    AND ooefstus='Y' "
   CASE g_xcja.xcja003 
      WHEN '1'   #部门
	        LET g_sql = g_sql CLIPPED, " AND ooef203 = 'Y' "
                                      #170105-00002#1 mark --s
	                                   #" AND EXISTS (SELECT 1 FROM ooed_t ",  #范围限定在aooi110中
	                                   #"              WHERE ooedent = ooefent AND ooed004 = ooef001 ",
	                                   #") " 
                                      #170105-00002#1 mark --e
      WHEN '2'   #组织
	        LET g_sql = g_sql CLIPPED, " AND ooef201 = 'Y' "
                                      #170105-00002#1 mark --s
	                                   #" AND EXISTS (SELECT 1 FROM ooed_t ",  #范围限定在aooi110中
	                                   #"              WHERE ooedent = ooefent AND ooed004 = ooef001 ",
	                                   #") " 
                                      #170105-00002#1 mark --e
   END CASE
   LET g_master.wc = cl_replace_str(g_master.wc,"xcjf013","ooef001")
	LET g_sql = g_sql CLIPPED," AND ",g_master.wc
	LET g_sql = g_sql CLIPPED," INTO TEMP axcp950_center "  #参与计算的利润中心临时表
   PREPARE axcp950_crt_table_p1 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp950_crt_table_p1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   EXECUTE axcp950_crt_table_p1
   IF SQLCA.sqlcode THEN
      DISPLAY "err code=",SQLCA.sqlerrd[2]
      DISPLAY "err sql=",g_sql
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp950_crt_table_p1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
	
	#axcp950_xcck:参与计算的xcck资料
   DROP TABLE axcp950_xcck; 
   LET g_wc2 = cl_replace_str(g_wc2,"xcjf016","xcck010")  #料
   #xcck_t.*/仓库对应利润中心/对方利润中心/内部交易定价单位/内部交易定价币别/内部交易定价价格
   #异动部门
   LET g_sql = " SELECT xcck_t.*,inaa005 center,xcck025 ob_center, ",
   #                                              单位            币别 先用xcjb的栏位给个空的值，用xcjb007,008主要是引用其栏位类型
               "        xcjb007,xcjb008,0 xcjb009, ",                  #xcjb009交易单价
               "        xcjb007 imaa006,xcjb008 xccc010,0 xccc280,  ", #xccc280实际单价
               "        b.inaj017 inaj017,b.inaj035 inaj035",
               "   FROM xcck_t ",
               "        LEFT JOIN xcjb_t ON xcjbent = xcckent AND xcjb001 = '",g_master.xcje006,"' AND xcjb002 = xcck004 AND xcjb003=xcck005 AND xcjb004 = xcck010 AND xcjb005='ALL' AND xcjb006='ALL'",
               "        LEFT JOIN inaa_t ON inaaent = xcckent AND inaasite = xccksite AND inaa001 = xcck015, ",
               #"        (SELECT * FROM inaj_t ",
               #"          WHERE inajent = ",g_enterprise,
               #"            AND inaj022 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               #"            AND (inaj004 = 1 OR inaj004 = -1) ",
               #"         ) b ",  #缩小范围
               "        inaj_t b ",  #不知为何上面这个缩小范围，程序里执行会报ora-907的错
               "  WHERE b.inajent = xcckent AND b.inajsite = xccksite ",
               "    AND b.inaj001 = xcck006 AND b.inaj002 = xcck007 AND b.inaj003 = xcck008 AND b.inaj004 = xcck009 ",
               "    AND xcckent= ",g_enterprise,
               "    AND xcckld = '",g_master.xcjeld,"' ",
               "    AND xcck004= ",g_master.xcje002,
               "    AND xcck005= ",g_master.xcje003,
               "    AND xcck001= '1' ",  #帐套本位币顺序
               "    AND ",g_wc2,
               "    AND EXISTS (SELECT 1 FROM axcp950_center ",  #在利润中心范围内
               "                 WHERE inaa005 = ooef001 ) ",
               #304库存报废,501盘点,999非库存异动,115当站下线，101杂项收料，301，杂项发料
               #"    AND xcck020 NOT IN ('999') "  #不处理的异动类型
               "    AND xcck020 NOT IN ('999','301','101','115') "  #不处理的异动类型  #mod zhangllc 160721
   IF g_xcja.xcja008 = '2' THEN  #对比法
      LET g_sql = g_sql CLIPPED," AND xcck003 = '",g_xcja.xcja009,"' "  #成本计算类型
   END IF
   #LET g_sql = g_sql CLIPPED," ORDER BY xcck003 "
   LET g_sql = g_sql CLIPPED," INTO TEMP axcp950_xcck "  #参与计算的利润中心临时表
   PREPARE axcp950_crt_table_p2 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp950_crt_table_p2"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   EXECUTE axcp950_crt_table_p2
   IF SQLCA.sqlcode THEN
      DISPLAY "err code=",SQLCA.sqlerrd[2]
      DISPLAY "err sql=",g_sql
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp950_crt_table_p2"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #删除重复数据(保留一笔) 可能用多种成本计算类型计算过
   LET g_sql = " DELETE FROM axcp950_xcck a ",
               "   WHERE (a.xcck001,a.xcck006,a.xcck007,a.xcck008,a.xcck009) ",
               "         IN ",
               "         (SELECT xcck001,xcck006,xcck007,xcck008,xcck009 FROM axcp950_xcck ",
               "           GROUP BY xcck001,xcck006,xcck007,xcck008,xcck009 HAVING COUNT(*)>1) ",
               "     AND rowid NOT IN ",
               "         (SELECT MIN(rowid) FROM axcp950_xcck ",
               "           GROUP BY xcck001,xcck006,xcck007,xcck008,xcck009 HAVING COUNT(*)>1) "
   PREPARE axcp950_crt_table_p21 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp950_crt_table_p21"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   EXECUTE axcp950_crt_table_p21
   IF SQLCA.sqlcode THEN
      DISPLAY "err code=",SQLCA.sqlerrd[2]
      DISPLAY "err sql=",g_sql
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp950_crt_table_p21"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #更新对方利润中心，调拨单对方利润中心为拨入/拨出反向的仓库对应的inaa005
   LET g_sql = " MERGE INTO axcp950_xcck a ",
               "      USING axcp950_xcck b ",
               "          ON ( a.xcckent = b.xcckent ",
               "         AND   a.xcckld  = b.xcckld  ",
               "         AND   a.xcck001 = b.xcck001 ",
               "         AND   a.xcck002 = b.xcck002 ",
               "         AND   a.xcck003 = b.xcck003 ",
               "         AND   a.xcck004 = b.xcck004 ",
               "         AND   a.xcck005 = b.xcck005 ",
               "         AND   a.xcck006 = b.xcck006 ",
               "         AND   a.xcck007 = b.xcck007 ",
               "         AND   a.xcck008 = b.xcck008 ",
               "         AND   a.xcck009 = b.xcck009 * -1) ",
               "  WHEN MATCHED THEN    ",
               "     UPDATE SET a.ob_center  = b.center ",
               "      WHERE a.xcck020 = '401' "  #调拨
   PREPARE axcp950_crt_table_p22 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp950_crt_table_p22"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   EXECUTE axcp950_crt_table_p22
   IF SQLCA.sqlcode THEN
      DISPLAY "err code=",SQLCA.sqlerrd[2]
      DISPLAY "err sql=",g_sql
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp950_crt_table_p22"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #删除未跨利润中心的记录，如：调拨单是同个利润中心之间的仓库调拨
   #这些没必要做内部收入和成本
   DELETE FROM axcp950_xcck
    WHERE ob_center = center
      AND xcck020 = '401' #调拨
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "DEL the same center"  #删除重复数据
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #更新xccc280单价
   LET g_sql = " MERGE INTO axcp950_xcck a ",
               "      USING (SELECT xccc_t.*,imaa006  ",
               "               FROM xccc_t LEFT JOIN imaa_t ON imaaent = xcccent AND imaa001= xccc006 ",
               "              WHERE xcccent= ",g_enterprise,
               "                AND xcccld = '",g_master.xcjeld,"' ",
               "                AND xccc004= ",g_master.xcje002,
               "                AND xccc005= ",g_master.xcje003,
               "                AND xccc001= '1' ",  #帐套本位币顺序
               "             ) b ",
               "          ON ( a.xcckent = b.xcccent ",
               "         AND   a.xcckld  = b.xcccld  ", #帐套
               "         AND   a.xcck001 = b.xccc001 ", #帐套本位币顺序
               "         AND   a.xcck002 = b.xccc002 ", #成本域
               "         AND   a.xcck003 = b.xccc003 ", #成本计算类型
               "         AND   a.xcck004 = b.xccc004 ", #年度
               "         AND   a.xcck005 = b.xccc005 ", #期別
               "         AND   a.xcck010 = b.xccc006 ", #料號
               "         AND   a.xcck011 = b.xccc007 ", #特性码
               "         AND   a.xcck017 = b.xccc008 )", #批号
               "  WHEN MATCHED THEN    ",
               "     UPDATE SET a.imaa006  = b.imaa006, ",  #成本单位单位
               "                a.xccc010  = b.xccc010, ",  #核算币别
               "                a.xccc280  = b.xccc280  "   #成本单价
   PREPARE axcp950_crt_table_p230 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp950_crt_table_p230"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   EXECUTE axcp950_crt_table_p230
   IF SQLCA.sqlcode THEN
      DISPLAY "err code[2]=",SQLCA.sqlerrd[2]
      DISPLAY "err sql=",g_sql
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp950_crt_table_p230"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   
   ##############begin################
   #-----计算内部交易单价-------begin
   #--入库，当前仓库组织为采购组织
   LET g_sql = " MERGE INTO axcp950_xcck a ",
               "      USING xcjb_t b ",
               "          ON ( a.xcckent = b.xcjbent ",
               "         AND   a.xcck004 = b.xcjb002 ", #年度
               "         AND   a.xcck005 = b.xcjb003 ", #期別
               "         AND   a.xcck010 = b.xcjb004 ", #料號
               "         AND   a.ob_center = b.xcjb005 ", #銷售組織
               "         AND   a.center    = b.xcjb006 ", #採購組織
               "         AND   b.xcjb001 = '",g_master.xcje006,"') ",  #計算類型(版本)
               "  WHEN MATCHED THEN    ",
               "     UPDATE SET a.xcjb007  = b.xcjb007, ",
               "                a.xcjb008  = b.xcjb008, ",
               "                a.xcjb009  = b.xcjb009  ",
               "      WHERE a.xcck009 = 1 ",  #入库，当前仓库组织为采购组织
               "        AND a.xcck020 IN ('401', ", #调拨
               " '201','202', ", #销售出库，退货
               "                          '302', ", #生产发料
               "                          '303', ", #生产退料 生产发料的反向
               "                          '301', ", #杂发出库
               "                          '101', ", #杂收入库
               "                          '304', ", #库存报废
               "                          '501', ", #盘点
               "                          '115', ", #当站下线
               "                          '102', ", #采购入库
               "                          '103', ", #委外入库 同采购入库
               "                          '108', ", #采购仓退 采购入库的反向
               "                          '110', ", #生产入库
               "                          '111', ", #联产品入库
               "                          '112', ", #多产出主件入库
               "                          '113', ", #拆件入库
               "                          '114') "  #回收入库
               #'999'  #
   PREPARE axcp950_crt_table_p231 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp950_crt_table_p231"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   EXECUTE axcp950_crt_table_p231
   IF SQLCA.sqlcode THEN
      DISPLAY "err code[2]=",SQLCA.sqlerrd[2]
      DISPLAY "err sql=",g_sql
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp950_crt_table_p231"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #--出库，当前仓库组织为销售组织
   LET g_sql = " MERGE INTO axcp950_xcck a ",
               "      USING xcjb_t b ",
               "          ON ( a.xcckent = b.xcjbent ",
               "         AND   a.xcck004 = b.xcjb002 ", #年度
               "         AND   a.xcck005 = b.xcjb003 ", #期別
               "         AND   a.xcck010 = b.xcjb004 ", #料號
               "         AND   a.center    = b.xcjb005 ", #銷售組織
               "         AND   a.ob_center = b.xcjb006 ", #採購組織
               "         AND   b.xcjb001 = '",g_master.xcje006,"') ",  #計算類型(版本)
               "  WHEN MATCHED THEN    ",
               "     UPDATE SET a.xcjb007  = b.xcjb007, ",
               "                a.xcjb008  = b.xcjb008, ",
               "                a.xcjb009  = b.xcjb009  ",
               "      WHERE a.xcck009 = -1 ",  #出库，当前仓库组织为销售组织
               "        AND a.xcck020 IN ('401', ", #调拨
               " '201','202', ", #销售出库，退货
               "                          '302', ", #生产发料
               "                          '303', ", #生产退料 生产发料的反向
               "                          '301', ", #杂发出库
               "                          '101', ", #杂收入库
               "                          '304', ", #库存报废
               "                          '501', ", #盘点
               "                          '115', ", #当站下线
               "                          '102', ", #采购入库
               "                          '103', ", #委外入库 同采购入库
               "                          '108', ", #采购仓退 采购入库的反向
               "                          '110', ", #生产入库
               "                          '111', ", #联产品入库
               "                          '112', ", #多产出主件入库
               "                          '113', ", #拆件入库
               "                          '114') "  #回收入库
   PREPARE axcp950_crt_table_p232 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp950_crt_table_p232"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   EXECUTE axcp950_crt_table_p232
   IF SQLCA.sqlcode THEN
      DISPLAY "err code[2]=",SQLCA.sqlerrd[2]
      DISPLAY "err sql=",g_sql
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp950_crt_table_p232"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #内部定价按采购组织是杂收单的利润中心，销售组织是其自己的抓不到，再抓销售组织是ALL的
   LET g_sql = " MERGE INTO axcp950_xcck a ",
               "      USING xcjb_t b ",
               "          ON ( a.xcckent = b.xcjbent ",
               "         AND   a.xcck004 = b.xcjb002 ", #年度
               "         AND   a.xcck005 = b.xcjb003 ", #期別
               "         AND   a.xcck010 = b.xcjb004 ", #料號
               "         AND   b.xcjb005 = 'ALL' ",     #銷售組織
               "         AND   a.center  = b.xcjb006 ", #採購組織
               "         AND   b.xcjb001 = '",g_master.xcje006,"') ",  #計算類型(版本)
               "  WHEN MATCHED THEN    ",
               "     UPDATE SET a.xcjb007  = b.xcjb007, ",  #计价单位
               "                a.xcjb008  = b.xcjb008, ",  #币别
               "                a.xcjb009  = b.xcjb009  ",  #內部定價
               "      WHERE (a.xcck020 in ('101','115','110') OR (a.xcck020='501' AND a.xcck009=1) ) ",  #杂收入库，当站下线,生产入库,盘盈
               "        AND (xcjb007=' ' OR xcjb008=' ' OR xcjb009=0) "
   PREPARE axcp950_crt_table_p233 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp950_crt_table_p233"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   EXECUTE axcp950_crt_table_p233
   IF SQLCA.sqlcode THEN
      DISPLAY "err sql=",g_sql
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp950_crt_table_p233"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #内部定价按采购组织是ALL，销售组织是销售部门所属利润中心
   LET g_sql = " MERGE INTO axcp950_xcck a ",
               "      USING xcjb_t b ",
               "          ON ( a.xcckent = b.xcjbent ",
               "         AND   a.xcck004 = b.xcjb002 ", #年度
               "         AND   a.xcck005 = b.xcjb003 ", #期別
               "         AND   a.xcck010 = b.xcjb004 ", #料號
               "         AND   b.xcjb005 = a.ob_center ",  #銷售組織
               "         AND   b.xcjb006 = 'ALL' ",        #採購組織
               "         AND   b.xcjb001 = '",g_master.xcje006,"') ",  #計算類型(版本)
               "  WHEN MATCHED THEN    ",
               "     UPDATE SET a.xcjb007  = b.xcjb007, ",  #计价单位
               "                a.xcjb008  = b.xcjb008, ",  #币别
               "                a.xcjb009  = b.xcjb009  ",  #內部定價
               "      WHERE a.xcck020 in ('201','202') ",  #销售出货/销售退货
               "        AND (xcjb007=' ' OR xcjb008=' ' OR xcjb009=0) "
   PREPARE axcp950_crt_table_p234 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp950_crt_table_p234"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   EXECUTE axcp950_crt_table_p234
   IF SQLCA.sqlcode THEN
      DISPLAY "err code[2]=",SQLCA.sqlerrd[2]
      DISPLAY "err sql=",g_sql
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp950_crt_table_p234"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #内部定价按采购组织是ALL，销售组织是ALL
   LET g_sql = " MERGE INTO axcp950_xcck a ",
               "      USING xcjb_t b ",
               "          ON ( a.xcckent = b.xcjbent ",
               "         AND   a.xcck004 = b.xcjb002 ", #年度
               "         AND   a.xcck005 = b.xcjb003 ", #期別
               "         AND   a.xcck010 = b.xcjb004 ", #料號
               "         AND   b.xcjb005 = 'ALL' ",        #銷售組織
               "         AND   b.xcjb006 = 'ALL' ",        #採購組織
               "         AND   b.xcjb001 = '",g_master.xcje006,"') ",  #計算類型(版本)
               "  WHEN MATCHED THEN    ",
               "     UPDATE SET a.xcjb007  = b.xcjb007, ",  #计价单位
               "                a.xcjb008  = b.xcjb008, ",  #币别
               "                a.xcjb009  = b.xcjb009  ",  #內部定價
               "      WHERE a.xcck020 in ('201','202') ",  #销售出货/销售退货
               "        AND (xcjb007=' ' OR xcjb008=' ' OR xcjb009=0) "
   PREPARE axcp950_crt_table_p235 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp950_crt_table_p235"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   EXECUTE axcp950_crt_table_p235
   IF SQLCA.sqlcode THEN
      DISPLAY "err code[2]=",SQLCA.sqlerrd[2]
      DISPLAY "err sql=",g_sql
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp950_crt_table_p235"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #-----计算内部交易单价------end
   #最后利润中心相同的，如杂发，价格就是抓月平均的成本
   UPDATE axcp950_xcck SET xcjb007  = imaa006,  #计价单位
                           xcjb008  = xccc010,  #币别
                           xcjb009  = xccc280  #內部定價
    WHERE ob_center = center
      AND (xcjb007=' ' OR xcjb008=' ' OR xcjb009=0) 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "Upd axcp950_xcck"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   ##############end################
	
	
	#axcp950_xccq:参与计算的xccq资料
   DROP TABLE axcp950_xccq; 
   LET g_wc2 = cl_replace_str(g_wc2,"xcck010","xccq006")  #料
   #成本计算类型/料/仓/期末结存数量/期末结存金额
   #仓库对应利润中心/内部交易定价单位/内部交易定价币别/内部交易定价价格
   LET g_sql = " SELECT xccq003,xccq006,xccq010,SUM(xccq901) xccq901,SUM(xccq902) xccq902, ",
               "        inaa005 center,xcjb007,xcjb008,0 xcjb009,  ",  #xcjb009交易单价
               "        xcjb007 imaa006,xcjb008 xccc010,0 xccc280 ", #xccc280实际单价
               "   FROM xccq_t ",
               "               LEFT JOIN xcjb_t ON xcjbent = xccqent AND xcjb001 = '",g_master.xcje006,"' AND xcjb002 = xccq004 AND xcjb003=xccq005 AND xcjb004 = xccq006 AND xcjb005='ALL' AND xcjb006='ALL'",
               "               LEFT JOIN inaa_t ON inaaent = xccqent AND inaasite = xccqsite AND inaa001 = xccq010 ",
               "  WHERE xccqent= ",g_enterprise,
               "    AND xccqld = '",g_master.xcjeld,"' ",
               "    AND xccq001= '1' ",  #帐套本位币顺序
               "    AND xccq004= ",g_master.xcje002,
               "    AND xccq005= ",g_master.xcje003,
               "    AND ",g_wc2,
               "    AND EXISTS (SELECT 1 FROM axcp950_center ",  #在利润中心范围内
               "                 WHERE inaa005 = ooef001 ) "
	IF g_xcja.xcja008 = '2' THEN  #对比法
	   LET g_sql = g_sql CLIPPED," AND xccq003 = '",g_xcja.xcja009,"' "  #成本计算类型
	END IF
	#LET g_sql = g_sql CLIPPED," ORDER BY xccq003 "
	LET g_sql = g_sql CLIPPED," GROUP BY xccq003,xccq006,xccq010,inaa005,xcjb007,xcjb008 ",
	                          "  INTO TEMP axcp950_xccq "  #参与计算的利润中心临时表
   PREPARE axcp950_crt_table_p3 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp950_crt_table_p3"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   EXECUTE axcp950_crt_table_p3
   IF SQLCA.sqlcode THEN
      DISPLAY "err code=",SQLCA.sqlerrd[2]
      DISPLAY "err sql=",g_sql
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp950_crt_table_p3"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #删除重复数据(保留一笔) 可能用多种成本计算类型计算过
   LET g_sql = " DELETE FROM axcp950_xccq a ", #料+仓库唯一
               "   WHERE (a.xccq006,a.xccq010) ",
               "         IN ",
               "         (SELECT xccq006,xccq010 FROM axcp950_xccq ",
               "           GROUP BY xccq006,xccq010 HAVING COUNT(*)>1) ",
               "     AND rowid NOT IN ",
               "         (SELECT MIN(rowid) FROM axcp950_xccq ",
               "           GROUP BY xccq006,xccq010 HAVING COUNT(*)>1) "
   PREPARE axcp950_crt_table_p31 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp950_crt_table_p31"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   EXECUTE axcp950_crt_table_p31
   IF SQLCA.sqlcode THEN
      DISPLAY "err code=",SQLCA.sqlerrd[2]
      DISPLAY "err sql=",g_sql
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp950_crt_table_p31"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   ##更新xccc280单价
   #LET g_sql = " MERGE INTO axcp950_xccq a ",
   #            "      USING (SELECT xccc_t.*,imaa006  ",
   #            "               FROM xccc_t LEFT JOIN imaa_t ON imaaent = xcccent AND imaa001= xccc006 ",
   #            "              WHERE xcccent= ",g_enterprise,
   #            "                AND xcccld = '",g_master.xcjeld,"' ",
   #            "                AND xccc004= ",g_master.xcje002,
   #            "                AND xccc005= ",g_master.xcje003,
   #            "                AND xccc001= '1' ",  #帐套本位币顺序
   #            "             ) b ",
   #            "          ON ( a.xccqent = b.xcccent ",
   #            "         AND   a.xccqld  = b.xcccld  ", #帐套
   #            "         AND   a.xccq001 = b.xccc001 ", #帐套本位币顺序
   #            "         AND   a.xccq002 = b.xccc002 ", #成本域
   #            "         AND   a.xccq003 = b.xccc003 ", #成本计算类型
   #            "         AND   a.xccq004 = b.xccc004 ", #年度
   #            "         AND   a.xccq005 = b.xccc005 ", #期別
   #            "         AND   a.xccq006 = b.xccc006 ", #料號
   #            "         AND   a.xccq007 = b.xccc007 ", #特性码
   #            "         AND   a.xccq008 = b.xccc008 )", #批号  --此等栏位临时表中不存在
   #            "  WHEN MATCHED THEN    ",
   #            "     UPDATE SET a.imaa006  = b.imaa006, ",  #成本单位单位
   #            "                a.xccc010  = b.xccc010, ",  #核算币别
   #            "                a.xccc280  = b.xccc280  "   #成本单价
   #PREPARE axcp950_crt_table_p320 FROM g_sql
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code   = SQLCA.sqlcode
   #   LET g_errparam.extend = "PREPARE axcp950_crt_table_p320"
   #   LET g_errparam.popup  = TRUE
   #   CALL cl_err()
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   #EXECUTE axcp950_crt_table_p320
   #IF SQLCA.sqlcode THEN
   #   DISPLAY "err code[2]=",SQLCA.sqlerrd[2]
   #   DISPLAY "err sql=",g_sql
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code   = SQLCA.sqlcode
   #   LET g_errparam.extend = "EXECUTE axcp950_crt_table_p320"
   #   LET g_errparam.popup  = TRUE
   #   CALL cl_err()
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   
   #计算内部交易定价:按采购组织为仓库所属利润中心，销售组织为ALL
   LET g_sql = " MERGE INTO axcp950_xccq a ",
               "      USING xcjb_t b ",
               "          ON ( b.xcjbent =",g_enterprise,
               "         AND   b.xcjb002 =",g_master.xcje002, #年度
               "         AND   b.xcjb003 =",g_master.xcje003, #期別
               "         AND   b.xcjb004 = a.xccq006 ", #料號
               "         AND   b.xcjb005 = 'ALL' ",        #銷售組織
               "         AND   b.xcjb006 = a.center ",        #採購組織
               "         AND   b.xcjb001 = '",g_master.xcje006,"') ",  #計算類型(版本)
               "  WHEN MATCHED THEN    ",
               "     UPDATE SET a.xcjb007  = b.xcjb007, ",  #计价单位
               "                a.xcjb008  = b.xcjb008, ",  #币别
               "                a.xcjb009  = b.xcjb009  "   #內部定價
   PREPARE axcp950_crt_table_p32 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp950_crt_table_p32"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   EXECUTE axcp950_crt_table_p32
   IF SQLCA.sqlcode THEN
      DISPLAY "err code=",SQLCA.sqlerrd[2]
      DISPLAY "err sql=",g_sql
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp950_crt_table_p32"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #产生分录底稿用的临时表
   IF NOT axct701_02_create_tmp_table() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
  
	RETURN r_success
END FUNCTION

#删除临时表
PRIVATE FUNCTION axcp950_drop_tmp_table()
   DROP TABLE axcp950_center;  #参与计算的利润中心表
   DROP TABLE axcp950_xcck;    #参与计算的异动记录
   DROP TABLE axcp950_xccq;    #参与计算的库存结存
END FUNCTION

#计算异动明细部分——各类型共用
PRIVATE FUNCTION axcp950_ins_xcjf_f_xcck(p_type)
   DEFINE p_type     LIKE type_t.chr10    #'2011'   销售出货同利润中心的库存--分摊组织的内部收入增加
                                          #'2012_1' 销售出货同利润中心的库存--销售组织的内部成本增加
                                          #'2012_2' 销售出货同利润中心的库存--销售组织的外部收入减少(金额为成本金额xccc280)
                                          
                                          #'2013'   销售出货不同利润中心的库存--库存所在利润中心方（center）--增加内部收入
                                          #'2014_1' 销售出货不同利润中心的库存--申请部门所在利润中心方(ob_center)--增加内部成本
                                          #'2014_2' 销售出货不同利润中心的库存--申请部门所在利润中心方(ob_center)--减少外部收入(金额为成本金额xccc280)
                                          #'2015'   销售出货不同利润中心的库存-库存所在利润中心方（center）--增加内部成本（金额为成本金额）  #160616-00006#2 add
                                          
                                          #'2021' 销售退货同利润中心的库存--分摊组织的内部收入减少
                                          #'2022_1' 销售退货同利润中心的库存--销售组织的内部成本减少
                                          #'2022_2' 销售退货同利润中心的库存--销售组织的外部收入增加(金额为成本金额xccc280)
                                          
                                          #'2023' 销售退货不同利润中心的库存--库存所在利润中心方（center）--减少内部收入
                                          #'2024_1' 销售退货不同利润中心的库存--申请部门所在利润中心方(ob_center)--减少内部成本
                                          #'2024_2' 销售退货不同利润中心的库存--申请部门所在利润中心方(ob_center)--增加外部收入(金额为成本金额xccc280)
                                          #'2025'   销售退货不同利润中心的库存-库存所在利润中心方（center）--减少内部成本（金额为成本金额   #160616-00006#2 add
                                          
                                          #'401'  调拨
                                          #'3021' 生产发料同利润中心的库存
                                          #'3022' 生产发料不同利润中心的库存--库存所在利润中心方（center）
                                          #'3023' 生产发料不同利润中心的库存--申请部门所在利润中心方(ob_center)
                                          #'3031' 生产退料同利润中心的库存
                                          #'3032' 生产退料不同利润中心的库存--库存所在利润中心方（center）
                                          #'3033' 生产退料不同利润中心的库存--申请部门所在利润中心方(ob_center)
                                          #'3011' 杂发同利润中心的库存
                                          #'3012' 杂发不同利润中心的库存--库存所在利润中心方（center）
                                          #'3013' 杂发不同利润中心的库存--申请部门所在利润中心方(ob_center)
                                          #'101'  杂收入库
                                          #'115'  当站下线
                                          #'102'  采购入库
                                          #'103'  委外入库 同采购入库
                                          #'108'  采购仓退 采购入库的反向
                                          #'110'  生产入库

   DEFINE r_success  LIKE type_t.num5
   DEFINE l_success  LIKE type_t.num5
#   DEFINE l_glad     RECORD LIKE glad_t.*  #科目相关设置 #161124-00048#12 mark
  #161124-00048#12 add(s)
  DEFINE l_glad RECORD  #帳套科目管理設定檔
       gladent LIKE glad_t.gladent, #企业编号
       gladownid LIKE glad_t.gladownid, #资料所有者
       gladowndp LIKE glad_t.gladowndp, #资料所有部门
       gladcrtid LIKE glad_t.gladcrtid, #资料录入者
       gladcrtdp LIKE glad_t.gladcrtdp, #资料录入部门
       gladcrtdt LIKE glad_t.gladcrtdt, #资料创建日
       gladmodid LIKE glad_t.gladmodid, #资料更改者
       gladmoddt LIKE glad_t.gladmoddt, #最近更改日
       gladstus LIKE glad_t.gladstus, #状态码
       gladld LIKE glad_t.gladld, #账套
       glad001 LIKE glad_t.glad001, #会计科目编号
       glad002 LIKE glad_t.glad002, #是否按余额类型生成分录
       glad003 LIKE glad_t.glad003, #启用凭证项次细项立冲
       glad004 LIKE glad_t.glad004, #凭证项次异动别
       glad005 LIKE glad_t.glad005, #是否启用数量金额式
       glad006 LIKE glad_t.glad006, #借方现金变动码
       glad007 LIKE glad_t.glad007, #启用部门管理
       glad008 LIKE glad_t.glad008, #启用利润成本管理
       glad009 LIKE glad_t.glad009, #启用区域管理
       glad010 LIKE glad_t.glad010, #启用收付款客商管理
       glad011 LIKE glad_t.glad011, #启用客群管理
       glad012 LIKE glad_t.glad012, #启用产品类别管理
       glad013 LIKE glad_t.glad013, #启用人员管理
       glad014 LIKE glad_t.glad014, #no use
       glad015 LIKE glad_t.glad015, #启用项目管理
       glad016 LIKE glad_t.glad016, #启用WBS管理
       glad017 LIKE glad_t.glad017, #启用自由核算项一
       glad0171 LIKE glad_t.glad0171, #自由核算项一类型编号
       glad0172 LIKE glad_t.glad0172, #自由核算项一控制方式
       glad018 LIKE glad_t.glad018, #启用自由核算项二
       glad0181 LIKE glad_t.glad0181, #自由核算项二类型编号
       glad0182 LIKE glad_t.glad0182, #自由核算项二控制方式
       glad019 LIKE glad_t.glad019, #启用自由核算项三
       glad0191 LIKE glad_t.glad0191, #自由核算项三类型编号
       glad0192 LIKE glad_t.glad0192, #自由核算项三控制方式
       glad020 LIKE glad_t.glad020, #启用自由核算项四
       glad0201 LIKE glad_t.glad0201, #自由核算项四类型编号
       glad0202 LIKE glad_t.glad0202, #自由核算项四控制方式
       glad021 LIKE glad_t.glad021, #启用自由核算项五
       glad0211 LIKE glad_t.glad0211, #自由核算项五类型编号
       glad0212 LIKE glad_t.glad0212, #自由核算项五控制方式
       glad022 LIKE glad_t.glad022, #启用自由核算项六
       glad0221 LIKE glad_t.glad0221, #自由核算项六类型编号
       glad0222 LIKE glad_t.glad0222, #自由核算项六控制方式
       glad023 LIKE glad_t.glad023, #启用自由核算项七
       glad0231 LIKE glad_t.glad0231, #自由核算项七类型编号
       glad0232 LIKE glad_t.glad0232, #自由核算项七控制方式
       glad024 LIKE glad_t.glad024, #启用自由核算项八
       glad0241 LIKE glad_t.glad0241, #自由核算项八类型编号
       glad0242 LIKE glad_t.glad0242, #自由核算项八控制方式
       glad025 LIKE glad_t.glad025, #启用自由核算项九
       glad0251 LIKE glad_t.glad0251, #自由核算项九类型编号
       glad0252 LIKE glad_t.glad0252, #自由核算项九控制方式
       glad026 LIKE glad_t.glad026, #启用自由核算项十
       glad0261 LIKE glad_t.glad0261, #自由核算项十类型编号
       glad0262 LIKE glad_t.glad0262, #自由核算项十控制方式
       glad027 LIKE glad_t.glad027, #启用账款客商管理
       glad030 LIKE glad_t.glad030, #是否进行预算管控
       glad031 LIKE glad_t.glad031, #启用经营方式管理
       glad032 LIKE glad_t.glad032, #启用渠道管理
       glad033 LIKE glad_t.glad033, #启用品牌管理
       glad034 LIKE glad_t.glad034, #科目做多币种管理
       glad035 LIKE glad_t.glad035, #是否是子系统科目
       glad036 LIKE glad_t.glad036  #贷方现金变动码
END RECORD
  #161124-00048#12 add(e)
   DEFINE l_rate     LIKE xcjf_t.xcjf024   #计价单位与内部定价单位的换算率
   
   LET r_success = TRUE
   
   LET g_seq = g_seq + 1
   
   INITIALIZE g_xcjf.* TO NULL   #清空
   LET g_xcjf.xcjfent   = g_enterprise     #企業編號
   LET g_xcjf.xcjfsite  = g_xcje.xcjesite  #賬務中心
   LET g_xcjf.xcjfld    = g_xcje.xcjeld    #帳套
   LET g_xcjf.xcjfdocno = g_xcje.xcjedocno #單據編號
   LET g_xcjf.xcjfseq   = g_seq            #項次
   LET g_xcjf.xcjf001   = g_xcck.xcck006   #業務單據
   LET g_xcjf.xcjf002   = g_xcck.xcck007   #項次
   LET g_xcjf.xcjf003   = g_xcck.xcck008   #項次
   CASE p_type  --以下方向增加还是减少在本函数最后insert前处理
      WHEN '2011' #销售出货同利润中心的库存-分摊组织的内部收入增加
           LET g_xcjf.xcjf010   = '1'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_xcjc006        #實體利潤中心（組織)
           SELECT inba004,inba003  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM inba_t
            WHERE xmdkent   = g_enterprise
              AND xmdkdocno = g_xcjf.xcjf001
      WHEN '2012_1' #销售出货同利润中心的库存-销售组织的内部成本增加
           LET g_xcjf.xcjf010   = '3'                 #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_ob_center         #實體利潤中心（組織)
           SELECT inba004,inba003  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM inba_t
            WHERE xmdkent   = g_enterprise
              AND xmdkdocno = g_xcjf.xcjf001
      WHEN '2012_2' #销售出货同利润中心的库存-销售组织的外部收入减少
           LET g_xcjf.xcjf010   = '2'                 #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_ob_center         #實體利潤中心（組織)
           SELECT inba004,inba003  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM inba_t
            WHERE xmdkent   = g_enterprise
              AND xmdkdocno = g_xcjf.xcjf001
      WHEN '2013' #销售出货不同利润中心的库存--库存所在利润中心方（center）--增加内部收入
           LET g_xcjf.xcjf010   = '1'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_center         #實體利潤中心（組織)
           SELECT xmdk004,xmdk003  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM xmdk_t
            WHERE xmdkent   = g_enterprise
              AND xmdkdocno = g_xcjf.xcjf001
      WHEN '2014_1' #销售出货不同利润中心的库存--申请部门所在利润中心方(ob_center)--增加内部成本
           LET g_xcjf.xcjf010   = '3'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_ob_center      #實體利潤中心（組織)
           SELECT xmdk004,xmdk003  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM xmdk_t
            WHERE xmdkent   = g_enterprise
              AND xmdkdocno = g_xcjf.xcjf001
      WHEN '2014_2' #销售出货不同利润中心的库存--申请部门所在利润中心方(ob_center)--减少外部收入
           LET g_xcjf.xcjf010   = '2'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_ob_center      #實體利潤中心（組織)
           SELECT xmdk004,xmdk003  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM xmdk_t
            WHERE xmdkent   = g_enterprise
              AND xmdkdocno = g_xcjf.xcjf001
      #add zhangllc 160617--s 160616-00006#2
      WHEN '2015' #销售出货不同利润中心的库存-库存所在利润中心方（center）--增加内部成本（金额为成本金额）
           LET g_xcjf.xcjf010   = '3'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_center         #實體利潤中心（組織)
           SELECT xmdk004,xmdk003  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM xmdk_t
            WHERE xmdkent   = g_enterprise
              AND xmdkdocno = g_xcjf.xcjf001
      #add zhangllc 160617--e
      WHEN '2021' #销售退货同利润中心的库存--分摊组织的内部收入减少
           LET g_xcjf.xcjf010   = '1'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_xcjc006        #實體利潤中心（組織)
           SELECT inba004,inba003  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM inba_t
            WHERE xmdkent   = g_enterprise
              AND xmdkdocno = g_xcjf.xcjf001
      WHEN '2022_1' #销售退货同利润中心的库存--销售组织的内部成本减少
           LET g_xcjf.xcjf010   = '3'                 #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_ob_center         #實體利潤中心（組織)
           SELECT inba004,inba003  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM inba_t
            WHERE xmdkent   = g_enterprise
              AND xmdkdocno = g_xcjf.xcjf001
      WHEN '2022_2' #销售退货同利润中心的库存--销售组织的外部收入增加
           LET g_xcjf.xcjf010   = '2'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_ob_center         #實體利潤中心（組織)
           SELECT inba004,inba003  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM inba_t
            WHERE xmdkent   = g_enterprise
              AND xmdkdocno = g_xcjf.xcjf001
      WHEN '2023' #销售退货不同利润中心的库存--库存所在利润中心方（center）--减少内部收入
           LET g_xcjf.xcjf010   = '1'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_center         #實體利潤中心（組織)
           SELECT xmdk004,xmdk003  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM xmdk_t
            WHERE xmdkent   = g_enterprise
              AND xmdkdocno = g_xcjf.xcjf001
      WHEN '2024_1' #销售退货不同利润中心的库存--申请部门所在利润中心方(ob_center)--减少内部成本
           LET g_xcjf.xcjf010   = '3'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_ob_center      #實體利潤中心（組織)
           SELECT xmdk004,xmdk003  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM xmdk_t
            WHERE xmdkent   = g_enterprise
              AND xmdkdocno = g_xcjf.xcjf001
      WHEN '2024_2' #销售退货不同利润中心的库存--申请部门所在利润中心方(ob_center)--增加外部收入
           LET g_xcjf.xcjf010   = '2'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_ob_center      #實體利潤中心（組織)
           SELECT xmdk004,xmdk003  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM xmdk_t
            WHERE xmdkent   = g_enterprise
              AND xmdkdocno = g_xcjf.xcjf001
      #add zhangllc 160617--s 160616-00006#2
      WHEN '2025' #销售退货不同利润中心的库存-库存所在利润中心方（center）--减少内部成本（金额为成本金额）
           LET g_xcjf.xcjf010   = '3'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_center         #實體利潤中心（組織)
           SELECT xmdk004,xmdk003  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM xmdk_t
            WHERE xmdkent   = g_enterprise
              AND xmdkdocno = g_xcjf.xcjf001
      #add zhangllc 160617--e

      WHEN '401' #调拨(相同利润中心之间的调拨不会计算)
           IF g_xcck.xcck009    = 1 THEN
              LET g_xcjf.xcjf010 = '3'             #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           ELSE
              LET g_xcjf.xcjf010 = '1'             #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           END IF
           LET g_xcjf.xcjf013   = g_center         #實體利潤中心（組織)
           #LET g_xcjf.xcjf031   = g_dept           #部門
           #LET g_xcjf.xcjf041   = g_user           #人員
           SELECT indc101,indc004  #调拨部门,调拨人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM indc_t
            WHERE indcent   = g_enterprise
              AND indcdocno = g_xcjf.xcjf001
      WHEN '3021' #生产发料同利润中心的库存
           LET g_xcjf.xcjf010   = '3'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_center         #實體利潤中心（組織)
           SELECT sfda003,sfda004  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM sfda_t
            WHERE sfdaent   = g_enterprise
              AND sfdadocno = g_xcjf.xcjf001
      WHEN '3022' #生产发料不同利润中心的库存-库存所在利润中心方（center）
           LET g_xcjf.xcjf010   = '1'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_center         #實體利潤中心（組織)
           SELECT sfda003,sfda004  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM sfda_t
            WHERE sfdaent   = g_enterprise
              AND sfdadocno = g_xcjf.xcjf001
      WHEN '3023' #生产发料不同利润中心的库存-申请部门所在利润中心方(ob_center)
           LET g_xcjf.xcjf010   = '3'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_ob_center      #實體利潤中心（組織)
           SELECT sfda003,sfda004  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM sfda_t
            WHERE sfdaent   = g_enterprise
              AND sfdadocno = g_xcjf.xcjf001
      WHEN '3031' #生产退料同利润中心的库存
           LET g_xcjf.xcjf010   = '3'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_center         #實體利潤中心（組織)
           SELECT sfda003,sfda004  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM sfda_t
            WHERE sfdaent   = g_enterprise
              AND sfdadocno = g_xcjf.xcjf001
      WHEN '3032' #生产退料不同利润中心的库存-库存所在利润中心方（center）
           LET g_xcjf.xcjf010   = '1'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_center         #實體利潤中心（組織)
           SELECT sfda003,sfda004  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM sfda_t
            WHERE sfdaent   = g_enterprise
              AND sfdadocno = g_xcjf.xcjf001
      WHEN '3033' #生产退料不同利润中心的库存-申请部门所在利润中心方(ob_center)
           LET g_xcjf.xcjf010   = '3'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_ob_center      #實體利潤中心（組織)
           SELECT sfda003,sfda004  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM sfda_t
            WHERE sfdaent   = g_enterprise
              AND sfdadocno = g_xcjf.xcjf001
      WHEN '3011' #杂发同利润中心的库存
           LET g_xcjf.xcjf010   = '3'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_center         #實體利潤中心（組織)
           SELECT inba004,inba003  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM inba_t
            WHERE inbaent   = g_enterprise
              AND inbadocno = g_xcjf.xcjf001
      WHEN '3012' #杂发不同利润中心的库存-库存所在利润中心方（center）
           LET g_xcjf.xcjf010   = '1'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_center         #實體利潤中心（組織)
           SELECT inba004,inba003  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM inba_t
            WHERE inbaent   = g_enterprise
              AND inbadocno = g_xcjf.xcjf001
      WHEN '3013' #杂发不同利润中心的库存-申请部门所在利润中心方(ob_center)
           LET g_xcjf.xcjf010   = '3'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_ob_center      #實體利潤中心（組織)
           SELECT inba004,inba003  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM inba_t
            WHERE inbaent   = g_enterprise
              AND inbadocno = g_xcjf.xcjf001
      WHEN '101'  #杂收入库
           LET g_xcjf.xcjf010   = '3'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_center         #實體利潤中心（組織)
           SELECT inba004,inba003  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM inba_t
            WHERE inbaent   = g_enterprise
              AND inbadocno = g_xcjf.xcjf001
      WHEN '115'  #当站下线
           LET g_xcjf.xcjf010   = '3'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_center         #實體利潤中心（組織)
           SELECT sfha003,sfha002  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM sfha_t
            WHERE sfhaent   = g_enterprise
              AND sfhadocno = g_xcjf.xcjf001
      WHEN '102'  #采购入库
           LET g_xcjf.xcjf010   = '3'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_center         #實體利潤中心（組織)
           SELECT pmds003,pmds002  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM pmds_t
            WHERE pmdsent   = g_enterprise
              AND pmdsdocno = g_xcjf.xcjf001
      WHEN '103'  #委外入库 同采购入库
           LET g_xcjf.xcjf010   = '3'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_center         #實體利潤中心（組織)
           SELECT pmds003,pmds002  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM pmds_t
            WHERE pmdsent   = g_enterprise
              AND pmdsdocno = g_xcjf.xcjf001
      WHEN '108'  #采购仓退 采购入库的反向
           LET g_xcjf.xcjf010   = '3'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_center         #實體利潤中心（組織)
           SELECT pmds003,pmds002  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM pmds_t
            WHERE pmdsent   = g_enterprise
              AND pmdsdocno = g_xcjf.xcjf001
      WHEN '110'  #生产入库
           LET g_xcjf.xcjf010   = '3'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
           LET g_xcjf.xcjf013   = g_center         #實體利潤中心（組織)
           SELECT sfea003,sfea002  #申请部门，申请人员
             INTO g_xcjf.xcjf031,g_xcjf.xcjf041
             FROM sfea_t
            WHERE sfeaent   = g_enterprise
              AND sfeadocno = g_xcjf.xcjf001
   END CASE
   #目前来源都是基于存货，计算类别都是损益;在制和资产等后面再思考如何做
   LET g_xcjf.xcjf011   = '1'              #來源(存貨/在制)
   LET g_xcjf.xcjf012   = '1'              #計算類別(損益/資產)
   LET g_xcjf.xcjf014   = g_xcja.xcja007   #虛擬利潤中心(組織)
   LET g_xcjf.xcjf015   = g_xcck.xccksite  #交易組織(site)
   LET g_xcjf.xcjf016   = g_xcck.xcck010   #料號
   LET g_xcjf.xcjf017   = g_xcck.xcck015   #倉庫
   LET g_xcjf.xcjf018   = g_xcck.xcck017   #批號
   LET g_xcjf.xcjf019   = g_xcck.xcck020   #異動類型
   LET g_xcjf.xcjf020   = g_xcck.xcck044   #基礎單位
   LET g_xcjf.xcjf021   = g_xcck.xcck009   #出入庫碼
   
   #LET g_xcjf.xcjf028   =    #收入成本存貨科目
   #mod--161103-00045#2 By shiun--(S)
   IF g_xcjf.xcjf010 MATCHES '[12]' THEN  #收入
#      CALL s_get_item_acc(g_xcje.xcjeld,'4',g_xcjf.xcjf016,'','',g_glaa.glaacomp,'') 
      CALL s_get_item_acc(g_xcje.xcjeld,'27',g_xcjf.xcjf016,'','',g_glaa.glaacomp,'') #170105-00002#1 mod 26->27
         RETURNING l_success,g_xcjf.xcjf028  #收入
   END IF
   IF g_xcjf.xcjf010 MATCHES '[34]' THEN  #成本
#      CALL s_get_item_acc(g_xcje.xcjeld,'5',g_xcjf.xcjf016,'','',g_glaa.glaacomp,'') 
      CALL s_get_item_acc(g_xcje.xcjeld,'28',g_xcjf.xcjf016,'','',g_glaa.glaacomp,'')  #170105-00002#1 mod 27->28
         RETURNING l_success,g_xcjf.xcjf028 #成本
   END IF
   #mod--161103-00045#2 By shiun--(E)
   LET g_xcjf.xcjf029   = g_xcjf.xcjf028   #對方科目
   LET g_xcjf.xcjf030   = ''               #摘要
   
   LET g_xcjf.xcjf032   = g_xcjf.xcjf013        #成本中心=實體利潤中心（組織)
   
   #根据科目预设资料
   #获取科目相关设置预设资料
#   SELECT * INTO l_glad.* FROM glad_t  #161124-00048#12 mark
   #161124-00048#12 add(s)
   SELECT gladent,gladownid,gladowndp,gladcrtid,gladcrtdp,gladcrtdt,gladmodid,gladmoddt,
          gladstus,gladld,glad001,glad002,glad003,glad004,glad005,glad006,glad007,glad008,
          glad009,glad010,glad011,glad012,glad013,glad014,glad015,glad016,glad017,glad0171,
          glad0172,glad018,glad0181,glad0182,glad019,glad0191,glad0192,glad020,glad0201,glad0202,
          glad021,glad0211,glad0212,glad022,glad0221,glad0222,glad023,glad0231,glad0232,glad024,
          glad0241,glad0242,glad025,glad0251,glad0252,glad026,glad0261,glad0262,glad027,glad030,
          glad031,glad032,glad033,glad034,glad035,glad036 
     INTO l_glad.* FROM glad_t
   #161124-00048#12 add(e)
    WHERE gladent = g_enterprise
      AND gladld  = g_xcje.xcjeld
      AND glad001 = g_xcjf.xcjf028  #科目
   IF l_glad.glad009 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'4') RETURNING g_xcjf.xcjf033  #區域
   END IF
   IF l_glad.glad010 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'5') RETURNING g_xcjf.xcjf034  #交易對象
   END IF
   IF l_glad.glad027 = 'Y'THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'6') RETURNING g_xcjf.xcjf035  #帳款對象
   END IF
   IF l_glad.glad011 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'7') RETURNING g_xcjf.xcjf036  #客群
   END IF
   IF l_glad.glad012 ='Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'8') RETURNING g_xcjf.xcjf037  #品類
   END IF
   IF l_glad.glad031 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'9') RETURNING g_xcjf.xcjf038  #經營類別
   END IF
   IF l_glad.glad032 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'10') RETURNING g_xcjf.xcjf039  #渠道
   END IF
   IF l_glad.glad033 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'11') RETURNING g_xcjf.xcjf040  #品牌
   END IF
   IF l_glad.glad015 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'13') RETURNING g_xcjf.xcjf042  #項目號
   END IF
   IF l_glad.glad016 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'14') RETURNING g_xcjf.xcjf043  #WBS
   END IF
   IF l_glad.glad017 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'15') RETURNING g_xcjf.xcjf044  #自由核算項1
   END IF
   IF l_glad.glad018 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'16') RETURNING g_xcjf.xcjf045  #自由核算項2
   END IF
   IF l_glad.glad019 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'17') RETURNING g_xcjf.xcjf046  #自由核算項3
   END IF
   IF l_glad.glad020 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'18') RETURNING g_xcjf.xcjf047  #自由核算項4
   END IF
   IF l_glad.glad021 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'19') RETURNING g_xcjf.xcjf048  #自由核算項5
   END IF
   IF l_glad.glad022 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'20') RETURNING g_xcjf.xcjf049  #自由核算項6
   END IF
   IF l_glad.glad023 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'21') RETURNING g_xcjf.xcjf050  #自由核算項7
   END IF
   IF l_glad.glad024 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'22') RETURNING g_xcjf.xcjf051  #自由核算項8
   END IF
   IF l_glad.glad025 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'23') RETURNING g_xcjf.xcjf052  #自由核算項9
   END IF
   IF l_glad.glad026 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'24') RETURNING g_xcjf.xcjf053  #自由核算項10
   END IF
   
   LET g_xcjf.xcjf022 = g_xcck.xcck201   #異動數量
   #xcjf020   = xcck044   #基礎單位，即成本单位
   LET g_xcjf.xcjf023 = g_xcck.xcck043   #計價單位=交易单位  xcck044成本单位 
   #換算率xcjf024:计价单位与成本单位的换算率
   IF g_xcjf.xcjf020 = g_xcjf.xcjf023 THEN    #计价单位xcck043（交易单位）与成本单位xcck044的换算率
      LET g_xcjf.xcjf024 = 1             #換算率
   ELSE
      CALL s_aooi250_convert_qty1(g_xcjf.xcjf016,g_xcck.xcck043,g_xcck.xcck044,1)
           RETURNING l_success,g_xcjf.xcjf024
      IF cl_null(g_xcjf.xcjf024) OR g_xcjf.xcjf024 = 0 THEN
         LET g_xcjf.xcjf024 = 1          #換算率
      END IF
   END IF
   
   #LET g_xcjf.xcjf101 =    #交易幣別
   #LET g_xcjf.xcjf102 =    #交易單價(交易单位的)
   #LET g_xcjf.xcjf110 =    #交易金額
   #LET g_xcjf.xcjf200 =    #換算匯率
   #LET g_xcjf.xcjf210 =    #換算匯率二
   #LET g_xcjf.xcjf220 =    #換算匯率三
   #LET g_xcjf.xcjf201 =    #本位幣一金額
   #LET g_xcjf.xcjf211 =    #本位幣二金額
   #LET g_xcjf.xcjf221 =    #本位幣三金額
   #add zhangllc 160617--s 160616-00006#2
   IF g_xcja.xcja011='1' AND (p_type = '2015' OR p_type = '2025') THEN
      #本位币金额 = 成本单位交易金额*汇率一 = 交易单位交易金额*单位换算率*汇率一 = 交易单位单价*交易数量*单位换算率*汇率一
      #计算交易单价xcjf102
      IF g_xcjf.xcjf023 = g_imaa006 THEN    #计价单位与内部定价单位的换算率
         LET l_rate = 1             #換算率
      ELSE
         CALL s_aooi250_convert_qty1(g_xcjf.xcjf016,g_imaa006,g_xcjf.xcjf023,1)
              RETURNING l_success,l_rate
         IF cl_null(l_rate) OR l_rate = 0 THEN
            LET l_rate = 1          #換算率
         END IF
      END IF
      LET g_xcjf.xcjf102 = g_xccc280 * l_rate       #交易單價=内部交易定价折换成实际交易单位的定价
      
      LET g_xcjf.xcjf101 = g_xccc010        #交易幣別
      LET g_xcjf.xcjf110 = g_xcjf.xcjf102 * g_xcjf.xcjf022   #交易金額=单价*数量（交易单位的，非成本单位的）
      
      #汇率一
      CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_xcck.xcck013,g_xcjf.xcjf101,g_glaa.glaa001,0,g_glaa.glaa025)
            RETURNING g_xcjf.xcjf200
      IF cl_null(g_xcjf.xcjf200) OR g_xcjf.xcjf200=0 THEN LET g_xcjf.xcjf200 = 1 END IF
      LET g_xcjf.xcjf201 = (g_xcjf.xcjf110*g_xcjf.xcjf024) * g_xcjf.xcjf200   #本位幣一金額=成本单位交易金额*汇率
      #汇率二
      IF g_glaa.glaa015 = 'Y' THEN
         CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_xcck.xcck013,g_xcjf.xcjf101,g_glaa.glaa016,0,g_glaa.glaa018)
            RETURNING g_xcjf.xcjf210
      ELSE
         LET g_xcjf.xcjf210 = 0
      END IF
      LET g_xcjf.xcjf211 = (g_xcjf.xcjf110*g_xcjf.xcjf024) * g_xcjf.xcjf210   #本位幣二金額=成本单位交易金额*汇率二
      #汇率三
      IF g_glaa.glaa019 = 'Y' THEN
         CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_xcck.xcck013,g_xcjf.xcjf101,g_glaa.glaa020,0,g_glaa.glaa022)
            RETURNING g_xcjf.xcjf220
      ELSE
         LET g_xcjf.xcjf220 = 0
      END IF
      LET g_xcjf.xcjf221 = (g_xcjf.xcjf110*g_xcjf.xcjf024) * g_xcjf.xcjf220   #本位幣三金額=成本单位交易金额*汇率三
           
   ELSE
   #add zhangllc 160617--e
      CASE g_xcja.xcja008
         WHEN '1'  #推算法：取axci951的xcjb009
              #外部收入的抵扣的使用实际的xccc280
              IF p_type = '2012_2' OR p_type = '2014_2' OR p_type = '2022_2' OR p_type = '2024_2' THEN
                 #本位币金额 = 成本单位交易金额*汇率一 = 交易单位交易金额*单位换算率*汇率一 = 交易单位单价*交易数量*单位换算率*汇率一
                 #计算交易单价xcjf102
                 IF g_xcjf.xcjf023 = g_imaa006 THEN    #计价单位与内部定价单位的换算率
                    LET l_rate = 1             #換算率
                 ELSE
                    CALL s_aooi250_convert_qty1(g_xcjf.xcjf016,g_imaa006,g_xcjf.xcjf023,1)
                         RETURNING l_success,l_rate
                    IF cl_null(l_rate) OR l_rate = 0 THEN
                       LET l_rate = 1          #換算率
                    END IF
                 END IF
                 LET g_xcjf.xcjf102 = g_xccc280 * l_rate       #交易單價=内部交易定价折换成实际交易单位的定价
                 
                 LET g_xcjf.xcjf101 = g_xccc010        #交易幣別
                 LET g_xcjf.xcjf110 = g_xcjf.xcjf102 * g_xcjf.xcjf022   #交易金額=单价*数量（交易单位的，非成本单位的）
              ELSE
                 IF cl_null(g_xcjb007) OR cl_null(g_xcjb008) OR g_xcjb009=0 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.replace[1] = g_center
                    LET g_errparam.replace[2] = g_ob_center
                    LET g_errparam.code = 'axc-00752'
                    display 'xcck:',g_xcck.xcck006,' center:',g_center,' ob_center:',g_ob_center
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET r_success = FALSE
                    RETURN r_success
                 END IF
                 #本位币金额 = 成本单位交易金额*汇率一 = 交易单位交易金额*单位换算率*汇率一 = 交易单位单价*交易数量*单位换算率*汇率一
                 #计算交易单价xcjf102
                 IF g_xcjf.xcjf023 = g_xcjb007 THEN    #计价单位与内部定价单位的换算率
                    LET l_rate = 1             #換算率
                 ELSE
                    CALL s_aooi250_convert_qty1(g_xcjf.xcjf016,g_xcjb007,g_xcjf.xcjf023,1)
                         RETURNING l_success,l_rate
                    IF cl_null(l_rate) OR l_rate = 0 THEN
                       LET l_rate = 1          #換算率
                    END IF
                 END IF
                 LET g_xcjf.xcjf102 = g_xcjb009 * l_rate       #交易單價=内部交易定价折换成实际交易单位的定价
                 
                 LET g_xcjf.xcjf101 = g_xcjb008        #交易幣別
                 LET g_xcjf.xcjf110 = g_xcjf.xcjf102 * g_xcjf.xcjf022   #交易金額=单价*数量（交易单位的，非成本单位的）
              END IF
              
              #汇率一
              CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_xcck.xcck013,g_xcjf.xcjf101,g_glaa.glaa001,0,g_glaa.glaa025)
                    RETURNING g_xcjf.xcjf200
              IF cl_null(g_xcjf.xcjf200) OR g_xcjf.xcjf200=0 THEN LET g_xcjf.xcjf200 = 1 END IF
              LET g_xcjf.xcjf201 = (g_xcjf.xcjf110*g_xcjf.xcjf024) * g_xcjf.xcjf200   #本位幣一金額=成本单位交易金额*汇率
              #汇率二
              IF g_glaa.glaa015 = 'Y' THEN
                 CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_xcck.xcck013,g_xcjf.xcjf101,g_glaa.glaa016,0,g_glaa.glaa018)
                    RETURNING g_xcjf.xcjf210
              ELSE
                 LET g_xcjf.xcjf210 = 0
              END IF
              LET g_xcjf.xcjf211 = (g_xcjf.xcjf110*g_xcjf.xcjf024) * g_xcjf.xcjf210   #本位幣二金額=成本单位交易金额*汇率二
              #汇率三
              IF g_glaa.glaa019 = 'Y' THEN
                 CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_xcck.xcck013,g_xcjf.xcjf101,g_glaa.glaa020,0,g_glaa.glaa022)
                    RETURNING g_xcjf.xcjf220
              ELSE
                 LET g_xcjf.xcjf220 = 0
              END IF
              LET g_xcjf.xcjf221 = (g_xcjf.xcjf110*g_xcjf.xcjf024) * g_xcjf.xcjf220   #本位幣三金額=成本单位交易金额*汇率三
              
         WHEN '2'  #对比法：取xcck的成本计算类型为xcck的成本
              #本位币金额 = 成本单位交易金额*汇率一 = 交易单位交易金额*单位换算率*汇率一 = 交易单位单价*交易数量*单位换算率*汇率一
              LET g_xcjf.xcjf101 = g_xcck.xcck040   #交易幣別
              LET g_xcjf.xcjf201 = g_xcck.xcck202   #本位幣一金額
              #汇率一
              CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_today,g_xcjf.xcjf101,g_glaa.glaa001,0,g_glaa.glaa025)
                    RETURNING g_xcjf.xcjf200
              IF cl_null(g_xcjf.xcjf200) OR g_xcjf.xcjf200=0 THEN LET g_xcjf.xcjf200 = 1 END IF
              
              LET g_xcjf.xcjf110 = g_xcjf.xcjf201 / g_xcjf.xcjf200/g_xcjf.xcjf024   #交易单位交易金額=本位币一金额/汇率一/成本单位换算率=成本单位交易金额/成本单位与交易单位的换算率
              LET g_xcjf.xcjf102 = g_xcjf.xcjf110 / g_xcjf.xcjf022   #交易單價=交易金额/数量/
              #汇率二
              IF g_glaa.glaa015 = 'Y' THEN
                 CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_today,g_xcjf.xcjf101,g_glaa.glaa016,0,g_glaa.glaa018)
                    RETURNING g_xcjf.xcjf210
              ELSE
                 LET g_xcjf.xcjf210 = 0
              END IF
              LET g_xcjf.xcjf211 = g_xcjf.xcjf110 * g_xcjf.xcjf210   #本位币二金额=交易金额*汇率二
              #汇率三
              IF g_glaa.glaa019 = 'Y' THEN
                 CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_today,g_xcjf.xcjf101,g_glaa.glaa020,0,g_glaa.glaa022)
                    RETURNING g_xcjf.xcjf220
              ELSE
                 LET g_xcjf.xcjf220 = 0
              END IF
              LET g_xcjf.xcjf221 = g_xcjf.xcjf110 * g_xcjf.xcjf220   #本位币二金额=交易金额*汇率三
      END CASE
   END IF  #add zhangllc 160617 160616-00006#2
   
   LET g_xcjf.xcjfud021 = ''   #自定義欄位(日期時間)021
   LET g_xcjf.xcjfud022 = ''   #自定義欄位(日期時間)022
   LET g_xcjf.xcjfud023 = ''   #自定義欄位(日期時間)023
   LET g_xcjf.xcjfud024 = ''   #自定義欄位(日期時間)024
   LET g_xcjf.xcjfud025 = ''   #自定義欄位(日期時間)025
   LET g_xcjf.xcjfud026 = ''   #自定義欄位(日期時間)026
   LET g_xcjf.xcjfud027 = ''   #自定義欄位(日期時間)027
   LET g_xcjf.xcjfud028 = ''   #自定義欄位(日期時間)028
   LET g_xcjf.xcjfud029 = ''   #自定義欄位(日期時間)029
   LET g_xcjf.xcjfud030 = ''   #自定義欄位(日期時間)030
   
   #销售分摊处理:*分摊比率
   IF p_type = '2011' #销售出货同利润中心的库存-分摊组织的内部收入增加
   OR p_type = '2012' #销售出货同利润中心的库存-销售组织的外部收入减少
   OR p_type = '2021' #销售退货同利润中心的库存--分摊组织的内部收入减少
   OR p_type = '2022' #销售退货同利润中心的库存--销售组织的外部收入增加
   THEN
      LET g_xcjf.xcjf110 = g_xcjf.xcjf110 * g_xcjc007/100   #交易金額
      LET g_xcjf.xcjf201 = g_xcjf.xcjf201 * g_xcjc007/100   #本位幣一金額
      LET g_xcjf.xcjf211 = g_xcjf.xcjf211 * g_xcjc007/100   #本位幣二金額
      LET g_xcjf.xcjf221 = g_xcjf.xcjf221 * g_xcjc007/100   #本位幣三金額
   END IF
   
   IF p_type = '108'   #采购仓退 采购入库的反向
   OR p_type = '3031'  #生产退料 生产发料的反向--同利润中心的库存
   OR p_type = '3032'  #生产退料 生产发料的反向--不同利润中心的库存-库存所在利润中心方（center）
   OR p_type = '3033'  #生产退料 生产发料的反向--不同利润中心的库存-申请部门所在利润中心方(ob_center)
   OR p_type = '2012_2'  #销售出货同利润中心的库存-销售组织的外部收入减少
   OR p_type = '2014_2'  #销售出货不同利润中心的库存--申请部门所在利润中心方(ob_center)--减少外部收入
   OR p_type = '2021'  #销售退货同利润中心的库存--分摊组织的内部收入减少
   OR p_type = '2022_1'  #销售退货同利润中心的库存--销售组织的内部成本减少
   OR p_type = '2023'  #销售退货不同利润中心的库存--库存所在利润中心方（center）--减少内部收入
   OR p_type = '2024_1'  #销售退货不同利润中心的库存--申请部门所在利润中心方(ob_center)--减少内部
   OR p_type = '2025'   #销售退货不同利润中心的库存-库存所在利润中心方（center）--减少内部成本   #160616-00006#2 add
   THEN
      LET g_xcjf.xcjf102 = g_xcjf.xcjf102 * -1   #交易單價
      LET g_xcjf.xcjf110 = g_xcjf.xcjf110 * -1   #交易金額
      LET g_xcjf.xcjf201 = g_xcjf.xcjf201 * -1   #本位幣一金額
      LET g_xcjf.xcjf211 = g_xcjf.xcjf211 * -1   #本位幣二金額
      LET g_xcjf.xcjf221 = g_xcjf.xcjf221 * -1   #本位幣三金額
   END IF

#   INSERT INTO xcjf_t VALUES g_xcjf.* #161124-00048#12 mark
   #161124-00048#12 add(s)
   INSERT INTO xcjf_t(xcjfent,xcjfsite,xcjfld,xcjfdocno,xcjfseq,xcjf001,xcjf002,xcjf003,xcjf010,xcjf011,
                      xcjf012,xcjf013,xcjf014,xcjf015,xcjf016,xcjf017,xcjf018,xcjf019,xcjf020,xcjf021,xcjf022,
                      xcjf023,xcjf024,xcjf028,xcjf029,xcjf030,xcjf031,xcjf032,xcjf033,xcjf034,xcjf035,xcjf036,
                      xcjf037,xcjf038,xcjf039,xcjf040,xcjf041,xcjf042,xcjf043,xcjf044,xcjf045,xcjf046,xcjf047,
                      xcjf048,xcjf049,xcjf050,xcjf051,xcjf052,xcjf053,xcjf101,xcjf102,xcjf110,xcjf200,xcjf201,
                      xcjf210,xcjf211,xcjf220,xcjf221,xcjfud001,xcjfud002,xcjfud003,xcjfud004,xcjfud005,xcjfud006,
                      xcjfud007,xcjfud008,xcjfud009,xcjfud010,xcjfud011,xcjfud012,xcjfud013,xcjfud014,xcjfud015,
                      xcjfud016,xcjfud017,xcjfud018,xcjfud019,xcjfud020,xcjfud021,xcjfud022,xcjfud023,xcjfud024,
                      xcjfud025,xcjfud026,xcjfud027,xcjfud028,xcjfud029,xcjfud030) 
               VALUES(g_xcjf.xcjfent,g_xcjf.xcjfsite,g_xcjf.xcjfld,g_xcjf.xcjfdocno,g_xcjf.xcjfseq,g_xcjf.xcjf001,g_xcjf.xcjf002,g_xcjf.xcjf003,g_xcjf.xcjf010,g_xcjf.xcjf011,
                      g_xcjf.xcjf012,g_xcjf.xcjf013,g_xcjf.xcjf014,g_xcjf.xcjf015,g_xcjf.xcjf016,g_xcjf.xcjf017,g_xcjf.xcjf018,g_xcjf.xcjf019,g_xcjf.xcjf020,g_xcjf.xcjf021,g_xcjf.xcjf022,
                      g_xcjf.xcjf023,g_xcjf.xcjf024,g_xcjf.xcjf028,g_xcjf.xcjf029,g_xcjf.xcjf030,g_xcjf.xcjf031,g_xcjf.xcjf032,g_xcjf.xcjf033,g_xcjf.xcjf034,g_xcjf.xcjf035,g_xcjf.xcjf036,
                      g_xcjf.xcjf037,g_xcjf.xcjf038,g_xcjf.xcjf039,g_xcjf.xcjf040,g_xcjf.xcjf041,g_xcjf.xcjf042,g_xcjf.xcjf043,g_xcjf.xcjf044,g_xcjf.xcjf045,g_xcjf.xcjf046,g_xcjf.xcjf047,
                      g_xcjf.xcjf048,g_xcjf.xcjf049,g_xcjf.xcjf050,g_xcjf.xcjf051,g_xcjf.xcjf052,g_xcjf.xcjf053,g_xcjf.xcjf101,g_xcjf.xcjf102,g_xcjf.xcjf110,g_xcjf.xcjf200,g_xcjf.xcjf201,
                      g_xcjf.xcjf210,g_xcjf.xcjf211,g_xcjf.xcjf220,g_xcjf.xcjf221,g_xcjf.xcjfud001,g_xcjf.xcjfud002,g_xcjf.xcjfud003,g_xcjf.xcjfud004,g_xcjf.xcjfud005,g_xcjf.xcjfud006,
                      g_xcjf.xcjfud007,g_xcjf.xcjfud008,g_xcjf.xcjfud009,g_xcjf.xcjfud010,g_xcjf.xcjfud011,g_xcjf.xcjfud012,g_xcjf.xcjfud013,g_xcjf.xcjfud014,g_xcjf.xcjfud015,
                      g_xcjf.xcjfud016,g_xcjf.xcjfud017,g_xcjf.xcjfud018,g_xcjf.xcjfud019,g_xcjf.xcjfud020,g_xcjf.xcjfud021,g_xcjf.xcjfud022,g_xcjf.xcjfud023,g_xcjf.xcjfud024,
                      g_xcjf.xcjfud025,g_xcjf.xcjfud026,g_xcjf.xcjfud027,g_xcjf.xcjfud028,g_xcjf.xcjfud029,g_xcjf.xcjfud030) 
               
   #161124-00048#12 add(e)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins xcjf'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

#计算库存结存部分
#仓库所属利润中心的内部成本 金额为正向
PRIVATE FUNCTION axcp950_ins_xcjf_f_xccq()
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_success  LIKE type_t.num5
#   DEFINE l_glad     RECORD LIKE glad_t.*  #科目相关设置 #161124-00048#12 mark
  #161124-00048#12 add(s)
  DEFINE l_glad RECORD  #帳套科目管理設定檔
       gladent LIKE glad_t.gladent, #企业编号
       gladownid LIKE glad_t.gladownid, #资料所有者
       gladowndp LIKE glad_t.gladowndp, #资料所有部门
       gladcrtid LIKE glad_t.gladcrtid, #资料录入者
       gladcrtdp LIKE glad_t.gladcrtdp, #资料录入部门
       gladcrtdt LIKE glad_t.gladcrtdt, #资料创建日
       gladmodid LIKE glad_t.gladmodid, #资料更改者
       gladmoddt LIKE glad_t.gladmoddt, #最近更改日
       gladstus LIKE glad_t.gladstus, #状态码
       gladld LIKE glad_t.gladld, #账套
       glad001 LIKE glad_t.glad001, #会计科目编号
       glad002 LIKE glad_t.glad002, #是否按余额类型生成分录
       glad003 LIKE glad_t.glad003, #启用凭证项次细项立冲
       glad004 LIKE glad_t.glad004, #凭证项次异动别
       glad005 LIKE glad_t.glad005, #是否启用数量金额式
       glad006 LIKE glad_t.glad006, #借方现金变动码
       glad007 LIKE glad_t.glad007, #启用部门管理
       glad008 LIKE glad_t.glad008, #启用利润成本管理
       glad009 LIKE glad_t.glad009, #启用区域管理
       glad010 LIKE glad_t.glad010, #启用收付款客商管理
       glad011 LIKE glad_t.glad011, #启用客群管理
       glad012 LIKE glad_t.glad012, #启用产品类别管理
       glad013 LIKE glad_t.glad013, #启用人员管理
       glad014 LIKE glad_t.glad014, #no use
       glad015 LIKE glad_t.glad015, #启用项目管理
       glad016 LIKE glad_t.glad016, #启用WBS管理
       glad017 LIKE glad_t.glad017, #启用自由核算项一
       glad0171 LIKE glad_t.glad0171, #自由核算项一类型编号
       glad0172 LIKE glad_t.glad0172, #自由核算项一控制方式
       glad018 LIKE glad_t.glad018, #启用自由核算项二
       glad0181 LIKE glad_t.glad0181, #自由核算项二类型编号
       glad0182 LIKE glad_t.glad0182, #自由核算项二控制方式
       glad019 LIKE glad_t.glad019, #启用自由核算项三
       glad0191 LIKE glad_t.glad0191, #自由核算项三类型编号
       glad0192 LIKE glad_t.glad0192, #自由核算项三控制方式
       glad020 LIKE glad_t.glad020, #启用自由核算项四
       glad0201 LIKE glad_t.glad0201, #自由核算项四类型编号
       glad0202 LIKE glad_t.glad0202, #自由核算项四控制方式
       glad021 LIKE glad_t.glad021, #启用自由核算项五
       glad0211 LIKE glad_t.glad0211, #自由核算项五类型编号
       glad0212 LIKE glad_t.glad0212, #自由核算项五控制方式
       glad022 LIKE glad_t.glad022, #启用自由核算项六
       glad0221 LIKE glad_t.glad0221, #自由核算项六类型编号
       glad0222 LIKE glad_t.glad0222, #自由核算项六控制方式
       glad023 LIKE glad_t.glad023, #启用自由核算项七
       glad0231 LIKE glad_t.glad0231, #自由核算项七类型编号
       glad0232 LIKE glad_t.glad0232, #自由核算项七控制方式
       glad024 LIKE glad_t.glad024, #启用自由核算项八
       glad0241 LIKE glad_t.glad0241, #自由核算项八类型编号
       glad0242 LIKE glad_t.glad0242, #自由核算项八控制方式
       glad025 LIKE glad_t.glad025, #启用自由核算项九
       glad0251 LIKE glad_t.glad0251, #自由核算项九类型编号
       glad0252 LIKE glad_t.glad0252, #自由核算项九控制方式
       glad026 LIKE glad_t.glad026, #启用自由核算项十
       glad0261 LIKE glad_t.glad0261, #自由核算项十类型编号
       glad0262 LIKE glad_t.glad0262, #自由核算项十控制方式
       glad027 LIKE glad_t.glad027, #启用账款客商管理
       glad030 LIKE glad_t.glad030, #是否进行预算管控
       glad031 LIKE glad_t.glad031, #启用经营方式管理
       glad032 LIKE glad_t.glad032, #启用渠道管理
       glad033 LIKE glad_t.glad033, #启用品牌管理
       glad034 LIKE glad_t.glad034, #科目做多币种管理
       glad035 LIKE glad_t.glad035, #是否是子系统科目
       glad036 LIKE glad_t.glad036  #贷方现金变动码
END RECORD
  #161124-00048#12 add(e)
   DEFINE l_rate     LIKE xcjf_t.xcjf024   #计价单位与内部定价单位的换算率
   
   LET r_success = TRUE
   
   LET g_seq = g_seq + 1
   
   INITIALIZE g_xcjf.* TO NULL   #清空
   LET g_xcjf.xcjfent   = g_enterprise     #企業編號
   LET g_xcjf.xcjfsite  = g_xcje.xcjesite  #賬務中心
   LET g_xcjf.xcjfld    = g_xcje.xcjeld    #帳套
   LET g_xcjf.xcjfdocno = g_xcje.xcjedocno #單據編號
   LET g_xcjf.xcjfseq   = g_seq            #項次
   LET g_xcjf.xcjf001   = ''   #業務單據
   LET g_xcjf.xcjf002   = 0    #項次
   LET g_xcjf.xcjf003   = 0    #項次
   #库存结存 --仓库所属利润中心的内部成本 金额为正向
   LET g_xcjf.xcjf010   = '3'              #類型(1.内部收入/2.外部收入/3.内部成本/4.外部成本)
   LET g_xcjf.xcjf013   = g_center         #實體利潤中心（組織)
   LET g_xcjf.xcjf031   = ''    #申请部门
   LET g_xcjf.xcjf041   = ''    #申请人员
   
      #目前来源都是基于存货，计算类别都是损益;在制和资产等后面再思考如何做
   LET g_xcjf.xcjf011   = '1'              #來源(存貨/在制)
   LET g_xcjf.xcjf012   = '1'              #計算類別(損益/資產)
   LET g_xcjf.xcjf014   = g_xcja.xcja007   #虛擬利潤中心(組織)
   LET g_xcjf.xcjf015   = ''               #交易組織(site)
   LET g_xcjf.xcjf016   = g_xccq006        #料號
   LET g_xcjf.xcjf017   = g_xccq010        #倉庫
   LET g_xcjf.xcjf018   = ''   #批號
   LET g_xcjf.xcjf019   = ''   #異動類型
   LET g_xcjf.xcjf020   = g_imaa006   #基礎單位
   LET g_xcjf.xcjf021   = 1   #出入庫碼
   
   #LET g_xcjf.xcjf028   =    #收入成本存貨科目
   #mod--161103-00045#2 By shiun--(S)
   IF g_xcjf.xcjf010 MATCHES '[12]' THEN  #收入
#      CALL s_get_item_acc(g_xcje.xcjeld,'4',g_xcjf.xcjf016,'','',g_glaa.glaacomp,'') 
      CALL s_get_item_acc(g_xcje.xcjeld,'27',g_xcjf.xcjf016,'','',g_glaa.glaacomp,'') #170105-00002#1 mod 26->27
         RETURNING l_success,g_xcjf.xcjf028  #收入
   END IF
   IF g_xcjf.xcjf010 MATCHES '[34]' THEN  #成本
#      CALL s_get_item_acc(g_xcje.xcjeld,'5',g_xcjf.xcjf016,'','',g_glaa.glaacomp,'') 
      CALL s_get_item_acc(g_xcje.xcjeld,'28',g_xcjf.xcjf016,'','',g_glaa.glaacomp,'')  #170105-00002#1 mod 27->28
         RETURNING l_success,g_xcjf.xcjf028 #成本
   END IF
   #mod--161103-00045#2 By shiun--(E)
   LET g_xcjf.xcjf029   = g_xcjf.xcjf028   #對方科目
   LET g_xcjf.xcjf030   = ''               #摘要
   
   LET g_xcjf.xcjf032   = g_xcjf.xcjf013        #成本中心=實體利潤中心（組織)
   
   #根据科目预设资料
   #获取科目相关设置预设资料
#   SELECT * INTO l_glad.* FROM glad_t  #161124-00048#12 mark
   #161124-00048#12 add(s)
   SELECT gladent,gladownid,gladowndp,gladcrtid,gladcrtdp,gladcrtdt,gladmodid,gladmoddt,
          gladstus,gladld,glad001,glad002,glad003,glad004,glad005,glad006,glad007,glad008,
          glad009,glad010,glad011,glad012,glad013,glad014,glad015,glad016,glad017,glad0171,
          glad0172,glad018,glad0181,glad0182,glad019,glad0191,glad0192,glad020,glad0201,glad0202,
          glad021,glad0211,glad0212,glad022,glad0221,glad0222,glad023,glad0231,glad0232,glad024,
          glad0241,glad0242,glad025,glad0251,glad0252,glad026,glad0261,glad0262,glad027,glad030,
          glad031,glad032,glad033,glad034,glad035,glad036 
     INTO l_glad.* FROM glad_t
   #161124-00048#12 add(e)
    WHERE gladent = g_enterprise
      AND gladld  = g_xcje.xcjeld
      AND glad001 = g_xcjf.xcjf028  #科目
   IF l_glad.glad009 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'4') RETURNING g_xcjf.xcjf033  #區域
   END IF
   IF l_glad.glad010 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'5') RETURNING g_xcjf.xcjf034  #交易對象
   END IF
   IF l_glad.glad027 = 'Y'THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'6') RETURNING g_xcjf.xcjf035  #帳款對象
   END IF
   IF l_glad.glad011 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'7') RETURNING g_xcjf.xcjf036  #客群
   END IF
   IF l_glad.glad012 ='Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'8') RETURNING g_xcjf.xcjf037  #品類
   END IF
   IF l_glad.glad031 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'9') RETURNING g_xcjf.xcjf038  #經營類別
   END IF
   IF l_glad.glad032 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'10') RETURNING g_xcjf.xcjf039  #渠道
   END IF
   IF l_glad.glad033 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'11') RETURNING g_xcjf.xcjf040  #品牌
   END IF
   IF l_glad.glad015 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'13') RETURNING g_xcjf.xcjf042  #項目號
   END IF
   IF l_glad.glad016 = 'Y' THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'14') RETURNING g_xcjf.xcjf043  #WBS
   END IF
   IF l_glad.glad017 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'15') RETURNING g_xcjf.xcjf044  #自由核算項1
   END IF
   IF l_glad.glad018 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'16') RETURNING g_xcjf.xcjf045  #自由核算項2
   END IF
   IF l_glad.glad019 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'17') RETURNING g_xcjf.xcjf046  #自由核算項3
   END IF
   IF l_glad.glad020 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'18') RETURNING g_xcjf.xcjf047  #自由核算項4
   END IF
   IF l_glad.glad021 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'19') RETURNING g_xcjf.xcjf048  #自由核算項5
   END IF
   IF l_glad.glad022 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'20') RETURNING g_xcjf.xcjf049  #自由核算項6
   END IF
   IF l_glad.glad023 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'21') RETURNING g_xcjf.xcjf050  #自由核算項7
   END IF
   IF l_glad.glad024 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'22') RETURNING g_xcjf.xcjf051  #自由核算項8
   END IF
   IF l_glad.glad025 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'23') RETURNING g_xcjf.xcjf052  #自由核算項9
   END IF
   IF l_glad.glad026 = 'Y'  THEN
      CALL s_voucher_get_fix_default_value(g_xcje.xcjeld,g_xcjf.xcjf028,'24') RETURNING g_xcjf.xcjf053  #自由核算項10
   END IF
   
   LET g_xcjf.xcjf022 = g_xccq901       #異動數量
   LET g_xcjf.xcjf023 = g_imaa006       #計價單位
   #換算率xcjf024:计价单位与成本单位的换算率,这里都给值基础单位，所以换算率为1（基础单位就是成本单位）
   LET g_xcjf.xcjf024 = 1             #換算率
   
   #LET g_xcjf.xcjf101 =    #交易幣別
   #LET g_xcjf.xcjf102 =    #交易單價(交易单位的)
   #LET g_xcjf.xcjf110 =    #交易金額
   #LET g_xcjf.xcjf200 =    #換算匯率
   #LET g_xcjf.xcjf210 =    #換算匯率二
   #LET g_xcjf.xcjf220 =    #換算匯率三
   #LET g_xcjf.xcjf201 =    #本位幣一金額
   #LET g_xcjf.xcjf211 =    #本位幣二金額
   #LET g_xcjf.xcjf221 =    #本位幣三金額
   CASE g_xcja.xcja008
      WHEN '1'  #推算法：取axci951的xcjb009
           IF cl_null(g_xcjb007) OR cl_null(g_xcjb008) OR g_xcjb009=0 THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.replace[1] = g_center
              LET g_errparam.replace[2] = 'ALL'
              LET g_errparam.code = 'axc-00752'
              display 'xcck:',g_xcck.xcck006,' center:',g_center,' ob_center:',g_ob_center
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success = FALSE
              RETURN r_success
           END IF
           #本位币金额 = 成本单位交易金额*汇率一 = 交易单位交易金额*单位换算率*汇率一 = 交易单位单价*交易数量*单位换算率*汇率一
           #计算交易单价xcjf102
           IF g_xcjf.xcjf023 = g_xcjb007 THEN    #计价单位与内部定价单位的换算率
              LET l_rate = 1             #換算率
           ELSE
              CALL s_aooi250_convert_qty1(g_xcjf.xcjf016,g_xcjb007,g_xcjf.xcjf023,1)
                   RETURNING l_success,l_rate
              IF cl_null(l_rate) OR l_rate = 0 THEN
                 LET l_rate = 1          #換算率
              END IF
           END IF
           LET g_xcjf.xcjf102 = g_xcjb009 * l_rate       #交易單價=内部交易定价折换成实际交易单位的定价
           
           LET g_xcjf.xcjf101 = g_xcjb008        #交易幣別
           LET g_xcjf.xcjf110 = g_xcjf.xcjf102 * g_xcjf.xcjf022   #交易金額=单价*数量（交易单位的，非成本单位的）
              
           #汇率一
           CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_edate,g_xcjf.xcjf101,g_glaa.glaa001,0,g_glaa.glaa025)
                 RETURNING g_xcjf.xcjf200
           IF cl_null(g_xcjf.xcjf200) OR g_xcjf.xcjf200=0 THEN LET g_xcjf.xcjf200 = 1 END IF
           LET g_xcjf.xcjf201 = (g_xcjf.xcjf110*g_xcjf.xcjf024) * g_xcjf.xcjf200   #本位幣一金額=成本单位交易金额*汇率
           #汇率二
           IF g_glaa.glaa015 = 'Y' THEN
              CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_edate,g_xcjf.xcjf101,g_glaa.glaa016,0,g_glaa.glaa018)
                 RETURNING g_xcjf.xcjf210
           ELSE
              LET g_xcjf.xcjf210 = 0
           END IF
           LET g_xcjf.xcjf211 = (g_xcjf.xcjf110*g_xcjf.xcjf024) * g_xcjf.xcjf210   #本位幣二金額=成本单位交易金额*汇率二
           #汇率三
           IF g_glaa.glaa019 = 'Y' THEN
              CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_edate,g_xcjf.xcjf101,g_glaa.glaa020,0,g_glaa.glaa022)
                 RETURNING g_xcjf.xcjf220
           ELSE
              LET g_xcjf.xcjf220 = 0
           END IF
           LET g_xcjf.xcjf221 = (g_xcjf.xcjf110*g_xcjf.xcjf024) * g_xcjf.xcjf220   #本位幣三金額=成本单位交易金额*汇率三
           
      WHEN '2'  #对比法：取xccq的成本计算类型为xccq的成本
           #本位币金额 = 成本单位交易金额*汇率一 = 交易单位交易金额*单位换算率*汇率一 = 交易单位单价*交易数量*单位换算率*汇率一
           LET g_xcjf.xcjf101 = g_glaa.glaa001   #交易幣別
           LET g_xcjf.xcjf201 = g_xccq902        #本位幣一金額
           #汇率一
           CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_today,g_xcjf.xcjf101,g_glaa.glaa001,0,g_glaa.glaa025)
                 RETURNING g_xcjf.xcjf200
           IF cl_null(g_xcjf.xcjf200) OR g_xcjf.xcjf200=0 THEN LET g_xcjf.xcjf200 = 1 END IF
           
           LET g_xcjf.xcjf110 = g_xcjf.xcjf201 / g_xcjf.xcjf200/g_xcjf.xcjf024   #交易单位交易金額=本位币一金额/汇率一/成本单位换算率=成本单位交易金额/成本单位与交易单位的换算率
           LET g_xcjf.xcjf102 = g_xcjf.xcjf110 / g_xcjf.xcjf022   #交易單價=交易金额/数量/
           #汇率二
           IF g_glaa.glaa015 = 'Y' THEN
              CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_today,g_xcjf.xcjf101,g_glaa.glaa016,0,g_glaa.glaa018)
                 RETURNING g_xcjf.xcjf210
           ELSE
              LET g_xcjf.xcjf210 = 0
           END IF
           LET g_xcjf.xcjf211 = g_xcjf.xcjf110 * g_xcjf.xcjf210   #本位币二金额=交易金额*汇率二
           #汇率三
           IF g_glaa.glaa019 = 'Y' THEN
              CALL s_aooi160_get_exrate('2',g_xcje.xcjeld,g_today,g_xcjf.xcjf101,g_glaa.glaa020,0,g_glaa.glaa022)
                 RETURNING g_xcjf.xcjf220
           ELSE
              LET g_xcjf.xcjf220 = 0
           END IF
           LET g_xcjf.xcjf221 = g_xcjf.xcjf110 * g_xcjf.xcjf220   #本位币二金额=交易金额*汇率三
   END CASE
   LET g_xcjf.xcjfud021 = ''   #自定義欄位(日期時間)021
   LET g_xcjf.xcjfud022 = ''   #自定義欄位(日期時間)022
   LET g_xcjf.xcjfud023 = ''   #自定義欄位(日期時間)023
   LET g_xcjf.xcjfud024 = ''   #自定義欄位(日期時間)024
   LET g_xcjf.xcjfud025 = ''   #自定義欄位(日期時間)025
   LET g_xcjf.xcjfud026 = ''   #自定義欄位(日期時間)026
   LET g_xcjf.xcjfud027 = ''   #自定義欄位(日期時間)027
   LET g_xcjf.xcjfud028 = ''   #自定義欄位(日期時間)028
   LET g_xcjf.xcjfud029 = ''   #自定義欄位(日期時間)029
   LET g_xcjf.xcjfud030 = ''   #自定義欄位(日期時間)030
   
#   INSERT INTO xcjf_t VALUES g_xcjf.* #161124-00048#12 mark
   #161124-00048#12 add(s)
  INSERT INTO xcjf_t(xcjfent,xcjfsite,xcjfld,xcjfdocno,xcjfseq,xcjf001,xcjf002,xcjf003,xcjf010,xcjf011,
                      xcjf012,xcjf013,xcjf014,xcjf015,xcjf016,xcjf017,xcjf018,xcjf019,xcjf020,xcjf021,xcjf022,
                      xcjf023,xcjf024,xcjf028,xcjf029,xcjf030,xcjf031,xcjf032,xcjf033,xcjf034,xcjf035,xcjf036,
                      xcjf037,xcjf038,xcjf039,xcjf040,xcjf041,xcjf042,xcjf043,xcjf044,xcjf045,xcjf046,xcjf047,
                      xcjf048,xcjf049,xcjf050,xcjf051,xcjf052,xcjf053,xcjf101,xcjf102,xcjf110,xcjf200,xcjf201,
                      xcjf210,xcjf211,xcjf220,xcjf221,xcjfud001,xcjfud002,xcjfud003,xcjfud004,xcjfud005,xcjfud006,
                      xcjfud007,xcjfud008,xcjfud009,xcjfud010,xcjfud011,xcjfud012,xcjfud013,xcjfud014,xcjfud015,
                      xcjfud016,xcjfud017,xcjfud018,xcjfud019,xcjfud020,xcjfud021,xcjfud022,xcjfud023,xcjfud024,
                      xcjfud025,xcjfud026,xcjfud027,xcjfud028,xcjfud029,xcjfud030) 
               VALUES(g_xcjf.xcjfent,g_xcjf.xcjfsite,g_xcjf.xcjfld,g_xcjf.xcjfdocno,g_xcjf.xcjfseq,g_xcjf.xcjf001,g_xcjf.xcjf002,g_xcjf.xcjf003,g_xcjf.xcjf010,g_xcjf.xcjf011,
                      g_xcjf.xcjf012,g_xcjf.xcjf013,g_xcjf.xcjf014,g_xcjf.xcjf015,g_xcjf.xcjf016,g_xcjf.xcjf017,g_xcjf.xcjf018,g_xcjf.xcjf019,g_xcjf.xcjf020,g_xcjf.xcjf021,g_xcjf.xcjf022,
                      g_xcjf.xcjf023,g_xcjf.xcjf024,g_xcjf.xcjf028,g_xcjf.xcjf029,g_xcjf.xcjf030,g_xcjf.xcjf031,g_xcjf.xcjf032,g_xcjf.xcjf033,g_xcjf.xcjf034,g_xcjf.xcjf035,g_xcjf.xcjf036,
                      g_xcjf.xcjf037,g_xcjf.xcjf038,g_xcjf.xcjf039,g_xcjf.xcjf040,g_xcjf.xcjf041,g_xcjf.xcjf042,g_xcjf.xcjf043,g_xcjf.xcjf044,g_xcjf.xcjf045,g_xcjf.xcjf046,g_xcjf.xcjf047,
                      g_xcjf.xcjf048,g_xcjf.xcjf049,g_xcjf.xcjf050,g_xcjf.xcjf051,g_xcjf.xcjf052,g_xcjf.xcjf053,g_xcjf.xcjf101,g_xcjf.xcjf102,g_xcjf.xcjf110,g_xcjf.xcjf200,g_xcjf.xcjf201,
                      g_xcjf.xcjf210,g_xcjf.xcjf211,g_xcjf.xcjf220,g_xcjf.xcjf221,g_xcjf.xcjfud001,g_xcjf.xcjfud002,g_xcjf.xcjfud003,g_xcjf.xcjfud004,g_xcjf.xcjfud005,g_xcjf.xcjfud006,
                      g_xcjf.xcjfud007,g_xcjf.xcjfud008,g_xcjf.xcjfud009,g_xcjf.xcjfud010,g_xcjf.xcjfud011,g_xcjf.xcjfud012,g_xcjf.xcjfud013,g_xcjf.xcjfud014,g_xcjf.xcjfud015,
                      g_xcjf.xcjfud016,g_xcjf.xcjfud017,g_xcjf.xcjfud018,g_xcjf.xcjfud019,g_xcjf.xcjfud020,g_xcjf.xcjfud021,g_xcjf.xcjfud022,g_xcjf.xcjfud023,g_xcjf.xcjfud024,
                      g_xcjf.xcjfud025,g_xcjf.xcjfud026,g_xcjf.xcjfud027,g_xcjf.xcjfud028,g_xcjf.xcjfud029,g_xcjf.xcjfud030) 
   #161124-00048#12 add(e)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins xcjf'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
