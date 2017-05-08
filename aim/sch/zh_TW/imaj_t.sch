/* 
================================================================================
檔案代號:imaj_t
檔案名稱:料件成份與物質檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imaj_t
(
imajent       number(5)      ,/* 企業編號 */
imaj001       varchar2(40)      ,/* 料件編號 */
imaj002       varchar2(10)      ,/* 類型 */
imaj003       varchar2(10)      ,/* 成份/物質 */
imaj004       number(20,6)      ,/* 含量 */
imaj005       varchar2(10)      ,/* 單位 */
imaj006       varchar2(10)      ,/* 管制類型 */
imajud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imajud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imajud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imajud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imajud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imajud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imajud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imajud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imajud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imajud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imajud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imajud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imajud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imajud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imajud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imajud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imajud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imajud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imajud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imajud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imajud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imajud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imajud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imajud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imajud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imajud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imajud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imajud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imajud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imajud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imaj_t add constraint imaj_pk primary key (imajent,imaj001,imaj002,imaj003) enable validate;

create unique index imaj_pk on imaj_t (imajent,imaj001,imaj002,imaj003);

grant select on imaj_t to tiptop;
grant update on imaj_t to tiptop;
grant delete on imaj_t to tiptop;
grant insert on imaj_t to tiptop;

exit;
