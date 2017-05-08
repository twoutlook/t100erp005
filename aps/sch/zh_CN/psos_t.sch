/* 
================================================================================
檔案代號:psos_t
檔案名稱:工單結果檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psos_t
(
psosent       number(5)      ,/* 企業編號 */
psossite       varchar2(10)      ,/* 營運據點 */
psos001       varchar2(10)      ,/* APS版本 */
psos002       varchar2(20)      ,/* 執行日期時間 */
psos004       varchar2(40)      ,/* 工單編號 */
psos005       number(20,6)      ,/* 需求數量 */
psos006       varchar2(40)      ,/* EPR工單編號 */
psos007       date      ,/* ERP預計完工日 */
psos008       date      ,/* ERP預計開立日 */
psos009       number(5,0)      ,/* 建議單據 */
psos010       varchar2(500)      ,/* 品號 */
psos011       date      ,/* 預計完工時間 */
psos012       date      ,/* 預計發放時間 */
psos013       number(10,0)      ,/* 優先順序 */
psos014       number(20,6)      ,/* 開立數量 */
psos015       varchar2(80)      ,/* 途程編號 */
psos016       number(5,0)      ,/* 品項型式 */
psos017       varchar2(10)      ,/* 單位 */
psos018       number(5,0)      ,/* 完全發料 */
psos019       number(5,0)      ,/* ATP開立 */
psos020       varchar2(30)      ,/* 計畫批號 */
psos021       varchar2(40)      ,/* 主要訂單 */
psos022       varchar2(40)      ,/* 上階工單 */
psos023       varchar2(40)      ,/* 上階的來源工單 */
psos024       number(20,6)      ,/* 已生產量 */
psos025       number(20,6)      ,/* 未分配量 */
psos026       number(20,6)      ,/* 報廢數量 */
psos027       varchar2(20)      ,/* 擁有者 */
psos028       number(5,0)      ,/* 狀態 */
psos029       varchar2(10)      ,/* 規劃時之單位 */
psos030       number(20,6)      ,/* 轉換率 */
psos031       date      ,/* 理想完工日 */
psos032       date      ,/* 物料限制時間 */
psos033       number(20,6)      ,/* 主料替他量 */
psos034       number(20,6)      ,/* 預計短缺量 */
psos035       number(20,6)      ,/* 實際耗用量 */
psos036       number(20,6)      ,/* 建議量 */
psos037       varchar2(20)      ,/* 新擁有者 */
psos038       number(5,0)      ,/* 使用工單製程 */
psos039       varchar2(10)      ,/* 供給法則 */
psos040       number(5,0)      ,/* 自動轉外包工單 */
psos041       number(5,0)      ,/* 自動外購取消 */
psos042       varchar2(10)      ,/* 外包商編號 */
psos043       varchar2(10)      ,/* 原供給法則 */
psos044       number(5,0)      ,/* 外包碼 */
psos045       number(20,6)      ,/* 建議開立量 */
psos046       number(5,0)      ,/* 多餘量開單模式 */
psos047       number(20,6)      ,/* MOD訂單耗用量 */
psos048       date      ,/* 理想開工日 */
psos049       number(20,6)      ,/* 預測耗用量 */
psos050       number(20,6)      ,/* 虛擬訂單實際需求量 */
psos051       varchar2(80)      ,/* MP途程編號 */
psos052       number(5,0)      ,/* 外包 */
psos053       number(5,0)      ,/* 供給法則生效 */
psos054       varchar2(40)      ,/* 品號 */
psos055       varchar2(256)      ,/* 品號特徵碼 */
psos056       date      ,/* 批工單預計移轉日 */
psos057       varchar2(1)      ,/* 已產生單據 */
psos058       varchar2(40)      ,/* 產生工單單號 */
psos059       number(20,6)      ,/* inventory_kit */
psos060       varchar2(1)      ,/* 鎖定 */
psos061       number(20,6)      ,/* 可供給量 */
psos062       number(20,6)      /* 已轉數量 */
);
alter table psos_t add constraint psos_pk primary key (psosent,psossite,psos001,psos002,psos004) enable validate;

create unique index psos_pk on psos_t (psosent,psossite,psos001,psos002,psos004);

grant select on psos_t to tiptop;
grant update on psos_t to tiptop;
grant delete on psos_t to tiptop;
grant insert on psos_t to tiptop;

exit;
