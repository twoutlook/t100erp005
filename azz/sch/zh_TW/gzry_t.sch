/* 
================================================================================
檔案代號:gzry_t
檔案名稱:系統規格描述資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzry_t
(
gzrystus       varchar2(10)      ,/* 狀態碼 */
gzry001       varchar2(20)      ,/* 程式功能點 */
gzry002       varchar2(20)      ,/* 上層功能點 */
gzry003       varchar2(80)      ,/* 功能內容 */
gzry004       varchar2(1)      ,/* 功能已完成 */
gzry005       varchar2(500)      ,/* 功能詳細說明 */
gzry006       varchar2(10)      ,/* 指定開發人 */
gzry007       varchar2(10)      ,/* 功能測試人 */
gzry008       varchar2(1)      ,/* 兩區已同步 */
gzry009       date      ,/* 預計開工日期 */
gzry010       number(15,3)      ,/* 預估時數 */
gzry011       date      ,/* 實際開工日期 */
gzry012       number(15,3)      ,/* 實際時數 */
gzry013       date      ,/* 完工日期 */
gzry014       varchar2(1)      ,/* 緊急度 */
gzryownid       varchar2(10)      ,/* 資料所有者 */
gzryowndp       varchar2(10)      ,/* 資料所屬部門 */
gzrycrtid       varchar2(10)      ,/* 資料建立者 */
gzrycrtdp       varchar2(10)      ,/* 資料建立部門 */
gzrycrtdt       date      ,/* 資料創建日 */
gzrymodid       varchar2(10)      ,/* 資料修改者 */
gzrymoddt       date      /* 最近修改日 */
);
alter table gzry_t add constraint gzry_pk primary key (gzry001) enable validate;


grant select on gzry_t to tiptop;
grant update on gzry_t to tiptop;
grant delete on gzry_t to tiptop;
grant insert on gzry_t to tiptop;

exit;
