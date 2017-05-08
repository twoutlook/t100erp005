/* 
================================================================================
檔案代號:pjbos_t
檔案名稱:專案WBS變更單身檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table pjbos_t
(
pjbosent       number(5)      ,/* 企業編號 */
pjbos001       varchar2(20)      ,/* 專案編號 */
pjbos002       varchar2(30)      ,/* 本階WBS */
pjbos900       number(10,0)      ,/* 變更序 */
pjbos003       varchar2(40)      ,/* 提速值 */
pjbos004       number(5,0)      /* 階層 */
);
alter table pjbos_t add constraint pjbos_pk primary key (pjbosent,pjbos001,pjbos002,pjbos900) enable validate;

create unique index pjbos_pk on pjbos_t (pjbosent,pjbos001,pjbos002,pjbos900);

grant select on pjbos_t to tiptop;
grant update on pjbos_t to tiptop;
grant delete on pjbos_t to tiptop;
grant insert on pjbos_t to tiptop;

exit;
