/* 
================================================================================
檔案代號:sfdb_t
檔案名稱:發退料套數檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfdb_t
(
sfdbent       number(5)      ,/* 企業編號 */
sfdbsite       varchar2(10)      ,/* 營運據點 */
sfdbdocno       varchar2(20)      ,/* 發退料單號 */
sfdb001       varchar2(20)      ,/* 工單單號 */
sfdb002       number(10,0)      ,/* Run Card */
sfdb003       varchar2(10)      ,/* 部位 */
sfdb004       varchar2(10)      ,/* 作業 */
sfdb005       varchar2(10)      ,/* 作業序 */
sfdb006       number(20,6)      ,/* 預計套數 */
sfdb007       number(20,6)      ,/* 實際套數 */
sfdb008       number(5,0)      ,/* 正負 */
sfdbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfdbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfdbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfdbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfdbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfdbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfdbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfdbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfdbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfdbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfdbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfdbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfdbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfdbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfdbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfdbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfdbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfdbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfdbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfdbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfdbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfdbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfdbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfdbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfdbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfdbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfdbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfdbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfdbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfdbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfdb_t add constraint sfdb_pk primary key (sfdbent,sfdbdocno,sfdb001,sfdb002,sfdb003,sfdb004,sfdb005) enable validate;

create unique index sfdb_pk on sfdb_t (sfdbent,sfdbdocno,sfdb001,sfdb002,sfdb003,sfdb004,sfdb005);

grant select on sfdb_t to tiptop;
grant update on sfdb_t to tiptop;
grant delete on sfdb_t to tiptop;
grant insert on sfdb_t to tiptop;

exit;
