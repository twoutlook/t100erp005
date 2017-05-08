/* 
================================================================================
檔案代號:gzyl_t
檔案名稱:权限过滤器明细表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzyl_t
(
gzylent       number(5)      ,/* 企业代码 */
gzyl001       varchar2(20)      ,/* 作业编号 */
gzyl002       number(5,0)      ,/* 序号 */
gzyl003       varchar2(1)      ,/* 过滤方式 */
gzyl004       varchar2(80)      ,/* 指定值 */
gzyl005       varchar2(10)      /* 过滤条件编号 */
);
alter table gzyl_t add constraint gzyl_pk primary key (gzylent,gzyl001,gzyl002) enable validate;

create unique index gzyl_pk on gzyl_t (gzylent,gzyl001,gzyl002);

grant select on gzyl_t to tiptop;
grant update on gzyl_t to tiptop;
grant delete on gzyl_t to tiptop;
grant insert on gzyl_t to tiptop;

exit;
