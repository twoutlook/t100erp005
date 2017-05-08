/* 
================================================================================
檔案代號:gzasl_t
檔案名稱:异常管理检核设置档多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table gzasl_t
(
gzaslent       number(5)      ,/* 企业编号 */
gzasl002       varchar2(10)      ,/* 目录编号 */
gzasl003       varchar2(6)      ,/* 语言别 */
gzasl004       varchar2(500)      ,/* 说明 */
gzasl005       varchar2(10)      /* 助记码 */
);
alter table gzasl_t add constraint gzasl_pk primary key (gzaslent,gzasl002,gzasl003) enable validate;

create unique index gzasl_pk on gzasl_t (gzaslent,gzasl002,gzasl003);

grant select on gzasl_t to tiptop;
grant update on gzasl_t to tiptop;
grant delete on gzasl_t to tiptop;
grant insert on gzasl_t to tiptop;

exit;
