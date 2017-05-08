/* 
================================================================================
檔案代號:gzgm_t
檔案名稱:報表元件表頭設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzgm_t
(
gzgmstus       varchar2(10)      ,/* 狀態碼 */
gzgm001       varchar2(20)      ,/* 報表元件代號 */
gzgm002       varchar2(6)      ,/* 語言別 */
gzgm003       varchar2(10)      ,/* 表頭代號 */
gzgmownid       varchar2(20)      ,/* 資料所有者 */
gzgmowndp       varchar2(10)      ,/* 資料所屬部門 */
gzgmcrtid       varchar2(20)      ,/* 資料建立者 */
gzgmcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzgmcrtdt       timestamp(0)      ,/* 資料創建日 */
gzgmmodid       varchar2(20)      ,/* 資料修改者 */
gzgmmoddt       timestamp(0)      ,/* 最近修改日 */
gzgm004       varchar2(1)      /* 客製 */
);
alter table gzgm_t add constraint gzgm_pk primary key (gzgm001,gzgm002) enable validate;

create unique index gzgm_pk on gzgm_t (gzgm001,gzgm002);

grant select on gzgm_t to tiptop;
grant update on gzgm_t to tiptop;
grant delete on gzgm_t to tiptop;
grant insert on gzgm_t to tiptop;

exit;
