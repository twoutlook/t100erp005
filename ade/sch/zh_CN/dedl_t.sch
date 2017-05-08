/* 
================================================================================
檔案代號:dedl_t
檔案名稱:門店部門月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dedl_t
(
dedlent       number(5)      ,/* 企業編號 */
dedlsite       varchar2(10)      ,/* 營運據點 */
dedl001       varchar2(10)      ,/* 層級類型 */
dedl005       varchar2(10)      ,/* 部門編號 */
dedl006       number(20,6)      ,/* 銷售數量 */
dedl007       number(20,6)      ,/* 銷售成本 */
dedl008       number(20,6)      ,/* 進價金額 */
dedl009       number(20,6)      ,/* 原價金額 */
dedl010       number(20,6)      ,/* 未稅金額 */
dedl011       number(20,6)      ,/* 應收金額 */
dedl012       number(20,6)      ,/* 折扣金額 */
dedl013       number(20,6)      ,/* 收銀差額 */
dedl014       number(20,6)      ,/* 實收金額 */
dedl015       number(20,6)      ,/* 毛利 */
dedl016       number(20,6)      ,/* 毛利率 */
dedl017       number(20,6)      ,/* 客單數 */
dedl018       number(20,6)      ,/* 退貨金額 */
dedl019       number(20,6)      ,/* 退貨單據數 */
dedl020       number(20,6)      ,/* 打折金額 */
dedl021       number(20,6)      ,/* 變價金額 */
dedl022       number(20,6)      ,/* 抵扣券金額 */
dedl023       number(20,6)      ,/* 會員折扣金額 */
dedl024       number(5,0)      ,/* 統計年度 */
dedl025       number(5,0)      /* 統計月份 */
);
alter table dedl_t add constraint dedl_pk primary key (dedlent,dedlsite,dedl005,dedl024,dedl025) enable validate;

create unique index dedl_pk on dedl_t (dedlent,dedlsite,dedl005,dedl024,dedl025);

grant select on dedl_t to tiptop;
grant update on dedl_t to tiptop;
grant delete on dedl_t to tiptop;
grant insert on dedl_t to tiptop;

exit;
