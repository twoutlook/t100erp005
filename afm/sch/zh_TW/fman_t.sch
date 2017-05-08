/* 
================================================================================
檔案代號:fman_t
檔案名稱:融資利率確認檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table fman_t
(
fmanent       number(5)      ,/* no use */
fman001       varchar2(20)      ,/* no use */
fman002       varchar2(10)      ,/* no use */
fman003       date      ,/* no use */
fman004       varchar2(1)      ,/* no use */
fman005       number(10,6)      ,/* no use */
fman006       varchar2(1)      ,/* no use */
fman007       number(10,6)      ,/* no use */
fman008       number(10,6)      ,/* no use */
fman009       varchar2(20)      ,/* no use */
fman010       number(10,0)      /* no use */
);
alter table fman_t add constraint fman_pk primary key (fmanent,fman001,fman009,fman010) enable validate;

create unique index fman_pk on fman_t (fmanent,fman001,fman009,fman010);

grant select on fman_t to tiptop;
grant update on fman_t to tiptop;
grant delete on fman_t to tiptop;
grant insert on fman_t to tiptop;

exit;
