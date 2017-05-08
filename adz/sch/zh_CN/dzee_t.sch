/* 
================================================================================
檔案代號:dzee_t
檔案名稱:表格更新包紀錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzee_t
(
dzee001       varchar2(40)      ,/* 執行 ID */
dzee002       number(10,0)      ,/* 執行序號 */
dzee003       varchar2(40)      ,/* 主Patch名稱 */
dzee004       varchar2(40)      ,/* 子Patch名稱 */
dzee005       varchar2(1)      ,/* 狀態 */
dzee006       timestamp(0)      ,/* 分派時間 */
dzee007       timestamp(0)      ,/* 開始時間 */
dzee008       timestamp(0)      ,/* 結束時間 */
dzee009       varchar2(500)      ,/* 執行指令 */
dzee010       varchar2(500)      ,/* 紀錄擋路徑 */
dzee011       varchar2(500)      ,/* 完整執行及匯出Log指令 */
dzee012       clob      /* 完整Log內容 */
);
alter table dzee_t add constraint dzee_pk primary key (dzee001,dzee002) enable validate;

create unique index dzee_pk on dzee_t (dzee001,dzee002);

grant select on dzee_t to tiptop;
grant update on dzee_t to tiptop;
grant delete on dzee_t to tiptop;
grant insert on dzee_t to tiptop;

exit;
