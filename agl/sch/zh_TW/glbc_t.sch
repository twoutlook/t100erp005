/* 
================================================================================
檔案代號:glbc_t
檔案名稱:现金变动码明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table glbc_t
(
glbcent       number(5)      ,/* 企业编号 */
glbcld       varchar2(5)      ,/* 账套 */
glbccomp       varchar2(10)      ,/* 营运据点 */
glbcdocno       varchar2(20)      ,/* 凭证编号 */
glbcseq       number(10,0)      ,/* 项次 */
glbcseq1       number(10,0)      ,/* 序号 */
glbc001       number(5,0)      ,/* 年度 */
glbc002       number(5,0)      ,/* 期别 */
glbc003       varchar2(10)      ,/* 借贷别 */
glbc004       varchar2(10)      ,/* 现金变动码 */
glbc005       varchar2(10)      ,/* 交易客商 */
glbc006       varchar2(10)      ,/* 交易币种 */
glbc007       number(20,10)      ,/* 汇率 */
glbc008       number(20,6)      ,/* 原币金额 */
glbc009       number(20,6)      ,/* 本币金额 */
glbc010       varchar2(1)      ,/* 数据源 */
glbc011       number(20,10)      ,/* 汇率(本位币二) */
glbc012       number(20,6)      ,/* 金额(本位币二) */
glbc013       number(20,10)      ,/* 汇率(本位币三) */
glbc014       number(20,6)      ,/* 金额(本位币三) */
glbcud001       varchar2(40)      ,/* 自定义字段(文本)001 */
glbcud002       varchar2(40)      ,/* 自定义字段(文本)002 */
glbcud003       varchar2(40)      ,/* 自定义字段(文本)003 */
glbcud004       varchar2(40)      ,/* 自定义字段(文本)004 */
glbcud005       varchar2(40)      ,/* 自定义字段(文本)005 */
glbcud006       varchar2(40)      ,/* 自定义字段(文本)006 */
glbcud007       varchar2(40)      ,/* 自定义字段(文本)007 */
glbcud008       varchar2(40)      ,/* 自定义字段(文本)008 */
glbcud009       varchar2(40)      ,/* 自定义字段(文本)009 */
glbcud010       varchar2(40)      ,/* 自定义字段(文本)010 */
glbcud011       number(20,6)      ,/* 自定义字段(数字)011 */
glbcud012       number(20,6)      ,/* 自定义字段(数字)012 */
glbcud013       number(20,6)      ,/* 自定义字段(数字)013 */
glbcud014       number(20,6)      ,/* 自定义字段(数字)014 */
glbcud015       number(20,6)      ,/* 自定义字段(数字)015 */
glbcud016       number(20,6)      ,/* 自定义字段(数字)016 */
glbcud017       number(20,6)      ,/* 自定义字段(数字)017 */
glbcud018       number(20,6)      ,/* 自定义字段(数字)018 */
glbcud019       number(20,6)      ,/* 自定义字段(数字)019 */
glbcud020       number(20,6)      ,/* 自定义字段(数字)020 */
glbcud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
glbcud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
glbcud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
glbcud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
glbcud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
glbcud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
glbcud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
glbcud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
glbcud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
glbcud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
glbc015       varchar2(10)      /* 状态码 */
);
alter table glbc_t add constraint glbc_pk primary key (glbcent,glbcld,glbcdocno,glbcseq,glbcseq1,glbc001,glbc002,glbc010) enable validate;

create unique index glbc_pk on glbc_t (glbcent,glbcld,glbcdocno,glbcseq,glbcseq1,glbc001,glbc002,glbc010);

grant select on glbc_t to tiptop;
grant update on glbc_t to tiptop;
grant delete on glbc_t to tiptop;
grant insert on glbc_t to tiptop;

exit;
