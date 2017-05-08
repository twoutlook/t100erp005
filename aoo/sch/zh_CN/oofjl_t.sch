/* 
================================================================================
檔案代號:oofjl_t
檔案名稱:編碼轉換單頭多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table oofjl_t
(
oofjlent       number(5)      ,/* 企業編號 */
oofjl001       varchar2(10)      ,/* 轉換表號 */
oofjl002       varchar2(6)      ,/* 語言別 */
oofjl003       varchar2(500)      ,/* 說明 */
oofjl004       varchar2(10)      /* 助記碼 */
);
alter table oofjl_t add constraint oofjl_pk primary key (oofjlent,oofjl001,oofjl002) enable validate;

create  index oofjl_01 on oofjl_t (oofjl004);
create unique index oofjl_pk on oofjl_t (oofjlent,oofjl001,oofjl002);

grant select on oofjl_t to tiptop;
grant update on oofjl_t to tiptop;
grant delete on oofjl_t to tiptop;
grant insert on oofjl_t to tiptop;

exit;
