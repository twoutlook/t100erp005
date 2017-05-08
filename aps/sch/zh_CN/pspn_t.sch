/* 
================================================================================
檔案代號:pspn_t
檔案名稱:APS_Config(大部分來自於TT)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pspn_t
(
pspnent       number(5)      ,/* 企業編號 */
pspnsite       varchar2(10)      ,/* 營運據點 */
pspn001       varchar2(10)      ,/* APS版本 */
pspn002       varchar2(20)      ,/* 執行日期時間 */
pspn003       varchar2(80)      ,/* key_id */
pspn004       number(10,0)      ,/* key_group */
pspn005       varchar2(80)      ,/* key_value */
pspn006       varchar2(80)      ,/* key_name */
pspn007       varchar2(80)      ,/* key_section */
pspn008       varchar2(255)      /* key_descript */
);
alter table pspn_t add constraint pspn_pk primary key (pspnent,pspnsite,pspn001,pspn002,pspn003,pspn004) enable validate;

create unique index pspn_pk on pspn_t (pspnent,pspnsite,pspn001,pspn002,pspn003,pspn004);

grant select on pspn_t to tiptop;
grant update on pspn_t to tiptop;
grant delete on pspn_t to tiptop;
grant insert on pspn_t to tiptop;

exit;
