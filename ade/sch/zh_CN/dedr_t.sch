/* 
================================================================================
檔案代號:dedr_t
檔案名稱:門店品類會員消費月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dedr_t
(
dedrent       number(5)      ,/* 企業編號 */
dedrsite       varchar2(10)      ,/* 營運據點 */
dedr001       varchar2(10)      ,/* 層級類型 */
dedr005       varchar2(10)      ,/* 品類編號 */
dedr006       varchar2(20)      ,/* 品牌 */
dedr007       varchar2(10)      ,/* 主供應商 */
dedr008       varchar2(10)      ,/* 結算方式 */
dedr009       varchar2(10)      ,/* 稅別編號 */
dedr010       varchar2(10)      ,/* 會員卡種 */
dedr011       varchar2(10)      ,/* 會員等級 */
dedr012       number(20,6)      ,/* 銷售數量 */
dedr013       number(20,6)      ,/* 銷售成本 */
dedr014       number(20,6)      ,/* 進價金額 */
dedr015       number(20,6)      ,/* 原價金額 */
dedr016       number(20,6)      ,/* 未稅金額 */
dedr017       number(20,6)      ,/* 應收金額 */
dedr018       number(20,6)      ,/* 毛利 */
dedr019       number(20,6)      ,/* 毛利率 */
dedr020       number(22,2)      ,/* 會員積分 */
dedr021       number(20,6)      ,/* 客單數 */
dedr022       number(20,6)      ,/* 抵扣券金額 */
dedr023       number(20,6)      ,/* 會員折扣金額 */
dedr024       number(20,6)      ,/* 實收金額 */
dedr025       number(5,0)      ,/* 統計年度 */
dedr026       number(5,0)      ,/* 統計月份 */
dedr027       number(20,6)      ,/* 客單價 */
dedr028       varchar2(1)      /* 結算方式 */
);
alter table dedr_t add constraint dedr_pk primary key (dedrent,dedrsite,dedr005,dedr006,dedr007,dedr008,dedr009,dedr010,dedr011,dedr025,dedr026,dedr028) enable validate;

create unique index dedr_pk on dedr_t (dedrent,dedrsite,dedr005,dedr006,dedr007,dedr008,dedr009,dedr010,dedr011,dedr025,dedr026,dedr028);

grant select on dedr_t to tiptop;
grant update on dedr_t to tiptop;
grant delete on dedr_t to tiptop;
grant insert on dedr_t to tiptop;

exit;
