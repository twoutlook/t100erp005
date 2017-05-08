/* 
================================================================================
檔案代號:dzzis_t
檔案名稱:测试
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table dzzis_t
(
dzzis001       varchar2(10)      ,/* test 1 */
dzzis002       varchar2(10)      ,/* test 2 */
dzzis003       varchar2(10)      /* test 3 */
);
alter table dzzis_t add constraint dzzis_pk primary key (dzzis001) enable validate;


grant select on dzzis_t to tiptop;
grant update on dzzis_t to tiptop;
grant delete on dzzis_t to tiptop;
grant insert on dzzis_t to tiptop;

exit;
