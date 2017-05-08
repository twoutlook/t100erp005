/* 
================================================================================
檔案代號:gzam_t
檔案名稱:开账设置表格数据档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzam_t
(
gzam001       varchar2(15)      ,/* 作业编号 */
gzam002       varchar2(10)      ,/* 格式编号 */
gzam003       varchar2(15)      ,/* 表格编号 */
gzam004       varchar2(15)      ,/* 上层表格编号 */
gzam005       varchar2(500)      ,/* 主键设置 */
gzam006       varchar2(500)      ,/* 键值设置 */
gzam007       varchar2(500)      ,/* 外键设置 */
gzam008       varchar2(1)      /* 不导出，同上表格数据一并新增 */
);
alter table gzam_t add constraint gzam_pk primary key (gzam001,gzam002,gzam003) enable validate;

create unique index gzam_pk on gzam_t (gzam001,gzam002,gzam003);

grant select on gzam_t to tiptop;
grant update on gzam_t to tiptop;
grant delete on gzam_t to tiptop;
grant insert on gzam_t to tiptop;

exit;
