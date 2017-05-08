/* 
================================================================================
檔案代號:gzyc_t
檔案名稱:職能角色定義運行作業功能明細
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzyc_t
(
gzycent       number(5)      ,/* 企業編號 */
gzyc001       varchar2(10)      ,/* 職能角色編號 */
gzyc002       varchar2(20)      ,/* 作業編號 */
gzyc003       varchar2(80)      ,/* 功能編號 */
gzyc004       varchar2(1)      ,/* 功能授權 */
gzyc005       varchar2(1)      ,/* 資料授權類別 */
gzycud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzycud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzycud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzycud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzycud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzycud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzycud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzycud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzycud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzycud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzycud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzycud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzycud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzycud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzycud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzycud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzycud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzycud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzycud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzycud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzycud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzycud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzycud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzycud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzycud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzycud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzycud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzycud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzycud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzycud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzyc_t add constraint gzyc_pk primary key (gzycent,gzyc001,gzyc002,gzyc003) enable validate;

create unique index gzyc_pk on gzyc_t (gzycent,gzyc001,gzyc002,gzyc003);

grant select on gzyc_t to tiptop;
grant update on gzyc_t to tiptop;
grant delete on gzyc_t to tiptop;
grant insert on gzyc_t to tiptop;

exit;
