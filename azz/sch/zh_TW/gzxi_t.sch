/* 
================================================================================
檔案代號:gzxi_t
檔案名稱:我的最爱纪录档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzxi_t
(
gzxiacti       varchar2(1)      ,/* 数据有效码 */
gzxi001       varchar2(20)      ,/* 员工编号 */
gzxi002       varchar2(20)      ,/* 作业编号 */
gzxi003       varchar2(20)      ,/* 分层目录 */
gzxi004       varchar2(1)      ,/* 是否为作业 */
gzxi005       varchar2(80)      ,/* 说明 */
gzxiud001       varchar2(40)      ,/* 自定义字段(文本)001 */
gzxiud002       varchar2(40)      ,/* 自定义字段(文本)002 */
gzxiud003       varchar2(40)      ,/* 自定义字段(文本)003 */
gzxiud004       varchar2(40)      ,/* 自定义字段(文本)004 */
gzxiud005       varchar2(40)      ,/* 自定义字段(文本)005 */
gzxiud006       varchar2(40)      ,/* 自定义字段(文本)006 */
gzxiud007       varchar2(40)      ,/* 自定义字段(文本)007 */
gzxiud008       varchar2(40)      ,/* 自定义字段(文本)008 */
gzxiud009       varchar2(40)      ,/* 自定义字段(文本)009 */
gzxiud010       varchar2(40)      ,/* 自定义字段(文本)010 */
gzxiud011       number(20,6)      ,/* 自定义字段(数字)011 */
gzxiud012       number(20,6)      ,/* 自定义字段(数字)012 */
gzxiud013       number(20,6)      ,/* 自定义字段(数字)013 */
gzxiud014       number(20,6)      ,/* 自定义字段(数字)014 */
gzxiud015       number(20,6)      ,/* 自定义字段(数字)015 */
gzxiud016       number(20,6)      ,/* 自定义字段(数字)016 */
gzxiud017       number(20,6)      ,/* 自定义字段(数字)017 */
gzxiud018       number(20,6)      ,/* 自定义字段(数字)018 */
gzxiud019       number(20,6)      ,/* 自定义字段(数字)019 */
gzxiud020       number(20,6)      ,/* 自定义字段(数字)020 */
gzxiud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
gzxiud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
gzxiud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
gzxiud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
gzxiud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
gzxiud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
gzxiud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
gzxiud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
gzxiud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
gzxiud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
gzxi006       timestamp(0)      ,/* 录入时间 */
gzxient       number(5)      /* 企业代码 */
);
alter table gzxi_t add constraint gzxi_pk primary key (gzxi001,gzxi002,gzxient) enable validate;

create unique index gzxi_pk on gzxi_t (gzxi001,gzxi002,gzxient);

grant select on gzxi_t to tiptop;
grant update on gzxi_t to tiptop;
grant delete on gzxi_t to tiptop;
grant insert on gzxi_t to tiptop;

exit;
