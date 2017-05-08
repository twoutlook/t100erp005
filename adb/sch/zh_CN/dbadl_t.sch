/* 
================================================================================
檔案代號:dbadl_t
檔案名稱:站點基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dbadl_t
(
dbadlent       number(5)      ,/* 企業編號 */
dbadl001       varchar2(10)      ,/* 裝裁點編號 */
dbadl002       varchar2(6)      ,/* 語言別 */
dbadl003       varchar2(500)      ,/* 說明(簡稱) */
dbadl004       varchar2(500)      ,/* 說明(全稱) */
dbadl005       varchar2(10)      /* 助記碼 */
);
alter table dbadl_t add constraint dbadl_pk primary key (dbadlent,dbadl001,dbadl002) enable validate;

create unique index dbadl_pk on dbadl_t (dbadlent,dbadl001,dbadl002);

grant select on dbadl_t to tiptop;
grant update on dbadl_t to tiptop;
grant delete on dbadl_t to tiptop;
grant insert on dbadl_t to tiptop;

exit;
