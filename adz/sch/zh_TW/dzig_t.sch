/* 
================================================================================
檔案代號:dzig_t
檔案名稱:Patch預設賦予值
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzig_t
(
dzig001       varchar2(15)      ,/* table代號 */
dzig002       varchar2(20)      ,/* 欄位代號 */
dzig003       varchar2(100)      /* Patch賦予值 */
);
alter table dzig_t add constraint dzig_pk primary key (dzig001,dzig002) enable validate;

create unique index dzig_pk on dzig_t (dzig001,dzig002);

grant select on dzig_t to tiptop;
grant update on dzig_t to tiptop;
grant delete on dzig_t to tiptop;
grant insert on dzig_t to tiptop;

exit;
