/* 
================================================================================
檔案代號:gzab_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzab_t
(
gzab001       varchar2(10)      ,/* 應用分類 */
gzab002       varchar2(20)      /* 可用程式編號 */
);
alter table gzab_t add constraint gzab_pk primary key (gzab001,gzab002) enable validate;

create  index gzab_01 on gzab_t (gzab002);

grant select on gzab_t to tiptop;
grant update on gzab_t to tiptop;
grant delete on gzab_t to tiptop;
grant insert on gzab_t to tiptop;

exit;
