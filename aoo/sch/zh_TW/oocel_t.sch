/* 
================================================================================
檔案代號:oocel_t
檔案名稱:洲別檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table oocel_t
(
oocelent       number(5)      ,/* 企業編號 */
oocel001       varchar2(10)      ,/* 洲別編號 */
oocel002       varchar2(6)      ,/* 語言別 */
oocel003       varchar2(500)      ,/* 說明 */
oocel004       varchar2(10)      /* 助記碼 */
);
alter table oocel_t add constraint oocel_pk primary key (oocelent,oocel001,oocel002) enable validate;

create unique index oocel_pk on oocel_t (oocelent,oocel001,oocel002);

grant select on oocel_t to tiptop;
grant update on oocel_t to tiptop;
grant delete on oocel_t to tiptop;
grant insert on oocel_t to tiptop;

exit;
