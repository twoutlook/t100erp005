/* 
================================================================================
檔案代號:dzhs_t
檔案名稱:序號紀錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzhs_t
(
dzhs001       varchar2(80)      ,/* 序號名稱 */
dzhs002       number(10,0)      ,/* 現行序號 */
dzhs003       number(10,0)      ,/* 遞增值 */
dzhs004       number(10,0)      ,/* 起始值 */
dzhs005       number(10,0)      ,/* 最大值 */
dzhs006       number(10,0)      ,/* 最小值 */
dzhs007       varchar2(1)      /* 是否遞迴 */
);
alter table dzhs_t add constraint dzhs_pk primary key (dzhs001) enable validate;

create unique index dzhs_pk on dzhs_t (dzhs001);

grant select on dzhs_t to tiptop;
grant update on dzhs_t to tiptop;
grant delete on dzhs_t to tiptop;
grant insert on dzhs_t to tiptop;

exit;
