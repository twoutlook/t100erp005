/* 
================================================================================
檔案代號:apee_t
檔案名稱:付款申請付款明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apee_t
(
apeeent       number(5)      ,/* 企業編號 */
apeecomp       varchar2(10)      ,/* 代付法人 */
apeesite       varchar2(10)      ,/* 資金中心 */
apeeorga       varchar2(10)      ,/* 代付組織 */
apeedocno       varchar2(20)      ,/* 請款單號 */
apeeseq       number(10,0)      ,/* 項次 */
apee001       varchar2(10)      ,/* 來源作業 */
apee002       varchar2(20)      ,/* 沖銷類型 */
apee003       varchar2(20)      ,/* 收支付款單號 */
apee004       number(10,0)      ,/* 收支付款單項次 */
apee005       varchar2(10)      ,/* 內部帳戶 */
apee006       varchar2(20)      ,/* 款別代碼 */
apee008       varchar2(20)      ,/* 銀存帳戶(票據)號碼 */
apee009       varchar2(1)      ,/* 已轉資料(銀存/票據/…) */
apee010       varchar2(255)      ,/* 摘要說明 */
apee011       varchar2(10)      ,/* 銀行存提碼 */
apee012       varchar2(10)      ,/* 現金變動碼 */
apee013       varchar2(10)      ,/* 轉入客商碼 */
apee014       varchar2(20)      ,/* 轉入帳款單編號 */
apee015       number(5,0)      ,/* 沖銷加減項 */
apee016       varchar2(24)      ,/* 沖銷科目 */
apee017       varchar2(20)      ,/* 業務人員 */
apee018       varchar2(10)      ,/* 業務部門 */
apee021       varchar2(10)      ,/* 票據類型 */
apee024       varchar2(20)      ,/* 第二參考單號 */
apee025       number(10,0)      ,/* 第二參考單號項次 */
apee028       varchar2(1)      ,/* 產生方式 */
apee031       date      ,/* 應付款日 */
apee032       date      ,/* 付款(票)到期日 */
apee033       varchar2(20)      ,/* 扣帳核銷者 */
apee034       date      ,/* 扣帳核銷日期 */
apee038       varchar2(10)      ,/* 交易對象 */
apee039       varchar2(15)      ,/* 受款銀行 */
apee040       varchar2(30)      ,/* 受款帳號 */
apee041       varchar2(255)      ,/* 受款人全名 */
apee100       varchar2(10)      ,/* 幣別 */
apee101       number(20,10)      ,/* 匯率 */
apee109       number(20,6)      ,/* 原幣沖帳金額 */
apee119       number(20,6)      ,/* 本幣沖帳金額 */
apeeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apeeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apeeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apeeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apeeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apeeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apeeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apeeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apeeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apeeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apeeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apeeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apeeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apeeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apeeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apeeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apeeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apeeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apeeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apeeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apeeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apeeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apeeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apeeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apeeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apeeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apeeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apeeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apeeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apeeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apee_t add constraint apee_pk primary key (apeeent,apeedocno,apeeseq) enable validate;

create  index apee_01 on apee_t (apee003,apee004);
create  index apee_04 on apee_t (apee024,apee025);
create unique index apee_pk on apee_t (apeeent,apeedocno,apeeseq);

grant select on apee_t to tiptop;
grant update on apee_t to tiptop;
grant delete on apee_t to tiptop;
grant insert on apee_t to tiptop;

exit;
