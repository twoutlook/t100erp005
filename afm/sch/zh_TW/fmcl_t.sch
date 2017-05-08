/* 
================================================================================
檔案代號:fmcl_t
檔案名稱:融資付息還本設置檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmcl_t
(
fmclent       number(5)      ,/* 企業代碼 */
fmcldocno       varchar2(20)      ,/* 融資合同編號 */
fmclseq       number(10,0)      ,/* 融資清單項次 */
fmclseq2       number(10,0)      ,/* 項次 */
fmcl001       varchar2(1)      ,/* 還款性質 */
fmcl002       varchar2(1)      ,/* 還款週期 */
fmcl003       number(5,0)      ,/* 起始付息期別 */
fmcl004       number(5,0)      ,/* 付息日 */
fmcl005       date      ,/* 約定還本日期 */
fmcl006       number(20,6)      ,/* 還本金額 */
fmclud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmclud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmclud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmclud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmclud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmclud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmclud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmclud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmclud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmclud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmclud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmclud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmclud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmclud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmclud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmclud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmclud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmclud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmclud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmclud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmclud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmclud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmclud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmclud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmclud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmclud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmclud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmclud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmclud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmclud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmcl_t add constraint fmcl_pk primary key (fmclent,fmcldocno,fmclseq,fmclseq2) enable validate;

create unique index fmcl_pk on fmcl_t (fmclent,fmcldocno,fmclseq,fmclseq2);

grant select on fmcl_t to tiptop;
grant update on fmcl_t to tiptop;
grant delete on fmcl_t to tiptop;
grant insert on fmcl_t to tiptop;

exit;
