/* 
================================================================================
檔案代號:imehl_t
檔案名稱:規則化規格可選項檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table imehl_t
(
imehlent       number(5)      ,/* 企業編號 */
imehl001       varchar2(10)      ,/* 品名種類 */
imehl002       varchar2(10)      ,/* 節點編號 */
imehl003       varchar2(40)      ,/* 選項值 */
imehl004       varchar2(6)      ,/* 語言別 */
imehl005       varchar2(500)      ,/* 說明 */
imehl006       varchar2(10)      /* 助記碼 */
);
alter table imehl_t add constraint imehl_pk primary key (imehlent,imehl001,imehl002,imehl003,imehl004) enable validate;

create unique index imehl_pk on imehl_t (imehlent,imehl001,imehl002,imehl003,imehl004);

grant select on imehl_t to tiptop;
grant update on imehl_t to tiptop;
grant delete on imehl_t to tiptop;
grant insert on imehl_t to tiptop;

exit;
