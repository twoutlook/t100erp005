/* 
================================================================================
檔案代號:prfgl_t
檔案名稱:產品價格組資料表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table prfgl_t
(
prfglent       number(5)      ,/* 企業編號 */
prfgl001       varchar2(10)      ,/* 產品價格組 */
prfgl002       varchar2(6)      ,/* 語言別 */
prfgl003       varchar2(500)      ,/* 說明 */
prfgl004       varchar2(10)      /* 助記碼 */
);
alter table prfgl_t add constraint prfgl_pk primary key (prfglent,prfgl001,prfgl002) enable validate;

create unique index prfgl_pk on prfgl_t (prfglent,prfgl001,prfgl002);

grant select on prfgl_t to tiptop;
grant update on prfgl_t to tiptop;
grant delete on prfgl_t to tiptop;
grant insert on prfgl_t to tiptop;

exit;
