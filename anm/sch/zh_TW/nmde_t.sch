/* 
================================================================================
檔案代號:nmde_t
檔案名稱:銀行重評價檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table nmde_t
(
nmdeent       number(5)      ,/* 企業代碼 */
nmdecomp       varchar2(10)      ,/* 法人 */
nmdeld       varchar2(5)      ,/* 帳別 */
nmdesite       varchar2(10)      ,/* 帳務中心 */
nmde001       number(5,0)      ,/* 年度 */
nmde002       number(5,0)      ,/* 期別 */
nmde003       varchar2(10)      ,/* 來源模組 */
nmde004       varchar2(10)      ,/* 銀行帳戶 */
nmde005       varchar2(10)      ,/* 開戶組織 */
nmde006       varchar2(10)      ,/* 部門 */
nmde007       varchar2(10)      ,/* 責任中心 */
nmde008       varchar2(10)      ,/* 區域 */
nmde009       varchar2(10)      ,/* 客群 */
nmde010       varchar2(10)      ,/* 產品類別 */
nmde011       varchar2(20)      ,/* 人員 */
nmde012       varchar2(10)      ,/* 預算編號 */
nmde013       varchar2(20)      ,/* 專案代號 */
nmde014       varchar2(30)      ,/* WBS編號 */
nmde015       varchar2(24)      ,/* 會計科目 */
nmde017       varchar2(20)      ,/* 傳票號碼 */
nmde100       varchar2(10)      ,/* 幣別 */
nmde101       number(20,10)      ,/* 重評價匯率 */
nmde102       number(20,6)      ,/* 本期原幣未沖金額 */
nmde103       number(20,6)      ,/* 本期本幣未沖金額 */
nmde104       number(20,6)      ,/* 本期重評價後本幣金額 */
nmde105       number(20,6)      ,/* 本期匯差金額 */
nmde106       number(20,6)      ,/* 本期匯差傳票提列金額 */
nmde111       number(20,10)      ,/* 本位幣二重評價匯率 */
nmde113       number(20,6)      ,/* 本期本位幣二未沖金額 */
nmde114       number(20,6)      ,/* 本期本位幣二重評價後金額 */
nmde115       number(20,6)      ,/* 本期本位幣二匯差金額 */
nmde116       number(20,6)      ,/* 本期本位幣二匯差傳票提列提列金額 */
nmde121       number(20,10)      ,/* 本位幣三重評價匯率 */
nmde123       number(20,6)      ,/* 本期本位幣三未沖金額 */
nmde124       number(20,6)      ,/* 本期本位幣三重評價後金額 */
nmde125       number(20,6)      ,/* 本期本位幣三匯差金額 */
nmde126       number(20,6)      ,/* 本期本位幣三匯差傳票提列提列金額 */
nmdedocno       varchar2(20)      ,/* 單據編號 */
nmdedocdt       date      ,/* 單據日期 */
nmdeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmdeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmdeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmdeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmdeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmdeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmdeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmdeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmdeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmdeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmdeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmdeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmdeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmdeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmdeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmdeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmdeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmdeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmdeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmdeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmdeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmdeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmdeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmdeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmdeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmdeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmdeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmdeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmdeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmdeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmde_t add constraint nmde_pk primary key (nmdeent,nmdeld,nmde001,nmde002,nmde004) enable validate;

create unique index nmde_pk on nmde_t (nmdeent,nmdeld,nmde001,nmde002,nmde004);

grant select on nmde_t to tiptop;
grant update on nmde_t to tiptop;
grant delete on nmde_t to tiptop;
grant insert on nmde_t to tiptop;

exit;
