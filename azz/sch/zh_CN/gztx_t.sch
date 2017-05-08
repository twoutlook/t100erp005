/* 
================================================================================
檔案代號:gztx_t
檔案名稱:選項內存值多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gztx_t
(
gztx001       varchar2(20)      ,/* 選項項目組編號 */
gztx002       varchar2(10)      ,/* 項目內存值 */
gztx003       varchar2(6)      ,/* 語言別 */
gztx004       varchar2(80)      /* 項目內存值說明 */
);
alter table gztx_t add constraint gztx_pk primary key (gztx001,gztx002,gztx003) enable validate;

create unique index gztx_pk on gztx_t (gztx001,gztx002,gztx003);

grant select on gztx_t to tiptop;
grant update on gztx_t to tiptop;
grant delete on gztx_t to tiptop;
grant insert on gztx_t to tiptop;

exit;
