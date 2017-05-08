/* 
================================================================================
檔案代號:gzswl_t
檔案名稱:参数作业页面多语言表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzswl_t
(
gzswl001       varchar2(20)      ,/* 设置作业名称 */
gzswl002       varchar2(80)      ,/* 分页编号 */
gzswl003       varchar2(6)      ,/* 语言别 */
gzswl004       varchar2(500)      ,/* 说明 */
gzswl005       varchar2(1)      /* 客制 */
);
alter table gzswl_t add constraint gzswl_pk primary key (gzswl001,gzswl002,gzswl003) enable validate;

create unique index gzswl_pk on gzswl_t (gzswl001,gzswl002,gzswl003);

grant select on gzswl_t to tiptop;
grant update on gzswl_t to tiptop;
grant delete on gzswl_t to tiptop;
grant insert on gzswl_t to tiptop;

exit;
