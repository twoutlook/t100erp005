/* 
================================================================================
檔案代號:stbj_t
檔案名稱:自營合約補充條款明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stbj_t
(
stbjent       number(5)      ,/* 企業代碼 */
stbjsite       varchar2(10)      ,/* 營運據點 */
stbjunit       varchar2(10)      ,/* 應用執行組織物件 */
stbjdocno       varchar2(20)      ,/* 單號 */
stbjseq       number(10,0)      ,/* 項次 */
stbj001       varchar2(500)      /* 補充條款 */
);
alter table stbj_t add constraint stbj_pk primary key (stbjent,stbjdocno,stbjseq) enable validate;

create unique index stbj_pk on stbj_t (stbjent,stbjdocno,stbjseq);

grant select on stbj_t to tiptop;
grant update on stbj_t to tiptop;
grant delete on stbj_t to tiptop;
grant insert on stbj_t to tiptop;

exit;
