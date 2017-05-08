/* 
================================================================================
檔案代號:gzgc_t
檔案名稱:報表樣板整體設定檔(GR+XtraGrid)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzgc_t
(
dzgcstus       varchar2(10)      ,/*   */
gzgc001       varchar2(6)      ,/* 語言別 */
gzgc002       varchar2(1)      ,/* 類別 */
gzgc003       varchar2(20)      ,/* 字型 */
gzgc004       number(5)      ,/* 字型大小 */
gzgc005       varchar2(1)      ,/* 粗體 */
gzgc006       varchar2(20)      ,/* 顏色 */
gzgc007       varchar2(20)      ,/* 顏色RGB值 */
gzgc008       varchar2(1)      ,/* 位置 */
gzgcownid       varchar2(20)      ,/* 資料所有者 */
gzgcowndp       varchar2(10)      ,/* 資料所屬部門 */
gzgccrtid       varchar2(20)      ,/* 資料建立者 */
gzgccrtdp       varchar2(10)      ,/* 資料建立部門 */
gzgccrtdt       timestamp(0)      ,/* 資料創建日 */
gzgcmodid       varchar2(20)      ,/* 資料修改者 */
gzgcmoddt       timestamp(0)      /* 最近修改日 */
);
alter table gzgc_t add constraint gzgc_pk primary key (gzgc001,gzgc002) enable validate;

create unique index gzgc_pk on gzgc_t (gzgc001,gzgc002);

grant select on gzgc_t to tiptop;
grant update on gzgc_t to tiptop;
grant delete on gzgc_t to tiptop;
grant insert on gzgc_t to tiptop;

exit;
