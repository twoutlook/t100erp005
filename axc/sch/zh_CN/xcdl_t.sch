/* 
================================================================================
檔案代號:xcdl_t
檔案名稱:本期料件明細出庫沖銷明細入庫成本要素成本檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcdl_t
(
xcdlent       number(5)      ,/* 企業編號 */
xcdlcomp       varchar2(10)      ,/* 法人組織 */
xcdlld       varchar2(5)      ,/* 帳套 */
xcdl001       varchar2(1)      ,/* 帳套本位幣順序 */
xcdl002       varchar2(30)      ,/* 成本域 */
xcdl003       varchar2(10)      ,/* 成本計算類型 */
xcdl004       number(5,0)      ,/* 年度 */
xcdl005       number(5,0)      ,/* 期別 */
xcdl006       varchar2(20)      ,/* 出庫單號 */
xcdl007       number(10,0)      ,/* 項次 */
xcdl008       number(10,0)      ,/* 項序 */
xcdl009       varchar2(20)      ,/* 沖銷入庫單號 */
xcdl010       number(10,0)      ,/* 項次 */
xcdl011       number(10,0)      ,/* 項序 */
xcdl012       varchar2(10)      ,/* 成本要素 */
xcdl013       varchar2(40)      ,/* 料號 */
xcdl014       varchar2(256)      ,/* 特性 */
xcdl015       date      ,/* 出庫日期 */
xcdl016       timestamp(0)      ,/* 時間 */
xcdl017       varchar2(10)      ,/* 倉庫編號 */
xcdl018       varchar2(10)      ,/* 儲位編號 */
xcdl019       varchar2(30)      ,/* 批號 */
xcdl020       varchar2(10)      ,/* 異動類型 */
xcdl021       varchar2(10)      ,/* 原因碼 */
xcdl022       varchar2(10)      ,/* 交易對象 */
xcdl023       varchar2(10)      ,/* 客群 */
xcdl024       varchar2(10)      ,/* 區域 */
xcdl025       varchar2(10)      ,/* 成本中心 */
xcdl026       varchar2(10)      ,/* 經營類別 */
xcdl027       varchar2(10)      ,/* 渠道 */
xcdl028       varchar2(10)      ,/* 品類 */
xcdl029       varchar2(10)      ,/* 品牌 */
xcdl030       varchar2(20)      ,/* 項目號 */
xcdl031       varchar2(30)      ,/* WBS */
xcdl032       varchar2(24)      ,/* 存貨科目 */
xcdl033       varchar2(24)      ,/* 費用成本科目 */
xcdl034       varchar2(24)      ,/* 收入科目 */
xcdl047       varchar2(20)      ,/* 工單號碼 */
xcdl048       varchar2(5)      ,/* 重複性生產-計畫編號 */
xcdl049       varchar2(40)      ,/* 重複性生產-生產料號 */
xcdl050       varchar2(30)      ,/* 重複性生產-生產料號BOM特性 */
xcdl051       varchar2(256)      ,/* 重複性生產-生產料號產品特徵 */
xcdl055       varchar2(10)      ,/* xccc類型 */
xcdl101       number(20,6)      ,/* 沖銷數量 */
xcdl102       number(20,6)      /* 沖銷金額 */
);
alter table xcdl_t add constraint xcdl_pk primary key (xcdlent,xcdlld,xcdl001,xcdl002,xcdl003,xcdl004,xcdl005,xcdl006,xcdl007,xcdl008,xcdl009,xcdl010,xcdl011,xcdl012) enable validate;

create unique index xcdl_pk on xcdl_t (xcdlent,xcdlld,xcdl001,xcdl002,xcdl003,xcdl004,xcdl005,xcdl006,xcdl007,xcdl008,xcdl009,xcdl010,xcdl011,xcdl012);

grant select on xcdl_t to tiptop;
grant update on xcdl_t to tiptop;
grant delete on xcdl_t to tiptop;
grant insert on xcdl_t to tiptop;

exit;
