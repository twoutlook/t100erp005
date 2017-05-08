/* 
================================================================================
檔案代號:bgcel_t
檔案名稱:模擬收入變量主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bgcel_t
(
bgcelent       number(5)      ,/* 企業編號 */
bgcel001       varchar2(10)      ,/* 預算參照表 */
bgcel002       number(10,0)      ,/* 模擬收入項目 */
bgcel003       varchar2(6)      ,/* 語言別 */
bgcel004       varchar2(500)      ,/* 說明 */
bgcel005       varchar2(10)      /* 助記碼 */
);
alter table bgcel_t add constraint bgcel_pk primary key (bgcelent,bgcel001,bgcel002,bgcel003) enable validate;

create unique index bgcel_pk on bgcel_t (bgcelent,bgcel001,bgcel002,bgcel003);

grant select on bgcel_t to tiptop;
grant update on bgcel_t to tiptop;
grant delete on bgcel_t to tiptop;
grant insert on bgcel_t to tiptop;

exit;
