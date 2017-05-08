/* 
================================================================================
檔案代號:prek_t
檔案名稱:換贈來源明細
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prek_t
(
prekent       number(5)      ,/* 企業編號 */
prekunit       varchar2(10)      ,/* 應用組織 */
preksite       varchar2(10)      ,/* 營運據點 */
prekdocno       varchar2(20)      ,/* 單號 */
prekseq       number(10,0)      ,/* 項次 */
prek001       date      ,/* 交易日期 */
prek002       varchar2(20)      ,/* 收銀小票 */
prek003       varchar2(20)      ,/* 銷售單號 */
prek004       number(20,6)      ,/* 銷售金額 */
prek005       number(20,6)      /* 交款金額 */
);
alter table prek_t add constraint prek_pk primary key (prekent,prekdocno,prekseq) enable validate;

create unique index prek_pk on prek_t (prekent,prekdocno,prekseq);

grant select on prek_t to tiptop;
grant update on prek_t to tiptop;
grant delete on prek_t to tiptop;
grant insert on prek_t to tiptop;

exit;
