/* 
================================================================================
檔案代號:pmey_t
檔案名稱:採購折扣合約分段計價檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmey_t
(
pmeyent       number(5)      ,/* 企業編號 */
pmeysite       varchar2(10)      ,/* 營運據點 */
pmeydocno       varchar2(20)      ,/* 合約單號 */
pmeyseq       number(10,0)      ,/* 項次 */
pmey001       number(20,6)      ,/* 起始數量/金額 */
pmey002       number(20,6)      ,/* 截止數量/金額 */
pmey003       number(20,6)      ,/* 折扣單價 */
pmey004       number(20,6)      /* 折扣率 */
);
alter table pmey_t add constraint pmey_pk primary key (pmeyent,pmeydocno,pmeyseq,pmey001,pmey002) enable validate;

create unique index pmey_pk on pmey_t (pmeyent,pmeydocno,pmeyseq,pmey001,pmey002);

grant select on pmey_t to tiptop;
grant update on pmey_t to tiptop;
grant delete on pmey_t to tiptop;
grant insert on pmey_t to tiptop;

exit;
