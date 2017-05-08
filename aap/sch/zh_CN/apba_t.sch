/* 
================================================================================
檔案代號:apba_t
檔案名稱:進項發票明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apba_t
(
apbaent       number(5)      ,/* 企業編號 */
apbadocno       varchar2(20)      ,/* 檔案號碼 */
apbaorga       varchar2(10)      ,/* 帳務歸屬組織 */
apba001       varchar2(2)      ,/* 發票類型 */
apba002       varchar2(20)      ,/* 發票代碼 */
apba003       varchar2(20)      ,/* 發票號碼 */
apbaseq       number(10,0)      ,/* 項次 */
apba004       varchar2(10)      ,/* 來源作業 */
apba005       varchar2(20)      ,/* 業務單號碼 */
apba006       number(10,0)      ,/* 業務單項次 */
apba007       varchar2(40)      ,/* 產品編號 */
apba008       varchar2(255)      ,/* 品名規格 */
apba009       varchar2(10)      ,/* 單位 */
apba010       number(20,6)      ,/* 發票數量 */
apba011       number(20,6)      ,/* 暫估帳款數量 */
apba012       number(5,0)      ,/* 正負值 */
apba013       varchar2(20)      ,/* 參考單號 */
apba014       number(20,6)      ,/* 單價 */
apba015       varchar2(10)      ,/* 稅別 */
apba016       varchar2(20)      ,/* 扣抵發票代碼 */
apba017       varchar2(20)      ,/* 扣抵藍字發票號碼 */
apba100       varchar2(10)      ,/* 交易原幣 */
apba103       number(20,6)      ,/* 原幣未稅金額 */
apba104       number(20,6)      ,/* 原幣稅額 */
apba105       number(20,6)      ,/* 原幣含稅總額 */
apba111       number(20,10)      ,/* 發票匯率 */
apba113       number(20,6)      ,/* 發票幣未稅金額 */
apba114       number(20,6)      ,/* 發票幣稅額 */
apba115       number(20,6)      ,/* 發票幣含稅總額 */
apbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apbaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
apba018       number(20,6)      /* 本次開票金額 */
);
alter table apba_t add constraint apba_pk primary key (apbaent,apbadocno,apbaseq) enable validate;

create  index apba_01 on apba_t (apbaent,apba004,apba005,apba006);
create  index apba_n2 on apba_t (apbaent,apbaorga,apba016,apba017);
create unique index apba_pk on apba_t (apbaent,apbadocno,apbaseq);

grant select on apba_t to tiptop;
grant update on apba_t to tiptop;
grant delete on apba_t to tiptop;
grant insert on apba_t to tiptop;

exit;
