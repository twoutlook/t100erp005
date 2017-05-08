/* 
================================================================================
檔案代號:steal_t
檔案名稱:專櫃合同申请主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table steal_t
(
stealent       number(5)      ,/* 企業編號 */
stealdocno       varchar2(20)      ,/* 單據編號 */
steal001       varchar2(6)      ,/* 語言別 */
steal002       varchar2(500)      ,/* 專櫃簡稱 */
steal003       varchar2(500)      ,/* 專櫃全稱 */
steal004       varchar2(10)      /* 助記碼 */
);
alter table steal_t add constraint steal_pk primary key (stealent,stealdocno,steal001) enable validate;

create unique index steal_pk on steal_t (stealent,stealdocno,steal001);

grant select on steal_t to tiptop;
grant update on steal_t to tiptop;
grant delete on steal_t to tiptop;
grant insert on steal_t to tiptop;

exit;
