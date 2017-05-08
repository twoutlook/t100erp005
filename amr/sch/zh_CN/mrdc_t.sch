/* 
================================================================================
檔案代號:mrdc_t
檔案名稱:資源領用單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mrdc_t
(
mrdcent       number(5)      ,/* 企業編號 */
mrdcsite       varchar2(10)      ,/* 營運據點 */
mrdcdocno       varchar2(20)      ,/* 資源領用單號 */
mrdcdocdt       date      ,/* 領用日期 */
mrdc001       varchar2(10)      ,/* 領用目的 */
mrdc002       varchar2(80)      ,/* 領用說明 */
mrdc003       varchar2(20)      ,/* 領用人員 */
mrdc004       varchar2(10)      ,/* 領用部門 */
mrdc005       varchar2(10)      ,/* 使用對象類型 */
mrdc006       varchar2(10)      ,/* 使用對象 */
mrdc007       varchar2(80)      ,/* 聯絡人 */
mrdc008       varchar2(255)      ,/* 備註 */
mrdcownid       varchar2(20)      ,/* 資料所有者 */
mrdcowndp       varchar2(10)      ,/* 資料所屬部門 */
mrdccrtid       varchar2(20)      ,/* 資料建立者 */
mrdccrtdp       varchar2(10)      ,/* 資料建立部門 */
mrdccrtdt       timestamp(0)      ,/* 資料創建日 */
mrdcmodid       varchar2(20)      ,/* 資料修改者 */
mrdcmoddt       timestamp(0)      ,/* 最近修改日 */
mrdccnfid       varchar2(20)      ,/* 資料確認者 */
mrdccnfdt       timestamp(0)      ,/* 資料確認日 */
mrdcstus       varchar2(10)      ,/* 狀態碼 */
mrdcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrdcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrdcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrdcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrdcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrdcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrdcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrdcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrdcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrdcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrdcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrdcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrdcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrdcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrdcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrdcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrdcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrdcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrdcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrdcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrdcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrdcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrdcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrdcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrdcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrdcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrdcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrdcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrdcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrdcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrdc_t add constraint mrdc_pk primary key (mrdcent,mrdcdocno) enable validate;

create unique index mrdc_pk on mrdc_t (mrdcent,mrdcdocno);

grant select on mrdc_t to tiptop;
grant update on mrdc_t to tiptop;
grant delete on mrdc_t to tiptop;
grant insert on mrdc_t to tiptop;

exit;
