/* 
================================================================================
檔案代號:gzbas_t
檔案名稱:系統流程分類提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table gzbas_t
(
gzbas001       varchar2(40)      ,/* 分類代號 */
gzbas002       varchar2(40)      /* 上層分類代號 */
);
alter table gzbas_t add constraint gzbas_pk primary key (gzbas001,gzbas002) enable validate;

create unique index gzbas_pk on gzbas_t (gzbas001,gzbas002);

grant select on gzbas_t to tiptop;
grant update on gzbas_t to tiptop;
grant delete on gzbas_t to tiptop;
grant insert on gzbas_t to tiptop;

exit;
