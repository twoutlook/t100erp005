/* 
================================================================================
檔案代號:fmcm_t
檔案名稱:融資資金划付明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmcm_t
(
fmcment       number(5)      ,/* 企業代碼 */
fmcmdocno       varchar2(20)      ,/* 融資合同編號 */
fmcmseq       number(10,0)      ,/* 合同項次 */
fmcmseq2       number(10,0)      ,/* 項次 */
fmcm001       varchar2(10)      ,/* 幣別 */
fmcm002       date      ,/* 划付日期 */
fmcm003       varchar2(30)      ,/* 貸款帳戶 */
fmcm004       number(20,6)      ,/* 金額 */
fmcmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmcmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmcmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmcmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmcmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmcmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmcmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmcmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmcmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmcmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmcmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmcmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmcmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmcmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmcmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmcmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmcmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmcmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmcmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmcmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmcmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmcmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmcmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmcmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmcmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmcmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmcmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmcmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmcmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmcmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmcm_t add constraint fmcm_pk primary key (fmcment,fmcmdocno,fmcmseq,fmcmseq2) enable validate;

create unique index fmcm_pk on fmcm_t (fmcment,fmcmdocno,fmcmseq,fmcmseq2);

grant select on fmcm_t to tiptop;
grant update on fmcm_t to tiptop;
grant delete on fmcm_t to tiptop;
grant insert on fmcm_t to tiptop;

exit;
