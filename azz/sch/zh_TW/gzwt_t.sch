/* 
================================================================================
檔案代號:gzwt_t
檔案名稱:作業操作說明細項檔底稿
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzwt_t
(
gzwtownid       varchar2(20)      ,/* 資料所有者 */
gzwtowndp       varchar2(10)      ,/* 資料所屬部門 */
gzwtcrtid       varchar2(20)      ,/* 資料建立者 */
gzwtcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzwtcrtdt       timestamp(0)      ,/* 資料創建日 */
gzwtmodid       varchar2(20)      ,/* 資料修改者 */
gzwtmoddt       timestamp(0)      ,/* 最近修改日 */
gzwtstus       varchar2(10)      ,/* 狀態碼 */
gzwt001       varchar2(20)      ,/* 作業編號 */
gzwt002       varchar2(1)      ,/* 客製 */
gzwt003       varchar2(10)      ,/* 類別 */
gzwt004       varchar2(80)      ,/* 編號 */
gzwt005       number(5,0)      ,/* 順序 */
gzwt006       varchar2(6)      ,/* 語言別 */
gzwt007       varchar2(255)      ,/* 名稱 */
gzwt008       clob      ,/* 網頁內容 */
gzwt009       clob      /* 編輯內容 */
);
alter table gzwt_t add constraint gzwt_pk primary key (gzwtownid,gzwt001,gzwt002,gzwt003,gzwt004,gzwt006) enable validate;

create unique index gzwt_pk on gzwt_t (gzwtownid,gzwt001,gzwt002,gzwt003,gzwt004,gzwt006);

grant select on gzwt_t to tiptop;
grant update on gzwt_t to tiptop;
grant delete on gzwt_t to tiptop;
grant insert on gzwt_t to tiptop;

exit;
