/* 
================================================================================
檔案代號:oofh_t
檔案名稱:自動編碼可選項檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oofh_t
(
oofhent       number(5)      ,/* 企業編號 */
oofh001       varchar2(10)      ,/* 編碼分類 */
oofh002       varchar2(10)      ,/* 節點編號 */
oofh003       varchar2(10)      ,/* 選項值 */
oofhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oofhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oofhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oofhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oofhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oofhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oofhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oofhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oofhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oofhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oofhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oofhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oofhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oofhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oofhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oofhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oofhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oofhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oofhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oofhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oofhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oofhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oofhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oofhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oofhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oofhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oofhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oofhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oofhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oofhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oofh_t add constraint oofh_pk primary key (oofhent,oofh001,oofh002,oofh003) enable validate;

create unique index oofh_pk on oofh_t (oofhent,oofh001,oofh002,oofh003);

grant select on oofh_t to tiptop;
grant update on oofh_t to tiptop;
grant delete on oofh_t to tiptop;
grant insert on oofh_t to tiptop;

exit;
