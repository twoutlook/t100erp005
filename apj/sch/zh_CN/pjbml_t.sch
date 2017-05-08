/* 
================================================================================
檔案代號:pjbml_t
檔案名稱:專案活動單身檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pjbml_t
(
pjbmlent       number(5)      ,/* 企業編號 */
pjbml001       varchar2(20)      ,/* 專案編號 */
pjbml002       varchar2(30)      ,/* 活動編號 */
pjbml003       varchar2(6)      ,/* 語言別 */
pjbml004       varchar2(500)      ,/* 說明 */
pjbml005       varchar2(10)      /* 助記碼 */
);
alter table pjbml_t add constraint pjbml_pk primary key (pjbmlent,pjbml001,pjbml002,pjbml003) enable validate;

create unique index pjbml_pk on pjbml_t (pjbmlent,pjbml001,pjbml002,pjbml003);

grant select on pjbml_t to tiptop;
grant update on pjbml_t to tiptop;
grant delete on pjbml_t to tiptop;
grant insert on pjbml_t to tiptop;

exit;
