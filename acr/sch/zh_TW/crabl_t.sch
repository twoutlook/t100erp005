/* 
================================================================================
檔案代號:crabl_t
檔案名稱:競爭廠商資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table crabl_t
(
crablent       number(5)      ,/* 企業編號 */
crabl001       varchar2(10)      ,/* 競爭廠商編號 */
crabl002       varchar2(6)      ,/* 語言別 */
crabl003       varchar2(255)      ,/* 競爭廠商全名 */
crabl004       varchar2(80)      ,/* 競爭廠商簡稱 */
crabl005       varchar2(10)      /* 助記碼 */
);
alter table crabl_t add constraint crabl_pk primary key (crablent,crabl001,crabl002) enable validate;

create unique index crabl_pk on crabl_t (crablent,crabl001,crabl002);

grant select on crabl_t to tiptop;
grant update on crabl_t to tiptop;
grant delete on crabl_t to tiptop;
grant insert on crabl_t to tiptop;

exit;
