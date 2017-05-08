/* 
================================================================================
檔案代號:gzca_t
檔案名稱:系統分類碼檔(SCC)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzca_t
(
gzcastus       varchar2(10)      ,/* 狀態碼 */
gzca001       number(10,0)      ,/* 系統分類碼 */
gzca002       varchar2(1)      ,/* 系統標準 */
gzcaownid       varchar2(20)      ,/* 資料所有者 */
gzcaowndp       varchar2(10)      ,/* 資料所屬部門 */
gzcacrtid       varchar2(20)      ,/* 資料建立者 */
gzcacrtdp       varchar2(10)      ,/* 資料建立部門 */
gzcacrtdt       timestamp(0)      ,/* 資料創建日 */
gzcamodid       varchar2(20)      ,/* 資料修改者 */
gzcamoddt       timestamp(0)      ,/* 最近修改日 */
gzca003       varchar2(4000)      ,/* 備註 */
gzca004       varchar2(10)      /* 模組 */
);
alter table gzca_t add constraint gzca_pk primary key (gzca001) enable validate;

create unique index gzca_pk on gzca_t (gzca001);

grant select on gzca_t to tiptop;
grant update on gzca_t to tiptop;
grant delete on gzca_t to tiptop;
grant insert on gzca_t to tiptop;

exit;
