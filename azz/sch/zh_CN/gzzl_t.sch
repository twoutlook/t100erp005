/* 
================================================================================
檔案代號:gzzl_t
檔案名稱:程式連結成果資料明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzzl_t
(
gzzl001       varchar2(20)      ,/* 42r編號 */
gzzl002       varchar2(20)      ,/* 4gl編號 */
gzzl003       varchar2(4)      ,/* 4gl歸屬模組 */
gzzl004       varchar2(1)      /* 4gl型態 */
);
alter table gzzl_t add constraint gzzl_pk primary key (gzzl001,gzzl002) enable validate;

create unique index gzzl_pk on gzzl_t (gzzl001,gzzl002);

grant select on gzzl_t to tiptop;
grant update on gzzl_t to tiptop;
grant delete on gzzl_t to tiptop;
grant insert on gzzl_t to tiptop;

exit;
