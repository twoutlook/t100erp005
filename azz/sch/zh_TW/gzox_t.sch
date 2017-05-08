/* 
================================================================================
檔案代號:gzox_t
檔案名稱:多語言匯入字典檔格式設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzox_t
(
gzoxownid       varchar2(20)      ,/* 資料所有者 */
gzoxowndp       varchar2(10)      ,/* 資料所屬部門 */
gzoxcrtid       varchar2(20)      ,/* 資料建立者 */
gzoxcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzoxcrtdt       timestamp(0)      ,/* 資料創建日 */
gzoxmodid       varchar2(20)      ,/* 資料修改者 */
gzoxmoddt       timestamp(0)      ,/* 最近修改日 */
gzoxstus       varchar2(10)      ,/* 狀態碼 */
gzox001       varchar2(15)      ,/* 表格編號 */
gzox002       varchar2(80)      ,/* PK欄位組合 */
gzox003       varchar2(20)      ,/* 多語言欄位編號 */
gzox004       varchar2(80)      /* 需轉換欄位名稱組合 */
);
alter table gzox_t add constraint gzox_pk primary key (gzox001) enable validate;

create unique index gzox_pk on gzox_t (gzox001);

grant select on gzox_t to tiptop;
grant update on gzox_t to tiptop;
grant delete on gzox_t to tiptop;
grant insert on gzox_t to tiptop;

exit;
