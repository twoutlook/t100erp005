/* 
================================================================================
檔案代號:pscal_t
檔案名稱:APS版本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table pscal_t
(
pscalent       number(5)      ,/* 企業編號 */
pscalsite       varchar2(10)      ,/* 營運據點 */
pscal001       varchar2(10)      ,/* APS編號 */
pscal002       varchar2(6)      ,/* 語言別 */
pscal003       varchar2(500)      ,/* 說明 */
pscal004       varchar2(10)      /* 助記碼 */
);
alter table pscal_t add constraint pscal_pk primary key (pscalent,pscalsite,pscal001,pscal002) enable validate;

create unique index pscal_pk on pscal_t (pscalent,pscalsite,pscal001,pscal002);

grant select on pscal_t to tiptop;
grant update on pscal_t to tiptop;
grant delete on pscal_t to tiptop;
grant insert on pscal_t to tiptop;

exit;
