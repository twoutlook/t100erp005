/* 
================================================================================
檔案代號:gzbal_t
檔案名稱:系統流程分類多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzbal_t
(
gzbalent       number(5)      ,/* 企業碼 */
gzbal001       varchar2(40)      ,/* 分類代號 */
gzbal002       varchar2(6)      ,/* 語系 */
gzbal003       varchar2(500)      ,/* 分類說明 */
gzbal004       varchar2(10)      /* 助記碼 */
);
alter table gzbal_t add constraint gzbal_pk primary key (gzbalent,gzbal001,gzbal002) enable validate;

create unique index gzbal_pk on gzbal_t (gzbalent,gzbal001,gzbal002);

grant select on gzbal_t to tiptop;
grant update on gzbal_t to tiptop;
grant delete on gzbal_t to tiptop;
grant insert on gzbal_t to tiptop;

exit;
