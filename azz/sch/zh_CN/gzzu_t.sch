/* 
================================================================================
檔案代號:gzzu_t
檔案名稱:不管制權限的action指定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzzu_t
(
gzzu001       varchar2(80)      ,/* 功能編號 */
gzzu002       varchar2(20)      ,/* 使用程式編號 */
gzzu003       varchar2(1)      ,/* 是否僅為前置字 */
gzzu004       varchar2(1)      /* 使用標示 */
);
alter table gzzu_t add constraint gzzu_pk primary key (gzzu001) enable validate;

create unique index gzzu_pk on gzzu_t (gzzu001);

grant select on gzzu_t to tiptop;
grant update on gzzu_t to tiptop;
grant delete on gzzu_t to tiptop;
grant insert on gzzu_t to tiptop;

exit;
