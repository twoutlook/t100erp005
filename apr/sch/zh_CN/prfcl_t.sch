/* 
================================================================================
檔案代號:prfcl_t
檔案名稱:客戶資料多語言
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table prfcl_t
(
prfclent       number(5)      ,/* 企業編號 */
prfcl001       varchar2(10)      ,/* 客戶組 */
prfcl002       varchar2(6)      ,/* 語言別 */
prfcl003       varchar2(500)      ,/* 說明 */
prfcl004       varchar2(10)      /* 助記碼 */
);
alter table prfcl_t add constraint prfcl_pk primary key (prfclent,prfcl001,prfcl002) enable validate;

create unique index prfcl_pk on prfcl_t (prfclent,prfcl001,prfcl002);

grant select on prfcl_t to tiptop;
grant update on prfcl_t to tiptop;
grant delete on prfcl_t to tiptop;
grant insert on prfcl_t to tiptop;

exit;
