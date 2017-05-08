/* 
================================================================================
檔案代號:chen_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table chen_t
(
chenent       number(5)      ,/* 企業代碼 */
chenmodu       varchar2(10)      ,/* 資料修改者 */
chendate       date      ,/* 最近修改日 */
chenoriu       varchar2(10)      ,/* 資料所有者 */
chenorid       varchar2(10)      ,/* 資料所有部門 */
chenuser       varchar2(10)      ,/* 資料建立者 */
chendept       varchar2(10)      ,/* 資料建立部門 */
chenbuid       date      ,/* 資料創建日 */
chen001       varchar2(10)      ,/* 幣別編號 */
chen002       number(10,0)      ,/* 金額小數位數 */
chen003       number(10,0)      ,/* 除匯率時小數位數 */
chen004       varchar2(1)      ,/* 計算方式 */
chen005       varchar2(10)      /* ISO代碼 */
);
alter table chen_t add constraint chen_pk primary key (chenent,chen001) enable validate;


grant select on chen_t to tiptop;
grant update on chen_t to tiptop;
grant delete on chen_t to tiptop;
grant insert on chen_t to tiptop;

exit;
