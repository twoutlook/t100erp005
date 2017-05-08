/* 
================================================================================
檔案代號:logb_t
檔案名稱:用戶觸發動作時間記錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table logb_t
(
logb001       varchar2(20)      ,/* 使用者編號 */
logb002       varchar2(20)      ,/* 作業編號 */
logb003       varchar2(20)      ,/* 資料庫編號 */
logb004       varchar2(20)      ,/* 主機位址 */
logb005       varchar2(80)      ,/* 作業進程編號 */
logb006       varchar2(80)      ,/* 功能編號 */
logb007       date      ,/* 啟動時間 */
logb008       varchar2(1)      ,/* 成功或失敗狀態 */
logb009       varchar2(10)      /* Fraction(5) */
);
alter table logb_t add constraint logb_pk primary key (logb001,logb002,logb003,logb004,logb005,logb007,logb009) enable validate;


grant select on logb_t to tiptop;
grant update on logb_t to tiptop;
grant delete on logb_t to tiptop;
grant insert on logb_t to tiptop;

exit;
