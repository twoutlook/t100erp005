/* 
================================================================================
檔案代號:fmmm_t
檔案名稱:計提投資收益維護單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmmm_t
(
fmmment       number(5)      ,/* 企業編號 */
fmmm001       varchar2(20)      ,/* 投資購買帳務單號 */
fmmmseq       number(10,0)      ,/* 項次 */
fmmm002       varchar2(10)      ,/* 投資組織 */
fmmm003       varchar2(20)      ,/* 投資購買單號 */
fmmm004       varchar2(1)      ,/* 來源類型 */
fmmm005       varchar2(10)      ,/* 費用類型 */
fmmm006       varchar2(24)      ,/* 會計科目 */
fmmm007       varchar2(10)      ,/* 幣別 */
fmmm008       number(20,6)      ,/* 金額 */
fmmm009       number(20,10)      ,/* 本幣一匯率 */
fmmm010       number(20,6)      ,/* 本幣金額 */
fmmm013       number(20,10)      ,/* 本幣二匯率 */
fmmm014       number(20,6)      ,/* 本幣二金額 */
fmmm015       number(20,10)      ,/* 本幣三匯率 */
fmmm016       number(20,6)      ,/* 本幣三金額 */
fmmm020       varchar2(10)      ,/* 帳款對象 */
fmmm021       varchar2(10)      ,/* 收款對象 */
fmmm022       varchar2(10)      ,/* 部門 */
fmmm023       varchar2(10)      ,/* 利潤中心 */
fmmm024       varchar2(10)      ,/* 區域 */
fmmm025       varchar2(10)      ,/* 客群 */
fmmm026       varchar2(10)      ,/* 產品類別 */
fmmm027       varchar2(20)      ,/* 人員 */
fmmm028       varchar2(20)      ,/* 專案代號 */
fmmm029       varchar2(20)      ,/* WBS編號 */
fmmm030       varchar2(10)      ,/* 經營方式 */
fmmm031       varchar2(10)      ,/* 渠道 */
fmmm032       varchar2(10)      ,/* 品牌 */
fmmm033       varchar2(30)      ,/* 自由核算項一 */
fmmm034       varchar2(30)      ,/* 自由核算項二 */
fmmm035       varchar2(30)      ,/* 自由核算項三 */
fmmm036       varchar2(30)      ,/* 自由核算項四 */
fmmm037       varchar2(30)      ,/* 自由核算項五 */
fmmm038       varchar2(30)      ,/* 自由核算項六 */
fmmm039       varchar2(30)      ,/* 自由核算項七 */
fmmm040       varchar2(30)      ,/* 自由核算項八 */
fmmm041       varchar2(30)      ,/* 自由核算項九 */
fmmm042       varchar2(30)      ,/* 自由核算項十 */
fmmm043       varchar2(255)      ,/* 摘要 */
fmmmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmmud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmmm044       varchar2(10)      ,/* 存提碼 */
fmmm045       varchar2(10)      ,/* 現金變動碼 */
fmmm046       varchar2(24)      /* 對方科目 */
);
alter table fmmm_t add constraint fmmm_pk primary key (fmmment,fmmm001,fmmmseq) enable validate;

create unique index fmmm_pk on fmmm_t (fmmment,fmmm001,fmmmseq);

grant select on fmmm_t to tiptop;
grant update on fmmm_t to tiptop;
grant delete on fmmm_t to tiptop;
grant insert on fmmm_t to tiptop;

exit;
