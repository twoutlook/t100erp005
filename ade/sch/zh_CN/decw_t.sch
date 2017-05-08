/* 
================================================================================
檔案代號:decw_t
檔案名稱:門店收入週結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table decw_t
(
decwent       number(5)      ,/* 企業編號 */
decwsite       varchar2(10)      ,/* 營運據點 */
decw001       varchar2(10)      ,/* 層級類型 */
decw005       varchar2(20)      ,/* 專櫃編號 */
decw006       varchar2(10)      ,/* 專櫃類型 */
decw007       varchar2(10)      ,/* 品類編號 */
decw008       varchar2(10)      ,/* 稅別編號 */
decw009       number(20,6)      ,/* 稅額 */
decw010       number(20,6)      ,/* 銷售額 */
decw011       number(20,6)      ,/* 銷售折讓總額 */
decw012       number(20,6)      ,/* 應收金額 */
decw013       number(20,6)      ,/* 銷售收入 */
decw014       varchar2(10)      ,/* 庫區 */
decw015       number(20,6)      ,/* 主帳套立帳數量 */
decw016       number(20,6)      ,/* 次帳套一立帳金額 */
decw017       number(20,6)      ,/* 次帳套二立帳金額 */
decw018       varchar2(10)      ,/* 經營方式 */
decw019       number(10,0)      ,/* 統計年度月份 */
decw020       number(5,0)      /* 統計週期 */
);
alter table decw_t add constraint decw_pk primary key (decwent,decwsite,decw005,decw007,decw008,decw014,decw018,decw019,decw020) enable validate;

create unique index decw_pk on decw_t (decwent,decwsite,decw005,decw007,decw008,decw014,decw018,decw019,decw020);

grant select on decw_t to tiptop;
grant update on decw_t to tiptop;
grant delete on decw_t to tiptop;
grant insert on decw_t to tiptop;

exit;
