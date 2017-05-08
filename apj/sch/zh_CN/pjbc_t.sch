/* 
================================================================================
檔案代號:pjbc_t
檔案名稱:專案成員檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjbc_t
(
pjbcent       number(5)      ,/* 企業編號 */
pjbc001       varchar2(20)      ,/* 專案編號 */
pjbc002       varchar2(10)      ,/* 專案角色 */
pjbc003       varchar2(20)      ,/* 員工編號 */
pjbc004       date      ,/* 生效日期 */
pjbc005       date      ,/* 失效日期 */
pjbc006       varchar2(255)      ,/* 備註 */
pjbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjbcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pjbc_t add constraint pjbc_pk primary key (pjbcent,pjbc001,pjbc002,pjbc003) enable validate;

create unique index pjbc_pk on pjbc_t (pjbcent,pjbc001,pjbc002,pjbc003);

grant select on pjbc_t to tiptop;
grant update on pjbc_t to tiptop;
grant delete on pjbc_t to tiptop;
grant insert on pjbc_t to tiptop;

exit;
