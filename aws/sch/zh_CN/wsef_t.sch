/* 
================================================================================
檔案代號:wsef_t
檔案名稱:EAI整合產品資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wsef_t
(
wsef001       varchar2(20)      ,/* 產品別 */
wsef002       varchar2(10)      ,/* 版本 */
wsef003       varchar2(20)      ,/* IP位置 */
wsef004       varchar2(20)      ,/* 產品識別碼 */
wsef005       varchar2(100)      ,/* WSDL位置 */
wsef006       varchar2(1)      ,/* 站台分類 */
wsef007       number(5)      /* 例外站台 */
);
alter table wsef_t add constraint wsef_pk primary key (wsef001,wsef003,wsef004,wsef006,wsef007) enable validate;

create unique index wsef_pk on wsef_t (wsef001,wsef003,wsef004,wsef006,wsef007);

grant select on wsef_t to tiptop;
grant update on wsef_t to tiptop;
grant delete on wsef_t to tiptop;
grant insert on wsef_t to tiptop;

exit;
