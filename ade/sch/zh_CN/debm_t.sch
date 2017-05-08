/* 
================================================================================
檔案代號:debm_t
檔案名稱:門店部門款別統計日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table debm_t
(
debment       number(5)      ,/* 企業編號 */
debmsite       varchar2(10)      ,/* 營運據點 */
debm001       varchar2(10)      ,/* 層級類型 */
debm002       date      ,/* 統計日期 */
debm003       number(5,0)      ,/* 會計週 */
debm004       number(5,0)      ,/* 會計期 */
debm005       varchar2(10)      ,/* 部門編號 */
debm006       varchar2(10)      ,/* 款別編號 */
debm007       varchar2(10)      ,/* 款別分類 */
debm008       number(20,6)      /* 實收金額 */
);
alter table debm_t add constraint debm_pk primary key (debment,debmsite,debm002,debm005,debm006) enable validate;

create unique index debm_pk on debm_t (debment,debmsite,debm002,debm005,debm006);

grant select on debm_t to tiptop;
grant update on debm_t to tiptop;
grant delete on debm_t to tiptop;
grant insert on debm_t to tiptop;

exit;
