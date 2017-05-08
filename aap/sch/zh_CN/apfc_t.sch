/* 
================================================================================
檔案代號:apfc_t
檔案名稱:集團費用分攤來源明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apfc_t
(
apfcent       number(5)      ,/* 企業代碼 */
apfcsite       varchar2(10)      ,/* 帳務組織 */
apfccomp       varchar2(10)      ,/* 分攤法人 */
apfclegl       varchar2(10)      ,/* 核算組織 */
apfcld       varchar2(5)      ,/* 帳別 */
apfcdocno       varchar2(20)      ,/* 集團分攤單號 */
apfcseq       number(10,0)      ,/* 項次 */
apfc001       varchar2(10)      ,/* 來源作業 */
apfc002       varchar2(20)      ,/* 沖銷類型 */
apfc003       varchar2(20)      ,/* 來源帳款單單號 */
apfc004       number(10,0)      ,/* 來源帳款單項次 */
apfc005       number(10,0)      ,/* 來源帳款單帳期序 */
apfc006       varchar2(10)      ,/* 來源帳款單性質 */
apfc007       varchar2(10)      ,/* 來源歸屬組織 */
apfc008       varchar2(5)      ,/* 來源帳別 */
apfc009       varchar2(10)      ,/* 來源法人 */
apfc010       number(5,0)      ,/* 沖銷加減項 */
apfc011       varchar2(20)      ,/* 第二參考單號 */
apfc012       number(10,0)      ,/* 第二參考單號項次 */
apfc013       varchar2(10)      ,/* 交易對象 */
apfc014       varchar2(24)      ,/* 來源沖銷科目 */
apfc015       varchar2(20)      ,/* 業務人員 */
apfc016       varchar2(10)      ,/* 業務部門 */
apfc017       varchar2(10)      ,/* 責任中心 */
apfc018       varchar2(10)      ,/* 產品類別 */
apfc019       varchar2(10)      ,/* 預算項目 */
apfc020       varchar2(20)      ,/* 專案代號 */
apfc021       varchar2(30)      ,/* WBS編號 */
apfc022       varchar2(1)      ,/* 產生方式 */
apfc023       varchar2(20)      ,/* 傳票號碼 */
apfc024       number(10,0)      ,/* 傳票項次 */
apfc025       date      ,/* 應付款日 */
apfc026       date      ,/* 付款(票)到期日 */
apfc027       varchar2(10)      ,/* 區域 */
apfc028       varchar2(10)      ,/* 客戶分類 */
apfc029       varchar2(10)      ,/* 預算編號 */
apfc100       varchar2(10)      ,/* 幣別 */
apfc101       number(20,10)      ,/* 匯率 */
apfc109       number(20,6)      ,/* 原幣沖帳金額 */
apfc119       number(20,6)      ,/* 本幣沖帳金額 */
apfc120       varchar2(10)      ,/* 本位幣二幣別 */
apfc121       number(20,10)      ,/* 本位幣二匯率 */
apfc129       number(20,6)      ,/* 本位幣二沖帳金額 */
apfc130       varchar2(10)      ,/* 本位幣二幣別 */
apfc131       number(20,10)      ,/* 本位幣三匯率 */
apfc139       number(20,6)      ,/* 本位幣三沖帳金額 */
apfcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apfcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apfcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apfcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apfcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apfcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apfcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apfcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apfcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apfcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apfcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apfcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apfcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apfcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apfcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apfcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apfcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apfcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apfcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apfcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apfcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apfcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apfcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apfcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apfcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apfcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apfcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apfcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apfcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apfcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apfc_t add constraint apfc_pk primary key (apfcent,apfcld,apfcdocno,apfcseq) enable validate;

create  index apfc_01 on apfc_t (apfc003,apfc004,apfc005,apfc006,apfc007,apfc008,apfc009);
create  index apfc_02 on apfc_t (apfc023,apfc024);
create unique index apfc_pk on apfc_t (apfcent,apfcld,apfcdocno,apfcseq);

grant select on apfc_t to tiptop;
grant update on apfc_t to tiptop;
grant delete on apfc_t to tiptop;
grant insert on apfc_t to tiptop;

exit;
