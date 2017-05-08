/* 
================================================================================
檔案代號:dzeal_t
檔案名稱:資料表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dzeal_t
(
dzeal001       varchar2(15)      ,/* 表格編號 */
dzeal002       varchar2(6)      ,/* 語言別 */
dzeal003       varchar2(500)      ,/* 表格名稱 */
dzeal004       varchar2(80)      ,/* 表格目的 */
dzeal005       varchar2(80)      /* 備註 */
);
alter table dzeal_t add constraint dzeal_pk primary key (dzeal001,dzeal002) enable validate;

create unique index dzeal_pk on dzeal_t (dzeal001,dzeal002);

grant select on dzeal_t to tiptop;
grant update on dzeal_t to tiptop;
grant delete on dzeal_t to tiptop;
grant insert on dzeal_t to tiptop;

exit;
