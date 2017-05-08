/* 
================================================================================
檔案代號:dzdf_t
檔案名稱:4gl與元件/FUN對應關係檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzdf_t
(
dzdf001       varchar2(20)      ,/* 4gl代號 */
dzdf002       varchar2(40)      ,/* 元件/FUN對象 */
dzdf003       varchar2(1)      ,/* 是否元件 */
dzdf004       varchar2(40)      ,/* 所屬元件（非元件情況下） */
dzdfownid       varchar2(20)      ,/* 資料所有者 */
dzdfowndp       varchar2(10)      ,/* 資料所屬部門 */
dzdfcrtid       varchar2(20)      ,/* 資料建立者 */
dzdfcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzdfcrtdt       timestamp(0)      ,/* 資料創建日 */
dzdfmodid       varchar2(20)      ,/* 資料修改者 */
dzdfmoddt       timestamp(0)      ,/* 最近修改日 */
dzdfcnfid       varchar2(20)      ,/* 資料確認者 */
dzdfcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzdf_t add constraint dzdf_pk primary key (dzdf001,dzdf002) enable validate;

create unique index dzdf_pk on dzdf_t (dzdf001,dzdf002);

grant select on dzdf_t to tiptop;
grant update on dzdf_t to tiptop;
grant delete on dzdf_t to tiptop;
grant insert on dzdf_t to tiptop;

exit;
