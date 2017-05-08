/* 
================================================================================
檔案代號:pspc_t
檔案名稱:採購單結果檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pspc_t
(
pspcent       number(5)      ,/* 企業編號 */
pspcsite       varchar2(10)      ,/* 營運據點 */
pspc001       varchar2(10)      ,/* APS版本 */
pspc002       varchar2(20)      ,/* 執行日期時間 */
pspc004       varchar2(40)      ,/* 採購單編號 */
pspc005       varchar2(500)      ,/* 品號 */
pspc006       number(20,6)      ,/* 預計採購數量 */
pspc007       number(5,0)      ,/* 建議單據 */
pspc008       date      ,/* ERP預計開立日 */
pspc009       date      ,/* ERP預計到廠日 */
pspc010       date      ,/* 預計發放時間 */
pspc011       date      ,/* 預計到廠日期 */
pspc012       varchar2(10)      ,/* 供應商編號 */
pspc013       varchar2(40)      ,/* EPR工單編號 */
pspc014       varchar2(10)      ,/* 單位 */
pspc015       varchar2(30)      ,/* 計畫批號 */
pspc016       number(5,0)      ,/* ATP開立 */
pspc017       varchar2(10)      ,/* 供應商位置 */
pspc018       varchar2(40)      ,/* 主要訂單 */
pspc019       varchar2(40)      ,/* 上階工單 */
pspc020       varchar2(40)      ,/* 上階的來源工單 */
pspc021       number(20,6)      ,/* 已入庫數量 */
pspc022       number(20,6)      ,/* 未分配量 */
pspc023       number(5,0)      ,/* 保留狀態 */
pspc024       varchar2(20)      ,/* 擁有者 */
pspc025       number(5,0)      ,/* 狀態 */
pspc026       varchar2(10)      ,/* 規劃時之單位 */
pspc027       number(20,6)      ,/* 轉換率 */
pspc028       number(5,0)      ,/* 鎖定 */
pspc029       number(20,6)      ,/* 待驗量 */
pspc030       number(20,6)      ,/* 待入庫量 */
pspc031       number(20,6)      ,/* 驗退量 */
pspc032       number(20,6)      ,/* 主料替他量 */
pspc033       number(20,6)      ,/* 實際耗用量 */
pspc034       number(20,6)      ,/* 建議量 */
pspc035       date      ,/* 理想完工日 */
pspc036       varchar2(20)      ,/* 新擁有者 */
pspc037       varchar2(10)      ,/* 供給法則 */
pspc038       number(5,0)      ,/* 製造轉採購單 */
pspc039       number(5,0)      ,/* 自動外購取消 */
pspc040       varchar2(40)      ,/* 自動轉外購前的工單單號 */
pspc041       varchar2(10)      ,/* 原供給法則 */
pspc042       number(15,3)      ,/* 前置時間 */
pspc043       number(20,6)      ,/* 建議開立量 */
pspc044       date      ,/* ERP預計到庫日 */
pspc045       date      ,/* 預計到庫日期 */
pspc046       number(20,6)      ,/* MOD訂單耗用量 */
pspc047       date      ,/* 理想開工日 */
pspc048       number(20,6)      ,/* 預測耗用量 */
pspc049       number(20,6)      ,/* 虛擬訂單實際需求量 */
pspc050       varchar2(40)      ,/* 品號 */
pspc051       varchar2(256)      ,/* 品號特徵碼 */
pspc052       number(5,0)      ,/* 延遲到貨 */
pspc053       number(10,0)      ,/* 延遲天數 */
pspc054       varchar2(1)      ,/* 已產生單據 */
pspc055       varchar2(40)      ,/* 產生單號 */
pspc056       number(10,0)      ,/* 產生項次 */
pspc057       number(10,0)      ,/* inspect_day */
pspc058       number(20,6)      ,/* orig_purchase_qty */
pspc059       number(20,6)      ,/* part_spare_qty */
pspc060       number(20,6)      ,/* 可供給量 */
pspc061       number(20,6)      ,/* 已轉數量 */
pspc062       varchar2(1)      /* 保稅否 */
);
alter table pspc_t add constraint pspc_pk primary key (pspcent,pspcsite,pspc001,pspc002,pspc004) enable validate;

create unique index pspc_pk on pspc_t (pspcent,pspcsite,pspc001,pspc002,pspc004);

grant select on pspc_t to tiptop;
grant update on pspc_t to tiptop;
grant delete on pspc_t to tiptop;
grant insert on pspc_t to tiptop;

exit;
