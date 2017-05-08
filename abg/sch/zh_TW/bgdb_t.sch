/* 
================================================================================
檔案代號:bgdb_t
檔案名稱:预算产品结构明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bgdb_t
(
bgdbent       number(5)      ,/* 企业编号 */
bgdb001       varchar2(10)      ,/* 预算组织 */
bgdb002       varchar2(40)      ,/* 预算主件料号 */
bgdb003       date      ,/* 生效日期 */
bgdbseq       number(10,0)      ,/* 项次 */
bgdb004       varchar2(40)      ,/* 元件料号 */
bgdb005       number(20,6)      ,/* 组成用量 */
bgdb006       number(20,6)      ,/* 主件底数 */
bgdb007       varchar2(10)      ,/* 发料单位 */
bgdb008       number(20,6)      ,/* 损耗率 */
bgdb009       date      ,/* 失效日期 */
bgdbud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgdbud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgdbud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgdbud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgdbud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgdbud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgdbud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgdbud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgdbud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgdbud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgdbud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgdbud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgdbud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgdbud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgdbud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgdbud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgdbud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgdbud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgdbud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgdbud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgdbud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgdbud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgdbud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgdbud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgdbud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgdbud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgdbud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgdbud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgdbud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgdbud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgdb_t add constraint bgdb_pk primary key (bgdbent,bgdb001,bgdb002,bgdb003,bgdbseq) enable validate;

create unique index bgdb_pk on bgdb_t (bgdbent,bgdb001,bgdb002,bgdb003,bgdbseq);

grant select on bgdb_t to tiptop;
grant update on bgdb_t to tiptop;
grant delete on bgdb_t to tiptop;
grant insert on bgdb_t to tiptop;

exit;
