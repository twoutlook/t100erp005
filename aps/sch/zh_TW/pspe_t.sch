/* 
================================================================================
檔案代號:pspe_t
檔案名稱:替代供給結果檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pspe_t
(
pspeent       number(5)      ,/* 企業編號 */
pspesite       varchar2(10)      ,/* 營運據點 */
pspe001       varchar2(10)      ,/* APS版本 */
pspe002       varchar2(20)      ,/* 執行日期時間 */
pspe003       varchar2(500)      ,/* 品號 */
pspe004       varchar2(500)      ,/* 替代料號 */
pspe005       number(5,0)      ,/* 供給型態 */
pspe006       varchar2(10)      ,/* 庫別 */
pspe007       varchar2(10)      ,/* 供給庫位 */
pspe008       varchar2(40)      ,/* 工單編號 */
pspe009       varchar2(40)      ,/* 供給採購單編號 */
pspe010       number(20,6)      ,/* 替代料供給量 */
pspe011       number(20,6)      ,/* 替代料供給量 */
pspe012       varchar2(40)      ,/* 品號 */
pspe013       varchar2(256)      ,/* 品號特徵碼 */
pspe014       varchar2(40)      ,/* 替代品號 */
pspe015       varchar2(256)      ,/* 替代特徵碼 */
pspe016       number(10,0)      /* 流水編號 */
);
alter table pspe_t add constraint pspe_pk primary key (pspeent,pspesite,pspe001,pspe002,pspe016) enable validate;

create unique index pspe_pk on pspe_t (pspeent,pspesite,pspe001,pspe002,pspe016);

grant select on pspe_t to tiptop;
grant update on pspe_t to tiptop;
grant delete on pspe_t to tiptop;
grant insert on pspe_t to tiptop;

exit;
