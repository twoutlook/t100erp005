/* 
================================================================================
檔案代號:dedg_t
檔案名稱:門店庫區會員消費統計月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dedg_t
(
dedgent       number(5)      ,/* 企業編號 */
dedgsite       varchar2(10)      ,/* 營運據點 */
dedg001       varchar2(10)      ,/* 層級類型 */
dedg005       varchar2(10)      ,/* 庫區編號 */
dedg006       varchar2(10)      ,/* 庫區類型 */
dedg007       varchar2(10)      ,/* 存貨管理方式 */
dedg008       varchar2(10)      ,/* 庫區業態 */
dedg009       varchar2(10)      ,/* 品類編號 */
dedg010       varchar2(20)      ,/* 專櫃編號 */
dedg011       varchar2(10)      ,/* 稅別 */
dedg012       varchar2(10)      ,/* 會員卡種 */
dedg013       varchar2(10)      ,/* 會員等級 */
dedg014       number(20,6)      ,/* 銷售數量 */
dedg015       number(20,6)      ,/* 銷售成本 */
dedg016       number(20,6)      ,/* 進價金額 */
dedg017       number(20,6)      ,/* 原價金額 */
dedg018       number(20,6)      ,/* 未稅金額 */
dedg019       number(20,6)      ,/* 應收金額 */
dedg020       number(20,6)      ,/* 毛利 */
dedg021       number(20,6)      ,/* 毛利率 */
dedg022       number(22,2)      ,/* 會員積分 */
dedg023       number(20,6)      ,/* 客單數 */
dedg024       number(20,6)      ,/* 抵扣券金額 */
dedg025       number(20,6)      ,/* 會員折扣金額 */
dedg026       number(20,6)      ,/* 實收金額 */
dedg027       number(5,0)      ,/* 統計年度 */
dedg028       number(5,0)      ,/* 統計月份 */
dedg029       number(20,6)      /* 客單價 */
);
alter table dedg_t add constraint dedg_pk primary key (dedgent,dedgsite,dedg005,dedg009,dedg010,dedg011,dedg012,dedg013,dedg027,dedg028) enable validate;

create unique index dedg_pk on dedg_t (dedgent,dedgsite,dedg005,dedg009,dedg010,dedg011,dedg012,dedg013,dedg027,dedg028);

grant select on dedg_t to tiptop;
grant update on dedg_t to tiptop;
grant delete on dedg_t to tiptop;
grant insert on dedg_t to tiptop;

exit;
