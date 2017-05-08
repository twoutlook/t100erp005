/* 
================================================================================
檔案代號:dbaas_t
檔案名稱:銷售地域層級提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table dbaas_t
(
dbaasent       number(5)      ,/* 企業編號 */
dbaas001       varchar2(10)      ,/* 地域編號 */
dbaas002       varchar2(40)      ,/* 提速值 */
dbaas003       number(5,0)      /* 階級 */
);
alter table dbaas_t add constraint dbaas_pk primary key (dbaasent,dbaas001,dbaas002) enable validate;

create unique index dbaas_pk on dbaas_t (dbaasent,dbaas001,dbaas002);

grant select on dbaas_t to tiptop;
grant update on dbaas_t to tiptop;
grant delete on dbaas_t to tiptop;
grant insert on dbaas_t to tiptop;

exit;
