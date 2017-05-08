/* 
================================================================================
檔案代號:ecbh_t
檔案名稱:料件製程資源項目檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table ecbh_t
(
ecbhent       number(5)      ,/* 企業編號 */
ecbhsite       varchar2(10)      ,/* 營運據點 */
ecbh001       varchar2(40)      ,/* 製程料號 */
ecbh002       varchar2(10)      ,/* 製程編號 */
ecbh003       number(10,0)      ,/* 項次 */
ecbh004       varchar2(20)      ,/* 資源編號 */
ecbh005       varchar2(20)      ,/* 工具編號 */
ecbh006       number(15,3)      ,/* 固定機時 */
ecbh007       number(15,3)      ,/* 標準機時 */
ecbhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ecbhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ecbhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ecbhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ecbhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ecbhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ecbhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ecbhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ecbhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ecbhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ecbhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ecbhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ecbhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ecbhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ecbhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ecbhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ecbhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ecbhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ecbhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ecbhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ecbhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ecbhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ecbhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ecbhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ecbhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ecbhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ecbhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ecbhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ecbhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ecbhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ecbh_t add constraint ecbh_pk primary key (ecbhent,ecbhsite,ecbh001,ecbh002,ecbh003,ecbh004,ecbh005) enable validate;

create unique index ecbh_pk on ecbh_t (ecbhent,ecbhsite,ecbh001,ecbh002,ecbh003,ecbh004,ecbh005);

grant select on ecbh_t to tiptop;
grant update on ecbh_t to tiptop;
grant delete on ecbh_t to tiptop;
grant insert on ecbh_t to tiptop;

exit;
