/* 
================================================================================
檔案代號:dzadl_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table dzadl_t
(
dzadlmodu       varchar2(10)      ,/* 資料修改者 */
dzadldate       date      ,/* 最近修改日 */
dzadloriu       varchar2(10)      ,/* 資料所有者 */
dzadlorid       varchar2(10)      ,/* 資料所有部門 */
dzadluser       varchar2(10)      ,/* 資料建立者 */
dzadldept       varchar2(10)      ,/* 資料建立部門 */
dzadlbuid       date      ,/* 資料創建日 */
dzadlstus       varchar2(1)      ,/* 狀態碼 */
dzadl001       varchar2(20)      ,/* 規格編號 */
dzadl002       number(5)      ,/* 語言別 */
dzadl003       varchar2(60)      ,/* Action識別碼 */
dzadl004       varchar2(80)      ,/* 功能名稱 */
dzadl005       varchar2(500)      /* 功能說明 */
);
alter table dzadl_t add constraint dzadl_pk primary key (dzadl001,dzadl002,dzadl003) enable validate;


grant select on dzadl_t to tiptop;
grant update on dzadl_t to tiptop;
grant delete on dzadl_t to tiptop;
grant insert on dzadl_t to tiptop;

exit;
