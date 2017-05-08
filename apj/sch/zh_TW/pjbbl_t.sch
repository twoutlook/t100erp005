/* 
================================================================================
檔案代號:pjbbl_t
檔案名稱:專案WBS單身檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pjbbl_t
(
pjbblent       number(5)      ,/* 企業編號 */
pjbbl001       varchar2(20)      ,/* 專案編號 */
pjbbl002       varchar2(30)      ,/* 本階WBS */
pjbbl003       varchar2(6)      ,/* 語言別 */
pjbbl004       varchar2(500)      ,/* 說明 */
pjbbl005       varchar2(10)      /* 助記碼 */
);
alter table pjbbl_t add constraint pjbbl_pk primary key (pjbblent,pjbbl001,pjbbl002,pjbbl003) enable validate;

create  index pjbbl_01 on pjbbl_t (pjbbl005);
create unique index pjbbl_pk on pjbbl_t (pjbblent,pjbbl001,pjbbl002,pjbbl003);

grant select on pjbbl_t to tiptop;
grant update on pjbbl_t to tiptop;
grant delete on pjbbl_t to tiptop;
grant insert on pjbbl_t to tiptop;

exit;
