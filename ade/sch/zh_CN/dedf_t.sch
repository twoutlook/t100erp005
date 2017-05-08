/* 
================================================================================
檔案代號:dedf_t
檔案名稱:門店庫區月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dedf_t
(
dedfent       number(5)      ,/* 企業編號 */
dedfsite       varchar2(10)      ,/* 營運據點 */
dedf001       varchar2(10)      ,/* 層級類型 */
dedf005       varchar2(10)      ,/* 庫區編號 */
dedf006       varchar2(10)      ,/* 庫區類型 */
dedf007       varchar2(10)      ,/* 存貨管理方式 */
dedf008       varchar2(10)      ,/* 庫區業態 */
dedf009       varchar2(10)      ,/* 品類編號 */
dedf010       varchar2(20)      ,/* 專櫃編號 */
dedf011       varchar2(10)      ,/* 稅別編號 */
dedf012       number(20,6)      ,/* 稅額 */
dedf013       number(20,6)      ,/* 銷售數量 */
dedf014       number(20,6)      ,/* 銷售成本 */
dedf015       number(20,6)      ,/* 進價金額 */
dedf016       number(20,6)      ,/* 原價金額 */
dedf017       number(20,6)      ,/* 未稅金額 */
dedf018       number(20,6)      ,/* 應收金額 */
dedf019       number(20,6)      ,/* 折扣金額 */
dedf020       number(20,6)      ,/* 實收金額 */
dedf021       number(20,6)      ,/* 收銀差額 */
dedf022       number(20,6)      ,/* 毛利 */
dedf023       number(20,6)      ,/* 毛利率 */
dedf024       number(20,6)      ,/* 客單數 */
dedf025       number(20,6)      ,/* 退貨單據數 */
dedf026       number(20,6)      ,/* 退貨金額 */
dedf027       number(20,6)      ,/* 打折金額 */
dedf028       number(20,6)      ,/* 變價金額 */
dedf029       number(20,6)      ,/* 抵扣券金額 */
dedf030       number(20,6)      ,/* 會員折扣金額 */
dedf031       number(5,0)      ,/* 統計年度 */
dedf032       number(5,0)      ,/* 統計月份 */
dedf033       number(20,6)      /* 客單價 */
);
alter table dedf_t add constraint dedf_pk primary key (dedfent,dedfsite,dedf005,dedf009,dedf010,dedf011,dedf031,dedf032) enable validate;

create unique index dedf_pk on dedf_t (dedfent,dedfsite,dedf005,dedf009,dedf010,dedf011,dedf031,dedf032);

grant select on dedf_t to tiptop;
grant update on dedf_t to tiptop;
grant delete on dedf_t to tiptop;
grant insert on dedf_t to tiptop;

exit;
