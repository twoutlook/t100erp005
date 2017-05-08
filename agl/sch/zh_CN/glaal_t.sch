/* 
================================================================================
檔案代號:glaal_t
檔案名稱:帳別資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table glaal_t
(
glaalent       number(5)      ,/* 企業編號 */
glaalld       varchar2(5)      ,/* 帳別編號 */
glaal001       varchar2(6)      ,/* 語言別 */
glaal002       varchar2(500)      ,/* 說明 */
glaal003       varchar2(10)      /* 助記碼 */
);
alter table glaal_t add constraint glaal_pk primary key (glaalent,glaalld,glaal001) enable validate;

create unique index glaal_pk on glaal_t (glaalent,glaalld,glaal001);

grant select on glaal_t to tiptop;
grant update on glaal_t to tiptop;
grant delete on glaal_t to tiptop;
grant insert on glaal_t to tiptop;

exit;
