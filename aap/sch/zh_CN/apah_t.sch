/* 
================================================================================
檔案代號:apah_t
檔案名稱:零用金撥補申請明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apah_t
(
apahent       number(5)      ,/* 集團碼 */
apahsite       varchar2(10)      ,/* 帳務中心 */
apahcomp       varchar2(10)      ,/* 法人組織 */
apahdocno       varchar2(20)      ,/* 撥補單號 */
apahseq       number(10,0)      ,/* 項次 */
apah001       varchar2(10)      ,/* 交易帳戶編號 */
apah002       varchar2(10)      ,/* 存提碼 */
apah003       varchar2(255)      ,/* 備註 */
apah004       date      ,/* 申請入帳日期 */
apah005       varchar2(20)      ,/* 銀存收支單號 */
apah006       number(10,0)      ,/* 銀存收支項次 */
apah100       varchar2(10)      ,/* 幣別 */
apah103       number(20,6)      ,/* 申請撥補金額 */
apah104       number(20,6)      ,/* 銀存入帳金額 */
apahud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apahud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apahud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apahud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apahud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apahud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apahud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apahud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apahud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apahud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apahud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apahud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apahud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apahud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apahud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apahud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apahud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apahud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apahud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apahud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apahud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apahud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apahud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apahud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apahud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apahud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apahud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apahud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apahud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apahud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apah_t add constraint apah_pk primary key (apahent,apahcomp,apahdocno,apahseq) enable validate;

create unique index apah_pk on apah_t (apahent,apahcomp,apahdocno,apahseq);

grant select on apah_t to tiptop;
grant update on apah_t to tiptop;
grant delete on apah_t to tiptop;
grant insert on apah_t to tiptop;

exit;
