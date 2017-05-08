/* 
================================================================================
檔案代號:bcbal_t
檔案名稱:条码规则主档多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bcbal_t
(
bcbalent       number(5)      ,/* 企业代码 */
bcbal001       varchar2(10)      ,/* 编码规则编号 */
bcbal002       varchar2(6)      ,/* 语言别 */
bcbal003       varchar2(500)      ,/* 说明 */
bcbal004       varchar2(10)      /* 助记码 */
);
alter table bcbal_t add constraint bcbal_pk primary key (bcbalent,bcbal001,bcbal002) enable validate;

create unique index bcbal_pk on bcbal_t (bcbalent,bcbal001,bcbal002);

grant select on bcbal_t to tiptop;
grant update on bcbal_t to tiptop;
grant delete on bcbal_t to tiptop;
grant insert on bcbal_t to tiptop;

exit;
