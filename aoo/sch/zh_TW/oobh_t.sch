/* 
================================================================================
檔案代號:oobh_t
檔案名稱:單據別產品分類限定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oobh_t
(
oobhent       number(5)      ,/* 企業編號 */
oobh001       varchar2(5)      ,/* 參照表號 */
oobh002       varchar2(5)      ,/* 單據別 */
oobh003       varchar2(10)      ,/* 產品分類 */
oobhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oobhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oobhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oobhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oobhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oobhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oobhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oobhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oobhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oobhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oobhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oobhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oobhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oobhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oobhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oobhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oobhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oobhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oobhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oobhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oobhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oobhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oobhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oobhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oobhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oobhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oobhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oobhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oobhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oobhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oobh_t add constraint oobh_pk primary key (oobhent,oobh001,oobh002,oobh003) enable validate;

create unique index oobh_pk on oobh_t (oobhent,oobh001,oobh002,oobh003);

grant select on oobh_t to tiptop;
grant update on oobh_t to tiptop;
grant delete on oobh_t to tiptop;
grant insert on oobh_t to tiptop;

exit;
