/* 
================================================================================
檔案代號:bmhb_t
檔案名稱:料件承認模板成份與物質檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmhb_t
(
bmhbent       number(5)      ,/* 企業編號 */
bmhb001       varchar2(10)      ,/* 模板編號 */
bmhb002       varchar2(10)      ,/* 類型 */
bmhb003       varchar2(10)      ,/* 成份/物質 */
bmhb004       number(20,6)      ,/* 含量 */
bmhb005       varchar2(10)      ,/* 單位 */
bmhb006       varchar2(10)      ,/* 管制類型 */
bmhbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmhbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmhbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmhbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmhbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmhbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmhbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmhbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmhbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmhbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmhbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmhbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmhbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmhbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmhbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmhbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmhbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmhbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmhbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmhbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmhbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmhbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmhbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmhbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmhbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmhbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmhbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmhbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmhbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmhbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmhb_t add constraint bmhb_pk primary key (bmhbent,bmhb001,bmhb002,bmhb003) enable validate;

create unique index bmhb_pk on bmhb_t (bmhbent,bmhb001,bmhb002,bmhb003);

grant select on bmhb_t to tiptop;
grant update on bmhb_t to tiptop;
grant delete on bmhb_t to tiptop;
grant insert on bmhb_t to tiptop;

exit;
