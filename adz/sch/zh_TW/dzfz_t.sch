/* 
================================================================================
檔案代號:dzfz_t
檔案名稱:畫面結構設計內容檔底稿
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfz_t
(
dzfz001       varchar2(20)      ,/* 設計工具版號 */
dzfz002       varchar2(20)      ,/* 資料所有者 */
dzfz003       varchar2(20)      ,/* 畫面代號 */
dzfz004       number(5,0)      ,/* 編號 */
dzfz005       number(5,0)      ,/* 父節點編號 */
dzfz006       number(5,0)      ,/* 順序 */
dzfz007       varchar2(20)      ,/* 4fd tag 類型 */
dzfz008       varchar2(40)      ,/* 4fd tag name */
dzfz009       number(5,0)      ,/* 4fd tag name 編號 */
dzfz010       varchar2(15)      ,/* 資料表代碼 */
dzfz011       varchar2(20)      ,/* 欄位代碼 */
dzfz012       varchar2(1)      ,/* 是否可刪除 */
dzfz013       varchar2(40)      /* 4fd tag name前置名稱 */
);
alter table dzfz_t add constraint dzfz_pk primary key (dzfz001,dzfz002,dzfz003,dzfz004) enable validate;

create unique index dzfz_pk on dzfz_t (dzfz001,dzfz002,dzfz003,dzfz004);

grant select on dzfz_t to tiptop;
grant update on dzfz_t to tiptop;
grant delete on dzfz_t to tiptop;
grant insert on dzfz_t to tiptop;

exit;
