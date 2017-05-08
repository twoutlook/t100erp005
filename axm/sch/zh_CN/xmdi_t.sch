/* 
================================================================================
檔案代號:xmdi_t
檔案名稱:出通單多庫儲批出貨明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmdi_t
(
xmdient       number(5)      ,/* 企業編號 */
xmdisite       varchar2(10)      ,/* 營運據點 */
xmdidocno       varchar2(20)      ,/* 出通單號 */
xmdiseq       number(10,0)      ,/* 項次 */
xmdiseq1       number(10,0)      ,/* 項序 */
xmdi001       varchar2(40)      ,/* 料件編號 */
xmdi002       varchar2(256)      ,/* 產品特徵 */
xmdi003       varchar2(10)      ,/* 作業編號 */
xmdi004       varchar2(10)      ,/* 製程序 */
xmdi005       varchar2(10)      ,/* 限定庫位 */
xmdi006       varchar2(10)      ,/* 限定儲位 */
xmdi007       varchar2(30)      ,/* 限定批號 */
xmdi008       varchar2(10)      ,/* 單位 */
xmdi009       number(20,6)      ,/* 出貨數量 */
xmdi010       varchar2(10)      ,/* 參考單位 */
xmdi011       number(20,6)      ,/* 參考數量 */
xmdi012       number(20,6)      ,/* 已轉出貨量 */
xmdiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmdiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmdiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmdiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmdiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmdiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmdiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmdiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmdiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmdiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmdiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmdiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmdiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmdiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmdiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmdiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmdiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmdiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmdiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmdiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmdiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmdiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmdiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmdiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmdiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmdiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmdiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmdiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmdiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmdiud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmdi013       varchar2(30)      /* 庫存管理特徵 */
);
alter table xmdi_t add constraint xmdi_pk primary key (xmdient,xmdidocno,xmdiseq,xmdiseq1) enable validate;

create unique index xmdi_pk on xmdi_t (xmdient,xmdidocno,xmdiseq,xmdiseq1);

grant select on xmdi_t to tiptop;
grant update on xmdi_t to tiptop;
grant delete on xmdi_t to tiptop;
grant insert on xmdi_t to tiptop;

exit;
