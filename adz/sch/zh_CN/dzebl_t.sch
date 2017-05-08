/* 
================================================================================
檔案代號:dzebl_t
檔案名稱:資料表欄位多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dzebl_t
(
dzebl001       varchar2(15)      ,/* 欄位編號 */
dzebl002       varchar2(6)      ,/* 語言別 */
dzebl003       varchar2(500)      ,/* 欄位名稱 */
dzebl004       varchar2(500)      ,/* 欄位說明 */
dzebl000       varchar2(15)      /* 表格名稱 */
);
alter table dzebl_t add constraint dzebl_pk primary key (dzebl001,dzebl002) enable validate;

create unique index dzebl_pk on dzebl_t (dzebl001,dzebl002);

grant select on dzebl_t to tiptop;
grant update on dzebl_t to tiptop;
grant delete on dzebl_t to tiptop;
grant insert on dzebl_t to tiptop;

exit;
