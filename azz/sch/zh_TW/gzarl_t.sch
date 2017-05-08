/* 
================================================================================
檔案代號:gzarl_t
檔案名稱:异常管理节点维护档多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table gzarl_t
(
gzarlent       number(5)      ,/* 企业编号 */
gzarl001       varchar2(10)      ,/* 节点编号 */
gzarl002       varchar2(6)      ,/* 语言别 */
gzarl003       varchar2(500)      ,/* 节点名称 */
gzarl004       varchar2(500)      ,/* 说明 */
gzarl005       varchar2(10)      /* 助记码 */
);
alter table gzarl_t add constraint gzarl_pk primary key (gzarlent,gzarl001,gzarl002) enable validate;

create unique index gzarl_pk on gzarl_t (gzarlent,gzarl001,gzarl002);

grant select on gzarl_t to tiptop;
grant update on gzarl_t to tiptop;
grant delete on gzarl_t to tiptop;
grant insert on gzarl_t to tiptop;

exit;
