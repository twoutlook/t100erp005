/* 
================================================================================
檔案代號:oobal_t
檔案名稱:單據別說明多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table oobal_t
(
oobalent       number(5)      ,/* 企業編號 */
oobal001       varchar2(5)      ,/* 參照表編號 */
oobal002       varchar2(5)      ,/* 單據別編號 */
oobal003       varchar2(6)      ,/* 語言別 */
oobal004       varchar2(80)      ,/* 說明 */
oobal005       varchar2(10)      /* 助記碼 */
);
alter table oobal_t add constraint oobal_pk primary key (oobalent,oobal001,oobal002,oobal003) enable validate;

create  index oobal_01 on oobal_t (oobal005);
create unique index oobal_pk on oobal_t (oobalent,oobal001,oobal002,oobal003);

grant select on oobal_t to tiptop;
grant update on oobal_t to tiptop;
grant delete on oobal_t to tiptop;
grant insert on oobal_t to tiptop;

exit;
