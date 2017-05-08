/* 
================================================================================
檔案代號:dzcdl_t
檔案名稱:校驗帶值設計表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dzcdl_t
(
dzcdl001       varchar2(20)      ,/* 校驗帶值識別碼 */
dzcdl002       varchar2(6)      ,/* 語言別 */
dzcdl003       varchar2(500)      ,/* 說明 */
dzcdl004       varchar2(10)      /* 助記碼 */
);
alter table dzcdl_t add constraint dzcdl_pk primary key (dzcdl001,dzcdl002) enable validate;

create unique index dzcdl_pk on dzcdl_t (dzcdl001,dzcdl002);

grant select on dzcdl_t to tiptop;
grant update on dzcdl_t to tiptop;
grant delete on dzcdl_t to tiptop;
grant insert on dzcdl_t to tiptop;

exit;
