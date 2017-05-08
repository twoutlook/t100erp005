/* 
================================================================================
檔案代號:prfh_t
檔案名稱:產品價格組明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prfh_t
(
prfhent       number(5)      ,/* 企業編號 */
prfhsite       varchar2(10)      ,/* 營運據點 */
prfh001       varchar2(10)      ,/* 產品價格組 */
prfh002       number(10,0)      ,/* 組別 */
prfh003       varchar2(10)      ,/* 屬性 */
prfh004       varchar2(40)      ,/* 屬性編號 */
prfhstus       varchar2(10)      ,/* 狀態碼 */
prfhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prfhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prfhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prfhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prfhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prfhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prfhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prfhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prfhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prfhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prfhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prfhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prfhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prfhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prfhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prfhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prfhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prfhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prfhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prfhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prfhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prfhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prfhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prfhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prfhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prfhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prfhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prfhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prfhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prfhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prfh_t add constraint prfh_pk primary key (prfhent,prfh001,prfh002,prfh003,prfh004) enable validate;

create unique index prfh_pk on prfh_t (prfhent,prfh001,prfh002,prfh003,prfh004);

grant select on prfh_t to tiptop;
grant update on prfh_t to tiptop;
grant delete on prfh_t to tiptop;
grant insert on prfh_t to tiptop;

exit;
