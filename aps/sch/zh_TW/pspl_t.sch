/* 
================================================================================
檔案代號:pspl_t
檔案名稱:APS_Functions(程式清單)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pspl_t
(
pspl001       varchar2(10)      ,/* func_id */
pspl002       varchar2(10)      ,/* parent_id */
pspl003       varchar2(80)      ,/* func_name */
pspl004       varchar2(1)      ,/* status */
pspl005       varchar2(10)      ,/* sort_id */
pspl006       varchar2(1)      ,/* is_custom */
pspl007       varchar2(1)      /* is_program */
);
alter table pspl_t add constraint pspl_pk primary key (pspl001,pspl002) enable validate;

create unique index pspl_pk on pspl_t (pspl001,pspl002);

grant select on pspl_t to tiptop;
grant update on pspl_t to tiptop;
grant delete on pspl_t to tiptop;
grant insert on pspl_t to tiptop;

exit;
