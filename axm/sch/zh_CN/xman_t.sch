/* 
================================================================================
檔案代號:xman_t
檔案名稱:產品客戶包裝方式檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xman_t
(
xmanent       number(5)      ,/* 企業編號 */
xmansite       varchar2(10)      ,/* 營運據點 */
xman001       varchar2(40)      ,/* 料件編號 */
xman002       varchar2(10)      ,/* 產品分類 */
xman003       varchar2(10)      ,/* 客戶編號 */
xman004       varchar2(10)      ,/* 聯絡地址 */
xman005       varchar2(10)      ,/* 包裝方式 */
xmanownid       varchar2(20)      ,/* 資料所有者 */
xmanowndp       varchar2(10)      ,/* 資料所屬部門 */
xmancrtid       varchar2(20)      ,/* 資料建立者 */
xmancrtdp       varchar2(10)      ,/* 資料建立部門 */
xmancrtdt       timestamp(0)      ,/* 資料創建日 */
xmanmodid       varchar2(20)      ,/* 資料修改者 */
xmanmoddt       timestamp(0)      ,/* 最近修改日 */
xmanstus       varchar2(10)      ,/* 狀態碼 */
xmanud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmanud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmanud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmanud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmanud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmanud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmanud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmanud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmanud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmanud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmanud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmanud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmanud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmanud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmanud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmanud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmanud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmanud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmanud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmanud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmanud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmanud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmanud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmanud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmanud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmanud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmanud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmanud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmanud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmanud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xman_t add constraint xman_pk primary key (xmanent,xmansite,xman001,xman002,xman003,xman004) enable validate;

create unique index xman_pk on xman_t (xmanent,xmansite,xman001,xman002,xman003,xman004);

grant select on xman_t to tiptop;
grant update on xman_t to tiptop;
grant delete on xman_t to tiptop;
grant insert on xman_t to tiptop;

exit;
