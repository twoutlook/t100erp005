/* 
================================================================================
檔案代號:gzws_t
檔案名稱:作業操作說明檔底稿
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzws_t
(
gzwsownid       varchar2(20)      ,/* 資料所有者 */
gzwsowndp       varchar2(10)      ,/* 資料所屬部門 */
gzwscrtid       varchar2(20)      ,/* 資料建立者 */
gzwscrtdp       varchar2(10)      ,/* 資料建立部門 */
gzwscrtdt       timestamp(0)      ,/* 資料創建日 */
gzwsmodid       varchar2(20)      ,/* 資料修改者 */
gzwsmoddt       timestamp(0)      ,/* 最近修改日 */
gzwsstus       varchar2(10)      ,/* 狀態碼 */
gzws001       varchar2(20)      ,/* 作業編號 */
gzws002       varchar2(1)      ,/* 客製 */
gzws003       varchar2(10)      ,/* 類別 */
gzws004       varchar2(6)      ,/* 語言別 */
gzws005       varchar2(1)      ,/* no use */
gzws006       varchar2(1)      ,/* no use */
gzws007       clob      ,/* 網頁內容 */
gzws008       clob      /* 編輯內容 */
);
alter table gzws_t add constraint gzws_pk primary key (gzwsownid,gzws001,gzws002,gzws003,gzws004) enable validate;

create unique index gzws_pk on gzws_t (gzwsownid,gzws001,gzws002,gzws003,gzws004);

grant select on gzws_t to tiptop;
grant update on gzws_t to tiptop;
grant delete on gzws_t to tiptop;
grant insert on gzws_t to tiptop;

exit;
