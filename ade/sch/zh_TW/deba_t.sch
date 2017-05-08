/* 
================================================================================
檔案代號:deba_t
檔案名稱:門店單品日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table deba_t
(
debaent       number(5)      ,/* 企業編號 */
debasite       varchar2(10)      ,/* 營運據點 */
deba001       varchar2(10)      ,/* 層級類型 */
deba002       date      ,/* 統計日期 */
deba003       number(5,0)      ,/* 會計週 */
deba004       number(5,0)      ,/* 會計期 */
deba005       varchar2(10)      ,/* 庫區編號 */
deba006       varchar2(10)      ,/* 庫區類型 */
deba007       varchar2(10)      ,/* 存貨管理方式 */
deba008       varchar2(10)      ,/* 庫區業態 */
deba009       varchar2(40)      ,/* 商品編號 */
deba010       varchar2(40)      ,/* 商品條碼 */
deba011       varchar2(255)      ,/* 商品品名 */
deba012       varchar2(255)      ,/* 商品規格 */
deba013       varchar2(20)      ,/* 品牌 */
deba014       varchar2(10)      ,/* 主供應商 */
deba015       varchar2(10)      ,/* 結算方式 */
deba016       varchar2(10)      ,/* 品類編號 */
deba017       varchar2(20)      ,/* 專櫃編號 */
deba018       varchar2(10)      ,/* 稅別編號 */
deba019       number(20,6)      ,/* 稅額 */
deba020       varchar2(10)      ,/* 銷售單位 */
deba021       number(20,6)      ,/* 銷售數量 */
deba022       number(20,6)      ,/* 銷售成本 */
deba023       number(20,6)      ,/* 進價金額 */
deba024       number(20,6)      ,/* 原價金額 */
deba025       number(20,6)      ,/* 未稅金額 */
deba026       number(20,6)      ,/* 應收金額 */
deba027       number(20,6)      ,/* 毛利 */
deba028       number(20,6)      ,/* 毛利率 */
deba029       number(20,6)      ,/* 客單數 */
deba030       number(20,6)      ,/* 促銷銷售數量 */
deba031       number(20,6)      ,/* 促銷應收金額 */
deba032       number(20,6)      ,/* 打折金額 */
deba033       number(20,6)      ,/* 變價金額 */
deba034       number(20,6)      ,/* 退貨金額 */
deba035       number(20,6)      ,/* 後臺銷售數量 */
deba036       number(20,6)      ,/* 後臺進價金額 */
deba037       number(20,6)      ,/* 後臺應收金額 */
deba038       number(20,6)      ,/* 前臺銷售數量 */
deba039       number(20,6)      ,/* 前臺進價金額 */
deba040       number(20,6)      ,/* 前臺應收金額 */
deba041       number(5,0)      ,/* 統計年度 */
deba042       number(5,0)      ,/* 統計月份 */
deba043       varchar2(256)      ,/* 產品特徵 */
deba044       number(20,6)      ,/* 退貨單據數 */
deba045       number(20,6)      ,/* 抵扣券金額 */
deba046       number(20,6)      ,/* 會員折扣金額 */
deba047       number(20,6)      ,/* 實收金額 */
deba048       number(20,6)      ,/* 客單價 */
deba049       varchar2(10)      ,/* 經營方式 */
deba050       number(20,6)      ,/* 結算扣率 */
deba051       number(20,6)      ,/* 庫存數量 */
deba052       number(20,6)      ,/* 庫存金額 */
deba053       varchar2(10)      ,/* 管理品類編號 */
deba054       varchar2(20)      /* 合約編號 */
);
alter table deba_t add constraint deba_pk primary key (debaent,debasite,deba002,deba005,deba009,deba017,deba018,deba020,deba043) enable validate;

create  index deba_n01 on deba_t (debaent,debasite,deba002,deba005,deba049);
create unique index deba_pk on deba_t (debaent,debasite,deba002,deba005,deba009,deba017,deba018,deba020,deba043);

grant select on deba_t to tiptop;
grant update on deba_t to tiptop;
grant delete on deba_t to tiptop;
grant insert on deba_t to tiptop;

exit;
