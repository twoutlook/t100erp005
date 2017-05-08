/* 
================================================================================
檔案代號:gzzn_t
檔案名稱:模組內子作業設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzzn_t
(
gzzn001       varchar2(4)      ,/* 連結程式模組編號 */
gzzn002       varchar2(80)      ,/* 連結程式編號 */
gzzn003       varchar2(1)      ,/* 生效否 */
gzzn004       varchar2(1)      /* no use */
);
alter table gzzn_t add constraint gzzn_pk primary key (gzzn001,gzzn002) enable validate;

create unique index gzzn_pk on gzzn_t (gzzn001,gzzn002);

grant select on gzzn_t to tiptop;
grant update on gzzn_t to tiptop;
grant delete on gzzn_t to tiptop;
grant insert on gzzn_t to tiptop;

exit;
