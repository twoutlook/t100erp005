/* 
================================================================================
檔案代號:dzlt_t
檔案名稱:IT工具類匯出清單
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzlt_t
(
dzlt001       varchar2(40)      ,/* GUID */
dzlt002       number(5,0)      ,/* 序號 */
dzlt003       varchar2(4)      ,/* 模組別 */
dzlt004       varchar2(10)      ,/* 動作類型 */
dzlt005       varchar2(1)      ,/* 主程式否 */
dzlt006       varchar2(40)      ,/* 檔名 */
dzlt007       varchar2(1)      ,/* no use */
dzlt008       varchar2(1)      ,/* 匯出狀態 */
dzlt009       varchar2(1)      ,/* 匯入狀態 */
dzlt010       varchar2(1)      ,/* 過單否 */
dzlt011       varchar2(20)      ,/* 需求單號 */
dzlt012       varchar2(10)      ,/* 產品代號 */
dzlt013       varchar2(20)      ,/* 產品版本 */
dzlt014       number(5,0)      /* 作業項次 */
);
alter table dzlt_t add constraint dzlt_pk primary key (dzlt002,dzlt011,dzlt012,dzlt013,dzlt014) enable validate;

create unique index dzlt_pk on dzlt_t (dzlt002,dzlt011,dzlt012,dzlt013,dzlt014);

grant select on dzlt_t to tiptop;
grant update on dzlt_t to tiptop;
grant delete on dzlt_t to tiptop;
grant insert on dzlt_t to tiptop;

exit;
