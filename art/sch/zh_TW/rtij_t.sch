/* 
================================================================================
檔案代號:rtij_t
檔案名稱:返物贡献商品记录档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtij_t
(
rtijent       number(5)      ,/* 企业编号 */
rtijsite       varchar2(10)      ,/* 营运据点 */
rtijunit       varchar2(10)      ,/* 应用组织 */
rtijdocno       varchar2(20)      ,/* 单据编号 */
rtijseq1       number(10,0)      ,/* 项次 */
rtijseq2       number(10,0)      ,/* 序号 */
rtij001       varchar2(10)      ,/* 单据类型 */
rtij002       varchar2(10)      ,/* 促销类型 */
rtij003       varchar2(20)      ,/* 促销规则 */
rtij004       number(10,0)      ,/* 条件组别 */
rtij005       number(20,6)      ,/* 参与数量 */
rtij006       number(20,6)      ,/* 参与金额 */
rtijud001       varchar2(40)      ,/* 自定义字段(文本)001 */
rtijud002       varchar2(40)      ,/* 自定义字段(文本)002 */
rtijud003       varchar2(40)      ,/* 自定义字段(文本)003 */
rtijud004       varchar2(40)      ,/* 自定义字段(文本)004 */
rtijud005       varchar2(40)      ,/* 自定义字段(文本)005 */
rtijud006       varchar2(40)      ,/* 自定义字段(文本)006 */
rtijud007       varchar2(40)      ,/* 自定义字段(文本)007 */
rtijud008       varchar2(40)      ,/* 自定义字段(文本)008 */
rtijud009       varchar2(40)      ,/* 自定义字段(文本)009 */
rtijud010       varchar2(40)      ,/* 自定义字段(文本)010 */
rtijud011       number(20,6)      ,/* 自定义字段(数字)011 */
rtijud012       number(20,6)      ,/* 自定义字段(数字)012 */
rtijud013       number(20,6)      ,/* 自定义字段(数字)013 */
rtijud014       number(20,6)      ,/* 自定义字段(数字)014 */
rtijud015       number(20,6)      ,/* 自定义字段(数字)015 */
rtijud016       number(20,6)      ,/* 自定义字段(数字)016 */
rtijud017       number(20,6)      ,/* 自定义字段(数字)017 */
rtijud018       number(20,6)      ,/* 自定义字段(数字)018 */
rtijud019       number(20,6)      ,/* 自定义字段(数字)019 */
rtijud020       number(20,6)      ,/* 自定义字段(数字)020 */
rtijud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
rtijud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
rtijud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
rtijud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
rtijud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
rtijud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
rtijud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
rtijud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
rtijud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
rtijud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
rtij007       varchar2(20)      /* 来源单号 */
);
alter table rtij_t add constraint rtij_pk primary key (rtijent,rtijdocno,rtijseq1,rtijseq2) enable validate;

create unique index rtij_pk on rtij_t (rtijent,rtijdocno,rtijseq1,rtijseq2);

grant select on rtij_t to tiptop;
grant update on rtij_t to tiptop;
grant delete on rtij_t to tiptop;
grant insert on rtij_t to tiptop;

exit;
