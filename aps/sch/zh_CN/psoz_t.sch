/* 
================================================================================
檔案代號:psoz_t
檔案名稱:MRP結果檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psoz_t
(
psozent       number(5)      ,/* 企業編號 */
psozsite       varchar2(10)      ,/* 營運據點 */
psoz001       varchar2(10)      ,/* APS版本 */
psoz002       varchar2(20)      ,/* 執行日期時間 */
psoz003       number(10,0)      ,/* 流水編號 */
psoz004       date      ,/* 供需日期 */
psoz005       number(20,6)      ,/* 訂單未交量 */
psoz006       number(20,6)      ,/* 計畫出貨量 */
psoz007       number(20,6)      ,/* 安全庫存量 */
psoz008       number(20,6)      ,/* ATP需求量 */
psoz009       number(20,6)      ,/* 訂單未交替他需求量 */
psoz010       number(20,6)      ,/* 預測替他需求量 */
psoz011       number(20,6)      ,/* ATP替他需求量 */
psoz012       number(20,6)      ,/* 計劃備料量 */
psoz013       number(20,6)      ,/* 計劃備料替他需求量 */
psoz014       number(20,6)      ,/* 工單備料量 */
psoz015       number(20,6)      ,/* 工單備料替他需求量 */
psoz016       number(20,6)      ,/* 備料重排減少量 */
psoz017       number(20,6)      ,/* 備料重排增加量 */
psoz018       number(20,6)      ,/* 庫存單位數量 */
psoz019       number(20,6)      ,/* 採購待入庫數量 */
psoz020       number(20,6)      ,/* 替代庫存量 */
psoz021       number(20,6)      ,/* 請購量 */
psoz022       number(20,6)      ,/* 待進貨量 */
psoz023       number(20,6)      ,/* 待撥入量 */
psoz024       number(20,6)      ,/* 未發放在製量 */
psoz025       number(20,6)      ,/* 已發放在製量 */
psoz026       number(20,6)      ,/* 替代請購量 */
psoz027       number(20,6)      ,/* 替代採購量 */
psoz028       number(20,6)      ,/* 替代在製量 */
psoz029       number(20,6)      ,/* 重排減少量 */
psoz030       number(20,6)      ,/* 重排增加量 */
psoz031       number(20,6)      ,/* 預估結存 */
psoz032       number(20,6)      ,/* 規劃採購量 */
psoz033       number(20,6)      ,/* 替代規劃採購量 */
psoz034       number(20,6)      ,/* 規劃製造量 */
psoz035       number(20,6)      ,/* 替代規劃製造量 */
psoz036       number(20,6)      ,/* 預計結存 */
psoz037       number(20,6)      ,/* 規劃結存 */
psoz038       varchar2(40)      ,/* 品號 */
psoz039       varchar2(256)      ,/* 品號特徵碼 */
psoz040       varchar2(10)      ,/* 時距編號(GUID) */
psoz041       number(20,6)      ,/* 採購在驗數量 */
psoz042       number(20,6)      /* 行政保留量 */
);
alter table psoz_t add constraint psoz_pk primary key (psozent,psozsite,psoz001,psoz002,psoz003,psoz004,psoz038,psoz039) enable validate;

create unique index psoz_pk on psoz_t (psozent,psozsite,psoz001,psoz002,psoz003,psoz004,psoz038,psoz039);

grant select on psoz_t to tiptop;
grant update on psoz_t to tiptop;
grant delete on psoz_t to tiptop;
grant insert on psoz_t to tiptop;

exit;
