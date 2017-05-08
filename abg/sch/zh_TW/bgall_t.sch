/* 
================================================================================
檔案代號:bgall_t
檔案名稱:预算项目维护档多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bgall_t
(
bgallent       number(5)      ,/* 企业编号 */
bgall001       varchar2(10)      ,/* 预算编号 */
bgall002       varchar2(10)      ,/* 预算组织 */
bgall003       varchar2(24)      ,/* 可用预算细项 */
bgall004       varchar2(6)      ,/* 语言别 */
bgall005       varchar2(500)      ,/* 说明 */
bgall006       varchar2(10)      /* 助记码 */
);
alter table bgall_t add constraint bgall_pk primary key (bgallent,bgall001,bgall002,bgall003,bgall004) enable validate;

create unique index bgall_pk on bgall_t (bgallent,bgall001,bgall002,bgall003,bgall004);

grant select on bgall_t to tiptop;
grant update on bgall_t to tiptop;
grant delete on bgall_t to tiptop;
grant insert on bgall_t to tiptop;

exit;
