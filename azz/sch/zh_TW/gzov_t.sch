/* 
================================================================================
檔案代號:gzov_t
檔案名稱:送翻翻回暫存表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzov_t
(
gzov001       varchar2(10)      ,/* 訊息編號 */
gzov002       varchar2(500)      ,/* 基礎語系資料 */
gzov003       varchar2(500)      /* 匯入語系資料 */
);
alter table gzov_t add constraint gzov_pk primary key (gzov001) enable validate;

create unique index gzov_pk on gzov_t (gzov001);

grant select on gzov_t to tiptop;
grant update on gzov_t to tiptop;
grant delete on gzov_t to tiptop;
grant insert on gzov_t to tiptop;

exit;
