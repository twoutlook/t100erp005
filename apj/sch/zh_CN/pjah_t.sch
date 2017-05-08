/* 
================================================================================
檔案代號:pjah_t
檔案名稱:專案報價費用明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjah_t
(
pjahent       number(5)      ,/* 企業編號 */
pjah001       varchar2(20)      ,/* 專案編號 */
pjah002       number(10,0)      ,/* 報價版本 */
pjah003       varchar2(10)      ,/* WBS類型 */
pjah004       varchar2(10)      ,/* 費用類型 */
pjah005       number(20,6)      ,/* 原幣未稅金額 */
pjah006       number(20,6)      ,/* 原幣含稅金額 */
pjah007       varchar2(255)      ,/* 備註 */
pjah008       varchar2(10)      ,/* 稅別 */
pjahud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjahud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjahud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjahud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjahud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjahud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjahud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjahud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjahud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjahud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjahud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjahud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjahud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjahud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjahud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjahud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjahud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjahud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjahud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjahud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjahud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjahud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjahud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjahud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjahud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjahud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjahud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjahud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjahud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjahud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjah009       number(5,2)      /* 稅率 */
);
alter table pjah_t add constraint pjah_pk primary key (pjahent,pjah001,pjah002,pjah003,pjah004) enable validate;

create unique index pjah_pk on pjah_t (pjahent,pjah001,pjah002,pjah003,pjah004);

grant select on pjah_t to tiptop;
grant update on pjah_t to tiptop;
grant delete on pjah_t to tiptop;
grant insert on pjah_t to tiptop;

exit;
