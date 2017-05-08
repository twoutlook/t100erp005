/* 
================================================================================
檔案代號:tttt_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table tttt_t
(
ttttmodu       varchar2(10)      ,/* 資料修改者 */
ttttdate       date      ,/* 最近修改日 */
ttttoriu       varchar2(10)      ,/* 資料所有者 */
ttttorid       varchar2(10)      ,/* 資料所有部門 */
ttttuser       varchar2(10)      ,/* 資料建立者 */
ttttdept       varchar2(10)      ,/* 資料建立部門 */
ttttbuid       date      /* 資料創建日 */
);


grant select on tttt_t to tiptop;
grant update on tttt_t to tiptop;
grant delete on tttt_t to tiptop;
grant insert on tttt_t to tiptop;

exit;
