/* 
================================================================================
檔案代號:dzfy_t
檔案名稱:畫面樣版ToolBar功能鍵設定檔底稿
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfy_t
(
dzfy001       varchar2(20)      ,/* 設計工具版號 */
dzfy002       varchar2(20)      ,/* 資料所有者 */
dzfy003       varchar2(20)      ,/* 畫面代號 */
dzfy004       varchar2(40)      /* Action ID */
);
alter table dzfy_t add constraint dzfy_pk primary key (dzfy001,dzfy002,dzfy003,dzfy004) enable validate;

create unique index dzfy_pk on dzfy_t (dzfy001,dzfy002,dzfy003,dzfy004);

grant select on dzfy_t to tiptop;
grant update on dzfy_t to tiptop;
grant delete on dzfy_t to tiptop;
grant insert on dzfy_t to tiptop;

exit;
