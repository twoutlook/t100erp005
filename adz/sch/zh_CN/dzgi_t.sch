/* 
================================================================================
檔案代號:dzgi_t
檔案名稱:報表元件設計-資料模型位Table明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzgi_t
(
dzgi001       varchar2(20)      ,/* 報表元件代號 */
dzgi002       number(10)      ,/* 版次 */
dzgi003       number(10,0)      ,/* 序號 */
dzgi004       varchar2(15)      ,/* Table編號 */
dzgi005       varchar2(40)      ,/* 客戶代號 */
dzgi006       varchar2(1)      /* 客製 */
);
alter table dzgi_t add constraint dzgi_pk primary key (dzgi001,dzgi002,dzgi003,dzgi006) enable validate;

create unique index dzgi_pk on dzgi_t (dzgi001,dzgi002,dzgi003,dzgi006);

grant select on dzgi_t to tiptop;
grant update on dzgi_t to tiptop;
grant delete on dzgi_t to tiptop;
grant insert on dzgi_t to tiptop;

exit;
