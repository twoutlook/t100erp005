/* 
================================================================================
檔案代號:oohd_t
檔案名稱:控制組客戶分類檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oohd_t
(
oohdent       number(5)      ,/* 企業編號 */
oohd001       varchar2(10)      ,/* 控制組編號 */
oohd002       varchar2(10)      ,/* 客戶分類 */
oohd003       date      ,/* 生效日期 */
oohd004       date      ,/* 失效日期 */
oohdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oohdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oohdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oohdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oohdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oohdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oohdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oohdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oohdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oohdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oohdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oohdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oohdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oohdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oohdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oohdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oohdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oohdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oohdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oohdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oohdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oohdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oohdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oohdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oohdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oohdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oohdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oohdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oohdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oohdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oohd_t add constraint oohd_pk primary key (oohdent,oohd001,oohd002) enable validate;

create  index oohd_01 on oohd_t (oohd003);
create  index oohd_02 on oohd_t (oohd004);
create unique index oohd_pk on oohd_t (oohdent,oohd001,oohd002);

grant select on oohd_t to tiptop;
grant update on oohd_t to tiptop;
grant delete on oohd_t to tiptop;
grant insert on oohd_t to tiptop;

exit;
