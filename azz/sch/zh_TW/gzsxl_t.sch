/* 
================================================================================
檔案代號:gzsxl_t
檔案名稱:参数作业页面设置表多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table gzsxl_t
(
gzsxl001       varchar2(20)      ,/* 设置作业名称 */
gzsxl002       varchar2(80)      ,/* 分页编号 */
gzsxl003       varchar2(80)      ,/* 分项编号 */
gzsxl004       varchar2(6)      ,/* 语言别 */
gzsxl005       varchar2(500)      ,/* 说明 */
gzsxl006       varchar2(1)      /* 客制 */
);
alter table gzsxl_t add constraint gzsxl_pk primary key (gzsxl001,gzsxl002,gzsxl003,gzsxl004) enable validate;

create unique index gzsxl_pk on gzsxl_t (gzsxl001,gzsxl002,gzsxl003,gzsxl004);

grant select on gzsxl_t to tiptop;
grant update on gzsxl_t to tiptop;
grant delete on gzsxl_t to tiptop;
grant insert on gzsxl_t to tiptop;

exit;
