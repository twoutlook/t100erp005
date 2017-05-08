/* 
================================================================================
檔案代號:prcbl_t
檔案名稱:促銷活動計劃申請多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table prcbl_t
(
prcblent       number(5)      ,/* 企業編號 */
prcbldocno       varchar2(20)      ,/* 申請單號 */
prcblseq       number(10,0)      ,/* 項次 */
prcbl001       varchar2(6)      ,/* 語言別 */
prcbl002       varchar2(500)      ,/* 說明 */
prcbl003       varchar2(10)      /* 助記碼 */
);
alter table prcbl_t add constraint prcbl_pk primary key (prcblent,prcbldocno,prcblseq,prcbl001) enable validate;

create unique index prcbl_pk on prcbl_t (prcblent,prcbldocno,prcblseq,prcbl001);

grant select on prcbl_t to tiptop;
grant update on prcbl_t to tiptop;
grant delete on prcbl_t to tiptop;
grant insert on prcbl_t to tiptop;

exit;
