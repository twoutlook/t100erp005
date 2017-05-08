/* 
================================================================================
檔案代號:xcck_t
檔案名稱:本期料件明細進出成本檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xcck_t
(
xcckent       number(5)      ,/* 企業編號 */
xccksite       varchar2(10)      ,/* site組織 */
xcckcomp       varchar2(10)      ,/* 法人組織 */
xcckld       varchar2(5)      ,/* 帳套 */
xcck001       varchar2(1)      ,/* 帳套本位幣順序 */
xcck002       varchar2(30)      ,/* 成本域 */
xcck003       varchar2(10)      ,/* 成本計算類型 */
xcck004       number(5,0)      ,/* 年度 */
xcck005       number(5,0)      ,/* 期別 */
xcck006       varchar2(20)      ,/* 參考單號 */
xcck007       number(10,0)      ,/* 項次 */
xcck008       number(5,0)      ,/* 項序 */
xcck009       number(5,0)      ,/* 出入庫碼 */
xcck010       varchar2(40)      ,/* 料號 */
xcck011       varchar2(256)      ,/* 產品特徵 */
xcck012       varchar2(10)      ,/* 單據類型 */
xcck013       date      ,/* 單據日期 */
xcck014       varchar2(8)      ,/* 時間 */
xcck015       varchar2(10)      ,/* 倉庫編號 */
xcck016       varchar2(10)      ,/* 儲位編號 */
xcck017       varchar2(30)      ,/* 批號 */
xcck020       varchar2(10)      ,/* 異動類型 */
xcck021       varchar2(10)      ,/* 原因碼 */
xcck022       varchar2(10)      ,/* 交易對象 */
xcck023       varchar2(10)      ,/* 客群 */
xcck024       varchar2(10)      ,/* 區域 */
xcck025       varchar2(10)      ,/* 成本中心 */
xcck026       varchar2(10)      ,/* 經營類別 */
xcck027       varchar2(10)      ,/* 通路 */
xcck028       varchar2(10)      ,/* 品類 */
xcck029       varchar2(10)      ,/* 品牌 */
xcck030       varchar2(20)      ,/* 專案號 */
xcck031       varchar2(30)      ,/* WBS */
xcck032       varchar2(24)      ,/* 存貨科目 */
xcck033       varchar2(24)      ,/* 費用成本科目 */
xcck034       varchar2(24)      ,/* 收入科目 */
xcck040       varchar2(10)      ,/* 交易幣別 */
xcck041       varchar2(10)      ,/* 本位幣別 */
xcck042       number(20,10)      ,/* 匯率 */
xcck043       varchar2(10)      ,/* 交易單位 */
xcck044       varchar2(10)      ,/* 成本單位 */
xcck045       number(20,6)      ,/* 換算率 */
xcck046       number(20,6)      ,/* 交易數量 */
xcck047       varchar2(20)      ,/* 工單號碼 */
xcck048       varchar2(10)      ,/* 重複性生產-計畫編號 */
xcck049       varchar2(40)      ,/* 重複性生產-生產料號 */
xcck050       varchar2(30)      ,/* 重複性生產-生產料號BOM特性 */
xcck051       varchar2(256)      ,/* 重複性生產-生產料號產品特徵 */
xcck055       varchar2(10)      ,/* xccc類型 */
xcck201       number(20,6)      ,/* 本期異動數量 */
xcck202       number(20,6)      ,/* 本期異動金額 */
xcck202a       number(20,6)      ,/* 本期異動金額-材料 */
xcck202b       number(20,6)      ,/* 本期異動金額-人工 */
xcck202c       number(20,6)      ,/* 本期異動金額-加工費 */
xcck202d       number(20,6)      ,/* 本期異動金額-製費一 */
xcck202e       number(20,6)      ,/* 本期異動金額-製費二 */
xcck202f       number(20,6)      ,/* 本期異動金額-製費三 */
xcck202g       number(20,6)      ,/* 本期異動金額-製費四 */
xcck202h       number(20,6)      ,/* 本期異動金額-製費五 */
xcck282       number(20,6)      ,/* 本期異動單價 */
xcck282a       number(20,6)      ,/* 本期異動單價-材料 */
xcck282b       number(20,6)      ,/* 本期異動單價-人工 */
xcck282c       number(20,6)      ,/* 本期異動單價-加工 */
xcck282d       number(20,6)      ,/* 本期異動單價-製費一 */
xcck282e       number(20,6)      ,/* 本期異動單價-製費二 */
xcck282f       number(20,6)      ,/* 本期異動單價-製費三 */
xcck282g       number(20,6)      ,/* 本期異動單價-製費四 */
xcck282h       number(20,6)      ,/* 本期異動單價-製費五 */
xcck301       number(20,6)      ,/* 已耗數量 */
xcck302       number(20,6)      ,/* 已耗金額 */
xcck302a       number(20,6)      ,/* 已耗金額-材料 */
xcck302b       number(20,6)      ,/* 已耗金額-人工 */
xcck302c       number(20,6)      ,/* 已耗金額-加工費 */
xcck302d       number(20,6)      ,/* 已耗金額-製費一 */
xcck302e       number(20,6)      ,/* 已耗金額-製費二 */
xcck302f       number(20,6)      ,/* 已耗金額-製費三 */
xcck302g       number(20,6)      ,/* 已耗金額-製費四 */
xcck302h       number(20,6)      ,/* 已耗金額-製費五 */
xcck901       number(20,6)      ,/* 結存數量 */
xcck902       number(20,6)      ,/* 結存金額 */
xcck902a       number(20,6)      ,/* 結存金額-材料 */
xcck902b       number(20,6)      ,/* 結存金額-人工 */
xcck902c       number(20,6)      ,/* 結存金額-加工費 */
xcck902d       number(20,6)      ,/* 結存金額-製費一 */
xcck902e       number(20,6)      ,/* 結存金額-製費二 */
xcck902f       number(20,6)      ,/* 結存金額-製費三 */
xcck902g       number(20,6)      ,/* 結存金額-製費四 */
xcck902h       number(20,6)      ,/* 結存金額-製費五 */
xcck980       number(20,6)      ,/* 結存單位成本 */
xcck980a       number(20,6)      ,/* 結存單位成本-材料 */
xcck980b       number(20,6)      ,/* 結存單位成本-人工 */
xcck980c       number(20,6)      ,/* 結存單位成本-加工費 */
xcck980d       number(20,6)      ,/* 結存單位成本-製費一 */
xcck980e       number(20,6)      ,/* 結存單位成本-製費二 */
xcck980f       number(20,6)      ,/* 結存單位成本-製費三 */
xcck980g       number(20,6)      ,/* 結存單位成本-製費四 */
xcck980h       number(20,6)      ,/* 結存單位成本-製費五 */
xcck903       number(20,6)      ,/* 結存調整金額 */
xcck903a       number(20,6)      ,/* 結存調整金額-材料 */
xcck903b       number(20,6)      ,/* 結存調整金額-人工 */
xcck903c       number(20,6)      ,/* 結存調整金額-加工費 */
xcck903d       number(20,6)      ,/* 結存調整金額-製費一 */
xcck903e       number(20,6)      ,/* 結存調整金額-製費二 */
xcck903f       number(20,6)      ,/* 結存調整金額-製費三 */
xcck903g       number(20,6)      ,/* 結存調整金額-製費四 */
xcck903h       number(20,6)      ,/* 結存調整金額-製費五 */
xcckownid       varchar2(20)      ,/* 資料所有者 */
xcckowndp       varchar2(10)      ,/* 資料所屬部門 */
xcckcrtid       varchar2(20)      ,/* 資料建立者 */
xcckcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcckcrtdt       timestamp(0)      ,/* 資料創建日 */
xcckmodid       varchar2(20)      ,/* 資料修改者 */
xcckmoddt       timestamp(0)      ,/* 最近修改日 */
xcckstus       varchar2(10)      ,/* 狀態碼 */
xcckud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcckud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcckud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcckud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcckud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcckud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcckud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcckud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcckud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcckud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcckud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcckud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcckud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcckud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcckud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcckud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcckud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcckud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcckud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcckud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcckud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcckud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcckud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcckud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcckud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcckud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcckud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcckud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcckud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcckud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xcck056       varchar2(20)      /* 成本代銷單號 */
);
alter table xcck_t add constraint xcck_pk primary key (xcckent,xcckld,xcck001,xcck002,xcck003,xcck004,xcck005,xcck006,xcck007,xcck008,xcck009) enable validate;

create  index xcck_n on xcck_t (xcckent,xcckld,xcck001,xcck002,xcck003,xcck010,xcck011,xcck282);
create unique index xcck_pk on xcck_t (xcckent,xcckld,xcck001,xcck002,xcck003,xcck004,xcck005,xcck006,xcck007,xcck008,xcck009);

grant select on xcck_t to tiptop;
grant update on xcck_t to tiptop;
grant delete on xcck_t to tiptop;
grant insert on xcck_t to tiptop;

exit;
