/* 
================================================================================
檔案代號:dedp_t
檔案名稱:門店款別統計月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dedp_t
(
dedpent       number(5)      ,/* 企業代碼 */
dedpsite       varchar2(10)      ,/* 營運據點 */
dedp001       varchar2(10)      ,/* 層級類型 */
dedp005       varchar2(10)      ,/* 款別編號 */
dedp006       varchar2(10)      ,/* 款別類型 */
dedp007       number(20,6)      ,/* 實收金額 */
dedp008       number(5,0)      ,/* 統計年度 */
dedp009       number(5,0)      /* 統計月份 */
);
alter table dedp_t add constraint dedp_pk primary key (dedpent,dedpsite,dedp005,dedp008,dedp009) enable validate;

create unique index dedp_pk on dedp_t (dedpent,dedpsite,dedp005,dedp008,dedp009);

grant select on dedp_t to tiptop;
grant update on dedp_t to tiptop;
grant delete on dedp_t to tiptop;
grant insert on dedp_t to tiptop;

exit;
