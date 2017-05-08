/* 
================================================================================
檔案代號:bgkk_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bgkk_t
(
bgkkent       number(5)      ,/* 企業代碼 */
bgkkownid       varchar2(10)      ,/* 資料所有者 */
bgkk002       varchar2(10)      ,/* 資料所屬部門 */
bgkkcrtid       varchar2(10)      ,/* 資料建立者 */
bgkkcrtdp       varchar2(10)      ,/* 資料建立部門 */
bgkkcrtdt       date      ,/* 資料創建日 */
bgkkmodid       varchar2(10)      ,/* 資料修改者 */
bgkkmoddt       date      ,/* 最近修改日 */
bgkkstus       varchar2(10)      ,/* 狀態碼 */
bgkk003       varchar2(10)      /*   */
);
alter table bgkk_t add constraint bgkk_pk primary key (bgkkent) enable validate;


grant select on bgkk_t to tiptop;
grant update on bgkk_t to tiptop;
grant delete on bgkk_t to tiptop;
grant insert on bgkk_t to tiptop;

exit;
