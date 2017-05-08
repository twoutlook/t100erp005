/* 
================================================================================
檔案代號:dzau_t
檔案名稱:行業對應之標準規格引用清單
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzau_t
(
dzau001       varchar2(20)      ,/* 行業規格編號 */
dzau003       varchar2(60)      ,/* 標準識別碼 */
dzau004       number(10)      ,/* 標準識別碼版次 */
dzau005       varchar2(10)      /* 識別碼類型 */
);
alter table dzau_t add constraint dzau_pk primary key (dzau001,dzau003) enable validate;

create unique index dzau_pk on dzau_t (dzau001,dzau003);

grant select on dzau_t to tiptop;
grant update on dzau_t to tiptop;
grant delete on dzau_t to tiptop;
grant insert on dzau_t to tiptop;

exit;
