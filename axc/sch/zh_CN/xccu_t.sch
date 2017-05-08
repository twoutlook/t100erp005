/* 
================================================================================
檔案代號:xccu_t
檔案名稱:料件即時數量成本檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xccu_t
(
xccuent       number(5)      ,/* 企業編號 */
xccucomp       varchar2(10)      ,/* 法人組織 */
xcculd       varchar2(5)      ,/* 帳套 */
xccu001       varchar2(1)      ,/* 帳套本位幣順序 */
xccu002       varchar2(30)      ,/* 成本域 */
xccu003       varchar2(10)      ,/* 成本計算類型 */
xccu004       varchar2(40)      ,/* 料號 */
xccu005       varchar2(256)      ,/* 特性碼 */
xccu006       varchar2(30)      ,/* 批號 */
xccu010       varchar2(10)      ,/* 核算幣別 */
xccu101       number(20,6)      ,/* 數量 */
xccu102       number(20,6)      ,/* 成本金額 */
xccu102a       number(20,6)      ,/* 成本金額-材料 */
xccu102b       number(20,6)      ,/* 成本金額-人工 */
xccu102c       number(20,6)      ,/* 成本金額-加工 */
xccu102d       number(20,6)      ,/* 成本金額-製費一 */
xccu102e       number(20,6)      ,/* 成本金額-製費二 */
xccu102f       number(20,6)      ,/* 成本金額-製費三 */
xccu102g       number(20,6)      ,/* 成本金額-製費四 */
xccu102h       number(20,6)      ,/* 成本金額製費五 */
xccu202       number(20,6)      ,/* 單位成本 */
xccu202a       number(20,6)      ,/* 單位成本-材料 */
xccu202b       number(20,6)      ,/* 單位成本-人工 */
xccu202c       number(20,6)      ,/* 單位成本-加工 */
xccu202d       number(20,6)      ,/* 單位成本-製費一 */
xccu202e       number(20,6)      ,/* 單位成本-製費二 */
xccu202f       number(20,6)      ,/* 單位成本-製費三 */
xccu202g       number(20,6)      ,/* 單位成本-製費四 */
xccu202h       number(20,6)      ,/* 單位成本-製費五 */
xccutime       timestamp(0)      /* 最近成本計算時間 */
);
alter table xccu_t add constraint xccu_pk primary key (xccuent,xcculd,xccu001,xccu002,xccu003,xccu004,xccu005,xccu006) enable validate;

create  index xccu_n01 on xccu_t (xccuent,xccu004,xccu005,xccu006);
create unique index xccu_pk on xccu_t (xccuent,xcculd,xccu001,xccu002,xccu003,xccu004,xccu005,xccu006);

grant select on xccu_t to tiptop;
grant update on xccu_t to tiptop;
grant delete on xccu_t to tiptop;
grant insert on xccu_t to tiptop;

exit;
