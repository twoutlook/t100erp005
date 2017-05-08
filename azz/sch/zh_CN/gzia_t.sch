/* 
================================================================================
檔案代號:gzia_t
檔案名稱:自定义查询单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzia_t
(
gziastus       varchar2(10)      ,/* 状态码 */
gzia001       varchar2(20)      ,/* 查询单ID */
gzia002       varchar2(1)      ,/* 查询报表时是否需录入查询条件 */
gzia003       varchar2(1)      ,/* 客制码 */
gzia004       varchar2(1)      ,/* 是否提供高端查询选项 */
gzia005       number(10,0)      ,/* 最大查询笔数 */
gzia006       varchar2(4000)      ,/* SQL指令 */
gziaownid       varchar2(20)      ,/* 资料所有者 */
gziaowndp       varchar2(10)      ,/* 资料所有部门 */
gziacrtid       varchar2(20)      ,/* 资料录入者 */
gziacrtdp       varchar2(10)      ,/* 资料录入部门 */
gziacrtdt       timestamp(0)      ,/* 资料创建日 */
gziamodid       varchar2(20)      ,/* 资料更改者 */
gziamoddt       timestamp(0)      /* 最近更改日 */
);
alter table gzia_t add constraint gzia_pk primary key (gzia001) enable validate;

create unique index gzia_pk on gzia_t (gzia001);

grant select on gzia_t to tiptop;
grant update on gzia_t to tiptop;
grant delete on gzia_t to tiptop;
grant insert on gzia_t to tiptop;

exit;
