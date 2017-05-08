/* 
================================================================================
檔案代號:dzya_t
檔案名稱:程式類型相關作業
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzya_t
(
dzya001       varchar2(1)      ,/* 程式類型 */
dzya002       varchar2(20)      /* 作業名稱 */
);
alter table dzya_t add constraint dzya_pk primary key (dzya001,dzya002) enable validate;

create unique index dzya_pk on dzya_t (dzya001,dzya002);

grant select on dzya_t to tiptop;
grant update on dzya_t to tiptop;
grant delete on dzya_t to tiptop;
grant insert on dzya_t to tiptop;

exit;
