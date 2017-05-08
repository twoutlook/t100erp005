/* 
================================================================================
檔案代號:dzitl_t
檔案名稱:中介表格觸發器資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dzitl_t
(
dzitl001       varchar2(15)      ,/* 表格名稱 */
dzitl002       varchar2(20)      ,/* 觸發器ID */
dzitl003       varchar2(20)      ,/* 欲建立觸發Schema */
dzitl004       varchar2(1)      ,/* 標準或客製 */
dzitl005       varchar2(6)      ,/* 語言別 */
dzitl006       varchar2(80)      ,/* 觸發器名稱 */
dzitl007       varchar2(500)      /* 觸發器說明 */
);
alter table dzitl_t add constraint dzitl_pk primary key (dzitl001,dzitl002,dzitl003,dzitl004,dzitl005) enable validate;

create unique index dzitl_pk on dzitl_t (dzitl001,dzitl002,dzitl003,dzitl004,dzitl005);

grant select on dzitl_t to tiptop;
grant update on dzitl_t to tiptop;
grant delete on dzitl_t to tiptop;
grant insert on dzitl_t to tiptop;

exit;
