/* 
================================================================================
檔案代號:xuji_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xuji_t
(
xujient       number(5)      ,/* 企業代碼 */
xujimodu       varchar2(10)      ,/* 資料修改者 */
xujidate       date      ,/* 最近修改日 */
xujioriu       varchar2(10)      ,/* 資料所有者 */
xujiorid       varchar2(10)      ,/* 資料所有部門 */
xujiuser       varchar2(10)      ,/* 資料建立者 */
xujidept       varchar2(10)      ,/* 資料建立部門 */
xujibuid       date      ,/* 資料創建日 */
xujistus       varchar2(1)      ,/* 狀態碼 */
xuji001       varchar2(10)      ,/* 幣別編號 */
xuji002       number(10,0)      ,/* 金額小數位數 */
xuji003       number(10,0)      ,/* 除匯率時小數位數 */
xuji004       varchar2(1)      ,/* 計算方式 */
xuji005       varchar2(10)      /* ISO代碼 */
);
alter table xuji_t add constraint xuji_pk primary key (xujient,xuji001) enable validate;


grant select on xuji_t to tiptop;
grant update on xuji_t to tiptop;
grant delete on xuji_t to tiptop;
grant insert on xuji_t to tiptop;

exit;
