/* 
================================================================================
檔案代號:apfb_t
檔案名稱:集團代付款沖銷帳款明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apfb_t
(
apfbent       number(5)      ,/* 企業編號 */
apfbsite       varchar2(10)      ,/* 帳務中心 */
apfbcomp       varchar2(10)      ,/* 法人 */
apfblegl       varchar2(10)      ,/* 核算組織 */
apfbld       varchar2(5)      ,/* 帳套 */
apfbdocno       varchar2(20)      ,/* 代付款(核銷)單號 */
apfbseq       number(10,0)      ,/* 項次 */
apfborga       varchar2(10)      ,/* 帳務歸屬組織(被代付組織) */
apfb001       varchar2(10)      ,/* 來源作業 */
apfb002       varchar2(20)      ,/* 沖銷類型 */
apfb003       varchar2(20)      ,/* 沖銷帳款單號 */
apfb004       number(10,0)      ,/* 沖銷帳款單項次 */
apfb005       number(10,0)      ,/* 沖銷帳款單帳期 */
apfb006       varchar2(10)      ,/* 內部帳戶 */
apfb007       varchar2(20)      ,/* 發票代碼 */
apfb008       varchar2(20)      ,/* 發票號碼 */
apfb010       varchar2(255)      ,/* 摘要說明 */
apfb011       varchar2(10)      ,/* 內部帳戶存提碼 */
apfb012       varchar2(10)      ,/* 內部帳戶現金變動碼 */
apfb013       varchar2(10)      ,/* 轉入客商碼 */
apfb014       varchar2(20)      ,/* 轉入帳款單編號 */
apfb015       varchar2(1)      ,/* 沖銷加減項 */
apfb016       varchar2(24)      ,/* 沖銷科目 */
apfb017       varchar2(20)      ,/* 業務人員 */
apfb018       varchar2(10)      ,/* 業務部門 */
apfb019       varchar2(10)      ,/* 責任中心 */
apfb020       varchar2(10)      ,/* 產品類別 */
apfb021       varchar2(10)      ,/* 預算項目 */
apfb022       varchar2(20)      ,/* 專案代號 */
apfb023       varchar2(30)      ,/* WBS編號 */
apfb024       varchar2(20)      ,/* 第二參考單號 */
apfb025       number(10,0)      ,/* 第二參考單號項次 */
apfb028       varchar2(1)      ,/* 產生方式 */
apfb029       varchar2(20)      ,/* 付款申請單號 */
apfb030       number(10,0)      ,/* 付款申請單項次 */
apfb031       date      ,/* 應付款日 */
apfb032       date      ,/* 付款(票)到期日 */
apfb033       varchar2(20)      ,/* 扣帳核銷者 */
apfb034       date      ,/* 扣帳核銷日期 */
apfb035       varchar2(10)      ,/* 區域 */
apfb036       varchar2(10)      ,/* 客戶分類 */
apfb037       varchar2(10)      ,/* 預算編號 */
apfb038       varchar2(10)      ,/* 交易對象 */
apfb039       varchar2(10)      ,/* 帳款類別 */
apfb040       varchar2(10)      ,/* 稅別 */
apfb041       varchar2(10)      ,/* 付款條件 */
apfb100       varchar2(10)      ,/* 幣別 */
apfb101       number(20,10)      ,/* 匯率 */
apfb109       number(20,6)      ,/* 原幣沖帳金額 */
apfb119       number(20,6)      ,/* 本幣沖帳金額 */
apfb120       varchar2(10)      ,/* 本位幣二幣別 */
apfb121       number(20,10)      ,/* 本位幣二匯率 */
apfb129       number(20,6)      ,/* 本位幣二沖帳金額 */
apfb130       varchar2(10)      ,/* 本位幣三幣別 */
apfb131       number(20,10)      ,/* 本位幣三匯率 */
apfb139       number(20,6)      ,/* 本位幣三沖帳金額 */
apfb104       number(20,6)      ,/* 原幣應稅折抵稅額 */
apfb114       number(20,6)      ,/* 本幣應稅折抵稅額 */
apfb124       number(20,6)      ,/* 本位幣二應稅折抵稅額 */
apfb134       number(20,6)      ,/* 本位幣三應稅折抵稅額 */
apfbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apfbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apfbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apfbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apfbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apfbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apfbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apfbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apfbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apfbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apfbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apfbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apfbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apfbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apfbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apfbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apfbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apfbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apfbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apfbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apfbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apfbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apfbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apfbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apfbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apfbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apfbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apfbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apfbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apfbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apfb_t add constraint apfb_pk primary key (apfbent,apfbdocno,apfbseq) enable validate;

create  index apfb_01 on apfb_t (apfb001,apfb003,apfb004,apfb005);
create  index apfb_02 on apfb_t (apfb002,apfb006,apfb031,apfb032);
create  index apfb_03 on apfb_t (apfb015,apfb016);
create  index apfb_04 on apfb_t (apfb024,apfb025);
create  index apfb_05 on apfb_t (apfb003,apfb004,apfb034);
create unique index apfb_pk on apfb_t (apfbent,apfbdocno,apfbseq);

grant select on apfb_t to tiptop;
grant update on apfb_t to tiptop;
grant delete on apfb_t to tiptop;
grant insert on apfb_t to tiptop;

exit;
