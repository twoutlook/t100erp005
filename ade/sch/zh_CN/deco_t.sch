/* 
================================================================================
檔案代號:deco_t
檔案名稱:門店部門會員消費統計週結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table deco_t
(
decoent       number(5)      ,/* 企業編號 */
decosite       varchar2(10)      ,/* 營運據點 */
deco001       varchar2(10)      ,/* 層級類型 */
deco005       varchar2(10)      ,/* 部門編號 */
deco006       varchar2(10)      ,/* 會員卡種 */
deco007       varchar2(10)      ,/* 會員等級 */
deco008       number(20,6)      ,/* 銷售數量 */
deco009       number(20,6)      ,/* 銷售成本 */
deco010       number(20,6)      ,/* 進價金額 */
deco011       number(20,6)      ,/* 原價金額 */
deco012       number(20,6)      ,/* 未稅金額 */
deco013       number(20,6)      ,/* 應收金額 */
deco014       number(20,6)      ,/* 毛利 */
deco015       number(20,6)      ,/* 毛利率 */
deco016       number(22,2)      ,/* 會員積分 */
deco017       number(20,6)      ,/* 客單數 */
deco018       number(20,6)      ,/* 抵扣券金額 */
deco019       number(20,6)      ,/* 會員折扣金額 */
deco020       number(20,6)      ,/* 實收金額 */
deco021       number(10,0)      ,/* 統計年度月份 */
deco022       number(5,0)      /* 統計週期 */
);
alter table deco_t add constraint deco_pk primary key (decoent,decosite,deco005,deco006,deco007,deco021,deco022) enable validate;

create unique index deco_pk on deco_t (decoent,decosite,deco005,deco006,deco007,deco021,deco022);

grant select on deco_t to tiptop;
grant update on deco_t to tiptop;
grant delete on deco_t to tiptop;
grant insert on deco_t to tiptop;

exit;
