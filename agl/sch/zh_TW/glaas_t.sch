/* 
================================================================================
檔案代號:glaas_t
檔案名稱:帳別資料檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table glaas_t
(
glaasent       number(5)      ,/* 企業編號 */
glaasld       varchar2(5)      ,/* 帳別編號 */
glaas001       varchar2(40)      ,/* 提速值 */
glaas002       number(5,0)      /* 階層 */
);
alter table glaas_t add constraint glaas_pk primary key (glaasent,glaasld,glaas001) enable validate;

create unique index glaas_pk on glaas_t (glaasent,glaasld,glaas001);

grant select on glaas_t to tiptop;
grant update on glaas_t to tiptop;
grant delete on glaas_t to tiptop;
grant insert on glaas_t to tiptop;

exit;
