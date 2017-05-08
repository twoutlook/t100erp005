/* 
================================================================================
檔案代號:xmda_t
檔案名稱:订单单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmda_t
(
xmdaent       number(5)      ,/* 企业编号 */
xmdasite       varchar2(10)      ,/* 营运据点 */
xmdadocno       varchar2(20)      ,/* 订单单号 */
xmdadocdt       date      ,/* 订单日期 */
xmda001       number(5,0)      ,/* 版次 */
xmda002       varchar2(20)      ,/* 业务人员 */
xmda003       varchar2(10)      ,/* 业务部门 */
xmda004       varchar2(10)      ,/* 客户编号 */
xmda005       varchar2(10)      ,/* 订单性质 */
xmda006       varchar2(10)      ,/* 多角性质 */
xmda007       varchar2(10)      ,/* 数据源 */
xmda008       varchar2(20)      ,/* 来源单号 */
xmda009       varchar2(10)      ,/* 收款条件 */
xmda010       varchar2(10)      ,/* 交易条件 */
xmda011       varchar2(10)      ,/* 税种 */
xmda012       number(5,2)      ,/* 税率 */
xmda013       varchar2(1)      ,/* 单价含税否 */
xmda015       varchar2(10)      ,/* 币种 */
xmda016       number(20,10)      ,/* 汇率 */
xmda017       varchar2(10)      ,/* 取价方式 */
xmda018       varchar2(10)      ,/* 收款优惠条件 */
xmda019       varchar2(1)      ,/* 纳入APS计算 */
xmda020       varchar2(10)      ,/* 运送方式 */
xmda021       varchar2(10)      ,/* 账款客户 */
xmda022       varchar2(10)      ,/* 收货客户 */
xmda023       varchar2(10)      ,/* 销售渠道 */
xmda024       varchar2(10)      ,/* 销售分类二 */
xmda025       varchar2(10)      ,/* 出货地址 */
xmda026       varchar2(10)      ,/* 账款地址 */
xmda027       varchar2(20)      ,/* 客户连络人 */
xmda028       varchar2(20)      ,/* 一次性交易对象识别码 */
xmda029       varchar2(10)      ,/* 出货部门 */
xmda030       varchar2(1)      ,/* 多角贸易已抛转 */
xmda031       varchar2(20)      ,/* 多角序号 */
xmda032       varchar2(10)      ,/* 留置原因 */
xmda033       varchar2(20)      ,/* 客户订购单号 */
xmda034       varchar2(10)      ,/* 最终客户 */
xmda035       varchar2(2)      ,/* 发票类型 */
xmda036       varchar2(10)      ,/* 送货供应商 */
xmda037       varchar2(10)      ,/* 起运点 */
xmda038       varchar2(10)      ,/* 目的地 */
xmda039       varchar2(10)      ,/* 预收款发票开立方式 */
xmda041       number(20,6)      ,/* 订单总税前金额 */
xmda042       number(20,6)      ,/* 订单总含税金额 */
xmda043       number(20,6)      ,/* 订单总税额 */
xmda044       varchar2(10)      ,/* 唛头编号 */
xmda045       varchar2(1)      ,/* 物流结案 */
xmda046       varchar2(1)      ,/* 账流结案 */
xmda047       varchar2(1)      ,/* 金流结案 */
xmda048       varchar2(10)      ,/* 内外销 */
xmda049       varchar2(10)      ,/* 汇率计算基准 */
xmda050       varchar2(10)      ,/* 多角流程编号 */
xmda051       varchar2(1)      ,/* 多角最终站 */
xmda071       varchar2(255)      ,/* 备注 */
xmdaownid       varchar2(20)      ,/* 资料所有者 */
xmdaowndp       varchar2(10)      ,/* 资料所有部门 */
xmdacrtid       varchar2(20)      ,/* 资料录入者 */
xmdacrtdp       varchar2(10)      ,/* 资料录入部门 */
xmdacrtdt       timestamp(0)      ,/* 资料创建日 */
xmdamodid       varchar2(20)      ,/* 资料更改者 */
xmdamoddt       timestamp(0)      ,/* 最近更改日 */
xmdacnfid       varchar2(20)      ,/* 资料审核者 */
xmdacnfdt       timestamp(0)      ,/* 数据审核日 */
xmdapstid       varchar2(20)      ,/* 资料过账者 */
xmdapstdt       timestamp(0)      ,/* 资料过账日 */
xmdastus       varchar2(10)      ,/* 状态码 */
xmda200       varchar2(10)      ,/* 调货经销商编号 */
xmda201       varchar2(10)      ,/* 代送商编号 */
xmda202       varchar2(10)      ,/* 销售办事处 */
xmda203       varchar2(10)      ,/* 发票客户 */
xmda204       varchar2(30)      ,/* 促销方案编号 */
xmda205       number(20,6)      ,/* 整单折扣 */
xmda206       varchar2(10)      ,/* 送货站点编号 */
xmda207       varchar2(10)      ,/* 运输路线编号 */
xmda208       varchar2(10)      ,/* 地区编号 */
xmda209       varchar2(10)      ,/* 县市编号 */
xmda210       varchar2(10)      ,/* 省区编号 */
xmda211       varchar2(10)      ,/* 区域编号 */
xmda212       number(20,6)      ,/* 本币含税总金额 */
xmda213       varchar2(1)      ,/* 收款完成否 */
xmdaunit       varchar2(10)      ,/* 发货组织 */
xmdaud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xmdaud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xmdaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xmdaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xmdaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xmdaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xmdaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xmdaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xmdaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xmdaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xmdaud011       number(20,6)      ,/* 自定义字段(数字)011 */
xmdaud012       number(20,6)      ,/* 自定义字段(数字)012 */
xmdaud013       number(20,6)      ,/* 自定义字段(数字)013 */
xmdaud014       number(20,6)      ,/* 自定义字段(数字)014 */
xmdaud015       number(20,6)      ,/* 自定义字段(数字)015 */
xmdaud016       number(20,6)      ,/* 自定义字段(数字)016 */
xmdaud017       number(20,6)      ,/* 自定义字段(数字)017 */
xmdaud018       number(20,6)      ,/* 自定义字段(数字)018 */
xmdaud019       number(20,6)      ,/* 自定义字段(数字)019 */
xmdaud020       number(20,6)      ,/* 自定义字段(数字)020 */
xmdaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xmdaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xmdaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xmdaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xmdaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xmdaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xmdaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xmdaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xmdaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xmdaud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
xmda052       varchar2(10)      /* 银行账户 */
);
alter table xmda_t add constraint xmda_pk primary key (xmdaent,xmdadocno) enable validate;

create unique index xmda_pk on xmda_t (xmdaent,xmdadocno);

grant select on xmda_t to tiptop;
grant update on xmda_t to tiptop;
grant delete on xmda_t to tiptop;
grant insert on xmda_t to tiptop;

exit;
