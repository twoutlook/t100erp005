/* 
================================================================================
檔案代號:gzxh_t
檔案名稱:使用者定義運行作業功能明細
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzxh_t
(
gzxhent       number(5)      ,/* 企業編號 */
gzxh001       varchar2(20)      ,/* 使用者編號 */
gzxh002       varchar2(20)      ,/* 作業編號 */
gzxh003       varchar2(80)      ,/* 功能編號 */
gzxh004       varchar2(1)      ,/* 功能授權 */
gzxh005       varchar2(1)      ,/* 資料授權類別 */
gzxhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzxhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzxhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzxhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzxhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzxhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzxhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzxhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzxhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzxhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzxhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzxhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzxhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzxhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzxhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzxhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzxhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzxhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzxhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzxhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzxhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzxhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzxhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzxhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzxhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzxhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzxhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzxhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzxhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzxhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzxh_t add constraint gzxh_pk primary key (gzxhent,gzxh001,gzxh002,gzxh003) enable validate;

create unique index gzxh_pk on gzxh_t (gzxhent,gzxh001,gzxh002,gzxh003);

grant select on gzxh_t to tiptop;
grant update on gzxh_t to tiptop;
grant delete on gzxh_t to tiptop;
grant insert on gzxh_t to tiptop;

exit;
