/* 
================================================================================
檔案代號:test_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table test_t
(
testmodu       varchar2(10)      ,/* 資料修改者 */
testdate       date      ,/* 最近修改日 */
testoriu       varchar2(10)      ,/* 資料所有者 */
testorid       varchar2(10)      ,/* 資料所有部門 */
testuser       varchar2(10)      ,/* 資料建立者 */
testdept       varchar2(10)      ,/* 資料建立部門 */
testbuid       date      /* 資料創建日 */
);


grant select on test_t to tiptop;
grant update on test_t to tiptop;
grant delete on test_t to tiptop;
grant insert on test_t to tiptop;

exit;
