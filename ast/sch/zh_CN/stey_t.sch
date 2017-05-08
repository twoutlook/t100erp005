/* 
================================================================================
檔案代號:stey_t
檔案名稱:專櫃對應供應商明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stey_t
(
steyent       number(5)      ,/* 企業代碼 */
steyunit       varchar2(10)      ,/* 應用執行組織物件 */
steysite       varchar2(10)      ,/* 營運據點 */
stey001       varchar2(10)      ,/* 專櫃編號 */
stey002       varchar2(10)      ,/* 供應商編號 */
stey003       date      /* 執行日期 */
);
alter table stey_t add constraint stey_pk primary key (steyent,stey001,stey002,stey003) enable validate;

create unique index stey_pk on stey_t (steyent,stey001,stey002,stey003);

grant select on stey_t to tiptop;
grant update on stey_t to tiptop;
grant delete on stey_t to tiptop;
grant insert on stey_t to tiptop;

exit;
