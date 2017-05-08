/* 
================================================================================
檔案代號:apfd_t
檔案名稱:集團費用分攤目的明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apfd_t
(
apfdent       number(5)      ,/* 企業別 */
apfdsite       varchar2(10)      ,/* 帳務組織 */
apfdcomp       varchar2(10)      ,/* 法人(集團) */
apfdld       varchar2(5)      ,/* 帳別 */
apfddocno       varchar2(20)      ,/* 攤銷單號 */
apfdseq       number(10,0)      ,/* 攤銷單項次 */
apfdorga       varchar2(10)      ,/* 來源歸屬組織 */
apfd001       varchar2(10)      ,/* 攤銷至目的方式 */
apfd002       varchar2(20)      ,/* 交易單號(入庫單) */
apfd003       number(10,0)      ,/* 交易單項次 */
apfd004       varchar2(40)      ,/* 產品編號 */
apfd005       varchar2(20)      ,/* 目的帳款單號 */
apfd006       number(10,0)      ,/* 目的帳款單項次 */
apfd007       varchar2(24)      ,/* 目的會計科目 */
apfd008       number(20,6)      ,/* 數量 */
apfd009       varchar2(10)      ,/* 分攤金額方式 */
apfd111       number(20,6)      ,/* 本幣分攤前單價 */
apfd113       number(20,6)      ,/* 本幣分攤前金額 */
apfd211       number(20,6)      ,/* 本幣分攤後單價 */
apfd213       number(20,6)      ,/* 本幣分攤後金額 */
apfd123       number(20,6)      ,/* 本位幣二分攤前金額 */
apfd223       number(20,6)      ,/* 本位幣二分攤後金額 */
apfd133       number(20,6)      ,/* 本位幣三分攤前金額 */
apfd233       number(20,6)      ,/* 本位幣三分攤後金額 */
apfdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apfdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apfdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apfdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apfdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apfdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apfdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apfdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apfdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apfdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apfdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apfdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apfdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apfdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apfdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apfdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apfdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apfdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apfdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apfdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apfdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apfdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apfdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apfdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apfdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apfdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apfdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apfdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apfdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apfdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apfd_t add constraint apfd_pk primary key (apfdent,apfddocno,apfdseq) enable validate;

create  index apfd_01 on apfd_t (apfdent,apfdld,apfddocno,apfdseq);
create  index apfd_02 on apfd_t (apfd005,apfd006,apfd007);
create unique index apfd_pk on apfd_t (apfdent,apfddocno,apfdseq);

grant select on apfd_t to tiptop;
grant update on apfd_t to tiptop;
grant delete on apfd_t to tiptop;
grant insert on apfd_t to tiptop;

exit;
