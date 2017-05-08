/* 
================================================================================
檔案代號:gztel_t
檔案名稱:模块流程说明多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table gztel_t
(
gztel001       varchar2(10)      ,/* 流程编号 */
gztel002       varchar2(6)      ,/* 语言别 */
gztel003       varchar2(500)      ,/* 说明 */
gztel004       varchar2(10)      ,/* 助记码 */
gztel005       varchar2(1)      /* 客制 */
);
alter table gztel_t add constraint gztel_pk primary key (gztel001,gztel002) enable validate;

create unique index gztel_pk on gztel_t (gztel001,gztel002);

grant select on gztel_t to tiptop;
grant update on gztel_t to tiptop;
grant delete on gztel_t to tiptop;
grant insert on gztel_t to tiptop;

exit;
