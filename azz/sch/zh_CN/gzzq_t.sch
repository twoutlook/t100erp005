/* 
================================================================================
檔案代號:gzzq_t
檔案名稱:ACTION多語言對照表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzzq_t
(
gzzq001       varchar2(20)      ,/* 程式編號 */
gzzq002       varchar2(80)      ,/* 功能編號 */
gzzq003       varchar2(6)      ,/* 語言別 */
gzzq004       varchar2(80)      ,/* 功能名稱 */
gzzq005       varchar2(500)      ,/* 功能說明 */
gzzq006       varchar2(1)      /* 使用標示 */
);
alter table gzzq_t add constraint gzzq_pk primary key (gzzq001,gzzq002,gzzq003) enable validate;

create unique index gzzq_pk on gzzq_t (gzzq001,gzzq002,gzzq003);

grant select on gzzq_t to tiptop;
grant update on gzzq_t to tiptop;
grant delete on gzzq_t to tiptop;
grant insert on gzzq_t to tiptop;

exit;
