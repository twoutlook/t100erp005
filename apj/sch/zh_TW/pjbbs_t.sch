/* 
================================================================================
檔案代號:pjbbs_t
檔案名稱:專案WBS單身檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table pjbbs_t
(
pjbbsent       number(5)      ,/* 企業編號 */
pjbbs001       varchar2(20)      ,/* 專案編號 */
pjbbs002       varchar2(30)      ,/* 本階WBS */
pjbbs003       varchar2(40)      ,/* 提速值 */
pjbbs004       number(5,0)      /* 階層 */
);
alter table pjbbs_t add constraint pjbbs_pk primary key (pjbbsent,pjbbs001,pjbbs002,pjbbs003) enable validate;

create unique index pjbbs_pk on pjbbs_t (pjbbsent,pjbbs001,pjbbs002,pjbbs003);

grant select on pjbbs_t to tiptop;
grant update on pjbbs_t to tiptop;
grant delete on pjbbs_t to tiptop;
grant insert on pjbbs_t to tiptop;

exit;
