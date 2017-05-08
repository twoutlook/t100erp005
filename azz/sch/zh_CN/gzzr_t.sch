/* 
================================================================================
檔案代號:gzzr_t
檔案名稱:程式與功能對照表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzzr_t
(
gzzr001       varchar2(20)      ,/* 程式編號 */
gzzr002       varchar2(80)      ,/* 功能編號 */
gzzr003       varchar2(1)      ,/* 功能更新碼 */
gzzr004       varchar2(20)      ,/* 來源程式編號 */
gzzr005       varchar2(1)      /* 功能權限識別碼 */
);
alter table gzzr_t add constraint gzzr_pk primary key (gzzr001,gzzr002) enable validate;

create unique index gzzr_pk on gzzr_t (gzzr001,gzzr002);

grant select on gzzr_t to tiptop;
grant update on gzzr_t to tiptop;
grant delete on gzzr_t to tiptop;
grant insert on gzzr_t to tiptop;

exit;
