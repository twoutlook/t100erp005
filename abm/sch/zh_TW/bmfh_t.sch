/* 
================================================================================
檔案代號:bmfh_t
檔案名稱:ECN插件位置檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmfh_t
(
bmfhent       number(5)      ,/* 企業編號 */
bmfhsite       varchar2(10)      ,/* 營運據點 */
bmfhdocno       varchar2(20)      ,/* ECN單號 */
bmfh002       number(10,0)      ,/* ECN項次 */
bmfh003       number(10,0)      ,/* 項次 */
bmfh004       varchar2(10)      ,/* 插件位置 */
bmfh005       number(20,6)      ,/* 數量 */
bmfhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmfhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmfhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmfhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmfhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmfhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmfhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmfhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmfhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmfhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmfhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmfhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmfhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmfhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmfhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmfhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmfhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmfhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmfhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmfhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmfhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmfhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmfhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmfhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmfhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmfhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmfhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmfhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmfhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmfhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmfh_t add constraint bmfh_pk primary key (bmfhent,bmfhsite,bmfhdocno,bmfh002,bmfh003) enable validate;

create unique index bmfh_pk on bmfh_t (bmfhent,bmfhsite,bmfhdocno,bmfh002,bmfh003);

grant select on bmfh_t to tiptop;
grant update on bmfh_t to tiptop;
grant delete on bmfh_t to tiptop;
grant insert on bmfh_t to tiptop;

exit;
