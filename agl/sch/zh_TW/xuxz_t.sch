/* 
================================================================================
檔案代號:xuxz_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xuxz_t
(
xuxzent       number(5)      ,/* 企業代碼 */
xuxzmodu       varchar2(10)      ,/* 資料修改者 */
xuxzdate       date      ,/* 最近修改日 */
xuxzoriu       varchar2(10)      ,/* 資料所有者 */
xuxzorid       varchar2(10)      ,/* 資料所有部門 */
xuxzuser       varchar2(10)      ,/* 資料建立者 */
xuxzdept       varchar2(10)      ,/* 資料建立部門 */
xuxzbuid       date      ,/* 資料創建日 */
xuxzstus       varchar2(1)      ,/* 狀態碼 */
xuxz001       varchar2(1)      ,/*   */
xuxz002       varchar2(1)      /*   */
);
alter table xuxz_t add constraint xuxz_pk primary key (xuxzent,xuxz001) enable validate;


grant select on xuxz_t to tiptop;
grant update on xuxz_t to tiptop;
grant delete on xuxz_t to tiptop;
grant insert on xuxz_t to tiptop;

exit;
