/* 
================================================================================
檔案代號:pmew_t
檔案名稱:採購折扣結算對象檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmew_t
(
pmewent       number(5)      ,/* 企業編號 */
pmewsite       varchar2(10)      ,/* 營運據點 */
pmewdocno       varchar2(20)      ,/* 合約單號 */
pmewseq       number(10,0)      ,/* 項次 */
pmew001       varchar2(10)      /* 供應商編號 */
);
alter table pmew_t add constraint pmew_pk primary key (pmewent,pmewdocno,pmewseq) enable validate;

create unique index pmew_pk on pmew_t (pmewent,pmewdocno,pmewseq);

grant select on pmew_t to tiptop;
grant update on pmew_t to tiptop;
grant delete on pmew_t to tiptop;
grant insert on pmew_t to tiptop;

exit;
