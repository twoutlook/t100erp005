/* 
================================================================================
檔案代號:apfe_t
檔案名稱:集團代付款明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apfe_t
(
apfeent       number(5)      ,/* 企業編號 */
apfesite       varchar2(10)      ,/* 帳務中心 */
apfecomp       varchar2(10)      ,/* 法人(集團) */
apfeld       varchar2(5)      ,/* 帳套 */
apfeorga       varchar2(10)      ,/* 代付組織 */
apfedocno       varchar2(20)      ,/* 代付款(核銷)單號 */
apfeseq       number(10,0)      ,/* 項次 */
apfe001       varchar2(10)      ,/* 來源作業 */
apfe002       varchar2(20)      ,/* 沖銷類型 */
apfe003       varchar2(20)      ,/* 付款單號 */
apfe004       number(10,0)      ,/* 付款單項次 */
apfe005       varchar2(10)      ,/* 內部帳戶 */
apfe006       varchar2(20)      ,/* 款別代碼 */
apfe007       number(20,6)      ,/* 原幣付款面額 */
apfe008       varchar2(20)      ,/* 銀存帳戶(票據)號碼 */
apfe009       varchar2(1)      ,/* 已轉資料(銀存/票據/…) */
apfe010       varchar2(255)      ,/* 摘要說明 */
apfe011       varchar2(10)      ,/* 銀行存提碼 */
apfe012       varchar2(10)      ,/* 現金變動碼 */
apfe013       varchar2(10)      ,/* 轉入客商碼 */
apfe014       varchar2(20)      ,/* 轉入帳款單編號 */
apfe015       varchar2(1)      ,/* 沖銷加減項 */
apfe016       varchar2(24)      ,/* 沖銷科目 */
apfe019       varchar2(10)      ,/* 責任中心 */
apfe020       varchar2(10)      ,/* 產品類別 */
apfe021       varchar2(10)      ,/* 預算項目 */
apfe022       varchar2(20)      ,/* 專案代號 */
apfe023       varchar2(30)      ,/* WBS編號 */
apfe024       varchar2(20)      ,/* 第二參考單號 */
apfe025       number(10,0)      ,/* 第二參考單號項次 */
apfe026       varchar2(10)      ,/* 退款類型 */
apfe028       varchar2(1)      ,/* 產生方式 */
apfe029       varchar2(20)      ,/* 傳票號碼 */
apfe030       number(10,0)      ,/* 傳票項次 */
apfe031       date      ,/* 應付款日 */
apfe032       date      ,/* 付款(票)到期日 */
apfe033       varchar2(20)      ,/* 扣帳核銷者 */
apfe034       date      ,/* 扣帳核銷日期 */
apfe035       varchar2(10)      ,/* 區域 */
apfe036       varchar2(10)      ,/* 客戶分類 */
apfe037       varchar2(10)      ,/* 預算編號 */
apfe038       varchar2(10)      ,/* 交易對象 */
apfe039       varchar2(15)      ,/* 受款銀行 */
apfe040       varchar2(30)      ,/* 受款帳號 */
apfe041       varchar2(255)      ,/* 受款人全名 */
apfe042       varchar2(40)      ,/* SWIFT CODE */
apfe043       varchar2(40)      ,/* IBAN CODE */
apfe100       varchar2(10)      ,/* 幣別 */
apfe101       number(20,10)      ,/* 匯率 */
apfe109       number(20,6)      ,/* 原幣沖帳金額 */
apfe119       number(20,6)      ,/* 本幣沖帳金額 */
apfeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apfeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apfeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apfeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apfeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apfeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apfeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apfeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apfeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apfeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apfeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apfeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apfeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apfeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apfeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apfeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apfeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apfeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apfeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apfeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apfeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apfeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apfeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apfeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apfeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apfeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apfeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apfeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apfeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apfeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apfe_t add constraint apfe_pk primary key (apfeent,apfedocno,apfeseq) enable validate;

create  index apfe_01 on apfe_t (apfe001,apfe003,apfe004,apfe005);
create  index apfe_02 on apfe_t (apfe002,apfe006,apfe008,apfe009,apfe031,apfe032);
create  index apfe_03 on apfe_t (apfecomp,apfe005);
create  index apfe_04 on apfe_t (apfe024,apfe025);
create unique index apfe_pk on apfe_t (apfeent,apfedocno,apfeseq);

grant select on apfe_t to tiptop;
grant update on apfe_t to tiptop;
grant delete on apfe_t to tiptop;
grant insert on apfe_t to tiptop;

exit;
