/* 
================================================================================
檔案代號:gzjcl_t
檔案名稱:Client服务名称多语言记录表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzjcl_t
(
gzjcl001       varchar2(40)      ,/* WS服务名称 */
gzjcl002       varchar2(6)      ,/* 语言别 */
gzjcl003       varchar2(500)      ,/* 服务名称说明 */
gzjcl004       varchar2(10)      /* 助记码 */
);
alter table gzjcl_t add constraint gzjcl_pk primary key (gzjcl001,gzjcl002) enable validate;

create unique index gzjcl_pk on gzjcl_t (gzjcl001,gzjcl002);

grant select on gzjcl_t to tiptop;
grant update on gzjcl_t to tiptop;
grant delete on gzjcl_t to tiptop;
grant insert on gzjcl_t to tiptop;

exit;
