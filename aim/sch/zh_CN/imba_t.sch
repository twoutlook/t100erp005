/* 
================================================================================
檔案代號:imba_t
檔案名稱:商品准入/料件申請單主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table imba_t
(
imbaent       number(5)      ,/* 企業編號 */
imbadocno       varchar2(20)      ,/* 申請單號 */
imbadocdt       date      ,/* 單據日期 */
imba000       varchar2(1)      ,/* 申請類別 */
imba001       varchar2(40)      ,/* 料件編號 */
imba002       varchar2(10)      ,/* 目前版本 */
imba003       varchar2(10)      ,/* 主分群碼 */
imba004       varchar2(10)      ,/* 料件類別 */
imba005       varchar2(40)      ,/* 特徵組別 */
imba006       varchar2(10)      ,/* 基礎單位 */
imba009       varchar2(10)      ,/* 產品分類碼 */
imba010       varchar2(10)      ,/* 生命週期狀態 */
imba011       varchar2(10)      ,/* 產出類型 */
imba012       varchar2(1)      ,/* 允許副產品產出 */
imba013       varchar2(40)      ,/* 目錄編號 */
imba014       varchar2(40)      ,/* 產品條碼編號 */
imba015       varchar2(20)      ,/* 國際編號 */
imba016       number(20,6)      ,/* 毛重 */
imba017       number(20,6)      ,/* 淨重 */
imba018       varchar2(10)      ,/* 重量單位 */
imba019       number(20,6)      ,/* 長度 */
imba020       number(20,6)      ,/* 寬度 */
imba021       number(20,6)      ,/* 高度 */
imba022       varchar2(10)      ,/* 長度單位 */
imba023       number(20,6)      ,/* 面積 */
imba024       varchar2(10)      ,/* 面積單位 */
imba025       number(20,6)      ,/* 體積 */
imba026       varchar2(10)      ,/* 體積單位 */
imba027       varchar2(1)      ,/* 為包裝容器 */
imba028       number(20,6)      ,/* 容量 */
imba029       varchar2(10)      ,/* 容量單位 */
imba030       number(20,6)      ,/* 超量容差(%) */
imba031       number(20,6)      ,/* 載重量 */
imba032       varchar2(10)      ,/* 載重單位 */
imba033       number(20,6)      ,/* 超重容差(%) */
imba034       varchar2(10)      ,/* 料號來源 */
imba035       varchar2(40)      ,/* 來源參考料號 */
imba036       varchar2(1)      ,/* 記錄組裝位置(插件) */
imba037       varchar2(1)      ,/* 組裝位置須勾稽 */
imba038       varchar2(1)      ,/* 工程料件 */
imba041       varchar2(255)      ,/* 工程圖號 */
imba042       varchar2(20)      ,/* 主要模具編號 */
imba043       varchar2(10)      ,/* 據點研發可調整元件 */
imba044       varchar2(10)      ,/* AVL控管點 */
imba045       varchar2(10)      ,/* 生產國家地區 */
imba100       varchar2(10)      ,/* 條碼分類 */
imba101       varchar2(10)      ,/* 主供應商 */
imba102       number(5,0)      ,/* 保質期(月) */
imba103       number(5,0)      ,/* 保質期(天) */
imba104       varchar2(10)      ,/* 庫存單位 */
imba105       varchar2(10)      ,/* 銷售單位 */
imba106       varchar2(10)      ,/* 銷售計價單位 */
imba107       varchar2(10)      ,/* 採購單位 */
imba108       varchar2(10)      ,/* 商品種類 */
imba109       varchar2(10)      ,/* 條碼類型 */
imba110       varchar2(1)      ,/* 季節性商品 */
imba111       date      ,/* 開始日期 */
imba112       date      ,/* 結束日期 */
imba113       number(5,0)      ,/* 傳秤因子 */
imba114       varchar2(10)      ,/* 計價幣別 */
imba115       number(20,6)      ,/* 預計進貨價格 */
imba116       number(20,6)      ,/* 預計銷貨價格 */
imba117       number(20,6)      ,/* 進銷差率 */
imba118       number(5,0)      ,/* 試銷期(天) */
imba119       number(20,6)      ,/* 試銷金額 */
imba120       number(20,6)      ,/* 試銷數量 */
imba121       varchar2(1)      ,/* 是否網路經營 */
imba122       varchar2(10)      ,/* 產地分類 */
imba123       varchar2(80)      ,/* 產地說明 */
imba124       varchar2(10)      ,/* 進銷項稅別 */
imba125       varchar2(1)      ,/* 一次性商品 */
imba126       varchar2(10)      ,/* 品牌 */
imba127       varchar2(10)      ,/* 系列 */
imba128       varchar2(10)      ,/* 型別 */
imba129       varchar2(10)      ,/* 功能 */
imba130       varchar2(80)      ,/* 成份 */
imba131       varchar2(10)      ,/* 價格帶 */
imba132       varchar2(10)      ,/* 其它屬性一 */
imba133       varchar2(10)      ,/* 其它屬性二 */
imba134       varchar2(10)      ,/* 其它屬性三 */
imba135       varchar2(10)      ,/* 其它屬性四 */
imba136       varchar2(10)      ,/* 其它屬性五 */
imba137       varchar2(10)      ,/* 其它屬性六 */
imba138       varchar2(10)      ,/* 其它屬性七 */
imba139       varchar2(10)      ,/* 其它屬性八 */
imba140       varchar2(10)      ,/* 其它屬性九 */
imba141       varchar2(10)      ,/* 其它屬性十 */
imba142       varchar2(10)      ,/* 制定組織 */
imba143       varchar2(10)      ,/* 產品組編號 */
imba144       varchar2(1)      ,/* 庫存多單位 */
imba145       varchar2(10)      ,/* 採購計價單位 */
imba146       varchar2(10)      ,/* 成本單位 */
imba900       varchar2(20)      ,/* 申請人員 */
imba901       varchar2(10)      ,/* 申請部門 */
imbastus       varchar2(10)      ,/* 狀態碼 */
imbaownid       varchar2(20)      ,/* 資料所有者 */
imbaowndp       varchar2(10)      ,/* 資料所屬部門 */
imbacrtid       varchar2(20)      ,/* 資料建立者 */
imbacrtdp       varchar2(10)      ,/* 資料建立部門 */
imbacrtdt       timestamp(0)      ,/* 資料創建日 */
imbamodid       varchar2(20)      ,/* 資料修改者 */
imbamoddt       timestamp(0)      ,/* 最近修改日 */
imbacnfid       varchar2(20)      ,/* 資料確認者 */
imbacnfdt       timestamp(0)      ,/* 資料確認日 */
imbaacti       varchar2(1)      ,/* 商品有效碼 */
imbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imbaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
imba147       number(20,6)      ,/* 預設商品臨期比例 */
imba148       number(5,0)      ,/* 商品臨期天數 */
imba149       varchar2(10)      /* 臨期控管方式 */
);
alter table imba_t add constraint imba_pk primary key (imbaent,imbadocno) enable validate;

create unique index imba_pk on imba_t (imbaent,imbadocno);

grant select on imba_t to tiptop;
grant update on imba_t to tiptop;
grant delete on imba_t to tiptop;
grant insert on imba_t to tiptop;

exit;
