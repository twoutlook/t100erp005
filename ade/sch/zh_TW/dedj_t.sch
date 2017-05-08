/* 
================================================================================
檔案代號:dedj_t
檔案名稱:門店專櫃會員消費統計月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dedj_t
(
dedjent       number(5)      ,/* 企業編號 */
dedjsite       varchar2(10)      ,/* 營運據點 */
dedj001       varchar2(10)      ,/* 層級類別 */
dedj005       varchar2(20)      ,/* 專櫃編號 */
dedj006       varchar2(10)      ,/* 品類編號 */
dedj007       varchar2(10)      ,/* 稅別編號 */
dedj008       varchar2(10)      ,/* 會員卡種 */
dedj009       varchar2(10)      ,/* 會員等級 */
dedj010       number(20,6)      ,/* 銷售數量 */
dedj011       number(20,6)      ,/* 銷售成本 */
dedj012       number(20,6)      ,/* 進價金額 */
dedj013       number(20,6)      ,/* 原價金額 */
dedj014       number(20,6)      ,/* 未稅金額 */
dedj015       number(20,6)      ,/* 應收金額 */
dedj016       number(20,6)      ,/* 毛利 */
dedj017       number(20,6)      ,/* 毛利率 */
dedj018       number(22,2)      ,/* 會員積分 */
dedj019       number(20,6)      ,/* 客單數 */
dedj020       number(20,6)      ,/* 抵扣券金額 */
dedj021       number(20,6)      ,/* 會員折扣金額 */
dedj022       number(20,6)      ,/* 實收金額 */
dedj023       number(5,0)      ,/* 統計年度 */
dedj024       number(5,0)      /* 統計月份 */
);
alter table dedj_t add constraint dedj_pk primary key (dedjent,dedjsite,dedj005,dedj006,dedj007,dedj008,dedj009,dedj023,dedj024) enable validate;

create unique index dedj_pk on dedj_t (dedjent,dedjsite,dedj005,dedj006,dedj007,dedj008,dedj009,dedj023,dedj024);

grant select on dedj_t to tiptop;
grant update on dedj_t to tiptop;
grant delete on dedj_t to tiptop;
grant insert on dedj_t to tiptop;

exit;
