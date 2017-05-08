/* 
================================================================================
檔案代號:dzec_t
檔案名稱:資料表索引檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzec_t
(
dzecstus       varchar2(10)      ,/* 狀態碼 */
dzec001       varchar2(15)      ,/* Table代號 */
dzec002       varchar2(20)      ,/* 索引代號 */
dzec003       varchar2(20)      ,/* 索引形式 */
dzec004       varchar2(500)      ,/* 索引欄位 */
dzecownid       varchar2(20)      ,/* 資料所有者 */
dzecowndp       varchar2(10)      ,/* 資料所屬部門 */
dzeccrtid       varchar2(20)      ,/* 資料建立者 */
dzeccrtdp       varchar2(10)      ,/* 資料建立部門 */
dzeccrtdt       timestamp(0)      ,/* 資料創建日 */
dzecmodid       varchar2(20)      ,/* 資料修改者 */
dzecmoddt       timestamp(0)      ,/* 最近修改日 */
dzeccnfid       varchar2(20)      ,/* 資料確認者 */
dzeccnfdt       timestamp(0)      ,/* 資料確認日 */
dzec005       varchar2(1)      ,/* 異動確認碼 */
dzec006       varchar2(1)      ,/* 客制標示 */
dzec007       varchar2(1)      ,/* 原始客制標示 */
dzec008       varchar2(1)      /* 出貨標示 */
);
alter table dzec_t add constraint dzec_pk primary key (dzec001,dzec002) enable validate;

create unique index dzec_pk on dzec_t (dzec001,dzec002);

grant select on dzec_t to tiptop;
grant update on dzec_t to tiptop;
grant delete on dzec_t to tiptop;
grant insert on dzec_t to tiptop;

exit;
