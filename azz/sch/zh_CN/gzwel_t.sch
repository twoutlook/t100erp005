/* 
================================================================================
檔案代號:gzwel_t
檔案名稱:菜单设置多语言表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table gzwel_t
(
gzwel001       varchar2(20)      ,/* 菜单编号 */
gzwel002       varchar2(6)      ,/* 语言别 */
gzwel003       varchar2(500)      ,/* 菜单名称 */
gzwelent       number(5)      ,/* 企业编号 */
gzwel004       varchar2(1)      /* 客制 */
);
alter table gzwel_t add constraint gzwel_pk primary key (gzwel001,gzwel002,gzwelent) enable validate;

create unique index gzwel_pk on gzwel_t (gzwel001,gzwel002,gzwelent);

grant select on gzwel_t to tiptop;
grant update on gzwel_t to tiptop;
grant delete on gzwel_t to tiptop;
grant insert on gzwel_t to tiptop;

exit;
