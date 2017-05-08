/* 
================================================================================
檔案代號:debq_t
檔案名稱:門店款別統計日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table debq_t
(
debqent       number(5)      ,/* 企業編號 */
debqsite       varchar2(10)      ,/* 營運據點 */
debq001       varchar2(10)      ,/* 層級類型 */
debq002       date      ,/* 統計日期 */
debq003       number(5,0)      ,/* 會計週 */
debq004       number(5,0)      ,/* 會計期 */
debq005       varchar2(10)      ,/* 款別編號 */
debq006       varchar2(10)      ,/* 款別類型 */
debq007       number(20,6)      /* 實收金額 */
);
alter table debq_t add constraint debq_pk primary key (debqent,debqsite,debq002,debq005) enable validate;

create unique index debq_pk on debq_t (debqent,debqsite,debq002,debq005);

grant select on debq_t to tiptop;
grant update on debq_t to tiptop;
grant delete on debq_t to tiptop;
grant insert on debq_t to tiptop;

exit;
