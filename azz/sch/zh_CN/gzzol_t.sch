/* 
================================================================================
檔案代號:gzzol_t
檔案名稱:模組編號多語言記錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzzol_t
(
gzzol001       varchar2(4)      ,/* 模組編號 */
gzzol002       varchar2(6)      ,/* 語言別 */
gzzol003       varchar2(80)      ,/* 模組名稱 */
gzzol004       varchar2(10)      /* 助記碼 */
);
alter table gzzol_t add constraint gzzol_pk primary key (gzzol001,gzzol002) enable validate;

create unique index gzzol_pk on gzzol_t (gzzol001,gzzol002);

grant select on gzzol_t to tiptop;
grant update on gzzol_t to tiptop;
grant delete on gzzol_t to tiptop;
grant insert on gzzol_t to tiptop;

exit;
