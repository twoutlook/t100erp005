/* 
================================================================================
檔案代號:gztv_t
檔案名稱:選項項目組組名多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gztv_t
(
gztv001       varchar2(40)      ,/* 選項項目組編號 */
gztv002       varchar2(6)      ,/* 語言別 */
gztv003       varchar2(80)      /* 選項項目組名稱 */
);
alter table gztv_t add constraint gztv_pk primary key (gztv001,gztv002) enable validate;


grant select on gztv_t to tiptop;
grant update on gztv_t to tiptop;
grant delete on gztv_t to tiptop;
grant insert on gztv_t to tiptop;

exit;
