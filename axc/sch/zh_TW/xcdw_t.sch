/* 
================================================================================
檔案代號:xcdw_t
檔案名稱:本期料件明細進出成本要素補成本檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcdw_t
(
xcdwent       number(5)      ,/* 企業編號 */
xcdwsite       varchar2(10)      ,/* site組織 */
xcdwcomp       varchar2(10)      ,/* 法人組織 */
xcdwld       varchar2(5)      ,/* 帳別編號 */
xcdw001       varchar2(1)      ,/* 帳套本位幣順序 */
xcdw002       varchar2(30)      ,/* 成本域 */
xcdw003       varchar2(10)      ,/* 成本計算類型 */
xcdw004       number(5,0)      ,/* 年度 */
xcdw005       number(5,0)      ,/* 期別 */
xcdw006       varchar2(20)      ,/* 參考單號 */
xcdw007       number(10,0)      ,/* 項次 */
xcdw008       number(10,0)      ,/* 項序 */
xcdw009       number(5,0)      ,/* 出入庫碼 */
xcdw010       varchar2(10)      ,/* 成本要素 */
xcdw011       varchar2(40)      ,/* 料號 */
xcdw012       varchar2(256)      ,/* 特性 */
xcdw013       varchar2(10)      ,/* 單據類型 */
xcdw014       date      ,/* 單據日期 */
xcdw015       varchar2(8)      ,/* 時間 */
xcdw016       varchar2(10)      ,/* 倉庫編號 */
xcdw017       varchar2(10)      ,/* 儲位編號 */
xcdw018       varchar2(30)      ,/* 批號 */
xcdw020       varchar2(10)      ,/* 異動類型 */
xcdw021       varchar2(10)      ,/* 原因碼 */
xcdw022       varchar2(10)      ,/* 交易對象 */
xcdw023       varchar2(10)      ,/* 客群 */
xcdw024       varchar2(10)      ,/* 區域 */
xcdw025       varchar2(10)      ,/* 成本中心 */
xcdw026       varchar2(10)      ,/* 經營類別 */
xcdw027       varchar2(10)      ,/* 渠道 */
xcdw028       varchar2(10)      ,/* 品類 */
xcdw029       varchar2(10)      ,/* 品牌 */
xcdw030       varchar2(20)      ,/* 項目編號 */
xcdw031       varchar2(30)      ,/* WBS */
xcdw032       varchar2(24)      ,/* 存貨科目 */
xcdw033       varchar2(24)      ,/* 費用成本科目 */
xcdw034       varchar2(24)      ,/* 收入科目 */
xcdw047       varchar2(20)      ,/* 工單號碼 */
xcdw048       varchar2(10)      ,/* 重複性生產-計畫編號 */
xcdw049       varchar2(40)      ,/* 重複性生產-生產料號 */
xcdw050       varchar2(30)      ,/* 重複性生產-生產料號BOM特性 */
xcdw051       varchar2(256)      ,/* 重複性生產-生產料號產品特徵 */
xcdw201       number(20,6)      ,/* 本期異動數量 */
xcdw202       number(20,6)      ,/* 本期異動金額 */
xcdwstus       varchar2(10)      /* 狀態碼 */
);
alter table xcdw_t add constraint xcdw_pk primary key (xcdwent,xcdwld,xcdw001,xcdw002,xcdw003,xcdw004,xcdw005,xcdw006,xcdw007,xcdw008,xcdw009,xcdw010) enable validate;

create unique index xcdw_pk on xcdw_t (xcdwent,xcdwld,xcdw001,xcdw002,xcdw003,xcdw004,xcdw005,xcdw006,xcdw007,xcdw008,xcdw009,xcdw010);

grant select on xcdw_t to tiptop;
grant update on xcdw_t to tiptop;
grant delete on xcdw_t to tiptop;
grant insert on xcdw_t to tiptop;

exit;
