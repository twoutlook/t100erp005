/* 
================================================================================
檔案代號:xcdu_t
檔案名稱:料件即時數量成本次要素檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcdu_t
(
xcduent       number(5)      ,/* 企業編號 */
xcducomp       varchar2(10)      ,/* 法人組織 */
xcduld       varchar2(5)      ,/* 帳套 */
xcdu001       varchar2(1)      ,/* 帳套本位幣順序 */
xcdu002       varchar2(30)      ,/* 成本域 */
xcdu003       varchar2(10)      ,/* 成本計算類型 */
xcdu004       varchar2(40)      ,/* 料號 */
xcdu005       varchar2(256)      ,/* 特性碼 */
xcdu006       varchar2(30)      ,/* 批號 */
xcdu007       varchar2(10)      ,/* 次要素 */
xcdu010       varchar2(10)      ,/* 核算幣別 */
xcdu101       number(20,6)      ,/* 數量 */
xcdu102       number(20,6)      ,/* 成本金額 */
xcdu202       number(20,6)      ,/* 單位成本 */
xcdutime       timestamp(0)      /* 最近成本計算時間 */
);
alter table xcdu_t add constraint xcdu_pk primary key (xcduent,xcduld,xcdu001,xcdu002,xcdu003,xcdu004,xcdu005,xcdu006,xcdu007) enable validate;

create unique index xcdu_pk on xcdu_t (xcduent,xcduld,xcdu001,xcdu002,xcdu003,xcdu004,xcdu005,xcdu006,xcdu007);

grant select on xcdu_t to tiptop;
grant update on xcdu_t to tiptop;
grant delete on xcdu_t to tiptop;
grant insert on xcdu_t to tiptop;

exit;
