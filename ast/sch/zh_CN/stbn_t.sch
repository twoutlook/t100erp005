/* 
================================================================================
檔案代號:stbn_t
檔案名稱:合同申請簽約門店表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stbn_t
(
stbnent       number(5)      ,/* 企業代碼 */
stbnsite       varchar2(10)      ,/* 營運據點 */
stbnunit       varchar2(10)      ,/* 應用執行組織物件 */
stbndocno       varchar2(20)      ,/* 單號 */
stbnseq       number(10,0)      ,/* 項次 */
stbn001       varchar2(10)      ,/* 門店 */
stbnacti       varchar2(1)      /* 有效 */
);
alter table stbn_t add constraint stbn_pk primary key (stbnent,stbndocno,stbnseq) enable validate;

create unique index stbn_pk on stbn_t (stbnent,stbndocno,stbnseq);

grant select on stbn_t to tiptop;
grant update on stbn_t to tiptop;
grant delete on stbn_t to tiptop;
grant insert on stbn_t to tiptop;

exit;
