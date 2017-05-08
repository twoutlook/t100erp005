/* 
================================================================================
檔案代號:dzhd_t
檔案名稱:資料表鍵值檔簽出備份檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzhd_t
(
dzhd000       varchar2(40)      ,/* 簽出GUID */
dzhd001       varchar2(15)      ,/* Table代號 */
dzhd002       varchar2(20)      ,/* 鍵值代號 */
dzhd003       varchar2(20)      ,/* 鍵值形式 */
dzhd004       varchar2(500)      ,/* 鍵值欄位 */
dzhd005       varchar2(15)      ,/* 外來鍵表格 */
dzhd006       varchar2(100)      ,/* 外來鍵欄位 */
dzhd007       varchar2(1)      ,/* 異動確認碼 */
dzhd008       varchar2(1)      ,/* 客制標示 */
dzhd009       varchar2(1)      ,/* 原始客制標示 */
dzhd010       varchar2(1)      ,/* 出貨標示 */
dzhdstus       varchar2(10)      ,/* 狀態碼 */
dzhdownid       varchar2(20)      ,/* 資料所有者 */
dzhdowndp       varchar2(10)      ,/* 資料所屬部門 */
dzhdcrtid       varchar2(20)      ,/* 資料建立者 */
dzhdcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzhdcrtdt       timestamp(0)      ,/* 資料創建日 */
dzhdmodid       varchar2(20)      ,/* 資料修改者 */
dzhdmoddt       timestamp(0)      ,/* 最近修改日 */
dzhdcnfid       varchar2(20)      ,/* 資料確認者 */
dzhdcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzhd_t add constraint dzhd_pk primary key (dzhd000,dzhd001,dzhd002) enable validate;

create unique index dzhd_pk on dzhd_t (dzhd000,dzhd001,dzhd002);

grant select on dzhd_t to tiptop;
grant update on dzhd_t to tiptop;
grant delete on dzhd_t to tiptop;
grant insert on dzhd_t to tiptop;

exit;
