/* 
================================================================================
檔案代號:debb_t
檔案名稱:門店單品會員消費統計日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table debb_t
(
debbent       number(5)      ,/* 企業編號 */
debbsite       varchar2(10)      ,/* 營運據點 */
debb001       varchar2(10)      ,/* 層級類型 */
debb002       date      ,/* 統計日期 */
debb003       number(5,0)      ,/* 會計週 */
debb004       number(5,0)      ,/* 會計期 */
debb005       varchar2(10)      ,/* 庫區編號 */
debb006       varchar2(10)      ,/* 庫區類型 */
debb007       varchar2(10)      ,/* 存貨管理方式 */
debb008       varchar2(10)      ,/* 庫區業態 */
debb009       varchar2(40)      ,/* 商品編號 */
debb010       varchar2(40)      ,/* 商品條碼 */
debb011       varchar2(255)      ,/* 商品品名 */
debb012       varchar2(255)      ,/* 商品規格 */
debb013       varchar2(20)      ,/* 品牌 */
debb014       varchar2(10)      ,/* 主供應商 */
debb015       varchar2(10)      ,/* 結算方式 */
debb016       varchar2(10)      ,/* 品類編號 */
debb017       varchar2(20)      ,/* 專櫃編號 */
debb018       varchar2(10)      ,/* 稅別編號 */
debb019       varchar2(10)      ,/* 銷售單位 */
debb020       varchar2(10)      ,/* 會員卡種 */
debb021       varchar2(10)      ,/* 會員等級 */
debb022       number(20,6)      ,/* 銷售數量 */
debb023       number(20,6)      ,/* 銷售成本 */
debb024       number(20,6)      ,/* 進價金額 */
debb025       number(20,6)      ,/* 原價金額 */
debb026       number(20,6)      ,/* 未稅金額 */
debb027       number(20,6)      ,/* 應收金額 */
debb028       number(20,6)      ,/* 毛利 */
debb029       number(20,6)      ,/* 毛利率 */
debb030       number(22,2)      ,/* 會員積分 */
debb031       number(20,6)      ,/* 客單數 */
debb032       number(20,6)      ,/* 抵扣券金額 */
debb033       number(20,6)      ,/* 會員折扣金額 */
debb034       number(20,6)      ,/* 實收金額 */
debb035       varchar2(256)      ,/* 產品特徵 */
debb036       number(20,6)      ,/* 客單價 */
debb037       varchar2(10)      ,/* 經營方式 */
debb038       varchar2(10)      ,/* 管理品類 */
debb039       varchar2(20)      /* 合約編號 */
);
alter table debb_t add constraint debb_pk primary key (debbent,debbsite,debb002,debb005,debb009,debb017,debb018,debb019,debb020,debb021,debb035) enable validate;

create unique index debb_pk on debb_t (debbent,debbsite,debb002,debb005,debb009,debb017,debb018,debb019,debb020,debb021,debb035);

grant select on debb_t to tiptop;
grant update on debb_t to tiptop;
grant delete on debb_t to tiptop;
grant insert on debb_t to tiptop;

exit;
