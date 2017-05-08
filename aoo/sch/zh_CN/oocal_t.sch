/* 
================================================================================
檔案代號:oocal_t
檔案名稱:單位多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table oocal_t
(
oocalent       number(5)      ,/* 企業編號 */
oocal001       varchar2(10)      ,/* 單位編號 */
oocal002       varchar2(6)      ,/* 語言別 */
oocal003       varchar2(500)      ,/* 說明 */
oocal004       varchar2(10)      /* 助記碼 */
);
alter table oocal_t add constraint oocal_pk primary key (oocalent,oocal001,oocal002) enable validate;

create  index oocal_01 on oocal_t (oocal004);
create unique index oocal_pk on oocal_t (oocalent,oocal001,oocal002);

grant select on oocal_t to tiptop;
grant update on oocal_t to tiptop;
grant delete on oocal_t to tiptop;
grant insert on oocal_t to tiptop;

exit;
