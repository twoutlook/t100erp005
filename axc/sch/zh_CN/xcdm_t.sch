/* 
================================================================================
檔案代號:xcdm_t
檔案名稱:期末料件明細單據結存成本要素成本統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcdm_t
(
xcdment       number(5)      ,/* 企業編號 */
xcdmsite       varchar2(10)      ,/* site組織 */
xcdmcomp       varchar2(10)      ,/* 法人組織 */
xcdmld       varchar2(5)      ,/* 帳套 */
xcdm001       varchar2(1)      ,/* 帳套本位幣順序 */
xcdm002       varchar2(30)      ,/* 成本域 */
xcdm003       varchar2(10)      ,/* 成本計算類型 */
xcdm004       number(5,0)      ,/* 年度 */
xcdm005       number(5,0)      ,/* 期別 */
xcdm006       varchar2(20)      ,/* 參考單號 */
xcdm007       number(10,0)      ,/* 項次 */
xcdm008       number(10,0)      ,/* 項序 */
xcdm009       number(5,0)      ,/* 出入庫碼 */
xcdm010       varchar2(10)      ,/* 成本要素 */
xcdm011       varchar2(40)      ,/* 料號 */
xcdm012       varchar2(256)      ,/* 特性 */
xcdm013       varchar2(10)      ,/* 單據類型 */
xcdm014       date      ,/* 單據日期 */
xcdm015       varchar2(8)      ,/* 時間 */
xcdm016       varchar2(10)      ,/* 倉庫編號 */
xcdm017       varchar2(10)      ,/* 儲位編號 */
xcdm018       varchar2(30)      ,/* 批號 */
xcdm020       varchar2(10)      ,/* 異動類型 */
xcdm021       varchar2(10)      ,/* 原因碼 */
xcdm022       varchar2(10)      ,/* 交易對象 */
xcdm023       varchar2(10)      ,/* 客群 */
xcdm024       varchar2(10)      ,/* 區域 */
xcdm025       varchar2(10)      ,/* 成本中心 */
xcdm026       varchar2(10)      ,/* 經營類別 */
xcdm027       varchar2(10)      ,/* 渠道 */
xcdm028       varchar2(10)      ,/* 品類 */
xcdm029       varchar2(10)      ,/* 品牌 */
xcdm030       varchar2(20)      ,/* 項目號 */
xcdm031       varchar2(30)      ,/* WBS */
xcdm032       varchar2(24)      ,/* 存貨科目 */
xcdm033       varchar2(24)      ,/* 費用成本科目 */
xcdm034       varchar2(24)      ,/* 收入科目 */
xcdm040       varchar2(10)      ,/* 交易幣別 */
xcdm041       varchar2(10)      ,/* 本位幣別 */
xcdm042       number(20,10)      ,/* 匯率 */
xcdm043       varchar2(10)      ,/* 交易單位 */
xcdm044       varchar2(10)      ,/* 成本單位 */
xcdm045       number(20,6)      ,/* 換算率 */
xcdm046       number(20,6)      ,/* 交易數量 */
xcdm047       varchar2(20)      ,/* 工單號碼 */
xcdm048       varchar2(10)      ,/* 重複性生產-計畫編號 */
xcdm049       varchar2(40)      ,/* 重複性生產-生產料號 */
xcdm050       varchar2(30)      ,/* 重複性生產-生產料號BOM特性 */
xcdm051       varchar2(256)      ,/* 重複性生產-生產料號產品特徵 */
xcdm055       varchar2(10)      ,/* xccc類型 */
xcdm101       number(20,6)      ,/* 期末結存數量 */
xcdm102       number(20,6)      /* 期末結存金額 */
);
alter table xcdm_t add constraint xcdm_pk primary key (xcdment,xcdmld,xcdm001,xcdm002,xcdm003,xcdm004,xcdm005,xcdm006,xcdm007,xcdm008,xcdm009,xcdm010) enable validate;

create unique index xcdm_pk on xcdm_t (xcdment,xcdmld,xcdm001,xcdm002,xcdm003,xcdm004,xcdm005,xcdm006,xcdm007,xcdm008,xcdm009,xcdm010);

grant select on xcdm_t to tiptop;
grant update on xcdm_t to tiptop;
grant delete on xcdm_t to tiptop;
grant insert on xcdm_t to tiptop;

exit;
