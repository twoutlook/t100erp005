/* 
================================================================================
檔案代號:rtdt_t
檔案名稱:自有商品引進-門店明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtdt_t
(
rtdtent       number(5)      ,/* 企業編號 */
rtdtdocno       varchar2(20)      ,/* 單據編號 */
rtdt001       varchar2(10)      ,/* 門店編號 */
rtdtud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtdtud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtdtud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtdtud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtdtud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtdtud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtdtud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtdtud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtdtud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtdtud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtdtud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtdtud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtdtud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtdtud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtdtud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtdtud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtdtud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtdtud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtdtud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtdtud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtdtud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtdtud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtdtud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtdtud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtdtud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtdtud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtdtud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtdtud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtdtud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtdtud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtdt_t add constraint rtdt_pk primary key (rtdtent,rtdtdocno,rtdt001) enable validate;

create unique index rtdt_pk on rtdt_t (rtdtent,rtdtdocno,rtdt001);

grant select on rtdt_t to tiptop;
grant update on rtdt_t to tiptop;
grant delete on rtdt_t to tiptop;
grant insert on rtdt_t to tiptop;

exit;
