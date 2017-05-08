/* 
================================================================================
檔案代號:psov_t
檔案名稱:單據追朔執行結果檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psov_t
(
psovent       number(5)      ,/* 企業編號 */
psovsite       varchar2(10)      ,/* 營運據點 */
psov001       varchar2(10)      ,/* APS版本 */
psov002       varchar2(20)      ,/* 執行日期時間 */
psov003       varchar2(40)      ,/* 供給單號 */
psov004       number(20, 6)      ,/* 需求數量 */
psov005       varchar2(40)      ,/* 被供給單號 */
psov006       number(5,0)      ,/* 訂單需求 */
psov007       number(20, 6)      ,/* 供給數量 */
psov008       number(5,0)      ,/* 採購件 */
psov009       number(20, 6)      ,/* 可供給數量 */
psov010       number(5,0)      ,/* 鎖定供需 */
psov011       varchar2(500)      ,/* 品號 */
psov012       date      ,/* 需求日期 */
psov013       number(10,0)      ,/* 配置順序 */
psov014       number(5,0)      ,/* 最關鍵採購 */
psov015       varchar2(40)      ,/* 品號 */
psov016       varchar2(256)      ,/* 品號特徵碼 */
psov017       varchar2(40)      ,/* 原始需求品號 */
psov018       varchar2(40)      ,/* 需求(主料)品號 */
psov019       varchar2(256)      ,/* 需求品號特徵碼 */
psov020       number(5,0)      ,/* 取替代型態 */
psov021       varchar2(20)      ,/* 唯一碼 */
psov022       number(5,0)      ,/* 聯副產品 */
psov023       number(20, 6)      ,/* 供應套數 */
psov024       varchar2(20)      ,/* 最上階訂單號 */
psov025       number(10,0)      /* 領料序 */
);
alter table psov_t add constraint psov_pk primary key (psovent,psovsite,psov001,psov002,psov013) enable validate;


grant select on psov_t to tiptop;
grant update on psov_t to tiptop;
grant delete on psov_t to tiptop;
grant insert on psov_t to tiptop;

exit;
