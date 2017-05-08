/* 
================================================================================
檔案代號:stjk_t
檔案名稱:招商租賃合約品類品牌單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stjk_t
(
stjkent       number(5)      ,/* 企業編號 */
stjksite       varchar2(10)      ,/* 營運組織 */
stjkunit       varchar2(10)      ,/* 制定組織 */
stjkseq       number(10,0)      ,/* 項次 */
stjkacti       varchar2(1)      ,/* 有效否 */
stjk001       varchar2(20)      ,/* 合約編號 */
stjk002       varchar2(10)      ,/* 品類編號 */
stjk003       varchar2(10)      ,/* 品牌編號 */
stjk004       varchar2(1)      ,/* 主品類 */
stjk005       varchar2(1)      /* 主品牌 */
);
alter table stjk_t add constraint stjk_pk primary key (stjkent,stjkseq,stjk001) enable validate;

create unique index stjk_pk on stjk_t (stjkent,stjkseq,stjk001);

grant select on stjk_t to tiptop;
grant update on stjk_t to tiptop;
grant delete on stjk_t to tiptop;
grant insert on stjk_t to tiptop;

exit;
