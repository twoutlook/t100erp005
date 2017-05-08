/* 
================================================================================
檔案代號:fmcs_t
檔案名稱:融資資金到帳單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmcs_t
(
fmcscomp       varchar2(10)      ,/* 法人 */
fmcsent       number(5)      ,/* 企業編號 */
fmcsdocno       varchar2(20)      ,/* 融資資金到帳單編號 */
fmcsseq       number(10,0)      ,/* 項次 */
fmcs001       varchar2(20)      ,/* 融資合同號 */
fmcs002       number(10,0)      ,/* 融資合同項次 */
fmcs003       varchar2(10)      ,/* 融資組織 */
fmcs004       varchar2(10)      ,/* 貸款帳戶 */
fmcs005       varchar2(1)      ,/* 異動別 */
fmcs006       varchar2(10)      ,/* 存提碼 */
fmcs007       varchar2(10)      ,/* 幣別 */
fmcs008       number(20,6)      ,/* 金額 */
fmcs009       number(20,10)      ,/* 匯率 */
fmcs010       number(20,6)      ,/* 本幣金額 */
fmcs011       number(20,10)      ,/* 匯率二 */
fmcs012       number(20,6)      ,/* 本幣金額二 */
fmcs013       number(20,10)      ,/* 匯率 三 */
fmcs014       number(20,6)      ,/* 本幣金額三 */
fmcs015       number(10,6)      ,/* 執行利率 */
fmcs016       varchar2(10)      ,/* 現金變動碼 */
fmcs017       number(20,6)      ,/* 已還本金 */
fmcs018       number(20,6)      ,/* 已還本幣一 */
fmcs019       number(20,6)      ,/* 已還本幣二 */
fmcs020       number(20,6)      ,/* 已還本幣三 */
fmcsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmcsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmcsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmcsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmcsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmcsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmcsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmcsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmcsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmcsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmcsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmcsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmcsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmcsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmcsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmcsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmcsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmcsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmcsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmcsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmcsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmcsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmcsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmcsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmcsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmcsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmcsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmcsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmcsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmcsud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmcs021       varchar2(255)      /* 摘要 */
);
alter table fmcs_t add constraint fmcs_pk primary key (fmcsent,fmcsdocno,fmcsseq) enable validate;

create unique index fmcs_pk on fmcs_t (fmcsent,fmcsdocno,fmcsseq);

grant select on fmcs_t to tiptop;
grant update on fmcs_t to tiptop;
grant delete on fmcs_t to tiptop;
grant insert on fmcs_t to tiptop;

exit;
