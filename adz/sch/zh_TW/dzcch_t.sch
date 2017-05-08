/* 
================================================================================
檔案代號:dzcch_t
檔案名稱:cch test
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzcch_t
(
dzcch001       clob      ,/* 111 */
dzcch002       blob      ,/* 222 */
dzcch003       varchar2(1)      ,/* 333 */
dzcch004       varchar2(10)      ,/* 444 */
dzcch005       varchar2(40)      ,/* 555 */
dzcch006       varchar2(10)      ,/* 666 */
dzcch007       varchar2(10)      ,/* 777 */
dzcch008       varchar2(10)      ,/* 888 */
dzcch009       varchar2(10)      ,/* 999 */
dzcch010       varchar2(10)      /* 000 */
);
alter table dzcch_t add constraint dzcch_pk primary key (dzcch001,dzcch002) enable validate;


grant select on dzcch_t to tiptop;
grant update on dzcch_t to tiptop;
grant delete on dzcch_t to tiptop;
grant insert on dzcch_t to tiptop;

exit;
