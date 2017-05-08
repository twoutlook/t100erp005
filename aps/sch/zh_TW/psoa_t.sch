/* 
================================================================================
檔案代號:psoa_t
檔案名稱:MPS工單中介檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psoa_t
(
psoaent       number(5)      ,/* 企業編號 */
psoasite       varchar2(10)      ,/* 營運據點 */
psoa001       varchar2(10)      ,/* APS版本 */
psoa002       varchar2(20)      ,/* 執行日期時間 */
psoa003       varchar2(40)      ,/* 工單編號 */
psoa004       number(20,6)      ,/* 需求數量 */
psoa005       number(20,6)      ,/* 已生產量 */
psoa006       varchar2(40)      ,/* EPR工單編號 */
psoa007       date      ,/* ERP預計完工日 */
psoa008       date      ,/* ERP預計開立日 */
psoa009       varchar2(500)      ,/* 品號 */
psoa010       varchar2(80)      ,/* 途程編號 */
psoa011       number(20,6)      ,/* 報廢數量 */
psoa012       number(5,0)      ,/* 狀態 */
psoa013       date      ,/* 物料限制時間 */
psoa014       number(5,0)      ,/* 建議單據 */
psoa015       date      ,/* 預計完工時間 */
psoa016       date      ,/* 預計發放時間 */
psoa017       number(5,0)      ,/* 使用工單製程 */
psoa018       number(5,0)      ,/* 外包 */
psoa019       varchar2(10)      ,/* 外包商編號 */
psoa020       varchar2(10)      ,/* 單位 */
psoa021       number(5,0)      ,/* 鎖定 */
psoa022       varchar2(40)      ,/* 品號 */
psoa023       varchar2(256)      ,/* 品號特徵碼 */
psoa024       date      ,/* bw_release_date */
psoa025       date      /* bw_complete_date */
);
alter table psoa_t add constraint psoa_pk primary key (psoaent,psoasite,psoa001,psoa002,psoa003) enable validate;

create unique index psoa_pk on psoa_t (psoaent,psoasite,psoa001,psoa002,psoa003);

grant select on psoa_t to tiptop;
grant update on psoa_t to tiptop;
grant delete on psoa_t to tiptop;
grant insert on psoa_t to tiptop;

exit;
