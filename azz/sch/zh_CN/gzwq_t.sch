/* 
================================================================================
檔案代號:gzwq_t
檔案名稱:作業操作說明細項檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzwq_t
(
gzwqownid       varchar2(20)      ,/* 資料所有者 */
gzwqowndp       varchar2(10)      ,/* 資料所屬部門 */
gzwqcrtid       varchar2(20)      ,/* 資料建立者 */
gzwqcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzwqcrtdt       timestamp(0)      ,/* 資料創建日 */
gzwqmodid       varchar2(20)      ,/* 資料修改者 */
gzwqmoddt       timestamp(0)      ,/* 最近修改日 */
gzwqstus       varchar2(10)      ,/* 狀態碼 */
gzwq001       varchar2(20)      ,/* 作業編號 */
gzwq002       varchar2(1)      ,/* 客製 */
gzwq003       varchar2(10)      ,/* 類別 */
gzwq004       varchar2(80)      ,/* 編號 */
gzwq005       number(5,0)      ,/* 順序 */
gzwq006       varchar2(6)      ,/* 語言別 */
gzwq007       varchar2(255)      ,/* 名稱 */
gzwq008       clob      ,/* 網頁內容 */
gzwq009       clob      /* 編輯內容 */
);
alter table gzwq_t add constraint gzwq_pk primary key (gzwq001,gzwq002,gzwq003,gzwq004,gzwq006) enable validate;

create unique index gzwq_pk on gzwq_t (gzwq001,gzwq002,gzwq003,gzwq004,gzwq006);

grant select on gzwq_t to tiptop;
grant update on gzwq_t to tiptop;
grant delete on gzwq_t to tiptop;
grant insert on gzwq_t to tiptop;

exit;
