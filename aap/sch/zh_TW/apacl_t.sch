/* 
================================================================================
檔案代號:apacl_t
檔案名稱:零用金帳戶主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table apacl_t
(
apaclent       number(5)      ,/* 企業編號 */
apacl001       varchar2(10)      ,/* 零用金帳戶代碼 */
apacl002       varchar2(6)      ,/* 語言別 */
apacl003       varchar2(500)      ,/* 說明 */
apacl004       varchar2(10)      /* 助記碼 */
);
alter table apacl_t add constraint apacl_pk primary key (apaclent,apacl001,apacl002) enable validate;

create unique index apacl_pk on apacl_t (apaclent,apacl001,apacl002);

grant select on apacl_t to tiptop;
grant update on apacl_t to tiptop;
grant delete on apacl_t to tiptop;
grant insert on apacl_t to tiptop;

exit;
