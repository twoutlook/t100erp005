/* 
================================================================================
檔案代號:bgcal_t
檔案名稱:銷售模擬因子主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bgcal_t
(
bgcalent       number(5)      ,/* 企業編號 */
bgcal001       varchar2(10)      ,/* 影響因子編號 */
bgcal002       varchar2(6)      ,/* 語言別 */
bgcal003       varchar2(500)      ,/* 說明 */
bgcal004       varchar2(10)      /* 助記碼 */
);
alter table bgcal_t add constraint bgcal_pk primary key (bgcalent,bgcal001,bgcal002) enable validate;

create unique index bgcal_pk on bgcal_t (bgcalent,bgcal001,bgcal002);

grant select on bgcal_t to tiptop;
grant update on bgcal_t to tiptop;
grant delete on bgcal_t to tiptop;
grant insert on bgcal_t to tiptop;

exit;
