/* 
================================================================================
檔案代號:gzgdl_t
檔案名稱:报表样板说明多语言档(GR+XtraGrid)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzgdl_t
(
gzgdl000       varchar2(80)      ,/* 报表样板ID */
gzgdl001       varchar2(6)      ,/* 语言别 */
gzgdl002       varchar2(500)      ,/* 样板说明 */
gzgdl003       varchar2(1)      /* 客制 */
);
alter table gzgdl_t add constraint gzgdl_pk primary key (gzgdl000,gzgdl001) enable validate;

create unique index gzgdl_pk on gzgdl_t (gzgdl000,gzgdl001);

grant select on gzgdl_t to tiptop;
grant update on gzgdl_t to tiptop;
grant delete on gzgdl_t to tiptop;
grant insert on gzgdl_t to tiptop;

exit;
