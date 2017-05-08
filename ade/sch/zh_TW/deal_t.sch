/* 
================================================================================
檔案代號:deal_t
檔案名稱:門店營業款銀行存繳單明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table deal_t
(
dealent       number(5)      ,/* 企業編號 */
dealsite       varchar2(10)      ,/* 營運據點 */
dealunit       varchar2(10)      ,/* 應用組織 */
dealdocno       varchar2(20)      ,/* 存繳單號 */
dealseq       number(10,0)      ,/* 項次 */
deal001       date      ,/* 營業日期 */
deal002       varchar2(30)      ,/* 帳戶編號 */
deal003       varchar2(30)      ,/* 銀行帳號 */
deal004       varchar2(10)      ,/* 幣別 */
deal005       varchar2(10)      ,/* 款別分類 */
deal006       varchar2(10)      ,/* 款別編碼 */
deal007       number(20,6)      ,/* 存款金額 */
deal008       varchar2(20)      ,/* 支票號碼 */
dealud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dealud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dealud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dealud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dealud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dealud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dealud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dealud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dealud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dealud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dealud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dealud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dealud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dealud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dealud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dealud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dealud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dealud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dealud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dealud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dealud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dealud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dealud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dealud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dealud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dealud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dealud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dealud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dealud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dealud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
deal009       varchar2(20)      ,/* 轉撥備用金單號 */
deal010       number(10,0)      ,/* 轉撥備用金項次 */
deal011       number(20,6)      ,/* 轉撥金額 */
deal012       varchar2(15)      /* 銀行編號 */
);
alter table deal_t add constraint deal_pk primary key (dealent,dealdocno,dealseq) enable validate;

create unique index deal_pk on deal_t (dealent,dealdocno,dealseq);

grant select on deal_t to tiptop;
grant update on deal_t to tiptop;
grant delete on deal_t to tiptop;
grant insert on deal_t to tiptop;

exit;
