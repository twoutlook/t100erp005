/* 
================================================================================
檔案代號:stjn_t
檔案名稱:招商租賃合約日核算單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stjn_t
(
stjnent       number(5)      ,/* 企業編號 */
stjnsite       varchar2(10)      ,/* 營運組織 */
stjnunit       varchar2(10)      ,/* 制定組織 */
stjnseq       number(10,0)      ,/* 項次 */
stjn001       varchar2(20)      ,/* 合約編號 */
stjn002       date      ,/* 分攤日期 */
stjn003       varchar2(10)      ,/* 優惠類型 */
stjn004       varchar2(10)      ,/* 資料類型 */
stjn005       varchar2(10)      ,/* 費用編號 */
stjn006       number(20,6)      ,/* 费用金额 */
stjn007       varchar2(20)      ,/* 參考單號 */
stjn008       varchar2(10)      ,/* 參考單號版本 */
stjn009       varchar2(10)      ,/* 合約版本 */
stjn010       number(10,0)      /* 合約費用項次 */
);
alter table stjn_t add constraint stjn_pk primary key (stjnent,stjnseq,stjn001) enable validate;

create unique index stjn_pk on stjn_t (stjnent,stjnseq,stjn001);

grant select on stjn_t to tiptop;
grant update on stjn_t to tiptop;
grant delete on stjn_t to tiptop;
grant insert on stjn_t to tiptop;

exit;
