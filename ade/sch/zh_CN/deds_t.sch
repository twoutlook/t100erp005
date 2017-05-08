/* 
================================================================================
檔案代號:deds_t
檔案名稱:門店收款月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table deds_t
(
dedsent       number(5)      ,/* 企業編號 */
dedssite       varchar2(10)      ,/* 營運據點 */
deds001       varchar2(10)      ,/* 款別性質 */
deds002       varchar2(10)      ,/* 款別編號 */
deds004       number(20,6)      ,/* 收款金額 */
deds005       varchar2(40)      ,/* 款別類型對應憑證號 */
deds006       number(20,6)      ,/* 支票面額 */
deds007       date      ,/* 票據到期日 */
deds008       varchar2(15)      ,/* 票據付款銀行 */
deds009       varchar2(1)      ,/* 開客票 */
deds010       varchar2(20)      ,/* 開票人全名 */
deds011       varchar2(10)      ,/* 卡/券種編號 */
deds012       number(20,6)      ,/* 票券溢交金額 */
deds013       varchar2(10)      ,/* 沖預收款類型 */
deds014       number(15,3)      ,/* 抵現積點 */
deds015       varchar2(10)      ,/* 退款類型 */
deds016       number(20,6)      ,/* 主帳套立帳金額 */
deds017       number(20,6)      ,/* 次帳套一立帳金額 */
deds018       number(20,6)      ,/* 次帳套二立帳金額 */
deds019       number(5,0)      ,/* 統計年度 */
deds020       number(5,0)      /* 統計月份 */
);
alter table deds_t add constraint deds_pk primary key (dedsent,dedssite,deds002,deds005,deds007,deds008,deds009,deds010,deds011,deds013,deds015,deds019,deds020) enable validate;

create unique index deds_pk on deds_t (dedsent,dedssite,deds002,deds005,deds007,deds008,deds009,deds010,deds011,deds013,deds015,deds019,deds020);

grant select on deds_t to tiptop;
grant update on deds_t to tiptop;
grant delete on deds_t to tiptop;
grant insert on deds_t to tiptop;

exit;
