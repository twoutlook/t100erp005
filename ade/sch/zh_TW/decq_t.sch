/* 
================================================================================
檔案代號:decq_t
檔案名稱:門店週結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table decq_t
(
decqent       number(5)      ,/* 企業編號 */
decqsite       varchar2(10)      ,/* 營運據點 */
decq001       varchar2(10)      ,/* 層級類型 */
decq005       number(20,6)      ,/* 銷售數量 */
decq006       number(20,6)      ,/* 銷售成本 */
decq007       number(20,6)      ,/* 進價金額 */
decq008       number(20,6)      ,/* 原價金額 */
decq009       number(20,6)      ,/* 未稅金額 */
decq010       number(20,6)      ,/* 應收金額 */
decq011       number(20,6)      ,/* 折扣金額 */
decq012       number(20,6)      ,/* 收銀差額 */
decq013       number(20,6)      ,/* 實收金額 */
decq014       number(20,6)      ,/* 毛利 */
decq015       number(20,6)      ,/* 毛利率 */
decq016       number(20,6)      ,/* 客單數 */
decq017       number(20,6)      ,/* 退貨金額 */
decq018       number(20,6)      ,/* 退貨單據數 */
decq019       number(20,6)      ,/* 打折金額 */
decq020       number(20,6)      ,/* 變價金額 */
decq023       number(20,6)      ,/* 抵扣券金額 */
decq024       number(20,6)      ,/* 會員折扣金額 */
decq025       number(10,0)      ,/* 統計年度月份 */
decq026       number(5,0)      ,/* 統計週期 */
decq027       number(20,6)      /* 客單價 */
);
alter table decq_t add constraint decq_pk primary key (decqent,decqsite,decq025,decq026) enable validate;

create unique index decq_pk on decq_t (decqent,decqsite,decq025,decq026);

grant select on decq_t to tiptop;
grant update on decq_t to tiptop;
grant delete on decq_t to tiptop;
grant insert on decq_t to tiptop;

exit;
