/* 
================================================================================
檔案代號:fmao_t
檔案名稱:融資費用檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table fmao_t
(
fmaoent       number(5)      ,/* no use */
fmao001       varchar2(20)      ,/* no use */
fmao002       date      ,/* no use */
fmao003       varchar2(1)      ,/* no use */
fmao004       varchar2(10)      ,/* no use */
fmao005       number(20,6)      ,/* no use */
fmao006       number(20,6)      ,/* no use */
fmao007       varchar2(20)      ,/* no use */
fmao008       varchar2(20)      /* no use */
);
alter table fmao_t add constraint fmao_pk primary key (fmaoent,fmao001,fmao003,fmao004,fmao008) enable validate;

create unique index fmao_pk on fmao_t (fmaoent,fmao001,fmao003,fmao004,fmao008);

grant select on fmao_t to tiptop;
grant update on fmao_t to tiptop;
grant delete on fmao_t to tiptop;
grant insert on fmao_t to tiptop;

exit;
