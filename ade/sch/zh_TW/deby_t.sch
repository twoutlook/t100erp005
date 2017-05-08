/* 
================================================================================
檔案代號:deby_t
檔案名稱:門店收款日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table deby_t
(
debyent       number(5)      ,/* 企業編號 */
debysite       varchar2(10)      ,/* 營運據點 */
deby001       varchar2(10)      ,/* 款別性質 */
deby002       varchar2(10)      ,/* 款別編號 */
deby003       date      ,/* 統計日期 */
deby004       number(20,6)      ,/* 收款金額 */
deby005       varchar2(40)      ,/* 款別類型對應憑證號 */
deby006       number(20,6)      ,/* 支票面額 */
deby007       date      ,/* 票據到期日 */
deby008       varchar2(15)      ,/* 票據付款銀行 */
deby009       varchar2(1)      ,/* 開客票 */
deby010       varchar2(20)      ,/* 開票人全名 */
deby011       varchar2(10)      ,/* 卡/券種編號 */
deby012       number(20,6)      ,/* 票券溢交金額 */
deby013       varchar2(10)      ,/* 沖預收款類型 */
deby014       number(15,3)      ,/* 抵現積點 */
deby015       varchar2(10)      ,/* 退款類型 */
deby016       number(20,6)      ,/* 主帳套立帳金額 */
deby017       number(20,6)      ,/* 次帳套一立帳金額 */
deby018       number(20,6)      ,/* 次帳套二立帳金額 */
deby019       number(20,6)      ,/* 代收銀主帳套立帳金額 */
deby020       number(20,6)      ,/* 代收銀次帳套一立帳金額 */
deby021       number(20,6)      /* 代收銀次帳套二立帳金額 */
);
alter table deby_t add constraint deby_pk primary key (debyent,debysite,deby002,deby003,deby005,deby011) enable validate;

create unique index deby_pk on deby_t (debyent,debysite,deby002,deby003,deby005,deby011);

grant select on deby_t to tiptop;
grant update on deby_t to tiptop;
grant delete on deby_t to tiptop;
grant insert on deby_t to tiptop;

exit;
