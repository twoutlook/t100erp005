/* 
================================================================================
檔案代號:gzos_t
檔案名稱:多語言用詞調整暫存表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzos_t
(
gzos001       varchar2(6)      ,/* 調整語言別 */
gzos002       varchar2(500)      ,/* 調整前資料 */
gzos003       varchar2(500)      /* 調整後資料 */
);
alter table gzos_t add constraint gzos_pk primary key (gzos001,gzos002) enable validate;

create unique index gzos_pk on gzos_t (gzos001,gzos002);

grant select on gzos_t to tiptop;
grant update on gzos_t to tiptop;
grant delete on gzos_t to tiptop;
grant insert on gzos_t to tiptop;

exit;
