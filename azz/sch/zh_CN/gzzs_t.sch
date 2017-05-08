/* 
================================================================================
檔案代號:gzzs_t
檔案名稱:下拉式選單對應關聯作業對照表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzzs_t
(
gzzs001       varchar2(20)      ,/* 程式編號 */
gzzs002       varchar2(80)      ,/* 下拉功能編號 */
gzzs003       number(5,0)      ,/* 序號 */
gzzs004       varchar2(20)      /* 作業編號 */
);
alter table gzzs_t add constraint gzzs_pk primary key (gzzs001,gzzs002,gzzs003) enable validate;

create unique index gzzs_pk on gzzs_t (gzzs001,gzzs002,gzzs003);

grant select on gzzs_t to tiptop;
grant update on gzzs_t to tiptop;
grant delete on gzzs_t to tiptop;
grant insert on gzzs_t to tiptop;

exit;
