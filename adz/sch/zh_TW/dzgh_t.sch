/* 
================================================================================
檔案代號:dzgh_t
檔案名稱:報表元件設計-樣板明細檔(GR)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzgh_t
(
dzgh001       varchar2(20)      ,/* 報表元件代號 */
dzgh002       number(10)      ,/* 版次 */
dzgh003       varchar2(20)      ,/* 樣板代號 */
dzgh004       number(10,0)      ,/* 序號 */
dzgh005       varchar2(1)      ,/* 區塊類別 */
dzgh006       number(10,0)      ,/* 所屬區塊編號 */
dzgh007       varchar2(40)      ,/* 報表變數代號 */
dzgh008       number(10,0)      ,/* 區塊順序 */
dzgh009       varchar2(15)      ,/* 表格別名 */
dzgh010       varchar2(40)      ,/* 欄位別名 */
dzgh011       varchar2(40)      ,/* 客戶代號 */
dzgh012       varchar2(1)      /* 客製 */
);
alter table dzgh_t add constraint dzgh_pk primary key (dzgh001,dzgh002,dzgh003,dzgh004,dzgh012) enable validate;

create unique index dzgh_pk on dzgh_t (dzgh001,dzgh002,dzgh003,dzgh004,dzgh012);

grant select on dzgh_t to tiptop;
grant update on dzgh_t to tiptop;
grant delete on dzgh_t to tiptop;
grant insert on dzgh_t to tiptop;

exit;
