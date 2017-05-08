/* 
================================================================================
檔案代號:pcav_t
檔案名稱:操作授權記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pcav_t
(
pcavent       number(5)      ,/* 企業代碼 */
pcavsite       varchar2(10)      ,/* 營運據點 */
pcav001       varchar2(40)      ,/* 授權記錄ID */
pcav002       varchar2(40)      ,/* 銷售單GUID */
pcav003       varchar2(20)      ,/* 單號 */
pcav004       varchar2(10)      ,/* 機號 */
pcav005       varchar2(40)      ,/* 交易明細表GUID */
pcav006       varchar2(40)      ,/* 商品編碼 */
pcav007       varchar2(40)      ,/* 功能編號 */
pcav008       varchar2(40)      ,/* 功能名稱 */
pcav009       varchar2(10)      ,/* 授權人員 */
pcav010       date      ,/* 系統日期 */
pcav011       varchar2(8)      ,/* 系統時間 */
pcavstus       varchar2(10)      ,/* 狀態碼 */
pcav012       number(20,6)      ,/* 售價 */
pcav013       number(20,6)      ,/* 數量 */
pcavseq       number(10,0)      /* 項次 */
);
alter table pcav_t add constraint pcav_pk primary key (pcavent,pcav001) enable validate;

create unique index pcav_pk on pcav_t (pcavent,pcav001);

grant select on pcav_t to tiptop;
grant update on pcav_t to tiptop;
grant delete on pcav_t to tiptop;
grant insert on pcav_t to tiptop;

exit;
