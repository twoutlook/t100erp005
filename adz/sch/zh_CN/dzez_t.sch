/* 
================================================================================
檔案代號:dzez_t
檔案名稱:表格Patch清單及狀態
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzez_t
(
dzez001       varchar2(40)      ,/* GUID */
dzez002       varchar2(40)      ,/* 表格名稱 */
dzez003       varchar2(1)      ,/* 狀態 */
dzez004       varchar2(40)      ,/* 子包名稱 */
dzez005       timestamp(0)      ,/* 開始時間 */
dzez006       timestamp(0)      ,/* 結束時間 */
dzez007       varchar2(4)      /* 模組別 */
);
alter table dzez_t add constraint dzez_pk primary key (dzez001,dzez002) enable validate;

create unique index dzez_pk on dzez_t (dzez001,dzez002);

grant select on dzez_t to tiptop;
grant update on dzez_t to tiptop;
grant delete on dzez_t to tiptop;
grant insert on dzez_t to tiptop;

exit;
