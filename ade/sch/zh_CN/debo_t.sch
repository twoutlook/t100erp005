/* 
================================================================================
檔案代號:debo_t
檔案名稱:門店日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table debo_t
(
deboent       number(5)      ,/* 企業編號 */
debosite       varchar2(10)      ,/* 營運據點 */
debo001       varchar2(10)      ,/* 層級類型 */
debo002       date      ,/* 統計日期 */
debo003       number(5,0)      ,/* 會計週 */
debo004       number(5,0)      ,/* 會計期 */
debo005       number(20,6)      ,/* 銷售數量 */
debo006       number(20,6)      ,/* 銷售成本 */
debo007       number(20,6)      ,/* 進價金額 */
debo008       number(20,6)      ,/* 原價金額 */
debo009       number(20,6)      ,/* 未稅金額 */
debo010       number(20,6)      ,/* 應收金額 */
debo011       number(20,6)      ,/* 折扣金額 */
debo012       number(20,6)      ,/* 收銀差額 */
debo013       number(20,6)      ,/* 實收金額 */
debo014       number(20,6)      ,/* 毛利 */
debo015       number(20,6)      ,/* 毛利率 */
debo016       number(20,6)      ,/* 客單數 */
debo017       number(20,6)      ,/* 退貨金額 */
debo018       number(20,6)      ,/* 退貨單據數 */
debo019       number(20,6)      ,/* 打折金額 */
debo020       number(20,6)      ,/* 變價金額 */
debo021       number(5,0)      ,/* 統計年度 */
debo022       number(5,0)      ,/* 統計月份 */
debo023       number(20,6)      ,/* 抵扣券金額 */
debo024       number(20,6)      ,/* 會員折扣金額 */
debo025       number(20,6)      /* 客單價 */
);
alter table debo_t add constraint debo_pk primary key (deboent,debosite,debo002) enable validate;

create unique index debo_pk on debo_t (deboent,debosite,debo002);

grant select on debo_t to tiptop;
grant update on debo_t to tiptop;
grant delete on debo_t to tiptop;
grant insert on debo_t to tiptop;

exit;
