/* 
================================================================================
檔案代號:decg_t
檔案名稱:門店單品會員消費統計週結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table decg_t
(
decgent       number(5)      ,/* 企業編號 */
decgsite       varchar2(10)      ,/* 營運據點 */
decg001       varchar2(10)      ,/* 層級類型 */
decg005       varchar2(10)      ,/* 庫區編號 */
decg006       varchar2(10)      ,/* 庫區類型 */
decg007       varchar2(10)      ,/* 存貨管理方式 */
decg008       varchar2(10)      ,/* 庫區業態 */
decg009       varchar2(40)      ,/* 商品編號 */
decg010       varchar2(40)      ,/* 商品條碼 */
decg011       varchar2(255)      ,/* 商品品名 */
decg012       varchar2(255)      ,/* 商品規格 */
decg013       varchar2(20)      ,/* 品牌 */
decg014       varchar2(10)      ,/* 主供應商 */
decg015       varchar2(10)      ,/* 結算方式 */
decg016       varchar2(10)      ,/* 品類編號 */
decg017       varchar2(20)      ,/* 專櫃編號 */
decg018       varchar2(10)      ,/* 稅別編號 */
decg019       varchar2(10)      ,/* 銷售單位 */
decg020       varchar2(10)      ,/* 會員卡種 */
decg021       varchar2(10)      ,/* 會員等級 */
decg022       number(20,6)      ,/* 銷售數量 */
decg023       number(20,6)      ,/* 銷售成本 */
decg024       number(20,6)      ,/* 進價金額 */
decg025       number(20,6)      ,/* 原價金額 */
decg026       number(20,6)      ,/* 未稅金額 */
decg027       number(20,6)      ,/* 應收金額 */
decg028       number(20,6)      ,/* 毛利 */
decg029       number(20,6)      ,/* 毛利率 */
decg030       number(22,2)      ,/* 會員積分 */
decg031       number(20,6)      ,/* 客單數 */
decg032       number(20,6)      ,/* 抵扣券金額 */
decg033       number(20,6)      ,/* 會員折扣金額 */
decg034       number(20,6)      ,/* 實收金額 */
decg035       number(10,0)      ,/* 統計年度月份 */
decg036       number(5,0)      ,/* 統計週期 */
decg037       varchar2(256)      ,/* 產品特徵碼 */
decg038       number(20,6)      ,/* 客單價 */
decg039       varchar2(10)      ,/* 經營方式 */
decg040       varchar2(10)      ,/* 管理品類編號 */
decg041       varchar2(20)      /* 合約編號 */
);
alter table decg_t add constraint decg_pk primary key (decgent,decgsite,decg005,decg009,decg014,decg015,decg017,decg018,decg019,decg020,decg021,decg035,decg036,decg037,decg039,decg040,decg041) enable validate;

create unique index decg_pk on decg_t (decgent,decgsite,decg005,decg009,decg014,decg015,decg017,decg018,decg019,decg020,decg021,decg035,decg036,decg037,decg039,decg040,decg041);

grant select on decg_t to tiptop;
grant update on decg_t to tiptop;
grant delete on decg_t to tiptop;
grant insert on decg_t to tiptop;

exit;
