/* 
================================================================================
檔案代號:參照表資料
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table 參照表資料
(
參照表資料modu       varchar2(10)      ,/* 資料修改者 */
參照表資料date       date      ,/* 最近修改日 */
參照表資料oriu       varchar2(10)      ,/* 資料所有者 */
參照表資料orid       varchar2(10)      ,/* 資料所有部門 */
參照表資料user       varchar2(10)      ,/* 資料建立者 */
參照表資料dept       varchar2(10)      ,/* 資料建立部門 */
參照表資料buid       date      ,/* 資料創建日 */
參照表資料stus       varchar2(1)      ,/* 狀態碼 */
參照表資料000              ,/*   */
參照表資料001              ,/*   */
參照表資料002              /*   */
);


grant select on 參照表資料 to tiptop;
grant update on 參照表資料 to tiptop;
grant delete on 參照表資料 to tiptop;
grant insert on 參照表資料 to tiptop;

exit;
