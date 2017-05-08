/* 
================================================================================
檔案代號:oobi_t
檔案名稱:單據別單身理由碼限定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oobi_t
(
oobient       number(5)      ,/* 企業編號 */
oobi001       varchar2(5)      ,/* 參照表號 */
oobi002       varchar2(5)      ,/* 單據別 */
oobi003       varchar2(10)      ,/* 單身理由碼 */
oobiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oobiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oobiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oobiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oobiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oobiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oobiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oobiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oobiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oobiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oobiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oobiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oobiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oobiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oobiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oobiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oobiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oobiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oobiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oobiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oobiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oobiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oobiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oobiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oobiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oobiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oobiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oobiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oobiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oobiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oobi_t add constraint oobi_pk primary key (oobient,oobi001,oobi002,oobi003) enable validate;

create unique index oobi_pk on oobi_t (oobient,oobi001,oobi002,oobi003);

grant select on oobi_t to tiptop;
grant update on oobi_t to tiptop;
grant delete on oobi_t to tiptop;
grant insert on oobi_t to tiptop;

exit;
