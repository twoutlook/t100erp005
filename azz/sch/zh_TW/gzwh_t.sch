/* 
================================================================================
檔案代號:gzwh_t
檔案名稱:服務人員負責模組
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzwh_t
(
gzwhent       number(5)      ,/* 企業代碼 */
gzwh001       varchar2(10)      ,/* 營運據點 */
gzwh002       varchar2(20)      ,/* 服務人員 */
gzwh003       varchar2(4)      ,/* 服務模組 */
gzwhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzwhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzwhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzwhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzwhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzwhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzwhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzwhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzwhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzwhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzwhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzwhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzwhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzwhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzwhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzwhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzwhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzwhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzwhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzwhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzwhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzwhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzwhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzwhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzwhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzwhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzwhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzwhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzwhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzwhud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gzwh004       varchar2(1)      /* 主要處理人員 */
);
alter table gzwh_t add constraint gzwh_pk primary key (gzwhent,gzwh001,gzwh002,gzwh003) enable validate;

create unique index gzwh_pk on gzwh_t (gzwhent,gzwh001,gzwh002,gzwh003);

grant select on gzwh_t to tiptop;
grant update on gzwh_t to tiptop;
grant delete on gzwh_t to tiptop;
grant insert on gzwh_t to tiptop;

exit;
