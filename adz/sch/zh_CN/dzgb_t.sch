/* 
================================================================================
檔案代號:dzgb_t
檔案名稱:報表元件設計-資料模型Table連結明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzgb_t
(
dzgb001       varchar2(20)      ,/* 報表元件代號 */
dzgb002       number(10)      ,/* 版次 */
dzgb003       number(10,0)      ,/* 序號 */
dzgb004       varchar2(1)      ,/* Outer */
dzgb005       varchar2(15)      ,/* Table編號 */
dzgb006       varchar2(20)      ,/* 欄位編號 */
dzgb007       varchar2(2)      ,/* 運算子(Operator) */
dzgb008       varchar2(1)      ,/* Outer */
dzgb009       varchar2(15)      ,/* Table編號 */
dzgb010       varchar2(20)      ,/* 欄位編號 */
dzgb011       varchar2(2000)      ,/* 連結SQL */
dzgb012       varchar2(60)      ,/* 依附控件編號 */
dzgb013       varchar2(80)      ,/* 對應傳值設定 */
dzgb014       varchar2(15)      ,/* 資料參考Table */
dzgb015       varchar2(80)      ,/* 資料參考FK */
dzgb016       varchar2(20)      ,/* 資料參考回傳 */
dzgb017       varchar2(15)      ,/* Table別名 */
dzgb018       varchar2(40)      ,/* 客戶代號 */
dzgb019       varchar2(1)      /* 客製 */
);
alter table dzgb_t add constraint dzgb_pk primary key (dzgb001,dzgb002,dzgb003,dzgb019) enable validate;

create unique index dzgb_pk on dzgb_t (dzgb001,dzgb002,dzgb003,dzgb019);

grant select on dzgb_t to tiptop;
grant update on dzgb_t to tiptop;
grant delete on dzgb_t to tiptop;
grant insert on dzgb_t to tiptop;

exit;
