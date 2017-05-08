/* 
================================================================================
檔案代號:dzia_t
檔案名稱:中介表格主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzia_t
(
dzia001       varchar2(15)      ,/* table代號 */
dzia002       varchar2(255)      ,/* table說明 */
dzia003       varchar2(4)      ,/* 模組代號 */
dzia004       varchar2(4)      ,/* 表格型態 */
dzia005       varchar2(1)      ,/* 此表格需送翻 */
dzia006       varchar2(1)      ,/* 系統表格 */
dzia007       varchar2(1)      ,/* 表格含共用欄位 */
dzia008       varchar2(40)      ,/* 定義代號 */
dzia009       varchar2(15)      ,/* 上階表格 */
dzia010       varchar2(15)      ,/* 表格空間 */
dzia011       varchar2(1)      ,/* 異動確認碼 */
dzia012       varchar2(10)      ,/* ALM異動版本 */
dzia013       varchar2(10)      ,/* 異動版次 */
dzia014       varchar2(10)      ,/* 行業別 */
dzia015       varchar2(1)      ,/* 客制標示 */
dzia016       varchar2(4)      ,/* 原始模組代碼 */
dzia017       varchar2(1)      ,/* 出貨識別 */
dzia018       varchar2(1)      ,/* 原始客制標示 */
dzia019       varchar2(40)      ,/* 簽出GUID */
dzia020       varchar2(40)      ,/* 過單GUID */
dzia021       varchar2(40)      ,/* PatchGUID */
dziastus       varchar2(10)      ,/* 狀態碼 */
dziaownid       varchar2(20)      ,/* 資料所有者 */
dziaowndp       varchar2(10)      ,/* 資料所屬部門 */
dziacrtid       varchar2(20)      ,/* 資料建立者 */
dziacrtdp       varchar2(10)      ,/* 資料建立部門 */
dziacrtdt       timestamp(0)      ,/* 資料創建日 */
dziamodid       varchar2(20)      ,/* 資料修改者 */
dziamoddt       timestamp(0)      ,/* 最近修改日 */
dziacnfid       varchar2(20)      ,/* 資料確認者 */
dziacnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzia_t add constraint dzia_pk primary key (dzia001,dzia015) enable validate;

create unique index dzia_pk on dzia_t (dzia001,dzia015);

grant select on dzia_t to tiptop;
grant update on dzia_t to tiptop;
grant delete on dzia_t to tiptop;
grant insert on dzia_t to tiptop;

exit;
