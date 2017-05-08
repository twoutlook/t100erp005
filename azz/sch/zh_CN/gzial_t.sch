/* 
================================================================================
檔案代號:gzial_t
檔案名稱:自定义查询单头多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzial_t
(
gzial001       varchar2(20)      ,/* 查询单ID */
gzial002       varchar2(6)      ,/* 语言别 */
gzial003       varchar2(500)      ,/* 查询单名称 */
gzial004       varchar2(1)      /* 客制 */
);
alter table gzial_t add constraint gzial_pk primary key (gzial001,gzial002) enable validate;

create unique index gzial_pk on gzial_t (gzial001,gzial002);

grant select on gzial_t to tiptop;
grant update on gzial_t to tiptop;
grant delete on gzial_t to tiptop;
grant insert on gzial_t to tiptop;

exit;
