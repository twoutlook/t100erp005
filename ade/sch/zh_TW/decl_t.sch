/* 
================================================================================
檔案代號:decl_t
檔案名稱:門店專櫃會員消費統計週結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table decl_t
(
declent       number(5)      ,/* 企業編號 */
declsite       varchar2(10)      ,/* 營運據點 */
decl001       varchar2(10)      ,/* 層級類別 */
decl005       varchar2(20)      ,/* 專櫃編號 */
decl006       varchar2(10)      ,/* 品類編號 */
decl007       varchar2(10)      ,/* 稅別編號 */
decl008       varchar2(10)      ,/* 會員卡種 */
decl009       varchar2(10)      ,/* 會員等級 */
decl010       number(20,6)      ,/* 銷售數量 */
decl011       number(20,6)      ,/* 銷售成本 */
decl012       number(20,6)      ,/* 進價金額 */
decl013       number(20,6)      ,/* 原價金額 */
decl014       number(20,6)      ,/* 未稅金額 */
decl015       number(20,6)      ,/* 應收金額 */
decl016       number(20,6)      ,/* 毛利 */
decl017       number(20,6)      ,/* 毛利率 */
decl018       number(22,2)      ,/* 會員積分 */
decl019       number(20,6)      ,/* 單據數 */
decl020       number(20,6)      ,/* 抵扣券金額 */
decl021       number(20,6)      ,/* 會員折扣金額 */
decl022       number(20,6)      ,/* 實收金額 */
decl023       number(10,0)      ,/* 統計年度月份 */
decl024       number(5,0)      /* 統計週期 */
);
alter table decl_t add constraint decl_pk primary key (declent,declsite,decl005,decl006,decl007,decl008,decl009,decl023,decl024) enable validate;

create unique index decl_pk on decl_t (declent,declsite,decl005,decl006,decl007,decl008,decl009,decl023,decl024);

grant select on decl_t to tiptop;
grant update on decl_t to tiptop;
grant delete on decl_t to tiptop;
grant insert on decl_t to tiptop;

exit;
