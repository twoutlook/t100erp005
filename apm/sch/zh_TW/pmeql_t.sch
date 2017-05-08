/* 
================================================================================
檔案代號:pmeql_t
檔案名稱:要貨模板基本資料單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pmeql_t
(
pmeqlent       number(5)      ,/* 企業編號 */
pmeql001       varchar2(10)      ,/* 要貨模板編號 */
pmeql002       varchar2(6)      ,/* 語言別 */
pmeql003       varchar2(500)      ,/* 說明 */
pmeql004       varchar2(10)      /* 助記碼 */
);
alter table pmeql_t add constraint pmeql_pk primary key (pmeqlent,pmeql001,pmeql002) enable validate;

create unique index pmeql_pk on pmeql_t (pmeqlent,pmeql001,pmeql002);

grant select on pmeql_t to tiptop;
grant update on pmeql_t to tiptop;
grant delete on pmeql_t to tiptop;
grant insert on pmeql_t to tiptop;

exit;
