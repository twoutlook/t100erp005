/* 
================================================================================
檔案代號:ooai_test
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooai_test
(
ooaimodu       varchar2(10)      ,/* 資料修改者 */
ooaidate       date      ,/* 最近修改日 */
ooaioriu       varchar2(10)      ,/* 資料所有者 */
ooaiorid       varchar2(10)      ,/* 資料所有部門 */
ooaiuser       varchar2(10)      ,/* 資料建立者 */
ooaidept       varchar2(10)      ,/* 資料建立部門 */
ooaibuid       date      ,/* 資料創建日 */
ooaistus       varchar2(1)      ,/* 狀態碼 */
ooaient       number(5)      ,/* 企業代碼 */
ooai001       varchar2(4)      ,/* 幣別代號 */
ooai002       number(10,0)      ,/* 金額小數位數 */
ooai003       number(10,0)      ,/* 除匯率時小數位數 */
ooai004       varchar2(1)      ,/* 計算方式 */
ooai005       varchar2(10)      /* ISO代碼 */
);
alter table ooai_test add constraint ooai_pk primary key (ooaient) enable validate;


grant select on ooai_test to tiptop;
grant update on ooai_test to tiptop;
grant delete on ooai_test to tiptop;
grant insert on ooai_test to tiptop;

exit;
