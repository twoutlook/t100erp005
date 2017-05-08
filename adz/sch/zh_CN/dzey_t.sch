/* 
================================================================================
檔案代號:dzey_t
檔案名稱:Table異動更新檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzey_t
(
dzey001       date      ,/* 日期 */
dzey002       varchar2(40)      /* 表格名稱 */
);
alter table dzey_t add constraint dzey_pk primary key (dzey001,dzey002) enable validate;

create unique index dzey_pk on dzey_t (dzey001,dzey002);

grant select on dzey_t to tiptop;
grant update on dzey_t to tiptop;
grant delete on dzey_t to tiptop;
grant insert on dzey_t to tiptop;

exit;
