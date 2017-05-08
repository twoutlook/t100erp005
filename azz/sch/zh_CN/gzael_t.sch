/* 
================================================================================
檔案代號:gzael_t
檔案名稱:單據性質多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzael_t
(
gzael001       varchar2(10)      ,/* 模組編號 */
gzael002       varchar2(10)      ,/* 單據性質 */
gzael003       varchar2(6)      ,/* 語言別 */
gzael004       varchar2(80)      ,/* 說明 */
gzael005       varchar2(10)      /* 助記碼 */
);
alter table gzael_t add constraint gzael_pk primary key (gzael001,gzael002,gzael003) enable validate;

create  index gzael_01 on gzael_t (gzael005);
create unique index gzael_pk on gzael_t (gzael001,gzael002,gzael003);

grant select on gzael_t to tiptop;
grant update on gzael_t to tiptop;
grant delete on gzael_t to tiptop;
grant insert on gzael_t to tiptop;

exit;
