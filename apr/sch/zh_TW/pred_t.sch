/* 
================================================================================
檔案代號:pred_t
檔案名稱:促銷談判條件保底費用明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pred_t
(
predent       number(5)      ,/* 企業編號 */
predunit       varchar2(10)      ,/* 應用組織 */
preddocno       varchar2(20)      ,/* 單據編號 */
predsite       varchar2(10)      ,/* 營運據點 */
predacti       varchar2(1)      ,/* 有效 */
predseq       number(10,0)      ,/* 保底項次 */
predseq1       number(10,0)      ,/* 條件項次 */
pred001       varchar2(20)      ,/* 規則編號 */
pred002       varchar2(10)      ,/* 庫區編號 */
pred003       varchar2(10)      ,/* 專櫃編號 */
pred004       varchar2(10)      ,/* 類型 */
pred005       number(20,6)      ,/* 截止金額 */
pred006       number(20,6)      ,/* 起始金額 */
pred007       number(20,6)      /* 執行扣率 */
);
alter table pred_t add constraint pred_pk primary key (predent,preddocno,predseq,predseq1) enable validate;

create unique index pred_pk on pred_t (predent,preddocno,predseq,predseq1);

grant select on pred_t to tiptop;
grant update on pred_t to tiptop;
grant delete on pred_t to tiptop;
grant insert on pred_t to tiptop;

exit;
