/* 
================================================================================
檔案代號:gzcb_t
檔案名稱:系統分類值檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzcb_t
(
gzcb001       number(10,0)      ,/* 系統分類碼 */
gzcb002       varchar2(10)      ,/* 系統分類碼值 */
gzcb003       varchar2(40)      ,/* 系統應用欄位一 */
gzcb004       varchar2(40)      ,/* 系統應用欄位二 */
gzcb005       varchar2(40)      ,/* 系統應用欄位三 */
gzcb006       varchar2(40)      ,/* 系統應用欄位四 */
gzcb007       varchar2(40)      ,/* 系統應用欄位五 */
gzcb008       varchar2(40)      ,/* 系統應用欄位六 */
gzcb009       varchar2(40)      ,/* 系統應用欄位七 */
gzcb010       varchar2(40)      ,/* 系統應用欄位八 */
gzcb011       varchar2(40)      ,/* 系統應用欄位九 */
gzcb012       varchar2(40)      ,/* 選項順序 */
gzcb013       varchar2(1)      ,/* 客製 */
gzcb014       varchar2(500)      ,/* 備註 */
gzcb015       varchar2(10)      ,/* 庫存異動分類 */
gzcbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzcbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzcbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzcbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzcbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzcbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzcbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzcbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzcbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzcbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzcbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzcbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzcbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzcbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzcbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzcbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzcbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzcbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzcbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzcbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzcbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzcbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzcbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzcbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzcbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzcbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzcbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzcbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzcbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzcbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzcb_t add constraint gzcb_pk primary key (gzcb001,gzcb002) enable validate;

create unique index gzcb_pk on gzcb_t (gzcb001,gzcb002);

grant select on gzcb_t to tiptop;
grant update on gzcb_t to tiptop;
grant delete on gzcb_t to tiptop;
grant insert on gzcb_t to tiptop;

exit;
