/* 
================================================================================
檔案代號:psox_t
檔案名稱:建議工單聯副產品檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psox_t
(
psoxent       number(5)      ,/* 企業編號 */
psoxsite       varchar2(10)      ,/* 營運據點 */
psox001       varchar2(10)      ,/* APS版本 */
psox002       varchar2(20)      ,/* 執行日期時間 */
psox003       varchar2(40)      ,/* 工單編號 */
psox004       varchar2(40)      ,/* 品號 */
psox005       varchar2(256)      ,/* 品號特徵碼 */
psox006       varchar2(10)      ,/* 產出類型 */
psox007       number(20,6)      ,/* 預計產出數量 */
psox008       number(20,6)      ,/* 產出比率 */
psox009       number(20,6)      ,/* 成本利率 */
psox010       varchar2(500)      ,/* 備註 */
psox011       number(20,6)      ,/* 實際耗用量 */
psox012       number(20,6)      ,/* 建議開立量 */
psox013       number(20,6)      ,/* 虛擬建議開立量 */
psox014       number(20,6)      ,/* MOD訂單耗用量 */
psox015       number(20,6)      /* 虛擬訂單實際需求量 */
);
alter table psox_t add constraint psox_pk primary key (psoxent,psoxsite,psox001,psox002,psox003,psox004,psox005) enable validate;

create unique index psox_pk on psox_t (psoxent,psoxsite,psox001,psox002,psox003,psox004,psox005);

grant select on psox_t to tiptop;
grant update on psox_t to tiptop;
grant delete on psox_t to tiptop;
grant insert on psox_t to tiptop;

exit;
