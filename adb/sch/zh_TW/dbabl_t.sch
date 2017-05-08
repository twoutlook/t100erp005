/* 
================================================================================
檔案代號:dbabl_t
檔案名稱:路線基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dbabl_t
(
dbablent       number(5)      ,/* 企業編號 */
dbabl001       varchar2(10)      ,/* 路線編號 */
dbabl002       varchar2(6)      ,/* 語言別 */
dbabl003       varchar2(500)      ,/* 說明(簡稱) */
dbabl004       varchar2(500)      ,/* 說明(全稱) */
dbabl005       varchar2(10)      /* 助記碼 */
);
alter table dbabl_t add constraint dbabl_pk primary key (dbablent,dbabl001,dbabl002) enable validate;

create unique index dbabl_pk on dbabl_t (dbablent,dbabl001,dbabl002);

grant select on dbabl_t to tiptop;
grant update on dbabl_t to tiptop;
grant delete on dbabl_t to tiptop;
grant insert on dbabl_t to tiptop;

exit;
