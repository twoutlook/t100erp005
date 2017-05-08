/* 
================================================================================
檔案代號:bgcdl_t
檔案名稱:計價因子主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bgcdl_t
(
bgcdlent       number(5)      ,/* 企業編號 */
bgcdl001       varchar2(10)      ,/* 計價因子 */
bgcdl002       varchar2(6)      ,/* 語言別 */
bgcdl003       varchar2(500)      ,/* 說明 */
bgcdl004       varchar2(10)      /* 助記碼 */
);
alter table bgcdl_t add constraint bgcdl_pk primary key (bgcdlent,bgcdl001,bgcdl002) enable validate;

create unique index bgcdl_pk on bgcdl_t (bgcdlent,bgcdl001,bgcdl002);

grant select on bgcdl_t to tiptop;
grant update on bgcdl_t to tiptop;
grant delete on bgcdl_t to tiptop;
grant insert on bgcdl_t to tiptop;

exit;
