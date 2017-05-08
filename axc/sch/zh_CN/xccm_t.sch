/* 
================================================================================
檔案代號:xccm_t
檔案名稱:期末料件明細單據結存成本統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xccm_t
(
xccment       number(5)      ,/* 企業編號 */
xccmsite       varchar2(10)      ,/* site組織 */
xccmcomp       varchar2(10)      ,/* 法人組織 */
xccmld       varchar2(5)      ,/* 帳套 */
xccm001       varchar2(1)      ,/* 帳套本位幣順序 */
xccm002       varchar2(30)      ,/* 成本域 */
xccm003       varchar2(10)      ,/* 成本計算類型 */
xccm004       number(5,0)      ,/* 年度 */
xccm005       number(5,0)      ,/* 期別 */
xccm006       varchar2(20)      ,/* 參考單號 */
xccm007       number(5,0)      ,/* 項次 */
xccm008       number(5,0)      ,/* 項序 */
xccm009       number(5,0)      ,/* 出入庫碼 */
xccm010       varchar2(40)      ,/* 料號 */
xccm011       varchar2(256)      ,/* 特性 */
xccm012       varchar2(10)      ,/* 單據類型 */
xccm013       date      ,/* 單據日期 */
xccm014       varchar2(8)      ,/* 時間 */
xccm015       varchar2(10)      ,/* 倉庫編號 */
xccm016       varchar2(10)      ,/* 儲位編號 */
xccm017       varchar2(30)      ,/* 批號 */
xccm020       varchar2(10)      ,/* 異動類型 */
xccm021       varchar2(10)      ,/* 原因碼 */
xccm022       varchar2(10)      ,/* 交易對象 */
xccm023       varchar2(10)      ,/* 客群 */
xccm024       varchar2(10)      ,/* 區域 */
xccm025       varchar2(10)      ,/* 成本中心 */
xccm026       varchar2(10)      ,/* 經營類別 */
xccm027       varchar2(10)      ,/* 渠道 */
xccm028       varchar2(10)      ,/* 品類 */
xccm029       varchar2(10)      ,/* 品牌 */
xccm030       varchar2(20)      ,/* 項目號 */
xccm031       varchar2(30)      ,/* WBS */
xccm032       varchar2(24)      ,/* 存貨科目 */
xccm033       varchar2(24)      ,/* 費用成本科目 */
xccm034       varchar2(24)      ,/* 收入科目 */
xccm040       varchar2(10)      ,/* 交易幣別 */
xccm041       varchar2(10)      ,/* 本位幣別 */
xccm042       number(20,10)      ,/* 匯率 */
xccm043       varchar2(10)      ,/* 交易單位 */
xccm044       varchar2(10)      ,/* 成本單位 */
xccm045       number(20,6)      ,/* 換算率 */
xccm046       number(20,6)      ,/* 交易數量 */
xccm047       varchar2(20)      ,/* 工單號碼 */
xccm048       varchar2(10)      ,/* 重複性生產-計畫編號 */
xccm049       varchar2(40)      ,/* 重複性生產-生產料號 */
xccm050       varchar2(30)      ,/* 重複性生產-生產料號BOM特性 */
xccm051       varchar2(256)      ,/* 重複性生產-生產料號產品特徵 */
xccm055       varchar2(10)      ,/* xccc類型 */
xccm101       number(20,6)      ,/* 期末結存數量 */
xccm102       number(20,6)      ,/* 期末結存金額 */
xccm102a       number(20,6)      ,/* 期末結存金額-材料 */
xccm102b       number(20,6)      ,/* 期末結存金額-人工 */
xccm102c       number(20,6)      ,/* 期末結存金額-加工費 */
xccm102d       number(20,6)      ,/* 期末結存金額-制費一 */
xccm102e       number(20,6)      ,/* 期末結存金額-制費二 */
xccm102f       number(20,6)      ,/* 期末結存金額-制費三 */
xccm102g       number(20,6)      ,/* 期末結存金額-制費四 */
xccm102h       number(20,6)      ,/* 期末結存金額-制費五 */
xccmownid       varchar2(20)      ,/* 資料所有者 */
xccmowndp       varchar2(10)      ,/* 資料所屬部門 */
xccmcrtid       varchar2(20)      ,/* 資料建立者 */
xccmcrtdp       varchar2(10)      ,/* 資料建立部門 */
xccmcrtdt       timestamp(0)      ,/* 資料創建日 */
xccmmodid       varchar2(20)      ,/* 資料修改者 */
xccmmoddt       timestamp(0)      ,/* 最近修改日 */
xccmstus       varchar2(10)      /* 狀態碼 */
);
alter table xccm_t add constraint xccm_pk primary key (xccment,xccmld,xccm001,xccm002,xccm003,xccm004,xccm005,xccm006,xccm007,xccm008,xccm009) enable validate;

create unique index xccm_pk on xccm_t (xccment,xccmld,xccm001,xccm002,xccm003,xccm004,xccm005,xccm006,xccm007,xccm008,xccm009);

grant select on xccm_t to tiptop;
grant update on xccm_t to tiptop;
grant delete on xccm_t to tiptop;
grant insert on xccm_t to tiptop;

exit;
