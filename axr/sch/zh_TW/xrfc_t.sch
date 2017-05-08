/* 
================================================================================
檔案代號:xrfc_t
檔案名稱:集團收款核銷單帳款明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xrfc_t
(
xrfcent       number(5)      ,/* 企業編碼 */
xrfcdocno       varchar2(20)      ,/* 集團代收單號 */
xrfcseq       number(10,0)      ,/* 項次 */
xrfc001       varchar2(20)      ,/* 帳款法人組織 */
xrfc002       varchar2(5)      ,/* 帳款所屬帳套 */
xrfc003       varchar2(20)      ,/* 應收單號 */
xrfc004       number(10,0)      ,/* 應收單項次 */
xrfc005       number(10,0)      ,/* 多帳期序號 */
xrfc006       varchar2(10)      ,/* 類型 */
xrfc007       varchar2(10)      ,/* 收款條件 */
xrfc008       varchar2(10)      ,/* 稅別 */
xrfc009       varchar2(10)      ,/* 內部銀行帳戶編碼 */
xrfc010       varchar2(10)      ,/* 內部銀行存提碼 */
xrfc011       date      ,/* 應收款日 */
xrfc012       varchar2(10)      ,/* 帳款類別 */
xrfc013       varchar2(1)      ,/* 借貸別 */
xrfc100       varchar2(10)      ,/* 幣別 */
xrfc101       number(20,10)      ,/* 匯率 */
xrfc103       number(20,6)      ,/* 原幣沖帳金額 */
xrfc104       number(20,6)      ,/* 本幣沖帳金額 */
xrfc201       number(20,10)      ,/* 對應代收方當日匯率 */
xrfc204       number(20,6)      ,/* 對應代收方本金額 */
xrfcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrfcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrfcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrfcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrfcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrfcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrfcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrfcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrfcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrfcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrfcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrfcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrfcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrfcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrfcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrfcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrfcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrfcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrfcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrfcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrfcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrfcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrfcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrfcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrfcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrfcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrfcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrfcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrfcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrfcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xrfc_t add constraint xrfc_pk primary key (xrfcent,xrfcdocno,xrfcseq) enable validate;

create  index xrfc_n1 on xrfc_t (xrfcent,xrfc001,xrfc003,xrfc004,xrfc005);
create  index xrfc_n2 on xrfc_t (xrfcent,xrfc009,xrfc010);
create unique index xrfc_pk on xrfc_t (xrfcent,xrfcdocno,xrfcseq);

grant select on xrfc_t to tiptop;
grant update on xrfc_t to tiptop;
grant delete on xrfc_t to tiptop;
grant insert on xrfc_t to tiptop;

exit;
