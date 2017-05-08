/* 
================================================================================
檔案代號:sfka_t
檔案名稱:工單變更單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table sfka_t
(
sfkaent       number(5)      ,/* 企業編號 */
sfkasite       varchar2(10)      ,/* 營運據點 */
sfkadocno       varchar2(20)      ,/* 工單單號 */
sfkadocdt       date      ,/* 開單日期 */
sfka001       number(5,0)      ,/* 變更版本 */
sfka002       varchar2(20)      ,/* 生管人員 */
sfka003       varchar2(1)      ,/* 工單類型 */
sfka004       varchar2(1)      ,/* 發料制度 */
sfka005       varchar2(20)      ,/* 工單來源 */
sfka006       varchar2(20)      ,/* 來源單號 */
sfka007       number(10,0)      ,/* 來源項次 */
sfka008       number(10,0)      ,/* 來源項序 */
sfka009       varchar2(10)      ,/* 參考客戶 */
sfka010       varchar2(40)      ,/* 生產料號 */
sfka011       varchar2(30)      ,/* 特性 */
sfka012       number(20,6)      ,/* 生產數量 */
sfka013       varchar2(10)      ,/* 生產單位 */
sfka014       varchar2(10)      ,/* BOM版本 */
sfka015       date      ,/* BOM有效日期 */
sfka016       varchar2(10)      ,/* 製程編號 */
sfka017       varchar2(10)      ,/* 部門供應商 */
sfka018       varchar2(10)      ,/* 協作據點 */
sfka019       date      ,/* 預計開工日 */
sfka020       date      ,/* 預計完工日 */
sfka021       varchar2(20)      ,/* 母工單單號 */
sfka022       varchar2(20)      ,/* 參考原始單號 */
sfka023       varchar2(10)      ,/* 參考原始項次 */
sfka024       varchar2(10)      ,/* 參考原始項序 */
sfka025       varchar2(20)      ,/* 前工單單號 */
sfka026       varchar2(20)      ,/* 料表批號(PBI) */
sfka027       varchar2(40)      ,/* No Use */
sfka028       varchar2(20)      ,/* 專案編號 */
sfka029       varchar2(30)      ,/* WBS */
sfka030       varchar2(30)      ,/* 活動 */
sfka031       varchar2(10)      ,/* 理由碼 */
sfka032       number(20,6)      ,/* 緊急比率 */
sfka033       number(10,0)      ,/* 優先順序 */
sfka034       varchar2(10)      ,/* 預計入庫庫位 */
sfka035       varchar2(10)      ,/* 預計入庫儲位 */
sfka036       varchar2(20)      ,/* 手冊編號 */
sfka037       varchar2(20)      ,/* 保稅核准文號 */
sfka038       varchar2(1)      ,/* 保稅核銷 */
sfka039       varchar2(1)      ,/* 備料已產生 */
sfka040       varchar2(1)      ,/* 生產途程已確認 */
sfka041       varchar2(1)      ,/* 凍結 */
sfka042       varchar2(1)      ,/* 重工 */
sfka043       varchar2(1)      ,/* 備置 */
sfka044       varchar2(1)      ,/* FQC */
sfka045       date      ,/* 實際開始發料日 */
sfka046       date      ,/* 最後入庫日 */
sfka047       date      ,/* 生管結案日 */
sfka048       date      ,/* 成本結案日 */
sfka049       number(20,6)      ,/* 已發料套數 */
sfka050       number(20,6)      ,/* 已入庫合格量 */
sfka051       number(20,6)      ,/* 已入庫不合格量 */
sfka052       number(20,6)      ,/* Bouns */
sfka053       number(20,6)      ,/* 工單轉入數量 */
sfka054       number(20,6)      ,/* 工單轉出數量 */
sfka055       number(20,6)      ,/* 下線數量 */
sfka056       number(20,6)      ,/* 報廢數量 */
sfka057       varchar2(1)      ,/* 委外類型 */
sfka058       number(20,6)      ,/* 參考數量 */
sfka059       varchar2(30)      ,/* 預計入庫批號 */
sfka060       varchar2(10)      ,/* 參考單位 */
sfka061       varchar2(1)      ,/* 製程 */
sfka062       varchar2(1)      ,/* 納入MRP/MPS計算 */
sfka900       number(10,0)      ,/* 變更序 */
sfka901       varchar2(1)      ,/* 變更類型 */
sfka902       date      ,/* 變更日期 */
sfka905       varchar2(10)      ,/* 變更理由 */
sfka906       varchar2(255)      ,/* 變更備註 */
sfkaownid       varchar2(20)      ,/* 資料所有者 */
sfkaowndp       varchar2(10)      ,/* 資料所屬部門 */
sfkacrtid       varchar2(20)      ,/* 資料建立者 */
sfkacrtdp       varchar2(10)      ,/* 資料建立部門 */
sfkacrtdt       timestamp(0)      ,/* 資料創建日 */
sfkamodid       varchar2(20)      ,/* 資料修改者 */
sfkamoddt       timestamp(0)      ,/* 最近修改日 */
sfkacnfid       varchar2(20)      ,/* 資料確認者 */
sfkacnfdt       timestamp(0)      ,/* 資料確認日 */
sfkapstid       varchar2(20)      ,/* 資料過帳者 */
sfkapstdt       timestamp(0)      ,/* 資料過帳日 */
sfkastus       varchar2(10)      ,/* 狀態碼 */
sfkaacti       varchar2(1)      ,/* 工單結案 */
sfka063       number(5,0)      ,/* 來源分批序 */
sfka064       number(5,0)      ,/* 參考來源分批序 */
sfka065       varchar2(10)      ,/* 生管結案狀態 */
sfkaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfkaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfkaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfkaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfkaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfkaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfkaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfkaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfkaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfkaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfkaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfkaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfkaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfkaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfkaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfkaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfkaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfkaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfkaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfkaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfkaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfkaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfkaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfkaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfkaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfkaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfkaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfkaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfkaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfkaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
sfka066       varchar2(10)      ,/* 多角流程編號 */
sfka067       varchar2(20)      ,/* 多角流程式號 */
sfka068       varchar2(10)      ,/* 成本中心 */
sfka069       number(20,6)      ,/* 可供給量 */
sfka070       date      ,/* 原始預計完工日期 */
sfka071       number(20,6)      ,/* 齊料套數 */
sfka072       varchar2(1)      /* 保稅否 */
);
alter table sfka_t add constraint sfka_pk primary key (sfkaent,sfkadocno,sfka900) enable validate;

create unique index sfka_pk on sfka_t (sfkaent,sfkadocno,sfka900);

grant select on sfka_t to tiptop;
grant update on sfka_t to tiptop;
grant delete on sfka_t to tiptop;
grant insert on sfka_t to tiptop;

exit;
