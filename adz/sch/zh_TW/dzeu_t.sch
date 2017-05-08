/* 
================================================================================
檔案代號:dzeu_t
檔案名稱:表格.同義字設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzeu_t
(
dzeu001       varchar2(15)      ,/* Table代號 */
dzeu002       varchar2(15)      ,/* 資料庫 */
dzeu003       varchar2(10)      ,/* 表格形式(S:Synonym, T:Table) */
dzeu004       varchar2(1)      ,/* 是否執行 (Y/N) */
dzeu005       number(10,0)      /* 序號 */
);
alter table dzeu_t add constraint dzeu_pk primary key (dzeu001,dzeu002) enable validate;

create unique index dzeu_pk on dzeu_t (dzeu001,dzeu002);

grant select on dzeu_t to tiptop;
grant update on dzeu_t to tiptop;
grant delete on dzeu_t to tiptop;
grant insert on dzeu_t to tiptop;

exit;
