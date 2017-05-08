/* 
================================================================================
檔案代號:pjbe_t
檔案名稱:專案WBS人力預算檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjbe_t
(
pjbeent       number(5)      ,/* 企業編號 */
pjbe001       varchar2(20)      ,/* 專案編號 */
pjbe002       varchar2(30)      ,/* 本階WBS */
pjbe003       varchar2(10)      ,/* 專案角色 */
pjbe004       number(15,3)      ,/* 時數 */
pjbe005       number(15,3)      ,/* 天數 */
pjbe006       number(20,6)      ,/* 職能成本單價(時) */
pjbe007       number(20,6)      ,/* 職能成本單價(天) */
pjbe008       number(20,6)      ,/* 職能成本金額 */
pjbe009       varchar2(255)      ,/* 備註 */
pjbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjbeud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjbe010       varchar2(10)      ,/* 稅別 */
pjbe011       number(5,2)      ,/* 稅率 */
pjbe012       number(20,6)      ,/* 原幣含稅金額 */
pjbe013       number(20,6)      ,/* 本幣未稅金額 */
pjbe014       number(20,6)      /* 本幣含稅金額 */
);
alter table pjbe_t add constraint pjbe_pk primary key (pjbeent,pjbe001,pjbe002,pjbe003) enable validate;

create unique index pjbe_pk on pjbe_t (pjbeent,pjbe001,pjbe002,pjbe003);

grant select on pjbe_t to tiptop;
grant update on pjbe_t to tiptop;
grant delete on pjbe_t to tiptop;
grant insert on pjbe_t to tiptop;

exit;
