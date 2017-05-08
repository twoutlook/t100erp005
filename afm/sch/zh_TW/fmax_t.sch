/* 
================================================================================
檔案代號:fmax_t
檔案名稱:償還本息明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmax_t
(
fmaxent       number(5)      ,/* no use */
fmax001       varchar2(10)      ,/* no use */
fmax002       varchar2(1)      ,/* no use */
fmax003       varchar2(20)      ,/* no use */
fmax004       number(10,0)      ,/* no use */
fmax005       varchar2(15)      ,/* no use */
fmax006       varchar2(10)      ,/* no use */
fmax007       number(20,6)      ,/* no use */
fmax008       varchar2(10)      ,/* no use */
fmax009       number(10,0)      /* no use */
);
alter table fmax_t add constraint fmax_pk primary key (fmaxent,fmax001,fmax002,fmax003,fmax004,fmax008,fmax009) enable validate;

create unique index fmax_pk on fmax_t (fmaxent,fmax001,fmax002,fmax003,fmax004,fmax008,fmax009);

grant select on fmax_t to tiptop;
grant update on fmax_t to tiptop;
grant delete on fmax_t to tiptop;
grant insert on fmax_t to tiptop;

exit;
