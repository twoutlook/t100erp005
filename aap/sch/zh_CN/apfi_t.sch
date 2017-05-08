/* 
================================================================================
檔案代號:apfi_t
檔案名稱:集團付款核銷單帳款明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table apfi_t
(
apfient       number(5)      ,/* 企業代碼 */
apfidocno       varchar2(20)      ,/* 單號 */
apfiseq       number(10,0)      ,/* 項次 */
apfi001       varchar2(20)      ,/* 帳款法人組織 */
apfi002       varchar2(5)      ,/* 帳款所屬帳套 */
apfi003       varchar2(20)      ,/* 應付單號 */
apfi004       number(10,0)      ,/* 應付單項次 */
apfi005       number(10,0)      ,/* 多帳期序號 */
apfi006       varchar2(10)      ,/* 類型 */
apfi007       varchar2(10)      ,/* 付款條件 */
apfi008       varchar2(10)      ,/* 稅別 */
apfi009       varchar2(10)      ,/* 內部銀行帳戶編碼 */
apfi010       varchar2(10)      ,/* 內部銀行存提碼 */
apfi011       date      ,/* 應付款日 */
apfi012       varchar2(10)      ,/* 帳款類別 */
apfi013       varchar2(1)      ,/* 借貸別 */
apfi100       varchar2(10)      ,/* 幣別 */
apfi101       number(20,10)      ,/* 匯率 */
apfi103       number(20,6)      ,/* 原幣沖帳金額 */
apfi104       number(20,6)      ,/* 本幣沖帳金額 */
apfi201       number(20,10)      ,/* 對應代付方當日匯率 */
apfi204       number(20,6)      ,/* 對應代付方本金額 */
apfiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apfiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apfiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apfiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apfiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apfiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apfiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apfiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apfiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apfiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apfiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apfiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apfiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apfiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apfiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apfiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apfiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apfiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apfiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apfiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apfiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apfiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apfiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apfiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apfiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apfiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apfiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apfiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apfiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apfiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apfi_t add constraint apfi_pk primary key (apfient,apfidocno,apfiseq) enable validate;

create unique index apfi_pk on apfi_t (apfient,apfidocno,apfiseq);

grant select on apfi_t to tiptop;
grant update on apfi_t to tiptop;
grant delete on apfi_t to tiptop;
grant insert on apfi_t to tiptop;

exit;
