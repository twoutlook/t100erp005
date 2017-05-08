/* 
================================================================================
檔案代號:decf_t
檔案名稱:門店單品週結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table decf_t
(
decfent       number(5)      ,/* 企業編號 */
decfsite       varchar2(10)      ,/* 營運據點 */
decf001       varchar2(10)      ,/* 層級類型 */
decf005       varchar2(10)      ,/* 庫區編號 */
decf006       varchar2(10)      ,/* 庫區類型 */
decf007       varchar2(10)      ,/* 存貨管理方式 */
decf008       varchar2(10)      ,/* 庫區業態 */
decf009       varchar2(40)      ,/* 商品編號 */
decf010       varchar2(40)      ,/* 商品條碼 */
decf011       varchar2(255)      ,/* 商品品名 */
decf012       varchar2(255)      ,/* 商品規格 */
decf013       varchar2(20)      ,/* 品牌 */
decf014       varchar2(10)      ,/* 主供應商 */
decf015       varchar2(10)      ,/* 結算方式 */
decf016       varchar2(10)      ,/* 品類編號 */
decf017       varchar2(20)      ,/* 專櫃編號 */
decf018       varchar2(10)      ,/* 稅別編號 */
decf019       number(20,6)      ,/* 稅額 */
decf020       varchar2(10)      ,/* 銷售單位 */
decf021       number(20,6)      ,/* 銷售數量 */
decf022       number(20,6)      ,/* 銷售成本 */
decf023       number(20,6)      ,/* 進價金額 */
decf024       number(20,6)      ,/* 原價金額 */
decf025       number(20,6)      ,/* 未稅金額 */
decf026       number(20,6)      ,/* 應收金額 */
decf027       number(20,6)      ,/* 毛利 */
decf028       number(20,6)      ,/* 毛利率 */
decf029       number(20,6)      ,/* 客單數 */
decf030       number(20,6)      ,/* 促銷銷售數量 */
decf031       number(20,6)      ,/* 促銷應收金額 */
decf032       number(20,6)      ,/* 打折金額 */
decf033       number(20,6)      ,/* 變價金額 */
decf034       number(20,6)      ,/* 退貨金額 */
decf035       number(20,6)      ,/* 後臺銷售數量 */
decf036       number(20,6)      ,/* 後臺進價金額 */
decf037       number(20,6)      ,/* 後臺應收金額 */
decf038       number(20,6)      ,/* 前臺銷售數量 */
decf039       number(20,6)      ,/* 前臺進價金額 */
decf040       number(20,6)      ,/* 前臺應收金額 */
decf041       number(10,0)      ,/* 統計年度月份 */
decf042       number(5,0)      ,/* 統計週期 */
decf043       varchar2(256)      ,/* 產品特徵 */
decf044       number(20,6)      ,/* 退貨單據數 */
decf045       number(20,6)      ,/* 抵扣券金額 */
decf046       number(20,6)      ,/* 會員折扣金額 */
decf047       number(20,6)      ,/* 實收金額 */
decf048       number(20,6)      ,/* 客單價 */
decf049       varchar2(10)      ,/* 經營方式 */
decf051       number(20,6)      ,/* 庫存數量 */
decf052       number(20,6)      ,/* 庫存金額 */
decf053       varchar2(10)      ,/* 管理品類編號 */
decf054       varchar2(20)      /* 合約編號 */
);
alter table decf_t add constraint decf_pk primary key (decfent,decfsite,decf005,decf009,decf014,decf015,decf017,decf018,decf020,decf041,decf042,decf043,decf049,decf053,decf054) enable validate;

create unique index decf_pk on decf_t (decfent,decfsite,decf005,decf009,decf014,decf015,decf017,decf018,decf020,decf041,decf042,decf043,decf049,decf053,decf054);

grant select on decf_t to tiptop;
grant update on decf_t to tiptop;
grant delete on decf_t to tiptop;
grant insert on decf_t to tiptop;

exit;
