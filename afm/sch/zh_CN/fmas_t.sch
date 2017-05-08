/* 
================================================================================
檔案代號:fmas_t
檔案名稱:NO USE
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fmas_t
(
fmasent       number(5)      ,/* no use */
fmas001       varchar2(10)      ,/* no use */
fmas002       varchar2(20)      ,/* no use */
fmas003       varchar2(5)      ,/* no use */
fmas004       varchar2(10)      ,/* no use */
fmas005       number(5,0)      ,/* no use */
fmas006       number(5,0)      ,/* no use */
fmas007       varchar2(20)      ,/* no use */
fmasownid       varchar2(20)      ,/* no use */
fmasowndp       varchar2(10)      ,/* no use */
fmascrtid       varchar2(20)      ,/* no use */
fmascrtdp       varchar2(10)      ,/* no use */
fmascrtdt       timestamp(0)      ,/* no use */
fmasmodid       varchar2(20)      ,/* no use */
fmasmoddt       timestamp(0)      ,/* no use */
fmascnfid       varchar2(20)      ,/* no use */
fmascnfdt       timestamp(0)      ,/* no use */
fmasstus       varchar2(10)      /* no use */
);
alter table fmas_t add constraint fmas_pk primary key (fmasent,fmas002) enable validate;

create unique index fmas_pk on fmas_t (fmasent,fmas002);

grant select on fmas_t to tiptop;
grant update on fmas_t to tiptop;
grant delete on fmas_t to tiptop;
grant insert on fmas_t to tiptop;

exit;
