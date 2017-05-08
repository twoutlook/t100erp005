/* 
================================================================================
檔案代號:dzbu_t
檔案名稱:行業對應之標準add point引用清單
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzbu_t
(
dzbu001       varchar2(20)      ,/* 行業程式代號 */
dzbu003       varchar2(60)      ,/* 標準設計點 */
dzbu004       number(10)      /* 標準設計點版次 */
);
alter table dzbu_t add constraint dzbu_pk primary key (dzbu001,dzbu003) enable validate;

create unique index dzbu_pk on dzbu_t (dzbu001,dzbu003);

grant select on dzbu_t to tiptop;
grant update on dzbu_t to tiptop;
grant delete on dzbu_t to tiptop;
grant insert on dzbu_t to tiptop;

exit;
