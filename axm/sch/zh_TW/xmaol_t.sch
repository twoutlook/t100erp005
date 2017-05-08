/* 
================================================================================
檔案代號:xmaol_t
檔案名稱:嘜頭基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xmaol_t
(
xmaolent       number(5)      ,/* 企業編號 */
xmaol001       varchar2(10)      ,/* 客戶編號 */
xmaol002       varchar2(10)      ,/* 嘜頭編號 */
xmaol003       varchar2(6)      ,/* 語言別 */
xmaol004       varchar2(500)      ,/* 說明 */
xmaol005       varchar2(10)      /* 助記碼 */
);
alter table xmaol_t add constraint xmaol_pk primary key (xmaolent,xmaol001,xmaol002,xmaol003) enable validate;

create unique index xmaol_pk on xmaol_t (xmaolent,xmaol001,xmaol002,xmaol003);

grant select on xmaol_t to tiptop;
grant update on xmaol_t to tiptop;
grant delete on xmaol_t to tiptop;
grant insert on xmaol_t to tiptop;

exit;
