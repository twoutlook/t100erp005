/* 
================================================================================
檔案代號:stjg_t
檔案名稱:招商租賃合約分段扣率單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stjg_t
(
stjgent       number(5)      ,/* 企业代码 */
stjgsite       varchar2(10)      ,/* 营运组织 */
stjgunit       varchar2(10)      ,/* 制定組織 */
stjgseq       number(10,0)      ,/* 項次 */
stjgseq1       number(10,0)      ,/* 項次1 */
stjg001       varchar2(20)      ,/* 合約編號 */
stjg002       number(20,6)      ,/* 起始金額 */
stjg003       number(20,6)      ,/* 截止金額 */
stjg004       number(20,6)      ,/* 固定/單位金額 */
stjg005       number(20,6)      ,/* 比例 */
stjg006       number(20,6)      ,/* 確認金額 */
stjg007       number(20,6)      /* 確認比例 */
);
alter table stjg_t add constraint stjg_pk primary key (stjgent,stjgseq,stjgseq1,stjg001) enable validate;

create unique index stjg_pk on stjg_t (stjgent,stjgseq,stjgseq1,stjg001);

grant select on stjg_t to tiptop;
grant update on stjg_t to tiptop;
grant delete on stjg_t to tiptop;
grant insert on stjg_t to tiptop;

exit;
