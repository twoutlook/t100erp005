/* 
================================================================================
檔案代號:stgc_t
檔案名稱:專櫃每日退貨統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table stgc_t
(
stgcent       number(5)      ,/* 企業編號 */
stgcsite       varchar2(10)      ,/* 營運組織 */
stgcunit       varchar2(10)      ,/* 應用組織 */
stgc001       date      ,/* 銷退日期 */
stgc002       varchar2(40)      ,/* 商品編號 */
stgc003       varchar2(10)      ,/* 庫區編號 */
stgc004       varchar2(10)      ,/* 專櫃編號 */
stgc005       varchar2(10)      ,/* 供應商編號 */
stgc006       varchar2(10)      ,/* 費用編號 */
stgc007       number(20,6)      ,/* 銷退金額 */
stgc008       number(20,6)      ,/* 原扣率 */
stgc009       number(20,6)      ,/* 新扣率 */
stgc010       number(20,6)      ,/* 銷退費用金額 */
stgc011       number(20,6)      ,/* 銷退成本金額 */
stgc012       date      ,/* 原銷售日期 */
stgc013       varchar2(10)      ,/* 價款類型 */
stgc014       varchar2(1)      ,/* 已結轉否 */
stgcdocno       varchar2(20)      ,/* 銷退單號 */
stgcseq       number(10,0)      /* 項次 */
);
alter table stgc_t add constraint stgc_pk primary key (stgcent,stgcdocno,stgcseq) enable validate;

create unique index stgc_pk on stgc_t (stgcent,stgcdocno,stgcseq);

grant select on stgc_t to tiptop;
grant update on stgc_t to tiptop;
grant delete on stgc_t to tiptop;
grant insert on stgc_t to tiptop;

exit;
