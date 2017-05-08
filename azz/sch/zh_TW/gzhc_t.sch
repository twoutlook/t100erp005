/* 
================================================================================
檔案代號:gzhc_t
檔案名稱:GWC佈景色調檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzhc_t
(
gzhc001       varchar2(40)      ,/* 佈景編號 */
gzhc002       varchar2(10)      /* 色調編號 */
);
alter table gzhc_t add constraint gzhc_pk primary key (gzhc001,gzhc002) enable validate;

create unique index gzhc_pk on gzhc_t (gzhc001,gzhc002);

grant select on gzhc_t to tiptop;
grant update on gzhc_t to tiptop;
grant delete on gzhc_t to tiptop;
grant insert on gzhc_t to tiptop;

exit;
