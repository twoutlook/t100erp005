/* 
================================================================================
檔案代號:dzed_t
檔案名稱:資料表鍵值檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzed_t
(
dzedstus       varchar2(10)      ,/* 狀態碼 */
dzed001       varchar2(15)      ,/* Table代號 */
dzed002       varchar2(20)      ,/* 鍵值代號 */
dzed003       varchar2(20)      ,/* 鍵值形式 */
dzed004       varchar2(500)      ,/* 鍵值欄位 */
dzed005       varchar2(15)      ,/* 外來鍵表格 */
dzed006       varchar2(500)      ,/* 外來鍵欄位 */
dzedownid       varchar2(20)      ,/* 資料所有者 */
dzedowndp       varchar2(10)      ,/* 資料所屬部門 */
dzedcrtid       varchar2(20)      ,/* 資料建立者 */
dzedcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzedcrtdt       timestamp(0)      ,/* 資料創建日 */
dzedmodid       varchar2(20)      ,/* 資料修改者 */
dzedmoddt       timestamp(0)      ,/* 最近修改日 */
dzedcnfid       varchar2(20)      ,/* 資料確認者 */
dzedcnfdt       timestamp(0)      ,/* 資料確認日 */
dzed007       varchar2(1)      ,/* 異動確認碼 */
dzed008       varchar2(1)      ,/* 客制標示 */
dzed009       varchar2(1)      ,/* 原始客制標示 */
dzed010       varchar2(1)      /* 出貨標示 */
);
alter table dzed_t add constraint dzed_pk primary key (dzed001,dzed002) enable validate;

create unique index dzed_pk on dzed_t (dzed001,dzed002);

grant select on dzed_t to tiptop;
grant update on dzed_t to tiptop;
grant delete on dzed_t to tiptop;
grant insert on dzed_t to tiptop;

exit;
