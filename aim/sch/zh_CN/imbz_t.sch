/* 
================================================================================
檔案代號:imbz_t
檔案名稱:商品准入單流通補貨規格檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imbz_t
(
imbzent       number(5)      ,/* 企業編號 */
imbzdocno       varchar2(20)      ,/* 申請單號 */
imbz001       varchar2(40)      ,/* 商品編號 */
imbz002       varchar2(10)      ,/* 補貨規格 */
imbz003       varchar2(40)      ,/* 補貨條碼 */
imbz004       varchar2(10)      ,/* 補貨單位 */
imbz005       number(20,6)      ,/* 件裝數 */
imbzud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imbzud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imbzud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imbzud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imbzud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imbzud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imbzud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imbzud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imbzud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imbzud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imbzud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imbzud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imbzud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imbzud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imbzud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imbzud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imbzud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imbzud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imbzud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imbzud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imbzud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imbzud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imbzud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imbzud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imbzud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imbzud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imbzud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imbzud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imbzud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imbzud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
imbz006       varchar2(80)      /* 補貨規格說明 */
);
alter table imbz_t add constraint imbz_pk primary key (imbzent,imbzdocno,imbz002) enable validate;

create unique index imbz_pk on imbz_t (imbzent,imbzdocno,imbz002);

grant select on imbz_t to tiptop;
grant update on imbz_t to tiptop;
grant delete on imbz_t to tiptop;
grant insert on imbz_t to tiptop;

exit;
