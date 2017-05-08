/* 
================================================================================
檔案代號:hiko2
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table hiko2
(
tst001       varchar2(10)  DEFAULT Y    /* test 01 */
);
alter table hiko2 add constraint hiko_pk primary key (tst001) enable validate;


grant select on hiko2 to tiptop;
grant update on hiko2 to tiptop;
grant delete on hiko2 to tiptop;
grant insert on hiko2 to tiptop;

exit;
