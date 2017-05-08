/* 
================================================================================
檔案代號:xmdc_t
檔案名稱:订单单身明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmdc_t
(
xmdcent       number(5)      ,/* 企业编号 */
xmdcsite       varchar2(10)      ,/* 营运据点 */
xmdcdocno       varchar2(20)      ,/* 订单单号 */
xmdcseq       number(10,0)      ,/* 项次 */
xmdc001       varchar2(40)      ,/* 料件编号 */
xmdc002       varchar2(256)      ,/* 产品特征 */
xmdc003       varchar2(40)      ,/* 包装容器 */
xmdc004       varchar2(10)      ,/* 作业编号 */
xmdc005       varchar2(10)      ,/* 工艺序 */
xmdc006       varchar2(10)      ,/* 销售单位 */
xmdc007       number(20,6)      ,/* 销售数量 */
xmdc008       varchar2(10)      ,/* 参考单位 */
xmdc009       number(20,6)      ,/* 参考数量 */
xmdc010       varchar2(10)      ,/* 计价单位 */
xmdc011       number(20,6)      ,/* 计价数量 */
xmdc012       date      ,/* 约定交货日 */
xmdc013       date      ,/* 预定签收日 */
xmdc015       number(20,6)      ,/* 单价 */
xmdc016       varchar2(10)      ,/* 税种 */
xmdc017       number(5,2)      ,/* 税率 */
xmdc019       varchar2(10)      ,/* 子件特性 */
xmdc020       varchar2(10)      ,/* 急料 */
xmdc021       varchar2(1)      ,/* 保税 */
xmdc022       varchar2(1)      ,/* 部分交货 */
xmdcunit       varchar2(10)      ,/* 出货据点 */
xmdcorga       varchar2(10)      ,/* 收款据点 */
xmdc023       varchar2(10)      ,/* 收货客户 */
xmdc024       varchar2(1)      ,/* 多交期 */
xmdc025       varchar2(10)      ,/* 收货地址编号 */
xmdc026       varchar2(10)      ,/* 账款地址编号 */
xmdc027       varchar2(40)      ,/* 客户料号 */
xmdc028       varchar2(10)      ,/* 限定库位 */
xmdc029       varchar2(10)      ,/* 限定储位 */
xmdc030       varchar2(30)      ,/* 限定批号 */
xmdc031       varchar2(10)      ,/* 运输方式 */
xmdc032       varchar2(10)      ,/* 取货模式 */
xmdc033       number(20,6)      ,/* 备品率 */
xmdc034       number(20,6)      ,/* 可超交率 */
xmdc035       varchar2(10)      ,/* 价格核决 */
xmdc036       varchar2(20)      ,/* 项目编号 */
xmdc037       varchar2(30)      ,/* WBS编号 */
xmdc038       varchar2(30)      ,/* 活动编号 */
xmdc039       varchar2(10)      ,/* 费用原因 */
xmdc040       varchar2(10)      ,/* 取价来源 */
xmdc041       varchar2(20)      ,/* 价格参考单号 */
xmdc042       number(10,0)      ,/* 价格参考项次 */
xmdc043       number(20,6)      ,/* 取出价格 */
xmdc044       number(20,6)      ,/* 价差比 */
xmdc045       varchar2(10)      ,/* 状态码 */
xmdc046       number(20,6)      ,/* 税前金额 */
xmdc047       number(20,6)      ,/* 含税金额 */
xmdc048       number(20,6)      ,/* 税额 */
xmdc049       varchar2(10)      ,/* 理由码 */
xmdc050       varchar2(255)      ,/* 备注 */
xmdc051       number(10,0)      ,/* 客户订单项次 */
xmdc052       varchar2(1)      ,/* 检验否 */
xmdc053       varchar2(10)      ,/* 结案理由码 */
xmdc054       date      ,/* BOM有效日期 */
xmdc055       varchar2(20)      ,/* 来源单号 */
xmdc056       number(10,0)      ,/* 来源项次 */
xmdc057       varchar2(30)      ,/* 库存管理特征 */
xmdcud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xmdcud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xmdcud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xmdcud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xmdcud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xmdcud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xmdcud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xmdcud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xmdcud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xmdcud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xmdcud011       number(20,6)      ,/* 自定义字段(数字)011 */
xmdcud012       number(20,6)      ,/* 自定义字段(数字)012 */
xmdcud013       number(20,6)      ,/* 自定义字段(数字)013 */
xmdcud014       number(20,6)      ,/* 自定义字段(数字)014 */
xmdcud015       number(20,6)      ,/* 自定义字段(数字)015 */
xmdcud016       number(20,6)      ,/* 自定义字段(数字)016 */
xmdcud017       number(20,6)      ,/* 自定义字段(数字)017 */
xmdcud018       number(20,6)      ,/* 自定义字段(数字)018 */
xmdcud019       number(20,6)      ,/* 自定义字段(数字)019 */
xmdcud020       number(20,6)      ,/* 自定义字段(数字)020 */
xmdcud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xmdcud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xmdcud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xmdcud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xmdcud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xmdcud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xmdcud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xmdcud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xmdcud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xmdcud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
xmdc058       number(20,6)      ,/* 还量数量 */
xmdc059       number(20,6)      ,/* 还量参考数量 */
xmdc060       number(20,6)      ,/* 还价数量 */
xmdc061       number(20,6)      ,/* 还价参考数量 */
xmdc062       varchar2(30)      ,/* BOM特性 */
xmdc200       varchar2(20)      ,/* 现金折扣单号 */
xmdc201       number(10,0)      /* 现金折扣单项次 */
);
alter table xmdc_t add constraint xmdc_pk primary key (xmdcent,xmdcdocno,xmdcseq) enable validate;

create unique index xmdc_pk on xmdc_t (xmdcent,xmdcdocno,xmdcseq);

grant select on xmdc_t to tiptop;
grant update on xmdc_t to tiptop;
grant delete on xmdc_t to tiptop;
grant insert on xmdc_t to tiptop;

exit;
