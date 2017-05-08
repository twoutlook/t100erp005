/* 
================================================================================
檔案代號:dzci_t
檔案名稱:校驗帶值邏輯設定順序資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzci_t
(
dzci001       varchar2(20)      ,/* 校驗帶值群組識別碼 */
dzci002       number(10,0)      ,/* 邏輯順序 */
dzci003       varchar2(20)      ,/* 校驗帶值識別碼 */
dzciownid       varchar2(10)      ,/* 資料所有者 */
dzciowndp       varchar2(10)      ,/* 資料所屬部門 */
dzcicrtid       varchar2(10)      ,/* 資料建立者 */
dzcicrtdp       varchar2(10)      ,/* 資料建立部門 */
dzcicrtdt       date      ,/* 資料創建日 */
dzcimodid       varchar2(10)      ,/* 資料修改者 */
dzcimoddt       date      ,/* 最近修改日 */
dzcicnfid       varchar2(10)      ,/* 資料確認者 */
dzcicnfdt       date      /* 資料確認日 */
);
alter table dzci_t add constraint dzci_pk primary key (dzci001,dzci002) enable validate;


grant select on dzci_t to tiptop;
grant update on dzci_t to tiptop;
grant delete on dzci_t to tiptop;
grant insert on dzci_t to tiptop;

exit;
