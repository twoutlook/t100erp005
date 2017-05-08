/* 
================================================================================
檔案代號:dzre_t
檔案名稱:报表样板多语言纪录档(GR+XtraGrid)备份
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzre_t
(
dzrestus       varchar2(10)      ,/* 状态码 */
dzre000       varchar2(80)      ,/* 报表样板ID */
dzre001       varchar2(40)      ,/* 报表字段编号 */
dzre002       varchar2(6)      ,/* 语言别 */
dzre003       varchar2(500)      ,/* 说明 */
dzreownid       varchar2(20)      ,/* 资料所有者 */
dzreowndp       varchar2(10)      ,/* 资料所有部门 */
dzrecrtid       varchar2(20)      ,/* 资料录入者 */
dzrecrtdp       varchar2(10)      ,/* 资料录入部门 */
dzrecrtdt       timestamp(0)      ,/* 资料创建日 */
dzremodid       varchar2(20)      ,/* 资料更改者 */
dzremoddt       timestamp(0)      ,/* 最近更改日 */
dzre004       varchar2(1)      /* 客制 */
);
alter table dzre_t add constraint dzre_pk primary key (dzre000,dzre001,dzre002) enable validate;

create unique index dzre_pk on dzre_t (dzre000,dzre001,dzre002);

grant select on dzre_t to tiptop;
grant update on dzre_t to tiptop;
grant delete on dzre_t to tiptop;
grant insert on dzre_t to tiptop;

exit;
