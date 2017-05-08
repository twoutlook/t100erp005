/* 
================================================================================
檔案代號:gzrz_t
檔案名稱:系統規範要求記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzrz_t
(
gzrzstus       varchar2(10)      ,/* 狀態碼 */
gzrz001       varchar2(20)      ,/* 規範大類 */
gzrz002       varchar2(20)      ,/* 規範小類 */
gzrz003       number(10,0)      ,/* 規範序號 */
gzrz004       varchar2(255)      ,/* 規範標題 */
gzrz005       clob      ,/* 實施內容 */
gzrzownid       varchar2(10)      ,/* 資料所有者 */
gzrzowndp       varchar2(10)      ,/* 資料所屬部門 */
gzrzcrtid       varchar2(10)      ,/* 資料建立者 */
gzrzcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzrzcrtdt       date      ,/* 資料創建日 */
gzrzmodid       varchar2(10)      ,/* 資料修改者 */
gzrzmoddt       date      /* 最近修改日 */
);
alter table gzrz_t add constraint gzrz_pk primary key (gzrz001,gzrz002,gzrz003) enable validate;


grant select on gzrz_t to tiptop;
grant update on gzrz_t to tiptop;
grant delete on gzrz_t to tiptop;
grant insert on gzrz_t to tiptop;

exit;
