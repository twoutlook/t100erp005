/* 
================================================================================
檔案代號:dzaal_t
檔案名稱:規格與內容版本對應表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dzaal_t
(
);
alter table dzaal_t add constraint dzaal_pk primary key (dzaal001,dzaal002,dzaal003,dzaal004) enable validate;


grant select on dzaal_t to tiptop;
grant update on dzaal_t to tiptop;
grant delete on dzaal_t to tiptop;
grant insert on dzaal_t to tiptop;

exit;
