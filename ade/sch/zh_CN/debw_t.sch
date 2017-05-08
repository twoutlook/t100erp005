/* 
================================================================================
檔案代號:debw_t
檔案名稱:門店商品品類日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table debw_t
(
debwent       number(5)      ,/* 企業編號 */
debwsite       varchar2(10)      ,/* 營運據點 */
debw001       varchar2(10)      ,/* 層級類型 */
debw002       date      ,/* 統計日期 */
debw003       number(5,0)      ,/* 會計週 */
debw004       number(5,0)      ,/* 會計期 */
debw005       varchar2(10)      ,/* 品類編號 */
debw006       varchar2(20)      ,/* no use */
debw007       varchar2(10)      ,/* no use */
debw008       varchar2(10)      ,/* no use */
debw009       varchar2(10)      ,/* no use */
debw010       number(20,6)      ,/* no use */
debw011       number(20,6)      ,/* 銷售數量 */
debw012       number(20,6)      ,/* 銷售成本 */
debw013       number(20,6)      ,/* 進價金額 */
debw014       number(20,6)      ,/* 原價金額 */
debw015       number(20,6)      ,/* 未稅金額 */
debw016       number(20,6)      ,/* 應收金額 */
debw017       number(20,6)      ,/* 毛利 */
debw018       number(20,6)      ,/* 毛利率 */
debw019       number(20,6)      ,/* 客單數 */
debw020       number(20,6)      ,/* 促銷銷售數量 */
debw021       number(20,6)      ,/* 促銷應收金額 */
debw022       number(20,6)      ,/* 打折金額 */
debw023       number(20,6)      ,/* 變價金額 */
debw024       number(20,6)      ,/* 退貨金額 */
debw025       number(20,6)      ,/* 後台銷售數量 */
debw026       number(20,6)      ,/* 後台進價金額 */
debw027       number(20,6)      ,/* 後台應收金額 */
debw028       number(20,6)      ,/* 前台銷售數量 */
debw029       number(20,6)      ,/* 前台進價金額 */
debw030       number(20,6)      ,/* 前台應收金額 */
debw031       number(20,6)      ,/* 抵扣券金額 */
debw032       number(20,6)      ,/* 會員折扣金額 */
debw033       number(20,6)      ,/* 實收金額 */
debw034       number(20,6)      /* 客單價 */
);
alter table debw_t add constraint debw_pk primary key (debwent,debwsite,debw002,debw005) enable validate;

create unique index debw_pk on debw_t (debwent,debwsite,debw002,debw005);

grant select on debw_t to tiptop;
grant update on debw_t to tiptop;
grant delete on debw_t to tiptop;
grant insert on debw_t to tiptop;

exit;
