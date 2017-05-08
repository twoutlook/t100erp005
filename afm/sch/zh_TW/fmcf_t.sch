/* 
================================================================================
檔案代號:fmcf_t
檔案名稱:融資申請單單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmcf_t
(
fmcfent       number(5)      ,/* 企業代碼 */
fmcfdocno       varchar2(20)      ,/* 單號 */
fmcfseq       number(10,0)      ,/* 項次 */
fmcf001       varchar2(10)      ,/* 融資類型 */
fmcf002       varchar2(10)      ,/* 融資幣別 */
fmcf003       number(20,6)      ,/* 融資規模 */
fmcf004       number(20,6)      ,/* 融資成本(年利率%) */
fmcf005       number(10,0)      ,/* 融資期限(期別) */
fmcf006       varchar2(80)      ,/* 還款來源 */
fmcf007       varchar2(10)      ,/* 申請組織 */
fmcfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmcfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmcfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmcfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmcfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmcfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmcfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmcfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmcfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmcfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmcfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmcfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmcfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmcfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmcfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmcfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmcfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmcfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmcfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmcfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmcfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmcfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmcfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmcfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmcfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmcfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmcfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmcfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmcfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmcfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmcf_t add constraint fmcf_pk primary key (fmcfent,fmcfdocno,fmcfseq) enable validate;

create unique index fmcf_pk on fmcf_t (fmcfent,fmcfdocno,fmcfseq);

grant select on fmcf_t to tiptop;
grant update on fmcf_t to tiptop;
grant delete on fmcf_t to tiptop;
grant insert on fmcf_t to tiptop;

exit;
