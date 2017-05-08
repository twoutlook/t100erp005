/* 
================================================================================
檔案代號:bcmb_t
檔案名稱:料件資料與庫存資訊檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bcmb_t
(
bcmbent       number(5)      ,/* 企業編號 */
bcmbsite       varchar2(10)      ,/* 營運據點 */
bcmb001       varchar2(40)      ,/* 料件編號 */
bcmb002       varchar2(255)      ,/* 品名 */
bcmb003       varchar2(255)      ,/* 規格 */
bcmb004       varchar2(256)      ,/* 產品特徵 */
bcmb005       varchar2(500)      ,/* 產品特徵說明 */
bcmb006       varchar2(10)      ,/* 庫位編號 */
bcmb007       varchar2(10)      ,/* 儲位編號 */
bcmb008       varchar2(30)      ,/* 批號 */
bcmb009       varchar2(30)      ,/* 庫存管理特徵 */
bcmb010       varchar2(30)      ,/* 製造批號 */
bcmb011       varchar2(30)      ,/* 製造序號 */
bcmb012       varchar2(10)      ,/* 庫存單位 */
bcmb013       number(20,6)      ,/* 庫存數量 */
bcmb014       varchar2(1)      ,/* 庫存可用否 */
bcmb999       timestamp(5)      ,/* 最後異動時間 */
bcmbstus       varchar2(10)      ,/* 有效否 */
bcmbownid       varchar2(20)      ,/* 資料所有者 */
bcmbowndp       varchar2(10)      ,/* 資料所屬部門 */
bcmbcrtid       varchar2(20)      ,/* 資料建立者 */
bcmbcrtdp       varchar2(10)      ,/* 資料建立部門 */
bcmbcrtdt       timestamp(0)      ,/* 資料創建日 */
bcmbmodid       varchar2(20)      ,/* 資料修改者 */
bcmbmoddt       timestamp(0)      ,/* 最近修改日 */
bcmbcnfid       varchar2(20)      ,/* 資料確認者 */
bcmbcnfdt       timestamp(0)      ,/* 資料確認日 */
bcmbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bcmbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bcmbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bcmbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bcmbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bcmbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bcmbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bcmbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bcmbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bcmbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bcmbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bcmbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bcmbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bcmbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bcmbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bcmbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bcmbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bcmbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bcmbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bcmbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bcmbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bcmbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bcmbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bcmbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bcmbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bcmbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bcmbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bcmbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bcmbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bcmbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
bcmb015       number(20,6)      /* 超交率 */
);
alter table bcmb_t add constraint bcmb_pk primary key (bcmbent,bcmbsite,bcmb001,bcmb004,bcmb006,bcmb007,bcmb008,bcmb012) enable validate;

create unique index bcmb_pk on bcmb_t (bcmbent,bcmbsite,bcmb001,bcmb004,bcmb006,bcmb007,bcmb008,bcmb012);

grant select on bcmb_t to tiptop;
grant update on bcmb_t to tiptop;
grant delete on bcmb_t to tiptop;
grant insert on bcmb_t to tiptop;

exit;
