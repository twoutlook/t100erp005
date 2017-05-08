/* 
================================================================================
檔案代號:dzfu_t
檔案名稱:畫面樣版ToolBar功能鍵設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfu_t
(
dzfustus       varchar2(10)      ,/* 狀態碼 */
dzfu001       varchar2(10)      ,/* 程式類別 */
dzfu002       varchar2(40)      ,/* Action ID */
dzfuownid       varchar2(20)      ,/* 資料所有者 */
dzfuowndp       varchar2(10)      ,/* 資料所屬部門 */
dzfucrtid       varchar2(20)      ,/* 資料建立者 */
dzfucrtdp       varchar2(10)      ,/* 資料建立部門 */
dzfucrtdt       timestamp(0)      ,/* 資料創建日 */
dzfumodid       varchar2(20)      ,/* 資料修改者 */
dzfumoddt       timestamp(0)      /* 最近修改日 */
);
alter table dzfu_t add constraint dzfu_pk primary key (dzfu001,dzfu002) enable validate;

create unique index dzfu_pk on dzfu_t (dzfu001,dzfu002);

grant select on dzfu_t to tiptop;
grant update on dzfu_t to tiptop;
grant delete on dzfu_t to tiptop;
grant insert on dzfu_t to tiptop;

exit;
