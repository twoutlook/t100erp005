/* 
================================================================================
檔案代號:bmeb_t
檔案名稱:替代料限定客戶檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmeb_t
(
bmebent       number(5)      ,/* 企業編號 */
bmebsite       varchar2(10)      ,/* 營運據點 */
bmeb001       varchar2(40)      ,/* 主件料號 */
bmeb002       varchar2(30)      ,/* 特性 */
bmeb003       varchar2(40)      ,/* 元件料號 */
bmeb004       varchar2(10)      ,/* 部位 */
bmeb005       varchar2(10)      ,/* 作業 */
bmeb006       varchar2(10)      ,/* 製程式 */
bmeb007       varchar2(10)      ,/* 取代/替代 */
bmeb008       varchar2(40)      ,/* 取替代料件編號 */
bmeb009       varchar2(10)      ,/* 客戶編碼 */
bmeb010       varchar2(256)      ,/* 產品特徵 */
bmebud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmebud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmebud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmebud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmebud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmebud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmebud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmebud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmebud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmebud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmebud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmebud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmebud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmebud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmebud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmebud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmebud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmebud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmebud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmebud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmebud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmebud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmebud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmebud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmebud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmebud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmebud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmebud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmebud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmebud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmeb_t add constraint bmeb_pk primary key (bmebent,bmebsite,bmeb001,bmeb002,bmeb003,bmeb004,bmeb005,bmeb006,bmeb007,bmeb008,bmeb009,bmeb010) enable validate;

create  index bmeb_01 on bmeb_t (bmebent,bmebsite,bmeb001,bmeb002,bmeb003,bmeb004,bmeb005,bmeb006,bmeb007,bmeb008,bmeb009);
create unique index bmeb_pk on bmeb_t (bmebent,bmebsite,bmeb001,bmeb002,bmeb003,bmeb004,bmeb005,bmeb006,bmeb007,bmeb008,bmeb009,bmeb010);

grant select on bmeb_t to tiptop;
grant update on bmeb_t to tiptop;
grant delete on bmeb_t to tiptop;
grant insert on bmeb_t to tiptop;

exit;
