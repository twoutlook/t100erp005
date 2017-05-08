/* 
================================================================================
檔案代號:mhav_t
檔案名稱:水電費匯入資料暫存表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mhav_t
(
mhavent       number(5)      ,/* 企業代碼 */
mhavsite       varchar2(10)      ,/* 營運據點 */
mhavunit       varchar2(10)      ,/* 應用組織 */
mhav001       number(10,0)      ,/* 會計期間 */
mhav002       varchar2(1)      ,/* 水電費類型 */
mhav003       varchar2(1)      ,/* 來源類型 */
mhav004       varchar2(1)      ,/* 類型 */
mhav005       varchar2(10)      ,/* 專櫃編號 */
mhav006       varchar2(20)      ,/* 資源編號 */
mhav007       number(20,6)      ,/* 度數/噸數每小時 */
mhav008       number(20,6)      ,/* 單價 */
mhav009       number(20,6)      ,/* 金額 */
mhav010       number(20,6)      ,/* 上月讀數 */
mhav011       number(20,6)      ,/* 本月讀數 */
mhav012       number(20,6)      ,/* 本月實際度數/噸數 */
mhav013       number(20,6)      ,/* 標準經營時數 */
mhav014       number(20,6)      ,/* 實際營業時數 */
mhav015       number(20,6)      ,/* 實際單價 */
mhav016       number(20,6)      ,/* 實際金額 */
mhav017       varchar2(1)      ,/* 分攤原則 */
mhav018       varchar2(255)      /* 備註 */
);


grant select on mhav_t to tiptop;
grant update on mhav_t to tiptop;
grant delete on mhav_t to tiptop;
grant insert on mhav_t to tiptop;

exit;
