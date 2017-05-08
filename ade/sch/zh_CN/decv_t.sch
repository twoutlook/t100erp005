/* 
================================================================================
檔案代號:decv_t
檔案名稱:門店收款週結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table decv_t
(
decvent       number(5)      ,/* 企業編號 */
decvsite       varchar2(10)      ,/* 營運據點 */
decv001       varchar2(10)      ,/* 款別性質 */
decv002       varchar2(10)      ,/* 款別編號 */
decv004       number(20,6)      ,/* 收款金額 */
decv005       varchar2(40)      ,/* 款別類型對應憑證號 */
decv006       number(20,6)      ,/* 支票面額 */
decv007       date      ,/* 票據到期日 */
decv008       varchar2(15)      ,/* 票據付款銀行 */
decv009       varchar2(1)      ,/* 開客票 */
decv010       varchar2(20)      ,/* 開票人全名 */
decv011       varchar2(10)      ,/* 卡/券種編號 */
decv012       number(20,6)      ,/* 票券溢交金額 */
decv013       varchar2(10)      ,/* 沖預收款類型 */
decv014       number(15,3)      ,/* 抵現積點 */
decv015       varchar2(10)      ,/* 退款類型 */
decv016       number(20,6)      ,/* 主帳套立帳金額 */
decv017       number(20,6)      ,/* 次帳套一立帳金額 */
decv018       number(20,6)      ,/* 次帳套二立帳金額 */
decv019       number(10,0)      ,/* 統計年度月份 */
decv020       number(5,0)      /* 統計週期 */
);
alter table decv_t add constraint decv_pk primary key (decvent,decvsite,decv002,decv005,decv007,decv008,decv009,decv010,decv011,decv013,decv015,decv019,decv020) enable validate;

create unique index decv_pk on decv_t (decvent,decvsite,decv002,decv005,decv007,decv008,decv009,decv010,decv011,decv013,decv015,decv019,decv020);

grant select on decv_t to tiptop;
grant update on decv_t to tiptop;
grant delete on decv_t to tiptop;
grant insert on decv_t to tiptop;

exit;
