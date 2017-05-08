/* 
================================================================================
檔案代號:gzhal_t
檔案名稱:GWC布景名称多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzhal_t
(
gzhal001       varchar2(40)      ,/* 布景编号 */
gzhal002       varchar2(6)      ,/* 语言别 */
gzhal003       varchar2(500)      ,/* 布景名称 */
gzhal004       varchar2(1)      /* 客制 */
);
alter table gzhal_t add constraint gzhal_pk primary key (gzhal001,gzhal002) enable validate;

create unique index gzhal_pk on gzhal_t (gzhal001,gzhal002);

grant select on gzhal_t to tiptop;
grant update on gzhal_t to tiptop;
grant delete on gzhal_t to tiptop;
grant insert on gzhal_t to tiptop;

exit;
