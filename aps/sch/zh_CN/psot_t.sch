/* 
================================================================================
檔案代號:psot_t
檔案名稱:相依性需求結果檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psot_t
(
psotent       number(5)      ,/* 企業編號 */
psotsite       varchar2(10)      ,/* 營運據點 */
psot001       varchar2(10)      ,/* APS版本 */
psot002       varchar2(20)      ,/* 執行日期時間 */
psot003       varchar2(40)      ,/* 工單編號 */
psot004       number(10,0)      ,/* 領料序 */
psot005       number(10,0)      ,/* 需求序號 */
psot006       varchar2(500)      ,/* 元件品號 */
psot007       date      ,/* 預計完工日 */
psot008       date      ,/* 開立日 */
psot009       varchar2(500)      ,/* 主件品號 */
psot010       varchar2(30)      ,/* 計畫批號 */
psot011       date      ,/* 預計領用日 */
psot012       number(20,6)      ,/* 應領用量 */
psot013       number(5,0)      ,/* 自動領料 */
psot014       varchar2(40)      ,/* EPR工單編號 */
psot015       varchar2(500)      ,/* 原主料料號 */
psot016       varchar2(500)      ,/* 上階需求料號 */
psot017       number(20,6)      ,/* 耗率數量 */
psot018       number(5,0)      ,/* 客供料 */
psot019       number(5,0)      ,/* 取替代型態 */
psot020       varchar2(40)      ,/* 品號 */
psot021       varchar2(256)      ,/* 品號特徵碼 */
psot022       varchar2(40)      ,/* 工單品號 */
psot023       varchar2(256)      ,/* 工單特徵碼 */
psot024       varchar2(40)      ,/* 需求(主料)品號 */
psot025       varchar2(256)      ,/* 需求品號特徵碼 */
psot026       varchar2(40)      ,/* 上階品號 */
psot027       varchar2(256)      ,/* 上階特徵碼 */
psot028       varchar2(10)      ,/* 材料類型 */
psot029       number(20,6)      ,/* 超領率 */
psot030       number(20,6)      ,/* 缺領率 */
psot031       varchar2(10)      ,/* 作業編號 */
psot032       number(15,3)      ,/* 投料間距 */
psot033       number(20,6)      ,/* 被取代數量 */
psot034       varchar2(10)      ,/* 替代群組碼 */
psot035       varchar2(10)      ,/* 群組碼 */
psot036       number(20,6)      ,/* 供應套數 */
psot037       varchar2(10)      ,/* BOM序號 */
psot038       varchar2(10)      ,/* BOM順序號 */
psot039       number(20,6)      ,/* 領料用量(變動) */
psot040       number(20,6)      ,/* 領料用量(固定) */
psot041       varchar2(10)      ,/* 部位 */
psot042       varchar2(10)      /* 作業序 */
);
alter table psot_t add constraint psot_pk primary key (psotent,psotsite,psot001,psot002,psot003,psot004,psot005) enable validate;

create unique index psot_pk on psot_t (psotent,psotsite,psot001,psot002,psot003,psot004,psot005);

grant select on psot_t to tiptop;
grant update on psot_t to tiptop;
grant delete on psot_t to tiptop;
grant insert on psot_t to tiptop;

exit;
