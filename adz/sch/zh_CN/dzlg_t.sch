/* 
================================================================================
檔案代號:dzlg_t
檔案名稱:需求單單身(for 客戶)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzlg_t
(
dzlg001       varchar2(20)      ,/* 需求單號 */
dzlg002       varchar2(10)      ,/* 產品代號 */
dzlg003       varchar2(20)      ,/* 產品版本 */
dzlg004       number(5)      ,/* 項次 */
dzlg005       varchar2(20)      ,/* 作業代號 */
dzlg006       varchar2(20)      ,/* SD */
dzlg007       varchar2(20)      ,/* PR */
dzlg008       date      ,/* 預完日 */
dzlg009       date      ,/* 實完日 */
dzlg010       number(5)      /* 進度% */
);
alter table dzlg_t add constraint dzlg_pk primary key (dzlg001,dzlg002,dzlg003,dzlg004) enable validate;

create unique index dzlg_pk on dzlg_t (dzlg001,dzlg002,dzlg003,dzlg004);

grant select on dzlg_t to tiptop;
grant update on dzlg_t to tiptop;
grant delete on dzlg_t to tiptop;
grant insert on dzlg_t to tiptop;

exit;
