/* 
================================================================================
檔案代號:prcdl_t
檔案名稱:促銷活動計劃主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table prcdl_t
(
prcdlent       number(5)      ,/* 企業編號 */
prcdl001       varchar2(30)      ,/* 活動計劃 */
prcdl002       varchar2(6)      ,/* 語言別 */
prcdl003       varchar2(500)      ,/* 說明 */
prcdl004       varchar2(10)      /* 助記碼 */
);
alter table prcdl_t add constraint prcdl_pk primary key (prcdlent,prcdl001,prcdl002) enable validate;

create unique index prcdl_pk on prcdl_t (prcdlent,prcdl001,prcdl002);

grant select on prcdl_t to tiptop;
grant update on prcdl_t to tiptop;
grant delete on prcdl_t to tiptop;
grant insert on prcdl_t to tiptop;

exit;
