/* 
================================================================================
檔案代號:gzym_t
檔案名稱:权限过滤器条件设置表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzym_t
(
gzyment       number(5)      ,/* 企业代码 */
gzymownid       varchar2(20)      ,/* 资料所有者 */
gzymowndp       varchar2(10)      ,/* 资料所有部门 */
gzymcrtid       varchar2(20)      ,/* 资料录入者 */
gzymcrtdp       varchar2(10)      ,/* 资料录入部门 */
gzymcrtdt       timestamp(0)      ,/* 资料创建日 */
gzymmodid       varchar2(20)      ,/* 资料更改者 */
gzymmoddt       timestamp(0)      ,/* 最近更改日 */
gzymstus       varchar2(10)      ,/* 状态码 */
gzym001       varchar2(20)      ,/* 作业编号 */
gzym002       varchar2(10)      ,/* 过滤条件编号 */
gzym003       varchar2(80)      ,/* 说明 */
gzym004       varchar2(1)      ,/* AND/OR */
gzym005       varchar2(500)      ,/* 特殊条件 */
gzym006       varchar2(500)      /* 最终组合条件 */
);
alter table gzym_t add constraint gzym_pk primary key (gzyment,gzym001,gzym002) enable validate;

create unique index gzym_pk on gzym_t (gzyment,gzym001,gzym002);

grant select on gzym_t to tiptop;
grant update on gzym_t to tiptop;
grant delete on gzym_t to tiptop;
grant insert on gzym_t to tiptop;

exit;
