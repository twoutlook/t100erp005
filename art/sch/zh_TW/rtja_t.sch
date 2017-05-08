/* 
================================================================================
檔案代號:rtja_t
檔案名稱:销售集成单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table rtja_t
(
rtjaent       number(5)      ,/* 企业编号 */
rtjasite       varchar2(10)      ,/* 营运据点 */
rtjaunit       varchar2(10)      ,/* 应用组织 */
rtjadocno       varchar2(20)      ,/* 单据编号 */
rtjadocdt       date      ,/* 单据日期 */
rtjastus       varchar2(10)      ,/* 状态 */
rtja000       varchar2(10)      ,/* 程序作业编号 */
rtja001       varchar2(30)      ,/* 会员卡号 */
rtja002       varchar2(10)      ,/* 客户编号 */
rtja003       varchar2(20)      ,/* 一次性交易对象识别码 */
rtja004       varchar2(20)      ,/* 业务人员 */
rtja005       varchar2(10)      ,/* 业务部门 */
rtja006       timestamp(0)      ,/* 过账日期 */
rtja007       varchar2(20)      ,/* 来源单号 */
rtja008       varchar2(10)      ,/* 来源版本 */
rtja009       varchar2(10)      ,/* 销售分类 */
rtja010       varchar2(10)      ,/* 送货客户编号 */
rtja011       varchar2(10)      ,/* 账款客户编号 */
rtja012       varchar2(10)      ,/* 发票客户编号 */
rtja013       number(5,0)      ,/* 整单折扣 */
rtja014       varchar2(20)      ,/* 起始发票\折让号码 */
rtja015       varchar2(20)      ,/* 截止发票\折让号码 */
rtja016       number(15,3)      ,/* 交易积分 */
rtja017       varchar2(10)      ,/* 送货类型 */
rtja018       varchar2(10)      ,/* 送货营运组织 */
rtja019       varchar2(12)      ,/* 收货邮政编号 */
rtja020       varchar2(4000)      ,/* 收货地址 */
rtja021       varchar2(80)      ,/* 收货人 */
rtja022       varchar2(20)      ,/* 收货联络电话 */
rtja023       varchar2(10)      ,/* 提货类别 */
rtja024       varchar2(10)      ,/* 取货营运组织 */
rtja025       varchar2(10)      ,/* 收款条件 */
rtja026       varchar2(10)      ,/* 交易币种 */
rtja027       number(20,10)      ,/* 交易汇率 */
rtja028       varchar2(10)      ,/* 税种 */
rtja029       number(5,2)      ,/* 税率 */
rtja030       varchar2(1)      ,/* 含税 */
rtja031       number(20,6)      ,/* 含税应收金额 */
rtja032       varchar2(10)      ,/* 数据源 */
rtja033       varchar2(20)      ,/* 数据源单号 */
rtja034       date      ,/* 来源交易日期 */
rtja035       varchar2(8)      ,/* 来源交易时间 */
rtja036       varchar2(10)      ,/* 收银机号 */
rtja037       varchar2(20)      ,/* 收银人员 */
rtja038       varchar2(10)      ,/* 班别 */
rtja039       varchar2(10)      ,/* 收银方式 */
rtja040       varchar2(10)      ,/* 抛转 */
rtja041       varchar2(255)      ,/* 备注 */
rtja042       varchar2(10)      ,/* 卡种编号 */
rtja043       number(15,3)      ,/* 卡积分余额 */
rtja044       varchar2(30)      ,/* 赠品兑换规则编号 */
rtja045       varchar2(10)      ,/* 赠品兑换规则版本 */
rtja046       number(15,3)      ,/* 赠品兑换该规则计算总积分 */
rtja047       number(15,3)      ,/* 赠品兑换此次积分 */
rtja048       varchar2(1)      ,/* 结账否 */
rtja049       number(20,6)      ,/* 本币含税应收金额 */
rtjaownid       varchar2(20)      ,/* 资料所有者 */
rtjaowndp       varchar2(10)      ,/* 资料所有部门 */
rtjacrtid       varchar2(20)      ,/* 资料录入者 */
rtjacrtdp       varchar2(10)      ,/* 资料录入部门 */
rtjacrtdt       timestamp(0)      ,/* 资料创建日 */
rtjamodid       varchar2(20)      ,/* 资料更改者 */
rtjamoddt       timestamp(0)      ,/* 最近更改日 */
rtjacnfid       varchar2(20)      ,/* 资料审核者 */
rtjacnfdt       timestamp(0)      ,/* 数据审核日 */
rtjapstid       varchar2(20)      ,/* 资料过账者 */
rtjapstdt       timestamp(0)      ,/* 资料过账日 */
rtjaud001       varchar2(40)      ,/* 自定义字段(文本)001 */
rtjaud002       varchar2(40)      ,/* 自定义字段(文本)002 */
rtjaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
rtjaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
rtjaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
rtjaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
rtjaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
rtjaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
rtjaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
rtjaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
rtjaud011       number(20,6)      ,/* 自定义字段(数字)011 */
rtjaud012       number(20,6)      ,/* 自定义字段(数字)012 */
rtjaud013       number(20,6)      ,/* 自定义字段(数字)013 */
rtjaud014       number(20,6)      ,/* 自定义字段(数字)014 */
rtjaud015       number(20,6)      ,/* 自定义字段(数字)015 */
rtjaud016       number(20,6)      ,/* 自定义字段(数字)016 */
rtjaud017       number(20,6)      ,/* 自定义字段(数字)017 */
rtjaud018       number(20,6)      ,/* 自定义字段(数字)018 */
rtjaud019       number(20,6)      ,/* 自定义字段(数字)019 */
rtjaud020       number(20,6)      ,/* 自定义字段(数字)020 */
rtjaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
rtjaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
rtjaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
rtjaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
rtjaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
rtjaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
rtjaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
rtjaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
rtjaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
rtjaud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
rtja050       varchar2(1)      ,/* 组织赠送 */
rtja051       number(20,6)      ,/* 应收回款金额 */
rtja052       varchar2(20)      ,/* 立账单号 */
rtja053       varchar2(1)      ,/* 出纳收款 */
rtja054       varchar2(1)      ,/* 积分处理否 */
rtja055       varchar2(1)      ,/* 找零转储否 */
rtja056       varchar2(1)      ,/* 会员编号批量生成否 */
rtja057       date      ,/* 退货原销售单日期 */
rtja058       varchar2(1)      ,/* 会员消费回写否 */
rtja059       varchar2(255)      ,/* 顾客姓名 */
rtja060       varchar2(20)      ,/* 顾客电话 */
rtja101       varchar2(20)      ,/* 铺位编号(租赁) */
rtja102       varchar2(10)      ,/* 商户编号(租赁) */
rtja103       date      ,/* no use */
rtja104       varchar2(10)      ,/* no use */
rtja105       varchar2(20)      ,/* 合同编号(租赁) */
rtja106       number(20,6)      ,/* 销售合同金额(租赁) */
rtja061       varchar2(10)      ,/* 国家 */
rtja062       varchar2(10)      ,/* 省 */
rtja063       varchar2(10)      ,/* 市 */
rtja064       varchar2(10)      ,/* 区 */
rtja065       varchar2(10)      ,/* 街道 */
rtja108       varchar2(20)      ,/* 促销规则编号 */
rtja066       varchar2(10)      ,/* 兑换业态 */
rtja067       varchar2(20)      /* 实际扣账单号 */
);
alter table rtja_t add constraint rtja_pk primary key (rtjaent,rtjadocno) enable validate;

create  index rtja_n01 on rtja_t (rtjaent,rtjasite,rtjadocno,rtjadocdt);
create  index rtja_n02 on rtja_t (rtjaent,rtja001);
create unique index rtja_pk on rtja_t (rtjaent,rtjadocno);

grant select on rtja_t to tiptop;
grant update on rtja_t to tiptop;
grant delete on rtja_t to tiptop;
grant insert on rtja_t to tiptop;

exit;
