/* 
================================================================================
檔案代號:psoq_t
檔案名稱:需求訂單結果檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psoq_t
(
psoqent       number(5)      ,/* 企業編號 */
psoqsite       varchar2(10)      ,/* 營運據點 */
psoq001       varchar2(10)      ,/* APS版本 */
psoq002       varchar2(20)      ,/* 執行日期時間 */
psoq004       varchar2(40)      ,/* 訂單編號 */
psoq005       varchar2(500)      ,/* 品號 */
psoq006       number(20,6)      ,/* 訂購數量 */
psoq007       date      ,/* 交期 */
psoq008       number(5,0)      ,/* 可沖銷 */
psoq009       varchar2(10)      ,/* 客戶編號 */
psoq010       varchar2(10)      ,/* 客戶群組 */
psoq011       number(5,0)      ,/* 納入排程 */
psoq012       varchar2(10)      ,/* 訂單型式 */
psoq013       varchar2(10)      ,/* 產品族品號 */
psoq014       number(10,0)      ,/* 優先順序 */
psoq015       varchar2(40)      ,/* 銷售訂單編號 */
psoq016       varchar2(20)      ,/* 客戶單號 */
psoq017       number(20,6)      ,/* 已出貨量 */
psoq018       number(20,6)      ,/* 可完工量 */
psoq019       number(20,6)      ,/* 預測耗用量 */
psoq020       number(20,6)      ,/* 短缺量 */
psoq021       number(20,6)      ,/* 實際短缺量 */
psoq022       number(20,6)      ,/* 生產量 */
psoq023       date      ,/* 開立日 */
psoq024       date      ,/* 預計完工日 */
psoq025       number(5,0)      ,/* 可排程 */
psoq026       varchar2(10)      ,/* 錯誤訊息 */
psoq027       varchar2(500)      ,/* 延遲訊息 */
psoq028       varchar2(80)      ,/* 短缺訊息 */
psoq029       varchar2(10)      ,/* 保留欄位 */
psoq030       date      ,/* 預計開工日 */
psoq031       date      ,/* 預計完工日 */
psoq032       varchar2(10)      ,/* 單位 */
psoq033       number(5,0)      ,/* 客供缺料 */
psoq034       varchar2(20)      ,/* 擁有者 */
psoq035       varchar2(20)      ,/* 訂單規劃者 */
psoq036       varchar2(20)      ,/* 採購者 */
psoq037       number(20,6)      ,/* 轉換率 */
psoq038       date      ,/* 訂單開立日期 */
psoq039       varchar2(10)      ,/* 規劃時之單位 */
psoq040       number(5,0)      ,/* 嚴守交期 */
psoq041       number(15,3)      ,/* 保留欄位 */
psoq042       date      ,/* 真實交期 */
psoq043       varchar2(40)      ,/* 品號 */
psoq044       varchar2(256)      /* 品號特徵碼 */
);
alter table psoq_t add constraint psoq_pk primary key (psoqent,psoqsite,psoq001,psoq002,psoq004) enable validate;

create unique index psoq_pk on psoq_t (psoqent,psoqsite,psoq001,psoq002,psoq004);

grant select on psoq_t to tiptop;
grant update on psoq_t to tiptop;
grant delete on psoq_t to tiptop;
grant insert on psoq_t to tiptop;

exit;
