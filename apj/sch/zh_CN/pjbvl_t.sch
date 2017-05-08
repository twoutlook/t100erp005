/* 
================================================================================
檔案代號:pjbvl_t
檔案名稱:專案活動變更單身檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pjbvl_t
(
pjbvlent       number(5)      ,/* 企業編號 */
pjbvl001       varchar2(20)      ,/* 專案編號 */
pjbvl002       varchar2(30)      ,/* 活動編號 */
pjbvl003       varchar2(6)      ,/* 語言別 */
pjbvl004       varchar2(500)      ,/* 說明 */
pjbvl005       varchar2(10)      ,/* 助記碼 */
pjbvl900       number(10,0)      ,/* 變更序 */
pjbvl901       varchar2(1)      /* 變更類型 */
);
alter table pjbvl_t add constraint pjbvl_pk primary key (pjbvlent,pjbvl001,pjbvl002,pjbvl003,pjbvl900) enable validate;

create unique index pjbvl_pk on pjbvl_t (pjbvlent,pjbvl001,pjbvl002,pjbvl003,pjbvl900);

grant select on pjbvl_t to tiptop;
grant update on pjbvl_t to tiptop;
grant delete on pjbvl_t to tiptop;
grant insert on pjbvl_t to tiptop;

exit;
