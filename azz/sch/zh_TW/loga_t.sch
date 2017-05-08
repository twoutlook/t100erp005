/* 
================================================================================
檔案代號:loga_t
檔案名稱:用戶程式執行時間記錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table loga_t
(
loga001       varchar2(20)      ,/* 使用者編號 */
loga002       varchar2(20)      ,/* 作業編號 */
loga003       varchar2(20)      ,/* 資料庫編號 */
loga004       varchar2(20)      ,/* 主機位址 */
loga005       varchar2(80)      ,/* 作業進程編號 */
loga006       date      ,/* 啟動時間 */
loga007       date      ,/* 關閉時間 */
loga008       varchar2(80)      ,/* 離開編號 */
loga009       varchar2(10)      ,/* 員工編號 */
loga010       varchar2(20)      ,/* 程式編號 */
loga011       number(5)      ,/* 企業編號 */
loga012       varchar2(10)      /* 營運據點編號 */
);
alter table loga_t add constraint loga_pk primary key (loga001,loga002,loga003,loga004,loga005) enable validate;


grant select on loga_t to tiptop;
grant update on loga_t to tiptop;
grant delete on loga_t to tiptop;
grant insert on loga_t to tiptop;

exit;
