/* 
================================================================================
檔案代號:xrfb_t
檔案名稱:集團收款核銷單收款明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xrfb_t
(
xrfbent       number(5)      ,/* 企業編碼 */
xrfbdocno       varchar2(20)      ,/* 集團代收單號 */
xrfbld       varchar2(5)      ,/* 帳套 */
xrfbseq       number(10,0)      ,/* 項次 */
xrfb001       varchar2(10)      ,/* 來源組織 */
xrfb002       varchar2(20)      ,/* 繳款單號 */
xrfb003       number(10,0)      ,/* 繳款單項次 */
xrfb004       varchar2(10)      ,/* 款別 */
xrfb005       varchar2(10)      ,/* 銀行存提碼 */
xrfb006       varchar2(10)      ,/* 類型 */
xrfb007       varchar2(1)      ,/* 借貸別 */
xrfb100       varchar2(10)      ,/* 收款幣別 */
xrfb101       number(20,10)      ,/* 匯率 */
xrfb103       number(20,6)      ,/* 收款原幣金額 */
xrfb104       number(20,6)      ,/* 收款本幣金額 */
xrfb201       number(20,10)      ,/* 對應代收方當日匯率 */
xrfb204       number(20,6)      ,/* 對應代收方本幣金額 */
xrfbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrfbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrfbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrfbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrfbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrfbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrfbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrfbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrfbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrfbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrfbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrfbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrfbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrfbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrfbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrfbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrfbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrfbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrfbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrfbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrfbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrfbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrfbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrfbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrfbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrfbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrfbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrfbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrfbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrfbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xrfb_t add constraint xrfb_pk primary key (xrfbent,xrfbdocno,xrfbseq) enable validate;

create  index xrfb_n1 on xrfb_t (xrfbent,xrfb001,xrfb002,xrfb003);
create unique index xrfb_pk on xrfb_t (xrfbent,xrfbdocno,xrfbseq);

grant select on xrfb_t to tiptop;
grant update on xrfb_t to tiptop;
grant delete on xrfb_t to tiptop;
grant insert on xrfb_t to tiptop;

exit;
