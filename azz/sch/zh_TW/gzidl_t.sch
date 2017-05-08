/* 
================================================================================
檔案代號:gzidl_t
檔案名稱:自定义查询-QBE字段明细档多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table gzidl_t
(
gzidl001       varchar2(20)      ,/* 查询单ID */
gzidl002       number(5,0)      ,/* 序号 */
gzidl003       varchar2(6)      ,/* 语言别 */
gzidl004       varchar2(500)      ,/* 说明 */
gzidl005       varchar2(10)      ,/* 助记码 */
gzidl006       varchar2(1)      /* 客制 */
);
alter table gzidl_t add constraint gzidl_pk primary key (gzidl001,gzidl002,gzidl003) enable validate;

create unique index gzidl_pk on gzidl_t (gzidl001,gzidl002,gzidl003);

grant select on gzidl_t to tiptop;
grant update on gzidl_t to tiptop;
grant delete on gzidl_t to tiptop;
grant insert on gzidl_t to tiptop;

exit;
