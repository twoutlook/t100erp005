/* 
================================================================================
檔案代號:dzex_t
檔案名稱:狀態碼分類設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzex_t
(
dzex001       varchar2(15)      ,/* Table編號 */
dzex002       varchar2(20)      ,/* 狀態碼欄位 */
dzex003       number(5,0)      ,/* 系統分類碼 */
dzex004       varchar2(10)      ,/* 系統分類值 */
dzex005       varchar2(1)      ,/* 使用標示 */
dzex006       number(5,0)      ,/* 顯示順序 */
dzexstus       varchar2(10)      ,/* 狀態碼 */
dzexownid       varchar2(20)      ,/* 資料所有者 */
dzexowndp       varchar2(10)      ,/* 資料所屬部門 */
dzexcrtid       varchar2(20)      ,/* 資料建立者 */
dzexcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzexcrtdt       timestamp(0)      ,/* 資料創建日 */
dzexmodid       varchar2(20)      ,/* 資料修改者 */
dzexmoddt       timestamp(0)      ,/* 最近修改日 */
dzexcnfid       varchar2(20)      ,/* 資料確認者 */
dzexcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzex_t add constraint dzex_pk primary key (dzex001,dzex004) enable validate;

create unique index dzex_pk on dzex_t (dzex001,dzex004);

grant select on dzex_t to tiptop;
grant update on dzex_t to tiptop;
grant delete on dzex_t to tiptop;
grant insert on dzex_t to tiptop;

exit;
