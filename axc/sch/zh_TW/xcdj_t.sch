/* 
================================================================================
檔案代號:xcdj_t
檔案名稱:期初料件明細進出成本要素成本開帳檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcdj_t
(
xcdjent       number(5)      ,/* 企業編號 */
xcdjcomp       varchar2(10)      ,/* 法人組織 */
xcdjld       varchar2(5)      ,/* 帳套 */
xcdj001       varchar2(1)      ,/* 帳套本位幣順序 */
xcdj002       varchar2(30)      ,/* 成本域 */
xcdj003       varchar2(10)      ,/* 成本計算類型 */
xcdj004       number(5,0)      ,/* 年度 */
xcdj005       number(5,0)      ,/* 期別 */
xcdj006       varchar2(20)      ,/* 參考單號 */
xcdj007       number(10,0)      ,/* 項次 */
xcdj008       number(10,0)      ,/* 項序 */
xcdj009       number(5,0)      ,/* 出入庫碼 */
xcdj010       varchar2(10)      ,/* 成本要素 */
xcdj011       varchar2(40)      ,/* 料號 */
xcdj012       varchar2(256)      ,/* 特性 */
xcdj013       varchar2(10)      ,/* 單據類型 */
xcdj014       date      ,/* 單據日期 */
xcdj015       timestamp(0)      ,/* 時間 */
xcdj016       varchar2(10)      ,/* 倉庫編號 */
xcdj017       varchar2(10)      ,/* 儲位編號 */
xcdj018       varchar2(30)      ,/* 批號 */
xcdj020       varchar2(10)      ,/* 異動類型 */
xcdj021       varchar2(10)      ,/* 原因碼 */
xcdj022       varchar2(10)      ,/* 交易對象 */
xcdj023       varchar2(10)      ,/* 客群 */
xcdj024       varchar2(10)      ,/* 區域 */
xcdj025       varchar2(10)      ,/* 成本中心 */
xcdj026       varchar2(10)      ,/* 經營類別 */
xcdj027       varchar2(10)      ,/* 渠道 */
xcdj028       varchar2(10)      ,/* 品類 */
xcdj029       varchar2(10)      ,/* 品牌 */
xcdj030       varchar2(20)      ,/* 項目號 */
xcdj031       varchar2(30)      ,/* WBS */
xcdj032       varchar2(24)      ,/* 存貨科目 */
xcdj033       varchar2(24)      ,/* 費用成本科目 */
xcdj034       varchar2(24)      ,/* 收入科目 */
xcdj040       varchar2(10)      ,/* 交易幣別 */
xcdj041       varchar2(10)      ,/* 本位幣別 */
xcdj042       number(20,10)      ,/* 匯率 */
xcdj043       varchar2(10)      ,/* 交易單位 */
xcdj044       varchar2(10)      ,/* 成本單位 */
xcdj045       number(20,6)      ,/* 換算率 */
xcdj046       number(20,6)      ,/* 交易數量 */
xcdj047       varchar2(20)      ,/* 工單號碼 */
xcdj048       varchar2(10)      ,/* 重複性生產-計畫編號 */
xcdj049       varchar2(40)      ,/* 重複性生產-生產料號 */
xcdj050       varchar2(30)      ,/* 重複性生產-生產料號BOM特性 */
xcdj051       varchar2(256)      ,/* 重複性生產-生產料號產品特徵 */
xcdj055       varchar2(10)      ,/* xccc類型 */
xcdj101       number(20,6)      ,/* 期末結存數量 */
xcdj102       number(20,6)      /* 期末結存金額 */
);
alter table xcdj_t add constraint xcdj_pk primary key (xcdjent,xcdjld,xcdj001,xcdj002,xcdj003,xcdj004,xcdj005,xcdj006,xcdj007,xcdj008,xcdj009,xcdj010) enable validate;

create unique index xcdj_pk on xcdj_t (xcdjent,xcdjld,xcdj001,xcdj002,xcdj003,xcdj004,xcdj005,xcdj006,xcdj007,xcdj008,xcdj009,xcdj010);

grant select on xcdj_t to tiptop;
grant update on xcdj_t to tiptop;
grant delete on xcdj_t to tiptop;
grant insert on xcdj_t to tiptop;

exit;
