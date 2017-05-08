/* 
================================================================================
檔案代號:apeb_t
檔案名稱:付款申請帳款明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apeb_t
(
apebent       number(5)      ,/* 企業編號 */
apebcomp       varchar2(10)      ,/* 法人 */
apebsite       varchar2(10)      ,/* 資金中心 */
apebld       varchar2(5)      ,/* 帳別 */
apeborga       varchar2(10)      ,/* 帳務歸屬組織 */
apebdocno       varchar2(20)      ,/* 沖銷單單號 */
apebseq       number(10,0)      ,/* 項次 */
apeb001       varchar2(10)      ,/* 來源作業 */
apeb002       varchar2(20)      ,/* 對帳單號 */
apeb003       varchar2(20)      ,/* 沖銷帳款單單號 */
apeb004       number(10,0)      ,/* 沖銷帳款單項次 */
apeb005       number(10,0)      ,/* 沖銷帳款單帳期 */
apeb006       varchar2(10)      ,/* 款別性質 */
apeb007       varchar2(20)      ,/* 發票代碼 */
apeb008       varchar2(20)      ,/* 發票號碼 */
apeb010       varchar2(255)      ,/* 摘要說明 */
apeb013       varchar2(10)      ,/* 帳款對象 */
apeb015       number(5,0)      ,/* 沖銷加減項 */
apeb016       varchar2(24)      ,/* 沖銷科目 */
apeb024       varchar2(20)      ,/* 付款單號 */
apeb025       number(10,0)      ,/* 付款單項次 */
apeb028       varchar2(1)      ,/* 產生方式 */
apeb031       date      ,/* 應付到期日 */
apeb100       varchar2(10)      ,/* 幣別 */
apeb101       number(20,10)      ,/* 匯率 */
apeb109       number(20,6)      ,/* 原幣已沖銷金額 */
apeb119       number(20,6)      ,/* 本幣已沖銷金額 */
apebud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apebud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apebud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apebud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apebud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apebud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apebud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apebud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apebud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apebud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apebud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apebud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apebud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apebud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apebud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apebud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apebud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apebud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apebud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apebud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apebud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apebud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apebud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apebud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apebud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apebud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apebud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apebud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apebud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apebud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
apeb011       date      ,/* 發票日期 */
apeb012       varchar2(10)      ,/* 發票類型 */
apeb108       number(20,6)      ,/* 原幣請款金額 */
apeb118       number(20,6)      /* 本幣請款金額 */
);
alter table apeb_t add constraint apeb_pk primary key (apebent,apebdocno,apebseq) enable validate;

create  index apeb_01 on apeb_t (apeb003,apeb004,apeb005);
create  index apeb_02 on apeb_t (apeb002,apeb006,apeb008,apeb031);
create  index apeb_03 on apeb_t (apeb015,apeb016);
create  index apeb_04 on apeb_t (apeb024,apeb025);
create  index apeb_05 on apeb_t (apeb003,apeb004);
create  index apeb_n06 on apeb_t (apebdocno,apeb003,apeb007,apeb008);
create unique index apeb_pk on apeb_t (apebent,apebdocno,apebseq);

grant select on apeb_t to tiptop;
grant update on apeb_t to tiptop;
grant delete on apeb_t to tiptop;
grant insert on apeb_t to tiptop;

exit;
