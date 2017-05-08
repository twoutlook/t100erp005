/* 
================================================================================
檔案代號:rtil_t
檔案名稱:零售訂單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtil_t
(
rtilent       number(5)      ,/* 企業編號 */
rtilsite       varchar2(10)      ,/* 營運據點 */
rtilunit       varchar2(10)      ,/* 應用組織 */
rtildocno       varchar2(20)      ,/* 單據編號 */
rtildocdt       date      ,/* 單據日期 */
rtilstus       varchar2(10)      ,/* 狀態 */
rtil001       varchar2(30)      ,/* 會員卡號 */
rtil002       varchar2(10)      ,/* 客戶編號 */
rtil003       varchar2(20)      ,/* 一次性交易對象識別碼 */
rtil004       varchar2(20)      ,/* 業務人員 */
rtil005       varchar2(10)      ,/* 業務部門 */
rtil006       varchar2(10)      ,/* 銷售分類 */
rtil007       varchar2(10)      ,/* 送貨客戶編號 */
rtil008       varchar2(10)      ,/* 帳款客戶編號 */
rtil009       varchar2(10)      ,/* 發票客戶編號 */
rtil010       number(5,0)      ,/* 整單折扣 */
rtil011       varchar2(20)      ,/* 起始發票折讓號碼 */
rtil012       varchar2(20)      ,/* 截止發票折讓號碼 */
rtil013       number(15,3)      ,/* 交易積點 */
rtil014       varchar2(10)      ,/* 送貨類型 */
rtil015       varchar2(10)      ,/* 送貨營運組織 */
rtil016       varchar2(12)      ,/* 收貨郵政編號 */
rtil017       varchar2(4000)      ,/* 收貨地址 */
rtil018       varchar2(80)      ,/* 收貨人 */
rtil019       varchar2(20)      ,/* 收貨聯絡電話 */
rtil020       varchar2(10)      ,/* 提貨類別 */
rtil021       varchar2(10)      ,/* 取貨營運組織 */
rtil022       varchar2(10)      ,/* 收款條件 */
rtil023       varchar2(10)      ,/* 交易幣別 */
rtil024       number(20,10)      ,/* 交易匯率 */
rtil025       varchar2(10)      ,/* 稅別 */
rtil026       number(5,2)      ,/* 稅率 */
rtil027       varchar2(1)      ,/* 含稅 */
rtil028       number(20,6)      ,/* 含稅應收金額 */
rtil029       varchar2(10)      ,/* 資料來源 */
rtil030       varchar2(20)      ,/* 資料來源單號 */
rtil031       date      ,/* 來源交易日期 */
rtil032       timestamp(0)      ,/* 來源交易時間 */
rtil033       varchar2(10)      ,/* 收銀機號 */
rtil034       varchar2(20)      ,/* 收銀人員 */
rtil035       varchar2(10)      ,/* 班別 */
rtil036       varchar2(10)      ,/* 收銀方式 */
rtil037       varchar2(1)      ,/* 收款結賬否 */
rtil038       varchar2(255)      ,/* 備註 */
rtilownid       varchar2(20)      ,/* 資料所有者 */
rtilowndp       varchar2(10)      ,/* 資料所屬部門 */
rtilcrtid       varchar2(20)      ,/* 資料建立者 */
rtilcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtilcrtdt       timestamp(0)      ,/* 資料創建日 */
rtilmodid       varchar2(20)      ,/* 資料修改者 */
rtilmoddt       timestamp(0)      ,/* 最近修改日 */
rtilcnfid       varchar2(20)      ,/* 資料確認者 */
rtilcnfdt       timestamp(0)      ,/* 資料確認日 */
rtilud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtilud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtilud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtilud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtilud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtilud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtilud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtilud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtilud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtilud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtilud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtilud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtilud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtilud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtilud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtilud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtilud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtilud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtilud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtilud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtilud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtilud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtilud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtilud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtilud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtilud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtilud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtilud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtilud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtilud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtil039       number(20,6)      ,/* 應收款金額 */
rtil040       number(20,6)      ,/* 收款比例 */
rtil041       varchar2(20)      ,/* 來源單號 */
rtil000       varchar2(20)      ,/* 作業編號 */
rtil042       varchar2(10)      /* 訂單類型 */
);
alter table rtil_t add constraint rtil_pk primary key (rtilent,rtildocno) enable validate;

create unique index rtil_pk on rtil_t (rtilent,rtildocno);

grant select on rtil_t to tiptop;
grant update on rtil_t to tiptop;
grant delete on rtil_t to tiptop;
grant insert on rtil_t to tiptop;

exit;
