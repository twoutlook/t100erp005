/* 
================================================================================
檔案代號:rtdj_t
檔案名稱:供應商清場清退組織範圍表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtdj_t
(
rtdjent       number(5)      ,/* 企業編號 */
rtdjsite       varchar2(10)      ,/* 營運據點 */
rtdjunit       varchar2(10)      ,/* 應用組織 */
rtdjdocno       varchar2(20)      ,/* 單據編號 */
rtdjseq       number(10,0)      ,/* 項次 */
rtdj001       varchar2(10)      /* 組織編號 */
);
alter table rtdj_t add constraint rtdj_pk primary key (rtdjent,rtdjdocno,rtdjseq) enable validate;

create unique index rtdj_pk on rtdj_t (rtdjent,rtdjdocno,rtdjseq);

grant select on rtdj_t to tiptop;
grant update on rtdj_t to tiptop;
grant delete on rtdj_t to tiptop;
grant insert on rtdj_t to tiptop;

exit;
