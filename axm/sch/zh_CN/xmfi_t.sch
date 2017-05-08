/* 
================================================================================
檔案代號:xmfi_t
檔案名稱:銷售估價費用資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmfi_t
(
xmfient       number(5)      ,/* 企業編號 */
xmfisite       varchar2(10)      ,/* 營運據點 */
xmfidocno       varchar2(20)      ,/* 估價單號 */
xmfiseq       number(10,0)      ,/* 項次 */
xmfi001       varchar2(40)      ,/* 費用料號 */
xmfi002       varchar2(10)      ,/* 幣別 */
xmfi003       number(20,10)      ,/* 匯率 */
xmfi004       number(20,6)      ,/* 預估金額 */
xmfi005       varchar2(10)      ,/* 建議廠商 */
xmfi006       varchar2(255)      ,/* 備註 */
xmfiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmfiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmfiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmfiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmfiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmfiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmfiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmfiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmfiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmfiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmfiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmfiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmfiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmfiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmfiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmfiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmfiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmfiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmfiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmfiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmfiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmfiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmfiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmfiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmfiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmfiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmfiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmfiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmfiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmfiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmfi_t add constraint xmfi_pk primary key (xmfient,xmfidocno,xmfiseq) enable validate;

create unique index xmfi_pk on xmfi_t (xmfient,xmfidocno,xmfiseq);

grant select on xmfi_t to tiptop;
grant update on xmfi_t to tiptop;
grant delete on xmfi_t to tiptop;
grant insert on xmfi_t to tiptop;

exit;
