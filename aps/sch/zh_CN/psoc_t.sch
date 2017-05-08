/* 
================================================================================
檔案代號:psoc_t
檔案名稱:MPS採購單中介檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psoc_t
(
psocent       number(5)      ,/* 企業編號 */
psocsite       varchar2(10)      ,/* 營運據點 */
psoc001       varchar2(10)      ,/* APS版本 */
psoc002       varchar2(20)      ,/* 執行日期時間 */
psoc003       varchar2(40)      ,/* 採購單編號 */
psoc004       varchar2(500)      ,/* 品號 */
psoc005       number(20,6)      ,/* 預計採購數量 */
psoc006       number(5,0)      ,/* 建議單據 */
psoc007       date      ,/* ERP預計開立日 */
psoc008       date      ,/* ERP預計到廠日 */
psoc009       date      ,/* 預計發放時間 */
psoc010       date      ,/* 預計到廠日期 */
psoc011       varchar2(10)      ,/* 供應商編號 */
psoc012       varchar2(40)      ,/* EPR工單編號 */
psoc013       number(20,6)      ,/* 已入庫數量 */
psoc014       number(5,0)      ,/* 狀態 */
psoc015       number(5,0)      ,/* 鎖定 */
psoc016       number(20,6)      ,/* 待驗量 */
psoc017       number(20,6)      ,/* 待入庫量 */
psoc018       number(20,6)      ,/* 驗退量 */
psoc019       varchar2(10)      ,/* 供應商位置 */
psoc020       varchar2(10)      ,/* 單位 */
psoc021       number(15,3)      ,/* 前置時間 */
psoc022       date      ,/* ERP預計到庫日 */
psoc023       date      ,/* 預計到庫日期 */
psoc024       varchar2(40)      ,/* 品號 */
psoc025       varchar2(256)      ,/* 品號特徵碼 */
psoc026       number(20,6)      ,/* BUSINESS_QTY */
psoc027       varchar2(10)      ,/* BUSINESS_UNIT_ID */
psoc028       number(10,0)      ,/* inspect_day */
psoc029       number(20,6)      ,/* orig_purchase_qty */
psoc030       number(20,6)      /* 可供給量 */
);
alter table psoc_t add constraint psoc_pk primary key (psocent,psocsite,psoc001,psoc002,psoc003) enable validate;

create unique index psoc_pk on psoc_t (psocent,psocsite,psoc001,psoc002,psoc003);

grant select on psoc_t to tiptop;
grant update on psoc_t to tiptop;
grant delete on psoc_t to tiptop;
grant insert on psoc_t to tiptop;

exit;
