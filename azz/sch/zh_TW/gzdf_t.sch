/* 
================================================================================
檔案代號:gzdf_t
檔案名稱:子程式附子畫面明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzdf_t
(
gzdf001       varchar2(20)      ,/* 規格編號 */
gzdf002       varchar2(20)      ,/* 子畫面規格編號 */
gzdf003       varchar2(1)      /* 客製 */
);
alter table gzdf_t add constraint gzdf_pk primary key (gzdf001,gzdf002) enable validate;

create unique index gzdf_pk on gzdf_t (gzdf001,gzdf002);

grant select on gzdf_t to tiptop;
grant update on gzdf_t to tiptop;
grant delete on gzdf_t to tiptop;
grant insert on gzdf_t to tiptop;

exit;
