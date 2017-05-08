/* 
================================================================================
檔案代號:pspt_t
檔案名稱:存貨結果
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pspt_t
(
psptent       number(5)      ,/* 企業編號 */
psptsite       varchar2(10)      ,/* 營運據點 */
pspt001       varchar2(10)      ,/* APS版本 */
pspt002       varchar2(20)      ,/* 執行日期時間 */
pspt003       number(10,0)      ,/* 流水編號 */
pspt004       varchar2(500)      ,/* 品號 */
pspt005       varchar2(10)      ,/* 庫位 */
pspt006       varchar2(10)      ,/* 儲位 */
pspt007       number(20,6)      ,/* 原庫存數 */
pspt008       number(20,6)      ,/* 實際耗用量 */
pspt009       number(20,6)      ,/* 未分配量 */
pspt010       number(20,6)      ,/* 主料替他量 */
pspt011       varchar2(40)      ,/* 料號 */
pspt012       varchar2(256)      ,/* 產品特徵 */
pspt013       varchar2(30)      ,/* 批號 */
pspt014       varchar2(30)      ,/* 庫存管理特徵 */
pspt015       varchar2(1)      /* 保稅否 */
);
alter table pspt_t add constraint pspt_pk primary key (psptent,psptsite,pspt001,pspt002,pspt003) enable validate;

create unique index pspt_pk on pspt_t (psptent,psptsite,pspt001,pspt002,pspt003);

grant select on pspt_t to tiptop;
grant update on pspt_t to tiptop;
grant delete on pspt_t to tiptop;
grant insert on pspt_t to tiptop;

exit;
