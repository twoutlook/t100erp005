/* 
================================================================================
檔案代號:ooibs_t
檔案名稱:收付款條件主檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table ooibs_t
(
ooibsent       number(5)      ,/* 企業編號 */
ooibs002       varchar2(10)      ,/* 收付款條件編號 */
ooibs003       varchar2(40)      ,/* 提速值 */
ooibs004       number(5,0)      /* 階層 */
);
alter table ooibs_t add constraint ooibs_pk primary key (ooibsent,ooibs002,ooibs003) enable validate;

create unique index ooibs_pk on ooibs_t (ooibsent,ooibs002,ooibs003);

grant select on ooibs_t to tiptop;
grant update on ooibs_t to tiptop;
grant delete on ooibs_t to tiptop;
grant insert on ooibs_t to tiptop;

exit;
