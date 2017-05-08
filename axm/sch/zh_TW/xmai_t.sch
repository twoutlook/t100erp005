/* 
================================================================================
檔案代號:xmai_t
檔案名稱:銷售取價方式單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xmai_t
(
xmaient       number(5)      ,/* 企業編號 */
xmai001       varchar2(10)      ,/* 取價方式編號 */
xmai002       number(5,0)      ,/* 取價順序 */
xmai003       varchar2(10)      ,/* 取價來源 */
xmai004       number(5,0)      ,/* 計算月數 */
xmai005       varchar2(20)      ,/* 彈性價格對應作業 */
xmaiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmaiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmaiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmaiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmaiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmaiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmaiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmaiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmaiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmaiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmaiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmaiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmaiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmaiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmaiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmaiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmaiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmaiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmaiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmaiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmaiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmaiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmaiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmaiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmaiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmaiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmaiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmaiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmaiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmaiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmai_t add constraint xmai_pk primary key (xmaient,xmai001,xmai002) enable validate;

create unique index xmai_pk on xmai_t (xmaient,xmai001,xmai002);

grant select on xmai_t to tiptop;
grant update on xmai_t to tiptop;
grant delete on xmai_t to tiptop;
grant insert on xmai_t to tiptop;

exit;
