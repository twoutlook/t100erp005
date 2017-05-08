/* 
================================================================================
檔案代號:decu_t
檔案名稱:門店品類會員消費週結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table decu_t
(
decuent       number(5)      ,/* 企業編號 */
decusite       varchar2(10)      ,/* 營運據點 */
decu001       varchar2(10)      ,/* 層級類型 */
decu005       varchar2(10)      ,/* 品類編號 */
decu006       varchar2(20)      ,/* 品牌 */
decu007       varchar2(10)      ,/* 主供應商 */
decu008       varchar2(10)      ,/* 結算方式 */
decu009       varchar2(10)      ,/* 稅別編號 */
decu010       varchar2(10)      ,/* 會員卡種 */
decu011       varchar2(10)      ,/* 會員等級 */
decu012       number(20,6)      ,/* 銷售數量 */
decu013       number(20,6)      ,/* 銷售成本 */
decu014       number(20,6)      ,/* 進價金額 */
decu015       number(20,6)      ,/* 原價金額 */
decu016       number(20,6)      ,/* 未稅金額 */
decu017       number(20,6)      ,/* 應收金額 */
decu018       number(20,6)      ,/* 毛利 */
decu019       number(20,6)      ,/* 毛利率 */
decu020       number(22,2)      ,/* 會員積分 */
decu021       number(20,6)      ,/* 客單數 */
decu022       number(20,6)      ,/* 抵扣券金額 */
decu023       number(20,6)      ,/* 會員折扣金額 */
decu024       number(20,6)      ,/* 實收金額 */
decu025       number(10,0)      ,/* 統計年度月份 */
decu026       number(5,0)      ,/* 統計週期 */
decu027       number(20,6)      ,/* 客單價 */
decu028       varchar2(1)      /* 結算類型 */
);
alter table decu_t add constraint decu_pk primary key (decuent,decusite,decu005,decu006,decu007,decu008,decu009,decu010,decu011,decu025,decu026,decu028) enable validate;

create unique index decu_pk on decu_t (decuent,decusite,decu005,decu006,decu007,decu008,decu009,decu010,decu011,decu025,decu026,decu028);

grant select on decu_t to tiptop;
grant update on decu_t to tiptop;
grant delete on decu_t to tiptop;
grant insert on decu_t to tiptop;

exit;
