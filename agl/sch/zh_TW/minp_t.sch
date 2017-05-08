/* 
================================================================================
檔案代號:minp_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table minp_t
(
minpent       number(5)      ,/* 企業代碼 */
minpmodu       varchar2(10)      ,/* 資料修改者 */
minpdate       date      ,/* 最近修改日 */
minporiu       varchar2(10)      ,/* 資料所有者 */
minporid       varchar2(10)      ,/* 資料所有部門 */
minpuser       varchar2(10)      ,/* 資料建立者 */
minpdept       varchar2(10)      ,/* 資料建立部門 */
minpbuid       date      ,/* 資料創建日 */
minpstus       varchar2(1)      ,/* 狀態碼 */
minp001       varchar2(10)      ,/* 幣別編號 */
minp002              ,/*   */
minp003              ,/*   */
minp004              ,/*   */
minp005              /*   */
);
alter table minp_t add constraint minp_pk primary key (minpent,minp001) enable validate;


grant select on minp_t to tiptop;
grant update on minp_t to tiptop;
grant delete on minp_t to tiptop;
grant insert on minp_t to tiptop;

exit;
