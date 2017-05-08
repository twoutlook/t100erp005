/* 
================================================================================
檔案代號:xmahl_t
檔案名稱:銷售取價方式單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xmahl_t
(
xmahlent       number(5)      ,/* 企業編號 */
xmahl001       varchar2(10)      ,/* 取價方式編號 */
xmahl002       varchar2(6)      ,/* 語言別 */
xmahl003       varchar2(500)      ,/* 說明 */
xmahl004       varchar2(10)      /* 助記碼 */
);
alter table xmahl_t add constraint xmahl_pk primary key (xmahlent,xmahl001,xmahl002) enable validate;

create unique index xmahl_pk on xmahl_t (xmahlent,xmahl001,xmahl002);

grant select on xmahl_t to tiptop;
grant update on xmahl_t to tiptop;
grant delete on xmahl_t to tiptop;
grant insert on xmahl_t to tiptop;

exit;
