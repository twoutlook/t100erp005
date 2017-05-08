/* 
================================================================================
檔案代號:dzge_t
檔案名稱:報表元件設計-資料模型群組明細檔(GR)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzge_t
(
dzge001       varchar2(20)      ,/* 報表元件代號 */
dzge002       number(10)      ,/* 版次 */
dzge003       varchar2(1)      ,/* 類型 */
dzge004       number(5,0)      ,/* 順序 */
dzge005       varchar2(1)      ,/* 印出是否依照select 排序 */
dzge006       varchar2(20)      ,/* 欄位編號 */
dzge007       varchar2(1)      ,/* 排序方式 */
dzge008       varchar2(40)      ,/* 客戶代號 */
dzge009       varchar2(1)      /* 客製 */
);
alter table dzge_t add constraint dzge_pk primary key (dzge001,dzge002,dzge003,dzge004,dzge009) enable validate;

create unique index dzge_pk on dzge_t (dzge001,dzge002,dzge003,dzge004,dzge009);

grant select on dzge_t to tiptop;
grant update on dzge_t to tiptop;
grant delete on dzge_t to tiptop;
grant insert on dzge_t to tiptop;

exit;
