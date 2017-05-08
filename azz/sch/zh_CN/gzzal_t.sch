/* 
================================================================================
檔案代號:gzzal_t
檔案名稱:程序名称多语言记录表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzzal_t
(
gzzal001       varchar2(20)      ,/* 程序编号 */
gzzal002       varchar2(6)      ,/* 语言别 */
gzzal003       varchar2(500)      ,/* 程序名称 */
gzzal004       varchar2(10)      ,/* 助记码 */
gzzal005       varchar2(80)      ,/* 程序简称 */
gzzal006       varchar2(1)      /* 客制 */
);
alter table gzzal_t add constraint gzzal_pk primary key (gzzal001,gzzal002) enable validate;

create unique index gzzal_pk on gzzal_t (gzzal001,gzzal002);

grant select on gzzal_t to tiptop;
grant update on gzzal_t to tiptop;
grant delete on gzzal_t to tiptop;
grant insert on gzzal_t to tiptop;

exit;
