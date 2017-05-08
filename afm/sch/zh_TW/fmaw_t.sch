/* 
================================================================================
檔案代號:fmaw_t
檔案名稱:償還本息明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmaw_t
(
fmawent       number(5)      ,/* no use */
fmaw003       varchar2(20)      ,/* no use */
fmaw004       varchar2(10)      ,/* no use */
fmaw005       varchar2(20)      ,/* no use */
fmaw006       varchar2(1)      ,/* no use */
fmaw007       varchar2(10)      ,/* no use */
fmaw008       number(20,6)      ,/* no use */
fmaw009       varchar2(10)      ,/* no use */
fmawownid       varchar2(20)      ,/* no use */
fmawowndp       varchar2(10)      ,/* no use */
fmawcrtid       varchar2(20)      ,/* no use */
fmawcrtdp       varchar2(10)      ,/* no use */
fmawcrtdt       timestamp(0)      ,/* no use */
fmawmodid       varchar2(20)      ,/* no use */
fmawmoddt       timestamp(0)      ,/* no use */
fmawcnfid       varchar2(20)      ,/* no use */
fmawcnfdt       timestamp(0)      ,/* no use */
fmawstus       varchar2(10)      ,/* no use */
fmaw001       varchar2(10)      ,/* no use */
fmaw002       date      ,/* no use */
fmaw010       number(10,0)      /* no use */
);
alter table fmaw_t add constraint fmaw_pk primary key (fmawent,fmaw001,fmaw010) enable validate;

create unique index fmaw_pk on fmaw_t (fmawent,fmaw001,fmaw010);

grant select on fmaw_t to tiptop;
grant update on fmaw_t to tiptop;
grant delete on fmaw_t to tiptop;
grant insert on fmaw_t to tiptop;

exit;
