/* 
================================================================================
檔案代號:fmcn_t
檔案名稱:融資利率確定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmcn_t
(
fmcnent       number(5)      ,/* 企業代碼 */
fmcndocno       varchar2(20)      ,/* 融資合同編號 */
fmcnseq       number(10,0)      ,/* 融資合同項次 */
fmcnseq2       number(10,0)      ,/* 項次 */
fmcn001       varchar2(10)      ,/* 幣別 */
fmcn002       date      ,/* 利率確定日 */
fmcn003       varchar2(1)      ,/* 利率方式 */
fmcn004       number(15,3)      ,/* 基準利率(年%) */
fmcn005       varchar2(1)      ,/* 浮動方式 */
fmcn006       number(15,3)      ,/* 浮動利率(%) */
fmcn007       number(15,3)      ,/* 執行利率(年%) */
fmcnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmcnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmcnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmcnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmcnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmcnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmcnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmcnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmcnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmcnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmcnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmcnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmcnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmcnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmcnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmcnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmcnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmcnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmcnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmcnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmcnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmcnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmcnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmcnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmcnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmcnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmcnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmcnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmcnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmcnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmcn_t add constraint fmcn_pk primary key (fmcnent,fmcndocno,fmcnseq,fmcnseq2) enable validate;

create unique index fmcn_pk on fmcn_t (fmcnent,fmcndocno,fmcnseq,fmcnseq2);

grant select on fmcn_t to tiptop;
grant update on fmcn_t to tiptop;
grant delete on fmcn_t to tiptop;
grant insert on fmcn_t to tiptop;

exit;
