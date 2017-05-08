/* 
================================================================================
檔案代號:mhaj_t
檔案名稱:組織營業時間檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mhaj_t
(
mhajent       number(5)      ,/* 企業編號 */
mhajsite       varchar2(10)      ,/* 營運組織 */
mhajunit       varchar2(10)      ,/* 應用組織 */
mhaj001       number(10,0)      ,/* 會計期間 */
mhaj002       varchar2(10)      ,/* 經營大類 */
mhaj003       number(20,6)      ,/* 經營天數 */
mhaj004       number(20,6)      ,/* 每日營業時數 */
mhaj005       number(20,6)      ,/* 會計期計算營業時數 */
mhaj006       number(20,6)      ,/* 調整營業時數 */
mhaj007       number(20,6)      ,/* 會計期總營業時數 */
mhaj008       varchar2(255)      ,/* 備註 */
mhajstus       varchar2(10)      ,/* 資料狀態碼 */
mhajownid       varchar2(20)      ,/* 資料所有者 */
mhajowndp       varchar2(10)      ,/* 資料所屬部門 */
mhajcrtid       varchar2(20)      ,/* 資料建立者 */
mhajcrtdp       varchar2(10)      ,/* 資料建立部門 */
mhajcrtdt       timestamp(0)      ,/* 資料創建日 */
mhajmodid       varchar2(20)      ,/* 資料修改者 */
mhajmoddt       timestamp(0)      ,/* 最近修改日 */
mhajcnfid       varchar2(20)      ,/* 資料確認者 */
mhajcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table mhaj_t add constraint mhaj_pk primary key (mhajent,mhajsite,mhaj001,mhaj002) enable validate;

create unique index mhaj_pk on mhaj_t (mhajent,mhajsite,mhaj001,mhaj002);

grant select on mhaj_t to tiptop;
grant update on mhaj_t to tiptop;
grant delete on mhaj_t to tiptop;
grant insert on mhaj_t to tiptop;

exit;
