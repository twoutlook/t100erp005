/* 
================================================================================
檔案代號:dzza_t
檔案名稱:T100版次對應日期資訊檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzza_t
(
dzza001       number(10,0)      ,/* 項次 */
dzza002       varchar2(40)      ,/* T100版次代碼 */
dzza003       date      ,/* 起始時間 */
dzza004       date      ,/* 結束時間 */
dzza005       varchar2(500)      /* 備註 */
);
alter table dzza_t add constraint dzza_pk primary key (dzza001) enable validate;

create unique index dzza_pk on dzza_t (dzza001);

grant select on dzza_t to tiptop;
grant update on dzza_t to tiptop;
grant delete on dzza_t to tiptop;
grant insert on dzza_t to tiptop;

exit;
