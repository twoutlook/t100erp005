/* 
================================================================================
檔案代號:decm_t
檔案名稱:門店專櫃款別統計週結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table decm_t
(
decment       number(5)      ,/* 企業代碼 */
decmsite       varchar2(10)      ,/* 營運據點 */
decm001       varchar2(10)      ,/* 層級類型 */
decm005       varchar2(20)      ,/* 專櫃編號 */
decm006       varchar2(10)      ,/* 專櫃類型 */
decm007       varchar2(10)      ,/* 品類編號 */
decm008       varchar2(10)      ,/* 稅別編號 */
decm009       varchar2(10)      ,/* 款別編號 */
decm010       varchar2(10)      ,/* 款別分類 */
decm011       number(20,6)      ,/* 實收金額 */
decm012       number(10,0)      ,/* 統計年度月份 */
decm013       number(5,0)      /* 統計週期 */
);
alter table decm_t add constraint decm_pk primary key (decment,decmsite,decm005,decm007,decm008,decm009,decm012,decm013) enable validate;

create unique index decm_pk on decm_t (decment,decmsite,decm005,decm007,decm008,decm009,decm012,decm013);

grant select on decm_t to tiptop;
grant update on decm_t to tiptop;
grant delete on decm_t to tiptop;
grant insert on decm_t to tiptop;

exit;
