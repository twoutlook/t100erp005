/* 
================================================================================
檔案代號:decs_t
檔案名稱:門店款別統計週結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table decs_t
(
decsent       number(5)      ,/* 企業代碼 */
decssite       varchar2(10)      ,/* 營運據點 */
decs001       varchar2(10)      ,/* 層級類型 */
decs005       varchar2(10)      ,/* 款別編號 */
decs006       varchar2(10)      ,/* 款別類型 */
decs007       number(20,6)      ,/* 實收金額 */
decs008       number(10,0)      ,/* 統計年度月份 */
decs009       number(5,0)      /* 統計週期 */
);
alter table decs_t add constraint decs_pk primary key (decsent,decssite,decs005,decs008,decs009) enable validate;

create unique index decs_pk on decs_t (decsent,decssite,decs005,decs008,decs009);

grant select on decs_t to tiptop;
grant update on decs_t to tiptop;
grant delete on decs_t to tiptop;
grant insert on decs_t to tiptop;

exit;
