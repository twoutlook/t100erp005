/* 
================================================================================
檔案代號:pmahs_t
檔案名稱:供應商談判記錄檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table pmahs_t
(
pmahs001       varchar2(10)      ,/* 供應商編號 */
pmahs002       number(10,0)      ,/* 序號 */
pmahsent       number(5)      ,/* 企業編號 */
pmahs003       varchar2(40)      ,/* 提速值 */
pmahs004       number(5,0)      /* 階層 */
);
alter table pmahs_t add constraint pmahs_pk primary key (pmahs001,pmahs002,pmahsent,pmahs003) enable validate;

create unique index pmahs_pk on pmahs_t (pmahs001,pmahs002,pmahsent,pmahs003);

grant select on pmahs_t to tiptop;
grant update on pmahs_t to tiptop;
grant delete on pmahs_t to tiptop;
grant insert on pmahs_t to tiptop;

exit;
