/* 
================================================================================
檔案代號:debd_t
檔案名稱:門店庫區會員消費統計日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table debd_t
(
debdent       number(5)      ,/* 企業編號 */
debdsite       varchar2(10)      ,/* 營運據點 */
debd001       varchar2(10)      ,/* 層級類型 */
debd002       date      ,/* 統計日期 */
debd003       number(5,0)      ,/* 會計週 */
debd004       number(5,0)      ,/* 會計期 */
debd005       varchar2(10)      ,/* 庫區編號 */
debd006       varchar2(10)      ,/* 庫區類型 */
debd007       varchar2(10)      ,/* 存貨管理方式 */
debd008       varchar2(10)      ,/* 庫區業態 */
debd009       varchar2(10)      ,/* 品類編號 */
debd010       varchar2(20)      ,/* 專櫃編號 */
debd011       varchar2(10)      ,/* 稅別 */
debd012       varchar2(10)      ,/* 會員卡種 */
debd013       varchar2(10)      ,/* 會員等級 */
debd014       number(20,6)      ,/* 銷售數量 */
debd015       number(20,6)      ,/* 銷售成本 */
debd016       number(20,6)      ,/* 進價金額 */
debd017       number(20,6)      ,/* 原價金額 */
debd018       number(20,6)      ,/* 未稅金額 */
debd019       number(20,6)      ,/* 應收金額 */
debd020       number(20,6)      ,/* 毛利 */
debd021       number(20,6)      ,/* 毛利率 */
debd022       number(22,2)      ,/* 會員積分 */
debd023       number(20,6)      ,/* 客單數 */
debd024       number(20,6)      ,/* 抵扣券金額 */
debd025       number(20,6)      ,/* 會員折扣金額 */
debd026       number(20,6)      ,/* 實收金額 */
debd027       number(20,6)      /* 客單價 */
);
alter table debd_t add constraint debd_pk primary key (debdent,debdsite,debd002,debd005,debd009,debd010,debd011,debd012,debd013) enable validate;

create unique index debd_pk on debd_t (debdent,debdsite,debd002,debd005,debd009,debd010,debd011,debd012,debd013);

grant select on debd_t to tiptop;
grant update on debd_t to tiptop;
grant delete on debd_t to tiptop;
grant insert on debd_t to tiptop;

exit;
