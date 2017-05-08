/* 
================================================================================
檔案代號:pjbol_t
檔案名稱:專案WBS變更單身檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pjbol_t
(
pjbolent       number(5)      ,/* 企業編號 */
pjbol001       varchar2(20)      ,/* 專案編號 */
pjbol002       varchar2(30)      ,/* 本階WBS */
pjbol900       number(10,0)      ,/* 變更序 */
pjbol003       varchar2(6)      ,/* 語言別 */
pjbol004       varchar2(500)      ,/* 說明 */
pjbol005       varchar2(10)      ,/* 助記碼 */
pjbol901       varchar2(1)      /* 變更類型 */
);
alter table pjbol_t add constraint pjbol_pk primary key (pjbolent,pjbol001,pjbol002,pjbol900,pjbol003) enable validate;

create unique index pjbol_pk on pjbol_t (pjbolent,pjbol001,pjbol002,pjbol900,pjbol003);

grant select on pjbol_t to tiptop;
grant update on pjbol_t to tiptop;
grant delete on pjbol_t to tiptop;
grant insert on pjbol_t to tiptop;

exit;
