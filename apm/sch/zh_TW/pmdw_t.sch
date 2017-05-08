/* 
================================================================================
檔案代號:pmdw_t
檔案名稱:進項發票檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table pmdw_t
(
pmdwent       number(5)      ,/* 企業編號 */
pmdwownid       varchar2(20)      ,/* 資料所有者 */
pmdwowndp       varchar2(10)      ,/* 資料所有部門 */
pmdwcrtid       varchar2(20)      ,/* 資料建立者 */
pmdwcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmdwcrtdt       timestamp(0)      ,/* 資料創建日 */
pmdwmodid       varchar2(20)      ,/* 資料修改者 */
pmdwmoddt       timestamp(0)      ,/* 最近修改日 */
pmdwcnfid       varchar2(20)      ,/* 資料確認者 */
pmdwcnfdt       timestamp(0)      ,/* 資料確認日 */
pmdwstus       varchar2(10)      ,/* 狀態碼 */
pmdwcomp       varchar2(10)      ,/* 法人 */
pmdwdocno       varchar2(20)      ,/* 收貨單號 */
pmdwseq       number(10,0)      ,/* 項次 */
pmdw001       varchar2(10)      ,/* 發票來源 */
pmdw002       varchar2(10)      ,/* 開發票人 */
pmdw004       varchar2(10)      ,/* 帳務中心(業務組織) */
pmdw006       varchar2(10)      ,/* 業務部門(登入部門) */
pmdw008       varchar2(2)      ,/* 發票類型 */
pmdw009       varchar2(20)      ,/* 銷方發票代碼 */
pmdw010       varchar2(20)      ,/* 發票號碼 */
pmdw011       date      ,/* 發票日期 */
pmdw012       varchar2(10)      ,/* 稅別 */
pmdw0121       varchar2(1)      ,/* 含稅否 */
pmdw013       number(5,2)      ,/* 稅率 */
pmdw014       varchar2(10)      ,/* 幣別 */
pmdw015       number(20,10)      ,/* 匯率 */
pmdw016       varchar2(255)      ,/* 購貨方名稱 */
pmdw017       varchar2(20)      ,/* 購貨方稅務編號 */
pmdw018       varchar2(4000)      ,/* 購貨方地址 */
pmdw019       varchar2(20)      ,/* 購貨方電話 */
pmdw020       varchar2(255)      ,/* 購貨方開戶銀行 */
pmdw021       varchar2(30)      ,/* 購貨方帳戶編碼 */
pmdw022       varchar2(10)      ,/* 銷方銀行帳戶編碼 */
pmdw023       number(20,6)      ,/* 發票未稅金額 */
pmdw024       number(20,6)      ,/* 發票稅額 */
pmdw025       number(20,6)      ,/* 發票含稅金額 */
pmdw026       number(20,6)      ,/* 發票原幣未稅金額 */
pmdw027       number(20,6)      ,/* 發票原幣稅額 */
pmdw028       number(20,6)      ,/* 發票原幣含稅金額 */
pmdw029       varchar2(255)      ,/* 銷貨方名稱 */
pmdw030       varchar2(20)      ,/* 稅務編號 */
pmdw031       varchar2(4000)      ,/* 銷貨方地址 */
pmdw032       varchar2(20)      ,/* 銷貨方電話 */
pmdw033       varchar2(255)      ,/* 銷貨方開戶銀行 */
pmdw034       varchar2(30)      ,/* 銷貨方帳號 */
pmdw035       number(20,6)      ,/* 申報數量 */
pmdw036       varchar2(10)      ,/* 異動狀態 */
pmdw037       varchar2(1)      ,/* 可扣抵代碼 */
pmdw038       varchar2(10)      ,/* 作廢(登出)理由碼 */
pmdw039       date      ,/* 作廢日期 */
pmdw040       varchar2(8)      ,/* 作廢時間 */
pmdw041       varchar2(20)      ,/* 作廢人員 */
pmdw042       varchar2(80)      ,/* 專案作廢核准文號 */
pmdw043       varchar2(1)      ,/* 通關方式註記 */
pmdw044       number(5,0)      ,/* 列印次數 */
pmdw045       varchar2(20)      ,/* 支付工具卡號1 */
pmdw046       varchar2(20)      ,/* 支付工具卡號2 */
pmdw047       varchar2(20)      ,/* 支付工具卡號3 */
pmdw048       varchar2(10)      ,/* 通關註記 */
pmdw049       varchar2(255)      ,/* 備註說明 */
pmdw050       varchar2(20)      ,/* 立帳單號 */
pmdw107       number(20,6)      ,/* 發票原幣已折金額 */
pmdw108       number(20,6)      ,/* 發票原幣已折稅額 */
pmdw117       number(20,6)      ,/* 發票本幣已折金額 */
pmdw118       number(20,6)      ,/* 發票本幣已折稅額 */
pmdw200       varchar2(1)      ,/* 電子發票否 */
pmdw201       varchar2(10)      ,/* 愛心碼 */
pmdw202       varchar2(10)      ,/* 載具類別號碼 */
pmdw203       varchar2(80)      ,/* 載具顯碼 ID */
pmdw204       varchar2(80)      ,/* 載具隱碼 ID */
pmdw205       varchar2(1)      ,/* 電子發票匯出狀態 */
pmdw206       varchar2(20)      ,/* 電子發票匯出序號 */
pmdw207       varchar2(10)      ,/* 電子發票領取方式 */
pmdwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdwud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmdw_t add constraint pmdw_pk primary key (pmdwent,pmdwdocno,pmdwseq) enable validate;

create unique index pmdw_pk on pmdw_t (pmdwent,pmdwdocno,pmdwseq);

grant select on pmdw_t to tiptop;
grant update on pmdw_t to tiptop;
grant delete on pmdw_t to tiptop;
grant insert on pmdw_t to tiptop;

exit;
