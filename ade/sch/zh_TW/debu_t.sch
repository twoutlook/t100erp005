/* 
================================================================================
檔案代號:debu_t
檔案名稱:營運組織銷售月結單品檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table debu_t
(
debuent       number(5)      ,/* 企業編號 */
debusite       varchar2(10)      ,/* 營運據點 */
debu001       varchar2(10)      ,/* 層級類型 */
debu002       number(5,0)      ,/* 統計年度 */
debu003       number(5,0)      ,/* 統計月份 */
debu004       varchar2(10)      ,/* 庫區編號 */
debu005       varchar2(10)      ,/* 存貨管理方式 */
debu006       varchar2(10)      ,/* 庫區業態 */
debu007       varchar2(40)      ,/* 商品編號 */
debu008       varchar2(256)      ,/* 產品特徵 */
debu009       varchar2(255)      ,/* 商品品名 */
debu010       varchar2(255)      ,/* 商品規格 */
debu011       varchar2(10)      ,/* 品牌 */
debu012       varchar2(10)      ,/* 主供應商 */
debu013       varchar2(10)      ,/* 結算方式 */
debu014       varchar2(10)      ,/* 品類編號 */
debu015       varchar2(20)      ,/* 專櫃編號 */
debu016       varchar2(10)      ,/* 稅別編號 */
debu017       number(20,6)      ,/* 稅額 */
debu018       varchar2(10)      ,/* 銷售單位 */
debu019       number(20,6)      ,/* 銷售數量 */
debu020       number(20,6)      ,/* 銷售成本 */
debu021       number(20,6)      ,/* 進價金額 */
debu022       number(20,6)      ,/* 原價金額 */
debu023       number(20,6)      ,/* 未稅金額 */
debu024       number(20,6)      ,/* 應收金額 */
debu025       number(20,6)      ,/* 毛利 */
debu026       number(20,6)      ,/* 毛利率 */
debu027       number(20,6)      ,/* 客單數 */
debu028       number(20,6)      ,/* 促銷銷售數量 */
debu029       number(20,6)      ,/* 促銷應收金額 */
debu030       number(20,6)      ,/* 打折金額 */
debu031       number(20,6)      ,/* 變價金額 */
debu032       number(20,6)      ,/* 退貨金額 */
debu033       number(20,6)      ,/* 後臺銷售數量 */
debu034       number(20,6)      ,/* 後臺進價金額 */
debu035       number(20,6)      ,/* 後臺應收金額 */
debu036       number(20,6)      ,/* 前臺銷售數量 */
debu037       number(20,6)      ,/* 前臺進價金額 */
debu038       number(20,6)      ,/* 前臺應收金額 */
debu039       number(20,6)      ,/* 退貨單據數 */
debu040       varchar2(40)      ,/* 商品條碼 */
debu041       varchar2(10)      ,/* 庫區類型 */
debu042       number(20,6)      ,/* 抵扣券金額 */
debu043       number(20,6)      ,/* 會員折扣金額 */
debu044       number(20,6)      ,/* 實收金額 */
debu045       number(20,6)      ,/* 客單價 */
debu046       varchar2(10)      ,/* 結算方式 */
debu048       number(20,6)      ,/* 庫存數量 */
debu049       number(20,6)      ,/* 庫存金額 */
debu050       varchar2(10)      ,/* 管理品類編號 */
debu051       varchar2(20)      /* 合約編號 */
);
alter table debu_t add constraint debu_pk primary key (debuent,debusite,debu002,debu003,debu004,debu007,debu008,debu012,debu013,debu015,debu016,debu018,debu046,debu050,debu051) enable validate;

create unique index debu_pk on debu_t (debuent,debusite,debu002,debu003,debu004,debu007,debu008,debu012,debu013,debu015,debu016,debu018,debu046,debu050,debu051);

grant select on debu_t to tiptop;
grant update on debu_t to tiptop;
grant delete on debu_t to tiptop;
grant insert on debu_t to tiptop;

exit;
