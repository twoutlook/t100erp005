/* 
================================================================================
檔案代號:gzyk_t
檔案名稱:权限过滤工具表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table gzyk_t
(
gzykent       number(5)      ,/* 企业代码 */
gzykownid       varchar2(20)      ,/* 资料所有者 */
gzykowndp       varchar2(10)      ,/* 资料所有部门 */
gzykcrtid       varchar2(20)      ,/* 资料录入者 */
gzykcrtdp       varchar2(10)      ,/* 资料录入部门 */
gzykcrtdt       timestamp(0)      ,/* 资料创建日 */
gzykmodid       varchar2(20)      ,/* 资料更改者 */
gzykmoddt       timestamp(0)      ,/* 最近更改日 */
gzykcnfid       varchar2(20)      ,/* 资料审核者 */
gzykcnfdt       timestamp(0)      ,/* 数据审核日 */
gzykstus       varchar2(10)      ,/* 状态码 */
gzyk001       varchar2(20)      ,/* 作业编号 */
gzyk002       varchar2(15)      ,/* 对应主表 */
gzyk003       varchar2(1)      ,/* 条件AND/OR */
gzyk004       varchar2(500)      ,/* 合并条件 */
gzyk005       varchar2(1)      /* no use */
);
alter table gzyk_t add constraint gzyk_pk primary key (gzykent,gzyk001) enable validate;

create unique index gzyk_pk on gzyk_t (gzykent,gzyk001);

grant select on gzyk_t to tiptop;
grant update on gzyk_t to tiptop;
grant delete on gzyk_t to tiptop;
grant insert on gzyk_t to tiptop;

exit;
