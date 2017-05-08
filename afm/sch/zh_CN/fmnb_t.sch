/* 
================================================================================
檔案代號:fmnb_t
檔案名稱:投資重評價帳務單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmnb_t
(
fmnbent       number(5)      ,/* 企業編號 */
fmnbdocno       varchar2(20)      ,/* 重評價單號 */
fmnbseq       number(10,0)      ,/* 項次 */
fmnb001       varchar2(1)      ,/* 來源 */
fmnb002       varchar2(20)      ,/* 單據號碼 */
fmnb003       number(10,0)      ,/* 項次 */
fmnb004       number(10,0)      ,/* 欄位項次 */
fmnb005       varchar2(10)      ,/* 帳款對象 */
fmnb006       varchar2(10)      ,/* 收款對象 */
fmnb007       varchar2(10)      ,/* 部門 */
fmnb008       varchar2(10)      ,/* 利潤中心 */
fmnb009       varchar2(10)      ,/* 區域 */
fmnb010       varchar2(10)      ,/* 客群 */
fmnb011       varchar2(10)      ,/* 產品類別 */
fmnb012       varchar2(20)      ,/* 人員 */
fmnb013       varchar2(20)      ,/* 專案代號 */
fmnb014       varchar2(30)      ,/* WBS編號 */
fmnb015       varchar2(10)      ,/* 經營方式 */
fmnb016       varchar2(10)      ,/* 渠道 */
fmnb017       varchar2(10)      ,/* 品牌 */
fmnb018       varchar2(30)      ,/* 自由核算項一 */
fmnb019       varchar2(30)      ,/* 自由核算項二 */
fmnb020       varchar2(30)      ,/* 自由核算項三 */
fmnb021       varchar2(30)      ,/* 自由核算項四 */
fmnb022       varchar2(30)      ,/* 自由核算項五 */
fmnb023       varchar2(30)      ,/* 自由核算項六 */
fmnb024       varchar2(30)      ,/* 自由核算項七 */
fmnb025       varchar2(30)      ,/* 自由核算項八 */
fmnb026       varchar2(30)      ,/* 自由核算項九 */
fmnb027       varchar2(30)      ,/* 自由核算項十 */
fmnb028       varchar2(24)      ,/* 重評價會計科目 */
fmnb029       varchar2(24)      ,/* 科目 */
fmnb030       varchar2(10)      ,/* 來源組織 */
fmnb031       varchar2(255)      ,/* 摘要 */
fmnb100       varchar2(10)      ,/* 幣別 */
fmnb101       number(20,10)      ,/* 重評價匯率 */
fmnb102       number(20,10)      ,/* 上月重評匯率 */
fmnb103       number(20,6)      ,/* 本期原幣未沖金額 */
fmnb113       number(20,6)      ,/* 本期本幣未沖金額 */
fmnb114       number(20,6)      ,/* 本期重評價後本幣金額 */
fmnb115       number(20,6)      ,/* 本期匯差金額 */
fmnb116       number(20,6)      ,/* 本幣累計匯差 */
fmnb121       number(20,10)      ,/* 本位幣二重評價匯率 */
fmnb122       number(20,10)      ,/* 本位幣二上月重估匯率 */
fmnb123       number(20,6)      ,/* 本期本位幣二未沖金額 */
fmnb124       number(20,6)      ,/* 本期本位幣二重評價後金額 */
fmnb125       number(20,6)      ,/* 本期本位幣二匯差金額 */
fmnb126       number(20,6)      ,/* 本位幣二累計匯差 */
fmnb131       number(20,10)      ,/* 本位幣三重評價匯率 */
fmnb132       number(20,10)      ,/* 本位幣三上月重估匯率 */
fmnb133       number(20,6)      ,/* 本期本位幣三未沖金額 */
fmnb134       number(20,6)      ,/* 本期本位幣三重評價後金額 */
fmnb135       number(20,6)      ,/* 本期本位幣三匯差金額 */
fmnb136       number(20,6)      ,/* 本位幣三累計匯差 */
fmnbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmnbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmnbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmnbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmnbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmnbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmnbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmnbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmnbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmnbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmnbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmnbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmnbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmnbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmnbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmnbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmnbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmnbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmnbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmnbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmnbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmnbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmnbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmnbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmnbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmnbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmnbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmnbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmnbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmnbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmnb032       date      ,/* 單據日期 */
fmnb033       varchar2(20)      /* 交易原始單號 */
);
alter table fmnb_t add constraint fmnb_pk primary key (fmnbent,fmnbdocno,fmnbseq) enable validate;

create unique index fmnb_pk on fmnb_t (fmnbent,fmnbdocno,fmnbseq);

grant select on fmnb_t to tiptop;
grant update on fmnb_t to tiptop;
grant delete on fmnb_t to tiptop;
grant insert on fmnb_t to tiptop;

exit;
