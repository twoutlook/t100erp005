/* 
================================================================================
檔案代號:apgc_t
檔案名稱:信用状相关费用明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apgc_t
(
apgcent       number(5)      ,/* 企业编号 */
apgccomp       varchar2(10)      ,/* 法人 */
apgcdocno       varchar2(20)      ,/* 申请单号 */
apgcseq       number(10,0)      ,/* 项次 */
apgc900       number(10,0)      ,/* 变更序 */
apgcorga       varchar2(10)      ,/* 来源组织 */
apgc001       varchar2(10)      ,/* 费用编号 */
apgc002       varchar2(10)      ,/* 付款对象 */
apgc003       varchar2(10)      ,/* 付款条件 */
apgc004       varchar2(24)      ,/* 费用科目 */
apgc005       varchar2(10)      ,/* 账款类别 */
apgc006       varchar2(10)      ,/* 税种 */
apgc007       varchar2(2)      ,/* 发票类型 */
apgc008       varchar2(20)      ,/* 发票编号 */
apgc009       varchar2(20)      ,/* 发票号码 */
apgc010       date      ,/* 发票日期 */
apgc011       varchar2(1)      ,/* 可扣抵编号 */
apgc012       varchar2(20)      ,/* 应付单号 */
apgc013       varchar2(10)      ,/* 费用来源 */
apgc014       varchar2(10)      ,/* 付款账户 */
apgc015       varchar2(10)      ,/* 存提码 */
apgc016       varchar2(10)      ,/* 现金变动码 */
apgc100       varchar2(10)      ,/* 币种 */
apgc101       number(20,10)      ,/* 汇率 */
apgc103       number(20,6)      ,/* 原币税前金额 */
apgc104       number(20,6)      ,/* 税额 */
apgc105       number(20,6)      ,/* 原币含税金额 */
apgc113       number(20,6)      ,/* 本币税前金额 */
apgc114       number(20,6)      ,/* 本币税额 */
apgc115       number(20,6)      ,/* 本币含税金额 */
apgcud001       varchar2(40)      ,/* 自定义字段(文本)001 */
apgcud002       varchar2(40)      ,/* 自定义字段(文本)002 */
apgcud003       varchar2(40)      ,/* 自定义字段(文本)003 */
apgcud004       varchar2(40)      ,/* 自定义字段(文本)004 */
apgcud005       varchar2(40)      ,/* 自定义字段(文本)005 */
apgcud006       varchar2(40)      ,/* 自定义字段(文本)006 */
apgcud007       varchar2(40)      ,/* 自定义字段(文本)007 */
apgcud008       varchar2(40)      ,/* 自定义字段(文本)008 */
apgcud009       varchar2(40)      ,/* 自定义字段(文本)009 */
apgcud010       varchar2(40)      ,/* 自定义字段(文本)010 */
apgcud011       number(20,6)      ,/* 自定义字段(数字)011 */
apgcud012       number(20,6)      ,/* 自定义字段(数字)012 */
apgcud013       number(20,6)      ,/* 自定义字段(数字)013 */
apgcud014       number(20,6)      ,/* 自定义字段(数字)014 */
apgcud015       number(20,6)      ,/* 自定义字段(数字)015 */
apgcud016       number(20,6)      ,/* 自定义字段(数字)016 */
apgcud017       number(20,6)      ,/* 自定义字段(数字)017 */
apgcud018       number(20,6)      ,/* 自定义字段(数字)018 */
apgcud019       number(20,6)      ,/* 自定义字段(数字)019 */
apgcud020       number(20,6)      ,/* 自定义字段(数字)020 */
apgcud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
apgcud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
apgcud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
apgcud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
apgcud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
apgcud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
apgcud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
apgcud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
apgcud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
apgcud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table apgc_t add constraint apgc_pk primary key (apgcent,apgccomp,apgcdocno,apgcseq,apgc900) enable validate;

create unique index apgc_pk on apgc_t (apgcent,apgccomp,apgcdocno,apgcseq,apgc900);

grant select on apgc_t to tiptop;
grant update on apgc_t to tiptop;
grant delete on apgc_t to tiptop;
grant insert on apgc_t to tiptop;

exit;
