/* 
================================================================================
檔案代號:fmam_t
檔案名稱:融資資金劃付明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmam_t
(
fmament       number(5)      ,/* no use */
fmam001       varchar2(10)      ,/* no use */
fmam002       varchar2(10)      ,/* no use */
fmam003       date      ,/* no use */
fmam004       varchar2(30)      ,/* no use */
fmam005       number(20,6)      ,/* no use */
fmam006       number(10,0)      /* no use */
);
alter table fmam_t add constraint fmam_pk primary key (fmament,fmam001,fmam003,fmam006) enable validate;

create unique index fmam_pk on fmam_t (fmament,fmam001,fmam003,fmam006);

grant select on fmam_t to tiptop;
grant update on fmam_t to tiptop;
grant delete on fmam_t to tiptop;
grant insert on fmam_t to tiptop;

exit;
