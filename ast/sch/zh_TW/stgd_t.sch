/* 
================================================================================
檔案代號:stgd_t
檔案名稱:專櫃每日收款小票明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table stgd_t
(
stgdent       number(5)      ,/* 企業編號 */
stgdsite       varchar2(10)      ,/* 營運組織 */
stgdunit       varchar2(10)      ,/* 應用組織 */
stgd001       varchar2(40)      ,/* 收款序號 */
stgd002       date      ,/* 銷售日期 */
stgd003       varchar2(40)      ,/* 商品編號 */
stgd004       varchar2(10)      ,/* 庫區編號 */
stgd005       varchar2(10)      ,/* 專櫃編號 */
stgd006       varchar2(10)      ,/* 供應商編號 */
stgd007       varchar2(40)      ,/* 銷售收銀單號 */
stgd008       varchar2(10)      ,/* 收銀大類 */
stgd009       varchar2(10)      ,/* 收銀小類 */
stgd010       varchar2(1)      ,/* 收銀分攤否 */
stgd011       number(20,6)      ,/* 小票實收金額 */
stgd012       number(20,6)      ,/* 小票明細實收金額 */
stgdseq       number(10,0)      /* 銷售單項次 */
);
alter table stgd_t add constraint stgd_pk primary key (stgdent,stgdsite,stgd001,stgd007,stgdseq) enable validate;

create unique index stgd_pk on stgd_t (stgdent,stgdsite,stgd001,stgd007,stgdseq);

grant select on stgd_t to tiptop;
grant update on stgd_t to tiptop;
grant delete on stgd_t to tiptop;
grant insert on stgd_t to tiptop;

exit;
