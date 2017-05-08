/* 
================================================================================
檔案代號:logc_t
檔案名稱:修改歷程記錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table logc_t
(
logc001       varchar2(20)      ,/* 使用者編號 */
logc002       varchar2(20)      ,/* 程式編號 */
logc003       date      ,/* 事件時間 */
logc004       varchar2(80)      ,/* 原有PK */
logc005       varchar2(10)      ,/* 事件營運據點 */
logc006       varchar2(80)      /* 備註 */
);
alter table logc_t add constraint logc_pk primary key (logc001,logc002,logc003) enable validate;


grant select on logc_t to tiptop;
grant update on logc_t to tiptop;
grant delete on logc_t to tiptop;
grant insert on logc_t to tiptop;

exit;
