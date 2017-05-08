/* 
================================================================================
檔案代號:xccr_t
檔案名稱:料件即時數量成本檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xccr_t
(
xccrent       number(5)      ,/* 企業編號 */
xccrcomp       varchar2(10)      ,/* 法人組織 */
xccrld       varchar2(5)      ,/* 帳套 */
xccr001       varchar2(1)      ,/* 帳套本位幣順序 */
xccr002       varchar2(30)      ,/* 成本域 */
xccr003       varchar2(10)      ,/* 成本計算類型 */
xccr004       varchar2(40)      ,/* 料號 */
xccr005       varchar2(256)      ,/* 特性碼 */
xccr006       varchar2(30)      ,/* 批號 */
xccr010       varchar2(10)      ,/* 核算幣別 */
xccr101       number(20,6)      ,/* 數量 */
xccr102       number(20,6)      ,/* 成本金額 */
xccr102a       number(20,6)      ,/* 成本金額-材料 */
xccr102b       number(20,6)      ,/* 成本金額-人工 */
xccr102c       number(20,6)      ,/* 成本金額-加工 */
xccr102d       number(20,6)      ,/* 成本金額-製費一 */
xccr102e       number(20,6)      ,/* 成本金額-製費二 */
xccr102f       number(20,6)      ,/* 成本金額-製費三 */
xccr102g       number(20,6)      ,/* 成本金額-製費四 */
xccr102h       number(20,6)      ,/* 成本金額製費五 */
xccr202       number(20,6)      ,/* 單位成本 */
xccr202a       number(20,6)      ,/* 單位成本-材料 */
xccr202b       number(20,6)      ,/* 單位成本-人工 */
xccr202c       number(20,6)      ,/* 單位成本-加工 */
xccr202d       number(20,6)      ,/* 單位成本-製費一 */
xccr202e       number(20,6)      ,/* 單位成本-製費二 */
xccr202f       number(20,6)      ,/* 單位成本-製費三 */
xccr202g       number(20,6)      ,/* 單位成本-製費四 */
xccr202h       number(20,6)      ,/* 單位成本-製費五 */
xccrtime       timestamp(0)      /* 最近成本計算時間 */
);
alter table xccr_t add constraint xccr_pk primary key (xccrent,xccrld,xccr001,xccr002,xccr003,xccr004,xccr005,xccr006) enable validate;

create unique index xccr_pk on xccr_t (xccrent,xccrld,xccr001,xccr002,xccr003,xccr004,xccr005,xccr006);

grant select on xccr_t to tiptop;
grant update on xccr_t to tiptop;
grant delete on xccr_t to tiptop;
grant insert on xccr_t to tiptop;

exit;
