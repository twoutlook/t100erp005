/* 
================================================================================
檔案代號:wscb_t
檔案名稱:傳遞檔案用途
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wscb_t
(
wscbent       number(5)      ,/* 企業編號 */
wscb001       varchar2(40)      ,/* 工作序號 */
wscb002       varchar2(256)      ,/* 檔案名稱 */
wscb003       blob      /* 檔案內容 */
);


grant select on wscb_t to tiptop;
grant update on wscb_t to tiptop;
grant delete on wscb_t to tiptop;
grant insert on wscb_t to tiptop;

exit;
