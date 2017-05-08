/* 
================================================================================
檔案代號:logz_t
檔案名稱:系統數據依時紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table logz_t
(
logz001       date      ,/* 紀錄時間 */
logz002       number(5,0)      ,/* 系統模組數 */
logz003       number(5,0)      ,/* 登記主程式數 */
logz004       number(5,0)      ,/* 有效主程式數 */
logz005       number(5,0)      ,/* Free Style程式支數 */
logz006       number(5,0)      ,/* 登記子程式數 */
logz007       number(5,0)      ,/* 有效子程式數 */
logz008       number(5,0)      ,/* 註冊作業數 */
logz009       number(5,0)      ,/* 有效作業數 */
logz010       number(5,0)      /* 實際開表數(ds) */
);
alter table logz_t add constraint logz_pk primary key (logz001) enable validate;


grant select on logz_t to tiptop;
grant update on logz_t to tiptop;
grant delete on logz_t to tiptop;
grant insert on logz_t to tiptop;

exit;
