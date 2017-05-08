/* 
================================================================================
檔案代號:logr_t
檔案名稱:Rebuild重建歷程紀錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table logr_t
(
logr001       varchar2(10)      ,/* 建置ID */
logr002       varchar2(1)      ,/* 建置項目 C, L ,F */
logr003       varchar2(10)      ,/* 建置模組 */
logr004       number(10,0)      ,/* 建置序號 */
logr005       varchar2(4000)      ,/* 錯誤訊息 */
logr006       varchar2(1)      ,/* 是否完成處理 */
logr007       varchar2(40)      ,/* 編譯日期 */
logr008       varchar2(20)      /* 程式代碼 */
);
alter table logr_t add constraint logr_pk primary key (logr001,logr002,logr003,logr004) enable validate;


grant select on logr_t to tiptop;
grant update on logr_t to tiptop;
grant delete on logr_t to tiptop;
grant insert on logr_t to tiptop;

exit;
