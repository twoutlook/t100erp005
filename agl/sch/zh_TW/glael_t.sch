/* 
================================================================================
檔案代號:glael_t
檔案名稱:核算項類型資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table glael_t
(
glaelent       number(5)      ,/* 企業編號 */
glael001       varchar2(10)      ,/* 核算項類型編號 */
glael002       varchar2(6)      ,/* 語言別 */
glael003       varchar2(500)      ,/* 說明 */
glael004       varchar2(10)      /* 助記碼 */
);
alter table glael_t add constraint glael_pk primary key (glaelent,glael001,glael002) enable validate;

create unique index glael_pk on glael_t (glaelent,glael001,glael002);

grant select on glael_t to tiptop;
grant update on glael_t to tiptop;
grant delete on glael_t to tiptop;
grant insert on glael_t to tiptop;

exit;
