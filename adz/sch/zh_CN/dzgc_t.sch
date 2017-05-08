/* 
================================================================================
檔案代號:dzgc_t
檔案名稱:報表元件設計-資料模型欄位明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzgc_t
(
dzgc001       varchar2(20)      ,/* 報表元件代號 */
dzgc002       number(10)      ,/* 版次 */
dzgc003       number(10,0)      ,/* 序號 */
dzgc004       varchar2(40)      ,/* 變數代號 */
dzgc005       varchar2(1)      ,/* 欄位處理類型 */
dzgc006       varchar2(1)      ,/* 自訂欄位 */
dzgc007       varchar2(15)      ,/* Table編號(別名) */
dzgc008       varchar2(40)      ,/* 客戶代號 */
dzgc009       varchar2(1)      /* 客製 */
);
alter table dzgc_t add constraint dzgc_pk primary key (dzgc001,dzgc002,dzgc003,dzgc009) enable validate;

create unique index dzgc_pk on dzgc_t (dzgc001,dzgc002,dzgc003,dzgc009);

grant select on dzgc_t to tiptop;
grant update on dzgc_t to tiptop;
grant delete on dzgc_t to tiptop;
grant insert on dzgc_t to tiptop;

exit;
