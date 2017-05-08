/* 
================================================================================
檔案代號:ineb_t
檔案名稱:生效組織資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table ineb_t
(
inebent       number(5)      ,/* 企業編號 */
inebdocno       varchar2(20)      ,/* 盤點計劃 */
ineb001       varchar2(10)      ,/* 生效組織 */
inebstus       varchar2(10)      ,/* 狀態 */
inebud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inebud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inebud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inebud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inebud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inebud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inebud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inebud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inebud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inebud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inebud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inebud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inebud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inebud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inebud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inebud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inebud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inebud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inebud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inebud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inebud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inebud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inebud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inebud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inebud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inebud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inebud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inebud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inebud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inebud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ineb_t add constraint ineb_pk primary key (inebent,inebdocno,ineb001) enable validate;

create unique index ineb_pk on ineb_t (inebent,inebdocno,ineb001);

grant select on ineb_t to tiptop;
grant update on ineb_t to tiptop;
grant delete on ineb_t to tiptop;
grant insert on ineb_t to tiptop;

exit;
