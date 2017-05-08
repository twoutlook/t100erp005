/* 
================================================================================
檔案代號:rtia_t
檔案名稱:销售交易单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtia_t
(
rtiaent       number(5)      ,/* 企业编号 */
rtiasite       varchar2(10)      ,/* 营运据点 */
rtiaunit       varchar2(10)      ,/* 应用组织 */
rtiadocno       varchar2(20)      ,/* 单据编号 */
rtiadocdt       date      ,/* 单据日期 */
rtiastus       varchar2(10)      ,/* 状态 */
rtia000       varchar2(20)      ,/* 程序作业编号 */
rtia001       varchar2(30)      ,/* 会员卡号 */
rtia002       varchar2(10)      ,/* 客户编号 */
rtia003       varchar2(20)      ,/* 一次性交易对象识别码 */
rtia004       varchar2(20)      ,/* 业务人员 */
rtia005       varchar2(10)      ,/* 业务部门 */
rtia006       timestamp(0)      ,/* 过账日期 */
rtia007       varchar2(20)      ,/* 来源单号 */
rtia008       varchar2(10)      ,/* 来源版本 */
rtia009       varchar2(10)      ,/* 销售分类 */
rtia010       varchar2(10)      ,/* 送货客户编号 */
rtia011       varchar2(10)      ,/* 账款客户编号 */
rtia012       varchar2(10)      ,/* 发票客户编号 */
rtia013       number(5,0)      ,/* 整单折扣 */
rtia014       varchar2(20)      ,/* 起始发票\折让号码 */
rtia015       varchar2(20)      ,/* 截止发票\折让号码 */
rtia016       number(15,3)      ,/* 交易积分 */
rtia017       varchar2(10)      ,/* 送货类型 */
rtia018       varchar2(10)      ,/* 送货营运组织 */
rtia019       varchar2(12)      ,/* 收货邮政编号 */
rtia020       varchar2(4000)      ,/* 收货地址 */
rtia021       varchar2(80)      ,/* 收货人 */
rtia022       varchar2(20)      ,/* 收货联络电话 */
rtia023       varchar2(10)      ,/* 提货类别 */
rtia024       varchar2(10)      ,/* 取货营运组织 */
rtia025       varchar2(10)      ,/* 收款条件 */
rtia026       varchar2(10)      ,/* 交易币种 */
rtia027       number(20,10)      ,/* 交易汇率 */
rtia028       varchar2(10)      ,/* 税种 */
rtia029       number(5,2)      ,/* 税率 */
rtia030       varchar2(1)      ,/* 含税 */
rtia031       number(20,6)      ,/* 含税应收金额 */
rtia032       varchar2(10)      ,/* 数据源 */
rtia033       varchar2(20)      ,/* 数据源单号 */
rtia034       date      ,/* 来源交易日期 */
rtia035       varchar2(8)      ,/* 来源交易时间 */
rtia036       varchar2(10)      ,/* 收银机号 */
rtia037       varchar2(20)      ,/* 收银人员 */
rtia038       varchar2(10)      ,/* 班别 */
rtia039       varchar2(10)      ,/* 收银方式 */
rtia040       varchar2(10)      ,/* 抛转 */
rtia041       varchar2(255)      ,/* 备注 */
rtia042       varchar2(10)      ,/* 卡种编号 */
rtia043       number(15,3)      ,/* 卡积分余额 */
rtia044       varchar2(30)      ,/* 赠品兑换规则编号 */
rtia045       varchar2(10)      ,/* 赠品兑换规则版本 */
rtia046       number(15,3)      ,/* 赠品兑换该规则计算总积分 */
rtia047       number(15,3)      ,/* 赠品兑换此次积分 */
rtia048       varchar2(1)      ,/* 结账否 */
rtia049       number(20,6)      ,/* 本币含税应收金额 */
rtiaownid       varchar2(20)      ,/* 资料所有者 */
rtiaowndp       varchar2(10)      ,/* 资料所有部门 */
rtiacrtid       varchar2(20)      ,/* 资料录入者 */
rtiacrtdp       varchar2(10)      ,/* 资料录入部门 */
rtiacrtdt       timestamp(0)      ,/* 资料创建日 */
rtiamodid       varchar2(20)      ,/* 资料更改者 */
rtiamoddt       timestamp(0)      ,/* 最近更改日 */
rtiacnfid       varchar2(20)      ,/* 资料审核者 */
rtiacnfdt       timestamp(0)      ,/* 数据审核日 */
rtiapstid       varchar2(20)      ,/* 资料过账者 */
rtiapstdt       timestamp(0)      ,/* 资料过账日 */
rtiaud001       varchar2(40)      ,/* 自定义字段(文本)001 */
rtiaud002       varchar2(40)      ,/* 自定义字段(文本)002 */
rtiaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
rtiaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
rtiaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
rtiaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
rtiaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
rtiaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
rtiaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
rtiaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
rtiaud011       number(20,6)      ,/* 自定义字段(数字)011 */
rtiaud012       number(20,6)      ,/* 自定义字段(数字)012 */
rtiaud013       number(20,6)      ,/* 自定义字段(数字)013 */
rtiaud014       number(20,6)      ,/* 自定义字段(数字)014 */
rtiaud015       number(20,6)      ,/* 自定义字段(数字)015 */
rtiaud016       number(20,6)      ,/* 自定义字段(数字)016 */
rtiaud017       number(20,6)      ,/* 自定义字段(数字)017 */
rtiaud018       number(20,6)      ,/* 自定义字段(数字)018 */
rtiaud019       number(20,6)      ,/* 自定义字段(数字)019 */
rtiaud020       number(20,6)      ,/* 自定义字段(数字)020 */
rtiaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
rtiaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
rtiaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
rtiaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
rtiaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
rtiaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
rtiaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
rtiaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
rtiaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
rtiaud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
rtia050       varchar2(1)      ,/* 组织赠送 */
rtia051       number(20,6)      ,/* 应收尾款金额 */
rtia052       varchar2(20)      ,/* 立账单号 */
rtia053       varchar2(1)      ,/* 出纳收款 */
rtia054       varchar2(1)      ,/* 处理积分否 */
rtia055       varchar2(1)      ,/* 找零转储否 */
rtia056       varchar2(1)      ,/* 会员编号批量生成否 */
rtia057       date      ,/* 退货原销售单日期 */
rtia058       varchar2(1)      ,/* 会员消费回写否 */
rtia059       varchar2(255)      ,/* 顾客姓名 */
rtia060       varchar2(20)      ,/* 顾客电话 */
rtia101       varchar2(20)      ,/* 铺位编号(租赁) */
rtia102       varchar2(10)      ,/* 商户编号(租赁) */
rtia103       date      ,/* no use */
rtia104       varchar2(10)      ,/* no use */
rtia105       varchar2(20)      ,/* 合同编号(租赁) */
rtia106       number(20,6)      ,/* 销售合同金额(租赁) */
rtia107       varchar2(1)      ,/* 是否订单代采购 */
rtia061       varchar2(10)      ,/* 国家 */
rtia062       varchar2(10)      ,/* 省 */
rtia063       varchar2(10)      ,/* 市 */
rtia064       varchar2(10)      ,/* 区 */
rtia065       varchar2(10)      ,/* 街道 */
rtia108       varchar2(20)      ,/* 促销规则编号 */
rtia066       varchar2(10)      ,/* 兑换业态 */
rtia067       varchar2(20)      /* 实际扣账单号 */
);
alter table rtia_t add constraint rtia_pk primary key (rtiaent,rtiadocno) enable validate;

create unique index rtia_pk on rtia_t (rtiaent,rtiadocno);

grant select on rtia_t to tiptop;
grant update on rtia_t to tiptop;
grant delete on rtia_t to tiptop;
grant insert on rtia_t to tiptop;

exit;
