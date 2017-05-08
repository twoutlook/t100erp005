/* 
================================================================================
檔案代號:inai_t
檔案名稱:製造批序號庫存明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table inai_t
(
inaient       number(5)      ,/* 企業編號 */
inaisite       varchar2(10)      ,/* 營運據點 */
inai001       varchar2(40)      ,/* 料件編號 */
inai002       varchar2(256)      ,/* 產品特徵 */
inai003       varchar2(30)      ,/* 庫存管理特徵 */
inai004       varchar2(10)      ,/* 庫位編號 */
inai005       varchar2(10)      ,/* 儲位編號 */
inai006       varchar2(30)      ,/* 批號 */
inai007       varchar2(30)      ,/* 製造批號 */
inai008       varchar2(30)      ,/* 製造序號 */
inai009       varchar2(10)      ,/* 庫存單位 */
inai010       number(20,6)      ,/* 帳面基礎單位庫存數量 */
inai011       number(20,6)      ,/* 實際基礎單位庫存數量 */
inai012       date      ,/* 製造日期 */
inai013       varchar2(256)      ,/* Tag二進位碼 */
inai014       varchar2(10)      /* 基礎單位 */
);
alter table inai_t add constraint inai_pk primary key (inaient,inaisite,inai001,inai002,inai003,inai004,inai005,inai006,inai007,inai008,inai009) enable validate;

create  index inai_01 on inai_t (inai013);
create unique index inai_pk on inai_t (inaient,inaisite,inai001,inai002,inai003,inai004,inai005,inai006,inai007,inai008,inai009);

grant select on inai_t to tiptop;
grant update on inai_t to tiptop;
grant delete on inai_t to tiptop;
grant insert on inai_t to tiptop;

exit;
