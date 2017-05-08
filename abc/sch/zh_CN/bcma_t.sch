/* 
================================================================================
檔案代號:bcma_t
檔案名稱:料件資料與庫存資訊檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bcma_t
(
bcmaent       number(5)      ,/* 企業編號 */
bcmasite       varchar2(10)      ,/* 營運據點 */
bcma001       varchar2(40)      ,/* 料件編號 */
bcma002       varchar2(255)      ,/* 品名 */
bcma003       varchar2(255)      ,/* 規格 */
bcma004       varchar2(256)      ,/* 產品特徵 */
bcma005       varchar2(10)      ,/* 庫位編號 */
bcma006       varchar2(10)      ,/* 儲位編號 */
bcma007       varchar2(30)      ,/* 批號 */
bcma008       varchar2(30)      ,/* 製造批號 */
bcma009       varchar2(30)      ,/* 製造序號 */
bcma010       varchar2(10)      ,/* 庫存單位 */
bcma011       number(20,6)      ,/* 庫存數量 */
bcma012       varchar2(1)      ,/* 庫存可用否 */
bcma013       timestamp(0)      ,/* 最後異動日期 */
bcmastus       varchar2(10)      ,/* 狀態碼 */
bcmaownid       varchar2(20)      ,/* 資料所有者 */
bcmaowndp       varchar2(10)      ,/* 資料所屬部門 */
bcmacrtid       varchar2(20)      ,/* 資料建立者 */
bcmacrtdp       varchar2(10)      ,/* 資料建立部門 */
bcmacrtdt       timestamp(0)      ,/* 資料創建日 */
bcmamodid       varchar2(20)      ,/* 資料修改者 */
bcmamoddt       timestamp(0)      ,/* 最近修改日 */
bcmacnfid       varchar2(20)      ,/* 資料確認者 */
bcmacnfdt       timestamp(0)      ,/* 資料確認日 */
bcmaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bcmaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bcmaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bcmaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bcmaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bcmaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bcmaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bcmaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bcmaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bcmaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bcmaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bcmaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bcmaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bcmaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bcmaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bcmaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bcmaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bcmaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bcmaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bcmaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bcmaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bcmaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bcmaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bcmaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bcmaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bcmaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bcmaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bcmaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bcmaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bcmaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bcma_t add constraint bcma_pk primary key (bcmaent,bcmasite,bcma001) enable validate;

create unique index bcma_pk on bcma_t (bcmaent,bcmasite,bcma001);

grant select on bcma_t to tiptop;
grant update on bcma_t to tiptop;
grant delete on bcma_t to tiptop;
grant insert on bcma_t to tiptop;

exit;
