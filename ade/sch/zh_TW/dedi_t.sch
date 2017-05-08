/* 
================================================================================
檔案代號:dedi_t
檔案名稱:門店專櫃月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dedi_t
(
dedient       number(5)      ,/* 企業編號 */
dedisite       varchar2(10)      ,/* 營運據點 */
dedi001       varchar2(10)      ,/* 層級類型 */
dedi005       varchar2(20)      ,/* 專櫃編號 */
dedi006       varchar2(10)      ,/* 專櫃類型 */
dedi007       varchar2(10)      ,/* 品類編號 */
dedi008       varchar2(10)      ,/* 稅別編號 */
dedi009       number(20,6)      ,/* 稅額 */
dedi010       number(20,6)      ,/* 銷售數量 */
dedi011       number(20,6)      ,/* 銷售成本 */
dedi012       number(20,6)      ,/* 進價金額 */
dedi013       number(20,6)      ,/* 原價金額 */
dedi014       number(20,6)      ,/* 未稅金額 */
dedi015       number(20,6)      ,/* 應收金額 */
dedi016       number(20,6)      ,/* 折扣金額 */
dedi017       number(20,6)      ,/* 實收金額 */
dedi018       number(20,6)      ,/* 毛利 */
dedi019       number(20,6)      ,/* 毛利率 */
dedi020       number(20,6)      ,/* 客單數 */
dedi021       number(20,6)      ,/* 退貨金額 */
dedi022       number(20,6)      ,/* 退貨單據數 */
dedi023       number(20,6)      ,/* 打折金額 */
dedi024       number(20,6)      ,/* 變價金額 */
dedi025       number(20,6)      ,/* 抵扣券金額 */
dedi026       number(20,6)      ,/* 會員折扣金額 */
dedi027       number(5,0)      ,/* 統計年度 */
dedi028       number(5,0)      /* 統計月份 */
);
alter table dedi_t add constraint dedi_pk primary key (dedient,dedisite,dedi005,dedi007,dedi008,dedi027,dedi028) enable validate;

create unique index dedi_pk on dedi_t (dedient,dedisite,dedi005,dedi007,dedi008,dedi027,dedi028);

grant select on dedi_t to tiptop;
grant update on dedi_t to tiptop;
grant delete on dedi_t to tiptop;
grant insert on dedi_t to tiptop;

exit;
