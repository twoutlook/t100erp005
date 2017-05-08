/* 
================================================================================
檔案代號:gzau_t
檔案名稱:异常管理人员权限档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzau_t
(
gzauent       number(5)      ,/* 企业代码 */
gzau001       varchar2(10)      ,/* 人员编号 */
gzau002       varchar2(10)      ,/* 检核编号 */
gzauud001       varchar2(40)      ,/* 自定义字段(文字)001 */
gzauud002       varchar2(40)      ,/* 自定义字段(文字)002 */
gzauud003       varchar2(40)      ,/* 自定义字段(文字)003 */
gzauud004       varchar2(40)      ,/* 自定义字段(文字)004 */
gzauud005       varchar2(40)      ,/* 自定义字段(文字)005 */
gzauud006       varchar2(40)      ,/* 自定义字段(文字)006 */
gzauud007       varchar2(40)      ,/* 自定义字段(文字)007 */
gzauud008       varchar2(40)      ,/* 自定义字段(文字)008 */
gzauud009       varchar2(40)      ,/* 自定义字段(文字)009 */
gzauud010       varchar2(40)      ,/* 自定义字段(文字)010 */
gzauud011       number(20,6)      ,/* 自定义字段(数字)011 */
gzauud012       number(20,6)      ,/* 自定义字段(数字)012 */
gzauud013       number(20,6)      ,/* 自定义字段(数字)013 */
gzauud014       number(20,6)      ,/* 自定义字段(数字)014 */
gzauud015       number(20,6)      ,/* 自定义字段(数字)015 */
gzauud016       number(20,6)      ,/* 自定义字段(数字)016 */
gzauud017       number(20,6)      ,/* 自定义字段(数字)017 */
gzauud018       number(20,6)      ,/* 自定义字段(数字)018 */
gzauud019       number(20,6)      ,/* 自定义字段(数字)019 */
gzauud020       number(20,6)      ,/* 自定义字段(数字)020 */
gzauud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
gzauud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
gzauud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
gzauud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
gzauud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
gzauud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
gzauud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
gzauud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
gzauud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
gzauud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table gzau_t add constraint gzau_pk primary key (gzauent,gzau001,gzau002) enable validate;

create unique index gzau_pk on gzau_t (gzauent,gzau001,gzau002);

grant select on gzau_t to tiptop;
grant update on gzau_t to tiptop;
grant delete on gzau_t to tiptop;
grant insert on gzau_t to tiptop;

exit;
