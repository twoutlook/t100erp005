/* 
================================================================================
檔案代號:dzeb_t
檔案名稱:資料表欄位檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzeb_t
(
dzebstus       varchar2(10)      ,/* 狀態碼 */
dzeb001       varchar2(15)      ,/* table代號 */
dzeb002       varchar2(20)      ,/* 欄位代號 */
dzeb003       varchar2(80)      ,/* 欄位名稱 */
dzeb004       varchar2(1)      ,/* primary key */
dzeb005       varchar2(1)      ,/* 必要欄位 */
dzeb006       varchar2(4)      ,/* 欄位屬性 */
dzeb007       varchar2(20)      ,/* 資料型態(暫存) */
dzeb008       varchar2(10)      ,/* 欄位長度(暫存) */
dzeb021       number(10,0)      ,/* 欄位序號 */
dzeb022       varchar2(100)      ,/* 欄位類別定義代號 */
dzeb023       number(10,0)      ,/* 序號欄位號碼 */
dzeb024       varchar2(500)      ,/* 欄位說明 */
dzeb027       varchar2(80)      ,/* 外部轉入識別碼 */
dzebownid       varchar2(20)      ,/* 資料所有者 */
dzebowndp       varchar2(10)      ,/* 資料所屬部門 */
dzebcrtid       varchar2(20)      ,/* 資料建立者 */
dzebcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzebcrtdt       timestamp(0)      ,/* 資料創建日 */
dzebmodid       varchar2(20)      ,/* 資料修改者 */
dzebmoddt       timestamp(0)      ,/* 最近修改日 */
dzebcnfid       varchar2(20)      ,/* 資料確認者 */
dzebcnfdt       timestamp(0)      ,/* 資料確認日 */
dzeb028       varchar2(1)      ,/* 異動確認碼 */
dzeb029       varchar2(1)      ,/* 客制標示 */
dzeb012       varchar2(100)      ,/* 預設值 */
dzeb030       varchar2(1)      ,/* 原始客制標示 */
dzeb031       varchar2(1)      /* 出貨標示 */
);
alter table dzeb_t add constraint dzeb_pk primary key (dzeb001,dzeb002) enable validate;

create unique index dzeb_pk on dzeb_t (dzeb001,dzeb002);

grant select on dzeb_t to tiptop;
grant update on dzeb_t to tiptop;
grant delete on dzeb_t to tiptop;
grant insert on dzeb_t to tiptop;

exit;
