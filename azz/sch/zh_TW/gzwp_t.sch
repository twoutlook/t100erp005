/* 
================================================================================
檔案代號:gzwp_t
檔案名稱:作業操作說明檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzwp_t
(
gzwpownid       varchar2(20)      ,/* 資料所有者 */
gzwpowndp       varchar2(10)      ,/* 資料所屬部門 */
gzwpcrtid       varchar2(20)      ,/* 資料建立者 */
gzwpcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzwpcrtdt       timestamp(0)      ,/* 資料創建日 */
gzwpmodid       varchar2(20)      ,/* 資料修改者 */
gzwpmoddt       timestamp(0)      ,/* 最近修改日 */
gzwpstus       varchar2(10)      ,/* 狀態碼 */
gzwp001       varchar2(20)      ,/* 作業編號 */
gzwp002       varchar2(1)      ,/* 客製 */
gzwp003       varchar2(10)      ,/* 類別 */
gzwp004       varchar2(6)      ,/* 語言別 */
gzwp005       varchar2(1)      ,/* no use */
gzwp006       varchar2(1)      ,/* no use */
gzwp007       clob      ,/* 網頁內容 */
gzwp008       clob      /* 編輯內容 */
);
alter table gzwp_t add constraint gzwp_pk primary key (gzwp001,gzwp002,gzwp003,gzwp004) enable validate;

create unique index gzwp_pk on gzwp_t (gzwp001,gzwp002,gzwp003,gzwp004);

grant select on gzwp_t to tiptop;
grant update on gzwp_t to tiptop;
grant delete on gzwp_t to tiptop;
grant insert on gzwp_t to tiptop;

exit;
