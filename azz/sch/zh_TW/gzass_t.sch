/* 
================================================================================
檔案代號:gzass_t
檔案名稱:异常管理检核设置档提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table gzass_t
(
gzassent       number(5)      ,/* 企业编号 */
gzass001       varchar2(10)      ,/* 上层目录编号 */
gzass002       varchar2(10)      ,/* 目录编号 */
gzass003       varchar2(40)      ,/* 提速值 */
gzass004       number(5,0)      /* 阶层 */
);
alter table gzass_t add constraint gzass_pk primary key (gzassent,gzass001,gzass002,gzass003) enable validate;

create unique index gzass_pk on gzass_t (gzassent,gzass001,gzass002,gzass003);

grant select on gzass_t to tiptop;
grant update on gzass_t to tiptop;
grant delete on gzass_t to tiptop;
grant insert on gzass_t to tiptop;

exit;
