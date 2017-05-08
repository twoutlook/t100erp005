/* 
================================================================================
檔案代號:indq_t
檔案名稱:商品實際庫存調整明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table indq_t
(
indqent       number(5)      ,/* 企業編號 */
indqsite       varchar2(10)      ,/* 營運組織 */
indqunit       varchar2(10)      ,/* 應用組織 */
indqdocno       varchar2(20)      ,/* 單據編號 */
indqseq       number(10,0)      ,/* 項次 */
indq001       varchar2(40)      ,/* 商品編碼 */
indq002       varchar2(40)      ,/* 商品條碼 */
indq003       varchar2(256)      ,/* 商品特征 */
indq004       varchar2(10)      ,/* 庫區編號 */
indq005       varchar2(10)      ,/* 儲位編號 */
indq006       varchar2(30)      ,/* 批號 */
indq007       varchar2(10)      ,/* 庫存單位 */
indq008       number(20,6)      ,/* 庫存數量 */
indq009       number(20,6)      ,/* 核准數量 */
indq010       number(20,6)      ,/* 成本單價 */
indq011       number(20,6)      ,/* 銷售單價 */
indq012       varchar2(10)      /* 理由碼 */
);
alter table indq_t add constraint indq_pk primary key (indqent,indqdocno,indqseq) enable validate;

create unique index indq_pk on indq_t (indqent,indqdocno,indqseq);

grant select on indq_t to tiptop;
grant update on indq_t to tiptop;
grant delete on indq_t to tiptop;
grant insert on indq_t to tiptop;

exit;
