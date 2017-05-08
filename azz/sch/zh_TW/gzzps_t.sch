/* 
================================================================================
檔案代號:gzzps_t
檔案名稱:階層式選單設定提速表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table gzzps_t
(
gzzps001       varchar2(20)      ,/* 程式編號 */
gzzps002       varchar2(80)      ,/* 功能編號 */
gzzps003       varchar2(80)      ,/* 提速值 */
gzzps004       number(5,0)      /* 階層 */
);
alter table gzzps_t add constraint gzzps_pk primary key (gzzps001,gzzps002,gzzps003) enable validate;

create unique index gzzps_pk on gzzps_t (gzzps001,gzzps002,gzzps003);

grant select on gzzps_t to tiptop;
grant update on gzzps_t to tiptop;
grant delete on gzzps_t to tiptop;
grant insert on gzzps_t to tiptop;

exit;
