/* 
================================================================================
檔案代號:ooias_t
檔案名稱:款別主檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table ooias_t
(
ooiasent       number(5)      ,/* 企業編號 */
ooias001       varchar2(10)      ,/* 款別編號 */
ooias002       varchar2(40)      ,/* 提速值 */
ooias003       number(5,0)      /* 階層 */
);
alter table ooias_t add constraint ooias_pk primary key (ooiasent,ooias001,ooias002) enable validate;

create unique index ooias_pk on ooias_t (ooiasent,ooias001,ooias002);

grant select on ooias_t to tiptop;
grant update on ooias_t to tiptop;
grant delete on ooias_t to tiptop;
grant insert on ooias_t to tiptop;

exit;
