/* 
================================================================================
檔案代號:deck_t
檔案名稱:門店專櫃週結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table deck_t
(
deckent       number(5)      ,/* 企業編號 */
decksite       varchar2(10)      ,/* 營運據點 */
deck001       varchar2(10)      ,/* 層級類型 */
deck005       varchar2(20)      ,/* 專櫃編號 */
deck006       varchar2(10)      ,/* 專櫃類型 */
deck007       varchar2(10)      ,/* 品類編號 */
deck008       varchar2(10)      ,/* 稅別編號 */
deck009       number(20,6)      ,/* 稅額 */
deck010       number(20,6)      ,/* 銷售數量 */
deck011       number(20,6)      ,/* 銷售成本 */
deck012       number(20,6)      ,/* 進價金額 */
deck013       number(20,6)      ,/* 原價金額 */
deck014       number(20,6)      ,/* 未稅金額 */
deck015       number(20,6)      ,/* 應收金額 */
deck016       number(20,6)      ,/* 折扣金額 */
deck017       number(20,6)      ,/* 實收金額 */
deck018       number(20,6)      ,/* 毛利 */
deck019       number(20,6)      ,/* 毛利率 */
deck020       number(20,6)      ,/* 單據數 */
deck021       number(20,6)      ,/* 退貨金額 */
deck022       number(20,6)      ,/* 退貨單據數 */
deck023       number(20,6)      ,/* 打折金額 */
deck024       number(20,6)      ,/* 變價金額 */
deck025       number(20,6)      ,/* 抵扣券金額 */
deck026       number(20,6)      ,/* 會員折扣金額 */
deck027       number(10,0)      ,/* 統計年度月份 */
deck028       number(5,0)      /* 統計週期 */
);
alter table deck_t add constraint deck_pk primary key (deckent,decksite,deck005,deck007,deck008,deck027,deck028) enable validate;

create unique index deck_pk on deck_t (deckent,decksite,deck005,deck007,deck008,deck027,deck028);

grant select on deck_t to tiptop;
grant update on deck_t to tiptop;
grant delete on deck_t to tiptop;
grant insert on deck_t to tiptop;

exit;
