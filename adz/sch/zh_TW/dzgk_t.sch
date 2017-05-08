/* 
================================================================================
檔案代號:dzgk_t
檔案名稱:組合欄位-主欄位屬性表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzgk_t
(
dzgk001       number(10,0)      ,/* 序號 */
dzgk002       varchar2(4)      ,/* 屬性編號 */
dzgk003       varchar2(1)      /* 處理類別 */
);
alter table dzgk_t add constraint dzgk_pk primary key (dzgk001,dzgk002,dzgk003) enable validate;

create unique index dzgk_pk on dzgk_t (dzgk001,dzgk002,dzgk003);

grant select on dzgk_t to tiptop;
grant update on dzgk_t to tiptop;
grant delete on dzgk_t to tiptop;
grant insert on dzgk_t to tiptop;

exit;
