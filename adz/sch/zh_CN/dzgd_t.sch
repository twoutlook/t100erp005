/* 
================================================================================
檔案代號:dzgd_t
檔案名稱:報表元件設計-資料模型自訂義欄位明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzgd_t
(
dzgd001       varchar2(20)      ,/* 報表元件代號 */
dzgd002       number(10)      ,/* 版次 */
dzgd003       varchar2(40)      ,/* 報表變數代號 */
dzgd004       varchar2(20)      ,/* 參考型態欄位 */
dzgd005       varchar2(80)      ,/* 自訂欄位說明 */
dzgd006       varchar2(2000)      ,/* 公式 */
dzgd007       varchar2(40)      ,/* 客戶代號 */
dzgd008       varchar2(1)      /* 客製 */
);
alter table dzgd_t add constraint dzgd_pk primary key (dzgd001,dzgd002,dzgd003,dzgd008) enable validate;

create unique index dzgd_pk on dzgd_t (dzgd001,dzgd002,dzgd003,dzgd008);

grant select on dzgd_t to tiptop;
grant update on dzgd_t to tiptop;
grant delete on dzgd_t to tiptop;
grant insert on dzgd_t to tiptop;

exit;
