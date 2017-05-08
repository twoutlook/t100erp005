/* 
================================================================================
檔案代號:gzyn_t
檔案名稱:权限过滤器条件设置单身表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzyn_t
(
gzynent       number(5)      ,/* 企业代码 */
gzyn001       varchar2(20)      ,/* 作业编号 */
gzyn002       varchar2(10)      ,/* 过滤条件编号 */
gzyn003       number(5,0)      ,/* 序号 */
gzyn004       varchar2(20)      ,/* 过滤字段 */
gzyn005       varchar2(10)      ,/* SQL运算符 */
gzyn006       varchar2(100)      ,/* 指定比较值 */
gzyn007       varchar2(10)      /* AND/OR */
);
alter table gzyn_t add constraint gzyn_pk primary key (gzynent,gzyn001,gzyn002,gzyn003) enable validate;

create unique index gzyn_pk on gzyn_t (gzynent,gzyn001,gzyn002,gzyn003);

grant select on gzyn_t to tiptop;
grant update on gzyn_t to tiptop;
grant delete on gzyn_t to tiptop;
grant insert on gzyn_t to tiptop;

exit;
