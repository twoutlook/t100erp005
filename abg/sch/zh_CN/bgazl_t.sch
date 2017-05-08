/* 
================================================================================
檔案代號:bgazl_t
檔案名稱:预算维护档多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bgazl_t
(
bgazlent       number(5)      ,/* 企业编号 */
bgazl001       varchar2(10)      ,/* 预算编号 */
bgazl002       varchar2(10)      ,/* 预算版本 */
bgazl003       varchar2(10)      ,/* 预算组织 */
bgazl004       varchar2(24)      ,/* 预算细项 */
bgazl005       varchar2(10)      ,/* 项次 */
bgazl006       varchar2(6)      ,/* 语言别 */
bgazl007       varchar2(500)      ,/* 说明 */
bgazl008       varchar2(10)      /* 助记码 */
);
alter table bgazl_t add constraint bgazl_pk primary key (bgazlent,bgazl001,bgazl002,bgazl003,bgazl004,bgazl005,bgazl006) enable validate;

create unique index bgazl_pk on bgazl_t (bgazlent,bgazl001,bgazl002,bgazl003,bgazl004,bgazl005,bgazl006);

grant select on bgazl_t to tiptop;
grant update on bgazl_t to tiptop;
grant delete on bgazl_t to tiptop;
grant insert on bgazl_t to tiptop;

exit;
