/* 
================================================================================
檔案代號:dbaal_t
檔案名稱:銷售地域多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table dbaal_t
(
dbaalent       number(5)      ,/* 企業編號 */
dbaal001       varchar2(10)      ,/* 地域編號 */
dbaal002       varchar2(6)      ,/* 語言別 */
dbaal003       varchar2(500)      ,/* 說明 */
dbaal004       varchar2(10)      /* 助記碼 */
);
alter table dbaal_t add constraint dbaal_pk primary key (dbaalent,dbaal001,dbaal002) enable validate;

create unique index dbaal_pk on dbaal_t (dbaalent,dbaal001,dbaal002);

grant select on dbaal_t to tiptop;
grant update on dbaal_t to tiptop;
grant delete on dbaal_t to tiptop;
grant insert on dbaal_t to tiptop;

exit;
