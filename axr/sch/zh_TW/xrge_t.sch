/* 
================================================================================
檔案代號:xrge_t
檔案名稱:销售信用状变更明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xrge_t
(
xrgeent       number(5)      ,/* 企业编号 */
xrgecomp       varchar2(10)      ,/* 法人 */
xrgedocno       varchar2(20)      ,/* 申请单号 */
xrgeseq       number(10,0)      ,/* 项次 */
xrgeorga       varchar2(10)      ,/* 来源组织 */
xrge001       varchar2(20)      ,/* 订单单号 */
xrge002       number(10,0)      ,/* 订单项次 */
xrge003       varchar2(40)      ,/* 产品编号 */
xrge004       varchar2(255)      ,/* 品名规格 */
xrge005       varchar2(10)      ,/* 单位 */
xrge006       varchar2(10)      ,/* 税种 */
xrge007       varchar2(1)      ,/* 含税否 */
xrge008       number(20,6)      ,/* 订单数量 */
xrge009       number(20,6)      ,/* 原币含税单价 */
xrge105       number(20,6)      ,/* 原币含税金额 */
xrge115       number(20,6)      ,/* 本币含税金额 */
xrge900       number(10,0)      ,/* 变更序 */
xrge901       varchar2(1)      ,/* 变更类型 */
xrge902       varchar2(10)      ,/* 变更理由 */
xrge903       varchar2(255)      ,/* 变更备注 */
xrgeud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xrgeud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xrgeud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xrgeud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xrgeud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xrgeud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xrgeud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xrgeud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xrgeud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xrgeud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xrgeud011       number(20,6)      ,/* 自定义字段(数字)011 */
xrgeud012       number(20,6)      ,/* 自定义字段(数字)012 */
xrgeud013       number(20,6)      ,/* 自定义字段(数字)013 */
xrgeud014       number(20,6)      ,/* 自定义字段(数字)014 */
xrgeud015       number(20,6)      ,/* 自定义字段(数字)015 */
xrgeud016       number(20,6)      ,/* 自定义字段(数字)016 */
xrgeud017       number(20,6)      ,/* 自定义字段(数字)017 */
xrgeud018       number(20,6)      ,/* 自定义字段(数字)018 */
xrgeud019       number(20,6)      ,/* 自定义字段(数字)019 */
xrgeud020       number(20,6)      ,/* 自定义字段(数字)020 */
xrgeud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xrgeud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xrgeud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xrgeud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xrgeud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xrgeud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xrgeud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xrgeud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xrgeud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xrgeud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
xrge100       varchar2(10)      ,/* 币种 */
xrge101       number(20,10)      /* 汇率 */
);
alter table xrge_t add constraint xrge_pk primary key (xrgeent,xrgecomp,xrgedocno,xrgeseq,xrge900) enable validate;

create unique index xrge_pk on xrge_t (xrgeent,xrgecomp,xrgedocno,xrgeseq,xrge900);

grant select on xrge_t to tiptop;
grant update on xrge_t to tiptop;
grant delete on xrge_t to tiptop;
grant insert on xrge_t to tiptop;

exit;
