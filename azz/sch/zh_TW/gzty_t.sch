/* 
================================================================================
檔案代號:gzty_t
檔案名稱:資料庫及表格備份表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzty_t
(
gzty001       varchar2(20)      ,/* 表格編號 */
gzty002       varchar2(20)      ,/* 欄位編號 */
gzty003       number(5,0)      ,/* 欄位型態 */
gzty004       number(5,0)      ,/* 欄位長度 */
gzty005       number(5,0)      /* 欄位序號 */
);
alter table gzty_t add constraint gzty_pk primary key (gzty001,gzty002) enable validate;

create unique index gzty_pk on gzty_t (gzty001,gzty002);

grant select on gzty_t to tiptop;
grant update on gzty_t to tiptop;
grant delete on gzty_t to tiptop;
grant insert on gzty_t to tiptop;

exit;
