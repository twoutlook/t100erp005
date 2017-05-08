/* 
================================================================================
檔案代號:pmbf_t
檔案名稱:交易對象准入-往來銀行檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmbf_t
(
pmbfent       number(5)      ,/* 企業編號 */
pmbfdocno       varchar2(20)      ,/* 申請單號 */
pmbf001       varchar2(10)      ,/* 交易對象編號 */
pmbf002       varchar2(15)      ,/* 銀行編號 */
pmbf003       varchar2(30)      ,/* 銀行帳戶 */
pmbf004       varchar2(255)      ,/* 帳戶名稱 */
pmbf005       varchar2(15)      ,/* SWIFT CODE */
pmbf006       varchar2(255)      ,/* 備註 */
pmbf007       varchar2(40)      ,/* IBAN CODE */
pmbf008       varchar2(1)      ,/* 主要收款帳戶 */
pmbf009       varchar2(1)      ,/* 主要付款帳戶 */
pmbfstus       varchar2(10)      ,/* 狀態碼 */
pmbfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmbfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmbfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmbfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmbfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmbfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmbfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmbfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmbfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmbfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmbfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmbfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmbfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmbfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmbfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmbfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmbfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmbfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmbfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmbfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmbfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmbfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmbfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmbfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmbfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmbfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmbfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmbfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmbfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmbfud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmbf010       varchar2(1)      ,/* 對公否 */
pmbf011       varchar2(20)      /* 鋪位編號 */
);
alter table pmbf_t add constraint pmbf_pk primary key (pmbfent,pmbfdocno,pmbf002,pmbf003) enable validate;

create  index pmbf_01 on pmbf_t (pmbf001);
create unique index pmbf_pk on pmbf_t (pmbfent,pmbfdocno,pmbf002,pmbf003);

grant select on pmbf_t to tiptop;
grant update on pmbf_t to tiptop;
grant delete on pmbf_t to tiptop;
grant insert on pmbf_t to tiptop;

exit;
