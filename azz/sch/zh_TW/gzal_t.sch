/* 
================================================================================
檔案代號:gzal_t
檔案名稱:开账设置作业数据档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzal_t
(
gzal001       varchar2(15)      ,/* 作业编号 */
gzal002       varchar2(10)      ,/* 格式编号 */
gzal003       number(10,0)      ,/* 允许错误笔数 */
gzal004       varchar2(20)      ,/* 最后导入者 */
gzal005       timestamp(0)      ,/* 最后导入日期 */
gzal006       number(10,0)      /* 导入笔数 */
);
alter table gzal_t add constraint gzal_pk primary key (gzal001,gzal002) enable validate;

create unique index gzal_pk on gzal_t (gzal001,gzal002);

grant select on gzal_t to tiptop;
grant update on gzal_t to tiptop;
grant delete on gzal_t to tiptop;
grant insert on gzal_t to tiptop;

exit;
