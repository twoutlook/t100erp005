/* 
================================================================================
檔案代號:prbt_t
檔案名稱:電子秤導出商品資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prbt_t
(
prbtent       number(5)      ,/* 企業代碼 */
prbt001       varchar2(10)      ,/* PLU編號 */
prbt002       varchar2(40)      ,/* 商品條碼 */
prbt003       varchar2(40)      ,/* 商品編號 */
prbt004       varchar2(10)      ,/* 導出人員 */
prbt005       varchar2(1)      ,/* 狀態 */
prbtud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prbtud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prbtud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prbtud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prbtud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prbtud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prbtud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prbtud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prbtud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prbtud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prbtud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prbtud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prbtud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prbtud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prbtud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prbtud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prbtud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prbtud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prbtud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prbtud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prbtud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prbtud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prbtud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prbtud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prbtud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prbtud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prbtud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prbtud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prbtud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prbtud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prbt_t add constraint prbt_pk primary key (prbtent,prbt001,prbt004) enable validate;

create unique index prbt_pk on prbt_t (prbtent,prbt001,prbt004);

grant select on prbt_t to tiptop;
grant update on prbt_t to tiptop;
grant delete on prbt_t to tiptop;
grant insert on prbt_t to tiptop;

exit;
