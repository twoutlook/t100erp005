/* 
================================================================================
檔案代號:preh_t
檔案名稱:促銷談判結果時間資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table preh_t
(
prehent       number(5)      ,/* 企業編號 */
prehunit       varchar2(10)      ,/* 制定組織 */
prehsite       varchar2(10)      ,/* 營運組織 */
prehacti       varchar2(1)      ,/* 有效 */
preh001       varchar2(30)      ,/* 規則編號 */
preh002       number(10,0)      ,/* 組別 */
preh003       date      ,/* 開始日期 */
preh004       date      ,/* 結束日期 */
preh005       varchar2(8)      ,/* 開始時間 */
preh006       varchar2(8)      ,/* 結束時間 */
preh007       varchar2(10)      ,/* 固定日期 */
preh008       varchar2(1)      /* 固定星期 */
);
alter table preh_t add constraint preh_pk primary key (prehent,preh001,preh002) enable validate;

create unique index preh_pk on preh_t (prehent,preh001,preh002);

grant select on preh_t to tiptop;
grant update on preh_t to tiptop;
grant delete on preh_t to tiptop;
grant insert on preh_t to tiptop;

exit;
