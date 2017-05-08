/* 
================================================================================
檔案代號:dzev_t
檔案名稱:實際表格與設計資料對照設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzev_t
(
dzev001       varchar2(15)      ,/* DB Owner */
dzev002       varchar2(15)      ,/* Table代號 */
dzev003       varchar2(40)      ,/* 流水號 */
dzev004       varchar2(40)      ,/* 資料類別 */
dzev005       varchar2(80)      ,/* 欄位名稱 */
dzev006       varchar2(1)      ,/* 是否為Key */
dzev007       varchar2(1)      ,/* 是否為空 */
dzev008       varchar2(20)      ,/* 資料型態 */
dzev009       varchar2(10)      ,/* 資料長度 */
dzev010       varchar2(80)      ,/* 欄位名稱 */
dzev011       number(10,0)      ,/* 欄位序號 */
dzev012       varchar2(40)      ,/* 前流水號 */
dzev013       varchar2(10)      ,/* 欄位屬性 */
dzev014       number(10,0)      ,/* 欄位序號 */
dzev015       varchar2(80)      ,/* 欄位類別定義代號 */
dzev016       number(10,0)      ,/* 序號欄位號碼 */
dzev017       varchar2(500)      ,/* 欄位說明 */
dzev018       varchar2(40)      ,/* ALM版本號 */
dzev019       varchar2(40)      ,/* ALM需求單號 */
dzev020       varchar2(1)      ,/* Patch標示 */
dzev021       varchar2(100)      ,/* 預設值 */
dzev022       varchar2(1)      ,/* 原始Patch標示 */
dzev023       varchar2(1)      /* 出貨標示 */
);
alter table dzev_t add constraint dzev_pk primary key (dzev001,dzev002,dzev003,dzev004,dzev005) enable validate;

create unique index dzev_pk on dzev_t (dzev001,dzev002,dzev003,dzev004,dzev005);

grant select on dzev_t to tiptop;
grant update on dzev_t to tiptop;
grant delete on dzev_t to tiptop;
grant insert on dzev_t to tiptop;

exit;
