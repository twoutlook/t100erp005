/* 
================================================================================
檔案代號:pjbi_t
檔案名稱:專案活動進度檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjbi_t
(
pjbient       number(5)      ,/* 企業編號 */
pjbi001       varchar2(20)      ,/* 專案編號 */
pjbi002       varchar2(30)      ,/* 活動編號 */
pjbi003       number(10,0)      ,/* 項次 */
pjbi004       number(15,3)      ,/* 完成天數 */
pjbi005       number(15,3)      ,/* 完成時數 */
pjbi006       number(20,6)      ,/* 完成百分比 */
pjbi007       date      ,/* 進度更新日期 */
pjbi008       varchar2(20)      ,/* 進度更新人員 */
pjbi009       varchar2(4000)      ,/* 備註 */
pjbiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjbiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjbiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjbiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjbiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjbiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjbiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjbiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjbiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjbiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjbiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjbiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjbiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjbiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjbiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjbiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjbiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjbiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjbiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjbiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjbiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjbiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjbiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjbiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjbiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjbiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjbiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjbiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjbiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjbiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pjbi_t add constraint pjbi_pk primary key (pjbient,pjbi001,pjbi002,pjbi003) enable validate;

create unique index pjbi_pk on pjbi_t (pjbient,pjbi001,pjbi002,pjbi003);

grant select on pjbi_t to tiptop;
grant update on pjbi_t to tiptop;
grant delete on pjbi_t to tiptop;
grant insert on pjbi_t to tiptop;

exit;
