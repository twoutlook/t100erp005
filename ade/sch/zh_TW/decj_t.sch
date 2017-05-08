/* 
================================================================================
檔案代號:decj_t
檔案名稱:門店庫區款別統計週結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table decj_t
(
decjent       number(5)      ,/* 企業代碼 */
decjsite       varchar2(10)      ,/* 營運據點 */
decj001       varchar2(10)      ,/* 層級類型 */
decj005       varchar2(10)      ,/* 庫區編號 */
decj006       varchar2(10)      ,/* 庫區類型 */
decj007       varchar2(10)      ,/* 存貨管理方式 */
decj008       varchar2(10)      ,/* 庫區業態 */
decj009       varchar2(10)      ,/* 品類編號 */
decj010       varchar2(20)      ,/* 專櫃編號 */
decj011       varchar2(10)      ,/* 稅別 */
decj012       varchar2(10)      ,/* 款別編號 */
decj013       varchar2(10)      ,/* 款別分類 */
decj014       number(20,6)      ,/* 實收金額 */
decj015       number(10,0)      ,/* 統計年度月份 */
decj016       number(5,0)      /* 統計週期 */
);
alter table decj_t add constraint decj_pk primary key (decjent,decjsite,decj005,decj009,decj010,decj011,decj012,decj015,decj016) enable validate;

create unique index decj_pk on decj_t (decjent,decjsite,decj005,decj009,decj010,decj011,decj012,decj015,decj016);

grant select on decj_t to tiptop;
grant update on decj_t to tiptop;
grant delete on decj_t to tiptop;
grant insert on decj_t to tiptop;

exit;
