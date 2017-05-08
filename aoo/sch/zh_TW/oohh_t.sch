/* 
================================================================================
檔案代號:oohh_t
檔案名稱:控制組產品分類檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oohh_t
(
oohhent       number(5)      ,/* 企業編號 */
oohh001       varchar2(10)      ,/* 控制組編號 */
oohh002       varchar2(10)      ,/* 產品分類 */
oohh003       date      ,/* 生效日期 */
oohh004       date      ,/* 失效日期 */
oohhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oohhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oohhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oohhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oohhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oohhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oohhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oohhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oohhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oohhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oohhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oohhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oohhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oohhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oohhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oohhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oohhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oohhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oohhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oohhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oohhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oohhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oohhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oohhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oohhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oohhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oohhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oohhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oohhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oohhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oohh_t add constraint oohh_pk primary key (oohhent,oohh001,oohh002) enable validate;

create  index oohh_01 on oohh_t (oohh003);
create  index oohh_02 on oohh_t (oohh004);
create unique index oohh_pk on oohh_t (oohhent,oohh001,oohh002);

grant select on oohh_t to tiptop;
grant update on oohh_t to tiptop;
grant delete on oohh_t to tiptop;
grant insert on oohh_t to tiptop;

exit;
