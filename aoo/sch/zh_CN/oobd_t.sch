/* 
================================================================================
檔案代號:oobd_t
檔案名稱:單據別生命週期限定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oobd_t
(
oobdent       number(5)      ,/* 企業編號 */
oobd001       varchar2(5)      ,/* 參照表號 */
oobd002       varchar2(5)      ,/* 單據別 */
oobd003       varchar2(10)      ,/* 生命週期類型 */
oobd004       varchar2(10)      ,/* 生命週期編號 */
oobdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oobdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oobdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oobdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oobdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oobdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oobdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oobdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oobdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oobdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oobdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oobdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oobdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oobdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oobdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oobdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oobdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oobdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oobdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oobdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oobdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oobdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oobdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oobdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oobdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oobdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oobdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oobdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oobdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oobdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oobd_t add constraint oobd_pk primary key (oobdent,oobd001,oobd002,oobd003,oobd004) enable validate;

create unique index oobd_pk on oobd_t (oobdent,oobd001,oobd002,oobd003,oobd004);

grant select on oobd_t to tiptop;
grant update on oobd_t to tiptop;
grant delete on oobd_t to tiptop;
grant insert on oobd_t to tiptop;

exit;
