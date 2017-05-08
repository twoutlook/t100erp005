/* 
================================================================================
檔案代號:gzhcl_t
檔案名稱:GWC佈景色調名稱多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzhcl_t
(
gzhcl001       varchar2(40)      ,/* 佈景編號 */
gzhcl002       varchar2(10)      ,/* 色調編號 */
gzhcl003       varchar2(6)      ,/* 語言別 */
gzhcl004       varchar2(500)      /* 色調名稱 */
);
alter table gzhcl_t add constraint gzhcl_pk primary key (gzhcl001,gzhcl002,gzhcl003) enable validate;


grant select on gzhcl_t to tiptop;
grant update on gzhcl_t to tiptop;
grant delete on gzhcl_t to tiptop;
grant insert on gzhcl_t to tiptop;

exit;
