/* 
================================================================================
檔案代號:xmdl_t
檔案名稱:出货/签收/销退单单身明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmdl_t
(
xmdlent       number(5)      ,/* 企业编号 */
xmdlsite       varchar2(10)      ,/* 营运据点 */
xmdldocno       varchar2(20)      ,/* 单据编号 */
xmdlseq       number(10,0)      ,/* 项次 */
xmdl001       varchar2(20)      ,/* 出通单号 */
xmdl002       number(10,0)      ,/* 出通项次 */
xmdl003       varchar2(20)      ,/* 订单单号 */
xmdl004       number(10,0)      ,/* 订单项次 */
xmdl005       number(10,0)      ,/* 订单项序 */
xmdl006       number(10,0)      ,/* 订单分批序 */
xmdl007       varchar2(10)      ,/* 子件特性 */
xmdl008       varchar2(40)      ,/* 料件编号 */
xmdl009       varchar2(256)      ,/* 产品特征 */
xmdl010       varchar2(40)      ,/* 包装容器 */
xmdl011       varchar2(10)      ,/* 作业编号 */
xmdl012       varchar2(10)      ,/* 作业序 */
xmdl013       varchar2(1)      ,/* 多库储批出货 */
xmdl014       varchar2(10)      ,/* 库位 */
xmdl015       varchar2(10)      ,/* 储位 */
xmdl016       varchar2(30)      ,/* 批号 */
xmdl017       varchar2(10)      ,/* 出货单位 */
xmdl018       number(20,6)      ,/* 数量 */
xmdl019       varchar2(10)      ,/* 参考单位 */
xmdl020       number(20,6)      ,/* 参考数量 */
xmdl021       varchar2(10)      ,/* 计价单位 */
xmdl022       number(20,6)      ,/* 计价数量 */
xmdl023       varchar2(1)      ,/* 检验否 */
xmdl024       number(20,6)      ,/* 单价 */
xmdl025       varchar2(10)      ,/* 税种 */
xmdl026       number(5,2)      ,/* 税率 */
xmdl027       number(20,6)      ,/* 税前金额 */
xmdl028       number(20,6)      ,/* 含税金额 */
xmdl029       number(20,6)      ,/* 税额 */
xmdl030       varchar2(20)      ,/* 项目编号 */
xmdl031       varchar2(30)      ,/* WBS编号 */
xmdl032       varchar2(30)      ,/* 活动编号 */
xmdl033       varchar2(40)      ,/* 客户料号 */
xmdl034       number(20,6)      ,/* QPA */
xmdl035       number(20,6)      ,/* 已签收量 */
xmdl036       number(20,6)      ,/* 已签退量 */
xmdl037       number(20,6)      ,/* 已销退量 */
xmdl038       number(20,6)      ,/* 主账套已立账数量 */
xmdl039       number(20,6)      ,/* 账套二已立账数量 */
xmdl040       number(20,6)      ,/* 账套三已立账数量 */
xmdl041       varchar2(1)      ,/* 保税否 */
xmdl042       varchar2(10)      ,/* 取价来源 */
xmdl043       varchar2(20)      ,/* 价格来源参考单号 */
xmdl044       number(10,0)      ,/* 价格来源参考项次 */
xmdl045       number(20,6)      ,/* 取出价格 */
xmdl046       number(20,6)      ,/* 价差比 */
xmdl047       number(20,6)      ,/* 已开发票数量 */
xmdl048       varchar2(20)      ,/* 发票编号 */
xmdl049       varchar2(20)      ,/* 发票号码 */
xmdl050       varchar2(10)      ,/* 理由码 */
xmdl051       varchar2(255)      ,/* 备注 */
xmdl052       varchar2(30)      ,/* 库存管理特征 */
xmdl053       number(20,6)      ,/* 主账套暂估数量 */
xmdl054       number(20,6)      ,/* 账套二暂估数量 */
xmdl055       number(20,6)      ,/* 账套三暂估数量 */
xmdl081       number(20,6)      ,/* 签退数量(签收、签退单使用) */
xmdl082       number(20,6)      ,/* 签退参考数量(签收、签退单使用) */
xmdl083       number(20,6)      ,/* 签退计价数量(签收、签退单使用) */
xmdl084       varchar2(10)      ,/* 签退理由码(签收、签退单使用) */
xmdl085       varchar2(10)      ,/* 订单开立据点 */
xmdl086       varchar2(10)      ,/* 订单多角性质 */
xmdl087       varchar2(1)      ,/* 需自立应收否 */
xmdl088       varchar2(10)      ,/* 多角流程编号 */
xmdl089       varchar2(20)      ,/* QC单号 */
xmdl090       number(10,0)      ,/* 判定项次 */
xmdl091       varchar2(10)      ,/* 判定结果 */
xmdl092       number(20,6)      ,/* 借货还量数量 */
xmdl093       number(20,6)      ,/* 借货还量参考数量 */
xmdl200       varchar2(10)      ,/* 销售渠道 */
xmdl201       varchar2(10)      ,/* 产品组编码 */
xmdl202       varchar2(10)      ,/* 销售范围编码 */
xmdl203       varchar2(10)      ,/* 销售办公室 */
xmdl204       varchar2(10)      ,/* 出货包装单位 */
xmdl205       number(20,6)      ,/* 出货包装数量 */
xmdl206       number(20,6)      ,/* 签退包装数量 */
xmdl207       varchar2(10)      ,/* 库存锁定等级 */
xmdl208       number(20,6)      ,/* 标准价 */
xmdl209       number(20,6)      ,/* 促销价 */
xmdl210       number(20,6)      ,/* 交易价 */
xmdl211       number(20,6)      ,/* 折价金额 */
xmdl212       varchar2(10)      ,/* 销售组织 */
xmdl213       varchar2(20)      ,/* 销售人员 */
xmdl214       varchar2(10)      ,/* 销售部门 */
xmdl215       varchar2(20)      ,/* 合同编号 */
xmdl216       varchar2(10)      ,/* 经营方式 */
xmdl217       varchar2(10)      ,/* 结算类型 */
xmdl218       varchar2(10)      ,/* 结算方式 */
xmdl219       varchar2(10)      ,/* 交易类型 */
xmdl220       number(20,6)      ,/* 寄销已核销数量 */
xmdl222       varchar2(10)      ,/* 地区编号 */
xmdl223       varchar2(10)      ,/* 县市编号 */
xmdl224       varchar2(10)      ,/* 省区编号 */
xmdl225       varchar2(10)      ,/* 区域编号 */
xmdl226       varchar2(40)      ,/* 商品条码 */
xmdlunit       varchar2(10)      ,/* 应用组织 */
xmdlorga       varchar2(10)      ,/* 账务组织 */
xmdlud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xmdlud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xmdlud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xmdlud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xmdlud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xmdlud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xmdlud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xmdlud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xmdlud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xmdlud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xmdlud011       number(20,6)      ,/* 自定义字段(数字)011 */
xmdlud012       number(20,6)      ,/* 自定义字段(数字)012 */
xmdlud013       number(20,6)      ,/* 自定义字段(数字)013 */
xmdlud014       number(20,6)      ,/* 自定义字段(数字)014 */
xmdlud015       number(20,6)      ,/* 自定义字段(数字)015 */
xmdlud016       number(20,6)      ,/* 自定义字段(数字)016 */
xmdlud017       number(20,6)      ,/* 自定义字段(数字)017 */
xmdlud018       number(20,6)      ,/* 自定义字段(数字)018 */
xmdlud019       number(20,6)      ,/* 自定义字段(数字)019 */
xmdlud020       number(20,6)      ,/* 自定义字段(数字)020 */
xmdlud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xmdlud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xmdlud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xmdlud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xmdlud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xmdlud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xmdlud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xmdlud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xmdlud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xmdlud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
xmdl056       number(20,6)      ,/* 检验合格量 */
xmdl094       varchar2(20)      ,/* 来源单号(销退) */
xmdl095       number(10,0)      ,/* 项次(销退) */
xmdl227       varchar2(20)      ,/* 现金折扣单号 */
xmdl228       number(10,0)      ,/* 现金折扣单项次 */
xmdl057       date      ,/* 有效日期 */
xmdl058       date      ,/* 制造日期 */
xmdl096       number(10,0)      ,/* 来源项次 */
xmdl059       number(20,6)      ,/* 客户退货量 */
xmdl060       varchar2(10)      ,/* 放行状态 */
xmdl097       varchar2(20)      ,/* 装箱单号 */
xmdl098       number(10,0)      /* 装箱项次 */
);
alter table xmdl_t add constraint xmdl_pk primary key (xmdlent,xmdldocno,xmdlseq) enable validate;

create unique index xmdl_pk on xmdl_t (xmdlent,xmdldocno,xmdlseq);

grant select on xmdl_t to tiptop;
grant update on xmdl_t to tiptop;
grant delete on xmdl_t to tiptop;
grant insert on xmdl_t to tiptop;

exit;
