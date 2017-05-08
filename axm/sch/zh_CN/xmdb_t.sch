/* 
================================================================================
檔案代號:xmdb_t
檔案名稱:訂單多帳期預收款檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmdb_t
(
xmdbent       number(5)      ,/* 企業編號 */
xmdbsite       varchar2(10)      ,/* 營運據點 */
xmdbdocno       varchar2(20)      ,/* 訂單單號 */
xmdb001       number(5,0)      ,/* 期別 */
xmdb002       varchar2(10)      ,/* 收款條件 */
xmdb003       date      ,/* 預計應收款日 */
xmdb004       date      ,/* 預計票據到期日 */
xmdb005       number(20,6)      ,/* 未稅金額 */
xmdb006       number(20,6)      ,/* 含稅金額 */
xmdb007       varchar2(20)      ,/* 應收帳款單號 */
xmdb008       number(20,6)      ,/* 主帳套立帳未稅金額 */
xmdb009       number(20,6)      ,/* 主帳套立帳含稅金額 */
xmdb010       number(20,6)      ,/* 帳套二立帳未稅金額 */
xmdb011       number(20,6)      ,/* 帳套二立帳含稅金額 */
xmdb014       number(20,6)      ,/* 帳套三立帳未稅金額 */
xmdb015       number(20,6)      ,/* 帳套三立帳含稅金額 */
xmdb016       varchar2(10)      ,/* 帳款類型 */
xmdb017       varchar2(10)      ,/* 帳款影響出貨模式 */
xmdb200       number(20,6)      ,/* 本幣含稅總金額 */
xmdbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmdbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmdbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmdbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmdbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmdbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmdbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmdbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmdbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmdbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmdbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmdbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmdbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmdbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmdbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmdbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmdbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmdbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmdbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmdbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmdbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmdbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmdbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmdbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmdbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmdbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmdbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmdbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmdbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmdbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmdb_t add constraint xmdb_pk primary key (xmdbent,xmdbdocno,xmdb001) enable validate;

create unique index xmdb_pk on xmdb_t (xmdbent,xmdbdocno,xmdb001);

grant select on xmdb_t to tiptop;
grant update on xmdb_t to tiptop;
grant delete on xmdb_t to tiptop;
grant insert on xmdb_t to tiptop;

exit;
