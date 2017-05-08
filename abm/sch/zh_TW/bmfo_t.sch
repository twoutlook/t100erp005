/* 
================================================================================
檔案代號:bmfo_t
檔案名稱:ECN替代料限定客戶檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmfo_t
(
bmfoent       number(5)      ,/* 企業編號 */
bmfosite       varchar2(10)      ,/* 營運據點 */
bmfodocno       varchar2(20)      ,/* ECN單號 */
bmfo002       number(10,0)      ,/* 項次 */
bmfo003       varchar2(10)      ,/* 客戶編號 */
bmfoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmfoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmfoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmfoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmfoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmfoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmfoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmfoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmfoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmfoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmfoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmfoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmfoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmfoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmfoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmfoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmfoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmfoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmfoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmfoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmfoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmfoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmfoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmfoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmfoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmfoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmfoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmfoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmfoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmfoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmfo_t add constraint bmfo_pk primary key (bmfoent,bmfosite,bmfodocno,bmfo002,bmfo003) enable validate;

create unique index bmfo_pk on bmfo_t (bmfoent,bmfosite,bmfodocno,bmfo002,bmfo003);

grant select on bmfo_t to tiptop;
grant update on bmfo_t to tiptop;
grant delete on bmfo_t to tiptop;
grant insert on bmfo_t to tiptop;

exit;
