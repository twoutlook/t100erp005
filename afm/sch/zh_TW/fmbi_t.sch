/* 
================================================================================
檔案代號:fmbi_t
檔案名稱:償還本息單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmbi_t
(
fmbient       number(5)      ,/* no use */
fmbisite       varchar2(10)      ,/* no use */
fmbicomp       varchar2(10)      ,/* no use */
fmbidocno       varchar2(20)      ,/* no use */
fmbi001       date      ,/* no use */
fmbiownid       varchar2(20)      ,/* no use */
fmbiowndp       varchar2(10)      ,/* no use */
fmbicrtid       varchar2(20)      ,/* no use */
fmbicrtdp       varchar2(10)      ,/* no use */
fmbicrtdt       timestamp(0)      ,/* no use */
fmbimodid       varchar2(20)      ,/* no use */
fmbimoddt       timestamp(0)      ,/* no use */
fmbicnfid       varchar2(20)      ,/* no use */
fmbicnfdt       timestamp(0)      ,/* no use */
fmbistus       varchar2(10)      /* no use */
);
alter table fmbi_t add constraint fmbi_pk primary key (fmbient,fmbidocno) enable validate;

create unique index fmbi_pk on fmbi_t (fmbient,fmbidocno);

grant select on fmbi_t to tiptop;
grant update on fmbi_t to tiptop;
grant delete on fmbi_t to tiptop;
grant insert on fmbi_t to tiptop;

exit;
