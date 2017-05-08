/* 
================================================================================
檔案代號:dede_t
檔案名稱:門店單品會員消費統計月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dede_t
(
dedeent       number(5)      ,/* 企業編號 */
dedesite       varchar2(10)      ,/* 營運據點 */
dede001       varchar2(10)      ,/* 層級類型 */
dede005       varchar2(10)      ,/* 庫區編號 */
dede006       varchar2(10)      ,/* 庫區類型 */
dede007       varchar2(10)      ,/* 存貨管理方式 */
dede008       varchar2(10)      ,/* 庫區業態 */
dede009       varchar2(40)      ,/* 商品編號 */
dede010       varchar2(40)      ,/* 商品條碼 */
dede011       varchar2(255)      ,/* 商品品名 */
dede012       varchar2(255)      ,/* 商品規格 */
dede013       varchar2(20)      ,/* 品牌 */
dede014       varchar2(10)      ,/* 主供應商 */
dede015       varchar2(10)      ,/* 結算方式 */
dede016       varchar2(10)      ,/* 品類編號 */
dede017       varchar2(20)      ,/* 專櫃編號 */
dede018       varchar2(10)      ,/* 稅別編號 */
dede019       varchar2(10)      ,/* 銷售單位 */
dede020       varchar2(10)      ,/* 會員卡種 */
dede021       varchar2(10)      ,/* 會員等級 */
dede022       number(20,6)      ,/* 銷售數量 */
dede023       number(20,6)      ,/* 銷售成本 */
dede024       number(20,6)      ,/* 進價金額 */
dede025       number(20,6)      ,/* 原價金額 */
dede026       number(20,6)      ,/* 未稅金額 */
dede027       number(20,6)      ,/* 應收金額 */
dede028       number(20,6)      ,/* 毛利 */
dede029       number(20,6)      ,/* 毛利率 */
dede030       number(22,2)      ,/* 會員積分 */
dede031       number(20,6)      ,/* 客單數 */
dede032       number(20,6)      ,/* 抵扣券金額 */
dede033       number(20,6)      ,/* 會員折扣金額 */
dede034       number(20,6)      ,/* 實收金額 */
dede035       number(5,0)      ,/* 統計年度 */
dede036       number(5,0)      ,/* 年計月份 */
dede037       varchar2(256)      ,/* 產品特徵 */
dede038       number(20,6)      ,/* 客單價 */
dede039       varchar2(10)      ,/* 經營方式 */
dede040       varchar2(10)      ,/* 管理品類編號 */
dede041       varchar2(20)      /* 合約編號 */
);
alter table dede_t add constraint dede_pk primary key (dedeent,dedesite,dede005,dede009,dede014,dede015,dede017,dede018,dede019,dede020,dede021,dede035,dede036,dede037,dede039,dede040,dede041) enable validate;

create unique index dede_pk on dede_t (dedeent,dedesite,dede005,dede009,dede014,dede015,dede017,dede018,dede019,dede020,dede021,dede035,dede036,dede037,dede039,dede040,dede041);

grant select on dede_t to tiptop;
grant update on dede_t to tiptop;
grant delete on dede_t to tiptop;
grant insert on dede_t to tiptop;

exit;
