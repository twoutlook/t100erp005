/* 
================================================================================
檔案代號:fmdc_t
檔案名稱:融資費用檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fmdc_t
(
fmdccomp       varchar2(10)      ,/* 法人 */
fmdcent       number(5)      ,/* 企業編號 */
fmdcdocno       varchar2(20)      ,/* 到帳單編號 */
fmdcseq       number(10,0)      ,/* 到帳單項次 */
fmdcseq2       number(10,0)      ,/* 項次 */
fmdc001       varchar2(20)      ,/* 融資合同號 */
fmdc002       number(10,0)      ,/* 合同項次 */
fmdc003       varchar2(1)      ,/* 費用種類 */
fmdc004       varchar2(10)      ,/* 幣別 */
fmdc005       number(20,6)      ,/* 費率 */
fmdc006       number(20,6)      ,/* 金額 */
fmdc007       varchar2(20)      ,/* 支付方式 */
fmdc008       varchar2(20)      ,/* LC票號 */
fmdc009       number(20,10)      ,/* 匯率 */
fmdc010       number(20,6)      ,/* 本幣 */
fmdc011       number(20,10)      ,/* 匯率二 */
fmdc012       number(20,6)      ,/* 本幣二 */
fmdc013       number(20,10)      ,/* 匯率三 */
fmdc014       number(20,6)      ,/* 本幣三 */
fmdc015       varchar2(1)      ,/* 異動別 */
fmdc016       varchar2(10)      ,/* 存提碼 */
fmdc017       varchar2(10)      ,/* 現金變動碼 */
fmdc018       varchar2(10)      ,/* 支付帳戶 */
fmdcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmdcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmdcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmdcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmdcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmdcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmdcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmdcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmdcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmdcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmdcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmdcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmdcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmdcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmdcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmdcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmdcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmdcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmdcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmdcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmdcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmdcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmdcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmdcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmdcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmdcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmdcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmdcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmdcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmdcud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmdc019       number(20,6)      ,/* 已攤銷費用 */
fmdc020       number(20,6)      ,/* 已攤銷費用本幣一 */
fmdc021       number(20,6)      ,/* 已攤銷費用本幣二 */
fmdc022       number(20,6)      /* 已攤銷費用本幣三 */
);
alter table fmdc_t add constraint fmdc_pk primary key (fmdcent,fmdcdocno,fmdcseq,fmdcseq2) enable validate;

create unique index fmdc_pk on fmdc_t (fmdcent,fmdcdocno,fmdcseq,fmdcseq2);

grant select on fmdc_t to tiptop;
grant update on fmdc_t to tiptop;
grant delete on fmdc_t to tiptop;
grant insert on fmdc_t to tiptop;

exit;
