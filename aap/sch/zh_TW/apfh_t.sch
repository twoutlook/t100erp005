/* 
================================================================================
檔案代號:apfh_t
檔案名稱:集團付款核銷單付款明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table apfh_t
(
apfhent       number(5)      ,/* 企業代碼 */
apfhld       varchar2(5)      ,/* 帳別 */
apfhdocno       varchar2(20)      ,/* 單號 */
apfhseq       number(10,0)      ,/* 項次 */
apfh001       varchar2(10)      ,/* 來源組織 */
apfh002       varchar2(20)      ,/* 已付款單號 */
apfh003       varchar2(30)      ,/* 付款帳戶 */
apfh004       varchar2(10)      ,/* 款別 */
apfh005       varchar2(10)      ,/* 銀行存提碼 */
apfh006       varchar2(10)      ,/* 類型 */
apfh007       varchar2(1)      ,/* 借貸別 */
apfh008       varchar2(20)      ,/* 票據號碼 */
apfh100       varchar2(10)      ,/* 付款幣別 */
apfh101       number(20,10)      ,/* 匯率 */
apfh103       number(20,6)      ,/* 付款原幣金額 */
apfh104       number(20,6)      ,/* 付款本幣金額 */
apfh201       number(20,10)      ,/* 對應代付方當日匯率 */
apfh204       number(20,6)      ,/* 對應代付方本幣金額 */
apfhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apfhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apfhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apfhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apfhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apfhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apfhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apfhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apfhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apfhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apfhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apfhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apfhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apfhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apfhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apfhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apfhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apfhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apfhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apfhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apfhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apfhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apfhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apfhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apfhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apfhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apfhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apfhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apfhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apfhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apfh_t add constraint apfh_pk primary key (apfhent,apfhdocno,apfhseq) enable validate;

create unique index apfh_pk on apfh_t (apfhent,apfhdocno,apfhseq);

grant select on apfh_t to tiptop;
grant update on apfh_t to tiptop;
grant delete on apfh_t to tiptop;
grant insert on apfh_t to tiptop;

exit;
