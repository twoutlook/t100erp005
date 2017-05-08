/* 
================================================================================
檔案代號:dbbal_t
檔案名稱:產品組基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dbbal_t
(
dbbalent       number(5)      ,/* 企業編號 */
dbbal001       varchar2(10)      ,/* 產品組編號 */
dbbal002       varchar2(6)      ,/* 語言別 */
dbbal003       varchar2(500)      ,/* 說明 */
dbbal004       varchar2(10)      /* 助記碼 */
);
alter table dbbal_t add constraint dbbal_pk primary key (dbbalent,dbbal001,dbbal002) enable validate;

create unique index dbbal_pk on dbbal_t (dbbalent,dbbal001,dbbal002);

grant select on dbbal_t to tiptop;
grant update on dbbal_t to tiptop;
grant delete on dbbal_t to tiptop;
grant insert on dbbal_t to tiptop;

exit;
