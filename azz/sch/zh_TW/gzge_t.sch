/* 
================================================================================
檔案代號:gzge_t
檔案名稱:报表样板多语言纪录档(GR+XtraGrid)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzge_t
(
gzgestus       varchar2(10)      ,/* 状态码 */
gzge000       varchar2(80)      ,/* 报表样板ID */
gzge001       varchar2(40)      ,/* 报表字段编号 */
gzge002       varchar2(6)      ,/* 语言别 */
gzge003       varchar2(500)      ,/* 说明 */
gzgeownid       varchar2(20)      ,/* 资料所有者 */
gzgeowndp       varchar2(10)      ,/* 资料所有部门 */
gzgecrtid       varchar2(20)      ,/* 资料录入者 */
gzgecrtdp       varchar2(10)      ,/* 资料录入部门 */
gzgecrtdt       timestamp(0)      ,/* 资料创建日 */
gzgemodid       varchar2(20)      ,/* 资料更改者 */
gzgemoddt       timestamp(0)      ,/* 最近更改日 */
gzge004       varchar2(1)      /* 客制 */
);
alter table gzge_t add constraint gzge_pk primary key (gzge000,gzge001,gzge002) enable validate;

create unique index gzge_pk on gzge_t (gzge000,gzge001,gzge002);

grant select on gzge_t to tiptop;
grant update on gzge_t to tiptop;
grant delete on gzge_t to tiptop;
grant insert on gzge_t to tiptop;

exit;
