/* 
================================================================================
檔案代號:nmbq_t
檔案名稱:內部資金還款主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table nmbq_t
(
nmbqent       number(5)      ,/* 企業編碼 */
nmbqdocno       varchar2(20)      ,/* 還款單號 */
nmbqdocdt       date      ,/* 還款日期 */
nmbq001       varchar2(10)      ,/* 資金中心 */
nmbqstus       varchar2(1)      /* 有效碼 */
);
alter table nmbq_t add constraint nmbq_pk primary key (nmbqent,nmbqdocno) enable validate;

create unique index nmbq_pk on nmbq_t (nmbqent,nmbqdocno);

grant select on nmbq_t to tiptop;
grant update on nmbq_t to tiptop;
grant delete on nmbq_t to tiptop;
grant insert on nmbq_t to tiptop;

exit;
