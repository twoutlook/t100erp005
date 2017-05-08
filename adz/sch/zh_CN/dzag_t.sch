/* 
================================================================================
檔案代號:dzag_t
檔案名稱:規格Table設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzag_t
(
dzagstus       varchar2(10)      ,/* 狀態碼 */
dzag001       varchar2(20)      ,/* 規格編號 */
dzag002       varchar2(15)      ,/* Table編號 */
dzag003       number(10)      ,/* 識別碼版次 */
dzag004       varchar2(15)      ,/* 上層Table編號 */
dzag005       varchar2(1)      ,/* 是否為主要Table */
dzag006       varchar2(1)      ,/* 使用標示 */
dzagownid       varchar2(20)      ,/* 資料所有者 */
dzagowndp       varchar2(10)      ,/* 資料所屬部門 */
dzagcrtid       varchar2(20)      ,/* 資料建立者 */
dzagcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzagcrtdt       timestamp(0)      ,/* 資料創建日 */
dzagmodid       varchar2(20)      ,/* 資料修改者 */
dzagmoddt       timestamp(0)      ,/* 最近修改日 */
dzag007       varchar2(1)      ,/* 是否為單頭 */
dzag008       varchar2(500)      ,/* 主鍵設定 */
dzag009       varchar2(500)      ,/* 鍵值設定 */
dzag010       varchar2(500)      ,/* 外來鍵設定 */
dzag011       varchar2(40)      ,/* 客戶代號 */
dzag012       varchar2(1)      ,/* patch標示 */
dzag013       varchar2(15)      ,/* 三層二顯之上階Table */
dzag014       varchar2(500)      ,/* 三層二顯之上階Key值設定 */
dzag015       varchar2(500)      /* 三層二顯之本階對應Key值設定 */
);
alter table dzag_t add constraint dzag_pk primary key (dzag001,dzag002,dzag003,dzag006) enable validate;

create unique index dzag_pk on dzag_t (dzag001,dzag002,dzag003,dzag006);

grant select on dzag_t to tiptop;
grant update on dzag_t to tiptop;
grant delete on dzag_t to tiptop;
grant insert on dzag_t to tiptop;

exit;
