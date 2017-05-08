/* 
================================================================================
檔案代號:xcds_t
檔案名稱:料件明細成本次要素結存檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xcds_t
(
xcdsent       number(5)      ,/* 企業編號 */
xcdssite       varchar2(10)      ,/* site組織 */
xcdscomp       varchar2(10)      ,/* 法人組織 */
xcdsld       varchar2(5)      ,/* 帳套 */
xcds001       varchar2(1)      ,/* 帳套本位幣順序 */
xcds002       varchar2(30)      ,/* 成本域 */
xcds003       varchar2(10)      ,/* 成本計算類型 */
xcds004       varchar2(20)      ,/* 參考單號 */
xcds005       number(5,0)      ,/* 項次 */
xcds006       number(5,0)      ,/* 項序 */
xcds007       number(5,0)      ,/* 出入庫碼 */
xcds008       varchar2(10)      ,/* 次要素 */
xcds010       varchar2(40)      ,/* 料號 */
xcds011       varchar2(256)      ,/* 特性 */
xcds012       varchar2(10)      ,/* 單據類型 */
xcds013       date      ,/* 單據日期 */
xcds014       timestamp(0)      ,/* 時間 */
xcds015       varchar2(10)      ,/* 倉庫編號 */
xcds016       varchar2(10)      ,/* 儲位編號 */
xcds017       varchar2(30)      ,/* 批號 */
xcds020       varchar2(10)      ,/* 異動類型 */
xcds021       varchar2(10)      ,/* 原因碼 */
xcds022       varchar2(10)      ,/* 交易對象 */
xcds023       varchar2(10)      ,/* 客群 */
xcds024       varchar2(10)      ,/* 區域 */
xcds025       varchar2(10)      ,/* 成本中心 */
xcds026       varchar2(10)      ,/* 經營類別 */
xcds027       varchar2(10)      ,/* 渠道 */
xcds028       varchar2(10)      ,/* 品類 */
xcds029       varchar2(10)      ,/* 品牌 */
xcds030       varchar2(20)      ,/* 項目號 */
xcds031       varchar2(30)      ,/* WBS */
xcds032       varchar2(24)      ,/* 存貨科目 */
xcds033       varchar2(24)      ,/* 費用成本科目 */
xcds034       varchar2(24)      ,/* 收入科目 */
xcds040       varchar2(10)      ,/* 交易幣別 */
xcds041       varchar2(10)      ,/* 本位幣別 */
xcds042       number(20,10)      ,/* 匯率 */
xcds043       varchar2(10)      ,/* 交易單位 */
xcds044       varchar2(10)      ,/* 成本單位 */
xcds045       number(20,6)      ,/* 換算率 */
xcds046       number(20,6)      ,/* 交易數量 */
xcds047       varchar2(20)      ,/* 工單號碼 */
xcds048       varchar2(10)      ,/* 重複性生產-計畫編號 */
xcds049       varchar2(40)      ,/* 重複性生產-生產料號 */
xcds050       varchar2(30)      ,/* 重複性生產-生產料號BOM特性 */
xcds051       varchar2(256)      ,/* 重複性生產-生產料號產品特徵 */
xcds055       varchar2(10)      ,/* xccc類型 */
xcds201       number(20,6)      ,/* 本期異動數量 */
xcds202       number(20,6)      ,/* 本期異動金額 */
xcds282       number(20,6)      ,/* 本期異動單價 */
xcds301       number(20,6)      ,/* 已耗數量 */
xcds302       number(20,6)      ,/* 已耗金額 */
xcds901       number(20,6)      ,/* 結存數量 */
xcds902       number(20,6)      ,/* 結存金額 */
xcds980       number(20,6)      ,/* 結存單位成本 */
xcds903       number(20,6)      ,/* 結存調整金額 */
xcdsownid       varchar2(20)      ,/* 資料所有者 */
xcdsowndp       varchar2(10)      ,/* 資料所屬部門 */
xcdscrtid       varchar2(20)      ,/* 資料建立者 */
xcdscrtdp       varchar2(10)      ,/* 資料建立部門 */
xcdscrtdt       timestamp(0)      ,/* 資料創建日 */
xcdsmodid       varchar2(20)      ,/* 資料修改者 */
xcdsmoddt       timestamp(0)      ,/* 最近修改日 */
xcdsstus       varchar2(10)      ,/* 狀態碼 */
xcdsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcdsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcdsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcdsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcdsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcdsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcdsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcdsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcdsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcdsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcdsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcdsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcdsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcdsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcdsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcdsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcdsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcdsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcdsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcdsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcdsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcdsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcdsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcdsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcdsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcdsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcdsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcdsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcdsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcdsud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcds_t add constraint xcds_pk primary key (xcdsent,xcdsld,xcds001,xcds002,xcds003,xcds004,xcds005,xcds006,xcds007,xcds008) enable validate;

create unique index xcds_pk on xcds_t (xcdsent,xcdsld,xcds001,xcds002,xcds003,xcds004,xcds005,xcds006,xcds007,xcds008);

grant select on xcds_t to tiptop;
grant update on xcds_t to tiptop;
grant delete on xcds_t to tiptop;
grant insert on xcds_t to tiptop;

exit;
