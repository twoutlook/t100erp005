/* 
================================================================================
檔案代號:gzgjl_t
檔案名稱:表头说明多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table gzgjl_t
(
gzgjl001       varchar2(10)      ,/* 表头编号 */
gzgjl002       varchar2(6)      ,/* 语言别 */
gzgjl003       varchar2(500)      ,/* 说明 */
gzgjl004       varchar2(1)      /* 客制 */
);
alter table gzgjl_t add constraint gzgjl_pk primary key (gzgjl001,gzgjl002) enable validate;

create unique index gzgjl_pk on gzgjl_t (gzgjl001,gzgjl002);

grant select on gzgjl_t to tiptop;
grant update on gzgjl_t to tiptop;
grant delete on gzgjl_t to tiptop;
grant insert on gzgjl_t to tiptop;

exit;
