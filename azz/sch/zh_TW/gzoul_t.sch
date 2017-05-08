/* 
================================================================================
檔案代號:gzoul_t
檔案名稱:企業編號多語言紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzoul_t
(
gzoul001       number(5)      ,/* 企業編號 */
gzoul002       varchar2(6)      ,/* 語言別 */
gzoul003       varchar2(80)      ,/* 企業編號說明 */
gzoul004       varchar2(10)      /* 助記碼 */
);
alter table gzoul_t add constraint gzoul_pk primary key (gzoul001,gzoul002) enable validate;

create unique index gzoul_pk on gzoul_t (gzoul001,gzoul002);

grant select on gzoul_t to tiptop;
grant update on gzoul_t to tiptop;
grant delete on gzoul_t to tiptop;
grant insert on gzoul_t to tiptop;

exit;
