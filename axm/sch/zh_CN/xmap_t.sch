/* 
================================================================================
檔案代號:xmap_t
檔案名稱:嘜頭單身明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmap_t
(
xmapent       number(5)      ,/* 企業編號 */
xmap001       varchar2(10)      ,/* 客戶編號 */
xmap002       varchar2(10)      ,/* 嘜頭編號 */
xmap003       varchar2(10)      ,/* 類別 */
xmap004       number(10,0)      ,/* 行序 */
xmap005       varchar2(10)      ,/* 資料類型 */
xmap006       varchar2(500)      ,/* 資料內容 */
xmapud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmapud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmapud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmapud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmapud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmapud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmapud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmapud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmapud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmapud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmapud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmapud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmapud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmapud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmapud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmapud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmapud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmapud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmapud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmapud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmapud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmapud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmapud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmapud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmapud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmapud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmapud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmapud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmapud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmapud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmap_t add constraint xmap_pk primary key (xmapent,xmap001,xmap002,xmap003,xmap004) enable validate;

create unique index xmap_pk on xmap_t (xmapent,xmap001,xmap002,xmap003,xmap004);

grant select on xmap_t to tiptop;
grant update on xmap_t to tiptop;
grant delete on xmap_t to tiptop;
grant insert on xmap_t to tiptop;

exit;
