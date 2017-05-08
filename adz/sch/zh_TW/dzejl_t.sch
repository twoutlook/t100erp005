/* 
================================================================================
檔案代號:dzejl_t
檔案名稱:共通代碼明細檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dzejl_t
(
dzejl001       varchar2(40)      ,/* 代碼代號 */
dzejl002       varchar2(40)      ,/* 明細代號 */
dzejl003       varchar2(6)      ,/* 語言別 */
dzejl004       varchar2(500)      ,/* 說明 */
dzejl005       varchar2(10)      /* 助記碼 */
);
alter table dzejl_t add constraint dzejl_pk primary key (dzejl001,dzejl002,dzejl003) enable validate;

create unique index dzejl_pk on dzejl_t (dzejl001,dzejl002,dzejl003);

grant select on dzejl_t to tiptop;
grant update on dzejl_t to tiptop;
grant delete on dzejl_t to tiptop;
grant insert on dzejl_t to tiptop;

exit;
