/* 
================================================================================
檔案代號:deci_t
檔案名稱:門店庫區會員消費統計週結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table deci_t
(
decient       number(5)      ,/* 企業編號 */
decisite       varchar2(10)      ,/* 營運據點 */
deci001       varchar2(10)      ,/* 層級類型 */
deci005       varchar2(10)      ,/* 庫區編號 */
deci006       varchar2(10)      ,/* 庫區類型 */
deci007       varchar2(10)      ,/* 存貨管理方式 */
deci008       varchar2(10)      ,/* 庫區業態 */
deci009       varchar2(10)      ,/* 品類編號 */
deci010       varchar2(20)      ,/* 專櫃編號 */
deci011       varchar2(10)      ,/* 稅別 */
deci012       varchar2(10)      ,/* 會員卡種 */
deci013       varchar2(10)      ,/* 會員等級 */
deci014       number(20,6)      ,/* 銷售數量 */
deci015       number(20,6)      ,/* 銷售成本 */
deci016       number(20,6)      ,/* 進價金額 */
deci017       number(20,6)      ,/* 原價金額 */
deci018       number(20,6)      ,/* 未稅金額 */
deci019       number(20,6)      ,/* 應收金額 */
deci020       number(20,6)      ,/* 毛利 */
deci021       number(20,6)      ,/* 毛利率 */
deci022       number(22,2)      ,/* 會員積分 */
deci023       number(20,6)      ,/* 客單數 */
deci024       number(20,6)      ,/* 抵扣券金額 */
deci025       number(20,6)      ,/* 會員折扣金額 */
deci026       number(20,6)      ,/* 實收金額 */
deci027       number(10,0)      ,/* 統計年度月份 */
deci028       number(5,0)      ,/* 統計週期 */
deci029       number(20,6)      /* 客單價 */
);
alter table deci_t add constraint deci_pk primary key (decient,decisite,deci005,deci009,deci010,deci011,deci012,deci013,deci027,deci028) enable validate;

create unique index deci_pk on deci_t (decient,decisite,deci005,deci009,deci010,deci011,deci012,deci013,deci027,deci028);

grant select on deci_t to tiptop;
grant update on deci_t to tiptop;
grant delete on deci_t to tiptop;
grant insert on deci_t to tiptop;

exit;
