/* 
================================================================================
檔案代號:dzzh_t
檔案名稱:簽核等級單身(測試用)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzzh_t
(
dzzhstus       varchar2(10)      ,/* 狀態碼 */
dzzh001              ,/* 簽核等級 */
dzzh002       number(5,0)      ,/* 順序 */
dzzh003       varchar2(10)      ,/* 人員代碼 */
dzzh004       varchar2(500)      ,/* 備註 */
dzzh005       varchar2(10)      ,/* 人員簽名檔 */
dzzh006       varchar2(20)      ,/* dzzh006_test */
dzzh007       varchar2(20)      ,/* dzzh007_test */
dzzh008       date      ,/* dzzh008_test */
dzzhownid       varchar2(10)      ,/* 資料所有者 */
dzzhowndp       varchar2(10)      ,/* 資料所屬部門 */
dzzhcrtid       varchar2(10)      ,/* 資料建立者 */
dzzhcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzzhcrtdt       date      ,/* 資料創建日 */
dzzhmodid       varchar2(10)      ,/* 資料修改者 */
dzzhmoddt       date      ,/* 最近修改日 */
dzzhcnfid       varchar2(10)      ,/* 資料確認者 */
dzzhcnfdt       date      /* 資料確認日 */
);
alter table dzzh_t add constraint dzzh_pk primary key (dzzh001,dzzh002,dzzh003) enable validate;


grant select on dzzh_t to tiptop;
grant update on dzzh_t to tiptop;
grant delete on dzzh_t to tiptop;
grant insert on dzzh_t to tiptop;

exit;
