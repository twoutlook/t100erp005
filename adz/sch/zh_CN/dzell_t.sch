/* 
================================================================================
檔案代號:dzell_t
檔案名稱:欄位類別定義主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dzell_t
(
dzell001       varchar2(80)      ,/* 欄位類別定義代號 */
dzell002       varchar2(6)      ,/* 語言別 */
dzell003       varchar2(500)      ,/* 說明 */
dzell004       varchar2(10)      /* 助記碼 */
);
alter table dzell_t add constraint dzell_pk primary key (dzell001,dzell002) enable validate;

create unique index dzell_pk on dzell_t (dzell001,dzell002);

grant select on dzell_t to tiptop;
grant update on dzell_t to tiptop;
grant delete on dzell_t to tiptop;
grant insert on dzell_t to tiptop;

exit;
