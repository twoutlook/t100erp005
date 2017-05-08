/* 
================================================================================
檔案代號:dzaz_t
檔案名稱:產生器產生計數表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzaz_t
(
dzaz001       varchar2(20)      ,/* 規格編號 */
dzaz002       number(10,0)      ,/* 產生計數 */
dzaz003       varchar2(20)      ,/* 使用者編號 */
dzaz004       date      /* 產生日期 */
);


grant select on dzaz_t to tiptop;
grant update on dzaz_t to tiptop;
grant delete on dzaz_t to tiptop;
grant insert on dzaz_t to tiptop;

exit;
