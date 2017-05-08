/* 
================================================================================
檔案代號:gzszl_t
檔案名稱:參數設定主表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzszl_t
(
gzszl001       varchar2(15)      ,/* 表格編號 */
gzszl002       varchar2(10)      ,/* 資料序號 */
gzszl003       varchar2(6)      ,/* 語言別 */
gzszl004       varchar2(500)      ,/* 說明 */
gzszl005       varchar2(500)      ,/* 使用說明 */
gzszl006       varchar2(500)      ,/* 應用建議 */
gzszl007       varchar2(500)      /* 個案應用說明 */
);
alter table gzszl_t add constraint gzszl_pk primary key (gzszl001,gzszl002,gzszl003) enable validate;

create unique index gzszl_pk on gzszl_t (gzszl001,gzszl002,gzszl003);

grant select on gzszl_t to tiptop;
grant update on gzszl_t to tiptop;
grant delete on gzszl_t to tiptop;
grant insert on gzszl_t to tiptop;

exit;
