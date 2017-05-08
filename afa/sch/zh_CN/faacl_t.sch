/* 
================================================================================
檔案代號:faacl_t
檔案名稱:固定資產主要類型檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table faacl_t
(
faaclent       number(5)      ,/* 企業編號 */
faacl001       varchar2(20)      ,/* 資產主要類別 */
faacl002       varchar2(6)      ,/* 語言別 */
faacl003       varchar2(500)      ,/* 說明 */
faacl004       varchar2(10)      /* 助記碼 */
);
alter table faacl_t add constraint faacl_pk primary key (faaclent,faacl001,faacl002) enable validate;

create unique index faacl_pk on faacl_t (faaclent,faacl001,faacl002);

grant select on faacl_t to tiptop;
grant update on faacl_t to tiptop;
grant delete on faacl_t to tiptop;
grant insert on faacl_t to tiptop;

exit;
