/* 
================================================================================
檔案代號:gzat_t
檔案名稱:异常管理职能角色权限档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzat_t
(
gzatent       number(5)      ,/* 企业代码 */
gzat001       varchar2(10)      ,/* 职能角色编号 */
gzat002       varchar2(10)      ,/* 检核编号 */
gzatud001       varchar2(40)      ,/* 自定义字段(文字)001 */
gzatud002       varchar2(40)      ,/* 自定义字段(文字)002 */
gzatud003       varchar2(40)      ,/* 自定义字段(文字)003 */
gzatud004       varchar2(40)      ,/* 自定义字段(文字)004 */
gzatud005       varchar2(40)      ,/* 自定义字段(文字)005 */
gzatud006       varchar2(40)      ,/* 自定义字段(文字)006 */
gzatud007       varchar2(40)      ,/* 自定义字段(文字)007 */
gzatud008       varchar2(40)      ,/* 自定义字段(文字)008 */
gzatud009       varchar2(40)      ,/* 自定义字段(文字)009 */
gzatud010       varchar2(40)      ,/* 自定义字段(文字)010 */
gzatud011       number(20,6)      ,/* 自定义字段(数字)011 */
gzatud012       number(20,6)      ,/* 自定义字段(数字)012 */
gzatud013       number(20,6)      ,/* 自定义字段(数字)013 */
gzatud014       number(20,6)      ,/* 自定义字段(数字)014 */
gzatud015       number(20,6)      ,/* 自定义字段(数字)015 */
gzatud016       number(20,6)      ,/* 自定义字段(数字)016 */
gzatud017       number(20,6)      ,/* 自定义字段(数字)017 */
gzatud018       number(20,6)      ,/* 自定义字段(数字)018 */
gzatud019       number(20,6)      ,/* 自定义字段(数字)019 */
gzatud020       number(20,6)      ,/* 自定义字段(数字)020 */
gzatud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
gzatud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
gzatud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
gzatud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
gzatud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
gzatud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
gzatud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
gzatud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
gzatud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
gzatud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table gzat_t add constraint gzat_pk primary key (gzatent,gzat001,gzat002) enable validate;

create unique index gzat_pk on gzat_t (gzatent,gzat001,gzat002);

grant select on gzat_t to tiptop;
grant update on gzat_t to tiptop;
grant delete on gzat_t to tiptop;
grant insert on gzat_t to tiptop;

exit;
