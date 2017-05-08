/* 
================================================================================
檔案代號:xmfc_t
檔案名稱:銷售報價範本料號明細單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmfc_t
(
xmfcent       number(5)      ,/* 企業編號 */
xmfcsite       varchar2(10)      ,/* 營運據點 */
xmfcdocno       varchar2(20)      ,/* 範本料號 */
xmfc001       number(5,0)      ,/* 版次 */
xmfc002       number(10,0)      ,/* 序號 */
xmfc003       number(10,0)      ,/* 項次 */
xmfc004       varchar2(40)      ,/* 料件編號 */
xmfc005       varchar2(256)      ,/* 產品特徵 */
xmfc006       number(20,6)      ,/* 數量 */
xmfc007       varchar2(10)      ,/* 單位 */
xmfc008       varchar2(80)      ,/* 限定字元 */
xmfcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmfcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmfcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmfcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmfcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmfcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmfcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmfcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmfcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmfcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmfcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmfcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmfcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmfcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmfcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmfcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmfcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmfcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmfcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmfcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmfcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmfcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmfcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmfcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmfcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmfcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmfcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmfcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmfcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmfcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmfc_t add constraint xmfc_pk primary key (xmfcent,xmfcdocno,xmfc001,xmfc002,xmfc003) enable validate;

create unique index xmfc_pk on xmfc_t (xmfcent,xmfcdocno,xmfc001,xmfc002,xmfc003);

grant select on xmfc_t to tiptop;
grant update on xmfc_t to tiptop;
grant delete on xmfc_t to tiptop;
grant insert on xmfc_t to tiptop;

exit;
