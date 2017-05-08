/* 
================================================================================
檔案代號:step_t
檔案名稱:合約費用優惠商戶合作情況明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table step_t
(
stepent       number(5)      ,/* 企業編號 */
stepunit       varchar2(10)      ,/* 制定組織 */
stepsite       varchar2(10)      ,/* 營運據點 */
stepacti       varchar2(10)      ,/* 狀態 */
stepdocno       varchar2(20)      ,/* 審批單號 */
stepseq       number(10,0)      ,/* 項次 */
step001       varchar2(10)      ,/* 門店編號 */
step002       varchar2(10)      ,/* 專櫃編號 */
step003       varchar2(10)      ,/* 門牌號 */
step004       date      ,/* 租賃開始日期 */
step005       date      ,/* 租賃結束日期 */
step006       number(15,3)      ,/* 經營面積 */
step007       varchar2(10)      ,/* 經營小類 */
step008       varchar2(20)      /* 合同編號 */
);
alter table step_t add constraint step_pk primary key (stepent,stepdocno,stepseq) enable validate;

create unique index step_pk on step_t (stepent,stepdocno,stepseq);

grant select on step_t to tiptop;
grant update on step_t to tiptop;
grant delete on step_t to tiptop;
grant insert on step_t to tiptop;

exit;
