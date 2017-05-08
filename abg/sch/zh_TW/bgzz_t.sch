/* 
================================================================================
檔案代號:bgzz_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgzz_t
(
bgzzent       number(5)      ,/* 企業代碼 */
bgzzownid       varchar2(10)      ,/* 資料所有者 */
bgzzowndp       varchar2(10)      ,/* 資料所屬部門 */
bgzzcrtid       varchar2(10)      ,/* 資料建立者 */
bgzzcrtdp       varchar2(10)      ,/* 資料建立部門 */
bgzzcrtdt       date      ,/* 資料創建日 */
bgzzmodid       varchar2(10)      ,/* 資料修改者 */
bgzzmoddt       date      ,/* 最近修改日 */
bgzzstus       varchar2(10)      ,/* 狀態碼 */
bgzz001       varchar2(1)      ,/*   */
bgzz002       varchar2(10)      ,/*   */
bgzz003       varchar2(10)      /*   */
);
alter table bgzz_t add constraint bgzz_pk primary key (bgzzent,bgzz001,bgzz002) enable validate;


grant select on bgzz_t to tiptop;
grant update on bgzz_t to tiptop;
grant delete on bgzz_t to tiptop;
grant insert on bgzz_t to tiptop;

exit;
