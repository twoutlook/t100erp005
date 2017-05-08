/* 
================================================================================
檔案代號:pspm_t
檔案名稱:APS_FuncGroup(群組對應程式)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pspm_t
(
pspm001       varchar2(10)      ,/* group_id */
pspm002       varchar2(10)      /* func_id */
);
alter table pspm_t add constraint pspm_pk primary key (pspm001,pspm002) enable validate;

create unique index pspm_pk on pspm_t (pspm001,pspm002);

grant select on pspm_t to tiptop;
grant update on pspm_t to tiptop;
grant delete on pspm_t to tiptop;
grant insert on pspm_t to tiptop;

exit;
