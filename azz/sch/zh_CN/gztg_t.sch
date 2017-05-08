/* 
================================================================================
檔案代號:gztg_t
檔案名稱:SOP測試重點說明表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gztg_t
(
gztg001       varchar2(10)      ,/* SOP編號 */
gztg002       varchar2(6)      ,/* 語言別 */
gztg003       varchar2(500)      ,/* 目的 */
gztg004       varchar2(500)      /* 測試重點 */
);
alter table gztg_t add constraint gztg_pk primary key (gztg001,gztg002) enable validate;

create unique index gztg_pk on gztg_t (gztg001,gztg002);

grant select on gztg_t to tiptop;
grant update on gztg_t to tiptop;
grant delete on gztg_t to tiptop;
grant insert on gztg_t to tiptop;

exit;
