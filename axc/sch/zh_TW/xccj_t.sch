/* 
================================================================================
檔案代號:xccj_t
檔案名稱:期初料件明細進出成本開帳檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xccj_t
(
xccjent       number(5)      ,/* 企業編號 */
xccjcomp       varchar2(10)      ,/* 法人組織 */
xccjld       varchar2(5)      ,/* 帳套 */
xccj001       varchar2(1)      ,/* 帳套本位幣順序 */
xccj002       varchar2(30)      ,/* 成本域 */
xccj003       varchar2(10)      ,/* 成本計算類型 */
xccj004       number(5,0)      ,/* 年度 */
xccj005       number(5,0)      ,/* 期別 */
xccj006       varchar2(20)      ,/* 參考單號 */
xccj007       number(10,0)      ,/* 項次 */
xccj008       number(10,0)      ,/* 項序 */
xccj009       number(5,0)      ,/* 出入庫碼 */
xccj010       varchar2(40)      ,/* 料號 */
xccj011       varchar2(256)      ,/* 特性 */
xccj012       varchar2(10)      ,/* 單據類型 */
xccj013       date      ,/* 單據日期 */
xccj014       timestamp(0)      ,/* 時間 */
xccj015       varchar2(10)      ,/* 倉庫編號 */
xccj016       varchar2(10)      ,/* 儲位編號 */
xccj017       varchar2(30)      ,/* 批號 */
xccj020       varchar2(10)      ,/* 異動類型 */
xccj021       varchar2(10)      ,/* 原因碼 */
xccj022       varchar2(10)      ,/* 交易對象 */
xccj023       varchar2(10)      ,/* 客群 */
xccj024       varchar2(10)      ,/* 區域 */
xccj025       varchar2(10)      ,/* 成本中心 */
xccj026       varchar2(10)      ,/* 經營類別 */
xccj027       varchar2(10)      ,/* 渠道 */
xccj028       varchar2(10)      ,/* 品類 */
xccj029       varchar2(10)      ,/* 品牌 */
xccj030       varchar2(20)      ,/* 項目號 */
xccj031       varchar2(30)      ,/* WBS */
xccj032       varchar2(24)      ,/* 存貨科目編號 */
xccj033       varchar2(24)      ,/* 費用成本科目 */
xccj034       varchar2(24)      ,/* 收入科目編號 */
xccj040       varchar2(10)      ,/* 交易幣別 */
xccj041       varchar2(10)      ,/* 本位幣別 */
xccj042       number(20,10)      ,/* 匯率 */
xccj043       varchar2(10)      ,/* 交易單位 */
xccj044       varchar2(10)      ,/* 成本單位 */
xccj045       number(20,6)      ,/* 換算率 */
xccj046       number(20,6)      ,/* 交易數量 */
xccj047       varchar2(20)      ,/* 工單號碼 */
xccj048       varchar2(10)      ,/* 重複性生產-計畫編號 */
xccj049       varchar2(40)      ,/* 重複性生產-生產料號 */
xccj050       varchar2(30)      ,/* 重複性生產-生產料號BOM特性 */
xccj051       varchar2(256)      ,/* 重複性生產-生產料號產品特徵 */
xccj055       varchar2(10)      ,/* xccc類型 */
xccj101       number(20,6)      ,/* 期末結存數量 */
xccj102       number(20,6)      ,/* 期末結存金額 */
xccj102a       number(20,6)      ,/* 期末結存金額-材料 */
xccj102b       number(20,6)      ,/* 期末結存金額-人工 */
xccj102c       number(20,6)      ,/* 期末結存金額-加工費 */
xccj102d       number(20,6)      ,/* 期末結存金額-制費一 */
xccj102e       number(20,6)      ,/* 期末結存金額-制費二 */
xccj102f       number(20,6)      ,/* 期末結存金額-制費三 */
xccj102g       number(20,6)      ,/* 期末結存金額-制費四 */
xccj102h       number(20,6)      ,/* 期末結存金額-制費五 */
xccjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xccjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xccjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xccjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xccjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xccjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xccjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xccjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xccjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xccjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xccjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xccjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xccjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xccjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xccjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xccjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xccjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xccjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xccjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xccjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xccjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xccjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xccjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xccjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xccjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xccjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xccjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xccjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xccjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xccjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xccj_t add constraint xccj_pk primary key (xccjent,xccjld,xccj001,xccj002,xccj003,xccj004,xccj005,xccj006,xccj007,xccj008,xccj009) enable validate;

create unique index xccj_pk on xccj_t (xccjent,xccjld,xccj001,xccj002,xccj003,xccj004,xccj005,xccj006,xccj007,xccj008,xccj009);

grant select on xccj_t to tiptop;
grant update on xccj_t to tiptop;
grant delete on xccj_t to tiptop;
grant insert on xccj_t to tiptop;

exit;
