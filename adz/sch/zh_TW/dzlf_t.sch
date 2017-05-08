/* 
================================================================================
檔案代號:dzlf_t
檔案名稱:檔案匯出清單
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzlf_t
(
dzlf001       varchar2(40)      ,/* GUID */
dzlf002       number(5,0)      ,/* 序號 */
dzlf003       varchar2(80)      ,/* 路徑 */
dzlf004       varchar2(1)      ,/* 類型 */
dzlf005       varchar2(40)      ,/* 檔名 */
dzlf006       varchar2(1)      ,/* 匯出狀態 */
dzlf007       varchar2(1)      ,/* 匯入狀態 */
dzlf008       varchar2(20)      ,/* 需求單號 */
dzlf009       varchar2(10)      ,/* 產品代號 */
dzlf010       varchar2(20)      ,/* 產品版本 */
dzlf011       number(5,0)      ,/* 作業項次 */
dzlf012       varchar2(1)      /* 過單否 */
);
alter table dzlf_t add constraint dzlf_pk primary key (dzlf002,dzlf008,dzlf009,dzlf010,dzlf011) enable validate;

create unique index dzlf_pk on dzlf_t (dzlf002,dzlf008,dzlf009,dzlf010,dzlf011);

grant select on dzlf_t to tiptop;
grant update on dzlf_t to tiptop;
grant delete on dzlf_t to tiptop;
grant insert on dzlf_t to tiptop;

exit;
