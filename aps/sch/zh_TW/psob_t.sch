/* 
================================================================================
檔案代號:psob_t
檔案名稱:MPS單據關連中介檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psob_t
(
psobent       number(5)      ,/* 企業編號 */
psobsite       varchar2(10)      ,/* 營運據點 */
psob001       varchar2(10)      ,/* APS版本 */
psob002       varchar2(20)      ,/* 執行日期時間 */
psob003       varchar2(40)      ,/* 供給單號 */
psob004       number(20,6)      ,/* 需求數量 */
psob005       varchar2(40)      ,/* 被供給單號 */
psob006       number(5,0)      ,/* 訂單需求 */
psob007       number(20,6)      ,/* 供給數量 */
psob008       number(5,0)      ,/* 採購件 */
psob009       number(20,6)      ,/* 可供給數量 */
psob010       number(5,0)      ,/* 鎖定供需 */
psob011       varchar2(500)      ,/* 品號 */
psob012       date      ,/* 需求日期 */
psob013       number(10,0)      ,/* 配置順序 */
psob014       number(5,0)      ,/* 最關鍵採購 */
psob015       varchar2(40)      ,/* 品號 */
psob016       varchar2(256)      ,/* 品號特徵碼 */
psob017       number(5,0)      ,/* 聯副產品 */
psob018       number(20,6)      /* unit_qty */
);
alter table psob_t add constraint psob_pk primary key (psobent,psobsite,psob001,psob002,psob013) enable validate;

create unique index psob_pk on psob_t (psobent,psobsite,psob001,psob002,psob013);

grant select on psob_t to tiptop;
grant update on psob_t to tiptop;
grant delete on psob_t to tiptop;
grant insert on psob_t to tiptop;

exit;
