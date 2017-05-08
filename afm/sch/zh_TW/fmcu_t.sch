/* 
================================================================================
檔案代號:fmcu_t
檔案名稱:融資帳務單單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fmcu_t
(
fmcuent       number(5)      ,/* 企業代碼 */
fmcudocno       varchar2(20)      ,/* 單號 */
fmcuseq       number(10,0)      ,/* 項次 */
fmcu001       varchar2(10)      ,/* 融資組織 */
fmcu002       varchar2(10)      ,/* 單據來源 */
fmcu003       varchar2(20)      ,/* 業務單號 */
fmcu004       number(10,0)      ,/* 業務單據項次 */
fmcu005       number(10,0)      ,/* 費用項次 */
fmcu006       varchar2(1)      ,/* 異動別 */
fmcu007       varchar2(10)      ,/* 存提碼 */
fmcu008       varchar2(10)      ,/* 幣別 */
fmcu009       number(20,6)      ,/* 金額 */
fmcu010       number(20,10)      ,/* 匯率 */
fmcu011       number(20,6)      ,/* 本幣 */
fmcu012       varchar2(24)      ,/* 科目 */
fmcu013       varchar2(24)      ,/* 對方科目 */
fmcu014       number(20,10)      ,/* 匯率二 */
fmcu015       number(20,6)      ,/* 本幣二 */
fmcu016       number(20,10)      ,/* 匯率三 */
fmcu017       number(20,6)      ,/* 本幣三 */
fmcu018       number(20,6)      ,/* 重評價本幣 */
fmcu019       number(20,6)      ,/* 重評價本幣二 */
fmcu020       number(20,6)      ,/* 重評價本幣三 */
fmcu021       varchar2(10)      ,/* 部門 */
fmcu022       varchar2(10)      ,/* 利潤中心 */
fmcu023       varchar2(10)      ,/* 區域 */
fmcu024       varchar2(10)      ,/* 交易客商 */
fmcu025       varchar2(10)      ,/* 收款客商 */
fmcu026       varchar2(10)      ,/* 客群 */
fmcu027       varchar2(10)      ,/* 產品類別 */
fmcu028       varchar2(20)      ,/* 人員 */
fmcu029       varchar2(10)      ,/* 預算編號 */
fmcu030       varchar2(20)      ,/* 專案編號 */
fmcu031       varchar2(30)      ,/* WBS */
fmcu032       varchar2(10)      ,/* 經營方式 */
fmcu033       varchar2(10)      ,/* 渠道 */
fmcu034       varchar2(10)      ,/* 品牌 */
fmcu035       varchar2(30)      ,/* 自由核算項一 */
fmcu036       varchar2(30)      ,/* 自由核算項二 */
fmcu037       varchar2(30)      ,/* 自由核算項三 */
fmcu038       varchar2(30)      ,/* 自由核算項四 */
fmcu039       varchar2(30)      ,/* 自由核算項五 */
fmcu040       varchar2(30)      ,/* 自由核算項六 */
fmcu041       varchar2(30)      ,/* 自由核算項七 */
fmcu042       varchar2(30)      ,/* 自由核算項八 */
fmcu043       varchar2(30)      ,/* 自由核算項九 */
fmcu044       varchar2(30)      ,/* 自由核算項十 */
fmcu045       varchar2(255)      ,/* 摘要 */
fmcuud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmcuud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmcuud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmcuud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmcuud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmcuud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmcuud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmcuud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmcuud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmcuud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmcuud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmcuud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmcuud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmcuud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmcuud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmcuud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmcuud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmcuud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmcuud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmcuud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmcuud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmcuud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmcuud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmcuud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmcuud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmcuud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmcuud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmcuud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmcuud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmcuud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmcu_t add constraint fmcu_pk primary key (fmcuent,fmcudocno,fmcuseq) enable validate;

create unique index fmcu_pk on fmcu_t (fmcuent,fmcudocno,fmcuseq);

grant select on fmcu_t to tiptop;
grant update on fmcu_t to tiptop;
grant delete on fmcu_t to tiptop;
grant insert on fmcu_t to tiptop;

exit;
