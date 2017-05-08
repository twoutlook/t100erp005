/* 
================================================================================
檔案代號:rtaw_t
檔案名稱:品類對應最尾階產品品類資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtaw_t
(
rtawent       number(5)      ,/* 企業代碼 */
rtaw001       varchar2(10)      ,/* 品類編號 */
rtaw002       varchar2(10)      ,/* 最尾階產品品類 */
rtawud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtawud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtawud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtawud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtawud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtawud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtawud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtawud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtawud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtawud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtawud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtawud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtawud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtawud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtawud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtawud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtawud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtawud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtawud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtawud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtawud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtawud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtawud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtawud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtawud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtawud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtawud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtawud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtawud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtawud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtaw003       number(5,0)      /* 品類層級 */
);
alter table rtaw_t add constraint rtaw_pk primary key (rtawent,rtaw001,rtaw002) enable validate;

create unique index rtaw_pk on rtaw_t (rtawent,rtaw001,rtaw002);

grant select on rtaw_t to tiptop;
grant update on rtaw_t to tiptop;
grant delete on rtaw_t to tiptop;
grant insert on rtaw_t to tiptop;

exit;
