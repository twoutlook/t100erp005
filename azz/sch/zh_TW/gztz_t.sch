/* 
================================================================================
檔案代號:gztz_t
檔案名稱:資料庫表及欄位結構檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gztz_t
(
gztz001       varchar2(20)      ,/* 表格編號 */
gztz002       varchar2(20)      ,/* 欄位編號 */
gztz003       number(5,0)      ,/* 欄位型態 */
gztz004       number(5,0)      ,/* 欄位長度 */
gztz005       number(5,0)      /* 欄位序號 */
);
alter table gztz_t add constraint gztz_pk primary key (gztz001,gztz002) enable validate;

create unique index gztz_pk on gztz_t (gztz001,gztz002);

grant select on gztz_t to tiptop;
grant update on gztz_t to tiptop;
grant delete on gztz_t to tiptop;
grant insert on gztz_t to tiptop;

exit;
