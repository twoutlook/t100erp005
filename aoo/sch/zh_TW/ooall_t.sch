/* 
================================================================================
檔案代號:ooall_t
檔案名稱:參照表說明資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table ooall_t
(
ooallent       number(5)      ,/* 企業編號 */
ooall001       number(5,0)      ,/* 參照表類型 */
ooall002       varchar2(5)      ,/* 參照表編號 */
ooall003       varchar2(6)      ,/* 語言別 */
ooall004       varchar2(500)      ,/* 說明 */
ooall005       varchar2(10)      /* 助記碼 */
);
alter table ooall_t add constraint ooall_pk primary key (ooallent,ooall001,ooall002,ooall003) enable validate;

create  index ooall_01 on ooall_t (ooall005);
create unique index ooall_pk on ooall_t (ooallent,ooall001,ooall002,ooall003);

grant select on ooall_t to tiptop;
grant update on ooall_t to tiptop;
grant delete on ooall_t to tiptop;
grant insert on ooall_t to tiptop;

exit;
