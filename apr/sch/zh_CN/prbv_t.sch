/* 
================================================================================
檔案代號:prbv_t
檔案名稱:調價單生效門店資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prbv_t
(
prbvent       number(5)      ,/* 企業代碼 */
prbvunit       varchar2(10)      ,/* 應用執行組織物件 */
prbvsite       varchar2(10)      ,/* 營運據點 */
prbvdocno       varchar2(20)      ,/* 單號 */
prbv001       varchar2(10)      ,/* 生效營運組織 */
prbvstus       varchar2(10)      /* 狀態碼 */
);
alter table prbv_t add constraint prbv_pk primary key (prbvent,prbvdocno,prbv001) enable validate;

create unique index prbv_pk on prbv_t (prbvent,prbvdocno,prbv001);

grant select on prbv_t to tiptop;
grant update on prbv_t to tiptop;
grant delete on prbv_t to tiptop;
grant insert on prbv_t to tiptop;

exit;
