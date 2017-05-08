/* 
================================================================================
檔案代號:ecbi_t
檔案名稱:料件製程附件檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table ecbi_t
(
ecbient       number(5)      ,/* 企業編號 */
ecbisite       varchar2(10)      ,/* 營運據點 */
ecbi001       varchar2(40)      ,/* 製程料號 */
ecbi002       varchar2(10)      ,/* 製程編號 */
ecbi003       number(5,0)      ,/* 附件編號 */
ecbi004       blob      ,/* 附件 */
ecbi005       varchar2(255)      ,/* 附件檔名 */
ecbi006       varchar2(10)      ,/* 附件副檔名 */
ecbiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ecbiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ecbiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ecbiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ecbiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ecbiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ecbiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ecbiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ecbiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ecbiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ecbiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ecbiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ecbiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ecbiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ecbiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ecbiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ecbiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ecbiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ecbiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ecbiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ecbiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ecbiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ecbiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ecbiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ecbiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ecbiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ecbiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ecbiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ecbiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ecbiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ecbi_t add constraint ecbi_pk primary key (ecbient,ecbisite,ecbi001,ecbi002,ecbi003) enable validate;

create unique index ecbi_pk on ecbi_t (ecbient,ecbisite,ecbi001,ecbi002,ecbi003);

grant select on ecbi_t to tiptop;
grant update on ecbi_t to tiptop;
grant delete on ecbi_t to tiptop;
grant insert on ecbi_t to tiptop;

exit;
