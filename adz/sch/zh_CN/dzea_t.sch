/* 
================================================================================
檔案代號:dzea_t
檔案名稱:資料表主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzea_t
(
dzeastus       varchar2(10)      ,/* 狀態碼 */
dzea001       varchar2(15)      ,/* table代號 */
dzea002       varchar2(255)      ,/* table說明 */
dzea003       varchar2(4)      ,/* 模組代號 */
dzea004       varchar2(4)      ,/* 表格型態 */
dzea005       varchar2(1)      ,/* 此表格需送翻 */
dzea006       varchar2(1)      ,/* 系統表格 */
dzea007       varchar2(1)      ,/* 表格含共用欄位 */
dzea008       varchar2(40)      ,/* 定義代號 */
dzea009       varchar2(15)      ,/* 上階表格 */
dzea010       varchar2(15)      ,/* 表格空間 */
dzeaownid       varchar2(20)      ,/* 資料所有者 */
dzeaowndp       varchar2(10)      ,/* 資料所屬部門 */
dzeacrtid       varchar2(20)      ,/* 資料建立者 */
dzeacrtdp       varchar2(10)      ,/* 資料建立部門 */
dzeacrtdt       timestamp(0)      ,/* 資料創建日 */
dzeamodid       varchar2(20)      ,/* 資料修改者 */
dzeamoddt       timestamp(0)      ,/* 最近修改日 */
dzeacnfid       varchar2(20)      ,/* 資料確認者 */
dzeacnfdt       timestamp(0)      ,/* 資料確認日 */
dzea011       varchar2(1)      ,/* 異動確認碼 */
dzea012       varchar2(10)      ,/* ALM異動版本 */
dzea013       varchar2(10)      ,/* 異動版次 */
dzea014       varchar2(10)      ,/* 行業別 */
dzea015       varchar2(1)      ,/* 客制標示 */
dzea016       varchar2(4)      ,/* 原始模組代碼 */
dzea017       varchar2(1)      ,/* 出貨識別 */
dzea018       varchar2(1)      ,/* 原始客制標示 */
dzea019       varchar2(40)      ,/* 簽出GUID */
dzea020       varchar2(40)      ,/* 過單GUID */
dzea021       varchar2(40)      /* PatchGUID */
);
alter table dzea_t add constraint dzea_pk primary key (dzea001) enable validate;

create unique index dzea_pk on dzea_t (dzea001);

grant select on dzea_t to tiptop;
grant update on dzea_t to tiptop;
grant delete on dzea_t to tiptop;
grant insert on dzea_t to tiptop;

exit;
