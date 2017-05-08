/* 
================================================================================
檔案代號:dziu_t
檔案名稱:中介表格表格.同義字設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dziu_t
(
dziu001       varchar2(15)      ,/* Table代號 */
dziu002       varchar2(15)      ,/* 資料庫 */
dziu003       varchar2(10)      ,/* 表格形式(S:Synonym, T:Table) */
dziu004       varchar2(1)      ,/* 是否執行 (Y/N) */
dziu005       number(10,0)      ,/* 序號 */
dziu006       varchar2(15)      ,/* 資料庫識別名稱 */
dziu007       varchar2(15)      ,/* Synonym來源資料庫 */
dziu008       varchar2(255)      /* Synonym來源DB Link */
);
alter table dziu_t add constraint dziu_pk primary key (dziu001,dziu002,dziu005) enable validate;

create unique index dziu_pk on dziu_t (dziu001,dziu002,dziu005);

grant select on dziu_t to tiptop;
grant update on dziu_t to tiptop;
grant delete on dziu_t to tiptop;
grant insert on dziu_t to tiptop;

exit;
