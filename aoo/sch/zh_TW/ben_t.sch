/* 
================================================================================
檔案代號:ben_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ben_t
(
benmodu       varchar2(10)      ,/* 資料修改者 */
bendate       date      ,/* 最近修改日 */
benoriu       varchar2(10)      ,/* 資料所有者 */
benorid       varchar2(10)      ,/* 資料所有部門 */
benuser       varchar2(10)      ,/* 資料建立者 */
bendept       varchar2(10)      ,/* 資料建立部門 */
benbuid       date      ,/* 資料創建日 */
benstus       varchar2(1)      ,/* 狀態碼 */
bensite       number(5)      ,/* 組織代碼 */
ben001       number(5)      ,/* 1 */
ben002       varchar2(5)      ,/* 2 */
ben003       varchar2(10)      ,/* 3 */
ben004       varchar2(10)      /* 4 */
);
alter table ben_t add constraint ben_pk primary key (bensite,ben001,ben002) enable validate;


grant select on ben_t to tiptop;
grant update on ben_t to tiptop;
grant delete on ben_t to tiptop;
grant insert on ben_t to tiptop;

exit;
