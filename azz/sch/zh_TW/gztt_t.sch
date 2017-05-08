/* 
================================================================================
檔案代號:gztt_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gztt_t
(
gzttmodu       varchar2(10)      ,/* 資料修改者 */
gzttdate       date      ,/* 最近修改日 */
gzttoriu       varchar2(10)      ,/* 資料所有者 */
gzttorid       varchar2(10)      ,/* 資料所有部門 */
gzttuser       varchar2(10)      ,/* 資料建立者 */
gzttdept       varchar2(10)      ,/* 資料建立部門 */
gzttbuid       date      ,/* 資料創建日 */
gztt001       varchar2(15)      ,/* 表格編號 */
gztt002       number(5)      ,/* 語言別 */
gztt003       varchar2(80)      ,/* 表格名稱 */
gztt004       varchar2(80)      ,/* 表格目的 */
gztt005       varchar2(80)      /* 備註 */
);
alter table gztt_t add constraint gztt_pk primary key (gztt001,gztt002) enable validate;


grant select on gztt_t to tiptop;
grant update on gztt_t to tiptop;
grant delete on gztt_t to tiptop;
grant insert on gztt_t to tiptop;

exit;
