/* 
================================================================================
檔案代號:preb_t
檔案名稱:促銷談判條件時間資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table preb_t
(
prebent       number(5)      ,/* 企業編號 */
prebunit       varchar2(10)      ,/* 制定組織 */
prebsite       varchar2(10)      ,/* 營運組織 */
prebdocno       varchar2(20)      ,/* 促銷談判單號 */
preb001       varchar2(30)      ,/* 規則編號 */
preb002       number(10,0)      ,/* 組別 */
preb003       date      ,/* 開始日期 */
preb004       date      ,/* 結束日期 */
preb005       varchar2(8)      ,/* 開始時間 */
preb006       varchar2(8)      ,/* 結束時間 */
preb007       varchar2(10)      ,/* 固定日期 */
preb008       varchar2(1)      ,/* 固定星期 */
prebacti       varchar2(1)      /* 資料有效碼 */
);
alter table preb_t add constraint preb_pk primary key (prebent,prebdocno,preb002) enable validate;

create unique index preb_pk on preb_t (prebent,prebdocno,preb002);

grant select on preb_t to tiptop;
grant update on preb_t to tiptop;
grant delete on preb_t to tiptop;
grant insert on preb_t to tiptop;

exit;
