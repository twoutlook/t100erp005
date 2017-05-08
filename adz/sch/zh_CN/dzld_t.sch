/* 
================================================================================
檔案代號:dzld_t
檔案名稱:程式註冊資料匯出清單
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzld_t
(
dzld001       varchar2(40)      ,/* GUID */
dzld002       number(5,0)      ,/* 序號 */
dzld003       varchar2(20)      ,/* 作業代號 */
dzld004       varchar2(1)      ,/* 匯入動作 */
dzld005       varchar2(20)      ,/* 維護作業 */
dzld006       varchar2(80)      ,/* 條件式1 */
dzld007       varchar2(80)      ,/* 條件式2 */
dzld008       varchar2(1)      ,/* 匯出狀態 */
dzld009       varchar2(1)      ,/* 匯入狀態 */
dzld010       varchar2(1)      ,/* 清單資料產生方式 */
dzld011       varchar2(20)      ,/* 需求單號 */
dzld012       varchar2(10)      ,/* 產品代號 */
dzld013       varchar2(20)      ,/* 產品版本 */
dzld014       number(5,0)      ,/* 作業項次 */
dzld015       varchar2(1)      ,/* 資料類別 */
dzld016       varchar2(1)      /* 過單否 */
);
alter table dzld_t add constraint dzld_pk primary key (dzld002,dzld011,dzld012,dzld013,dzld014) enable validate;

create unique index dzld_pk on dzld_t (dzld002,dzld011,dzld012,dzld013,dzld014);

grant select on dzld_t to tiptop;
grant update on dzld_t to tiptop;
grant delete on dzld_t to tiptop;
grant insert on dzld_t to tiptop;

exit;
