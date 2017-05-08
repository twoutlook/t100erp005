/* 
================================================================================
檔案代號:pmdl_t
檔案名稱:採購單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmdl_t
(
pmdlent       number(5)      ,/* 企業編號 */
pmdlsite       varchar2(10)      ,/* 營運據點 */
pmdlunit       varchar2(10)      ,/* 應用組織 */
pmdldocno       varchar2(20)      ,/* 採購單號 */
pmdldocdt       date      ,/* 採購日期 */
pmdl001       number(5,0)      ,/* 版次 */
pmdl002       varchar2(20)      ,/* 採購人員 */
pmdl003       varchar2(10)      ,/* 採購部門 */
pmdl004       varchar2(10)      ,/* 供應商編號 */
pmdl005       varchar2(10)      ,/* 採購性質 */
pmdl006       varchar2(10)      ,/* 多角性質 */
pmdl007       varchar2(10)      ,/* 資料來源類型 */
pmdl008       varchar2(20)      ,/* 來源單號 */
pmdl009       varchar2(10)      ,/* 付款條件 */
pmdl010       varchar2(10)      ,/* 交易條件 */
pmdl011       varchar2(10)      ,/* 稅別 */
pmdl012       number(5,2)      ,/* 稅率 */
pmdl013       varchar2(1)      ,/* 單價含稅否 */
pmdl015       varchar2(10)      ,/* 幣別 */
pmdl016       number(20,10)      ,/* 匯率 */
pmdl017       varchar2(10)      ,/* 取價方式 */
pmdl018       varchar2(10)      ,/* 付款優惠條件 */
pmdl019       varchar2(1)      ,/* 納入 MPS/MRP計算 */
pmdl020       varchar2(10)      ,/* 運送方式 */
pmdl021       varchar2(10)      ,/* 付款供應商 */
pmdl022       varchar2(10)      ,/* 送貨供應商 */
pmdl023       varchar2(10)      ,/* 採購分類一 */
pmdl024       varchar2(10)      ,/* 採購分類二 */
pmdl025       varchar2(10)      ,/* 送貨地址 */
pmdl026       varchar2(10)      ,/* 帳款地址 */
pmdl027       varchar2(20)      ,/* 供應商連絡人 */
pmdl028       varchar2(20)      ,/* 一次性交易對象識別碼 */
pmdl029       varchar2(10)      ,/* 收貨部門 */
pmdl030       varchar2(1)      ,/* 多角貿易已拋轉 */
pmdl031       varchar2(20)      ,/* 多角序號 */
pmdl032       varchar2(10)      ,/* 最終客戶 */
pmdl033       varchar2(2)      ,/* 發票類型 */
pmdl040       number(20,6)      ,/* 採購總未稅金額 */
pmdl041       number(20,6)      ,/* 採購總含稅金額 */
pmdl042       number(20,6)      ,/* 採購總稅額 */
pmdl043       varchar2(10)      ,/* 留置原因 */
pmdl044       varchar2(255)      ,/* 備註 */
pmdl046       varchar2(10)      ,/* 預付款發票開立方式 */
pmdl047       varchar2(1)      ,/* 物流結案 */
pmdl048       varchar2(1)      ,/* 帳流結案 */
pmdl049       varchar2(1)      ,/* 金流結案 */
pmdl050       varchar2(1)      ,/* 多角最終站否 */
pmdl051       varchar2(10)      ,/* 多角流程代碼 */
pmdl052       varchar2(10)      ,/* 最終供應商 */
pmdl053       varchar2(10)      ,/* 兩角目的據點 */
pmdl054       varchar2(10)      ,/* 內外購 */
pmdl055       varchar2(10)      ,/* 匯率計算基準 */
pmdl200       varchar2(10)      ,/* 採購中心 */
pmdl201       varchar2(20)      ,/* 聯絡電話 */
pmdl202       varchar2(20)      ,/* 傳真號碼 */
pmdl203       varchar2(10)      ,/* 採購方式 */
pmdl204       varchar2(10)      ,/* 配送中心 */
pmdl900       number(20,6)      ,/* 保留欄位str */
pmdl999       number(20,6)      ,/* 保留欄位end */
pmdlownid       varchar2(20)      ,/* 資料所有者 */
pmdlowndp       varchar2(10)      ,/* 資料所屬部門 */
pmdlcrtid       varchar2(20)      ,/* 資料建立者 */
pmdlcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmdlcrtdt       timestamp(0)      ,/* 資料創建日 */
pmdlmodid       varchar2(20)      ,/* 資料修改者 */
pmdlmoddt       timestamp(0)      ,/* 最近修改日 */
pmdlcnfid       varchar2(20)      ,/* 資料確認者 */
pmdlcnfdt       timestamp(0)      ,/* 資料確認日 */
pmdlpstid       varchar2(20)      ,/* 資料過帳者 */
pmdlpstdt       timestamp(0)      ,/* 資料過帳日 */
pmdlstus       varchar2(10)      ,/* 狀態碼 */
pmdlud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdlud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdlud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdlud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdlud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdlud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdlud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdlud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdlud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdlud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdlud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdlud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdlud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdlud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdlud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdlud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdlud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdlud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdlud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdlud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdlud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdlud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdlud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdlud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdlud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdlud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdlud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdlud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdlud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdlud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmdl205       date      ,/* 採購最終有效日 */
pmdl206       varchar2(1)      ,/* 長效期訂單否 */
pmdl207       varchar2(10)      ,/* 所屬品類 */
pmdl208       varchar2(20)      /* 電子採購單號 */
);
alter table pmdl_t add constraint pmdl_pk primary key (pmdlent,pmdldocno) enable validate;

create unique index pmdl_pk on pmdl_t (pmdlent,pmdldocno);

grant select on pmdl_t to tiptop;
grant update on pmdl_t to tiptop;
grant delete on pmdl_t to tiptop;
grant insert on pmdl_t to tiptop;

exit;
