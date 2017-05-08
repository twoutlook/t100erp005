/* 
================================================================================
檔案代號:bgael_t
檔案名稱:预算项目档多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bgael_t
(
bgaelent       number(5)      ,/* 企业编号 */
bgael006       varchar2(5)      ,/* 预算细项参照表号 */
bgael001       varchar2(24)      ,/* 预算细项编码 */
bgael002       varchar2(6)      ,/* 语言别 */
bgael003       varchar2(500)      ,/* 说明 */
bgael004       varchar2(10)      /* 助记码 */
);
alter table bgael_t add constraint bgael_pk primary key (bgaelent,bgael006,bgael001,bgael002) enable validate;

create unique index bgael_pk on bgael_t (bgaelent,bgael006,bgael001,bgael002);

grant select on bgael_t to tiptop;
grant update on bgael_t to tiptop;
grant delete on bgael_t to tiptop;
grant insert on bgael_t to tiptop;

exit;
