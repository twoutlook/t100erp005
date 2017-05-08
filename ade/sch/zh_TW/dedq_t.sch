/* 
================================================================================
檔案代號:dedq_t
檔案名稱:門店品類月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dedq_t
(
dedqent       number(5)      ,/* 企業編號 */
dedqsite       varchar2(10)      ,/* 營運據點 */
dedq001       varchar2(10)      ,/* 層級類型 */
dedq005       varchar2(10)      ,/* 品類編號 */
dedq006       varchar2(20)      ,/* 品牌 */
dedq007       varchar2(10)      ,/* 主供應商 */
dedq008       varchar2(10)      ,/* 結算方式 */
dedq009       varchar2(10)      ,/* 稅別編號 */
dedq010       number(20,6)      ,/* 稅額 */
dedq011       number(20,6)      ,/* 銷售數量 */
dedq012       number(20,6)      ,/* 銷售成本 */
dedq013       number(20,6)      ,/* 進價金額 */
dedq014       number(20,6)      ,/* 原價金額 */
dedq015       number(20,6)      ,/* 未稅金額 */
dedq016       number(20,6)      ,/* 應收金額 */
dedq017       number(20,6)      ,/* 毛利 */
dedq018       number(20,6)      ,/* 毛利率 */
dedq019       number(20,6)      ,/* 客單數 */
dedq020       number(20,6)      ,/* 促銷銷售數量 */
dedq021       number(20,6)      ,/* 促銷應收金額 */
dedq022       number(20,6)      ,/* 打折金額 */
dedq023       number(20,6)      ,/* 變價金額 */
dedq024       number(20,6)      ,/* 退貨金額 */
dedq025       number(20,6)      ,/* 後台銷售數量 */
dedq026       number(20,6)      ,/* 後台進價金額 */
dedq027       number(20,6)      ,/* 後台應收金額 */
dedq028       number(20,6)      ,/* 前台銷售數量 */
dedq029       number(20,6)      ,/* 前台進價金額 */
dedq030       number(20,6)      ,/* 前台應收金額 */
dedq031       number(20,6)      ,/* 抵扣券金額 */
dedq032       number(20,6)      ,/* 會員折扣金額 */
dedq033       number(20,6)      ,/* 實收金額 */
dedq034       number(5,0)      ,/* 統計年度 */
dedq035       number(5,0)      ,/* 統計月份 */
dedq036       number(20,6)      ,/* 客單價 */
dedq037       varchar2(1)      /* 日結類型 */
);
alter table dedq_t add constraint dedq_pk primary key (dedqent,dedqsite,dedq005,dedq006,dedq007,dedq008,dedq009,dedq034,dedq035,dedq037) enable validate;

create unique index dedq_pk on dedq_t (dedqent,dedqsite,dedq005,dedq006,dedq007,dedq008,dedq009,dedq034,dedq035,dedq037);

grant select on dedq_t to tiptop;
grant update on dedq_t to tiptop;
grant delete on dedq_t to tiptop;
grant insert on dedq_t to tiptop;

exit;
