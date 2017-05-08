/* 
================================================================================
檔案代號:gzor_t
檔案名稱:自定数据语系纪录表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzor_t
(
gzorcrtid       varchar2(20)      ,/* 资料录入者 */
gzorcrtdp       varchar2(10)      ,/* 资料录入部门 */
gzorcrtdt       timestamp(0)      ,/* 资料创建日 */
gzormodid       varchar2(20)      ,/* 资料更改者 */
gzormoddt       timestamp(0)      ,/* 最近更改日 */
gzorstus       varchar2(10)      ,/* 状态码 */
gzor001       varchar2(6)      ,/* 语系编号 */
gzor002       varchar2(80)      ,/* 语系名称 */
gzor003       varchar2(6)      ,/* 语言包编号 */
gzor004       varchar2(80)      /* 原语言名称 */
);
alter table gzor_t add constraint gzor_pk primary key (gzor001) enable validate;

create unique index gzor_pk on gzor_t (gzor001);

grant select on gzor_t to tiptop;
grant update on gzor_t to tiptop;
grant delete on gzor_t to tiptop;
grant insert on gzor_t to tiptop;

exit;
