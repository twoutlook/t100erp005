/* 
================================================================================
檔案代號:dbdc_t
檔案名稱:客戶商品庫存統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table dbdc_t
(
dbdcent       number(5)      ,/* 企業編號 */
dbdcsite       varchar2(10)      ,/* 營運據點 */
dbdc000       varchar2(10)      ,/* 庫存類別 */
dbdc001       varchar2(10)      ,/* 客戶編號 */
dbdc002       varchar2(10)      ,/* 收貨客戶編號 */
dbdc003       varchar2(40)      ,/* 商品編號 */
dbdc004       varchar2(256)      ,/* 產品特徵 */
dbdc005       varchar2(10)      ,/* 庫存單位 */
dbdc006       varchar2(30)      ,/* 批號 */
dbdc007       number(20,6)      ,/* 庫存數量 */
dbdc008       date      ,/* 有效日期 */
dbdcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbdcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbdcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbdcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbdcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbdcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbdcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbdcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbdcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbdcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbdcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbdcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbdcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbdcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbdcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbdcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbdcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbdcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbdcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbdcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbdcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbdcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbdcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbdcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbdcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbdcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbdcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbdcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbdcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbdcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbdc_t add constraint dbdc_pk primary key (dbdcent,dbdcsite,dbdc000,dbdc001,dbdc002,dbdc003,dbdc004,dbdc005,dbdc006) enable validate;

create unique index dbdc_pk on dbdc_t (dbdcent,dbdcsite,dbdc000,dbdc001,dbdc002,dbdc003,dbdc004,dbdc005,dbdc006);

grant select on dbdc_t to tiptop;
grant update on dbdc_t to tiptop;
grant delete on dbdc_t to tiptop;
grant insert on dbdc_t to tiptop;

exit;
