/* 
================================================================================
檔案代號:pspi_t
檔案名稱:訂單結果暫存檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pspi_t
(
pspient       number(5)      ,/* 企業編號 */
pspisite       varchar2(10)      ,/* 營運據點 */
pspi001       varchar2(10)      ,/* APS版本 */
pspi002       varchar2(20)      ,/* 執行日期時間 */
pspi003       varchar2(40)      ,/* 訂單編號 */
pspi004       varchar2(500)      ,/* 品號 */
pspi005       varchar2(10)      ,/* 訂單型式 */
pspi006       date      ,/* 交期 */
pspi007       number(10,0)      ,/* 優先順序 */
pspi008       number(20,6)      ,/* 訂購數量 */
pspi009       number(20,6)      ,/* 已出貨量 */
pspi010       date      ,/* 開立日 */
pspi011       date      ,/* 預計完工日 */
pspi012       number(5,0)      ,/* 納入排程 */
pspi013       number(5,0)      ,/* 嚴守交期 */
pspi014       varchar2(4000)      ,/* 延遲訊息 */
pspi015       date      /* 真實交期 */
);
alter table pspi_t add constraint pspi_pk primary key (pspient,pspisite,pspi001,pspi002,pspi003) enable validate;

create unique index pspi_pk on pspi_t (pspient,pspisite,pspi001,pspi002,pspi003);

grant select on pspi_t to tiptop;
grant update on pspi_t to tiptop;
grant delete on pspi_t to tiptop;
grant insert on pspi_t to tiptop;

exit;
