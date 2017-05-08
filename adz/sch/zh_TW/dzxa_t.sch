/* 
================================================================================
檔案代號:dzxa_t
檔案名稱:代碼與內容版本對應表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzxa_t
(
dzxastus       varchar2(10)      ,/* 狀態碼 */
dzxa001       varchar2(20)      ,/* 代碼編號 */
dzxa002       varchar2(15)      ,/* 代碼版次 */
dzxa003       varchar2(60)      ,/* 代碼設計點 */
dzxa004       varchar2(15)      ,/* 設計點版次 */
dzxa005       varchar2(1)      ,/* 使用標示 */
dzxaownid       varchar2(10)      ,/* 資料所有者 */
dzxaowndp       varchar2(10)      ,/* 資料所屬部門 */
dzxacrtid       varchar2(10)      ,/* 資料建立者 */
dzxacrtdp       varchar2(10)      ,/* 資料建立部門 */
dzxacrtdt       date      ,/* 資料創建日 */
dzxamodid       varchar2(10)      ,/* 資料修改者 */
dzxamoddt       date      ,/* 最近修改日 */
dzxa006       number(5,0)      /* 函式順序 */
);
alter table dzxa_t add constraint dzxa_pk primary key (dzxa001,dzxa002,dzxa003) enable validate;


grant select on dzxa_t to tiptop;
grant update on dzxa_t to tiptop;
grant delete on dzxa_t to tiptop;
grant insert on dzxa_t to tiptop;

exit;
