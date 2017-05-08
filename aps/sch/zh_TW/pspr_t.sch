/* 
================================================================================
檔案代號:pspr_t
檔案名稱:CPT_User_Config(儲存個人化程式設定)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pspr_t
(
pspr001       varchar2(80)      ,/* task_id */
pspr002       varchar2(80)      ,/* section */
pspr003       varchar2(80)      ,/* seq_num */
pspr004       varchar2(80)      ,/* field_name */
pspr005       varchar2(80)      ,/* attribute_name */
pspr006       varchar2(80)      ,/* attribute_value */
pspr007       varchar2(80)      ,/* modify_user */
pspr008       timestamp(0)      /* modify_time */
);
alter table pspr_t add constraint pspr_pk primary key (pspr001,pspr002,pspr003) enable validate;

create unique index pspr_pk on pspr_t (pspr001,pspr002,pspr003);

grant select on pspr_t to tiptop;
grant update on pspr_t to tiptop;
grant delete on pspr_t to tiptop;
grant insert on pspr_t to tiptop;

exit;
