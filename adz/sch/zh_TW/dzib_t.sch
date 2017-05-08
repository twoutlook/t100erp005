/* 
================================================================================
檔案代號:dzib_t
檔案名稱:中介表格明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzib_t
(
dzib001       varchar2(15)      ,/* table代號 */
dzib002       varchar2(20)      ,/* 欄位代號 */
dzib003       varchar2(80)      ,/* 欄位名稱 */
dzib004       varchar2(1)      ,/* primary key */
dzib005       varchar2(1)      ,/* 必要欄位 */
dzib006       varchar2(4)      ,/* 欄位屬性 */
dzib007       varchar2(20)      ,/* 資料型態(暫存) */
dzib008       varchar2(10)      ,/* 欄位長度(暫存) */
dzib012       varchar2(100)      ,/* 預設值 */
dzib021       number(10,0)      ,/* 欄位序號 */
dzib022       varchar2(100)      ,/* 欄位類別定義代號 */
dzib023       number(10,0)      ,/* 序號欄位號碼 */
dzib024       varchar2(500)      ,/* 欄位說明 */
dzib027       varchar2(80)      ,/* 外部轉入識別碼 */
dzib028       varchar2(1)      ,/* 異動確認碼 */
dzib029       varchar2(1)      ,/* 客制標示 */
dzib030       varchar2(1)      ,/* 原始客制標示 */
dzib031       varchar2(1)      ,/* 出貨標示 */
dzibstus       varchar2(10)      ,/* 狀態碼 */
dzibownid       varchar2(20)      ,/* 資料所有者 */
dzibowndp       varchar2(10)      ,/* 資料所屬部門 */
dzibcrtid       varchar2(20)      ,/* 資料建立者 */
dzibcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzibcrtdt       timestamp(0)      ,/* 資料創建日 */
dzibmodid       varchar2(20)      ,/* 資料修改者 */
dzibmoddt       timestamp(0)      ,/* 最近修改日 */
dzibcnfid       varchar2(20)      ,/* 資料確認者 */
dzibcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzib_t add constraint dzib_pk primary key (dzib001,dzib002,dzib029) enable validate;

create unique index dzib_pk on dzib_t (dzib001,dzib002,dzib029);

grant select on dzib_t to tiptop;
grant update on dzib_t to tiptop;
grant delete on dzib_t to tiptop;
grant insert on dzib_t to tiptop;

exit;
