/* 
================================================================================
檔案代號:hiko_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table hiko_t
(
hikomodu       varchar2(10)      ,/* 資料修改者 */
hikodate       date      ,/* 最近修改日 */
hikooriu       varchar2(10)      ,/* 資料所有者 */
hikoorid       varchar2(10)      ,/* 資料所有部門 */
hikouser       varchar2(10)      ,/* 資料建立者 */
hikodept       varchar2(10)      ,/* 資料建立部門 */
hikobuid       date      ,/* 資料創建日 */
hikoent       number(5)      ,/* 企業代碼 */
hikostus       varchar2(1)      ,/* 狀態碼 */
hiko001       varchar2(10)      ,/* pk1 */
hiko002       varchar2(10)      ,/* test */
hiko003              ,/*   */
hiko004              ,/*   */
hiko005              ,/*   */
hiko006              ,/*   */
hiko007              ,/*   */
hiko008              ,/*   */
hiko009              ,/*   */
hiko010              ,/*   */
hiko011              ,/*   */
hiko012              ,/*   */
hiko013              ,/*   */
hiko014              ,/*   */
hiko015              ,/*   */
hiko016              ,/*   */
hiko017              ,/*   */
hiko018              ,/*   */
hiko019              ,/*   */
hiko020              /*   */
);
alter table hiko_t add constraint hiko_pk primary key (hikoent,hiko001) enable validate;


grant select on hiko_t to tiptop;
grant update on hiko_t to tiptop;
grant delete on hiko_t to tiptop;
grant insert on hiko_t to tiptop;

exit;
