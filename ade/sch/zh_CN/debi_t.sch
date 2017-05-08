/* 
================================================================================
檔案代號:debi_t
檔案名稱:門店專櫃款別統計日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table debi_t
(
debient       number(5)      ,/* 企業編號 */
debisite       varchar2(10)      ,/* 營運據點 */
debi001       varchar2(10)      ,/* 層級類型 */
debi002       date      ,/* 統計日期 */
debi003       number(5,0)      ,/* 會計週 */
debi004       number(5,0)      ,/* 會計期 */
debi005       varchar2(20)      ,/* 專櫃編號 */
debi006       varchar2(10)      ,/* 專櫃類型 */
debi007       varchar2(10)      ,/* 品類編號 */
debi008       varchar2(10)      ,/* 稅別編號 */
debi009       varchar2(10)      ,/* 款別編號 */
debi010       varchar2(10)      ,/* 款別分類 */
debi011       number(20,6)      /* 實收金額 */
);
alter table debi_t add constraint debi_pk primary key (debient,debisite,debi002,debi005,debi007,debi008,debi009) enable validate;

create unique index debi_pk on debi_t (debient,debisite,debi002,debi005,debi007,debi008,debi009);

grant select on debi_t to tiptop;
grant update on debi_t to tiptop;
grant delete on debi_t to tiptop;
grant insert on debi_t to tiptop;

exit;
