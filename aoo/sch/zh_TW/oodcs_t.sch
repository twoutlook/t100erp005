/* 
================================================================================
檔案代號:oodcs_t
檔案名稱:稅目提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table oodcs_t
(
oodcsent       number(5)      ,/* 企業編號 */
oodcs000       varchar2(10)      ,/* 稅區別 */
oodcs001       varchar2(10)      ,/* 稅目 */
oodcs002       varchar2(40)      ,/* 提速值 */
oodcs003       number(5,0)      /* 階層 */
);
alter table oodcs_t add constraint oodcs_pk primary key (oodcs001,oodcs002,oodcsent) enable validate;


grant select on oodcs_t to tiptop;
grant update on oodcs_t to tiptop;
grant delete on oodcs_t to tiptop;
grant insert on oodcs_t to tiptop;

exit;
