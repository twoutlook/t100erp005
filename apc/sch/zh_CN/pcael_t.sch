/* 
================================================================================
檔案代號:pcael_t
檔案名稱:POS功能基本資料多語言表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pcael_t
(
pcaelent       number(5)      ,/* 企業編號 */
pcael001       varchar2(40)      ,/* 功能編號 */
pcael002       varchar2(6)      ,/* 語言別 */
pcael003       varchar2(500)      ,/* 說明 */
pcael004       varchar2(10)      /* 助記碼 */
);
alter table pcael_t add constraint pcael_pk primary key (pcaelent,pcael001,pcael002) enable validate;

create unique index pcael_pk on pcael_t (pcaelent,pcael001,pcael002);

grant select on pcael_t to tiptop;
grant update on pcael_t to tiptop;
grant delete on pcael_t to tiptop;
grant insert on pcael_t to tiptop;

exit;
