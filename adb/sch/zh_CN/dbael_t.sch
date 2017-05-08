/* 
================================================================================
檔案代號:dbael_t
檔案名稱:裝載點基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dbael_t
(
dbaelent       number(5)      ,/* 企業編號 */
dbael001       varchar2(10)      ,/* 裝載點編號 */
dbael002       varchar2(6)      ,/* 語言別 */
dbael003       varchar2(500)      ,/* 說明(簡稱) */
dbael004       varchar2(500)      ,/* 說明(全稱) */
dbael005       varchar2(10)      /* 助記碼 */
);
alter table dbael_t add constraint dbael_pk primary key (dbaelent,dbael001,dbael002) enable validate;

create unique index dbael_pk on dbael_t (dbaelent,dbael001,dbael002);

grant select on dbael_t to tiptop;
grant update on dbael_t to tiptop;
grant delete on dbael_t to tiptop;
grant insert on dbael_t to tiptop;

exit;
