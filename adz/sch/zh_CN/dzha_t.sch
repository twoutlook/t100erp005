/* 
================================================================================
檔案代號:dzha_t
檔案名稱:資料表主檔簽出備份檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzha_t
(
dzha000       varchar2(40)      ,/* 簽出 GUID */
dzha001       varchar2(15)      ,/* table代號 */
dzha002       varchar2(255)      ,/* table說明 */
dzha003       varchar2(4)      ,/* 模組代號 */
dzha004       varchar2(4)      ,/* 表格型態 */
dzha005       varchar2(1)      ,/* 此表格需送翻 */
dzha006       varchar2(1)      ,/* 系統表格 */
dzha007       varchar2(1)      ,/* 表格含共用欄位 */
dzha008       varchar2(40)      ,/* 定義代號 */
dzha009       varchar2(15)      ,/* 上階表格 */
dzha010       varchar2(15)      ,/* 表格空間 */
dzha011       varchar2(1)      ,/* 異動確認碼 */
dzha012       varchar2(10)      ,/* ALM異動版本 */
dzha013       varchar2(10)      ,/* 異動版次 */
dzha014       varchar2(10)      ,/* 行業別 */
dzha015       varchar2(1)      ,/* 客制標示 */
dzha016       varchar2(4)      ,/* 原始模組代碼 */
dzha017       varchar2(1)      ,/* 出貨識別 */
dzha018       varchar2(1)      ,/* 原始客制標示 */
dzhastus       varchar2(10)      ,/* 狀態碼 */
dzhaownid       varchar2(20)      ,/* 資料所有者 */
dzhaowndp       varchar2(10)      ,/* 資料所屬部門 */
dzhacrtid       varchar2(20)      ,/* 資料建立者 */
dzhacrtdp       varchar2(10)      ,/* 資料建立部門 */
dzhacrtdt       timestamp(0)      ,/* 資料創建日 */
dzhamodid       varchar2(20)      ,/* 資料修改者 */
dzhamoddt       timestamp(0)      ,/* 最近修改日 */
dzhacnfid       varchar2(20)      ,/* 資料確認者 */
dzhacnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzha_t add constraint dzha_pk primary key (dzha000,dzha001) enable validate;

create unique index dzha_pk on dzha_t (dzha000,dzha001);

grant select on dzha_t to tiptop;
grant update on dzha_t to tiptop;
grant delete on dzha_t to tiptop;
grant insert on dzha_t to tiptop;

exit;
