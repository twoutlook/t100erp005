/* 
================================================================================
檔案代號:decp_t
檔案名稱:門店部門款別統計週結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table decp_t
(
decpent       number(5)      ,/* 企業代碼 */
decpsite       varchar2(10)      ,/* 營運據點 */
decp001       varchar2(10)      ,/* 層級類型 */
decp005       varchar2(10)      ,/* 部門編號 */
decp006       varchar2(10)      ,/* 款別編號 */
decp007       varchar2(10)      ,/* 款別分類 */
decp008       number(20,6)      ,/* 實收金額 */
decp009       number(10,0)      ,/* 統計年度月份 */
decp010       number(5,0)      /* 統計週期 */
);
alter table decp_t add constraint decp_pk primary key (decpent,decpsite,decp005,decp006,decp009,decp010) enable validate;

create unique index decp_pk on decp_t (decpent,decpsite,decp005,decp006,decp009,decp010);

grant select on decp_t to tiptop;
grant update on decp_t to tiptop;
grant delete on decp_t to tiptop;
grant insert on decp_t to tiptop;

exit;
