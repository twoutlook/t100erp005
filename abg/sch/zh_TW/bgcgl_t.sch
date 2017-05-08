/* 
================================================================================
檔案代號:bgcgl_t
檔案名稱:模拟收入组织对应变量主档多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bgcgl_t
(
bgcglent       number(5)      ,/* 企业编号 */
bgcgl001       varchar2(10)      ,/* 预算编号 */
bgcgl002       varchar2(10)      ,/* 预算组织 */
bgcgl003       varchar2(10)      ,/* 仿真收入项目 */
bgcgl004       varchar2(6)      ,/* 语言别 */
bgcgl005       varchar2(500)      ,/* 说明 */
bgcgl006       varchar2(10)      /* 助记码 */
);
alter table bgcgl_t add constraint bgcgl_pk primary key (bgcglent,bgcgl001,bgcgl002,bgcgl003,bgcgl004) enable validate;

create unique index bgcgl_pk on bgcgl_t (bgcglent,bgcgl001,bgcgl002,bgcgl003,bgcgl004);

grant select on bgcgl_t to tiptop;
grant update on bgcgl_t to tiptop;
grant delete on bgcgl_t to tiptop;
grant insert on bgcgl_t to tiptop;

exit;
