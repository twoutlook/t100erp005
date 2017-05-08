/* 
================================================================================
檔案代號:dedk_t
檔案名稱:門店專櫃款別統計月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dedk_t
(
dedkent       number(5)      ,/* 企業代碼 */
dedksite       varchar2(10)      ,/* 營運據點 */
dedk001       varchar2(10)      ,/* 層級類型 */
dedk005       varchar2(20)      ,/* 專櫃編號 */
dedk006       varchar2(10)      ,/* 專櫃類型 */
dedk007       varchar2(10)      ,/* 品類編號 */
dedk008       varchar2(10)      ,/* 稅別編號 */
dedk009       varchar2(10)      ,/* 款別編號 */
dedk010       varchar2(10)      ,/* 款別分類 */
dedk011       number(20,6)      ,/* 實收金額 */
dedk012       number(5,0)      ,/* 統計年度 */
dedk013       number(5,0)      /* 統計月份 */
);
alter table dedk_t add constraint dedk_pk primary key (dedkent,dedksite,dedk005,dedk007,dedk008,dedk009,dedk012,dedk013) enable validate;

create unique index dedk_pk on dedk_t (dedkent,dedksite,dedk005,dedk007,dedk008,dedk009,dedk012,dedk013);

grant select on dedk_t to tiptop;
grant update on dedk_t to tiptop;
grant delete on dedk_t to tiptop;
grant insert on dedk_t to tiptop;

exit;
