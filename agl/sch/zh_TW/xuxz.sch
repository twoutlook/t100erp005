/* 
================================================================================
檔案代號:xuxz
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xuxz
(
xuxz001       number(5,0)      ,/* test */
xuxz002       number(5,0)      /* test */
);
alter table xuxz add constraint xuxz_pk primary key (xuxz001) enable validate;


grant select on xuxz to tiptop;
grant update on xuxz to tiptop;
grant delete on xuxz to tiptop;
grant insert on xuxz to tiptop;

exit;
