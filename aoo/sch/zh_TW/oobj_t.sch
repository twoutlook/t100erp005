/* 
================================================================================
檔案代號:oobj_t
檔案名稱:單據別庫存標籤From限定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oobj_t
(
oobjent       number(5)      ,/* 企業編號 */
oobj001       varchar2(5)      ,/* 參照表號 */
oobj002       varchar2(5)      ,/* 單據別 */
oobj003       varchar2(10)      ,/* 庫存標籤編號 */
oobjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oobjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oobjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oobjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oobjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oobjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oobjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oobjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oobjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oobjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oobjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oobjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oobjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oobjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oobjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oobjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oobjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oobjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oobjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oobjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oobjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oobjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oobjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oobjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oobjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oobjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oobjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oobjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oobjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oobjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oobj_t add constraint oobj_pk primary key (oobjent,oobj001,oobj002,oobj003) enable validate;

create unique index oobj_pk on oobj_t (oobjent,oobj001,oobj002,oobj003);

grant select on oobj_t to tiptop;
grant update on oobj_t to tiptop;
grant delete on oobj_t to tiptop;
grant insert on oobj_t to tiptop;

exit;
