/* 
================================================================================
檔案代號:bgcfl_t
檔案名稱:模擬收入變量主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bgcfl_t
(
bgcflent       number(5)      ,/* 企業編號 */
bgcfl001       varchar2(10)      ,/* 變量編號 */
bgcfl002       varchar2(6)      ,/* 語言別 */
bgcfl003       varchar2(500)      ,/* 說明 */
bgcfl004       varchar2(10)      /* 助記碼 */
);
alter table bgcfl_t add constraint bgcfl_pk primary key (bgcflent,bgcfl001,bgcfl002) enable validate;

create unique index bgcfl_pk on bgcfl_t (bgcflent,bgcfl001,bgcfl002);

grant select on bgcfl_t to tiptop;
grant update on bgcfl_t to tiptop;
grant delete on bgcfl_t to tiptop;
grant insert on bgcfl_t to tiptop;

exit;
