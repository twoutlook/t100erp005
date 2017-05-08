/* 
================================================================================
檔案代號:rtell_t
檔案名稱:商戶商品引進單身檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table rtell_t
(
rtellent       number(5)      ,/* 企業編號 */
rtelldocno       varchar2(20)      ,/* 單據編號 */
rtellseq       number(10,0)      ,/* 項次 */
rtell001       varchar2(6)      ,/* 語言別 */
rtell002       varchar2(500)      ,/* 品名 */
rtell003       varchar2(255)      ,/* 規格 */
rtell004       varchar2(10)      /* 助記碼 */
);
alter table rtell_t add constraint rtell_pk primary key (rtellent,rtelldocno,rtellseq,rtell001) enable validate;

create unique index rtell_pk on rtell_t (rtellent,rtelldocno,rtellseq,rtell001);

grant select on rtell_t to tiptop;
grant update on rtell_t to tiptop;
grant delete on rtell_t to tiptop;
grant insert on rtell_t to tiptop;

exit;
