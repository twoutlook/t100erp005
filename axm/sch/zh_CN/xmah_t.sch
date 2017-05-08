/* 
================================================================================
檔案代號:xmah_t
檔案名稱:銷售取價方式單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xmah_t
(
xmahent       number(5)      ,/* 企業編號 */
xmah001       varchar2(10)      ,/* 取價方式編號 */
xmah002       varchar2(1)      ,/* 未取到價格允許人工輸入 */
xmah003       varchar2(1)      ,/* 價格允許修改 */
xmah004       number(20,6)      ,/* 修改容差率 */
xmah005       varchar2(10)      ,/* 價格超過容差率的處理方式 */
xmah006       varchar2(1)      ,/* 允許單價為0 */
xmah007       varchar2(1)      ,/* 不可低於業務底價 */
xmah008       varchar2(1)      ,/* 不可低於銷售底價 */
xmah009       varchar2(1)      ,/* 不可低於成本價 */
xmahownid       varchar2(20)      ,/* 資料所有者 */
xmahowndp       varchar2(10)      ,/* 資料所屬部門 */
xmahcrtid       varchar2(20)      ,/* 資料建立者 */
xmahcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmahcrtdt       timestamp(0)      ,/* 資料創建日 */
xmahmodid       varchar2(20)      ,/* 資料修改者 */
xmahmoddt       timestamp(0)      ,/* 最近修改日 */
xmahstus       varchar2(10)      ,/* 狀態碼 */
xmahud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmahud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmahud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmahud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmahud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmahud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmahud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmahud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmahud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmahud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmahud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmahud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmahud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmahud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmahud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmahud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmahud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmahud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmahud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmahud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmahud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmahud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmahud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmahud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmahud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmahud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmahud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmahud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmahud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmahud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmah_t add constraint xmah_pk primary key (xmahent,xmah001) enable validate;

create unique index xmah_pk on xmah_t (xmahent,xmah001);

grant select on xmah_t to tiptop;
grant update on xmah_t to tiptop;
grant delete on xmah_t to tiptop;
grant insert on xmah_t to tiptop;

exit;
