/* 
================================================================================
檔案代號:gzoj_t
檔案名稱:行業別插入標準設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzoj_t
(
gzojownid       varchar2(20)      ,/* 資料所有者 */
gzojowndp       varchar2(10)      ,/* 資料所屬部門 */
gzojcrtid       varchar2(20)      ,/* 資料建立者 */
gzojcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzojcrtdt       timestamp(0)      ,/* 資料創建日 */
gzojmodid       varchar2(20)      ,/* 資料修改者 */
gzojmoddt       timestamp(0)      ,/* 最近修改日 */
gzojstus       varchar2(10)      ,/* 狀態碼 */
gzoj001       varchar2(20)      ,/* 程式編號 */
gzoj002       varchar2(4)      ,/* 歸屬模組 */
gzoj003       varchar2(80)      ,/* 歸屬行業 */
gzoj004       varchar2(1)      ,/* 客製 */
gzoj005       clob      ,/* 邏輯內容 */
gzoj006       varchar2(60)      /* Function 功能名稱 */
);
alter table gzoj_t add constraint gzoj_pk primary key (gzoj001,gzoj003,gzoj006) enable validate;

create unique index gzoj_pk on gzoj_t (gzoj001,gzoj003,gzoj006);

grant select on gzoj_t to tiptop;
grant update on gzoj_t to tiptop;
grant delete on gzoj_t to tiptop;
grant insert on gzoj_t to tiptop;

exit;
