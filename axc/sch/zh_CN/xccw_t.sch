/* 
================================================================================
檔案代號:xccw_t
檔案名稱:本期料件明細進出補成本檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table xccw_t
(
xccwent       number(5)      ,/* 企業編號 */
xccwsite       varchar2(10)      ,/* site組織 */
xccwcomp       varchar2(10)      ,/* 法人組織 */
xccwld       varchar2(5)      ,/* 帳套 */
xccw001       varchar2(1)      ,/* 帳套本位幣順序 */
xccw002       varchar2(30)      ,/* 成本域 */
xccw003       varchar2(10)      ,/* 成本計算類型 */
xccw004       number(5,0)      ,/* 年度 */
xccw005       number(5,0)      ,/* 期別 */
xccw006       varchar2(20)      ,/* 參考單號 */
xccw007       number(10,0)      ,/* 項次 */
xccw008       number(5,0)      ,/* 項序 */
xccw009       number(5,0)      ,/* 出入庫碼 */
xccw010       varchar2(40)      ,/* 料號 */
xccw011       varchar2(256)      ,/* 特性 */
xccw012       varchar2(10)      ,/* 單據類型 */
xccw013       date      ,/* 單據日期 */
xccw014       varchar2(8)      ,/* 時間 */
xccw015       varchar2(10)      ,/* 倉庫編號 */
xccw016       varchar2(10)      ,/* 儲位編號 */
xccw017       varchar2(30)      ,/* 批號 */
xccw020       varchar2(10)      ,/* 異動類型 */
xccw021       varchar2(10)      ,/* 原因碼 */
xccw022       varchar2(10)      ,/* 交易對象 */
xccw023       varchar2(10)      ,/* 客群 */
xccw024       varchar2(10)      ,/* 區域 */
xccw025       varchar2(10)      ,/* 成本中心 */
xccw026       varchar2(10)      ,/* 經營類別 */
xccw027       varchar2(10)      ,/* 通路 */
xccw028       varchar2(10)      ,/* 品類 */
xccw029       varchar2(10)      ,/* 品牌 */
xccw030       varchar2(20)      ,/* 專案號 */
xccw031       varchar2(30)      ,/* WBS */
xccw032       varchar2(24)      ,/* 存貨科目 */
xccw033       varchar2(24)      ,/* 費用成本科目 */
xccw034       varchar2(24)      ,/* 收入科目 */
xccw040       varchar2(10)      ,/* 交易幣別 */
xccw041       varchar2(10)      ,/* 本位幣別 */
xccw042       number(20,10)      ,/* 匯率 */
xccw043       varchar2(10)      ,/* 交易單位 */
xccw044       varchar2(10)      ,/* 成本單位 */
xccw045       number(20,6)      ,/* 換算率 */
xccw046       number(20,6)      ,/* 交易數量 */
xccw047       varchar2(20)      ,/* 在製單號(工單號/重複性編號) */
xccw048       varchar2(10)      ,/* 重複性生產-計畫編號 */
xccw049       varchar2(40)      ,/* 重複性生產-生產料號 */
xccw050       varchar2(30)      ,/* 重複性生產-生產料號BOM特性 */
xccw051       varchar2(256)      ,/* 重複性生產-生產料號產品特徵 */
xccw201       number(20,6)      ,/* 本期異動數量 */
xccw202       number(20,6)      ,/* 本期異動金額 */
xccw202a       number(20,6)      ,/* 本期異動金額-材料 */
xccw202b       number(20,6)      ,/* 本期異動金額-人工 */
xccw202c       number(20,6)      ,/* 本期異動金額-加工費 */
xccw202d       number(20,6)      ,/* 本期異動金額-制費一 */
xccw202e       number(20,6)      ,/* 本期異動金額-制費二 */
xccw202f       number(20,6)      ,/* 本期異動金額-制費三 */
xccw202g       number(20,6)      ,/* 本期異動金額-制費四 */
xccw202h       number(20,6)      ,/* 本期異動金額-制費五 */
xccw282       number(20,6)      ,/* 本期異動單價 */
xccw282a       number(20,6)      ,/* 本期異動單價-材料 */
xccw282b       number(20,6)      ,/* 本期異動單價-人工 */
xccw282c       number(20,6)      ,/* 本期異動單價-加工 */
xccw282d       number(20,6)      ,/* 本期異動單價-制費一 */
xccw282e       number(20,6)      ,/* 本期異動單價-制費二 */
xccw282f       number(20,6)      ,/* 本期異動單價-制費三 */
xccw282g       number(20,6)      ,/* 本期異動單價-制費四 */
xccw282h       number(20,6)      ,/* 本期異動單價-制費五 */
xccwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xccwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xccwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xccwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xccwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xccwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xccwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xccwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xccwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xccwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xccwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xccwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xccwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xccwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xccwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xccwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xccwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xccwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xccwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xccwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xccwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xccwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xccwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xccwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xccwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xccwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xccwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xccwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xccwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xccwud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xccw_t add constraint xccw_pk primary key (xccwent,xccwld,xccw001,xccw002,xccw003,xccw004,xccw005,xccw006,xccw007,xccw008,xccw009) enable validate;

create unique index xccw_pk on xccw_t (xccwent,xccwld,xccw001,xccw002,xccw003,xccw004,xccw005,xccw006,xccw007,xccw008,xccw009);

grant select on xccw_t to tiptop;
grant update on xccw_t to tiptop;
grant delete on xccw_t to tiptop;
grant insert on xccw_t to tiptop;

exit;
