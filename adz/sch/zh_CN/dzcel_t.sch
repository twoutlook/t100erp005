/* 
================================================================================
檔案代號:dzcel_t
檔案名稱:校驗帶值參數設計表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dzcel_t
(
dzcel001       varchar2(20)      ,/* 校驗帶值識別碼 */
dzcel002       number(10,0)      ,/* 參數順序 */
dzcel003       varchar2(6)      ,/* 語言別 */
dzcel004       varchar2(500)      ,/* 說明 */
dzcel005       varchar2(10)      /* 助記碼 */
);
alter table dzcel_t add constraint dzcel_pk primary key (dzcel001,dzcel002,dzcel003) enable validate;

create unique index dzcel_pk on dzcel_t (dzcel001,dzcel002,dzcel003);

grant select on dzcel_t to tiptop;
grant update on dzcel_t to tiptop;
grant delete on dzcel_t to tiptop;
grant insert on dzcel_t to tiptop;

exit;
