/* 
================================================================================
檔案代號:fmar_t
檔案名稱:融資資金到帳檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmar_t
(
fmarent       number(5)      ,/* no use */
fmardocno       varchar2(20)      ,/* no use */
fmarseq       number(10,0)      ,/* no use */
fmar002       varchar2(20)      ,/* no use */
fmar003       varchar2(10)      ,/* no use */
fmar004       varchar2(20)      ,/* no use */
fmar005       date      ,/* no use */
fmar006       number(10,0)      ,/* no use */
fmar007       varchar2(10)      ,/* no use */
fmar008       number(20,6)      ,/* no use */
fmar009       varchar2(10)      ,/* no use */
fmar010       number(10,0)      /* no use */
);
alter table fmar_t add constraint fmar_pk primary key (fmarent,fmardocno,fmarseq) enable validate;

create unique index fmar_pk on fmar_t (fmarent,fmardocno,fmarseq);

grant select on fmar_t to tiptop;
grant update on fmar_t to tiptop;
grant delete on fmar_t to tiptop;
grant insert on fmar_t to tiptop;

exit;
