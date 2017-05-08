/* 
================================================================================
檔案代號:dzcchl_t
檔案名稱:cch test多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dzcchl_t
(
dzcchl001       clob      ,/* 111 */
dzcchl002       blob      ,/* 222 */
dzcchl003       varchar2(6)      ,/* 語言別 */
dzcchl004       varchar2(500)      ,/* 說明 */
dzcchl005       varchar2(10)      /* 助記碼 */
);
alter table dzcchl_t add constraint dzcchl_pk primary key (dzcchl001,dzcchl002,dzcchl003) enable validate;


grant select on dzcchl_t to tiptop;
grant update on dzcchl_t to tiptop;
grant delete on dzcchl_t to tiptop;
grant insert on dzcchl_t to tiptop;

exit;
