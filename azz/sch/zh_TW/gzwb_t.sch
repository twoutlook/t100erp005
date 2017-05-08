/* 
================================================================================
檔案代號:gzwb_t
檔案名稱:library參數子檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzwb_t
(
gzwb001       varchar2(20)      ,/* 4gl程式編號 */
gzwb002       varchar2(40)      ,/* 函式編號 */
gzwb003       varchar2(1)      ,/* 客製 */
gzwb004       varchar2(1)      ,/* 內部函式區別碼 */
gzwb005       varchar2(20)      ,/* 版本 */
gzwb006       varchar2(1)      ,/* 傳入或傳出編號 */
gzwb007       number(10,0)      ,/* 序號 */
gzwb008       varchar2(20)      ,/* 參數型態 */
gzwb009       varchar2(80)      ,/* 參數說明 */
gzwb010       varchar2(40)      ,/* 變數名稱 */
gzwbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzwbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzwbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzwbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzwbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzwbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzwbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzwbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzwbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzwbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzwbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzwbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzwbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzwbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzwbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzwbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzwbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzwbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzwbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzwbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzwbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzwbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzwbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzwbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzwbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzwbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzwbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzwbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzwbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzwbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzwb_t add constraint gzwb_pk primary key (gzwb001,gzwb002,gzwb006,gzwb007) enable validate;

create unique index gzwb_pk on gzwb_t (gzwb001,gzwb002,gzwb006,gzwb007);

grant select on gzwb_t to tiptop;
grant update on gzwb_t to tiptop;
grant delete on gzwb_t to tiptop;
grant insert on gzwb_t to tiptop;

exit;
