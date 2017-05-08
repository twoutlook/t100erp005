/* 
================================================================================
檔案代號:dzrdl_t
檔案名稱:报表样板说明多语言档(GR+XtraGrid)(备份)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dzrdl_t
(
dzrdl000       varchar2(80)      ,/* 报表样板ID */
dzrdl001       varchar2(6)      ,/* 语言别 */
dzrdl002       varchar2(500)      ,/* 说明 */
dzrdl003       varchar2(1)      /* 客制 */
);
alter table dzrdl_t add constraint dzrdl_pk primary key (dzrdl000,dzrdl001) enable validate;

create unique index dzrdl_pk on dzrdl_t (dzrdl000,dzrdl001);

grant select on dzrdl_t to tiptop;
grant update on dzrdl_t to tiptop;
grant delete on dzrdl_t to tiptop;
grant insert on dzrdl_t to tiptop;

exit;
