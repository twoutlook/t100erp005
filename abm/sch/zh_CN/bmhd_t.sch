/* 
================================================================================
檔案代號:bmhd_t
檔案名稱:料件承認模板適用範圍檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmhd_t
(
bmhdent       number(5)      ,/* 企業編號 */
bmhd001       varchar2(10)      ,/* 模板代號 */
bmhd003       varchar2(10)      ,/* 產品分類碼 */
bmhdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmhdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmhdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmhdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmhdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmhdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmhdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmhdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmhdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmhdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmhdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmhdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmhdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmhdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmhdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmhdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmhdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmhdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmhdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmhdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmhdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmhdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmhdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmhdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmhdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmhdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmhdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmhdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmhdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmhdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmhd_t add constraint bmhd_pk primary key (bmhdent,bmhd001,bmhd003) enable validate;

create unique index bmhd_pk on bmhd_t (bmhdent,bmhd001,bmhd003);

grant select on bmhd_t to tiptop;
grant update on bmhd_t to tiptop;
grant delete on bmhd_t to tiptop;
grant insert on bmhd_t to tiptop;

exit;
