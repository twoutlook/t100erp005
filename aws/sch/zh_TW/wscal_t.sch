/* 
================================================================================
檔案代號:wscal_t
檔案名稱:ETL Job設定多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table wscal_t
(
wscal001       varchar2(20)      ,/* 作業代碼 */
wscal007       number(10,0)      ,/* 序號 */
wscal008       varchar2(6)      ,/* 語言別 */
wscal009       varchar2(500)      ,/* 說明 */
wscal010       varchar2(10)      /* 助記碼 */
);
alter table wscal_t add constraint wscal_pk primary key (wscal001,wscal007,wscal008) enable validate;

create unique index wscal_pk on wscal_t (wscal001,wscal007,wscal008);

grant select on wscal_t to tiptop;
grant update on wscal_t to tiptop;
grant delete on wscal_t to tiptop;
grant insert on wscal_t to tiptop;

exit;
