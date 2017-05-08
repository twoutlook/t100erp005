/* 
================================================================================
檔案代號:gzaal_t
檔案名稱:應用分類多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzaal_t
(
gzaal001       number(5)      ,/* 應用分類 */
gzaal002       varchar2(6)      ,/* 語言別 */
gzaal003       varchar2(500)      ,/* 說明 */
gzaal004       varchar2(10)      /* 助記碼 */
);
alter table gzaal_t add constraint gzaal_pk primary key (gzaal001,gzaal002) enable validate;

create  index gzaal_01 on gzaal_t (gzaal004);
create unique index gzaal_pk on gzaal_t (gzaal001,gzaal002);

grant select on gzaal_t to tiptop;
grant update on gzaal_t to tiptop;
grant delete on gzaal_t to tiptop;
grant insert on gzaal_t to tiptop;

exit;
