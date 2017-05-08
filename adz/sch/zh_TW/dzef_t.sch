/* 
================================================================================
檔案代號:dzef_t
檔案名稱:欄位參考設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzef_t
(
dzefstus       varchar2(10)      ,/* 狀態碼 */
dzef001       varchar2(15)      ,/* Table代號 */
dzef002       varchar2(80)      ,/* 目標欄位 */
dzef003       varchar2(80)      ,/* 參考欄位 */
dzef004       number(10,0)      ,/* 檢查表格 */
dzef005       varchar2(80)      ,/* 檢查欄位 */
dzef006       varchar2(15)      ,/* 取值表格 */
dzef007       varchar2(80)      ,/* 取值參考欄位 */
dzef008       varchar2(80)      ,/* 取值欄位 */
dzef009       varchar2(80)      ,/* 多語言欄位 */
dzef010       number(10,0)      ,/* 依附序號 */
dzefownid       varchar2(20)      ,/* 資料所有者 */
dzefowndp       varchar2(10)      ,/* 資料所屬部門 */
dzefcrtid       varchar2(20)      ,/* 資料建立者 */
dzefcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzefcrtdt       timestamp(0)      ,/* 資料創建日 */
dzefmodid       varchar2(20)      ,/* 資料修改者 */
dzefmoddt       timestamp(0)      ,/* 最近修改日 */
dzefcnfid       varchar2(20)      ,/* 資料確認者 */
dzefcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzef_t add constraint dzef_pk primary key (dzef001,dzef002) enable validate;

create unique index dzef_pk on dzef_t (dzef001,dzef002);

grant select on dzef_t to tiptop;
grant update on dzef_t to tiptop;
grant delete on dzef_t to tiptop;
grant insert on dzef_t to tiptop;

exit;
