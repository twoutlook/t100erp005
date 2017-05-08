/* 
================================================================================
檔案代號:debz_t
檔案名稱:門店收入日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table debz_t
(
debzent       number(5)      ,/* 企業編號 */
debzsite       varchar2(10)      ,/* 營運據點 */
debz001       varchar2(10)      ,/* 層級類型 */
debz002       date      ,/* 統計日期 */
debz003       varchar2(10)      ,/* 會計週 */
debz004       varchar2(10)      ,/* 會計期 */
debz005       varchar2(20)      ,/* 專櫃編號 */
debz006       varchar2(10)      ,/* 專櫃類型 */
debz007       varchar2(10)      ,/* 品類編號 */
debz008       varchar2(10)      ,/* 稅別編號 */
debz009       number(20,6)      ,/* 稅額 */
debz010       number(20,6)      ,/* 銷售額 */
debz011       number(20,6)      ,/* 銷售折讓總額 */
debz012       number(20,6)      ,/* 應收金額 */
debz013       number(20,6)      ,/* 銷售收入 */
debz014       varchar2(10)      ,/* 庫區 */
debz015       number(20,6)      ,/* 主帳套立帳數量 */
debz016       number(20,6)      ,/* 次帳套一立帳金額 */
debz017       number(20,6)      ,/* 次帳套二立帳金額 */
debz018       varchar2(10)      ,/* 經營方式 */
debz019       number(20,6)      ,/* 代收銀主帳套立帳金額 */
debz020       number(20,6)      ,/* 代收銀次帳套一立帳金額 */
debz021       number(20,6)      /* 代收銀次帳套二立帳金額 */
);
alter table debz_t add constraint debz_pk primary key (debzent,debzsite,debz002,debz005,debz007,debz008,debz014,debz018) enable validate;

create unique index debz_pk on debz_t (debzent,debzsite,debz002,debz005,debz007,debz008,debz014,debz018);

grant select on debz_t to tiptop;
grant update on debz_t to tiptop;
grant delete on debz_t to tiptop;
grant insert on debz_t to tiptop;

exit;
