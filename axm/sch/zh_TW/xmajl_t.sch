/* 
================================================================================
檔案代號:xmajl_t
檔案名稱:信用評等公式資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xmajl_t
(
xmajlent       number(5)      ,/* 企業編號 */
xmajl001       varchar2(10)      ,/* 信用評等編號 */
xmajl002       varchar2(6)      ,/* 語言別 */
xmajl003       varchar2(500)      ,/* 說明 */
xmajl004       varchar2(10)      /* 助記碼 */
);
alter table xmajl_t add constraint xmajl_pk primary key (xmajlent,xmajl001,xmajl002) enable validate;

create unique index xmajl_pk on xmajl_t (xmajlent,xmajl001,xmajl002);

grant select on xmajl_t to tiptop;
grant update on xmajl_t to tiptop;
grant delete on xmajl_t to tiptop;
grant insert on xmajl_t to tiptop;

exit;
