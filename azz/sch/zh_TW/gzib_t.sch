/* 
================================================================================
檔案代號:gzib_t
檔案名稱:自定義查詢-群組明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzib_t
(
gzib001       varchar2(20)      ,/* 查詢單ID */
gzib002       varchar2(20)      ,/* 欄位編號 */
gzib003       number(5,0)      ,/* 順序 */
gzib004       varchar2(1)      ,/* 跳頁 */
gzib005       varchar2(1)      ,/* 群組 */
gzib006       varchar2(1)      ,/* 排序方式 */
gzib007       varchar2(15)      /* 使用資料表別名 */
);
alter table gzib_t add constraint gzib_pk primary key (gzib001,gzib002,gzib007) enable validate;

create unique index gzib_pk on gzib_t (gzib001,gzib002,gzib007);

grant select on gzib_t to tiptop;
grant update on gzib_t to tiptop;
grant delete on gzib_t to tiptop;
grant insert on gzib_t to tiptop;

exit;
