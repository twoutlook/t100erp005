/* 
================================================================================
檔案代號:dzekl_t
檔案名稱:欄位類別定義明細檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dzekl_t
(
dzekl001       varchar2(80)      ,/* 欄位類別定義代號 */
dzekl002       varchar2(80)      ,/* 欄位代號 */
dzekl003       varchar2(6)      ,/* 語言別 */
dzekl004       varchar2(500)      ,/* 說明 */
dzekl005       varchar2(10)      /* 助記碼 */
);
alter table dzekl_t add constraint dzekl_pk primary key (dzekl001,dzekl002,dzekl003) enable validate;

create unique index dzekl_pk on dzekl_t (dzekl001,dzekl002,dzekl003);

grant select on dzekl_t to tiptop;
grant update on dzekl_t to tiptop;
grant delete on dzekl_t to tiptop;
grant insert on dzekl_t to tiptop;

exit;
