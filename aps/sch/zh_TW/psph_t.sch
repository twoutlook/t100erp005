/* 
================================================================================
檔案代號:psph_t
檔案名稱:供需配置檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psph_t
(
psphent       number(5)      ,/* 企業編號 */
psphsite       varchar2(10)      ,/* 營運據點 */
psph001       varchar2(10)      ,/* APS版本 */
psph002       varchar2(20)      ,/* 執行日期時間 */
psph003       number(10,0)      ,/* 流水編號 */
psph004       number(10,0)      ,/* 子編號 */
psph005       number(10,0)      ,/* 上階ID */
psph006       number(10,0)      ,/* 階層碼 */
psph007       varchar2(40)      ,/* 供給單號 */
psph008       varchar2(40)      ,/* 被供給單號 */
psph009       varchar2(40)      ,/* 最上階訂單號 */
psph010       varchar2(40)      ,/* 供給單號 */
psph011       varchar2(40)      ,/* 需求來源編號 */
psph012       varchar2(10)      ,/* 需求來源型態 */
psph013       number(10,0)      ,/* 需求序 */
psph014       number(10,0)      ,/* 分配序 */
psph015       number(10,0)      ,/* 替代序 */
psph016       varchar2(10)      ,/* 供給型態 */
psph017       varchar2(500)      ,/* 品號 */
psph018       number(5,0)      ,/* 取替代型態 */
psph019       date      ,/* 需求日 */
psph020       number(20,6)      ,/* 需求數量 */
psph021       number(20,6)      ,/* 預測耗用量 */
psph022       number(20,6)      ,/* 預計短缺量 */
psph023       number(10,0)      ,/* 供給序 */
psph024       varchar2(10)      ,/* 供給庫別 */
psph025       varchar2(10)      ,/* 供給庫位 */
psph026       number(20,6)      ,/* 可供給數量 */
psph027       number(20,6)      ,/* 用量比例 */
psph028       number(15,3)      ,/* 保留欄位 */
psph029       number(20,6)      ,/* 已領用量 */
psph030       varchar2(500)      ,/* 原始需求品號 */
psph031       date      ,/* 供給時間 */
psph032       number(20,6)      ,/* 原供給量 */
psph033       number(10,0)      ,/* 唯一碼 */
psph034       number(10,0)      ,/* 上階唯一碼 */
psph035       number(20,6)      ,/* 主料需求數量 */
psph036       varchar2(500)      ,/* 上階需求料號 */
psph037       number(20,6)      ,/* 虛擬訂單實際需求量 */
psph038       varchar2(40)      ,/* 品號 */
psph039       varchar2(256)      ,/* 特徵碼 */
psph040       varchar2(40)      ,/* 主料品號 */
psph041       varchar2(256)      ,/* 主料特徵碼 */
psph042       varchar2(40)      ,/* 工單品號 */
psph043       varchar2(256)      ,/* 工單特徵碼 */
psph044       number(5,0)      ,/* 聯副產品 */
psph045       varchar2(20)      ,/* 鎖定唯一碼 */
psph046       varchar2(80)      ,/* BOM序號 */
psph047       number(10,0)      /* 領料序號 */
);
alter table psph_t add constraint psph_pk primary key (psphent,psphsite,psph001,psph002,psph003) enable validate;

create  index psph_n on psph_t (psphent,psphsite,psph001,psph002,psph010);
create unique index psph_pk on psph_t (psphent,psphsite,psph001,psph002,psph003);

grant select on psph_t to tiptop;
grant update on psph_t to tiptop;
grant delete on psph_t to tiptop;
grant insert on psph_t to tiptop;

exit;
