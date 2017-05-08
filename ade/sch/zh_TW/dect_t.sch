/* 
================================================================================
檔案代號:dect_t
檔案名稱:門店品類週結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dect_t
(
dectent       number(5)      ,/* 企業編號 */
dectsite       varchar2(10)      ,/* 營運據點 */
dect001       varchar2(10)      ,/* 層級類型 */
dect005       varchar2(10)      ,/* 品類編號 */
dect006       varchar2(20)      ,/* 品牌 */
dect007       varchar2(10)      ,/* 主供應商 */
dect008       varchar2(10)      ,/* 結算方式 */
dect009       varchar2(10)      ,/* 稅別編號 */
dect010       number(20,6)      ,/* 稅額 */
dect011       number(20,6)      ,/* 銷售數量 */
dect012       number(20,6)      ,/* 銷售成本 */
dect013       number(20,6)      ,/* 進價金額 */
dect014       number(20,6)      ,/* 原價金額 */
dect015       number(20,6)      ,/* 未稅金額 */
dect016       number(20,6)      ,/* 應收金額 */
dect017       number(20,6)      ,/* 毛利 */
dect018       number(20,6)      ,/* 毛利率 */
dect019       number(20,6)      ,/* 客單數 */
dect020       number(20,6)      ,/* 促銷銷售數量 */
dect021       number(20,6)      ,/* 促銷應收金額 */
dect022       number(20,6)      ,/* 打折金額 */
dect023       number(20,6)      ,/* 變價金額 */
dect024       number(20,6)      ,/* 退貨金額 */
dect025       number(20,6)      ,/* 後台銷售數量 */
dect026       number(20,6)      ,/* 後台進價金額 */
dect027       number(20,6)      ,/* 後台應收金額 */
dect028       number(20,6)      ,/* 前台銷售數量 */
dect029       number(20,6)      ,/* 前台進價金額 */
dect030       number(20,6)      ,/* 前台應收金額 */
dect031       number(20,6)      ,/* 抵扣券金額 */
dect032       number(20,6)      ,/* 會員折扣金額 */
dect033       number(20,6)      ,/* 實收金額 */
dect034       number(10,0)      ,/* 統計年度月份 */
dect035       number(5,0)      ,/* 統計週期 */
dect036       number(20,6)      ,/* 客單價 */
dect037       varchar2(1)      /* 日結類型 */
);
alter table dect_t add constraint dect_pk primary key (dectent,dectsite,dect005,dect006,dect007,dect008,dect009,dect034,dect035,dect037) enable validate;

create unique index dect_pk on dect_t (dectent,dectsite,dect005,dect006,dect007,dect008,dect009,dect034,dect035,dect037);

grant select on dect_t to tiptop;
grant update on dect_t to tiptop;
grant delete on dect_t to tiptop;
grant insert on dect_t to tiptop;

exit;
