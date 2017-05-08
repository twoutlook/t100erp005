/* 
================================================================================
檔案代號:dbdb_t
檔案名稱:客戶庫存異動單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table dbdb_t
(
dbdbent       number(5)      ,/* 企業編號 */
dbdbsite       varchar2(10)      ,/* 營運據點 */
dbdbunit       varchar2(10)      ,/* 應用組織 */
dbdbdocno       varchar2(20)      ,/* 單據編號 */
dbdbseq       number(10,0)      ,/* 項次 */
dbdb001       varchar2(10)      ,/* 異動類別 */
dbdb002       varchar2(20)      ,/* 來源單號 */
dbdb003       number(10,0)      ,/* 來源項次 */
dbdb004       varchar2(40)      ,/* 商品條碼 */
dbdb005       varchar2(40)      ,/* 商品編號 */
dbdb006       varchar2(256)      ,/* 產品特徵 */
dbdb007       varchar2(30)      ,/* 批號 */
dbdb008       number(20,6)      ,/* 銷售數量 */
dbdb009       varchar2(10)      ,/* 銷售單位 */
dbdb010       varchar2(10)      ,/* 庫存單位 */
dbdb011       number(20,6)      ,/* 銷售/庫存單位轉換率 */
dbdb012       date      ,/* 有效日期 */
dbdb013       varchar2(80)      ,/* 備註 */
dbdb014       varchar2(10)      ,/* 包裝單位 */
dbdb015       number(20,6)      ,/* 包裝數量 */
dbdbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbdbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbdbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbdbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbdbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbdbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbdbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbdbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbdbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbdbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbdbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbdbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbdbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbdbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbdbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbdbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbdbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbdbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbdbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbdbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbdbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbdbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbdbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbdbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbdbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbdbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbdbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbdbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbdbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbdbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbdb_t add constraint dbdb_pk primary key (dbdbent,dbdbdocno,dbdbseq) enable validate;

create unique index dbdb_pk on dbdb_t (dbdbent,dbdbdocno,dbdbseq);

grant select on dbdb_t to tiptop;
grant update on dbdb_t to tiptop;
grant delete on dbdb_t to tiptop;
grant insert on dbdb_t to tiptop;

exit;
