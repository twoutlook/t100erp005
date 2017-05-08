/* 
================================================================================
檔案代號:dzfx_t
檔案名稱:規格Table設定表底稿
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfx_t
(
dzfx001       varchar2(20)      ,/* 設計工具版號 */
dzfx002       varchar2(20)      ,/* 資料所有者 */
dzfx003       varchar2(20)      ,/* 規格編號(程式代號) */
dzfx004       varchar2(15)      ,/* Table編號 */
dzfx005       varchar2(15)      /* 上層Table編號 */
);
alter table dzfx_t add constraint dzfx_pk primary key (dzfx001,dzfx002,dzfx003,dzfx004) enable validate;

create unique index dzfx_pk on dzfx_t (dzfx001,dzfx002,dzfx003,dzfx004);

grant select on dzfx_t to tiptop;
grant update on dzfx_t to tiptop;
grant delete on dzfx_t to tiptop;
grant insert on dzfx_t to tiptop;

exit;
