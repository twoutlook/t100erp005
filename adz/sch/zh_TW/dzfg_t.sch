/* 
================================================================================
檔案代號:dzfg_t
檔案名稱:測試用:畫面結構設計附屬設定條件式
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfg_t
(
dzfg001       varchar2(20)      ,/* 程式代號 */
dzfg002       number(10)      ,/* 設計點版本 */
dzfg003       number(10)      ,/* 設計器版本 */
dzfg004       number(5,0)      ,/* 設計資料版本計數 */
dzfg005       varchar2(20)      ,/* 4fd tag name */
dzfg006       number(5,0)      ,/* 編號 */
dzfg007       number(5,0)      ,/* 順序 */
dzfg008       varchar2(15)      ,/* 資料表代碼 */
dzfg009       varchar2(20)      ,/* 欄位代號 */
dzfg010       varchar2(20)      ,/* 值的類型:欄位,變數,固定值 */
dzfg011       varchar2(15)      ,/* 資料表代碼 */
dzfg012       varchar2(20)      /* 欄位,變數,固定值 */
);
alter table dzfg_t add constraint dzfg_pk primary key (dzfg001,dzfg002,dzfg003,dzfg004,dzfg005,dzfg006,dzfg007) enable validate;

create unique index dzfg_pk on dzfg_t (dzfg001,dzfg002,dzfg003,dzfg004,dzfg005,dzfg006,dzfg007);

grant select on dzfg_t to tiptop;
grant update on dzfg_t to tiptop;
grant delete on dzfg_t to tiptop;
grant insert on dzfg_t to tiptop;

exit;
