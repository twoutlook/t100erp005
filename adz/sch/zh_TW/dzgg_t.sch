/* 
================================================================================
檔案代號:dzgg_t
檔案名稱:報表元件設計-樣板單頭檔(GR)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzgg_t
(
dzgg001       varchar2(20)      ,/* 報表元件代號 */
dzgg002       number(10)      ,/* 版次 */
dzgg003       varchar2(20)      ,/* 樣板代號 */
dzgg004       number(5,0)      ,/* 單頭區塊 */
dzgg005       number(5,0)      ,/* 單身行數 */
dzgg006       varchar2(1)      ,/* 簽核 */
dzgg007       varchar2(1)      ,/* 備註 */
dzgg008       varchar2(100)      ,/* 紙張名稱 */
dzgg009       varchar2(1)      ,/* 紙張方向 */
dzgg010       number(15,3)      ,/* 上邊界 */
dzgg011       number(15,3)      ,/* 下邊界 */
dzgg012       number(15,3)      ,/* 左邊界 */
dzgg013       number(15,3)      ,/* 右邊界 */
dzgg014       varchar2(1)      ,/* 單位 */
dzgg015       varchar2(1)      ,/* 單身表格化 */
dzgg016       varchar2(40)      ,/* 客戶代號 */
dzgg017       varchar2(1)      /* 客製 */
);
alter table dzgg_t add constraint dzgg_pk primary key (dzgg001,dzgg002,dzgg003,dzgg017) enable validate;

create unique index dzgg_pk on dzgg_t (dzgg001,dzgg002,dzgg003,dzgg017);

grant select on dzgg_t to tiptop;
grant update on dzgg_t to tiptop;
grant delete on dzgg_t to tiptop;
grant insert on dzgg_t to tiptop;

exit;
