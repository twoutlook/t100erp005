/* 
================================================================================
檔案代號:nmahl_t
檔案名稱:票據類型設置檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table nmahl_t
(
nmahlent       number(5)      ,/* 企業編號 */
nmahl001       varchar2(10)      ,/* 票據類型編號 */
nmahl002       varchar2(6)      ,/* 語言別 */
nmahl003       varchar2(500)      /* 說明 */
);
alter table nmahl_t add constraint nmahl_pk primary key (nmahlent,nmahl001,nmahl002) enable validate;

create unique index nmahl_pk on nmahl_t (nmahlent,nmahl001,nmahl002);

grant select on nmahl_t to tiptop;
grant update on nmahl_t to tiptop;
grant delete on nmahl_t to tiptop;
grant insert on nmahl_t to tiptop;

exit;
