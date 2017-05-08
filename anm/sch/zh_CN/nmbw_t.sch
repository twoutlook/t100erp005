/* 
================================================================================
檔案代號:nmbw_t
檔案名稱:內部資金還款單據明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmbw_t
(
nmbwent       number(5)      ,/* 企業編碼 */
nmbwdocno       varchar2(20)      ,/* 還款單號 */
nmbwseq       number(10,0)      ,/* 序號 */
nmbw001       varchar2(10)      ,/* 內部交易性質 */
nmbw002       varchar2(20)      ,/* 調度單號 */
nmbw003       number(10,0)      ,/* 調度單序號 */
nmbw004       varchar2(10)      ,/* 還款組織 */
nmbw005       varchar2(10)      ,/* 幣別 */
nmbw006       number(20,6)      ,/* 還款金額 */
nmbw007       number(20,6)      /* 已還金額 */
);
alter table nmbw_t add constraint nmbw_pk primary key (nmbwent,nmbwdocno,nmbwseq) enable validate;

create unique index nmbw_pk on nmbw_t (nmbwent,nmbwdocno,nmbwseq);

grant select on nmbw_t to tiptop;
grant update on nmbw_t to tiptop;
grant delete on nmbw_t to tiptop;
grant insert on nmbw_t to tiptop;

exit;
