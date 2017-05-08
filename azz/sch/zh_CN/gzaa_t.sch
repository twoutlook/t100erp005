/* 
================================================================================
檔案代號:gzaa_t
檔案名稱:應用分類檔(ACC)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzaa_t
(
gzaastus       varchar2(10)      ,/* 狀態碼 */
gzaa001       number(5)      ,/* 應用分類 */
gzaa002       varchar2(1)      ,/* 系統標準 */
gzaa003       varchar2(1)      ,/* 允許建立多階層結構 */
gzaa004       varchar2(10)      ,/* 模組 */
gzaaownid       varchar2(20)      ,/* 資料所有者 */
gzaaowndp       varchar2(10)      ,/* 資料所屬部門 */
gzaacrtid       varchar2(20)      ,/* 資料建立者 */
gzaacrtdp       varchar2(10)      ,/* 資料建立部門 */
gzaacrtdt       timestamp(0)      ,/* 資料創建日 */
gzaamodid       varchar2(20)      ,/* 資料修改者 */
gzaamoddt       timestamp(0)      ,/* 最近修改日 */
gzaa005       varchar2(1)      /* 開啟時一併顯示單身資料 */
);
alter table gzaa_t add constraint gzaa_pk primary key (gzaa001) enable validate;

create  index gzaa_01 on gzaa_t (gzaa002);
create unique index gzaa_pk on gzaa_t (gzaa001);

grant select on gzaa_t to tiptop;
grant update on gzaa_t to tiptop;
grant delete on gzaa_t to tiptop;
grant insert on gzaa_t to tiptop;

exit;
