/* 
================================================================================
檔案代號:dedt_t
檔案名稱:門店收入月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dedt_t
(
dedtent       number(5)      ,/* 企業編號 */
dedtsite       varchar2(10)      ,/* 營運據點 */
dedt001       varchar2(10)      ,/* 層級類型 */
dedt005       varchar2(20)      ,/* 專櫃編號 */
dedt006       varchar2(10)      ,/* 專櫃類型 */
dedt007       varchar2(10)      ,/* 品類編號 */
dedt008       varchar2(10)      ,/* 稅別編號 */
dedt009       number(20,6)      ,/* 稅額 */
dedt010       number(20,6)      ,/* 銷售額 */
dedt011       number(20,6)      ,/* 銷售折讓總額 */
dedt012       number(20,6)      ,/* 應收金額 */
dedt013       number(20,6)      ,/* 銷售收入 */
dedt014       varchar2(10)      ,/* 庫區 */
dedt015       number(20,6)      ,/* 主帳套立帳數量 */
dedt016       number(20,6)      ,/* 次帳套一立帳金額 */
dedt017       number(20,6)      ,/* 次帳套二立帳金額 */
dedt018       varchar2(10)      ,/* 經營方式 */
dedt019       number(5,0)      ,/* 統計年度 */
dedt020       number(5,0)      /* 統計月份 */
);
alter table dedt_t add constraint dedt_pk primary key (dedtent,dedtsite,dedt005,dedt007,dedt008,dedt014,dedt018,dedt019,dedt020) enable validate;

create unique index dedt_pk on dedt_t (dedtent,dedtsite,dedt005,dedt007,dedt008,dedt014,dedt018,dedt019,dedt020);

grant select on dedt_t to tiptop;
grant update on dedt_t to tiptop;
grant delete on dedt_t to tiptop;
grant insert on dedt_t to tiptop;

exit;
