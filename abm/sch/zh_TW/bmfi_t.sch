/* 
================================================================================
檔案代號:bmfi_t
檔案名稱:ECN特徵限定用料單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmfi_t
(
bmfient       number(5)      ,/* 企業編號 */
bmfisite       varchar2(10)      ,/* 營運據點 */
bmfidocno       varchar2(20)      ,/* ECN單號 */
bmfi002       number(10,0)      ,/* ECN項次 */
bmfi003       varchar2(30)      ,/* 限定特徵 */
bmfiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmfiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmfiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmfiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmfiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmfiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmfiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmfiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmfiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmfiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmfiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmfiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmfiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmfiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmfiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmfiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmfiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmfiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmfiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmfiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmfiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmfiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmfiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmfiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmfiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmfiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmfiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmfiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmfiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmfiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmfi_t add constraint bmfi_pk primary key (bmfient,bmfisite,bmfidocno,bmfi002,bmfi003) enable validate;

create unique index bmfi_pk on bmfi_t (bmfient,bmfisite,bmfidocno,bmfi002,bmfi003);

grant select on bmfi_t to tiptop;
grant update on bmfi_t to tiptop;
grant delete on bmfi_t to tiptop;
grant insert on bmfi_t to tiptop;

exit;
