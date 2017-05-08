/* 
================================================================================
檔案代號:dzivl_t
檔案名稱:中介表格視觀表資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dzivl_t
(
dzivl001       varchar2(20)      ,/* 視觀表ID */
dzivl002       varchar2(20)      ,/* 欲建立視觀表Schema */
dzivl003       varchar2(10)      ,/* 標準或客製 */
dzivl004       varchar2(6)      ,/* 語言別 */
dzivl005       varchar2(80)      ,/* 視觀表名稱 */
dzivl006       varchar2(500)      /* 視觀表說明 */
);
alter table dzivl_t add constraint dzivl_pk primary key (dzivl001,dzivl002,dzivl003,dzivl004) enable validate;

create unique index dzivl_pk on dzivl_t (dzivl001,dzivl002,dzivl003,dzivl004);

grant select on dzivl_t to tiptop;
grant update on dzivl_t to tiptop;
grant delete on dzivl_t to tiptop;
grant insert on dzivl_t to tiptop;

exit;
