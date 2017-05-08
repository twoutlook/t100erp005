/* 
================================================================================
檔案代號:oocnl_t
檔案名稱:郵政編碼檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table oocnl_t
(
oocnlent       number(5)      ,/* 企業編號 */
oocnl001       varchar2(10)      ,/* 國家地區編號 */
oocnl002       varchar2(12)      ,/* 郵政編號 */
oocnl003       varchar2(6)      ,/* 語言別 */
oocnl004       varchar2(500)      ,/* 說明 */
oocnl005       varchar2(10)      ,/* 助記碼 */
oocnl006       number(10,0)      /* 序號 */
);
alter table oocnl_t add constraint oocnl_pk primary key (oocnlent,oocnl001,oocnl003,oocnl006) enable validate;

create  index oocnl_01 on oocnl_t (oocnl005,oocnl002);
create unique index oocnl_pk on oocnl_t (oocnlent,oocnl001,oocnl003,oocnl006);

grant select on oocnl_t to tiptop;
grant update on oocnl_t to tiptop;
grant delete on oocnl_t to tiptop;
grant insert on oocnl_t to tiptop;

exit;
