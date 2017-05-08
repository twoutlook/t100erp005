/* 
================================================================================
檔案代號:xcdk_t
檔案名稱:本期料件明細進出成本要素成本檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcdk_t
(
xcdkent       number(5)      ,/* 企業編號 */
xcdksite       varchar2(10)      ,/* site組織 */
xcdkcomp       varchar2(10)      ,/* 法人組織 */
xcdkld       varchar2(5)      ,/* 帳套 */
xcdk001       varchar2(1)      ,/* 帳套本位幣順序 */
xcdk002       varchar2(30)      ,/* 成本域 */
xcdk003       varchar2(10)      ,/* 成本計算類型 */
xcdk004       number(5,0)      ,/* 年度 */
xcdk005       number(5,0)      ,/* 期別 */
xcdk006       varchar2(20)      ,/* 參考單號 */
xcdk007       number(10,0)      ,/* 項次 */
xcdk008       number(10,0)      ,/* 項序 */
xcdk009       number(5,0)      ,/* 出入庫碼 */
xcdk010       varchar2(10)      ,/* 成本要素 */
xcdk011       varchar2(40)      ,/* 料號 */
xcdk012       varchar2(256)      ,/* 特性 */
xcdk013       varchar2(10)      ,/* 單據類型 */
xcdk014       date      ,/* 單據日期 */
xcdk015       varchar2(8)      ,/* 時間 */
xcdk016       varchar2(10)      ,/* 倉庫編號 */
xcdk017       varchar2(10)      ,/* 儲位編號 */
xcdk018       varchar2(30)      ,/* 批號 */
xcdk020       varchar2(10)      ,/* 異動類型 */
xcdk021       varchar2(10)      ,/* 原因碼 */
xcdk022       varchar2(10)      ,/* 交易對象 */
xcdk023       varchar2(10)      ,/* 客群 */
xcdk024       varchar2(10)      ,/* 區域 */
xcdk025       varchar2(10)      ,/* 成本中心 */
xcdk026       varchar2(10)      ,/* 經營類別 */
xcdk027       varchar2(10)      ,/* 渠道 */
xcdk028       varchar2(10)      ,/* 品類 */
xcdk029       varchar2(10)      ,/* 品牌 */
xcdk030       varchar2(20)      ,/* 項目編號 */
xcdk031       varchar2(30)      ,/* WBS */
xcdk032       varchar2(24)      ,/* 存貨科目 */
xcdk033       varchar2(24)      ,/* 費用成本科目 */
xcdk034       varchar2(24)      ,/* 收入科目 */
xcdk047       varchar2(20)      ,/* 工單號碼 */
xcdk048       varchar2(10)      ,/* 重複性生產-計畫編號 */
xcdk049       varchar2(40)      ,/* 重複性生產-生產料號 */
xcdk050       varchar2(30)      ,/* 重複性生產-生產料號BOM特性 */
xcdk051       varchar2(256)      ,/* 重複性生產-生產料號產品特徵 */
xcdk055       varchar2(10)      ,/* xcdc類型 */
xcdk201       number(20,6)      ,/* 本期異動數量 */
xcdk202       number(20,6)      ,/* 本期異動金額 */
xcdk301       number(20,6)      ,/* 已耗數量 */
xcdk302       number(20,6)      ,/* 已耗金額 */
xcdk901       number(20,6)      ,/* 結存數量 */
xcdk902       number(20,6)      ,/* 結存金額 */
xcdk980       number(20,6)      ,/* 結存單位成本 */
xcdk903       number(20,6)      ,/* 結存調整金額 */
xcdkownid       varchar2(20)      ,/* 資料所有者 */
xcdkowndp       varchar2(10)      ,/* 資料所屬部門 */
xcdkcrtid       varchar2(20)      ,/* 資料建立者 */
xcdkcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcdkcrtdt       timestamp(0)      ,/* 資料創建日 */
xcdkmodid       varchar2(20)      ,/* 資料修改者 */
xcdkmoddt       timestamp(0)      ,/* 最近修改日 */
xcdkstus       varchar2(10)      ,/* 狀態碼 */
xcdkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcdkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcdkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcdkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcdkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcdkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcdkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcdkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcdkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcdkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcdkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcdkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcdkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcdkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcdkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcdkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcdkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcdkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcdkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcdkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcdkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcdkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcdkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcdkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcdkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcdkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcdkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcdkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcdkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcdkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcdk_t add constraint xcdk_pk primary key (xcdkent,xcdkld,xcdk001,xcdk002,xcdk003,xcdk004,xcdk005,xcdk006,xcdk007,xcdk008,xcdk009,xcdk010) enable validate;

create unique index xcdk_pk on xcdk_t (xcdkent,xcdkld,xcdk001,xcdk002,xcdk003,xcdk004,xcdk005,xcdk006,xcdk007,xcdk008,xcdk009,xcdk010);

grant select on xcdk_t to tiptop;
grant update on xcdk_t to tiptop;
grant delete on xcdk_t to tiptop;
grant insert on xcdk_t to tiptop;

exit;
