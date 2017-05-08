/* 
================================================================================
檔案代號:xccl_t
檔案名稱:本期料件明細出庫沖銷明細入庫成本檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xccl_t
(
xcclent       number(5)      ,/* 企業編號 */
xcclcomp       varchar2(10)      ,/* 法人組織 */
xcclld       varchar2(5)      ,/* 帳套 */
xccl001       varchar2(1)      ,/* 帳套本位幣順序 */
xccl002       varchar2(30)      ,/* 成本域 */
xccl003       varchar2(10)      ,/* 成本計算類型 */
xccl004       number(5,0)      ,/* 年度 */
xccl005       number(5,0)      ,/* 期別 */
xccl006       varchar2(20)      ,/* 出庫單號 */
xccl007       number(5,0)      ,/* 項次 */
xccl008       number(5,0)      ,/* 項序 */
xccl009       varchar2(20)      ,/* 沖銷入庫單號 */
xccl010       number(5,0)      ,/* 項次 */
xccl011       number(5,0)      ,/* 項序 */
xccl012       varchar2(40)      ,/* 料號 */
xccl013       varchar2(256)      ,/* 產品特徵 */
xccl014       varchar2(10)      ,/* 單據類型 */
xccl015       date      ,/* 單據日期 */
xccl016       varchar2(8)      ,/* 時間 */
xccl017       varchar2(10)      ,/* 倉庫編號 */
xccl018       varchar2(10)      ,/* 儲位編號 */
xccl019       varchar2(30)      ,/* 批號 */
xccl020       varchar2(10)      ,/* 異動類型 */
xccl021       varchar2(10)      ,/* 原因碼 */
xccl022       varchar2(10)      ,/* 交易對象 */
xccl023       varchar2(10)      ,/* 客群 */
xccl024       varchar2(10)      ,/* 區域 */
xccl025       varchar2(10)      ,/* 成本中心 */
xccl026       varchar2(10)      ,/* 經營類別 */
xccl027       varchar2(10)      ,/* 渠道 */
xccl028       varchar2(10)      ,/* 品類 */
xccl029       varchar2(10)      ,/* 品牌 */
xccl030       varchar2(20)      ,/* 項目號 */
xccl031       varchar2(30)      ,/* WBS */
xccl032       varchar2(24)      ,/* 存貨科目 */
xccl033       varchar2(24)      ,/* 費用成本科目 */
xccl034       varchar2(24)      ,/* 收入科目 */
xccl040       varchar2(10)      ,/* 交易幣別 */
xccl041       varchar2(10)      ,/* 本位幣別 */
xccl042       number(20,10)      ,/* 匯率 */
xccl043       varchar2(10)      ,/* 交易單位 */
xccl044       varchar2(10)      ,/* 成本單位 */
xccl045       number(20,6)      ,/* 換算率 */
xccl046       number(20,6)      ,/* 交易數量 */
xccl047       varchar2(20)      ,/* 工單號碼 */
xccl048       varchar2(10)      ,/* 重複性生產-計畫編號 */
xccl049       varchar2(40)      ,/* 重複性生產-生產料號 */
xccl050       varchar2(30)      ,/* 重複性生產-生產料號BOM特性 */
xccl051       varchar2(256)      ,/* 重複性生產-生產料號產品特徵 */
xccl055       varchar2(10)      ,/* xccc類型 */
xccl101       number(20,6)      ,/* 沖銷數量 */
xccl102       number(20,6)      ,/* 沖銷金額 */
xccl102a       number(20,6)      ,/* 沖銷金額-材料 */
xccl102b       number(20,6)      ,/* 沖銷金額-人工 */
xccl102c       number(20,6)      ,/* 沖銷金額-加工費 */
xccl102d       number(20,6)      ,/* 沖銷金額-制費一 */
xccl102e       number(20,6)      ,/* 沖銷金額-制費二 */
xccl102f       number(20,6)      ,/* 沖銷金額-制費三 */
xccl102g       number(20,6)      ,/* 沖銷金額-制費四 */
xccl102h       number(20,6)      ,/* 沖銷金額-制費五 */
xcclownid       varchar2(20)      ,/* 資料所有者 */
xcclowndp       varchar2(10)      ,/* 資料所屬部門 */
xcclcrtid       varchar2(20)      ,/* 資料建立者 */
xcclcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcclcrtdt       timestamp(0)      ,/* 資料創建日 */
xcclmodid       varchar2(20)      ,/* 資料修改者 */
xcclmoddt       timestamp(0)      ,/* 最近修改日 */
xcclstus       varchar2(10)      /* 狀態碼 */
);
alter table xccl_t add constraint xccl_pk primary key (xcclent,xcclld,xccl001,xccl002,xccl003,xccl004,xccl005,xccl006,xccl007,xccl008,xccl009,xccl010,xccl011) enable validate;

create unique index xccl_pk on xccl_t (xcclent,xcclld,xccl001,xccl002,xccl003,xccl004,xccl005,xccl006,xccl007,xccl008,xccl009,xccl010,xccl011);

grant select on xccl_t to tiptop;
grant update on xccl_t to tiptop;
grant delete on xccl_t to tiptop;
grant insert on xccl_t to tiptop;

exit;
