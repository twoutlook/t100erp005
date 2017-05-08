/* 
================================================================================
檔案代號:prej_t
檔案名稱:促銷談判結果保底費用明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table prej_t
(
prejent       number(5)      ,/* 企業編號 */
prejunit       varchar2(10)      ,/* 應用組織 */
prejsite       varchar2(10)      ,/* 營運據點 */
prejseq       number(10,0)      ,/* 保底項次 */
prejacti       varchar2(1)      ,/* 有效否 */
prejseq1       number(10,0)      ,/* 條件項次 */
prej001       varchar2(20)      ,/* 規則編號 */
prej002       varchar2(10)      ,/* 庫區編號 */
prej003       varchar2(10)      ,/* 專櫃編號 */
prej004       varchar2(10)      ,/* 類型 */
prej005       number(20,6)      ,/* 截止金額 */
prej006       number(20,6)      ,/* 起始金額 */
prej007       number(20,6)      /* 執行扣率 */
);
alter table prej_t add constraint prej_pk primary key (prejent,prejseq,prejseq1,prej001) enable validate;

create unique index prej_pk on prej_t (prejent,prejseq,prejseq1,prej001);

grant select on prej_t to tiptop;
grant update on prej_t to tiptop;
grant delete on prej_t to tiptop;
grant insert on prej_t to tiptop;

exit;
