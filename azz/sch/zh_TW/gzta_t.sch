/* 
================================================================================
檔案代號:gzta_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzta_t
(
gztamodu       varchar2(10)      ,/* 資料修改者 */
gztadate       date      ,/* 最近修改日 */
gztaoriu       varchar2(10)      ,/* 資料所有者 */
gztaorid       varchar2(10)      ,/* 資料所有部門 */
gztauser       varchar2(10)      ,/* 資料建立者 */
gztadept       varchar2(10)      ,/* 資料建立部門 */
gztabuid       date      ,/* 資料創建日 */
gztastus       varchar2(1)      ,/* 狀態碼 */
gzta001       varchar2(15)      ,/* 表格編號 */
gzta002       varchar2(3)      ,/* 歸屬模組 */
gzta003       varchar2(80)      ,/* 檔案類別 */
gzta004       varchar2(80)      ,/* 上游檔案 */
gzta005       varchar2(80)      ,/* 下游檔案 */
gzta006       varchar2(1)      ,/* 多語系表格 */
gzta007       varchar2(1)      ,/* 系統庫表格 */
gzta008       varchar2(1)      /* 設計庫表格 */
);
alter table gzta_t add constraint gzta_pk primary key (gzta001) enable validate;


grant select on gzta_t to tiptop;
grant update on gzta_t to tiptop;
grant delete on gzta_t to tiptop;
grant insert on gzta_t to tiptop;

exit;
